Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F142072DE2D
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 11:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241349AbjFMJrO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 05:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241560AbjFMJrC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 05:47:02 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66895CE;
        Tue, 13 Jun 2023 02:46:36 -0700 (PDT)
Received: from tp8.. (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B5F755BF;
        Tue, 13 Jun 2023 09:46:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B5F755BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1686649586; bh=dWpoeAXMJ/celJyNlHg+oUI0iRRMPpCQdfgVvBB7a8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L/Y20rYEgtSIsvR1c6iXgLgDQIkA3qUoKYVjLduUFOF3535eDlpUut7Vzp6h2UpOQ
         lxtPL/PUQnOVY/AiwtZFaLEY+BZ9K13Sd8xvwCXA15KwCdz4F/6lEytPKBfiRLSGG+
         R7KUeVAuUA04ZGounbjz2cQgEn/cVFy8i6MRoZ2qEtVthLiVHmyLGtmTOGLGDnXCXy
         veS3KndFFO9zfddDlcuOH9UpVMYce13mblGLbh9gjJhslXo7T8wbCEvhyKkUqJDPxm
         +24hmeA2Pn01xWJ9RB5d+8qrFErxvZWPipctrA1WMKVAjd6ttuQ+lAIfxYcOj5LNf/
         EELEP9Y+9fWAw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/5] docs: arm64: Move arm64 documentation under Documentation/arch/
Date:   Tue, 13 Jun 2023 03:46:02 -0600
Message-Id: <20230613094606.334687-2-corbet@lwn.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613094606.334687-1-corbet@lwn.net>
References: <20230613094606.334687-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Architecture-specific documentation is being moved into Documentation/arch/
as a way of cleaning up the top-level documentation directory and making
the docs hierarchy more closely match the source hierarchy.  Move
Documentation/arm64 into arch/ (along with the Chinese equvalent
translations) and fix up documentation references.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Alex Shi <alexs@kernel.org>
Cc: Yanteng Si <siyanteng@loongson.cn>
Cc: Hu Haowen <src.res@email.cn>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu   |  2 +-
 Documentation/admin-guide/kernel-parameters.txt      |  2 +-
 Documentation/admin-guide/sysctl/kernel.rst          |  2 +-
 Documentation/{ => arch}/arm64/acpi_object_usage.rst |  0
 Documentation/{ => arch}/arm64/amu.rst               |  0
 Documentation/{ => arch}/arm64/arm-acpi.rst          |  2 +-
 Documentation/{ => arch}/arm64/asymmetric-32bit.rst  |  0
 Documentation/{ => arch}/arm64/booting.rst           |  0
 .../{ => arch}/arm64/cpu-feature-registers.rst       |  0
 Documentation/{ => arch}/arm64/elf_hwcaps.rst        | 12 ++++++------
 Documentation/{ => arch}/arm64/features.rst          |  0
 Documentation/{ => arch}/arm64/hugetlbpage.rst       |  0
 Documentation/{ => arch}/arm64/index.rst             |  0
 Documentation/{ => arch}/arm64/kasan-offsets.sh      |  0
 .../{ => arch}/arm64/legacy_instructions.rst         |  0
 .../{ => arch}/arm64/memory-tagging-extension.rst    |  2 +-
 Documentation/{ => arch}/arm64/memory.rst            |  0
 Documentation/{ => arch}/arm64/perf.rst              |  0
 .../{ => arch}/arm64/pointer-authentication.rst      |  0
 Documentation/{ => arch}/arm64/silicon-errata.rst    |  0
 Documentation/{ => arch}/arm64/sme.rst               |  2 +-
 Documentation/{ => arch}/arm64/sve.rst               |  2 +-
 .../{ => arch}/arm64/tagged-address-abi.rst          |  2 +-
 Documentation/{ => arch}/arm64/tagged-pointers.rst   |  2 +-
 Documentation/arch/index.rst                         |  2 +-
 .../translations/zh_CN/{ => arch}/arm64/amu.rst      |  4 ++--
 .../translations/zh_CN/{ => arch}/arm64/booting.txt  |  4 ++--
 .../zh_CN/{ => arch}/arm64/elf_hwcaps.rst            | 10 +++++-----
 .../zh_CN/{ => arch}/arm64/hugetlbpage.rst           |  4 ++--
 .../translations/zh_CN/{ => arch}/arm64/index.rst    |  4 ++--
 .../zh_CN/{ => arch}/arm64/legacy_instructions.txt   |  4 ++--
 .../translations/zh_CN/{ => arch}/arm64/memory.txt   |  4 ++--
 .../translations/zh_CN/{ => arch}/arm64/perf.rst     |  4 ++--
 .../zh_CN/{ => arch}/arm64/silicon-errata.txt        |  4 ++--
 .../zh_CN/{ => arch}/arm64/tagged-pointers.txt       |  4 ++--
 Documentation/translations/zh_CN/arch/index.rst      |  2 +-
 .../translations/zh_TW/{ => arch}/arm64/amu.rst      |  4 ++--
 .../translations/zh_TW/{ => arch}/arm64/booting.txt  |  4 ++--
 .../zh_TW/{ => arch}/arm64/elf_hwcaps.rst            | 10 +++++-----
 .../zh_TW/{ => arch}/arm64/hugetlbpage.rst           |  4 ++--
 .../translations/zh_TW/{ => arch}/arm64/index.rst    |  4 ++--
 .../zh_TW/{ => arch}/arm64/legacy_instructions.txt   |  4 ++--
 .../translations/zh_TW/{ => arch}/arm64/memory.txt   |  4 ++--
 .../translations/zh_TW/{ => arch}/arm64/perf.rst     |  4 ++--
 .../zh_TW/{ => arch}/arm64/silicon-errata.txt        |  4 ++--
 .../zh_TW/{ => arch}/arm64/tagged-pointers.txt       |  4 ++--
 Documentation/translations/zh_TW/index.rst           |  2 +-
 Documentation/virt/kvm/api.rst                       |  2 +-
 MAINTAINERS                                          |  2 +-
 49 files changed, 66 insertions(+), 66 deletions(-)
 rename Documentation/{ => arch}/arm64/acpi_object_usage.rst (100%)
 rename Documentation/{ => arch}/arm64/amu.rst (100%)
 rename Documentation/{ => arch}/arm64/arm-acpi.rst (99%)
 rename Documentation/{ => arch}/arm64/asymmetric-32bit.rst (100%)
 rename Documentation/{ => arch}/arm64/booting.rst (100%)
 rename Documentation/{ => arch}/arm64/cpu-feature-registers.rst (100%)
 rename Documentation/{ => arch}/arm64/elf_hwcaps.rst (96%)
 rename Documentation/{ => arch}/arm64/features.rst (100%)
 rename Documentation/{ => arch}/arm64/hugetlbpage.rst (100%)
 rename Documentation/{ => arch}/arm64/index.rst (100%)
 rename Documentation/{ => arch}/arm64/kasan-offsets.sh (100%)
 rename Documentation/{ => arch}/arm64/legacy_instructions.rst (100%)
 rename Documentation/{ => arch}/arm64/memory-tagging-extension.rst (99%)
 rename Documentation/{ => arch}/arm64/memory.rst (100%)
 rename Documentation/{ => arch}/arm64/perf.rst (100%)
 rename Documentation/{ => arch}/arm64/pointer-authentication.rst (100%)
 rename Documentation/{ => arch}/arm64/silicon-errata.rst (100%)
 rename Documentation/{ => arch}/arm64/sme.rst (99%)
 rename Documentation/{ => arch}/arm64/sve.rst (99%)
 rename Documentation/{ => arch}/arm64/tagged-address-abi.rst (99%)
 rename Documentation/{ => arch}/arm64/tagged-pointers.rst (98%)
 rename Documentation/translations/zh_CN/{ => arch}/arm64/amu.rst (97%)
 rename Documentation/translations/zh_CN/{ => arch}/arm64/booting.txt (98%)
 rename Documentation/translations/zh_CN/{ => arch}/arm64/elf_hwcaps.rst (94%)
 rename Documentation/translations/zh_CN/{ => arch}/arm64/hugetlbpage.rst (91%)
 rename Documentation/translations/zh_CN/{ => arch}/arm64/index.rst (63%)
 rename Documentation/translations/zh_CN/{ => arch}/arm64/legacy_instructions.txt (95%)
 rename Documentation/translations/zh_CN/{ => arch}/arm64/memory.txt (97%)
 rename Documentation/translations/zh_CN/{ => arch}/arm64/perf.rst (96%)
 rename Documentation/translations/zh_CN/{ => arch}/arm64/silicon-errata.txt (97%)
 rename Documentation/translations/zh_CN/{ => arch}/arm64/tagged-pointers.txt (94%)
 rename Documentation/translations/zh_TW/{ => arch}/arm64/amu.rst (97%)
 rename Documentation/translations/zh_TW/{ => arch}/arm64/booting.txt (98%)
 rename Documentation/translations/zh_TW/{ => arch}/arm64/elf_hwcaps.rst (94%)
 rename Documentation/translations/zh_TW/{ => arch}/arm64/hugetlbpage.rst (91%)
 rename Documentation/translations/zh_TW/{ => arch}/arm64/index.rst (71%)
 rename Documentation/translations/zh_TW/{ => arch}/arm64/legacy_instructions.txt (96%)
 rename Documentation/translations/zh_TW/{ => arch}/arm64/memory.txt (97%)
 rename Documentation/translations/zh_TW/{ => arch}/arm64/perf.rst (96%)
 rename Documentation/translations/zh_TW/{ => arch}/arm64/silicon-errata.txt (97%)
 rename Documentation/translations/zh_TW/{ => arch}/arm64/tagged-pointers.txt (95%)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index f54867cadb0f..ecd585ca2d50 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -670,7 +670,7 @@ Description:	Preferred MTE tag checking mode
 		"async"	  	  Prefer asynchronous mode
 		================  ==============================================
 
