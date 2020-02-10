Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6CC1581E7
	for <lists+linux-arch@lfdr.de>; Mon, 10 Feb 2020 19:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgBJSAy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Feb 2020 13:00:54 -0500
Received: from condef-07.nifty.com ([202.248.20.72]:29115 "EHLO
        condef-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbgBJSAy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Feb 2020 13:00:54 -0500
Received: from conuserg-09.nifty.com ([10.126.8.72])by condef-07.nifty.com with ESMTP id 01AHtosf006583
        for <linux-arch@vger.kernel.org>; Tue, 11 Feb 2020 02:55:50 +0900
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 01AHsssJ022740;
        Tue, 11 Feb 2020 02:54:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 01AHsssJ022740
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1581357295;
        bh=xjPR5Fb3zXZIyJpB95Nu3/wXv0c6Fc5wLklLyh08oMQ=;
        h=From:To:Cc:Subject:Date:From;
        b=uTCBuO0FyHuJvJa8nYh+Vk/PKd7iKeialTMDwEMnnFHu2ip86d5gt4aAa9cWgGiXN
         amcK8jDgEpIC9gyUw9foWsvsMd5P2jq1mkCCCUaF4GqyxeQmZ07Mab9VeuaTVlqKl+
         /e/CBycHZcyxiiBgrDHr9CkHbYkwBYNnJemTGcrxqo8pP1+fubNnuoNy2KSUdDhWm8
         1mCVmXY5jdwS+UNDYwvL334C+awwG9XSytppXW+QfwNApZNOVik0YInpB/Mqchyf07
         upSMqbseNOUM7NnLMCOr62YVVn8+AW/tZ9wIBE9HR/ADPErtTTMUCZnPaFZWydP3ck
         yKkQMtHooGqXA==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] asm-generic: make more kernel-space headers mandatory
Date:   Tue, 11 Feb 2020 02:54:52 +0900
Message-Id: <20200210175452.5030-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Change a header to mandatory-y if both of the following are met:

[1] At least one architecture (except um) specifies it as generic-y in
    arch/*/include/asm/Kbuild

[2] Every architecture (except um) either has its own implementation
    (arch/*/include/asm/*.h) or specifies it as generic-y in
    arch/*/include/asm/Kbuild

This commit was generated by the following shell script.

----------------------------------->8-----------------------------------

arches=$(cd arch; ls -1 | sed -e '/Kconfig/d' -e '/um/d')

tmpfile=$(mktemp)

grep "^mandatory-y +=" include/asm-generic/Kbuild > $tmpfile

find arch -path 'arch/*/include/asm/Kbuild' |
	xargs sed -n 's/^generic-y += \(.*\)/\1/p' | sort -u |
while read header
do
	mandatory=yes

	for arch in $arches
	do
		if ! grep -q "generic-y += $header" arch/$arch/include/asm/Kbuild &&
			! [ -f arch/$arch/include/asm/$header ]; then
			mandatory=no
			break
		fi
	done

	if [ "$mandatory" = yes ]; then
		echo "mandatory-y += $header" >> $tmpfile

		for arch in $arches
		do
			sed -i "/generic-y += $header/d" arch/$arch/include/asm/Kbuild
		done
	fi

done

sed -i '/^mandatory-y +=/d' include/asm-generic/Kbuild

LANG=C sort $tmpfile >> include/asm-generic/Kbuild

----------------------------------->8-----------------------------------

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

