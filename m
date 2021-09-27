Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794AA418F2B
	for <lists+linux-arch@lfdr.de>; Mon, 27 Sep 2021 08:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbhI0GrB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Sep 2021 02:47:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232955AbhI0GrA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Sep 2021 02:47:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6048B6113D;
        Mon, 27 Sep 2021 06:45:19 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V4 01/22] Documentation: LoongArch: Add basic documentations
Date:   Mon, 27 Sep 2021 14:42:38 +0800
Message-Id: <20210927064300.624279-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210927064300.624279-1-chenhuacai@loongson.cn>
References: <20210927064300.624279-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add some basic documentation for LoongArch. LoongArch is a new RISC ISA,
which is a bit like MIPS or RISC-V. LoongArch includes a reduced 32-bit
version (LA32R), a standard 32-bit version (LA32S) and a 64-bit version
(LA64).

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 Documentation/arch.rst                     |   1 +
 Documentation/loongarch/features.rst       |   3 +
 Documentation/loongarch/index.rst          |  21 ++
 Documentation/loongarch/introduction.rst   | 342 +++++++++++++++++++++
 Documentation/loongarch/irq-chip-model.rst | 158 ++++++++++
 5 files changed, 525 insertions(+)
 create mode 100644 Documentation/loongarch/features.rst
 create mode 100644 Documentation/loongarch/index.rst
 create mode 100644 Documentation/loongarch/introduction.rst
 create mode 100644 Documentation/loongarch/irq-chip-model.rst

diff --git a/Documentation/arch.rst b/Documentation/arch.rst
index f10bd32a5972..ed6956289e4d 100644
--- a/Documentation/arch.rst
+++ b/Documentation/arch.rst
@@ -12,6 +12,7 @@ implementation.
    arm/index
    arm64/index
    ia64/index
+   loongarch/index
    m68k/index
    mips/index
    nios2/index
