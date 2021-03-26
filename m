Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580B534A8B9
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 14:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhCZNqu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Mar 2021 09:46:50 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:55644 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230224AbhCZNpf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Mar 2021 09:45:35 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F6NWg6MH2z9v03S;
        Fri, 26 Mar 2021 14:45:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id MNDC8OJTfViJ; Fri, 26 Mar 2021 14:45:03 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F6NWb1Qt4z9v03B;
        Fri, 26 Mar 2021 14:44:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D694F8B8C7;
        Fri, 26 Mar 2021 14:44:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qjbQix6F4eyN; Fri, 26 Mar 2021 14:44:59 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 34F198B8CB;
        Fri, 26 Mar 2021 14:44:59 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id A571367611; Fri, 26 Mar 2021 13:44:59 +0000 (UTC)
Message-Id: <6b76649009943f2893fdfded22becd41db2fe1f7.1616765870.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1616765869.git.christophe.leroy@csgroup.eu>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 12/17] sh: Convert to GENERIC_CMDLINE
To:     will@kernel.org, danielwa@cisco.com, robh@kernel.org,
        daniel@gimpelevich.san-francisco.ca.us
Cc:     linux-arch@vger.kernel.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        microblaze <monstr@monstr.eu>, linux-mips@vger.kernel.org,
        nios2 <ley.foon.tan@intel.com>, openrisc@lists.librecores.org,
        linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, linux-xtensa@linux-xtensa.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Date:   Fri, 26 Mar 2021 13:44:59 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This converts the architecture to GENERIC_CMDLINE.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/sh/Kconfig                             | 30 +--------------------
 arch/sh/configs/ap325rxa_defconfig          |  2 +-
 arch/sh/configs/dreamcast_defconfig         |  2 +-
 arch/sh/configs/ecovec24-romimage_defconfig |  2 +-
 arch/sh/configs/ecovec24_defconfig          |  2 +-
 arch/sh/configs/edosk7760_defconfig         |  2 +-
 arch/sh/configs/espt_defconfig              |  2 +-
 arch/sh/configs/j2_defconfig                |  2 +-
 arch/sh/configs/kfr2r09-romimage_defconfig  |  2 +-
 arch/sh/configs/kfr2r09_defconfig           |  2 +-
 arch/sh/configs/lboxre2_defconfig           |  2 +-
 arch/sh/configs/microdev_defconfig          |  2 +-
 arch/sh/configs/migor_defconfig             |  2 +-
 arch/sh/configs/polaris_defconfig           |  2 +-
 arch/sh/configs/r7780mp_defconfig           |  2 +-
 arch/sh/configs/r7785rp_defconfig           |  2 +-
 arch/sh/configs/rsk7201_defconfig           |  2 +-
 arch/sh/configs/rsk7203_defconfig           |  2 +-
 arch/sh/configs/rts7751r2d1_defconfig       |  2 +-
 arch/sh/configs/rts7751r2dplus_defconfig    |  2 +-
 arch/sh/configs/sdk7780_defconfig           |  2 +-
 arch/sh/configs/sdk7786_defconfig           |  2 +-
 arch/sh/configs/se7206_defconfig            |  2 +-
 arch/sh/configs/se7343_defconfig            |  2 +-
 arch/sh/configs/se7712_defconfig            |  2 +-
 arch/sh/configs/se7721_defconfig            |  2 +-
 arch/sh/configs/se7724_defconfig            |  2 +-
 arch/sh/configs/se7751_defconfig            |  2 +-
 arch/sh/configs/se7780_defconfig            |  2 +-
 arch/sh/configs/sh03_defconfig              |  2 +-
 arch/sh/configs/sh2007_defconfig            |  2 +-
 arch/sh/configs/sh7757lcr_defconfig         |  2 +-
 arch/sh/configs/sh7763rdp_defconfig         |  2 +-
 arch/sh/configs/shmin_defconfig             |  2 +-
 arch/sh/configs/shx3_defconfig              |  2 +-
 arch/sh/configs/titan_defconfig             |  2 +-
 arch/sh/configs/ul2_defconfig               |  2 +-
 arch/sh/kernel/setup.c                      | 11 ++------
 38 files changed, 39 insertions(+), 74 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index e798e55915c2..fab84f62448c 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -16,6 +16,7 @@ config SUPERH
 	select CPU_NO_EFFICIENT_FFS
 	select DMA_DECLARE_COHERENT
 	select GENERIC_ATOMIC64