---

 arch/alpha/include/asm/Kbuild      | 11 -------
 arch/arc/include/asm/Kbuild        | 21 ------------
 arch/arm/include/asm/Kbuild        | 12 -------
 arch/arm64/include/asm/Kbuild      | 18 -----------
 arch/c6x/include/asm/Kbuild        | 37 ---------------------
 arch/csky/include/asm/Kbuild       | 37 ---------------------
 arch/h8300/include/asm/Kbuild      | 46 --------------------------
 arch/hexagon/include/asm/Kbuild    | 33 -------------------
 arch/ia64/include/asm/Kbuild       |  7 ----
 arch/m68k/include/asm/Kbuild       | 24 --------------
 arch/microblaze/include/asm/Kbuild | 30 -----------------
 arch/mips/include/asm/Kbuild       | 13 --------
 arch/nds32/include/asm/Kbuild      | 37 ---------------------
 arch/nios2/include/asm/Kbuild      | 38 ----------------------
 arch/openrisc/include/asm/Kbuild   | 36 ---------------------
 arch/parisc/include/asm/Kbuild     | 18 -----------
 arch/powerpc/include/asm/Kbuild    |  4 ---
 arch/riscv/include/asm/Kbuild      | 28 ----------------
 arch/s390/include/asm/Kbuild       | 15 ---------
 arch/sh/include/asm/Kbuild         | 16 ---------
 arch/sparc/include/asm/Kbuild      | 14 --------
 arch/unicore32/include/asm/Kbuild  | 34 -------------------
 arch/x86/include/asm/Kbuild        |  2 --
 arch/xtensa/include/asm/Kbuild     | 26 ---------------
 include/asm-generic/Kbuild         | 52 ++++++++++++++++++++++++++++++
 25 files changed, 52 insertions(+), 557 deletions(-)

diff --git a/arch/alpha/include/asm/Kbuild b/arch/alpha/include/asm/Kbuild
index 89e87bbc987f..42911c8340c7 100644
--- a/arch/alpha/include/asm/Kbuild
+++ b/arch/alpha/include/asm/Kbuild
@@ -1,17 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 generated-y += syscall_table.h
-generic-y += compat.h
-generic-y += exec.h
 generic-y += export.h
-generic-y += fb.h
-generic-y += irq_work.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
-generic-y += mmiowb.h
-generic-y += preempt.h
-generic-y += sections.h
-generic-y += trace_clock.h
-generic-y += current.h
-generic-y += kprobes.h
diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index 1b505694691e..81f4edec0c2a 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -1,28 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
-generic-y += bugs.h
-generic-y += compat.h
-generic-y += device.h
-generic-y += div64.h
-generic-y += dma-mapping.h
-generic-y += emergency-restart.h
 generic-y += extable.h
-generic-y += ftrace.h
-generic-y += hardirq.h
-generic-y += hw_irq.h
-generic-y += irq_regs.h
-generic-y += irq_work.h
 generic-y += kvm_para.h
-generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
-generic-y += mmiowb.h
 generic-y += parport.h
-generic-y += percpu.h
-generic-y += preempt.h
-generic-y += topology.h
-generic-y += trace_clock.h
 generic-y += user.h
-generic-y += vga.h
-generic-y += word-at-a-time.h
-generic-y += xor.h
diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index fa579b23b4df..383635b68763 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -1,22 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
-generic-y += compat.h
-generic-y += current.h
 generic-y += early_ioremap.h
-generic-y += emergency-restart.h
-generic-y += exec.h
 generic-y += extable.h
 generic-y += flat.h
-generic-y += irq_regs.h
-generic-y += kdebug.h
-generic-y += local.h
 generic-y += local64.h
-generic-y += mm-arch-hooks.h
-generic-y += mmiowb.h
 generic-y += parport.h
-generic-y += preempt.h
 generic-y += seccomp.h
-generic-y += serial.h
-generic-y += trace_clock.h
 
 generated-y += mach-types.h
 generated-y += unistd-nr.h
diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index d3077c991962..ff9cbb631212 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -1,26 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
-generic-y += bugs.h
-generic-y += delay.h
-generic-y += div64.h
-generic-y += dma.h
-generic-y += dma-mapping.h
 generic-y += early_ioremap.h
-generic-y += emergency-restart.h
-generic-y += hw_irq.h
-generic-y += irq_regs.h
-generic-y += kdebug.h
-generic-y += kmap_types.h
-generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
-generic-y += mmiowb.h
 generic-y += qrwlock.h
 generic-y += qspinlock.h