-		See also: Documentation/arm64/memory-tagging-extension.rst
+		See also: Documentation/arch/arm64/memory-tagging-extension.rst
 
 What:		/sys/devices/system/cpu/nohz_full
 Date:		Apr 2015
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9e5bab29685f..893b5a133041 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -304,7 +304,7 @@
 			EL0 is indicated by /sys/devices/system/cpu/aarch32_el0
 			and hot-unplug operations may be restricted.
 
-			See Documentation/arm64/asymmetric-32bit.rst for more
+			See Documentation/arch/arm64/asymmetric-32bit.rst for more
 			information.
 
 	amd_iommu=	[HW,X86-64]
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index d85d90f5d000..3800fab1619b 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -949,7 +949,7 @@ user space can read performance monitor counter registers directly.
 
 The default value is 0 (access disabled).
 
-See Documentation/arm64/perf.rst for more information.
+See Documentation/arch/arm64/perf.rst for more information.
 
 
 pid_max
diff --git a/Documentation/arm64/acpi_object_usage.rst b/Documentation/arch/arm64/acpi_object_usage.rst
similarity index 100%
rename from Documentation/arm64/acpi_object_usage.rst
rename to Documentation/arch/arm64/acpi_object_usage.rst
diff --git a/Documentation/arm64/amu.rst b/Documentation/arch/arm64/amu.rst
similarity index 100%
rename from Documentation/arm64/amu.rst
rename to Documentation/arch/arm64/amu.rst
diff --git a/Documentation/arm64/arm-acpi.rst b/Documentation/arch/arm64/arm-acpi.rst
similarity index 99%
rename from Documentation/arm64/arm-acpi.rst
rename to Documentation/arch/arm64/arm-acpi.rst
index 47ecb9930dde..1636352756bb 100644
--- a/Documentation/arm64/arm-acpi.rst
+++ b/Documentation/arch/arm64/arm-acpi.rst
@@ -485,7 +485,7 @@ ACPI_OS_NAME
 ACPI Objects
 ------------
 Detailed expectations for ACPI tables and object are listed in the file
-Documentation/arm64/acpi_object_usage.rst.
+Documentation/arch/arm64/acpi_object_usage.rst.
 
 
 References
diff --git a/Documentation/arm64/asymmetric-32bit.rst b/Documentation/arch/arm64/asymmetric-32bit.rst
similarity index 100%
rename from Documentation/arm64/asymmetric-32bit.rst
rename to Documentation/arch/arm64/asymmetric-32bit.rst
diff --git a/Documentation/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
similarity index 100%
rename from Documentation/arm64/booting.rst
rename to Documentation/arch/arm64/booting.rst
diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentation/arch/arm64/cpu-feature-registers.rst
similarity index 100%
rename from Documentation/arm64/cpu-feature-registers.rst
rename to Documentation/arch/arm64/cpu-feature-registers.rst
diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arch/arm64/elf_hwcaps.rst
similarity index 96%
rename from Documentation/arm64/elf_hwcaps.rst
rename to Documentation/arch/arm64/elf_hwcaps.rst
index 83e57e4d38e2..58a86d532228 100644
--- a/Documentation/arm64/elf_hwcaps.rst
+++ b/Documentation/arch/arm64/elf_hwcaps.rst
@@ -102,7 +102,7 @@ HWCAP_ASIMDHP
 
 HWCAP_CPUID
     EL0 access to certain ID registers is available, to the extent