+	select GENERIC_CMDLINE
 	select GENERIC_CMOS_UPDATE if SH_SH03 || SH_DREAMCAST
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IRQ_SHOW
@@ -742,35 +743,6 @@ config ROMIMAGE_MMCIF
 	  first part of the romImage which in turn loads the rest the kernel
 	  image to RAM using the MMCIF hardware block.
 
-choice
-	prompt "Kernel command line"
-	optional
-	default CMDLINE_OVERWRITE
-	help
-	  Setting this option allows the kernel command line arguments
-	  to be set.
-
-config CMDLINE_OVERWRITE
-	bool "Overwrite bootloader kernel arguments"
-	help
-	  Given string will overwrite any arguments passed in by
-	  a bootloader.
-
-config CMDLINE_EXTEND
-	bool "Extend bootloader kernel arguments"
-	help
-	  Given string will be concatenated with arguments passed in
-	  by a bootloader.
-
-endchoice
-
-config CMDLINE
-	string "Kernel command line arguments string"
-	depends on CMDLINE_OVERWRITE || CMDLINE_EXTEND
-	default "console=ttySC1,115200"
-
-endmenu
-
 menu "Bus options"
 
 config SUPERHYWAY
diff --git a/arch/sh/configs/ap325rxa_defconfig b/arch/sh/configs/ap325rxa_defconfig
index 5193b3e099b9..3997aa49c75b 100644
--- a/arch/sh/configs/ap325rxa_defconfig
+++ b/arch/sh/configs/ap325rxa_defconfig
@@ -15,7 +15,7 @@ CONFIG_SH_AP325RXA=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_SECCOMP=y
 CONFIG_PREEMPT=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=tty1 console=ttySC5,38400 root=/dev/nfs ip=dhcp"
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/sh/configs/dreamcast_defconfig b/arch/sh/configs/dreamcast_defconfig
index 6a82c7b8ff32..ac030c1a351e 100644
--- a/arch/sh/configs/dreamcast_defconfig
+++ b/arch/sh/configs/dreamcast_defconfig
@@ -22,7 +22,7 @@ CONFIG_NR_DMA_CHANNELS_BOOL=y
 CONFIG_NR_DMA_CHANNELS=9
 CONFIG_SECCOMP=y
 CONFIG_PREEMPT=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=ttySC1,115200 panic=3"
 CONFIG_MAPLE=y
 CONFIG_PCI=y
diff --git a/arch/sh/configs/ecovec24-romimage_defconfig b/arch/sh/configs/ecovec24-romimage_defconfig
index 5c60e71d839e..db78857ae30f 100644
--- a/arch/sh/configs/ecovec24-romimage_defconfig
+++ b/arch/sh/configs/ecovec24-romimage_defconfig
@@ -14,7 +14,7 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_SH_ECOVEC=y
 # CONFIG_SH_TIMER_TMU is not set
 CONFIG_KEXEC=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=ttySC0,115200"
 # CONFIG_SUSPEND is not set
 CONFIG_NET=y