-generic-y += serial.h
 generic-y += set_memory.h
-generic-y += switch_to.h
-generic-y += trace_clock.h
-generic-y += unaligned.h
 generic-y += user.h
-generic-y += vga.h
diff --git a/arch/c6x/include/asm/Kbuild b/arch/c6x/include/asm/Kbuild
index a036e05fc3c6..a4ef93a1f7ae 100644
--- a/arch/c6x/include/asm/Kbuild
+++ b/arch/c6x/include/asm/Kbuild
@@ -1,42 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-generic-y += atomic.h
-generic-y += barrier.h
-generic-y += bugs.h
-generic-y += compat.h
-generic-y += current.h
-generic-y += device.h
-generic-y += div64.h
-generic-y += dma.h
-generic-y += dma-mapping.h
-generic-y += emergency-restart.h
-generic-y += exec.h
 generic-y += extable.h
-generic-y += fb.h
-generic-y += futex.h
-generic-y += hw_irq.h
-generic-y += io.h
-generic-y += irq_regs.h
-generic-y += irq_work.h
-generic-y += kdebug.h
-generic-y += kmap_types.h
-generic-y += kprobes.h
 generic-y += kvm_para.h
-generic-y += local.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
-generic-y += mmiowb.h
-generic-y += mmu.h
-generic-y += mmu_context.h
-generic-y += pci.h
-generic-y += percpu.h
-generic-y += pgalloc.h
-generic-y += preempt.h
-generic-y += serial.h
-generic-y += shmparam.h
-generic-y += tlbflush.h
-generic-y += topology.h
-generic-y += trace_clock.h
 generic-y += user.h
-generic-y += vga.h
-generic-y += word-at-a-time.h
-generic-y += xor.h
diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
index bc15a26c782f..93372255984d 100644
--- a/arch/csky/include/asm/Kbuild
+++ b/arch/csky/include/asm/Kbuild
@@ -1,45 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y += asm-offsets.h
-generic-y += bugs.h
-generic-y += compat.h
-generic-y += current.h
-generic-y += delay.h
-generic-y += device.h
-generic-y += div64.h
-generic-y += dma.h
-generic-y += dma-mapping.h
-generic-y += emergency-restart.h
-generic-y += exec.h
-generic-y += fb.h
-generic-y += futex.h
 generic-y += gpio.h
-generic-y += hardirq.h
-generic-y += hw_irq.h
-generic-y += irq.h
-generic-y += irq_regs.h
-generic-y += irq_work.h
-generic-y += kdebug.h
-generic-y += kmap_types.h
-generic-y += kprobes.h
 generic-y += kvm_para.h
-generic-y += linkage.h
-generic-y += local.h
 generic-y += local64.h
-generic-y += mm-arch-hooks.h
-generic-y += mmiowb.h
-generic-y += module.h
-generic-y += pci.h
-generic-y += percpu.h
-generic-y += preempt.h
 generic-y += qrwlock.h
-generic-y += sections.h
-generic-y += serial.h
-generic-y += timex.h
-generic-y += topology.h
-generic-y += trace_clock.h
-generic-y += unaligned.h
 generic-y += user.h
-generic-y += vga.h
 generic-y += vmlinux.lds.h
-generic-y += word-at-a-time.h
-generic-y += xor.h
diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
index 7f618190e1a9..ddf04f32b546 100644
--- a/arch/h8300/include/asm/Kbuild
+++ b/arch/h8300/include/asm/Kbuild
@@ -1,54 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y += asm-offsets.h
-generic-y += barrier.h
-generic-y += bugs.h
-generic-y += cacheflush.h
-generic-y += checksum.h
-generic-y += compat.h
-generic-y += current.h
-generic-y += delay.h
-generic-y += device.h
-generic-y += div64.h
-generic-y += dma.h
-generic-y += dma-mapping.h
-generic-y += emergency-restart.h
-generic-y += exec.h
 generic-y += extable.h