-    described by Documentation/arm64/cpu-feature-registers.rst.
+    described by Documentation/arch/arm64/cpu-feature-registers.rst.
 
     These ID registers may imply the availability of features.
 
@@ -163,12 +163,12 @@ HWCAP_SB
 HWCAP_PACA
     Functionality implied by ID_AA64ISAR1_EL1.APA == 0b0001 or
     ID_AA64ISAR1_EL1.API == 0b0001, as described by
-    Documentation/arm64/pointer-authentication.rst.
+    Documentation/arch/arm64/pointer-authentication.rst.
 
 HWCAP_PACG
     Functionality implied by ID_AA64ISAR1_EL1.GPA == 0b0001 or
     ID_AA64ISAR1_EL1.GPI == 0b0001, as described by
-    Documentation/arm64/pointer-authentication.rst.
+    Documentation/arch/arm64/pointer-authentication.rst.
 
 HWCAP2_DCPODP
     Functionality implied by ID_AA64ISAR1_EL1.DPB == 0b0010.
@@ -226,7 +226,7 @@ HWCAP2_BTI
 
 HWCAP2_MTE
     Functionality implied by ID_AA64PFR1_EL1.MTE == 0b0010, as described
-    by Documentation/arm64/memory-tagging-extension.rst.
+    by Documentation/arch/arm64/memory-tagging-extension.rst.
 
 HWCAP2_ECV
     Functionality implied by ID_AA64MMFR0_EL1.ECV == 0b0001.
@@ -239,11 +239,11 @@ HWCAP2_RPRES
 
 HWCAP2_MTE3
     Functionality implied by ID_AA64PFR1_EL1.MTE == 0b0011, as described
-    by Documentation/arm64/memory-tagging-extension.rst.
+    by Documentation/arch/arm64/memory-tagging-extension.rst.
 
 HWCAP2_SME
     Functionality implied by ID_AA64PFR1_EL1.SME == 0b0001, as described
-    by Documentation/arm64/sme.rst.
+    by Documentation/arch/arm64/sme.rst.
 
 HWCAP2_SME_I16I64
     Functionality implied by ID_AA64SMFR0_EL1.I16I64 == 0b1111.
diff --git a/Documentation/arm64/features.rst b/Documentation/arch/arm64/features.rst
similarity index 100%
rename from Documentation/arm64/features.rst
rename to Documentation/arch/arm64/features.rst
diff --git a/Documentation/arm64/hugetlbpage.rst b/Documentation/arch/arm64/hugetlbpage.rst
similarity index 100%
rename from Documentation/arm64/hugetlbpage.rst
rename to Documentation/arch/arm64/hugetlbpage.rst
diff --git a/Documentation/arm64/index.rst b/Documentation/arch/arm64/index.rst
similarity index 100%
rename from Documentation/arm64/index.rst
rename to Documentation/arch/arm64/index.rst
diff --git a/Documentation/arm64/kasan-offsets.sh b/Documentation/arch/arm64/kasan-offsets.sh
similarity index 100%
rename from Documentation/arm64/kasan-offsets.sh
rename to Documentation/arch/arm64/kasan-offsets.sh
diff --git a/Documentation/arm64/legacy_instructions.rst b/Documentation/arch/arm64/legacy_instructions.rst
similarity index 100%
rename from Documentation/arm64/legacy_instructions.rst
rename to Documentation/arch/arm64/legacy_instructions.rst
diff --git a/Documentation/arm64/memory-tagging-extension.rst b/Documentation/arch/arm64/memory-tagging-extension.rst
similarity index 99%
rename from Documentation/arm64/memory-tagging-extension.rst
rename to Documentation/arch/arm64/memory-tagging-extension.rst
index dbae47bba25e..679725030731 100644
--- a/Documentation/arm64/memory-tagging-extension.rst
+++ b/Documentation/arch/arm64/memory-tagging-extension.rst
@@ -221,7 +221,7 @@ programs should not retry in case of a non-zero system call return.
 ``NT_ARM_TAGGED_ADDR_CTRL`` allow ``ptrace()`` access to the tagged
 address ABI control and MTE configuration of a process as per the
 ``prctl()`` options described in
-Documentation/arm64/tagged-address-abi.rst and above. The corresponding
+Documentation/arch/arm64/tagged-address-abi.rst and above. The corresponding
 ``regset`` is 1 element of 8 bytes (``sizeof(long))``).
 
 Core dump support
diff --git a/Documentation/arm64/memory.rst b/Documentation/arch/arm64/memory.rst
similarity index 100%
rename from Documentation/arm64/memory.rst
rename to Documentation/arch/arm64/memory.rst
diff --git a/Documentation/arm64/perf.rst b/Documentation/arch/arm64/perf.rst
similarity index 100%
rename from Documentation/arm64/perf.rst
rename to Documentation/arch/arm64/perf.rst
diff --git a/Documentation/arm64/pointer-authentication.rst b/Documentation/arch/arm64/pointer-authentication.rst
similarity index 100%
rename from Documentation/arm64/pointer-authentication.rst
rename to Documentation/arch/arm64/pointer-authentication.rst
diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
similarity index 100%
rename from Documentation/arm64/silicon-errata.rst
rename to Documentation/arch/arm64/silicon-errata.rst
diff --git a/Documentation/arm64/sme.rst b/Documentation/arch/arm64/sme.rst
similarity index 99%
rename from Documentation/arm64/sme.rst
rename to Documentation/arch/arm64/sme.rst
index 1c43ea12eb4f..ba529a1dc606 100644
--- a/Documentation/arm64/sme.rst
+++ b/Documentation/arch/arm64/sme.rst
@@ -465,4 +465,4 @@ References
 [2] arch/arm64/include/uapi/asm/ptrace.h
     AArch64 Linux ptrace ABI definitions
 