diff --git a/arch/sh/configs/ecovec24_defconfig b/arch/sh/configs/ecovec24_defconfig
index 03cb916819fa..f6f7d2e1840d 100644
--- a/arch/sh/configs/ecovec24_defconfig
+++ b/arch/sh/configs/ecovec24_defconfig
@@ -16,7 +16,7 @@ CONFIG_SH_ECOVEC=y
 CONFIG_HEARTBEAT=y
 CONFIG_SECCOMP=y
 CONFIG_PREEMPT=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=tty0, console=ttySC0,115200 root=/dev/nfs ip=dhcp mem=248M memchunk.vpu=8m memchunk.veu0=4m"
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/sh/configs/edosk7760_defconfig b/arch/sh/configs/edosk7760_defconfig
index d77f54e906fd..1ac8eb89c550 100644
--- a/arch/sh/configs/edosk7760_defconfig
+++ b/arch/sh/configs/edosk7760_defconfig
@@ -19,7 +19,7 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_SH_DMA=y
 CONFIG_SH_DMA_API=y
 CONFIG_PREEMPT=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="mem=64M console=ttySC2,115200 root=/dev/nfs rw nfsroot=192.168.0.3:/scripts/filesys ip=192.168.0.4"
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/sh/configs/espt_defconfig b/arch/sh/configs/espt_defconfig
index 2804cb760a76..1bffacbaba3d 100644
--- a/arch/sh/configs/espt_defconfig
+++ b/arch/sh/configs/espt_defconfig
@@ -14,7 +14,7 @@ CONFIG_MEMORY_START=0x0c000000
 CONFIG_SH_ESPT=y
 CONFIG_SH_PCLK_FREQ=66666666
 CONFIG_SECCOMP=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=ttySC0,115200 root=/dev/nfs ip=bootp"
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/sh/configs/j2_defconfig b/arch/sh/configs/j2_defconfig
index 2eb81ebe3888..983c62e936eb 100644
--- a/arch/sh/configs/j2_defconfig
+++ b/arch/sh/configs/j2_defconfig
@@ -10,7 +10,7 @@ CONFIG_CPU_BIG_ENDIAN=y
 CONFIG_SH_DEVICE_TREE=y
 CONFIG_SH_JCORE_SOC=y
 CONFIG_HZ_100=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=ttyUL0 earlycon"
 CONFIG_BINFMT_ELF_FDPIC=y
 CONFIG_BINFMT_FLAT=y
diff --git a/arch/sh/configs/kfr2r09-romimage_defconfig b/arch/sh/configs/kfr2r09-romimage_defconfig
index 04436b4fbd76..8418c1f0c1ce 100644
--- a/arch/sh/configs/kfr2r09-romimage_defconfig
+++ b/arch/sh/configs/kfr2r09-romimage_defconfig
@@ -15,7 +15,7 @@ CONFIG_SH_KFR2R09=y
 # CONFIG_SH_TIMER_TMU is not set
 CONFIG_HZ_100=y
 CONFIG_KEXEC=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=ttySC1,115200 quiet"
 # CONFIG_SUSPEND is not set
 CONFIG_NET=y
diff --git a/arch/sh/configs/kfr2r09_defconfig b/arch/sh/configs/kfr2r09_defconfig
index 833404490cfe..0b04d179ebba 100644
--- a/arch/sh/configs/kfr2r09_defconfig
+++ b/arch/sh/configs/kfr2r09_defconfig
@@ -19,7 +19,7 @@ CONFIG_NO_HZ=y
 CONFIG_HZ_1000=y
 CONFIG_KEXEC=y
 CONFIG_PREEMPT=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=tty0 console=ttySC1,115200"
 # CONFIG_SUSPEND is not set
 CONFIG_CPU_IDLE=y
diff --git a/arch/sh/configs/lboxre2_defconfig b/arch/sh/configs/lboxre2_defconfig
index 05e4ac6fed5f..498c88953d2a 100644
--- a/arch/sh/configs/lboxre2_defconfig
+++ b/arch/sh/configs/lboxre2_defconfig
@@ -12,7 +12,7 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_SH_LBOX_RE2=y
 CONFIG_SH_PCLK_FREQ=40000000
 CONFIG_KEXEC=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=ttySC1,115200 root=/dev/sda1"
 CONFIG_PCI=y
 CONFIG_PCCARD=y
diff --git a/arch/sh/configs/microdev_defconfig b/arch/sh/configs/microdev_defconfig
index e9825196dd66..8467de1d3092 100644
--- a/arch/sh/configs/microdev_defconfig
+++ b/arch/sh/configs/microdev_defconfig
@@ -11,7 +11,7 @@ CONFIG_SH_DMA=y
 CONFIG_SH_DMA_API=y
 CONFIG_HEARTBEAT=y
 CONFIG_PREEMPT=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=ttySC0,115200 root=/dev/hda1"
 CONFIG_SUPERHYWAY=y
 CONFIG_NET=y
