Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF326C6DE3
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 17:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjCWQjc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 12:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjCWQjP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 12:39:15 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1033B3F0;
        Thu, 23 Mar 2023 09:37:25 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NF1iUH025741;
        Thu, 23 Mar 2023 16:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=acT/02utXawoH32mC8Zfy9FEHVZb3pNDgW9UY75G1Wk=;
 b=YNEDGxiOxwLIs2VW3/0EbLBpym/lbOGIAmIEe4boIucMp2OKupdarp2JDuWrpCRgddaf
 HSQ3e7ZQtspdf2U1PBjnkrtgOtrEN5AwFrC2yf0OZIkuzPUmbkppjb7f25tWefMFf06m
 HD3Lde7dxytPVRgDyW9xdn5fQHuFfTtwH06174Ygtdr4fektfdJkgSzq5hX3qEwLg+eS
 MEsSnTj18e+MnBAZ+A1d33fua28arpuz+Sh9A0s/c5ohGO3ADQCDf2FEFomDZgY/kCo1
 +OZG1ftII9VUAwlt0DJSJV7Zs+MAWxjQcPRl82UUwIH0FtG1szSBLC1tqYBnjakUQ32Z /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pgn871bqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 16:34:03 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32NDr2iH023038;
        Thu, 23 Mar 2023 16:34:02 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pgn871bp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 16:34:02 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32N4XR1f018070;
        Thu, 23 Mar 2023 16:33:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3pd4x6eefv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 16:33:58 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32NGXuTF27525836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 16:33:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B3E02004B;
        Thu, 23 Mar 2023 16:33:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0D5020040;
        Thu, 23 Mar 2023 16:33:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 23 Mar 2023 16:33:54 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: [PATCH v4] Kconfig: introduce HAS_IOPORT option and select it as necessary
Date:   Thu, 23 Mar 2023 17:33:52 +0100
Message-Id: <20230323163354.1454196-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OEQpOuYuicyDPRN5V_qRfK7Yk5Yc5L6E
X-Proofpoint-ORIG-GUID: 3APFiBEOa4qTbFQTDE9ca29AX4ixw-8u
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=774 adultscore=0 spamscore=0 clxscore=1011 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303230120
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We introduce a new HAS_IOPORT Kconfig option to indicate support for I/O
Port access. In a future patch HAS_IOPORT=n will disable compilation of
the I/O accessor functions inb()/outb() and friends on architectures
which can not meaningfully support legacy I/O spaces such as s390.

The following architectures do not select HAS_IOPORT:

* ARC
* C-SKY
* Hexagon
* Nios II
* OpenRISC
* s390
* User-Mode Linux
* Xtensa

All other architectures select HAS_IOPORT at least conditionally.

The "depends on" relations on HAS_IOPORT in drivers as well as ifdefs
for HAS_IOPORT specific sections will be added in subsequent patches on
a per subsystem basis.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Acked-by: Johannes Berg <johannes@sipsolutions.net> # for ARCH=um
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Note: This patch is the initial patch of a larger series[0]. This patch
introduces the HAS_IOPORT config option while the rest of the series adds
driver dependencies and the final patch removes inb() / outb() and friends on
platforms that don't support them. 

Thus each of the per-subsystem patches is independent from each other but
depends on this patch while the final patch depends on the whole series. Thus
splitting this initial patch off allows the per-subsytem HAS_IOPORT dependency
addition be merged separately via different trees without breaking the build.

[0] https://lore.kernel.org/lkml/20230314121216.413434-1-schnelle@linux.ibm.com/

Changes since v3:
- List archs without HAS_IOPORT in commit message (Arnd)
- Select HAS_IOPORT for LoongArch (Arnd)
- Use "select HAS_IOPORT if (E)ISA || .." instead of a "depends on" for (E)ISA
  for m68k and parisc