-generic-y += fb.h
-generic-y += ftrace.h
-generic-y += futex.h
-generic-y += hardirq.h
-generic-y += hw_irq.h
-generic-y += irq_regs.h
-generic-y += irq_work.h
-generic-y += kdebug.h
-generic-y += kmap_types.h
-generic-y += kprobes.h
 generic-y += kvm_para.h
-generic-y += linkage.h
-generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
-generic-y += mmiowb.h
-generic-y += mmu.h
-generic-y += mmu_context.h
-generic-y += module.h
 generic-y += parport.h
-generic-y += pci.h
-generic-y += percpu.h
-generic-y += pgalloc.h
-generic-y += preempt.h
-generic-y += sections.h
-generic-y += serial.h
-generic-y += shmparam.h
 generic-y += spinlock.h
-generic-y += timex.h
-generic-y += tlbflush.h
-generic-y += topology.h
-generic-y += trace_clock.h
-generic-y += uaccess.h
-generic-y += unaligned.h
-generic-y += vga.h
-generic-y += word-at-a-time.h
-generic-y += xor.h
diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
index 84bb1ed1b931..373964bb177e 100644
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -1,39 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-generic-y += barrier.h
-generic-y += bug.h
-generic-y += bugs.h
-generic-y += compat.h
-generic-y += current.h
-generic-y += device.h
-generic-y += div64.h
-generic-y += dma-mapping.h
-generic-y += emergency-restart.h
 generic-y += extable.h
-generic-y += fb.h
-generic-y += ftrace.h
-generic-y += hardirq.h
-generic-y += hw_irq.h
 generic-y += iomap.h
-generic-y += irq_regs.h
-generic-y += irq_work.h
-generic-y += kdebug.h
-generic-y += kmap_types.h
-generic-y += kprobes.h
 generic-y += kvm_para.h
-generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
-generic-y += mmiowb.h
-generic-y += pci.h
-generic-y += percpu.h
-generic-y += preempt.h
-generic-y += sections.h
-generic-y += serial.h
-generic-y += shmparam.h
-generic-y += topology.h
-generic-y += trace_clock.h
-generic-y += unaligned.h
-generic-y += vga.h
-generic-y += word-at-a-time.h
-generic-y += xor.h
diff --git a/arch/ia64/include/asm/Kbuild b/arch/ia64/include/asm/Kbuild
index 390393667d3b..f994c1daf9d4 100644
--- a/arch/ia64/include/asm/Kbuild
+++ b/arch/ia64/include/asm/Kbuild
@@ -1,12 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 generated-y += syscall_table.h
-generic-y += compat.h
-generic-y += exec.h
-generic-y += irq_work.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
-generic-y += preempt.h
-generic-y += trace_clock.h
 generic-y += vtime.h
-generic-y += word-at-a-time.h
diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 591d53b763b7..1bff55aa2d54 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -1,31 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 generated-y += syscall_table.h
-generic-y += barrier.h
-generic-y += compat.h
-generic-y += device.h
-generic-y += dma-mapping.h
-generic-y += emergency-restart.h
-generic-y += exec.h
 generic-y += extable.h
-generic-y += futex.h
-generic-y += hw_irq.h
-generic-y += irq_regs.h
-generic-y += irq_work.h
-generic-y += kdebug.h
-generic-y += kmap_types.h
-generic-y += kprobes.h
 generic-y += kvm_para.h
-generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
-generic-y += mmiowb.h
-generic-y += percpu.h
-generic-y += preempt.h
-generic-y += sections.h
-generic-y += shmparam.h
 generic-y += spinlock.h
-generic-y += topology.h
-generic-y += trace_clock.h
-generic-y += word-at-a-time.h
-generic-y += xor.h
diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index e5c9170a07fc..f38696d2b462 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -1,38 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 generated-y += syscall_table.h
-generic-y += barrier.h
-generic-y += bitops.h
-generic-y += bug.h
-generic-y += bugs.h
-generic-y += compat.h
-generic-y += device.h
-generic-y += div64.h
-generic-y += dma-mapping.h
-generic-y += emergency-restart.h
-generic-y += exec.h
 generic-y += extable.h