diff --git a/arch/sh/configs/migor_defconfig b/arch/sh/configs/migor_defconfig
index 4859cd30cfc4..e43fb2a63f1f 100644
--- a/arch/sh/configs/migor_defconfig
+++ b/arch/sh/configs/migor_defconfig
@@ -15,7 +15,7 @@ CONFIG_NUMA=y
 CONFIG_SH_MIGOR=y
 # CONFIG_SH_TIMER_CMT is not set
 CONFIG_SECCOMP=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=tty0 console=ttySC0,115200 earlyprintk=serial ip=on root=/dev/nfs ip=dhcp"
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/sh/configs/polaris_defconfig b/arch/sh/configs/polaris_defconfig
index 246408ec7462..2fc2bdc0e002 100644
--- a/arch/sh/configs/polaris_defconfig
+++ b/arch/sh/configs/polaris_defconfig
@@ -25,7 +25,7 @@ CONFIG_SH_DMA_API=y
 CONFIG_HEARTBEAT=y
 CONFIG_HZ_100=y
 CONFIG_PREEMPT=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=ttySC1,115200 root=/dev/mtdblock2 rootfstype=jffs2 mem=63M mtdparts=physmap-flash.0:0x00100000(bootloader)ro,0x00500000(Kernel)ro,0x00A00000(Filesystem)"
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/sh/configs/r7780mp_defconfig b/arch/sh/configs/r7780mp_defconfig
index f823cc6b18f9..9e2438114890 100644
--- a/arch/sh/configs/r7780mp_defconfig
+++ b/arch/sh/configs/r7780mp_defconfig
@@ -20,7 +20,7 @@ CONFIG_SH_PCLK_FREQ=33333333
 CONFIG_PUSH_SWITCH=y
 CONFIG_KEXEC=y
 CONFIG_PREEMPT=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=ttySC0,115200 root=/dev/sda1"
 CONFIG_PCI=y
 CONFIG_NET=y
diff --git a/arch/sh/configs/r7785rp_defconfig b/arch/sh/configs/r7785rp_defconfig
index f96bc20d4b1a..c1c92f154694 100644
--- a/arch/sh/configs/r7785rp_defconfig
+++ b/arch/sh/configs/r7785rp_defconfig
@@ -26,7 +26,7 @@ CONFIG_HEARTBEAT=y
 CONFIG_PUSH_SWITCH=y
 CONFIG_KEXEC=y
 CONFIG_PREEMPT=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=ttySC0,115200 root=/dev/sda1"
 CONFIG_PCI=y
 CONFIG_BINFMT_MISC=m
diff --git a/arch/sh/configs/rsk7201_defconfig b/arch/sh/configs/rsk7201_defconfig
index e41526120be1..65f3d695bc78 100644
--- a/arch/sh/configs/rsk7201_defconfig
+++ b/arch/sh/configs/rsk7201_defconfig
@@ -21,7 +21,7 @@ CONFIG_CPU_BIG_ENDIAN=y
 CONFIG_SH_RSK=y
 CONFIG_SH_PCLK_FREQ=40000000
 CONFIG_HZ_1000=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=ttySC0,115200 earlyprintk=serial ignore_loglevel"
 CONFIG_BINFMT_FLAT=y
 CONFIG_BINFMT_ZFLAT=y
diff --git a/arch/sh/configs/rsk7203_defconfig b/arch/sh/configs/rsk7203_defconfig
index 6af08fa1ddf8..33f608c54b85 100644
--- a/arch/sh/configs/rsk7203_defconfig
+++ b/arch/sh/configs/rsk7203_defconfig
@@ -26,7 +26,7 @@ CONFIG_CPU_FREQ=y
 CONFIG_SH_CPU_FREQ=y
 CONFIG_HEARTBEAT=y
 CONFIG_HZ_1000=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=ttySC0,115200 earlyprintk=serial ignore_loglevel"
 CONFIG_BINFMT_FLAT=y
 CONFIG_BINFMT_ZFLAT=y
diff --git a/arch/sh/configs/rts7751r2d1_defconfig b/arch/sh/configs/rts7751r2d1_defconfig
index 96263a4912b7..131699a6daa7 100644
--- a/arch/sh/configs/rts7751r2d1_defconfig
+++ b/arch/sh/configs/rts7751r2d1_defconfig
@@ -11,7 +11,7 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_SH_RTS7751R2D=y
 CONFIG_RTS7751R2D_1=y
 CONFIG_HEARTBEAT=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=tty0 console=ttySC1,115200 root=/dev/sda1"
 CONFIG_PCI=y
 CONFIG_HOTPLUG_PCI=y
