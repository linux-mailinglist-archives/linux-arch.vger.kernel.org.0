Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8803DCD9D
	for <lists+linux-arch@lfdr.de>; Sun,  1 Aug 2021 22:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhHAUOC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 1 Aug 2021 16:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhHAUOA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 1 Aug 2021 16:14:00 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA68C0613D3;
        Sun,  1 Aug 2021 13:13:51 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d8so18903458wrm.4;
        Sun, 01 Aug 2021 13:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y5V2ffKUzqvkYOzowlXH3qjSSRgwVh6vwn1blwwnC/c=;
        b=FB8DmjZBvUIMqv+1VnLNIPBUzvFF+NWkM0A/Y6naI0T7q2Uczq0aC5KuLNr1jYbyAH
         +Ap5/nh1KQ8MuBLvUeuP+RSE5+B0KAsaerelp2dkMI7DtxreR0y1vef7Wzed2mlP4ZDT
         /U9W65ypxUf8S+gr+e+1zxEfHvLrmMWLN75gZWTxyjSMH1ImhBwBp6DG47UYdCxoqlIA
         d1/KBYi789elx9ey0VEe0ddWnY04wcDUUaYr3iaWOPFrlbE05Vh9de711ILRyWzGN45/
         OQRP6nA03g6w5Cm/h47wq+fMgaM09NIfIPMh1gmf1ybVpRBs5zSihNmPISgOa2icxtIB
         PVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y5V2ffKUzqvkYOzowlXH3qjSSRgwVh6vwn1blwwnC/c=;
        b=fXbWIsaNcePGOxRpzte3W74Mv8wQvFxJo+4jiGeeSVkYlNqiHjv5pGIneb/aj1vBEJ
         efE/ZKTeuw7k/kq/6Y6xrvj1gQlCSH7wMnyn7YluV8niq2R8teA+fe6AZStMvqspV6U2
         k+SwcOWIaMsEiAZqrQc297iFSwcPUAyo0RsNAPiH7BAQOpxYvEFgLktaHsZRO4StystB
         cC86b+kkaL+mVBa8vWOaJNtJDvyQIesZfhIMZXnQ5Vq8/JzBoYcH9vkH804jJV++k5cu
         QlZpspsCKwr30rkU14BHNp/bw1q0VBREVyjP3jfRHft1ey/VQX+9TgqUudmJSZIIaxvM
         Tn9A==
X-Gm-Message-State: AOAM533IGK098yt8YM2A/t7NCZDiBgbx61XL7etsyk6avK4ZesyKQyWL
        hLw5iW3gVGNGJ8iTxgP+fw==
X-Google-Smtp-Source: ABdhPJzj1BljtSHul6mu29RDIgfv1J77njpc4bQwhxJsOyPB264FDzkfE3Ni/QQP7GCCMOd5jQQUCg==
X-Received: by 2002:adf:f384:: with SMTP id m4mr13658663wro.129.1627848829999;
        Sun, 01 Aug 2021 13:13:49 -0700 (PDT)
Received: from localhost.localdomain ([46.53.252.172])
        by smtp.gmail.com with ESMTPSA id k6sm8738686wrm.10.2021.08.01.13.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 13:13:49 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        masahiroy@kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] isystem: delete global -isystem compile option
Date:   Sun,  1 Aug 2021 23:13:36 +0300
Message-Id: <20210801201336.2224111-3-adobriyan@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210801201336.2224111-1-adobriyan@gmail.com>
References: <20210801201336.2224111-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In theory, it enables "leakage" of userspace headers into kernel which
may present licensing problem.

In practice, only stdarg.h was used, stdbool.h is trivial and SIMD
intrinsics are contained to a few architectures and aren't global
problem.

In general, kernel is very self contained code and -isystem removal
will further isolate it from Ring Threeland influence.

nds32 keeps -isystem globally due to intrisics used in entrenched header.

-isystem is selectively reenabled for some files.

Not compile tested on hexagon.

Compile tested on:

alpha-allmodconfig alpha-allnoconfig alpha-defconfig arm64-allmodconfig
arm64-allnoconfig arm64-defconfig arm-am200epdkit arm-aspeed_g4
arm-aspeed_g5 arm-assabet arm-at91_dt arm-axm55xx arm-badge4 arm-bcm2835
arm-cerfcube arm-clps711x arm-cm_x300 arm-cns3420vb arm-colibri_pxa270
arm-colibri_pxa300 arm-collie arm-corgi arm-davinci_all arm-dove
arm-ep93xx arm-eseries_pxa arm-exynos arm-ezx arm-footbridge arm-gemini
arm-h3600 arm-h5000 arm-hackkit arm-hisi arm-imote2 arm-imx_v4_v5
arm-imx_v6_v7 arm-integrator arm-iop32x arm-ixp4xx arm-jornada720
arm-keystone arm-lart arm-lpc18xx arm-lpc32xx arm-lpd270 arm-lubbock
arm-magician arm-mainstone arm-milbeaut_m10v arm-mini2440 arm-mmp2
arm-moxart arm-mps2 arm-multi_v4t arm-multi_v5 arm-multi_v7 arm-mv78xx0
arm-mvebu_v5 arm-mvebu_v7 arm-mxs arm-neponset arm-netwinder arm-nhk8815
arm-omap1 arm-omap2plus arm-orion5x arm-oxnas_v6 arm-palmz72 arm-pcm027
arm-pleb arm-pxa arm-pxa168 arm-pxa255-idp arm-pxa3xx arm-pxa910
arm-qcom arm-realview arm-rpc arm-s3c2410 arm-s3c6400 arm-s5pv210
arm-sama5 arm-shannon arm-shmobile arm-simpad arm-socfpga arm-spear13xx
arm-spear3xx arm-spear6xx arm-spitz arm-stm32 arm-sunxi arm-tct_hammer
arm-tegra arm-trizeps4 arm-u8500 arm-versatile arm-vexpress arm-vf610m4
arm-viper arm-vt8500_v6_v7 arm-xcep arm-zeus csky-allmodconfig
csky-allnoconfig csky-defconfig h8300-edosk2674 h8300-h8300h-sim
h8300-h8s-sim i386-allmodconfig i386-allnoconfig i386-defconfig
ia64-allmodconfig ia64-allnoconfig ia64-bigsur ia64-generic ia64-gensparse
ia64-tiger ia64-zx1 m68k-amcore m68k-amiga m68k-apollo m68k-atari
m68k-bvme6000 m68k-hp300 m68k-m5208evb m68k-m5249evb m68k-m5272c3
m68k-m5275evb m68k-m5307c3 m68k-m5407c3 m68k-m5475evb m68k-mac
m68k-multi m68k-mvme147 m68k-mvme16x m68k-q40 m68k-stmark2 m68k-sun3
m68k-sun3x microblaze-allmodconfig microblaze-allnoconfig microblaze-mmu
mips-ar7 mips-ath25 mips-ath79 mips-bcm47xx mips-bcm63xx mips-bigsur
mips-bmips_be mips-bmips_stb mips-capcella mips-cavium_octeon mips-ci20
mips-cobalt mips-cu1000-neo mips-cu1830-neo mips-db1xxx mips-decstation
mips-decstation_64 mips-decstation_r4k mips-e55 mips-fuloong2e
mips-gcw0 mips-generic mips-gpr mips-ip22 mips-ip27 mips-ip28 mips-ip32
mips-jazz mips-jmr3927 mips-lemote2f mips-loongson1b mips-loongson1c
mips-loongson2k mips-loongson3 mips-malta mips-maltaaprp mips-malta_kvm
mips-malta_qemu_32r6 mips-maltasmvp mips-maltasmvp_eva mips-maltaup
mips-maltaup_xpa mips-mpc30x mips-mtx1 mips-nlm_xlp mips-nlm_xlr
mips-omega2p mips-pic32mzda mips-pistachio mips-qi_lb60 mips-rb532
mips-rbtx49xx mips-rm200 mips-rs90 mips-rt305x mips-sb1250_swarm
mips-tb0219 mips-tb0226 mips-tb0287 mips-vocore2 mips-workpad mips-xway
nds32-allmodconfig nds32-allnoconfig nds32-defconfig nios2-10m50
nios2-3c120 nios2-allmodconfig nios2-allnoconfig openrisc-allmodconfig
openrisc-allnoconfig openrisc-or1klitex openrisc-or1ksim
openrisc-simple_smp parisc-allnoconfig parisc-generic-32bit
parisc-generic-64bit powerpc-acadia powerpc-adder875 powerpc-akebono
powerpc-amigaone powerpc-arches powerpc-asp8347 powerpc-bamboo
powerpc-bluestone powerpc-canyonlands powerpc-cell powerpc-chrp32
powerpc-cm5200 powerpc-currituck powerpc-ebony powerpc-eiger
powerpc-ep8248e powerpc-ep88xc powerpc-fsp2 powerpc-g5 powerpc-gamecube
powerpc-ge_imp3a powerpc-holly powerpc-icon powerpc-iss476-smp
powerpc-katmai powerpc-kilauea powerpc-klondike powerpc-kmeter1
powerpc-ksi8560 powerpc-linkstation powerpc-lite5200b powerpc-makalu
powerpc-maple powerpc-mgcoge powerpc-microwatt powerpc-motionpro
powerpc-mpc512x powerpc-mpc5200 powerpc-mpc7448_hpc2 powerpc-mpc8272_ads
powerpc-mpc8313_rdb powerpc-mpc8315_rdb powerpc-mpc832x_mds
powerpc-mpc832x_rdb powerpc-mpc834x_itx powerpc-mpc834x_itxgp
powerpc-mpc834x_mds powerpc-mpc836x_mds powerpc-mpc836x_rdk
powerpc-mpc837x_mds powerpc-mpc837x_rdb powerpc-mpc83xx
powerpc-mpc8540_ads powerpc-mpc8560_ads powerpc-mpc85xx_cds
powerpc-mpc866_ads powerpc-mpc885_ads powerpc-mvme5100 powerpc-obs600
powerpc-pasemi powerpc-pcm030 powerpc-pmac32 powerpc-powernv
powerpc-ppa8548 powerpc-ppc40x powerpc-ppc44x powerpc-ppc64
powerpc-ppc64e powerpc-ppc6xx powerpc-pq2fads powerpc-ps3
powerpc-pseries powerpc-rainier powerpc-redwood powerpc-sam440ep
powerpc-sbc8548 powerpc-sequoia powerpc-skiroot powerpc-socrates
powerpc-storcenter powerpc-stx_gp3 powerpc-taishan powerpc-tqm5200
powerpc-tqm8540 powerpc-tqm8541 powerpc-tqm8548 powerpc-tqm8555
powerpc-tqm8560 powerpc-tqm8xx powerpc-walnut powerpc-warp powerpc-wii
powerpc-xes_mpc85xx riscv-allmodconfig riscv-allnoconfig riscv-nommu_k210
riscv-nommu_k210_sdcard riscv-nommu_virt riscv-rv32 s390-allmodconfig
s390-allnoconfig s390-debug s390-zfcpdump sh-ap325rxa sh-apsh4a3a
sh-apsh4ad0a sh-dreamcast sh-ecovec24 sh-ecovec24-romimage sh-edosk7705
sh-edosk7760 sh-espt sh-hp6xx sh-j2 sh-kfr2r09 sh-kfr2r09-romimage
sh-landisk sh-lboxre2 sh-magicpanelr2 sh-microdev sh-migor sh-polaris
sh-r7780mp sh-r7785rp sh-rsk7201 sh-rsk7203 sh-rsk7264 sh-rsk7269
sh-rts7751r2d1 sh-rts7751r2dplus sh-sdk7780 sh-sdk7786 sh-se7206 sh-se7343
sh-se7619 sh-se7705 sh-se7712 sh-se7721 sh-se7722 sh-se7724 sh-se7750
sh-se7751 sh-se7780 sh-secureedge5410 sh-sh03 sh-sh2007 sh-sh7710voipgw
sh-sh7724_generic sh-sh7757lcr sh-sh7763rdp sh-sh7770_generic sh-sh7785lcr
sh-sh7785lcr_32bit sh-shmin sh-shx3 sh-titan sh-ul2 sh-urquell
sparc-allmodconfig sparc-allnoconfig sparc-sparc32 sparc-sparc64
um-i386-allmodconfig um-i386-allnoconfig um-i386-defconfig
um-x86_64-allmodconfig um-x86_64-allnoconfig x86_64-allmodconfig
x86_64-allnoconfig x86_64-defconfig xtensa-allmodconfig xtensa-allnoconfig
xtensa-audio_kc705 xtensa-cadence_csp xtensa-common xtensa-generic_kc705
xtensa-iss xtensa-nommu_kc705 xtensa-smp_lx200 xtensa-virt
xtensa-xip_kc705

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 Makefile                  | 2 +-
 arch/arm64/lib/Makefile   | 2 ++
 arch/nds32/Makefile       | 2 ++
 arch/powerpc/lib/Makefile | 2 ++
 crypto/Makefile           | 2 ++
 lib/raid6/Makefile        | 4 ++++
 6 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 6b555f64df06..b59053ec457a 100644