-generic-y += fb.h
-generic-y += hardirq.h
-generic-y += irq_regs.h
-generic-y += irq_work.h
-generic-y += kdebug.h
-generic-y += kmap_types.h
-generic-y += kprobes.h
 generic-y += kvm_para.h
-generic-y += linkage.h
-generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
-generic-y += mmiowb.h
 generic-y += parport.h
-generic-y += percpu.h
-generic-y += preempt.h
-generic-y += serial.h
-generic-y += shmparam.h
 generic-y += syscalls.h
-generic-y += topology.h
-generic-y += trace_clock.h
-generic-y += vga.h
-generic-y += word-at-a-time.h
-generic-y += xor.h
diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 4ebd8ce254ce..8643d313890e 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -4,23 +4,10 @@ generated-y += syscall_table_32_o32.h
 generated-y += syscall_table_64_n32.h
 generated-y += syscall_table_64_n64.h
 generated-y += syscall_table_64_o32.h
-generic-y += current.h
-generic-y += device.h
-generic-y += emergency-restart.h
 generic-y += export.h
-generic-y += irq_work.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
 generic-y += parport.h
-generic-y += percpu.h
-generic-y += preempt.h
 generic-y += qrwlock.h
 generic-y += qspinlock.h
-generic-y += sections.h
-generic-y += serial.h
-generic-y += trace_clock.h
-generic-y += unaligned.h
 generic-y += user.h
-generic-y += word-at-a-time.h
-generic-y += xor.h
diff --git a/arch/nds32/include/asm/Kbuild b/arch/nds32/include/asm/Kbuild
index 77eae62036b5..ff1e94299317 100644
--- a/arch/nds32/include/asm/Kbuild
+++ b/arch/nds32/include/asm/Kbuild
@@ -1,46 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y += asm-offsets.h
-generic-y += atomic.h
-generic-y += bitops.h
-generic-y += bug.h
-generic-y += bugs.h
-generic-y += checksum.h
 generic-y += cmpxchg.h
-generic-y += compat.h
-generic-y += device.h
-generic-y += div64.h
-generic-y += dma.h
-generic-y += dma-mapping.h
-generic-y += emergency-restart.h
-generic-y += exec.h
 generic-y += export.h
-generic-y += fb.h
 generic-y += gpio.h
-generic-y += hardirq.h
-generic-y += hw_irq.h
-generic-y += irq.h
-generic-y += irq_regs.h
-generic-y += irq_work.h
-generic-y += kdebug.h
-generic-y += kmap_types.h
-generic-y += kprobes.h
 generic-y += kvm_para.h
-generic-y += local.h
 generic-y += local64.h
-generic-y += mm-arch-hooks.h
-generic-y += mmiowb.h
 generic-y += parport.h
-generic-y += pci.h
-generic-y += percpu.h
-generic-y += preempt.h
-generic-y += sections.h
-generic-y += serial.h
-generic-y += switch_to.h
-generic-y += timex.h
-generic-y += topology.h
-generic-y += trace_clock.h
-generic-y += xor.h
-generic-y += unaligned.h
 generic-y += user.h
-generic-y += vga.h
-generic-y += word-at-a-time.h
diff --git a/arch/nios2/include/asm/Kbuild b/arch/nios2/include/asm/Kbuild
index 68093999bd26..7fe7437555fb 100644
--- a/arch/nios2/include/asm/Kbuild
+++ b/arch/nios2/include/asm/Kbuild
@@ -1,45 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
-generic-y += atomic.h
-generic-y += barrier.h
-generic-y += bitops.h
-generic-y += bug.h
-generic-y += bugs.h
 generic-y += cmpxchg.h
-generic-y += compat.h
-generic-y += current.h
-generic-y += device.h
-generic-y += div64.h
-generic-y += dma.h
-generic-y += dma-mapping.h
-generic-y += emergency-restart.h
-generic-y += exec.h
 generic-y += extable.h
