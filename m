Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15AE3473B07
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 03:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhLNCza (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Dec 2021 21:55:30 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:41839 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbhLNCz1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Dec 2021 21:55:27 -0500
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 1BE2s0bk012823;
        Tue, 14 Dec 2021 11:54:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 1BE2s0bk012823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1639450449;
        bh=XY3Y8BgBvFVYU2BMULL8b3z5Iscv+dC8iPHww02Ieas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IoCc5boAAarw6DfFrrIzXr/Rq+52DhjG3MsYHbiT2OuePfM6eH44BpyUQsoTDEYpg
         /VC8GDyeRCnwuGi5Vks+WCJ0sd/3oheGvedXhihxloTEaqBEbICX31Rv9gREGdiott
         HP4gYj262JOwAp5lzLol1xuKOzrvoSd9Xj+b4ObgKyWPOPN07LIIg1pUVx33hJcoMV
         yb5AizyHBtE0htvPFOqGCi742RcMfXcXZn+qdl3uOsb0zo1ku/mfP5SyvAAbX9smSR
         LlUtum5sCDybyurgCIa410Zry01gIjjv0fPXoKtQDd8wO3KYRnfeNoPqOsf7DiIj9E
         ufu2QDW/d0yTg==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arch@vger.kernel.org, David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Nicolas Schier <n.schier@avm.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 09/11] kbuild: do not quote string values in include/config/auto.conf
Date:   Tue, 14 Dec 2021 11:53:53 +0900
Message-Id: <20211214025355.1267796-10-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211214025355.1267796-1-masahiroy@kernel.org>
References: <20211214025355.1267796-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The previous commit fixed up all shell scripts to not include
include/config/auto.conf.

Now that include/config/auto.conf is only included by Makefiles,
we can change it into a more Make-friendly form.

Previously, Kconfig output string values enclosed with double-quotes
(both in the .config and include/config/auto.conf):

    CONFIG_X="foo bar"

Unlike shell, Make handles double-quotes (and single-quotes as well)
verbatim. We must rip them off when used.

There are some patterns:

  [1] $(patsubst "%",%,$(CONFIG_X))
  [2] $(CONFIG_X:"%"=%)
  [3] $(subst ",,$(CONFIG_X))
  [4] $(shell echo $(CONFIG_X))

These are not only ugly, but also fragile.

[1] and [2] do not work if the value contains spaces, like
   CONFIG_X=" foo bar "

[3] does not work correctly if the value contains double-quotes like
   CONFIG_X="foo\"bar"

[4] seems to work better, but has a cost of forking a process.

Anyway, quoted strings were always PITA for our Makefiles.

This commit changes Kconfig to stop quoting in include/config/auto.conf.

These are the string type symbols referenced in Makefiles or scripts:

    ACPI_CUSTOM_DSDT_FILE
    ARC_BUILTIN_DTB_NAME
    ARC_TUNE_MCPU
    BUILTIN_DTB_SOURCE
    CC_IMPLICIT_FALLTHROUGH
    CC_VERSION_TEXT
    CFG80211_EXTRA_REGDB_KEYDIR
    EXTRA_FIRMWARE
    EXTRA_FIRMWARE_DIR
    EXTRA_TARGETS
    H8300_BUILTIN_DTB
    INITRAMFS_SOURCE
    LOCALVERSION
    MODULE_SIG_HASH
    MODULE_SIG_KEY
    NDS32_BUILTIN_DTB
    NIOS2_DTB_SOURCE
    OPENRISC_BUILTIN_DTB
    SOC_CANAAN_K210_DTB_SOURCE
    SYSTEM_BLACKLIST_HASH_LIST
    SYSTEM_REVOCATION_KEYS
    SYSTEM_TRUSTED_KEYS
    TARGET_CPU
    UNUSED_KSYMS_WHITELIST
    XILINX_MICROBLAZE0_FAMILY
    XILINX_MICROBLAZE0_HW_VER
    XTENSA_VARIANT_NAME

I checked them one by one, and fixed up the code where necessary.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v1)

 Makefile                                      |  4 ++--
 arch/arc/Makefile                             |  4 ++--
 arch/arc/boot/dts/Makefile                    |  4 ++--
 arch/h8300/boot/dts/Makefile                  |  6 +-----
 arch/microblaze/Makefile                      |  2 +-
 arch/nds32/boot/dts/Makefile                  |  7 +------
 arch/nios2/boot/dts/Makefile                  |  2 +-
 arch/openrisc/boot/dts/Makefile               |  7 +------
 arch/powerpc/boot/Makefile                    |  2 +-
 arch/riscv/boot/dts/canaan/Makefile           |  4 +---
 arch/sh/boot/dts/Makefile                     |  4 +---
 arch/xtensa/Makefile                          |  2 +-
 arch/xtensa/boot/dts/Makefile                 |  5 +----
 certs/Makefile                                | 10 ++--------
 drivers/acpi/Makefile                         |  2 +-
 drivers/base/firmware_loader/builtin/Makefile |  4 ++--
 init/Makefile                                 |  2 +-
 net/wireless/Makefile                         |  4 ++--
 scripts/Makefile.modinst                      |  1 -
 scripts/gen_autoksyms.sh                      |  2 +-
 scripts/kconfig/confdata.c                    |  2 +-
 scripts/setlocalversion                       |  2 +-
 usr/Makefile                                  |  2 +-
 23 files changed, 28 insertions(+), 56 deletions(-)