diff --git a/arch/sh/configs/rts7751r2dplus_defconfig b/arch/sh/configs/rts7751r2dplus_defconfig
index 92e586e6c974..ffa76ad8efaa 100644
--- a/arch/sh/configs/rts7751r2dplus_defconfig
+++ b/arch/sh/configs/rts7751r2dplus_defconfig
@@ -11,7 +11,7 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_SH_RTS7751R2D=y
 CONFIG_RTS7751R2D_PLUS=y
 CONFIG_HEARTBEAT=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=tty0 console=ttySC1,115200 root=/dev/sda1"
 CONFIG_PCI=y
 CONFIG_HOTPLUG_PCI=y
diff --git a/arch/sh/configs/sdk7780_defconfig b/arch/sh/configs/sdk7780_defconfig
index 6c719ab4332a..a33f81c41a13 100644
--- a/arch/sh/configs/sdk7780_defconfig
+++ b/arch/sh/configs/sdk7780_defconfig
@@ -22,7 +22,7 @@ CONFIG_SH_DMA=y
 CONFIG_SH_DMA_API=y
 CONFIG_HEARTBEAT=y
 CONFIG_PREEMPT=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="mem=128M console=tty0 console=ttySC0,115200 ip=bootp root=/dev/nfs nfsroot=192.168.0.1:/home/rootfs"
 CONFIG_PCI=y
 CONFIG_PCI_DEBUG=y
diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_defconfig
index f776a1d0d277..1daf3dbffc16 100644
--- a/arch/sh/configs/sdk7786_defconfig
+++ b/arch/sh/configs/sdk7786_defconfig
@@ -70,7 +70,7 @@ CONFIG_HOTPLUG_CPU=y
 CONFIG_PREEMPT=y
 CONFIG_INTC_USERIMASK=y
 CONFIG_INTC_BALANCING=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=ttySC1,115200 earlyprintk=sh-sci.1,115200 root=/dev/sda1 nmi_debug=state,debounce rootdelay=5 pmb=iomap ignore_loglevel"
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
diff --git a/arch/sh/configs/se7206_defconfig b/arch/sh/configs/se7206_defconfig
index 315b04a8dd2f..c729ddb5d2c8 100644
--- a/arch/sh/configs/se7206_defconfig
+++ b/arch/sh/configs/se7206_defconfig
@@ -36,7 +36,7 @@ CONFIG_SH_CPU_FREQ=y
 CONFIG_HEARTBEAT=y
 CONFIG_HZ_1000=y
 CONFIG_PREEMPT=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=ttySC3,115200 ignore_loglevel earlyprintk=serial"
 CONFIG_BINFMT_FLAT=y
 CONFIG_BINFMT_ZFLAT=y
