rule iApp_YGS_Detection_Normal {
    meta:
        author = "Apich Organization Security Team"
        description = "Normal consolidated rule for iApp-based YGS family malware. Detects native slky/asendn logic, spaced package names, script artifacts, and specific cryptographic keys."
        date = "2026-01-22"
        version = "1.0"
        severity = "Critical"

    strings:
        /* --- Behavioral & Heuristic Patterns --- */
        // Matches CJK characters followed by a space (Example: 戸 籍 开 道 助 手)
        $spaced_pkg = /([\x4e00-\x9fff]\x20){3,}/

        /* --- Native Library Artifacts --- */
        $lib_so = "libygsiyu.so" ascii fullword
        $asset_so = "assets/lib.so" ascii
        $fn_slky = "slky" ascii
        $fn_asendn = "asendn" ascii

        // The 21-byte static XOR sequence (__s_00)
        $xor_21b_1 = { E2 48 25 E7 80 46 E3 3C }
        $xor_21b_2 = { 3C 1E 25 1D 4E 05 55 E1 }

        /* --- iApp Script & Asset Artifacts --- */
        $s1 = "main.iyu" ascii fullword
        $s2 = "gx.mp3" ascii fullword
        $s3 = "lengtong" ascii
        $s4 = "yecian" ascii
        $s5 = "rc4" wide ascii nocase

        /* --- Cryptographic Binary Seeds --- */
        $k1 = { 32 E7 B3 5A DA 13 BE A8 }
        $k2 = { 41 B1 D0 B9 84 BD 88 0A }
        $k3 = { 50 10 93 F2 84 11 FE 62 }
        $k4 = { 54 D7 23 0A 2C BD 29 95 }

    condition:
        // Case 1-A: ELF file with known native malicious logic
        (uint32(0) == 0x464c457f and (1 of $xor_21b_* or ($fn_slky and $fn_asendn))) or

        // Case 1-B: ELF file with known native malicious logic
        (2 of $xor_21b_* or ($fn_slky and $fn_asendn)) or

        // Case 2-A: APK structure with spaced package name and script artifacts
        ($spaced_pkg and 1 of ($s*)) or

        // Case 2-B: APK structure with spaced package name and the specific binary keys
        ($spaced_pkg and 1 of ($k*)) or

        // Case 2-C: APK structure with spaced package name and the specific binary XOR keys
        ($spaced_pkg and 1 of ($xor_21b_*)) or

        // Case 3-A: Presence of the 'lib.so' asset coupled with the specific binary keys
        ($asset_so and 1 of ($k*)) or

        // Case 3-B: Presence of the 'lib.so' asset coupled with the specific binary XOR keys
        ($asset_so and 1 of ($xor_21b_*)) or

        // Case 3-C: Presence of the 'lib.so' asset coupled with the specific script artifacts
        ($asset_so and 1 of ($s*)) or

        // Case 4: Strong attribution via key fingerprints alone (2 or more keys present)
        (2 of ($k*)) or

        // Case 5-A: Direct filename match for known iApp kit
        ($lib_so and 1 of $xor_21b_*) or

        // Case 5-B: Direct filename match for known iApp ki
        ($lib_so and 1 of $k*) or

        // Case 6: Strong attribution via XOR key fingerprints alone (2 or more XOR keys present)
        (2 of ($xor_21b_*))
}