-generic-y += fb.h
-generic-y += ftrace.h
-generic-y += futex.h
-generic-y += hardirq.h
-generic-y += hw_irq.h
-generic-y += irq_regs.h
-generic-y += irq_work.h
-generic-y += kdebug.h
-generic-y += kmap_types.h
-generic-y += kprobes.h
 generic-y += kvm_para.h
-generic-y += local.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
-generic-y += mmiowb.h
-generic-y += module.h
-generic-y += pci.h
-generic-y += percpu.h
-generic-y += preempt.h
-generic-y += sections.h
-generic-y += serial.h
 generic-y += spinlock.h
-generic-y += topology.h
-generic-y += trace_clock.h
-generic-y += unaligned.h
 generic-y += user.h
-generic-y += vga.h
-generic-y += word-at-a-time.h
-generic-y += xor.h
diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index e12d6c1735a0..ca5987e11053 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -1,45 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
-generic-y += barrier.h
-generic-y += bug.h
-generic-y += bugs.h
-generic-y += checksum.h
-generic-y += compat.h
-generic-y += current.h
-generic-y += device.h
-generic-y += div64.h
-generic-y += dma.h
-generic-y += dma-mapping.h
-generic-y += emergency-restart.h
-generic-y += exec.h
 generic-y += extable.h
-generic-y += fb.h
-generic-y += ftrace.h
-generic-y += hardirq.h
-generic-y += hw_irq.h
-generic-y += irq_regs.h
-generic-y += irq_work.h
-generic-y += kdebug.h
-generic-y += kmap_types.h
-generic-y += kprobes.h
 generic-y += kvm_para.h
-generic-y += local.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
-generic-y += mmiowb.h
-generic-y += module.h
-generic-y += pci.h
-generic-y += percpu.h
-generic-y += preempt.h
 generic-y += qspinlock_types.h
 generic-y += qspinlock.h
 generic-y += qrwlock_types.h
 generic-y += qrwlock.h
-generic-y += sections.h
-generic-y += shmparam.h
-generic-y += switch_to.h
-generic-y += topology.h
-generic-y += trace_clock.h
 generic-y += user.h
-generic-y += vga.h
-generic-y += word-at-a-time.h
-generic-y += xor.h
diff --git a/arch/parisc/include/asm/Kbuild b/arch/parisc/include/asm/Kbuild
index 9ceedf6393c4..e3ee5c0bfe80 100644
--- a/arch/parisc/include/asm/Kbuild
+++ b/arch/parisc/include/asm/Kbuild
@@ -2,26 +2,8 @@
 generated-y += syscall_table_32.h
 generated-y += syscall_table_64.h
 generated-y += syscall_table_c32.h
-generic-y += current.h
-generic-y += device.h
-generic-y += div64.h
-generic-y += emergency-restart.h
-generic-y += exec.h
-generic-y += hw_irq.h
-generic-y += irq_regs.h
-generic-y += irq_work.h
-generic-y += kdebug.h
 generic-y += kvm_para.h
-generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
-generic-y += mmiowb.h
-generic-y += percpu.h
-generic-y += preempt.h
 generic-y += seccomp.h
-generic-y += trace_clock.h
 generic-y += user.h
-generic-y += vga.h
-generic-y += word-at-a-time.h
-generic-y += xor.h
diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index d0a23d0db863..dadbcf3a0b1e 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -3,12 +3,8 @@ generated-y += syscall_table_32.h
 generated-y += syscall_table_64.h
 generated-y += syscall_table_c32.h
 generated-y += syscall_table_spu.h
-generic-y += div64.h
-generic-y += dma-mapping.h
 generic-y += export.h
-generic-y += irq_regs.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
-generic-y += preempt.h
 generic-y += vtime.h
 generic-y += early_ioremap.h
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index ec0ca8c6ab64..3d9410bb4de0 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -1,35 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
-generic-y += bugs.h
-generic-y += checksum.h
-generic-y += compat.h
-generic-y += device.h
-generic-y += div64.h
 generic-y += extable.h
 generic-y += flat.h
