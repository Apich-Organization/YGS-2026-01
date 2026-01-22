rule iApp_YGS_Detection_Enhanced {
    meta:
        author = "Apich Organization Security Team"
        description = "Enhanced consolidated rule for iApp-based YGS family malware. Detects native slky/asendn logic, spaced package names, script artifacts, and specific cryptographic keys."
        date = "2026-01-22"
        version = "1.0"
        severity = "Critical"

    strings:
        /* --- Behavioral & Heuristic Patterns --- */
        $spaced_pkg = /.\s+(.\s+)*./

        /* --- Native Library Artifacts --- */
        $lib_so = "ygsiyu" wide ascii nocase
        $asset_so = "assets/lib" wide ascii nocase
        $fn_slky = "slky" wide ascii nocase
        $fn_asendn = "asendn" wide ascii nocase

        // The 21-byte static XOR sequence (__s_00)
        $xor_21b_1 = { E2 48 25 E7 80 46 E3 3C }
        $xor_21b_2 = { 3C 1E 25 1D 4E 05 55 E1 }

        /* --- iApp Script & Asset Artifacts --- */
        $s1 = "main" wide ascii nocase
        $s2 = "gx" wide ascii nocase
        $s3 = "lengtong" wide ascii nocase
        $s4 = "yecian" wide ascii nocase
        $s5 = "rc4" wide ascii nocase

        /* --- Cryptographic Binary Seeds --- */
        $k1 = { 32 E7 B3 5A DA 13 BE A8 }
        $k2 = { 41 B1 D0 B9 84 BD 88 0A }
        $k3 = { 50 10 93 F2 84 11 FE 62 }
        $k4 = { 54 D7 23 0A 2C BD 29 95 }

    condition:
        // Case 1: Files with known native malicious logic strings
        ($fn_slky and $fn_asendn) or

        // Case 2: APK structure with spaced package name
        ($spaced_pkg) or

        // Case 3: Presence of the 'lib.so' asset
        ($asset_so) or

        // Case 4: Strong attribution via key fingerprints alone
        (1 of ($k*)) or

        // Case 5: Direct filename match for known iApp kit
        ($lib_so) or

        // Case 6: Strong attribution via XOR key fingerprints alone (2 or more XOR keys present)
        (1 of ($xor_21b_*)) or

        // Case 7: Direct assets filename match for known iApp kit
        (1 of $s*)
}
