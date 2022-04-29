Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05CB514C40
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 16:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377203AbiD2OJi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 10:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377115AbiD2OJb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 10:09:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FA1D117B;
        Fri, 29 Apr 2022 07:01:10 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TBDTcs021204;
        Fri, 29 Apr 2022 13:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=DSYmU2KyqXgcAYYRjyeArvgju810FAKBNpHnSvEJAOk=;
 b=VSKE1evyZCC76igMGiQhDdrXgKlUgBp9E4rGzJEMpEl+r+FtKKRfe0GPBelcbfDoI0OA
 pRQpK3XIySZFZUERD0SEKUK0/vB45gjEvQzoPFu4j8SW7xV1PjEbwCmpWf2Xz8p1mFnX
 5VN3qOC/XfXyoYEdC2S9NAubnSDDwSluJP+FTgGde/6/pnY15+3EcfzeIY+PqXq0RBSp
 fieeTMm7OY5w9Ex+S0DzS95m9wLf3d5YarZBjvL6Eo4T8UhJmzoQJFAGizulSJF0DArR
 KwLnXgutqDPaWsvAYuiCMR24XDxm2ycWIVax7pwi3QMgnfd0T2bWQ7Ablex/adugEKiH jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fr27h15yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:17 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23TDm9iZ018377;
        Fri, 29 Apr 2022 13:51:16 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fr27h15xf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:16 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TDS7M1025989;
        Fri, 29 Apr 2022 13:51:14 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3fm938yafv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:13 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TDc24F51577340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:38:02 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 418974C044;
        Fri, 29 Apr 2022 13:51:11 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32F8D4C040;
        Fri, 29 Apr 2022 13:51:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 13:51:10 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        linux-alpha@vger.kernel.org (open list:ALPHA PORT),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT),
        linux-ia64@vger.kernel.org (open list:IA64 (Itanium) PLATFORM),
        linux-m68k@lists.linux-m68k.org (open list:M68K ARCHITECTURE),
        linux-mips@vger.kernel.org (open list:MIPS),
        linux-parisc@vger.kernel.org (open list:PARISC ARCHITECTURE),
        linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND
        64-BIT)),
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
        linux-sh@vger.kernel.org (open list:SUPERH),
        sparclinux@vger.kernel.org (open list:SPARC + UltraSPARC
        (sparc/sparc64))
Subject: [RFC v2 01/39] Kconfig: introduce HAS_IOPORT option and select it as necessary
Date:   Fri, 29 Apr 2022 15:49:59 +0200
Message-Id: <20220429135108.2781579-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429135108.2781579-1-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -P9J6AB2n6AMBUugkA7mMRpNV34BmBS_
X-Proofpoint-GUID: RcRk9MDBXbun4qDsErZKbZJh7zT5Xep-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_06,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 clxscore=1011 adultscore=0 priorityscore=1501 mlxlogscore=804
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204290078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We introduce a new HAS_IOPORT Kconfig option to indicate support for
I/O Port access. In a future patch HAS_IOPORT=n will disable compilation
of the I/O accessor functions inb()/outb() and friends on architectures
which can not meaningfully support legacy I/O spaces such as s390 or
where such support is optional. The "depends on" relations on HAS_IOPORT
in drivers as well as ifdefs for HAS_IOPORT specific sections will be
added in subsequent patches on a per subsystem basis.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/alpha/Kconfig      | 1 +
 arch/arm/Kconfig        | 1 +
 arch/arm64/Kconfig      | 1 +
 arch/ia64/Kconfig       | 1 +
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
 lib/Kconfig             | 4 ++++
 lib/Kconfig.kgdb        | 1 +
 16 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 7d0d26b5b3f5..2b9cf1b0bdb8 100644
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
index 2e8091e2d8a8..603ce00033a5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -69,6 +69,7 @@ config ARM
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select HARDIRQS_SW_RESEND
+	select HAS_IOPORT
 	select HAVE_ARCH_AUDITSYSCALL if AEABI && !OABI_COMPAT
 	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 20ea89d9ac2f..234dc89a7654 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -136,6 +136,7 @@ config ARM64
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_VDSO_TIME_NS
 	select HARDIRQS_SW_RESEND