-[3] Documentation/arm64/cpu-feature-registers.rst
+[3] Documentation/arch/arm64/cpu-feature-registers.rst
diff --git a/Documentation/arm64/sve.rst b/Documentation/arch/arm64/sve.rst
similarity index 99%
rename from Documentation/arm64/sve.rst
rename to Documentation/arch/arm64/sve.rst
index 1b90a30382ac..0d9a426e9f85 100644
--- a/Documentation/arm64/sve.rst
+++ b/Documentation/arch/arm64/sve.rst
@@ -606,7 +606,7 @@ References
 [2] arch/arm64/include/uapi/asm/ptrace.h
     AArch64 Linux ptrace ABI definitions
 
-[3] Documentation/arm64/cpu-feature-registers.rst
+[3] Documentation/arch/arm64/cpu-feature-registers.rst
 
 [4] ARM IHI0055C
     http://infocenter.arm.com/help/topic/com.arm.doc.ihi0055c/IHI0055C_beta_aapcs64.pdf
diff --git a/Documentation/arm64/tagged-address-abi.rst b/Documentation/arch/arm64/tagged-address-abi.rst
similarity index 99%
rename from Documentation/arm64/tagged-address-abi.rst
rename to Documentation/arch/arm64/tagged-address-abi.rst
index 540a1d4fc6c9..fe24a3f158c5 100644
--- a/Documentation/arm64/tagged-address-abi.rst
+++ b/Documentation/arch/arm64/tagged-address-abi.rst
@@ -107,7 +107,7 @@ following behaviours are guaranteed:
 
 
 A definition of the meaning of tagged pointers on AArch64 can be found
-in Documentation/arm64/tagged-pointers.rst.
+in Documentation/arch/arm64/tagged-pointers.rst.
 
 3. AArch64 Tagged Address ABI Exceptions
 -----------------------------------------
diff --git a/Documentation/arm64/tagged-pointers.rst b/Documentation/arch/arm64/tagged-pointers.rst
similarity index 98%
rename from Documentation/arm64/tagged-pointers.rst
rename to Documentation/arch/arm64/tagged-pointers.rst
index 19d284b70384..81b6c2a770dd 100644
--- a/Documentation/arm64/tagged-pointers.rst
+++ b/Documentation/arch/arm64/tagged-pointers.rst
@@ -22,7 +22,7 @@ Passing tagged addresses to the kernel
 All interpretation of userspace memory addresses by the kernel assumes
 an address tag of 0x00, unless the application enables the AArch64
 Tagged Address ABI explicitly
-(Documentation/arm64/tagged-address-abi.rst).
+(Documentation/arch/arm64/tagged-address-abi.rst).
 
 This includes, but is not limited to, addresses found in:
 
diff --git a/Documentation/arch/index.rst b/Documentation/arch/index.rst
index 80ee31016584..41cd957d53ea 100644
--- a/Documentation/arch/index.rst
+++ b/Documentation/arch/index.rst
@@ -11,7 +11,7 @@ implementation.
 
    arc/index
    ../arm/index
-   ../arm64/index
+   arm64/index
    ia64/index
    ../loongarch/index
    m68k/index
diff --git a/Documentation/translations/zh_CN/arm64/amu.rst b/Documentation/translations/zh_CN/arch/arm64/amu.rst
similarity index 97%
rename from Documentation/translations/zh_CN/arm64/amu.rst
rename to Documentation/translations/zh_CN/arch/arm64/amu.rst
index ab7180f91394..f8e09fd21ef5 100644
--- a/Documentation/translations/zh_CN/arm64/amu.rst
+++ b/Documentation/translations/zh_CN/arch/arm64/amu.rst
@@ -1,6 +1,6 @@
-.. include:: ../disclaimer-zh_CN.rst
+.. include:: ../../disclaimer-zh_CN.rst
 
-:Original: :ref:`Documentation/arm64/amu.rst <amu_index>`
+:Original: :ref:`Documentation/arch/arm64/amu.rst <amu_index>`
 
 Translator: Bailu Lin <bailu.lin@vivo.com>
 
diff --git a/Documentation/translations/zh_CN/arm64/booting.txt b/Documentation/translations/zh_CN/arch/arm64/booting.txt
similarity index 98%
rename from Documentation/translations/zh_CN/arm64/booting.txt
rename to Documentation/translations/zh_CN/arch/arm64/booting.txt
index 5b0164132c71..630eb32a8854 100644
--- a/Documentation/translations/zh_CN/arm64/booting.txt
+++ b/Documentation/translations/zh_CN/arch/arm64/booting.txt
@@ -1,4 +1,4 @@
-Chinese translated version of Documentation/arm64/booting.rst
+Chinese translated version of Documentation/arch/arm64/booting.rst
 
 If you have any comment or update to the content, please contact the
 original document maintainer directly.  However, if you have a problem
@@ -10,7 +10,7 @@ M:	Will Deacon <will.deacon@arm.com>
 zh_CN:	Fu Wei <wefu@redhat.com>
 C:	55f058e7574c3615dea4615573a19bdb258696c6
 ---------------------------------------------------------------------
-Documentation/arm64/booting.rst 的中文翻译
+Documentation/arch/arm64/booting.rst 的中文翻译
 
 如果想评论或更新本文的内容，请直接联系原文档的维护者。如果你使用英文
 交流有困难的话，也可以向中文版维护者求助。如果本翻译更新不及时或者翻
diff --git a/Documentation/translations/zh_CN/arm64/elf_hwcaps.rst b/Documentation/translations/zh_CN/arch/arm64/elf_hwcaps.rst
similarity index 94%
rename from Documentation/translations/zh_CN/arm64/elf_hwcaps.rst
rename to Documentation/translations/zh_CN/arch/arm64/elf_hwcaps.rst
index 9aa4637eac97..f60ac1580d3e 100644
--- a/Documentation/translations/zh_CN/arm64/elf_hwcaps.rst
+++ b/Documentation/translations/zh_CN/arch/arm64/elf_hwcaps.rst
@@ -1,6 +1,6 @@
-.. include:: ../disclaimer-zh_CN.rst
+.. include:: ../../disclaimer-zh_CN.rst
 
-:Original: :ref:`Documentation/arm64/elf_hwcaps.rst <elf_hwcaps_index>`
+:Original: :ref:`Documentation/arch/arm64/elf_hwcaps.rst <elf_hwcaps_index>`
 
 Translator: Bailu Lin <bailu.lin@vivo.com>
 
