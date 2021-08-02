Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586813DE0E4
	for <lists+linux-arch@lfdr.de>; Mon,  2 Aug 2021 22:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhHBUn3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Aug 2021 16:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbhHBUn3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Aug 2021 16:43:29 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A0EC06175F;
        Mon,  2 Aug 2021 13:43:19 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o7-20020a05600c5107b0290257f956e02dso304802wms.1;
        Mon, 02 Aug 2021 13:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PRSTR3+DVBMkb0eQ5+orqeoOf+9krLg4NFc67Fbv2Y8=;
        b=jvI0MNUdJHaSaW75aN+mx+Tp/tDMwIkCHaq2P2cHXlMZa51niF2I/y7Mmhy/glXree
         9BGikocbu2oYhAes3vX2CklYlrV6gRufeUTU3t67a5GkIT7f6PxUQ3nRpM+Q0pT6PvRg
         5/uVUH8gz/udvO/K/qEkwTGP1itnDpuGnyfpva3pnftNjk5axEd4iPtEe3TqpMCyxjGy
         5pbmymlWJU4XXWWEpqNIxVCqB3VPeElJL4v2uudZnT9wekq3r+LYRiLusXXym3EDJMh4
         yWhfNtOhgP/8t914j7FEX1OOCZRDJbxZtvnzHd25rYkMemEXiMaHf2I9KoE0I7evxbwK
         nwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PRSTR3+DVBMkb0eQ5+orqeoOf+9krLg4NFc67Fbv2Y8=;
        b=R4USrwB8qYxXSEdqUW3D8YnJUiwCr5aXqMNfsYSuYl2x+kimLmzKgJuSGmZprPOOfR
         OTnvU3ywLrvTEv2laCzv7ZaT/Yucy6WCeIsHgBkB9k7bmMbF7J0L3Zm7XrHnuF06lzZP
         WwS1XLWwE1m0h3wEF1HCJ3pDV7U3aUuUjoLyp6hTSVaugwhwnfl/jcL45cWlw28z4lkk
         l5AUpBdtZKbx/rUl9uQY8ribajubuaGsDOXq+jbIyoz2Vfk0ZAQCL84LOSHmmhlpRQUg
         F9nISaVNLorSJjwlr35cLK953hHr6d8bujMF7XSRlAps3QKEdrRIVyvM5GyATgAm+nxH
         6X2A==
X-Gm-Message-State: AOAM533oD2fuSxxvvs0rs8h1cHsFc2YpW0BD5u7DD22mselpqBRGQQ6v
        BHSl8hz4vH/kkODXvnL/fA==
X-Google-Smtp-Source: ABdhPJxSKyh7aAS57JdYiYecRpDIZoLhp7sGGwUEqpbPj7Rr++NbQiYzNbCPJPo11nw/3FRSmWyhCA==
X-Received: by 2002:a05:600c:ac4:: with SMTP id c4mr725965wmr.10.1627936997674;
        Mon, 02 Aug 2021 13:43:17 -0700 (PDT)
Received: from localhost.localdomain ([46.53.249.181])
        by smtp.gmail.com with ESMTPSA id q63sm529973wme.36.2021.08.02.13.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 13:43:17 -0700 (PDT)
Date:   Mon, 2 Aug 2021 23:43:15 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        masahiroy@kernel.org
Subject: [PATCH v3 3/3] isystem: delete global -isystem compile option
Message-ID: <YQhY40teUJcTc5H4@localhost.localdomain>
References: <20210802204033.466861-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210802204033.466861-1-adobriyan@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From 1f091e94a559524d89f75cab9fcc1caaf0b2bada Mon Sep 17 00:00:00 2001
From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Fri, 30 Jul 2021 16:10:27 +0300
Subject: [PATCH v3 3/3] isystem: delete global -isystem compile option

Further isolate kernel from userspace, prevent accidental inclusion of
undesireable headers, mainly float.h and stdatomic.h.

nds32 keeps -isystem globally due to intrinsics used in entrenched header.

-isystem is selectively reenabled for some files, again, for intrinsics.

Compile tested on:

hexagon-defconfig hexagon-allmodconfig
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

Tested-by: Nathan Chancellor <nathan@kernel.org> # build (hexagon)
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
index 10526d4559b8..0cfa044301eb 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -120,6 +120,8 @@ CFLAGS_aegis128-neon-inner.o += $(aegis128-cflags-y)
 CFLAGS_REMOVE_aegis128-neon-inner.o += -mgeneral-regs-only
 aegis128-$(CONFIG_CRYPTO_AEGIS128_SIMD) += aegis128-neon.o aegis128-neon-inner.o
 endif
+# Enable <arm_neon.h>
+CFLAGS_aegis128-neon-inner.o += -isystem $(shell $(CC) -print-file-name=include)
 
 obj-$(CONFIG_CRYPTO_PCRYPT) += pcrypt.o
 obj-$(CONFIG_CRYPTO_CRYPTD) += cryptd.o
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