-generic-y += dma.h
-generic-y += dma-mapping.h
-generic-y += emergency-restart.h
-generic-y += exec.h
-generic-y += fb.h
-generic-y += hardirq.h
-generic-y += hw_irq.h
-generic-y += irq_regs.h
-generic-y += irq_work.h
-generic-y += kdebug.h
-generic-y += kmap_types.h
 generic-y += kvm_para.h
-generic-y += local.h
 generic-y += local64.h
-generic-y += mm-arch-hooks.h
-generic-y += percpu.h
-generic-y += preempt.h
-generic-y += sections.h
-generic-y += serial.h
-generic-y += shmparam.h
-generic-y += topology.h
-generic-y += trace_clock.h
-generic-y += unaligned.h
 generic-y += user.h
-generic-y += vga.h
 generic-y += vmlinux.lds.h
-generic-y += xor.h
diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index 1832ae6442ef..83f6e85de7bc 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -5,21 +5,6 @@ generated-y += syscall_table.h
 generated-y += unistd_nr.h
 
 generic-y += asm-offsets.h
-generic-y += cacheflush.h
-generic-y += device.h
-generic-y += dma-mapping.h
-generic-y += div64.h
-generic-y += emergency-restart.h
 generic-y += export.h
-generic-y += fb.h
-generic-y += irq_regs.h
-generic-y += irq_work.h
-generic-y += kmap_types.h
-generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
-generic-y += mmiowb.h
-generic-y += trace_clock.h
-generic-y += unaligned.h
-generic-y += word-at-a-time.h
diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index 51a54df22c11..7435182ef846 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -1,22 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 generated-y += syscall_table.h
-generic-y += compat.h
-generic-y += current.h
-generic-y += delay.h
-generic-y += div64.h
-generic-y += dma-mapping.h
-generic-y += emergency-restart.h
-generic-y += exec.h
-generic-y += irq_regs.h
-generic-y += irq_work.h
 generic-y += kvm_para.h
-generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
 generic-y += parport.h
-generic-y += percpu.h
-generic-y += preempt.h
-generic-y += serial.h
-generic-y += trace_clock.h
-generic-y += xor.h
diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index 62de2eb2773d..5269a704801f 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -4,21 +4,7 @@
 generated-y += syscall_table_32.h
 generated-y += syscall_table_64.h
 generated-y += syscall_table_c32.h
-generic-y += div64.h
-generic-y += emergency-restart.h
-generic-y += exec.h
 generic-y += export.h
-generic-y += irq_regs.h
-generic-y += irq_work.h
 generic-y += kvm_para.h
-generic-y += linkage.h
-generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
-generic-y += mmiowb.h
-generic-y += module.h
-generic-y += preempt.h
-generic-y += serial.h
-generic-y += trace_clock.h
-generic-y += word-at-a-time.h
diff --git a/arch/unicore32/include/asm/Kbuild b/arch/unicore32/include/asm/Kbuild
index 98aa125a8f06..55026e8240d8 100644
--- a/arch/unicore32/include/asm/Kbuild
+++ b/arch/unicore32/include/asm/Kbuild
@@ -1,41 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
-generic-y += atomic.h
-generic-y += bugs.h
-generic-y += compat.h
-generic-y += current.h
-generic-y += device.h
-generic-y += div64.h
-generic-y += dma-mapping.h
-generic-y += emergency-restart.h
-generic-y += exec.h
 generic-y += extable.h
-generic-y += fb.h
-generic-y += ftrace.h
-generic-y += futex.h
-generic-y += hardirq.h
-generic-y += hw_irq.h
-generic-y += irq_regs.h
-generic-y += irq_work.h
-generic-y += kdebug.h
-generic-y += kmap_types.h
-generic-y += kprobes.h
 generic-y += kvm_para.h