--- a/Makefile
+++ b/Makefile
@@ -979,7 +979,7 @@ KBUILD_CFLAGS += -falign-functions=64
 endif
 
 # arch Makefile may override CC so keep this after arch Makefile is included
-NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
+NOSTDINC_FLAGS += -nostdinc
 
 # warn about C99 declaration after statement
 KBUILD_CFLAGS += -Wdeclaration-after-statement
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 6dd56a49790a..dcad998f12d7 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -9,6 +9,8 @@ ifeq ($(CONFIG_KERNEL_MODE_NEON), y)
 obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
 CFLAGS_REMOVE_xor-neon.o	+= -mgeneral-regs-only
 CFLAGS_xor-neon.o		+= -ffreestanding
+# Enable <arm_neon.h>
+CFLAGS_xor-neon.o		+= -isystem $(shell $(CC) -print-file-name=include)
 endif
 
 lib-$(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) += uaccess_flushcache.o
diff --git a/arch/nds32/Makefile b/arch/nds32/Makefile
index ccdca7142020..c17fc3a755c3 100644
--- a/arch/nds32/Makefile
+++ b/arch/nds32/Makefile
@@ -9,6 +9,8 @@ endif
 # Avoid generating FPU instructions
 arch-y  += -mno-ext-fpu-sp -mno-ext-fpu-dp -mfloat-abi=soft
 