diff --git a/arch/sh/configs/se7343_defconfig b/arch/sh/configs/se7343_defconfig
index 5d6c19338ebf..32fedfd8ae81 100644
--- a/arch/sh/configs/se7343_defconfig
+++ b/arch/sh/configs/se7343_defconfig
@@ -17,7 +17,7 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_SH_7343_SOLUTION_ENGINE=y
 # CONFIG_SH_TIMER_CMT is not set
 CONFIG_HEARTBEAT=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=ttySC0,115200"
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/sh/configs/se7712_defconfig b/arch/sh/configs/se7712_defconfig
index ee6d28ae08de..02a8dcb898db 100644
--- a/arch/sh/configs/se7712_defconfig
+++ b/arch/sh/configs/se7712_defconfig
@@ -22,7 +22,7 @@ CONFIG_SH_SOLUTION_ENGINE=y
 CONFIG_SH_PCLK_FREQ=66666666
 CONFIG_HEARTBEAT=y
 CONFIG_PREEMPT_VOLUNTARY=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=ttySC0,115200 root=/dev/sda1"
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/sh/configs/se7721_defconfig b/arch/sh/configs/se7721_defconfig
index bad921bc10f8..a0ce6eca3bf5 100644
--- a/arch/sh/configs/se7721_defconfig
+++ b/arch/sh/configs/se7721_defconfig
@@ -22,7 +22,7 @@ CONFIG_SH_7721_SOLUTION_ENGINE=y
 CONFIG_SH_PCLK_FREQ=33333333
 CONFIG_HEARTBEAT=y
 CONFIG_PREEMPT_VOLUNTARY=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=ttySC0,115200 root=/dev/sda2"
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/sh/configs/se7724_defconfig b/arch/sh/configs/se7724_defconfig
index a26f7f1841c7..9cd50acd959d 100644
--- a/arch/sh/configs/se7724_defconfig
+++ b/arch/sh/configs/se7724_defconfig
@@ -17,7 +17,7 @@ CONFIG_SH_DMA_API=y
 CONFIG_HEARTBEAT=y
 CONFIG_SECCOMP=y
 CONFIG_PREEMPT=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=tty1 console=ttySC3,115200 root=/dev/nfs ip=dhcp memchunk.vpu=4m"
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/sh/configs/se7751_defconfig b/arch/sh/configs/se7751_defconfig
index 4a024065bb75..8c2beb3677e2 100644
--- a/arch/sh/configs/se7751_defconfig
+++ b/arch/sh/configs/se7751_defconfig
@@ -12,7 +12,7 @@ CONFIG_MEMORY_START=0x0c000000
 CONFIG_FLATMEM_MANUAL=y
 CONFIG_SH_7751_SOLUTION_ENGINE=y
 CONFIG_HEARTBEAT=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=ttySC1,38400"
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/sh/configs/se7780_defconfig b/arch/sh/configs/se7780_defconfig
index dcd85b858ac8..3be23f65c38e 100644
--- a/arch/sh/configs/se7780_defconfig
+++ b/arch/sh/configs/se7780_defconfig
@@ -14,7 +14,7 @@ CONFIG_MEMORY_SIZE=0x08000000
 CONFIG_SH_7780_SOLUTION_ENGINE=y
 CONFIG_SH_PCLK_FREQ=33333333
 CONFIG_HEARTBEAT=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=ttySC0,115200 root=/dev/sda1"
 CONFIG_PCI=y
 CONFIG_NET=y
diff --git a/arch/sh/configs/sh03_defconfig b/arch/sh/configs/sh03_defconfig
index ff502683132e..87e9805b76d0 100644
--- a/arch/sh/configs/sh03_defconfig
+++ b/arch/sh/configs/sh03_defconfig
@@ -16,7 +16,7 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_SH_SH03=y
 CONFIG_HEARTBEAT=y
 CONFIG_PREEMPT=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=ttySC1,115200 mem=64M root=/dev/nfs"
 CONFIG_PCI=y
 CONFIG_HOTPLUG_PCI=y
diff --git a/arch/sh/configs/sh2007_defconfig b/arch/sh/configs/sh2007_defconfig
index 99975db461d8..8e92c58316db 100644
--- a/arch/sh/configs/sh2007_defconfig
+++ b/arch/sh/configs/sh2007_defconfig
@@ -20,7 +20,7 @@ CONFIG_SH_DMA=y
 CONFIG_SH_DMA_API=y
 CONFIG_NR_DMA_CHANNELS_BOOL=y
 CONFIG_HZ_100=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=ttySC1,115200 ip=dhcp root=/dev/nfs rw nfsroot=/nfs/rootfs,rsize=1024,wsize=1024 earlyprintk=sh-sci.1"
 CONFIG_PCCARD=y
 CONFIG_BINFMT_MISC=y