@@ -92,7 +92,7 @@ HWCAP_ASIMDHP
     ID_AA64PFR0_EL1.AdvSIMD == 0b0001 表示有此功能。
 
 HWCAP_CPUID
-    根据 Documentation/arm64/cpu-feature-registers.rst 描述，EL0 可以访问
+    根据 Documentation/arch/arm64/cpu-feature-registers.rst 描述，EL0 可以访问
     某些 ID 寄存器。
 
     这些 ID 寄存器可能表示功能的可用性。
@@ -152,12 +152,12 @@ HWCAP_SB
     ID_AA64ISAR1_EL1.SB == 0b0001 表示有此功能。
 
 HWCAP_PACA
-    如 Documentation/arm64/pointer-authentication.rst 所描述，
+    如 Documentation/arch/arm64/pointer-authentication.rst 所描述，
     ID_AA64ISAR1_EL1.APA == 0b0001 或 ID_AA64ISAR1_EL1.API == 0b0001
     表示有此功能。
 
 HWCAP_PACG
-    如 Documentation/arm64/pointer-authentication.rst 所描述，
+    如 Documentation/arch/arm64/pointer-authentication.rst 所描述，
     ID_AA64ISAR1_EL1.GPA == 0b0001 或 ID_AA64ISAR1_EL1.GPI == 0b0001
     表示有此功能。
 
diff --git a/Documentation/translations/zh_CN/arm64/hugetlbpage.rst b/Documentation/translations/zh_CN/arch/arm64/hugetlbpage.rst
similarity index 91%
rename from Documentation/translations/zh_CN/arm64/hugetlbpage.rst
rename to Documentation/translations/zh_CN/arch/arm64/hugetlbpage.rst
index 13304d269d0b..8079eadde29a 100644
--- a/Documentation/translations/zh_CN/arm64/hugetlbpage.rst
+++ b/Documentation/translations/zh_CN/arch/arm64/hugetlbpage.rst
@@ -1,6 +1,6 @@
-.. include:: ../disclaimer-zh_CN.rst
+.. include:: ../../disclaimer-zh_CN.rst
 
-:Original: :ref:`Documentation/arm64/hugetlbpage.rst <hugetlbpage_index>`
+:Original: :ref:`Documentation/arch/arm64/hugetlbpage.rst <hugetlbpage_index>`
 
 Translator: Bailu Lin <bailu.lin@vivo.com>
 
diff --git a/Documentation/translations/zh_CN/arm64/index.rst b/Documentation/translations/zh_CN/arch/arm64/index.rst
similarity index 63%
rename from Documentation/translations/zh_CN/arm64/index.rst
rename to Documentation/translations/zh_CN/arch/arm64/index.rst
index 57dc5de5ccc5..e12b9f6e5d6c 100644
--- a/Documentation/translations/zh_CN/arm64/index.rst
+++ b/Documentation/translations/zh_CN/arch/arm64/index.rst
@@ -1,6 +1,6 @@
-.. include:: ../disclaimer-zh_CN.rst
+.. include:: ../../disclaimer-zh_CN.rst
 
-:Original: :ref:`Documentation/arm64/index.rst <arm64_index>`
+:Original: :ref:`Documentation/arch/arm64/index.rst <arm64_index>`
 :Translator: Bailu Lin <bailu.lin@vivo.com>
 
 .. _cn_arm64_index:
diff --git a/Documentation/translations/zh_CN/arm64/legacy_instructions.txt b/Documentation/translations/zh_CN/arch/arm64/legacy_instructions.txt
similarity index 95%
rename from Documentation/translations/zh_CN/arm64/legacy_instructions.txt
rename to Documentation/translations/zh_CN/arch/arm64/legacy_instructions.txt
index e295cf75f606..e469fccbe356 100644
--- a/Documentation/translations/zh_CN/arm64/legacy_instructions.txt
+++ b/Documentation/translations/zh_CN/arch/arm64/legacy_instructions.txt
@@ -1,4 +1,4 @@
-Chinese translated version of Documentation/arm64/legacy_instructions.rst
+Chinese translated version of Documentation/arch/arm64/legacy_instructions.rst
 
 If you have any comment or update to the content, please contact the
 original document maintainer directly.  However, if you have a problem
@@ -10,7 +10,7 @@ Maintainer: Punit Agrawal <punit.agrawal@arm.com>
             Suzuki K. Poulose <suzuki.poulose@arm.com>
 Chinese maintainer: Fu Wei <wefu@redhat.com>
 ---------------------------------------------------------------------
-Documentation/arm64/legacy_instructions.rst 的中文翻译
+Documentation/arch/arm64/legacy_instructions.rst 的中文翻译
 
 如果想评论或更新本文的内容，请直接联系原文档的维护者。如果你使用英文
 交流有困难的话，也可以向中文版维护者求助。如果本翻译更新不及时或者翻
diff --git a/Documentation/translations/zh_CN/arm64/memory.txt b/Documentation/translations/zh_CN/arch/arm64/memory.txt
similarity index 97%
rename from Documentation/translations/zh_CN/arm64/memory.txt
rename to Documentation/translations/zh_CN/arch/arm64/memory.txt
index be20f8228b91..c6962e9cb9f8 100644
--- a/Documentation/translations/zh_CN/arm64/memory.txt
+++ b/Documentation/translations/zh_CN/arch/arm64/memory.txt
@@ -1,4 +1,4 @@
-Chinese translated version of Documentation/arm64/memory.rst
+Chinese translated version of Documentation/arch/arm64/memory.rst
 
 If you have any comment or update to the content, please contact the
 original document maintainer directly.  However, if you have a problem
@@ -9,7 +9,7 @@ or if there is a problem with the translation.
 Maintainer: Catalin Marinas <catalin.marinas@arm.com>
 Chinese maintainer: Fu Wei <wefu@redhat.com>
 ---------------------------------------------------------------------
-Documentation/arm64/memory.rst 的中文翻译
+Documentation/arch/arm64/memory.rst 的中文翻译
 
 如果想评论或更新本文的内容，请直接联系原文档的维护者。如果你使用英文
 交流有困难的话，也可以向中文版维护者求助。如果本翻译更新不及时或者翻