+# Enable <nds32_intrinsic.h>
+KBUILD_CFLAGS	+= -isystem $(shell $(CC) -print-file-name=include)
 KBUILD_CFLAGS	+= $(call cc-option, -mno-sched-prolog-epilog)
 KBUILD_CFLAGS	+= -mcmodel=large
 
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 99a7c9132422..9e5d0f413b71 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -65,5 +65,7 @@ obj-$(CONFIG_FTR_FIXUP_SELFTEST) += feature-fixups-test.o
 
 obj-$(CONFIG_ALTIVEC)	+= xor_vmx.o xor_vmx_glue.o
 CFLAGS_xor_vmx.o += -maltivec $(call cc-option,-mabi=altivec)
+# Enable <altivec.h>
+CFLAGS_xor_vmx.o += -isystem $(shell $(CC) -print-file-name=include)
 
 obj-$(CONFIG_PPC64) += $(obj64-y)
diff --git a/crypto/Makefile b/crypto/Makefile
index 10526d4559b8..75ad9b040506 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -117,6 +117,8 @@ aegis128-cflags-$(CONFIG_CC_IS_GCC) += -ffixed-q16 -ffixed-q17 -ffixed-q18 \
 				       -ffixed-q28 -ffixed-q29 -ffixed-q30 \
 				       -ffixed-q31
 CFLAGS_aegis128-neon-inner.o += $(aegis128-cflags-y)
+# Enable <arm_neon.h>
+CFLAGS_aegis128-neon-inner.o += -isystem $(shell $(CC) -print-file-name=include)
 CFLAGS_REMOVE_aegis128-neon-inner.o += -mgeneral-regs-only
 aegis128-$(CONFIG_CRYPTO_AEGIS128_SIMD) += aegis128-neon.o aegis128-neon-inner.o
 endif
diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
index c770570bfe4f..45e17619422b 100644
--- a/lib/raid6/Makefile
+++ b/lib/raid6/Makefile
@@ -14,6 +14,8 @@ hostprogs	+= mktables
 
 ifeq ($(CONFIG_ALTIVEC),y)
 altivec_flags := -maltivec $(call cc-option,-mabi=altivec)
+# Enable <altivec.h>
+altivec_flags += -isystem $(shell $(CC) -print-file-name=include)
 
 ifdef CONFIG_CC_IS_CLANG
 # clang ppc port does not yet support -maltivec when -msoft-float is
@@ -34,6 +36,8 @@ endif
 # ARM/NEON intrinsics in a non C99-compliant environment (such as the kernel)
 ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
 NEON_FLAGS := -ffreestanding
+# Enable <arm_neon.h>
+NEON_FLAGS += -isystem $(shell $(CC) -print-file-name=include)
 ifeq ($(ARCH),arm)
 NEON_FLAGS += -march=armv7-a -mfloat-abi=softfp -mfpu=neon
 endif
-- 
2.31.1