diff --git a/Makefile b/Makefile
index 4e8ac0730f51..aa4e5dc12049 100644
--- a/Makefile
+++ b/Makefile
@@ -1729,9 +1729,9 @@ PHONY += prepare
 # now expand this into a simple variable to reduce the cost of shell evaluations
 prepare: CC_VERSION_TEXT := $(CC_VERSION_TEXT)
 prepare:
-	@if [ "$(CC_VERSION_TEXT)" != $(CONFIG_CC_VERSION_TEXT) ]; then \
+	@if [ "$(CC_VERSION_TEXT)" != "$(CONFIG_CC_VERSION_TEXT)" ]; then \
 		echo >&2 "warning: the compiler differs from the one used to build the kernel"; \
-		echo >&2 "  The kernel was built by: "$(CONFIG_CC_VERSION_TEXT); \
+		echo >&2 "  The kernel was built by: $(CONFIG_CC_VERSION_TEXT)"; \
 		echo >&2 "  You are using:           $(CC_VERSION_TEXT)"; \
 	fi
 
diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index f252e7b924e9..efc54f3e35e0 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -14,10 +14,10 @@ cflags-y	+= -fno-common -pipe -fno-builtin -mmedium-calls -D__linux__
 tune-mcpu-def-$(CONFIG_ISA_ARCOMPACT)	:= -mcpu=arc700
 tune-mcpu-def-$(CONFIG_ISA_ARCV2)	:= -mcpu=hs38
 
-ifeq ($(CONFIG_ARC_TUNE_MCPU),"")
+ifeq ($(CONFIG_ARC_TUNE_MCPU),)
 cflags-y				+= $(tune-mcpu-def-y)
 else
-tune-mcpu				:= $(shell echo $(CONFIG_ARC_TUNE_MCPU))
+tune-mcpu				:= $(CONFIG_ARC_TUNE_MCPU)
 ifneq ($(call cc-option,$(tune-mcpu)),)
 cflags-y				+= $(tune-mcpu)
 else
diff --git a/arch/arc/boot/dts/Makefile b/arch/arc/boot/dts/Makefile
index 8483a86c743d..4237aa5de3a3 100644
--- a/arch/arc/boot/dts/Makefile
+++ b/arch/arc/boot/dts/Makefile
@@ -2,8 +2,8 @@
 # Built-in dtb
 builtindtb-y		:= nsim_700
 
-ifneq ($(CONFIG_ARC_BUILTIN_DTB_NAME),"")
-	builtindtb-y	:= $(patsubst "%",%,$(CONFIG_ARC_BUILTIN_DTB_NAME))
+ifneq ($(CONFIG_ARC_BUILTIN_DTB_NAME),)
+	builtindtb-y	:= $(CONFIG_ARC_BUILTIN_DTB_NAME)
 endif
 
 obj-y   += $(builtindtb-y).dtb.o
diff --git a/arch/h8300/boot/dts/Makefile b/arch/h8300/boot/dts/Makefile
index 69fcd817892c..c36bbd1f2592 100644
--- a/arch/h8300/boot/dts/Makefile
+++ b/arch/h8300/boot/dts/Makefile
@@ -1,9 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-ifneq '$(CONFIG_H8300_BUILTIN_DTB)' '""'
-BUILTIN_DTB := $(patsubst "%",%,$(CONFIG_H8300_BUILTIN_DTB)).dtb.o
-endif
-
-obj-y += $(BUILTIN_DTB)
+obj-y += $(addsuffix .dtb.o, $(CONFIG_H8300_BUILTIN_DTB))
 
 dtb-$(CONFIG_H8300H_SIM) := h8300h_sim.dtb
 dtb-$(CONFIG_H8S_SIM) := h8s_sim.dtb
diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
index e775a696aa6f..a25e76d89e86 100644
--- a/arch/microblaze/Makefile
+++ b/arch/microblaze/Makefile
@@ -5,7 +5,7 @@ UTS_SYSNAME = -DUTS_SYSNAME=\"Linux\"
 
 # What CPU version are we building for, and crack it open
 # as major.minor.rev
-CPU_VER   := $(shell echo $(CONFIG_XILINX_MICROBLAZE0_HW_VER))
+CPU_VER   := $(CONFIG_XILINX_MICROBLAZE0_HW_VER)
 CPU_MAJOR := $(shell echo $(CPU_VER) | cut -d '.' -f 1)
 CPU_MINOR := $(shell echo $(CPU_VER) | cut -d '.' -f 2)
 CPU_REV   := $(shell echo $(CPU_VER) | cut -d '.' -f 3)
diff --git a/arch/nds32/boot/dts/Makefile b/arch/nds32/boot/dts/Makefile
index f84bd529b6fd..4fc69562eae8 100644
--- a/arch/nds32/boot/dts/Makefile
+++ b/arch/nds32/boot/dts/Makefile
@@ -1,7 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ifneq '$(CONFIG_NDS32_BUILTIN_DTB)' '""'
-BUILTIN_DTB := $(patsubst "%",%,$(CONFIG_NDS32_BUILTIN_DTB)).dtb.o
-else
-BUILTIN_DTB :=
-endif
-obj-$(CONFIG_OF) += $(BUILTIN_DTB)
+obj-$(CONFIG_OF) += $(addsuffix .dtb.o, $(CONFIG_NDS32_BUILTIN_DTB))
diff --git a/arch/nios2/boot/dts/Makefile b/arch/nios2/boot/dts/Makefile
index a91a0b09be63..e9e31bb40df8 100644
--- a/arch/nios2/boot/dts/Makefile
+++ b/arch/nios2/boot/dts/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y := $(patsubst "%.dts",%.dtb.o,$(CONFIG_NIOS2_DTB_SOURCE))
+obj-y := $(patsubst %.dts,%.dtb.o,$(CONFIG_NIOS2_DTB_SOURCE))
 
 dtstree		:= $(srctree)/$(src)
 dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
diff --git a/arch/openrisc/boot/dts/Makefile b/arch/openrisc/boot/dts/Makefile
index 17dd791a833f..13db5a2aab52 100644
--- a/arch/openrisc/boot/dts/Makefile
+++ b/arch/openrisc/boot/dts/Makefile
@@ -1,9 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-ifneq '$(CONFIG_OPENRISC_BUILTIN_DTB)' '""'
-BUILTIN_DTB := $(patsubst "%",%,$(CONFIG_OPENRISC_BUILTIN_DTB)).dtb.o
-else
-BUILTIN_DTB :=
-endif
-obj-y += $(BUILTIN_DTB)
+obj-y += $(addsuffix .dtb.o, $(CONFIG_OPENRISC_BUILTIN_DTB))
 
 #DTC_FLAGS ?= -p 1024
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 9993c6256ad2..4b4827c475c6 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -365,7 +365,7 @@ image-$(CONFIG_PPC_PMAC)	+= zImage.coff zImage.miboot
 endif
 
 # Allow extra targets to be added to the defconfig
