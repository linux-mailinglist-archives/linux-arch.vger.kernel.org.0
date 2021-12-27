Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB6048025E
	for <lists+linux-arch@lfdr.de>; Mon, 27 Dec 2021 17:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhL0QrI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Dec 2021 11:47:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65524 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231855AbhL0QpH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Dec 2021 11:45:07 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BRDkivX013769;
        Mon, 27 Dec 2021 16:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=a6CvO1zF2yDDW90HYpgGNz8wQOHAyGwgOTEPaoj9kIY=;
 b=J9+6XZPfuPEdoC5Kd4MtHYN8YTYXYGLYgFOC2yJaQP/J8HN0gvx1piwhgFuJlAPtseGT
 YW8dSJ3SVowg3NQbFeLysbuNlWe3VsUus4vCDYa4pbBYGrtl/0PVQT0XYtNg9SXb3UGX
 uuMAZVrWNOs/tfgrn/UH2P6PmdjakqYr8r/OiPnPXHKjaocFJ45oUhKF+1xPa2UlBV8i
 baKLhqliUa28FEjsHHTX1mur+lbi2NheNexTWF0gC2mFLtvXFn5SdukNGekdddFI5ow0
 JNKdCWXV/fCOGJNTV+GKxp91v2w8EVrZ9j/UluYMbn9+dq0gO56PgectL27hGGKyr8/m +w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d7dqem140-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:34 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BRGcP7B013329;
        Mon, 27 Dec 2021 16:43:33 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d7dqem135-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:32 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BRGbvhJ008362;
        Mon, 27 Dec 2021 16:43:30 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3d5txakf86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:30 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BRGhRSc43057618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Dec 2021 16:43:27 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C058A4062;
        Mon, 27 Dec 2021 16:43:27 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FBADA405B;
        Mon, 27 Dec 2021 16:43:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Dec 2021 16:43:25 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Karol Gugala <kgugala@antmicro.com>,
        Jeff Dike <jdike@addtoit.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Brian Cain <bcain@codeaurora.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        openrisc@lists.librecores.org, linux-s390@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [RFC 02/32] Kconfig: introduce HAS_IOPORT option and select it as necessary
Date:   Mon, 27 Dec 2021 17:42:47 +0100
Message-Id: <20211227164317.4146918-3-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227164317.4146918-1-schnelle@linux.ibm.com>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: isunVRZjJ6JiKqeiQVOJvEmV8qSRZgu6
X-Proofpoint-ORIG-GUID: NOj8zVp-UdJWaGmLhuKmlC5md2AkCEZR
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-27_08,2021-12-24_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 mlxscore=0 impostorscore=0 mlxlogscore=872
 priorityscore=1501 bulkscore=0 clxscore=1011 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112270080
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We introduce a new HAS_IOPORT Kconfig option to gate support for
I/O port access. In a future patch HAS_IOPORT=n will disable compilation
of the I/O accessor functions inb()/outb() and friends on architectures
which can not meaningfully support legacy I/O spaces. On these platforms
inb()/outb() etc are currently just stubs in asm-generic/io.h which when
called will cause a NULL pointer access which some compilers actually
detect and warn about.

The dependencies on HAS_IOPORT in drivers as well as ifdefs for
HAS_IOPORT specific sections will be added in subsequent patches on
a per subsystem basis. Then a final patch will ifdef the I/O access
functions on HAS_IOPORT thus turning any use not gated by HAS_IOPORT
into a compile-time warning.

Link: https://lore.kernel.org/lkml/CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com/
Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/alpha/Kconfig      | 1 +
 arch/arc/Kconfig        | 1 +
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
 17 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 4e87783c90ad..472a0c5e4c2f 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -28,6 +28,7 @@ config ALPHA
 	select AUDIT_ARCH
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_SMP_IDLE_THREAD
+	select HAS_IOPORT
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_MOD_ARCH_SPECIFIC
 	select MODULES_USE_ELF_RELA
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index b4ae6058902a..b3911ebbd237 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -27,6 +27,7 @@ config ARC
 	select GENERIC_PENDING_IRQ if SMP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
+	select HAS_IOPORT
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if ARC_MMU_V4
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c2724d986fa0..605709b6eecb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -66,6 +66,7 @@ config ARM
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select HARDIRQS_SW_RESEND
+	select HAS_IOPORT
 	select HAVE_ARCH_AUDITSYSCALL if AEABI && !OABI_COMPAT
 	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c4207cf9bb17..a8b199a40c8f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -135,6 +135,7 @@ config ARM64
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_VDSO_TIME_NS
 	select HARDIRQS_SW_RESEND
+	select HAS_IOPORT
 	select HAVE_MOVE_PMD
 	select HAVE_MOVE_PUD
 	select HAVE_PCI
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 1e33666fa679..672aa2a88b19 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -24,6 +24,7 @@ config IA64
 	select PCI_DOMAINS if PCI
 	select PCI_MSI
 	select PCI_SYSCALL if PCI
+	select HAS_IOPORT
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_EXIT_THREAD
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 0b50da08a9c5..926d97c33828 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -16,6 +16,7 @@ config M68K
 	select GENERIC_CPU_DEVICES
 	select GENERIC_IOMAP
 	select GENERIC_IRQ_SHOW
+	select HAS_IOPORT
 	select HAVE_AOUT if MMU
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_DEBUG_BUGVERBOSE
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 59798e43cdb0..213ef2940079 100644
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
index 0215dc1529e9..87e6e7c29493 100644
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
index 011dc32fdb4d..b352c6dbbead 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -43,6 +43,7 @@ config PARISC
 	select MODULES_USE_ELF_RELA
 	select CLONE_BACKWARDS
 	select TTY # Needed for pdc_cons.c
+	select HAS_IOPORT if PCI || EISA
 	select HAVE_DEBUG_STACKOVERFLOW
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HASH
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index dea74d7717c0..d39ba34d839a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -185,6 +185,7 @@ config PPC
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_VDSO_TIME_NS
+	select HAS_IOPORT			if PCI
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMALLOC		if HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_HUGE_VMAP		if PPC_RADIX_MMU || PPC_8xx
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 821252b65f89..b69cc86522fb 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -63,6 +63,7 @@ config RISCV
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL if MMU && 64BIT
 	select GENERIC_VDSO_TIME_NS if HAVE_GENERIC_VDSO
+	select HAS_IOPORT if MMU
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE if !XIP_KERNEL
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 70afb30e0b32..334a52535379 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -24,6 +24,7 @@ config SUPERH
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select GUP_GET_PTE_LOW_HIGH if X2TLB
+	select HAS_IOPORT if HAS_IOPORT_MAP
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_SECCOMP_FILTER
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 66fc08646be5..728598673724 100644
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
index 5c2ccb85f2ef..8d3cfd693559 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -153,6 +153,7 @@ config X86
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
index 5e7165e6a346..e55746625762 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -95,6 +95,7 @@ config ARCH_USE_SYM_ANNOTATIONS
 config INDIRECT_PIO
 	bool "Access I/O in non-MMIO mode"
 	depends on ARM64
+	depends on HAS_IOPORT
 	help
 	  On some platforms where no separate I/O space exists, there are I/O
 	  hosts which can not be accessed in MMIO mode. Using the logical PIO
@@ -486,6 +487,9 @@ config HAS_IOMEM
 	depends on !NO_IOMEM
 	default y
 
+config HAS_IOPORT
+	def_bool ISA || LEGACY_PCI
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