-generic-y += local.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
-generic-y += mmiowb.h
-generic-y += module.h
 generic-y += parport.h
-generic-y += percpu.h
-generic-y += preempt.h
-generic-y += sections.h
-generic-y += serial.h
-generic-y += shmparam.h
 generic-y += syscalls.h
-generic-y += topology.h
-generic-y += trace_clock.h
-generic-y += unaligned.h
 generic-y += user.h
-generic-y += vga.h
-generic-y += word-at-a-time.h
-generic-y += xor.h
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index ea34464d6221..b19ec8282d50 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -10,5 +10,3 @@ generated-y += xen-hypercalls.h
 generic-y += early_ioremap.h
 generic-y += export.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
-generic-y += mmiowb.h
diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
index 271917c24b7f..9718e9593564 100644
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -1,36 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 generated-y += syscall_table.h
-generic-y += bug.h
-generic-y += compat.h
-generic-y += device.h
-generic-y += div64.h
-generic-y += dma-mapping.h
-generic-y += emergency-restart.h
-generic-y += exec.h
 generic-y += extable.h
-generic-y += fb.h
-generic-y += hardirq.h
-generic-y += hw_irq.h
-generic-y += irq_regs.h
-generic-y += irq_work.h
-generic-y += kdebug.h
-generic-y += kmap_types.h
-generic-y += kprobes.h
 generic-y += kvm_para.h
-generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
-generic-y += mmiowb.h
 generic-y += param.h
-generic-y += percpu.h
-generic-y += preempt.h
 generic-y += qrwlock.h
 generic-y += qspinlock.h
-generic-y += sections.h
-generic-y += topology.h
-generic-y += trace_clock.h
 generic-y += user.h
-generic-y += vga.h
-generic-y += word-at-a-time.h
-generic-y += xor.h
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index cd17d50697cc..36341dfded70 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -4,6 +4,58 @@
 # (This file is not included when SRCARCH=um since UML borrows several
 # asm headers from the host architecutre.)
 
+mandatory-y += atomic.h
+mandatory-y += barrier.h
+mandatory-y += bitops.h
+mandatory-y += bug.h
+mandatory-y += bugs.h
+mandatory-y += cacheflush.h
+mandatory-y += checksum.h
+mandatory-y += compat.h
+mandatory-y += current.h
+mandatory-y += delay.h
+mandatory-y += device.h
+mandatory-y += div64.h
 mandatory-y += dma-contiguous.h
+mandatory-y += dma-mapping.h
+mandatory-y += dma.h
+mandatory-y += emergency-restart.h
+mandatory-y += exec.h
+mandatory-y += fb.h
+mandatory-y += ftrace.h
+mandatory-y += futex.h
+mandatory-y += hardirq.h
+mandatory-y += hw_irq.h
+mandatory-y += io.h
+mandatory-y += irq.h
+mandatory-y += irq_regs.h
+mandatory-y += irq_work.h
+mandatory-y += kdebug.h
+mandatory-y += kmap_types.h
+mandatory-y += kprobes.h
+mandatory-y += linkage.h
+mandatory-y += local.h
+mandatory-y += mm-arch-hooks.h
+mandatory-y += mmiowb.h
+mandatory-y += mmu.h
+mandatory-y += mmu_context.h
+mandatory-y += module.h
 mandatory-y += msi.h
+mandatory-y += pci.h
+mandatory-y += percpu.h
+mandatory-y += pgalloc.h
+mandatory-y += preempt.h
+mandatory-y += sections.h
+mandatory-y += serial.h
+mandatory-y += shmparam.h
 mandatory-y += simd.h
+mandatory-y += switch_to.h
+mandatory-y += timex.h
+mandatory-y += tlbflush.h
+mandatory-y += topology.h
+mandatory-y += trace_clock.h
+mandatory-y += uaccess.h
+mandatory-y += unaligned.h
+mandatory-y += vga.h
+mandatory-y += word-at-a-time.h
+mandatory-y += xor.h
-- 
2.17.1