diff --git a/arch/sh/configs/sh7757lcr_defconfig b/arch/sh/configs/sh7757lcr_defconfig
index a2700ab165af..a15877daff16 100644
--- a/arch/sh/configs/sh7757lcr_defconfig
+++ b/arch/sh/configs/sh7757lcr_defconfig
@@ -21,7 +21,7 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_SH_SH7757LCR=y
 CONFIG_HEARTBEAT=y
 CONFIG_SECCOMP=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=ttySC2,115200 root=/dev/nfs ip=dhcp"
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/sh/configs/sh7763rdp_defconfig b/arch/sh/configs/sh7763rdp_defconfig
index 8a6a446f9eb8..351ccabac8a6 100644
--- a/arch/sh/configs/sh7763rdp_defconfig
+++ b/arch/sh/configs/sh7763rdp_defconfig
@@ -14,7 +14,7 @@ CONFIG_MEMORY_START=0x0c000000
 CONFIG_SH_SH7763RDP=y
 CONFIG_SH_PCLK_FREQ=66666666
 CONFIG_SECCOMP=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=ttySC2,115200 root=/dev/sda1 rootdelay=10"
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/sh/configs/shmin_defconfig b/arch/sh/configs/shmin_defconfig
index c0b6f40d01cc..7cc8725951f5 100644
--- a/arch/sh/configs/shmin_defconfig
+++ b/arch/sh/configs/shmin_defconfig
@@ -18,7 +18,7 @@ CONFIG_FLATMEM_MANUAL=y
 # CONFIG_SH_ADC is not set
 CONFIG_SH_SHMIN=y
 CONFIG_SH_PCLK_FREQ=32000000
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=ttySC1,115200 root=1f01 mtdparts=phys_mapped_flash:64k(firm)ro,-(sys) netdev=34,0x300,eth0 "
 CONFIG_NET=y
 CONFIG_UNIX=y
diff --git a/arch/sh/configs/shx3_defconfig b/arch/sh/configs/shx3_defconfig
index 32ec6eb1eabc..36cac3067cef 100644
--- a/arch/sh/configs/shx3_defconfig
+++ b/arch/sh/configs/shx3_defconfig
@@ -47,7 +47,7 @@ CONFIG_KEXEC=y
 CONFIG_SECCOMP=y
 CONFIG_SMP=y
 CONFIG_PREEMPT=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=ttySC0,115200 earlyprintk=bios ignore_loglevel"
 CONFIG_BINFMT_MISC=y
 CONFIG_NET=y
diff --git a/arch/sh/configs/titan_defconfig b/arch/sh/configs/titan_defconfig
index ba887f1351be..5aa513d54df0 100644
--- a/arch/sh/configs/titan_defconfig
+++ b/arch/sh/configs/titan_defconfig
@@ -20,7 +20,7 @@ CONFIG_SH_PCLK_FREQ=30000000
 CONFIG_SH_DMA=y
 CONFIG_SH_DMA_API=y
 CONFIG_PREEMPT_VOLUNTARY=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=ttySC1,38400N81 root=/dev/nfs ip=:::::eth1:autoconf rw"
 CONFIG_PCI=y
 CONFIG_HOTPLUG_PCI=y
diff --git a/arch/sh/configs/ul2_defconfig b/arch/sh/configs/ul2_defconfig
index 103b81ec1ffb..8d8b6787302f 100644
--- a/arch/sh/configs/ul2_defconfig
+++ b/arch/sh/configs/ul2_defconfig
@@ -18,7 +18,7 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_HZ_100=y
 CONFIG_KEXEC=y
 CONFIG_PREEMPT=y
-CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE_FORCE=y
 CONFIG_CMDLINE="console=ttySC0,115200 root=/dev/nfs ip=dhcp"
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 4144be650d41..303b8658a870 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -32,6 +32,7 @@
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/uaccess.h>
+#include <linux/cmdline.h>
 #include <uapi/linux/mount.h>
 #include <asm/io.h>
 #include <asm/page.h>
@@ -306,15 +307,7 @@ void __init setup_arch(char **cmdline_p)
 	bss_resource.start = virt_to_phys(__bss_start);
 	bss_resource.end = virt_to_phys(__bss_stop)-1;
 
-#ifdef CONFIG_CMDLINE_OVERWRITE
-	strlcpy(command_line, CONFIG_CMDLINE, sizeof(command_line));
-#else
-	strlcpy(command_line, COMMAND_LINE, sizeof(command_line));
-#ifdef CONFIG_CMDLINE_EXTEND
-	strlcat(command_line, " ", sizeof(command_line));
-	strlcat(command_line, CONFIG_CMDLINE, sizeof(command_line));
-#endif
-#endif
+	cmdline_build(command_line, COMMAND_LINE, sizeof(command_line));
 
 	/* Save unparsed command line copy for /proc/cmdline */
 	memcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
-- 
2.25.0