diff --git a/Documentation/translations/zh_CN/arm64/perf.rst b/Documentation/translations/zh_CN/arch/arm64/perf.rst
similarity index 96%
rename from Documentation/translations/zh_CN/arm64/perf.rst
rename to Documentation/translations/zh_CN/arch/arm64/perf.rst
index 9bf21d73f4d1..6be72704e659 100644
--- a/Documentation/translations/zh_CN/arm64/perf.rst
+++ b/Documentation/translations/zh_CN/arch/arm64/perf.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. include:: ../disclaimer-zh_CN.rst
+.. include:: ../../disclaimer-zh_CN.rst
 
-:Original: :ref:`Documentation/arm64/perf.rst <perf_index>`
+:Original: :ref:`Documentation/arch/arm64/perf.rst <perf_index>`
 
 Translator: Bailu Lin <bailu.lin@vivo.com>
 
diff --git a/Documentation/translations/zh_CN/arm64/silicon-errata.txt b/Documentation/translations/zh_CN/arch/arm64/silicon-errata.txt
similarity index 97%
rename from Documentation/translations/zh_CN/arm64/silicon-errata.txt
rename to Documentation/translations/zh_CN/arch/arm64/silicon-errata.txt
index 440c59ac7dce..f4767ffdd61d 100644
--- a/Documentation/translations/zh_CN/arm64/silicon-errata.txt
+++ b/Documentation/translations/zh_CN/arch/arm64/silicon-errata.txt
@@ -1,4 +1,4 @@
-Chinese translated version of Documentation/arm64/silicon-errata.rst
+Chinese translated version of Documentation/arch/arm64/silicon-errata.rst
 
 If you have any comment or update to the content, please contact the
 original document maintainer directly.  However, if you have a problem
@@ -10,7 +10,7 @@ M:	Will Deacon <will.deacon@arm.com>
 zh_CN:	Fu Wei <wefu@redhat.com>
 C:	1926e54f115725a9248d0c4c65c22acaf94de4c4
 ---------------------------------------------------------------------
-Documentation/arm64/silicon-errata.rst 的中文翻译
+Documentation/arch/arm64/silicon-errata.rst 的中文翻译
 
 如果想评论或更新本文的内容，请直接联系原文档的维护者。如果你使用英文
 交流有困难的话，也可以向中文版维护者求助。如果本翻译更新不及时或者翻
diff --git a/Documentation/translations/zh_CN/arm64/tagged-pointers.txt b/Documentation/translations/zh_CN/arch/arm64/tagged-pointers.txt
similarity index 94%
rename from Documentation/translations/zh_CN/arm64/tagged-pointers.txt
rename to Documentation/translations/zh_CN/arch/arm64/tagged-pointers.txt
index 77ac3548a16d..27577c3c5e3f 100644
--- a/Documentation/translations/zh_CN/arm64/tagged-pointers.txt
+++ b/Documentation/translations/zh_CN/arch/arm64/tagged-pointers.txt
@@ -1,4 +1,4 @@
-Chinese translated version of Documentation/arm64/tagged-pointers.rst
+Chinese translated version of Documentation/arch/arm64/tagged-pointers.rst
 
 If you have any comment or update to the content, please contact the
 original document maintainer directly.  However, if you have a problem
@@ -9,7 +9,7 @@ or if there is a problem with the translation.
 Maintainer: Will Deacon <will.deacon@arm.com>
 Chinese maintainer: Fu Wei <wefu@redhat.com>
 ---------------------------------------------------------------------
-Documentation/arm64/tagged-pointers.rst 的中文翻译
+Documentation/arch/arm64/tagged-pointers.rst 的中文翻译
 
 如果想评论或更新本文的内容，请直接联系原文档的维护者。如果你使用英文
 交流有困难的话，也可以向中文版维护者求助。如果本翻译更新不及时或者翻
diff --git a/Documentation/translations/zh_CN/arch/index.rst b/Documentation/translations/zh_CN/arch/index.rst
index 908ea131bb1c..6fa0cb671009 100644
--- a/Documentation/translations/zh_CN/arch/index.rst
+++ b/Documentation/translations/zh_CN/arch/index.rst
@@ -9,7 +9,7 @@
    :maxdepth: 2
 
    ../mips/index
-   ../arm64/index
+   arm64/index
    ../riscv/index
    openrisc/index
    parisc/index
diff --git a/Documentation/translations/zh_TW/arm64/amu.rst b/Documentation/translations/zh_TW/arch/arm64/amu.rst
similarity index 97%
rename from Documentation/translations/zh_TW/arm64/amu.rst
rename to Documentation/translations/zh_TW/arch/arm64/amu.rst
index ffdc466e0f62..f947a6c7369f 100644
--- a/Documentation/translations/zh_TW/arm64/amu.rst
+++ b/Documentation/translations/zh_TW/arch/arm64/amu.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. include:: ../disclaimer-zh_TW.rst
+.. include:: ../../disclaimer-zh_TW.rst
 
-:Original: :ref:`Documentation/arm64/amu.rst <amu_index>`
+:Original: :ref:`Documentation/arch/arm64/amu.rst <amu_index>`
 
 Translator: Bailu Lin <bailu.lin@vivo.com>
             Hu Haowen <src.res@email.cn>
diff --git a/Documentation/translations/zh_TW/arm64/booting.txt b/Documentation/translations/zh_TW/arch/arm64/booting.txt
similarity index 98%
rename from Documentation/translations/zh_TW/arm64/booting.txt
rename to Documentation/translations/zh_TW/arch/arm64/booting.txt
index b9439dd54012..24817b8b70cd 100644
--- a/Documentation/translations/zh_TW/arm64/booting.txt
+++ b/Documentation/translations/zh_TW/arch/arm64/booting.txt
@@ -1,6 +1,6 @@
 SPDX-License-Identifier: GPL-2.0
 
-Chinese translated version of Documentation/arm64/booting.rst
+Chinese translated version of Documentation/arch/arm64/booting.rst
 
 If you have any comment or update to the content, please contact the
 original document maintainer directly.  However, if you have a problem
@@ -13,7 +13,7 @@ zh_CN:	Fu Wei <wefu@redhat.com>
 zh_TW:	Hu Haowen <src.res@email.cn>
 C:	55f058e7574c3615dea4615573a19bdb258696c6
 ---------------------------------------------------------------------
-Documentation/arm64/booting.rst 的中文翻譯
+Documentation/arch/arm64/booting.rst 的中文翻譯
 
 如果想評論或更新本文的內容，請直接聯繫原文檔的維護者。如果你使用英文
 交流有困難的話，也可以向中文版維護者求助。如果本翻譯更新不及時或者翻