- Select HAS_IOPORT with config GSC on parisc (Arnd)
- Drop "depends on HAS_IOPORT" for um's config ISA (Johannes)
- Drop "depends on HAS_IOPORT" for config ISA on x86 and parisc where it is
  always selected (Arnd)

 arch/alpha/Kconfig      | 1 +
 arch/arm/Kconfig        | 1 +
 arch/arm64/Kconfig      | 1 +
 arch/ia64/Kconfig       | 1 +
 arch/loongarch/Kconfig  | 1 +
 arch/m68k/Kconfig       | 1 +
 arch/microblaze/Kconfig | 1 +
 arch/mips/Kconfig       | 1 +
 arch/parisc/Kconfig     | 1 +
 arch/powerpc/Kconfig    | 1 +
 arch/riscv/Kconfig      | 1 +
 arch/sh/Kconfig         | 1 +
 arch/sparc/Kconfig      | 1 +
 arch/x86/Kconfig        | 1 +
 drivers/bus/Kconfig     | 2 +-
 drivers/parisc/Kconfig  | 1 +
 lib/Kconfig             | 4 ++++
 17 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 780d4673c3ca..a5c2b1aa46b0 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -27,6 +27,7 @@ config ALPHA
 	select AUDIT_ARCH
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_SMP_IDLE_THREAD
+	select HAS_IOPORT
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_MOD_ARCH_SPECIFIC
 	select MODULES_USE_ELF_RELA
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e24a9820e12f..4acb5bc4b52a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -70,6 +70,7 @@ config ARM
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select HARDIRQS_SW_RESEND
+	select HAS_IOPORT
 	select HAVE_ARCH_AUDITSYSCALL if AEABI && !OABI_COMPAT
 	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1023e896d46b..b740019c4aee 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -145,6 +145,7 @@ config ARM64
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_VDSO_TIME_NS
 	select HARDIRQS_SW_RESEND
+	select HAS_IOPORT
 	select HAVE_MOVE_PMD
 	select HAVE_MOVE_PUD
 	select HAVE_PCI
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index d7e4a24e8644..2e13ec8263b9 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -25,6 +25,7 @@ config IA64
 	select PCI_DOMAINS if PCI
 	select PCI_MSI
 	select PCI_SYSCALL if PCI
+	select HAS_IOPORT
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_EXIT_THREAD
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 7fd51257e0ed..e1615dfb5437 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -80,6 +80,7 @@ config LOONGARCH
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GPIOLIB
+	select HAS_IOPORT
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
 	select HAVE_ARCH_SECCOMP_FILTER
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 82154952e574..40198a1ebe27 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -18,6 +18,7 @@ config M68K
 	select GENERIC_CPU_DEVICES
 	select GENERIC_IOMAP
 	select GENERIC_IRQ_SHOW
+	select HAS_IOPORT if PCI || ISA || ATARI_ROM_ISA
 	select HAVE_ARCH_SECCOMP
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ASM_MODVERSIONS
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index cc88af6fa7a4..211f338d6235 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -21,6 +21,7 @@ config MICROBLAZE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK
+	select HAS_IOPORT if PCI
 	select HAVE_ARCH_HASH
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_SECCOMP
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e2f3ca73f40d..2ea3539a07ad 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -47,6 +47,7 @@ config MIPS
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GUP_GET_PXX_LOW_HIGH if CPU_MIPS32 && PHYS_ADDR_T_64BIT
+	select HAS_IOPORT if !NO_IOPORT_MAP || ISA
 	select HAVE_ARCH_COMPILER_H
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KGDB if MIPS_FP_SUPPORT
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index a98940e64243..466a25525364 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -47,6 +47,7 @@ config PARISC
 	select MODULES_USE_ELF_RELA
 	select CLONE_BACKWARDS
 	select TTY # Needed for pdc_cons.c