+	select HAS_IOPORT
 	select HAVE_MOVE_PMD
 	select HAVE_MOVE_PUD
 	select HAVE_PCI
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index cb93769a9f2a..0fffe5130a80 100644
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
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 936cce42ae9a..54bf0a40c2f0 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -18,6 +18,7 @@ config M68K
 	select GENERIC_CPU_DEVICES
 	select GENERIC_IOMAP
 	select GENERIC_IRQ_SHOW
+	select HAS_IOPORT if PCI || ISA || ATARI_ROM_ISA
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS if !CPU_HAS_NO_UNALIGNED
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 8cf429ad1c84..966a6682f1fc 100644
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
index de3b32a507d2..4c55df08d6f1 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -47,6 +47,7 @@ config MIPS
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GUP_GET_PTE_LOW_HIGH if CPU_MIPS32 && PHYS_ADDR_T_64BIT
+	select HAS_IOPORT
 	select HAVE_ARCH_COMPILER_H
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KGDB if MIPS_FP_SUPPORT
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 52e550b45692..741c5c64c173 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -46,6 +46,7 @@ config PARISC
 	select MODULES_USE_ELF_RELA
 	select CLONE_BACKWARDS
 	select TTY # Needed for pdc_cons.c
+	select HAS_IOPORT if PCI || EISA
 	select HAVE_DEBUG_STACKOVERFLOW
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HASH
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 174edabb74fa..7133cc35b777 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -182,6 +182,7 @@ config PPC
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_VDSO_TIME_NS
+	select HAS_IOPORT			if PCI
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMALLOC		if HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_HUGE_VMAP		if PPC_RADIX_MMU || PPC_8xx
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 00fd9c548f26..27fc8a450478 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -67,6 +67,7 @@ config RISCV
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL if MMU && 64BIT
 	select GENERIC_VDSO_TIME_NS if HAVE_GENERIC_VDSO
+	select HAS_IOPORT if MMU
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE if !XIP_KERNEL
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 5f220e903e5a..6c1694e82b89 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -25,6 +25,7 @@ config SUPERH
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select GUP_GET_PTE_LOW_HIGH if X2TLB
+	select HAS_IOPORT if HAS_IOPORT_MAP
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_SECCOMP_FILTER
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 9200bc04701c..64736476dde8 100644
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
index b0142e01002e..9ef0438d1b7d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -155,6 +155,7 @@ config X86
 	select GUP_GET_PTE_LOW_HIGH		if X86_PAE
 	select HARDIRQS_SW_RESEND
 	select HARDLOCKUP_CHECK_TIMESTAMP	if X86_64
+	select HAS_IOPORT
 	select HAVE_ACPI_APEI			if ACPI
 	select HAVE_ACPI_APEI_NMI		if ACPI
 	select HAVE_ALIGNED_STRUCT_PAGE		if SLUB
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 3c68e174a113..a61285100224 100644
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
diff --git a/lib/Kconfig b/lib/Kconfig
index 087e06b4cdfd..177fed9cf20a 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -91,6 +91,7 @@ config ARCH_USE_SYM_ANNOTATIONS
 config INDIRECT_PIO
 	bool "Access I/O in non-MMIO mode"
 	depends on ARM64
+	depends on HAS_IOPORT
 	help
 	  On some platforms where no separate I/O space exists, there are I/O
 	  hosts which can not be accessed in MMIO mode. Using the logical PIO
@@ -493,6 +494,9 @@ config HAS_IOMEM
 	depends on !NO_IOMEM
 	default y
 
+config HAS_IOPORT
+	def_bool ISA
+
 config HAS_IOPORT_MAP
 	bool
 	depends on HAS_IOMEM && !NO_IOPORT_MAP
diff --git a/lib/Kconfig.kgdb b/lib/Kconfig.kgdb
index 05dae05b6cc9..c68e4d9dcecb 100644
--- a/lib/Kconfig.kgdb
+++ b/lib/Kconfig.kgdb
@@ -121,6 +121,7 @@ config KDB_DEFAULT_ENABLE
 
 config KDB_KEYBOARD
 	bool "KGDB_KDB: keyboard as input device"
+	depends on HAS_IOPORT
 	depends on VT && KGDB_KDB
 	default n
 	help
-- 
2.32.0