-image-y	+= $(subst ",,$(CONFIG_EXTRA_TARGETS))
+image-y	+= $(CONFIG_EXTRA_TARGETS)
 
 initrd-  := $(patsubst zImage%, zImage.initrd%, $(image-))
 initrd-y := $(patsubst zImage%, zImage.initrd%, \
diff --git a/arch/riscv/boot/dts/canaan/Makefile b/arch/riscv/boot/dts/canaan/Makefile
index 9ee7156c0c31..c61b08ac8554 100644
--- a/arch/riscv/boot/dts/canaan/Makefile
+++ b/arch/riscv/boot/dts/canaan/Makefile
@@ -1,5 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
-ifneq ($(CONFIG_SOC_CANAAN_K210_DTB_SOURCE),"")
-dtb-y += $(strip $(shell echo $(CONFIG_SOC_CANAAN_K210_DTB_SOURCE))).dtb
+dtb-$(CONFIG_SOC_CANAAN_K210_DTB_BUILTIN) += $(addsuffix .dtb, $(CONFIG_SOC_CANAAN_K210_DTB_SOURCE))
 obj-$(CONFIG_SOC_CANAAN_K210_DTB_BUILTIN) += $(addsuffix .o, $(dtb-y))
-endif
diff --git a/arch/sh/boot/dts/Makefile b/arch/sh/boot/dts/Makefile
index c17d65b82abe..4a6dec9714a9 100644
--- a/arch/sh/boot/dts/Makefile
+++ b/arch/sh/boot/dts/Makefile
@@ -1,4 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ifneq ($(CONFIG_BUILTIN_DTB_SOURCE),"")
-obj-$(CONFIG_USE_BUILTIN_DTB) += $(patsubst "%",%,$(CONFIG_BUILTIN_DTB_SOURCE)).dtb.o
-endif
+obj-$(CONFIG_USE_BUILTIN_DTB) += $(addsuffix .dtb.o, $(CONFIG_BUILTIN_DTB_SOURCE))
diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
index 9778216d6e09..ee2769519eaf 100644
--- a/arch/xtensa/Makefile
+++ b/arch/xtensa/Makefile
@@ -12,7 +12,7 @@
 # Core configuration.
 # (Use VAR=<xtensa_config> to use another default compiler.)
 
-variant-y := $(patsubst "%",%,$(CONFIG_XTENSA_VARIANT_NAME))
+variant-y := $(CONFIG_XTENSA_VARIANT_NAME)
 
 VARIANT = $(variant-y)
 
diff --git a/arch/xtensa/boot/dts/Makefile b/arch/xtensa/boot/dts/Makefile
index 0b8d00cdae7c..720628c0d8b9 100644
--- a/arch/xtensa/boot/dts/Makefile
+++ b/arch/xtensa/boot/dts/Makefile
@@ -7,10 +7,7 @@
 #
 #
 
-BUILTIN_DTB_SOURCE := $(patsubst "%",%,$(CONFIG_BUILTIN_DTB_SOURCE)).dtb.o
-ifneq ($(CONFIG_BUILTIN_DTB_SOURCE),"")
-obj-$(CONFIG_OF) += $(BUILTIN_DTB_SOURCE)
-endif
+obj-$(CONFIG_OF) += $(addsuffix .dtb.o, $(CONFIG_BUILTIN_DTB_SOURCE))
 
 # for CONFIG_OF_ALL_DTBS test
 dtstree	:= $(srctree)/$(src)
diff --git a/certs/Makefile b/certs/Makefile
index 69c1404152ef..7b48445d71f6 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -6,7 +6,7 @@
 obj-$(CONFIG_SYSTEM_TRUSTED_KEYRING) += system_keyring.o system_certificates.o common.o
 obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist.o common.o
 obj-$(CONFIG_SYSTEM_REVOCATION_LIST) += revocation_certificates.o
-ifneq ($(CONFIG_SYSTEM_BLACKLIST_HASH_LIST),"")
+ifneq ($(CONFIG_SYSTEM_BLACKLIST_HASH_LIST),)
 obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_hashes.o
 else
 obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_nohashes.o
@@ -17,8 +17,6 @@ quiet_cmd_extract_certs  = CERT    $@
 
 $(obj)/system_certificates.o: $(obj)/x509_certificate_list
 
-CONFIG_SYSTEM_TRUSTED_KEYS := $(CONFIG_SYSTEM_TRUSTED_KEYS:"%"=%)
-
 $(obj)/x509_certificate_list: $(CONFIG_SYSTEM_TRUSTED_KEYS) scripts/extract-cert FORCE
 	$(call if_changed,extract_certs,$(if $(CONFIG_SYSTEM_TRUSTED_KEYS),$<,""))
 
@@ -46,7 +44,7 @@ ifdef SIGN_KEY
 # We do it this way rather than having a boolean option for enabling an
 # external private key, because 'make randconfig' might enable such a
 # boolean option and we unfortunately can't make it depend on !RANDCONFIG.
-ifeq ($(CONFIG_MODULE_SIG_KEY),"certs/signing_key.pem")
+ifeq ($(CONFIG_MODULE_SIG_KEY),certs/signing_key.pem)
 
 keytype-$(CONFIG_MODULE_SIG_KEY_TYPE_ECDSA) := -newkey ec -pkeyopt ec_paramgen_curve:secp384r1
 
@@ -69,8 +67,6 @@ $(obj)/x509.genkey:
 
 endif # CONFIG_MODULE_SIG_KEY
 
-CONFIG_MODULE_SIG_KEY := $(CONFIG_MODULE_SIG_KEY:"%"=%)
-
 # If CONFIG_MODULE_SIG_KEY isn't a PKCS#11 URI, depend on it
 ifneq ($(filter-out pkcs11:%, %(CONFIG_MODULE_SIG_KEY)),)
 X509_DEP := $(CONFIG_MODULE_SIG_KEY)
@@ -86,8 +82,6 @@ targets += signing_key.x509
 
 $(obj)/revocation_certificates.o: $(obj)/x509_revocation_list
 
-CONFIG_SYSTEM_REVOCATION_KEYS := $(CONFIG_SYSTEM_REVOCATION_KEYS:"%"=%)
-
 $(obj)/x509_revocation_list: $(CONFIG_SYSTEM_REVOCATION_KEYS) scripts/extract-cert FORCE
 	$(call if_changed,extract_certs,$(if $(CONFIG_SYSTEM_REVOCATION_KEYS),$<,""))
 
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 3018714e87d9..da0cdd1e9380 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -9,7 +9,7 @@ ccflags-$(CONFIG_ACPI_DEBUG)	+= -DACPI_DEBUG_OUTPUT
 # ACPI Boot-Time Table Parsing
 #
 ifeq ($(CONFIG_ACPI_CUSTOM_DSDT),y)
-tables.o: $(src)/../../include/$(subst $\",,$(CONFIG_ACPI_CUSTOM_DSDT_FILE)) ;
+tables.o: $(src)/../../include/$(CONFIG_ACPI_CUSTOM_DSDT_FILE) ;
 
 endif
 
diff --git a/drivers/base/firmware_loader/builtin/Makefile b/drivers/base/firmware_loader/builtin/Makefile
index eb4be452062a..6c067dedc01e 100644
--- a/drivers/base/firmware_loader/builtin/Makefile
+++ b/drivers/base/firmware_loader/builtin/Makefile
@@ -3,10 +3,10 @@ obj-y  += main.o
 
 # Create $(fwdir) from $(CONFIG_EXTRA_FIRMWARE_DIR) -- if it doesn't have a
 # leading /, it's relative to $(srctree).
-fwdir := $(subst $(quote),,$(CONFIG_EXTRA_FIRMWARE_DIR))
+fwdir := $(CONFIG_EXTRA_FIRMWARE_DIR)
 fwdir := $(addprefix $(srctree)/,$(filter-out /%,$(fwdir)))$(filter /%,$(fwdir))
 
-firmware  := $(addsuffix .gen.o, $(subst $(quote),,$(CONFIG_EXTRA_FIRMWARE)))
+firmware  := $(addsuffix .gen.o, $(CONFIG_EXTRA_FIRMWARE))
 obj-y += $(firmware)
 
 FWNAME    = $(patsubst $(obj)/%.gen.S,%,$@)
diff --git a/init/Makefile b/init/Makefile
index 04eeee12c076..06326e304384 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -31,7 +31,7 @@ quiet_cmd_compile.h = CHK     $@
       cmd_compile.h = \
 	$(CONFIG_SHELL) $(srctree)/scripts/mkcompile_h $@	\
 	"$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CONFIG_PREEMPT_BUILD)"	\
-	"$(CONFIG_PREEMPT_RT)" $(CONFIG_CC_VERSION_TEXT) "$(LD)"
+	"$(CONFIG_PREEMPT_RT)" "$(CONFIG_CC_VERSION_TEXT)" "$(LD)"
 
 include/generated/compile.h: FORCE
 	$(call cmd,compile.h)
diff --git a/net/wireless/Makefile b/net/wireless/Makefile
index 756e7de7e33f..1e9be50469ce 100644
--- a/net/wireless/Makefile
+++ b/net/wireless/Makefile
@@ -33,8 +33,8 @@ $(obj)/shipped-certs.c: $(wildcard $(srctree)/$(src)/certs/*.hex)
 	  echo 'unsigned int shipped_regdb_certs_len = sizeof(shipped_regdb_certs);'; \
 	 ) > $@
 
-$(obj)/extra-certs.c: $(CONFIG_CFG80211_EXTRA_REGDB_KEYDIR:"%"=%) \
-		      $(wildcard $(CONFIG_CFG80211_EXTRA_REGDB_KEYDIR:"%"=%)/*.x509)
+$(obj)/extra-certs.c: $(CONFIG_CFG80211_EXTRA_REGDB_KEYDI) \
+		      $(wildcard $(CONFIG_CFG80211_EXTRA_REGDB_KEYDIR)/*.x509)
 	@$(kecho) "  GEN     $@"
 	$(Q)(set -e; \
 	  allf=""; \
diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index df7e3d578ef5..c2c43a0ecfe0 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -66,7 +66,6 @@ endif
 # Don't stop modules_install even if we can't sign external modules.
 #
 ifeq ($(CONFIG_MODULE_SIG_ALL),y)
-CONFIG_MODULE_SIG_KEY := $(CONFIG_MODULE_SIG_KEY:"%"=%)
 sig-key := $(if $(wildcard $(CONFIG_MODULE_SIG_KEY)),,$(srctree)/)$(CONFIG_MODULE_SIG_KEY)
 quiet_cmd_sign = SIGN    $@
       cmd_sign = scripts/sign-file $(CONFIG_MODULE_SIG_HASH) $(sig-key) certs/signing_key.x509 $@ \
diff --git a/scripts/gen_autoksyms.sh b/scripts/gen_autoksyms.sh
index 949d6a054034..120225c541c5 100755
--- a/scripts/gen_autoksyms.sh
+++ b/scripts/gen_autoksyms.sh
@@ -23,7 +23,7 @@ if grep -q "^CONFIG_MODVERSIONS=y$" include/config/auto.conf; then
 	needed_symbols="$needed_symbols module_layout"
 fi
 
-ksym_wl=$(sed -n 's/^CONFIG_UNUSED_KSYMS_WHITELIST="\(.*\)"$/\1/p' include/config/auto.conf)
+ksym_wl=$(sed -n 's/^CONFIG_UNUSED_KSYMS_WHITELIST=\(.*\)$/\1/p' include/config/auto.conf)
 if [ -n "$ksym_wl" ]; then
 	[ "${ksym_wl}" != "${ksym_wl#/}" ] || ksym_wl="$abs_srctree/$ksym_wl"
 	if [ ! -f "$ksym_wl" ] || [ ! -r "$ksym_wl" ]; then
diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 42bc56ee238c..35a723a2a4c2 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -700,7 +700,7 @@ static void print_symbol_for_dotconfig(FILE *fp, struct symbol *sym)
 
 static void print_symbol_for_autoconf(FILE *fp, struct symbol *sym)
 {
-	__print_symbol(fp, sym, OUTPUT_N_NONE, true);
+	__print_symbol(fp, sym, OUTPUT_N_NONE, false);
 }
 
 void print_symbol_for_listconfig(struct symbol *sym)
diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index d06137405190..af4754a35e66 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -123,7 +123,7 @@ if test ! "$srctree" -ef .; then
 fi
 
 # CONFIG_LOCALVERSION and LOCALVERSION (if set)
-config_localversion=$(sed -n 's/^CONFIG_LOCALVERSION="\(.*\)"$/\1/p' include/config/auto.conf)
+config_localversion=$(sed -n 's/^CONFIG_LOCALVERSION=\(.*\)$/\1/p' include/config/auto.conf)
 res="${res}${config_localversion}${LOCALVERSION}"
 
 # scm version string if not at a tagged commit
diff --git a/usr/Makefile b/usr/Makefile
index b1a81a40eab1..7374873a539f 100644
--- a/usr/Makefile
+++ b/usr/Makefile
@@ -21,7 +21,7 @@ obj-$(CONFIG_BLK_DEV_INITRD) := initramfs_data.o
 
 $(obj)/initramfs_data.o: $(obj)/initramfs_inc_data
 
-ramfs-input := $(strip $(shell echo $(CONFIG_INITRAMFS_SOURCE)))
+ramfs-input := $(CONFIG_INITRAMFS_SOURCE)
 cpio-data :=
 
 # If CONFIG_INITRAMFS_SOURCE is empty, generate a small initramfs with the
-- 
2.32.0