diff --git a/Documentation/loongarch/features.rst b/Documentation/loongarch/features.rst
new file mode 100644
index 000000000000..ebacade3ea45
--- /dev/null
+++ b/Documentation/loongarch/features.rst
@@ -0,0 +1,3 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. kernel-feat:: $srctree/Documentation/features loongarch
diff --git a/Documentation/loongarch/index.rst b/Documentation/loongarch/index.rst
new file mode 100644
index 000000000000..d127e07a7ed3
--- /dev/null
+++ b/Documentation/loongarch/index.rst
@@ -0,0 +1,21 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================================
+LoongArch-specific Documentation
+================================
+
+.. toctree::
+   :maxdepth: 2
+   :numbered:
+
+   introduction
+   irq-chip-model
+
+   features
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/loongarch/introduction.rst b/Documentation/loongarch/introduction.rst
new file mode 100644
index 000000000000..888ba67fcc1b
--- /dev/null
+++ b/Documentation/loongarch/introduction.rst
@@ -0,0 +1,342 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================
+Introduction of LoongArch
+=========================
+
+LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V. LoongArch
+includes a reduced 32-bit version (LA32R), a standard 32-bit version (LA32S)
+and a 64-bit version (LA64). LoongArch has 4 privilege levels (PLV0~PLV3),
+PLV0 is the highest level which used by kernel, and PLV3 is the lowest level
+which used by applications. This document introduces the registers, basic
+instruction set, virtual memory and some other topics of LoongArch.
+
+Registers
+=========
+
+LoongArch registers include general purpose registers (GPRs), floating point
+registers (FPRs), vector registers (VRs) and control status registers (CSRs)
+used in privileged mode (PLV0).
+
+GPRs
+----
+
+LoongArch has 32 GPRs ($r0 - $r31), each one is 32bit wide in LA32 and 64bit
+wide in LA64. $r0 is always zero, and other registers has no special feature,
+but we actually have an ABI register convention as below.
+
+================= =============== =================== ============
+Name              Alias           Usage               Preserved
+                                                      across calls
+================= =============== =================== ============
+``$r0``           ``$zero``       Constant zero       Unused
+``$r1``           ``$ra``         Return address      No
+``$r2``           ``$tp``         TLS                 Unused
+``$r3``           ``$sp``         Stack pointer       Yes
+``$r4``-``$r11``  ``$a0``-``$a7`` Argument registers  No
+``$r4``-``$r5``   ``$v0``-``$v1`` Return value        No
+``$r12``-``$r20`` ``$t0``-``$t8`` Temp registers      No
+``$r21``          ``$x``          Reserved            Unused
+``$r22``          ``$fp``         Frame pointer       Yes
+``$r23``-``$r31`` ``$s0``-``$s8`` Static registers    Yes
+================= =============== =================== ============
+
+FPRs
+----
+
+LoongArch has 32 FPRs ($f0 - $f31), each one is 64bit wide. We also have an
+ABI register conversion as below.
+
+================= ================== =================== ============
+Name              Alias              Usage               Preserved
+                                                         across calls
+================= ================== =================== ============
+``$f0``-``$f7``   ``$fa0``-``$fa7``  Argument registers  No
+``$f0``-``$f1``   ``$fv0``-``$fv1``  Return value        No
+``$f8``-``$f23``  ``$ft0``-``$ft15`` Temp registers      No
+``$f24``-``$f31`` ``$fs0``-``$fs7``  Static registers    Yes
+================= ================== =================== ============
+
+VRs
+----
+
+LoongArch has 128bit vector extension (LSX, short for Loongson SIMD eXtention)
+and 256bit vector extension (LASX, short for Loongson Advanced SIMD eXtension).
+There are also 32 vector registers, for LSX is $v0 - $v31, and for LASX is $x0
+- $x31. FPRs and VRs are reused, e.g. the lower 128bits of $x0 is $v0, and the
+lower 64bits of $v0 is $f0, etc.
+
+CSRs
+----
+
+CSRs can only be used in privileged mode (PLV0):
+
+================= ===================================== ==============
+Address           Full Name                             Abbrev Name
+================= ===================================== ==============
+0x0               Current Mode information              CRMD
+0x1               Pre-exception Mode information        PRMD
+0x2               Extended Unit Enable                  EUEN
+0x3               Miscellaneous controller              MISC
+0x4               Exception Configuration               ECFG
+0x5               Exception Status                      ESTAT
+0x6               Exception Return Address              ERA
+0x7               Bad Virtual Address                   BADV
+0x8               Bad Instruction                       BADI
+0xC               Exception Entry Base address          EENTRY
+0x10              TLB Index                             TLBIDX
+0x11              TLB Entry High-order bits             TLBEHI
+0x12              TLB Entry Low-order bits 0            TLBELO0
+0x13              TLB Entry Low-order bits 1            TLBELO1
+0x18              Address Space Identifier              ASID
+0x19              Page Global Directory address for     PGDL
+                  Lower half address space
+0x1A              Page Global Directory address for     PGDH
+                  Higher half address space
+0x1B              Page Global Directory address         PGD
+0x1C              Page Walk Controller for Lower        PWCL
+                  half address space
+0x1D              Page Walk Controller for Higher       PWCH
+                  half address space
+0x1E              STLB Page Size                        STLBPS
+0x1F              Reduced Virtual Address Configuration RVACFG
+0x20              CPU Identifier                        CPUID
+0x21              Privileged Resource Configuration 1   PRCFG1
+0x22              Privileged Resource Configuration 2   PRCFG2
+0x23              Privileged Resource Configuration 3   PRCFG3
+0x30+n (0≤n≤15)   Data Save register                    SAVEn
+0x40              Timer Identifier                      TID
+0x41              Timer Configuration                   TCFG
+0x42              Timer Value                           TVAL
+0x43              Compensation of Timer Count           CNTC
+0x44              Timer Interrupt Clearing              TICLR
+0x60              LLBit Controller                      LLBCTL
+0x80              Implementation-specific Controller 1  IMPCTL1
+0x81              Implementation-specific Controller 2  IMPCTL2
+0x88              TLB Refill Exception Entry Base       TLBRENTRY
+                  address
+0x89              TLB Refill Exception BAD Virtual      TLBRBADV
+                  address
+0x8A              TLB Refill Exception Return Address   TLBRERA
+0x8B              TLB Refill Exception data SAVE        TLBRSAVE
+                  register
+0x8C              TLB Refill Exception Entry Low-order  TLBRELO0
+                  bits 0
+0x8D              TLB Refill Exception Entry Low-order  TLBRELO1
+                  bits 1
+0x8E              TLB Refill Exception Entry High-order TLBEHI
+                  bits
+0x8F              TLB Refill Exception Pre-exception    TLBRPRMD
+                  Mode information
+0x90              Machine Error Controller              MERRCTL
+0x91              Machine Error Information 1           MERRINFO1
+0x92              Machine Error Information 2           MERRINFO2
+0x93              Machine Error Exception Entry Base    MERRENTRY
+                  address
+0x94              Machine Error Exception Return        MERRERA
+                  address
+0x95              Machine Error Exception data SAVE     MERRSAVE
+                  register
+0x98              Cache TAGs                            CTAG
+0x180+n (0≤n≤3)   Direct Mapping configuration Window n DMWn
+0x200+2n (0≤n≤31) Performance Monitor Configuration n   PMCFGn
+0x201+2n (0≤n≤31) Performance Monitor overall Counter n PMCNTn
+0x300             Memory load/store WatchPoint          MWPC
+                  overall Controller
+0x301             Memory load/store WatchPoint          MWPS
+                  overall Status
+0x310+8n (0≤n≤7)  Memory load/store WatchPoint n        MWPnCFG1
+                  Configuration 1
+0x311+8n (0≤n≤7)  Memory load/store WatchPoint n        MWPnCFG2
+                  Configuration 2
+0x312+8n (0≤n≤7)  Memory load/store WatchPoint n        MWPnCFG3
+                  Configuration 3
+0x313+8n (0≤n≤7)  Memory load/store WatchPoint n        MWPnCFG4
+                  Configuration 4
+0x380             Fetch WatchPoint overall Controller   FWPC
+0x381             Fetch WatchPoint overall Status       FWPS
+0x390+8n (0≤n≤7)  Fetch WatchPoint n Configuration 1    FWPnCFG1
+0x391+8n (0≤n≤7)  Fetch WatchPoint n Configuration 2    FWPnCFG2
+0x392+8n (0≤n≤7)  Fetch WatchPoint n Configuration 3    FWPnCFG3
+0x393+8n (0≤n≤7)  Fetch WatchPoint n Configuration 4    FWPnCFG4
+0x500             Debug register                        DBG
+0x501             Debug Exception Return address        DERA
+0x502             Debug data SAVE register              DSAVE
+================= ===================================== ==============
+
+Basic Instruction Set
+=====================
+
+Instruction formats
+-------------------
+
+LoongArch has 32-bit wide instructions, and there are 9 instruction formats::
+
+  2R-type:    Opcode + Rj + Rd
+  3R-type:    Opcode + Rk + Rj + Rd
+  4R-type:    Opcode + Ra + Rk + Rj + Rd
+  2RI8-type:  Opcode + I8 + Rj + Rd
+  2RI12-type: Opcode + I12 + Rj + Rd
+  2RI14-type: Opcode + I14 + Rj + Rd
+  2RI16-type: Opcode + I16 + Rj + Rd
+  1RI21-type: Opcode + I21L + Rj + I21H
+  I26-type:   Opcode + I26L + I26H
+
+Rj and Rk are source operands (register), Rd is destination operand (register),
+and Ra is the additional operand (register) in 4R-type. I8/I12/I16/I21/I26 are
+8-bits/12-bits/16-bits/21-bits/26bits immediate data. 21bits/26bits immediate
+data are split into higher bits and lower bits in an instruction word, so you
+can see I21L/I21H and I26L/I26H here.
+
+Instruction names (Mnemonics)
+-----------------------------
+
+We only list the instruction names here, for details please read the references.
+
+Arithmetic Operation Instructions::
+
+  ADD.W SUB.W ADDI.W ADD.D SUB.D ADDI.D
+  SLT SLTU SLTI SLTUI
+  AND OR NOR XOR ANDN ORN ANDI ORI XORI
+  MUL.W MULH.W MULH.WU DIV.W DIV.WU MOD.W MOD.WU
+  MUL.D MULH.D MULH.DU DIV.D DIV.DU MOD.D MOD.DU
+  PCADDI PCADDU12I PCADDU18I
+  LU12I.W LU32I.D LU52I.D ADDU16I.D
+
+Bit-shift Instructions::
+
+  SLL.W SRL.W SRA.W ROTR.W SLLI.W SRLI.W SRAI.W ROTRI.W
+  SLL.D SRL.D SRA.D ROTR.D SLLI.D SRLI.D SRAI.D ROTRI.D
+
+Bit-manipulation Instructions::
+
+  EXT.W.B EXT.W.H CLO.W CLO.D SLZ.W CLZ.D CTO.W CTO.D CTZ.W CTZ.D
+  BYTEPICK.W BYTEPICK.D BSTRINS.W BSTRINS.D BSTRPICK.W BSTRPICK.D
+  REVB.2H REVB.4H REVB.2W REVB.D REVH.2W REVH.D BITREV.4B BITREV.8B BITREV.W BITREV.D
+  MASKEQZ MASKNEZ
+
+Branch Instructions::
+
+  BEQ BNE BLT BGE BLTU BGEU BEQZ BNEZ B BL JIRL
+
+Load/Store Instructions::
+
+  LD.B LD.BU LD.H LD.HU LD.W LD.WU LD.D ST.B ST.H ST.W ST.D
+  LDX.B LDX.BU LDX.H LDX.HU LDX.W LDX.WU LDX.D STX.B STX.H STX.W STX.D
+  LDPTR.W LDPTR.D STPTR.W STPTR.D
+  PRELD PRELDX
+
+Atomic Operation Instructions::
+
+  LL.W SC.W LL.D SC.D
+  AMSWAP.W AMSWAP.D AMADD.W AMADD.D AMAND.W AMAND.D AMOR.W AMOR.D AMXOR.W AMXOR.D
+  AMMAX.W AMMAX.D AMMIN.W AMMIN.D
+
+Barrier Instructions::
+
+  IBAR DBAR
+
+Special Instructions::
+
+  SYSCALL BREAK CPUCFG NOP IDLE ERTN DBCL RDTIMEL.W RDTIMEH.W RDTIME.D ASRTLE.D ASRTGT.D
+
+Privileged Instructions::
+
+  CSRRD CSRWR CSRXCHG
+  IOCSRRD.B IOCSRRD.H IOCSRRD.W IOCSRRD.D IOCSRWR.B IOCSRWR.H IOCSRWR.W IOCSRWR.D
+  CACOP TLBP(TLBSRCH) TLBRD TLBWR TLBFILL TLBCLR TLBFLUSH INVTLB LDDIR LDPTE
+
+Virtual Memory
+==============
+
+LoongArch can use direct-mapped virtual memory and page-mapped virtual memory.
+
+Direct-mapped virtual memory is configured by CSR.DMWn (n=0~3), it has a simple
+relationship between virtual address (VA) and physical address (PA)::
+
+ VA = PA + FixedOffset
+
+Page-mapped virtual memory has arbitrary relationship between VA and PA, which
+is recorded in TLB and page tables. LoongArch's TLB includes a fully-associative
+MTLB (Multiple Page Size TLB) and set-associative STLB (Single Page Size TLB).
+
+By default, the whole virtual address space of LA32 is configured like this:
+
+============ =========================== =============================
+Name         Address Range               Attributes
+============ =========================== =============================
+``UVRANGE``  ``0x00000000 - 0x7FFFFFFF`` Page-mapped, Cached, PLV0~3
+``KPRANGE0`` ``0x80000000 - 0x9FFFFFFF`` Direct-mapped, Uncached, PLV0
+``KPRANGE1`` ``0xA0000000 - 0xBFFFFFFF`` Direct-mapped, Cached, PLV0
+``KVRANGE``  ``0xC0000000 - 0xFFFFFFFF`` Page-mapped, Cached, PLV0
+============ =========================== =============================
+
+User mode (PLV3) can only access UVRANGE. For direct-mapped KPRANGE0 and
+KPRANGE1, PA is equal to VA with bit30~31 cleared. For example, the uncached
+direct-mapped VA of 0x00001000 is 0x80001000, and the cached direct-mapped
+VA of 0x00001000 is 0xA0001000.
+
+By default, the whole virtual address space of LA64 is configured like this:
+
+============ ====================== ======================================
+Name         Address Range          Attributes
+============ ====================== ======================================
+``XUVRANGE`` ``0x0000000000000000 - Page-mapped, Cached, PLV0~3
+             0x3FFFFFFFFFFFFFFF``
+``XSPRANGE`` ``0x4000000000000000 - Direct-mapped, Cached / Uncached, PLV0
+             0x7FFFFFFFFFFFFFFF``
+``XKPRANGE`` ``0x8000000000000000 - Direct-mapped, Cached / Uncached, PLV0
+             0xBFFFFFFFFFFFFFFF``
+``XKVRANGE`` ``0xC000000000000000 - Page-mapped, Cached, PLV0
+             0xFFFFFFFFFFFFFFFF``
+============ ====================== ======================================
+
+User mode (PLV3) can only access XUVRANGE. For direct-mapped XSPRANGE and XKPRANGE,
+PA is equal to VA with bit60~63 cleared, and the cache attributes is configured by
+bit60~61 (0 is strongly-ordered uncached, 1 is coherent cached, and 2 is weakly-
+ordered uncached) in VA. Currently we only use XKPRANGE for direct mapping and
+XSPRANGE is reserved. As an example, the strongly-ordered uncached direct-mapped VA
+(in XKPRANGE) of 0x00000000 00001000 is 0x80000000 00001000, the coherent cached
+direct-mapped VA (in XKPRANGE) of 0x00000000 00001000 is 0x90000000 00001000, and
+the weakly-ordered uncached direct-mapped VA (in XKPRANGE) of 0x00000000 00001000
+is 0xA0000000 00001000.
+
+Relationship of Loongson and LoongArch
+======================================
+
+LoongArch is a RISC ISA which is different from any other existing ones, while
+Loongson is a family of processors. Loongson includes 3 series: Loongson-1 is
+the 32-bit processor series, Loongson-2 is the low-end 64-bit processor series,
+and Loongson-3 is the high-end 64-bit processor series. Old Loongson is based on
+MIPS, while New Loongson is based on LoongArch. Take Loongson-3 as an example:
+Loongson-3A1000/3B1500/3A2000/3A3000/3A4000 are MIPS-compatible, while Loongson-
+3A5000 (and future revisions) are all based on LoongArch.
+
+References
+==========
+
+Official web site of Loongson and LoongArch (Loongson Technology Corp. Ltd.):
+
+  http://www.loongson.cn/index.html
+
+Developer web site of Loongson and LoongArch (Software and Documentation):
+
+  http://www.loongnix.cn/index.php
+
+  https://github.com/loongson
+
+Documentation of LoongArch ISA:
+
+  https://github.com/loongson/LoongArch-Documentation/releases/latest/download/LoongArch-Vol1-v1.00-CN.pdf (in Chinese)
+
+  https://github.com/loongson/LoongArch-Documentation/releases/latest/download/LoongArch-Vol1-v1.00-EN.pdf (in English)
+
+Documentation of LoongArch ELF ABI:
+
+  https://github.com/loongson/LoongArch-Documentation/releases/latest/download/LoongArch-ELF-ABI-v1.00-CN.pdf (in Chinese)
+
+  https://github.com/loongson/LoongArch-Documentation/releases/latest/download/LoongArch-ELF-ABI-v1.00-EN.pdf (in English)
+
+Linux kernel repository of Loongson and LoongArch:
+
+  https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git
diff --git a/Documentation/loongarch/irq-chip-model.rst b/Documentation/loongarch/irq-chip-model.rst
new file mode 100644
index 000000000000..67dec56b84f2
--- /dev/null
+++ b/Documentation/loongarch/irq-chip-model.rst
@@ -0,0 +1,158 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================================
+IRQ chip model (hierarchy) of LoongArch
+=======================================
+
+Currently, LoongArch based processors (e.g. Loongson-3A5000) can only work together
+with LS7A chipsets. The irq chips in LoongArch computers include CPUINTC (CPU Core
+Interrupt Controller), LIOINTC (Legacy I/O Interrupt Controller), EIOINTC (Extended
+I/O Interrupt Controller), HTVECINTC (Hyper-Transport Vector Interrupt Controller),
+PCH-PIC (Main Interrupt Controller in LS7A chipset), PCH-LPC (LPC Interrupt Controller
+in LS7A chipset) and PCH-MSI (MSI Interrupt Controller).
+
+CPUINTC is a per-core controller (in CPU), LIOINTC/EIOINTC/HTVECINTC are per-package
+controllers (in CPU), while PCH-PIC/PCH-LPC/PCH-MSI are controllers out of CPU (i.e.,
+in chipsets). These controllers (in other words, irqchips) are linked in a hierarchy,
+and there are two models of hierarchy (legacy model and extended model).
+
+Legacy IRQ model
+================
+
+In this model, IPI (Inter-Processor Interrupt) and CPU Local Timer interrupt go
+to CPUINTC directly, CPU UARTS interrupts go to LIOINTC, while all other devices
+interrupts go to PCH-PIC/PCH-LPC/PCH-MSI and gathered by HTVECINTC, and then go
+to LIOINTC, and then CPUINTC.
+
+ +---------------------------------------------+
+ |::                                           |
+ |                                             |
+ |    +-----+     +---------+     +-------+    |
+ |    | IPI | --> | CPUINTC | <-- | Timer |    |
+ |    +-----+     +---------+     +-------+    |
+ |                     ^                       |
+ |                     |                       |
+ |                +---------+     +-------+    |
+ |                | LIOINTC | <-- | UARTs |    |
+ |                +---------+     +-------+    |
+ |                     ^                       |
+ |                     |                       |
+ |               +-----------+                 |
+ |               | HTVECINTC |                 |
+ |               +-----------+                 |
+ |                ^         ^                  |
+ |                |         |                  |
+ |          +---------+ +---------+            |
+ |          | PCH-PIC | | PCH-MSI |            |
+ |          +---------+ +---------+            |
+ |            ^     ^           ^              |
+ |            |     |           |              |
+ |    +---------+ +---------+ +---------+      |
+ |    | PCH-LPC | | Devices | | Devices |      |
+ |    +---------+ +---------+ +---------+      |
+ |         ^                                   |
+ |         |                                   |
+ |    +---------+                              |
+ |    | Devices |                              |
+ |    +---------+                              |
+ |                                             |
+ |                                             |
+ +---------------------------------------------+
+
+Extended IRQ model
+==================
+
+In this model, IPI (Inter-Processor Interrupt) and CPU Local Timer interrupt go
+to CPUINTC directly, CPU UARTS interrupts go to LIOINTC, while all other devices
+interrupts go to PCH-PIC/PCH-LPC/PCH-MSI and gathered by EIOINTC, and then go to
+to CPUINTC directly.
+
+ +--------------------------------------------------------+
+ |::                                                      |
+ |                                                        |
+ |         +-----+     +---------+     +-------+          |
+ |         | IPI | --> | CPUINTC | <-- | Timer |          |
+ |         +-----+     +---------+     +-------+          |
+ |                      ^       ^                         |
+ |                      |       |                         |
+ |               +---------+ +---------+     +-------+    |
+ |               | EIOINTC | | LIOINTC | <-- | UARTs |    |
+ |               +---------+ +---------+     +-------+    |
+ |                ^       ^                               |
+ |                |       |                               |
+ |         +---------+ +---------+                        |
+ |         | PCH-PIC | | PCH-MSI |                        |
+ |         +---------+ +---------+                        |
+ |           ^     ^           ^                          |
+ |           |     |           |                          |
+ |   +---------+ +---------+ +---------+                  |
+ |   | PCH-LPC | | Devices | | Devices |                  |
+ |   +---------+ +---------+ +---------+                  |
+ |        ^                                               |
+ |        |                                               |
+ |   +---------+                                          |
+ |   | Devices |                                          |
+ |   +---------+                                          |
+ |                                                        |
+ |                                                        |
+ +--------------------------------------------------------+
+
+ACPI-related definitions
+========================
+
+CPUINTC::
+
+  ACPI_MADT_TYPE_CORE_PIC;
+  struct acpi_madt_core_pic;
+  enum acpi_madt_core_pic_version;
+
+LIOINTC::
+
+  ACPI_MADT_TYPE_LIO_PIC;
+  struct acpi_madt_lio_pic;
+  enum acpi_madt_lio_pic_version;
+
+EIOINTC::
+
+  ACPI_MADT_TYPE_EIO_PIC;
+  struct acpi_madt_eio_pic;
+  enum acpi_madt_eio_pic_version;
+
+HTVECINTC::
+
+  ACPI_MADT_TYPE_HT_PIC;
+  struct acpi_madt_ht_pic;
+  enum acpi_madt_ht_pic_version;
+
+PCH-PIC::
+
+  ACPI_MADT_TYPE_BIO_PIC;
+  struct acpi_madt_bio_pic;
+  enum acpi_madt_bio_pic_version;
+
+PCH-MSI::
+
+  ACPI_MADT_TYPE_MSI_PIC;
+  struct acpi_madt_msi_pic;
+  enum acpi_madt_msi_pic_version;
+
+PCH-LPC::
+
+  ACPI_MADT_TYPE_LPC_PIC;
+  struct acpi_madt_lpc_pic;
+  enum acpi_madt_lpc_pic_version;
+
+References
+==========
+
+Documentation of Loongson-3A5000:
+
+  https://github.com/loongson/LoongArch-Documentation/releases/latest/download/Loongson-3A5000-usermanual-1.02-CN.pdf (in Chinese)
+
+  https://github.com/loongson/LoongArch-Documentation/releases/latest/download/Loongson-3A5000-usermanual-1.02-EN.pdf (in English)
+
+Documentation of Loongson's LS7A chipset:
+
+  https://github.com/loongson/LoongArch-Documentation/releases/latest/download/Loongson-7A1000-usermanual-2.00-CN.pdf (in Chinese)
+
+  https://github.com/loongson/LoongArch-Documentation/releases/latest/download/Loongson-7A1000-usermanual-2.00-EN.pdf (in English)
-- 
2.27.0