diff --git a/Documentation/translations/zh_TW/arm64/elf_hwcaps.rst b/Documentation/translations/zh_TW/arch/arm64/elf_hwcaps.rst
similarity index 94%
rename from Documentation/translations/zh_TW/arm64/elf_hwcaps.rst
rename to Documentation/translations/zh_TW/arch/arm64/elf_hwcaps.rst
index 3eb1c623ce31..fca3c6ff7b93 100644
--- a/Documentation/translations/zh_TW/arm64/elf_hwcaps.rst
+++ b/Documentation/translations/zh_TW/arch/arm64/elf_hwcaps.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. include:: ../disclaimer-zh_TW.rst
+.. include:: ../../disclaimer-zh_TW.rst
 
-:Original: :ref:`Documentation/arm64/elf_hwcaps.rst <elf_hwcaps_index>`
+:Original: :ref:`Documentation/arch/arm64/elf_hwcaps.rst <elf_hwcaps_index>`
 
 Translator: Bailu Lin <bailu.lin@vivo.com>
             Hu Haowen <src.res@email.cn>
@@ -95,7 +95,7 @@ HWCAP_ASIMDHP
     ID_AA64PFR0_EL1.AdvSIMD == 0b0001 表示有此功能。
 
 HWCAP_CPUID
-    根據 Documentation/arm64/cpu-feature-registers.rst 描述，EL0 可以訪問
+    根據 Documentation/arch/arm64/cpu-feature-registers.rst 描述，EL0 可以訪問
     某些 ID 寄存器。
 
     這些 ID 寄存器可能表示功能的可用性。
@@ -155,12 +155,12 @@ HWCAP_SB
     ID_AA64ISAR1_EL1.SB == 0b0001 表示有此功能。
 
 HWCAP_PACA
-    如 Documentation/arm64/pointer-authentication.rst 所描述，
+    如 Documentation/arch/arm64/pointer-authentication.rst 所描述，
     ID_AA64ISAR1_EL1.APA == 0b0001 或 ID_AA64ISAR1_EL1.API == 0b0001
     表示有此功能。
 
 HWCAP_PACG
-    如 Documentation/arm64/pointer-authentication.rst 所描述，
+    如 Documentation/arch/arm64/pointer-authentication.rst 所描述，
     ID_AA64ISAR1_EL1.GPA == 0b0001 或 ID_AA64ISAR1_EL1.GPI == 0b0001
     表示有此功能。
 
diff --git a/Documentation/translations/zh_TW/arm64/hugetlbpage.rst b/Documentation/translations/zh_TW/arch/arm64/hugetlbpage.rst
similarity index 91%
rename from Documentation/translations/zh_TW/arm64/hugetlbpage.rst
rename to Documentation/translations/zh_TW/arch/arm64/hugetlbpage.rst
index 846b500dae97..10feb329dfb8 100644
--- a/Documentation/translations/zh_TW/arm64/hugetlbpage.rst
+++ b/Documentation/translations/zh_TW/arch/arm64/hugetlbpage.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. include:: ../disclaimer-zh_TW.rst
+.. include:: ../../disclaimer-zh_TW.rst
 
-:Original: :ref:`Documentation/arm64/hugetlbpage.rst <hugetlbpage_index>`
+:Original: :ref:`Documentation/arch/arm64/hugetlbpage.rst <hugetlbpage_index>`
 
 Translator: Bailu Lin <bailu.lin@vivo.com>
             Hu Haowen <src.res@email.cn>
diff --git a/Documentation/translations/zh_TW/arm64/index.rst b/Documentation/translations/zh_TW/arch/arm64/index.rst
similarity index 71%
rename from Documentation/translations/zh_TW/arm64/index.rst
rename to Documentation/translations/zh_TW/arch/arm64/index.rst
index 2322783f3881..68befee14b99 100644
--- a/Documentation/translations/zh_TW/arm64/index.rst
+++ b/Documentation/translations/zh_TW/arch/arm64/index.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. include:: ../disclaimer-zh_TW.rst
+.. include:: ../../disclaimer-zh_TW.rst
 
-:Original: :ref:`Documentation/arm64/index.rst <arm64_index>`
+:Original: :ref:`Documentation/arch/arm64/index.rst <arm64_index>`
 :Translator: Bailu Lin <bailu.lin@vivo.com>
              Hu Haowen <src.res@email.cn>
 
diff --git a/Documentation/translations/zh_TW/arm64/legacy_instructions.txt b/Documentation/translations/zh_TW/arch/arm64/legacy_instructions.txt
similarity index 96%
rename from Documentation/translations/zh_TW/arm64/legacy_instructions.txt
rename to Documentation/translations/zh_TW/arch/arm64/legacy_instructions.txt
index 6d4454f77b9e..3c915df9836c 100644
--- a/Documentation/translations/zh_TW/arm64/legacy_instructions.txt
+++ b/Documentation/translations/zh_TW/arch/arm64/legacy_instructions.txt
@@ -1,6 +1,6 @@
 SPDX-License-Identifier: GPL-2.0
 
-Chinese translated version of Documentation/arm64/legacy_instructions.rst
+Chinese translated version of Documentation/arch/arm64/legacy_instructions.rst
 
 If you have any comment or update to the content, please contact the
 original document maintainer directly.  However, if you have a problem
@@ -13,7 +13,7 @@ Maintainer: Punit Agrawal <punit.agrawal@arm.com>
 Chinese maintainer: Fu Wei <wefu@redhat.com>
 Traditional Chinese maintainer: Hu Haowen <src.res@email.cn>
 ---------------------------------------------------------------------
-Documentation/arm64/legacy_instructions.rst 的中文翻譯
+Documentation/arch/arm64/legacy_instructions.rst 的中文翻譯
 
 如果想評論或更新本文的內容，請直接聯繫原文檔的維護者。如果你使用英文
 交流有困難的話，也可以向中文版維護者求助。如果本翻譯更新不及時或者翻
diff --git a/Documentation/translations/zh_TW/arm64/memory.txt b/Documentation/translations/zh_TW/arch/arm64/memory.txt
similarity index 97%
rename from Documentation/translations/zh_TW/arm64/memory.txt
rename to Documentation/translations/zh_TW/arch/arm64/memory.txt
index 99c2b78b5674..2437380a26d8 100644
--- a/Documentation/translations/zh_TW/arm64/memory.txt
+++ b/Documentation/translations/zh_TW/arch/arm64/memory.txt
@@ -1,6 +1,6 @@
 SPDX-License-Identifier: GPL-2.0
 