+	select HAS_IOPORT if PCI || EISA
 	select HAVE_DEBUG_STACKOVERFLOW
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HASH
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a6c4407d3ec8..02fd9bcd9215 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -188,6 +188,7 @@ config PPC
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_VDSO_TIME_NS
+	select HAS_IOPORT			if PCI
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMALLOC		if HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_HUGE_VMAP		if PPC_RADIX_MMU || PPC_8xx
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c5e42cc37604..b957d12a171b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -74,6 +74,7 @@ config RISCV
 	select GENERIC_TIME_VSYSCALL if MMU && 64BIT
 	select GENERIC_VDSO_TIME_NS if HAVE_GENERIC_VDSO
 	select HARDIRQS_SW_RESEND
+	select HAS_IOPORT if MMU
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMALLOC if HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_HUGE_VMAP if MMU && 64BIT && !XIP_KERNEL
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 0665ac0add0b..cfb797bc4200 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -25,6 +25,7 @@ config SUPERH
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select GUP_GET_PXX_LOW_HIGH if X2TLB
+	select HAS_IOPORT if HAS_IOPORT_MAP
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_SECCOMP_FILTER
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 84437a4c6545..d4c1d96f85cd 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -32,6 +32,7 @@ config SPARC
 	select GENERIC_IRQ_SHOW
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select GENERIC_PCI_IOMAP
+	select HAS_IOPORT
 	select HAVE_NMI_WATCHDOG if SPARC64
 	select HAVE_CBPF_JIT if SPARC32
 	select HAVE_EBPF_JIT if SPARC64
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a825bf031f49..44514c63a476 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -162,6 +162,7 @@ config X86
 	select GUP_GET_PXX_LOW_HIGH		if X86_PAE
 	select HARDIRQS_SW_RESEND
 	select HARDLOCKUP_CHECK_TIMESTAMP	if X86_64
+	select HAS_IOPORT
 	select HAVE_ACPI_APEI			if ACPI
 	select HAVE_ACPI_APEI_NMI		if ACPI
 	select HAVE_ALIGNED_STRUCT_PAGE		if SLUB
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 7bfe998f3514..fcfa280df98a 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -81,7 +81,7 @@ config MOXTET
 config HISILICON_LPC
 	bool "Support for ISA I/O space on HiSilicon Hip06/7"
 	depends on (ARM64 && ARCH_HISI) || (COMPILE_TEST && !ALPHA && !HEXAGON && !PARISC)
-	depends on HAS_IOMEM
+	depends on HAS_IOPORT
 	select INDIRECT_PIO if ARM64
 	help
 	  Driver to enable I/O access to devices attached to the Low Pin
diff --git a/drivers/parisc/Kconfig b/drivers/parisc/Kconfig
index 9eb2c1b5de7d..2fc3222d2634 100644
--- a/drivers/parisc/Kconfig
+++ b/drivers/parisc/Kconfig
@@ -4,6 +4,7 @@ menu "Bus options (PCI, PCMCIA, EISA, GSC, ISA)"
 config GSC
 	bool "VSC/GSC/HSC bus support"
 	select HAVE_EISA
+	select HAS_IOPORT
 	default y
 	help
 	  The VSC, GSC and HSC busses were used from the earliest 700-series
diff --git a/lib/Kconfig b/lib/Kconfig
index ce2abffb9ed8..5c2da561c516 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -92,6 +92,7 @@ config ARCH_USE_SYM_ANNOTATIONS
 config INDIRECT_PIO
 	bool "Access I/O in non-MMIO mode"
 	depends on ARM64
+	depends on HAS_IOPORT
 	help
 	  On some platforms where no separate I/O space exists, there are I/O
 	  hosts which can not be accessed in MMIO mode. Using the logical PIO
@@ -509,6 +510,9 @@ config HAS_IOMEM
 	depends on !NO_IOMEM
 	default y
 
+config HAS_IOPORT
+	bool
+
 config HAS_IOPORT_MAP
 	bool
 	depends on HAS_IOMEM && !NO_IOPORT_MAP

base-commit: e8d018dd0257f744ca50a729e3d042cf2ec9da65
-- 
2.37.2