-Chinese translated version of Documentation/arm64/memory.rst
+Chinese translated version of Documentation/arch/arm64/memory.rst
 
 If you have any comment or update to the content, please contact the
 original document maintainer directly.  However, if you have a problem
@@ -12,7 +12,7 @@ Maintainer: Catalin Marinas <catalin.marinas@arm.com>
 Chinese maintainer: Fu Wei <wefu@redhat.com>
 Traditional Chinese maintainer: Hu Haowen <src.res@email.cn>
 ---------------------------------------------------------------------
-Documentation/arm64/memory.rst 的中文翻譯
+Documentation/arch/arm64/memory.rst 的中文翻譯
 
 如果想評論或更新本文的內容，請直接聯繫原文檔的維護者。如果你使用英文
 交流有困難的話，也可以向中文版維護者求助。如果本翻譯更新不及時或者翻
diff --git a/Documentation/translations/zh_TW/arm64/perf.rst b/Documentation/translations/zh_TW/arch/arm64/perf.rst
similarity index 96%
rename from Documentation/translations/zh_TW/arm64/perf.rst
rename to Documentation/translations/zh_TW/arch/arm64/perf.rst
index f1ffd55dfe50..3b39997a52eb 100644
--- a/Documentation/translations/zh_TW/arm64/perf.rst
+++ b/Documentation/translations/zh_TW/arch/arm64/perf.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. include:: ../disclaimer-zh_TW.rst
+.. include:: ../../disclaimer-zh_TW.rst
 
-:Original: :ref:`Documentation/arm64/perf.rst <perf_index>`
+:Original: :ref:`Documentation/arch/arm64/perf.rst <perf_index>`
 
 Translator: Bailu Lin <bailu.lin@vivo.com>
             Hu Haowen <src.res@email.cn>
diff --git a/Documentation/translations/zh_TW/arm64/silicon-errata.txt b/Documentation/translations/zh_TW/arch/arm64/silicon-errata.txt
similarity index 97%
rename from Documentation/translations/zh_TW/arm64/silicon-errata.txt
rename to Documentation/translations/zh_TW/arch/arm64/silicon-errata.txt
index bf2077197504..66c3a3506458 100644
--- a/Documentation/translations/zh_TW/arm64/silicon-errata.txt
+++ b/Documentation/translations/zh_TW/arch/arm64/silicon-errata.txt
@@ -1,6 +1,6 @@
 SPDX-License-Identifier: GPL-2.0
 
-Chinese translated version of Documentation/arm64/silicon-errata.rst
+Chinese translated version of Documentation/arch/arm64/silicon-errata.rst
 
 If you have any comment or update to the content, please contact the
 original document maintainer directly.  However, if you have a problem
@@ -13,7 +13,7 @@ zh_CN:	Fu Wei <wefu@redhat.com>
 zh_TW:	Hu Haowen <src.res@email.cn>
 C:	1926e54f115725a9248d0c4c65c22acaf94de4c4
 ---------------------------------------------------------------------
-Documentation/arm64/silicon-errata.rst 的中文翻譯
+Documentation/arch/arm64/silicon-errata.rst 的中文翻譯
 
 如果想評論或更新本文的內容，請直接聯繫原文檔的維護者。如果你使用英文
 交流有困難的話，也可以向中文版維護者求助。如果本翻譯更新不及時或者翻
diff --git a/Documentation/translations/zh_TW/arm64/tagged-pointers.txt b/Documentation/translations/zh_TW/arch/arm64/tagged-pointers.txt
similarity index 95%
rename from Documentation/translations/zh_TW/arm64/tagged-pointers.txt
rename to Documentation/translations/zh_TW/arch/arm64/tagged-pointers.txt
index 87f88628401a..b7f683f20ed1 100644
--- a/Documentation/translations/zh_TW/arm64/tagged-pointers.txt
+++ b/Documentation/translations/zh_TW/arch/arm64/tagged-pointers.txt
@@ -1,6 +1,6 @@
 SPDX-License-Identifier: GPL-2.0
 
-Chinese translated version of Documentation/arm64/tagged-pointers.rst
+Chinese translated version of Documentation/arch/arm64/tagged-pointers.rst
 
 If you have any comment or update to the content, please contact the
 original document maintainer directly.  However, if you have a problem
@@ -12,7 +12,7 @@ Maintainer: Will Deacon <will.deacon@arm.com>
 Chinese maintainer: Fu Wei <wefu@redhat.com>
 Traditional Chinese maintainer: Hu Haowen <src.res@email.cn>
 ---------------------------------------------------------------------
-Documentation/arm64/tagged-pointers.rst 的中文翻譯
+Documentation/arch/arm64/tagged-pointers.rst 的中文翻譯
 
 如果想評論或更新本文的內容，請直接聯繫原文檔的維護者。如果你使用英文
 交流有困難的話，也可以向中文版維護者求助。如果本翻譯更新不及時或者翻
diff --git a/Documentation/translations/zh_TW/index.rst b/Documentation/translations/zh_TW/index.rst
index e97d7d578751..e7c83868e780 100644
--- a/Documentation/translations/zh_TW/index.rst
+++ b/Documentation/translations/zh_TW/index.rst
@@ -150,7 +150,7 @@ TODOList:
 .. toctree::
    :maxdepth: 2
 
-   arm64/index
+   arch/arm64/index
 
 TODOList:
 
diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index add067793b90..96c4475539c2 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -2613,7 +2613,7 @@ follows::
        this vcpu, and determines which register slices are visible through
        this ioctl interface.
 
-(See Documentation/arm64/sve.rst for an explanation of the "vq"
+(See Documentation/arch/arm64/sve.rst for an explanation of the "vq"
 nomenclature.)
 
 KVM_REG_ARM64_SVE_VLS is only accessible after KVM_ARM_VCPU_INIT.
diff --git a/MAINTAINERS b/MAINTAINERS
index f794002a192e..09d5b6b58ebb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3062,7 +3062,7 @@ M:	Will Deacon <will@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
-F:	Documentation/arm64/
+F:	Documentation/arch/arm64/
 F:	arch/arm64/
 F:	tools/testing/selftests/arm64/
 X:	arch/arm64/boot/dts/
-- 
2.40.1

