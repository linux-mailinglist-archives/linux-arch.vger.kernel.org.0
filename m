Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521802EA225
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jan 2021 02:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbhAEBAq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jan 2021 20:00:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:39314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728135AbhAEBAp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Jan 2021 20:00:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADCE6229C4;
        Tue,  5 Jan 2021 00:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609808380;
        bh=k5tUJHFjMO2s79xpLs4QJPdGWhJciPZsye1o8rF3dAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J3TSwo3nNU7X1fflv8qhWlBhn2SmnPDX6zcIj6O9oxknpuMjJ7N3yvo9ua4URUl0A
         PuUfYceIKgapinnC/7xgRiktpmKCh88uXW3LIc+YIkYPxRD/9TsV1xs0NmEEJ6pjuk
         oOPR+/OyUvkgYYruRtYDpBW7qfr/apzWLFoFvF4TGS/TmChN4wb9jYM6uX/RFJil+Z
         yH/zKrmA41wjU1rucnDW1bq8SawDIgRo6A2eiQ22TOP0a4SI8/53r6h2GhKGeDbolu
         KP0RRqhT1KCPIJETNATjvr6VeQAgN6iMWTc1LgWYyJbTxVaFthxWvx/CpUMxRgvKs3
         4F1Hff+G6hnoQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 13/17] local64.h: make <asm/local64.h> mandatory
Date:   Mon,  4 Jan 2021 19:59:11 -0500
Message-Id: <20210105005915.3954208-13-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210105005915.3954208-1-sashal@kernel.org>
References: <20210105005915.3954208-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 87dbc209ea04645fd2351981f09eff5d23f8e2e9 ]

Make <asm-generic/local64.h> mandatory in include/asm-generic/Kbuild and
remove all arch/*/include/asm/local64.h arch-specific files since they
only #include <asm-generic/local64.h>.

This fixes build errors on arch/c6x/ and arch/nios2/ for
block/blk-iocost.c.

Build-tested on 21 of 25 arch-es.  (tools problems on the others)

Yes, we could even rename <asm-generic/local64.h> to
<linux/local64.h> and change all #includes to use
<linux/local64.h> instead.

Link: https://lkml.kernel.org/r/20201227024446.17018-1-rdunlap@infradead.org
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Ley Foon Tan <ley.foon.tan@intel.com>
Cc: Mark Salter <msalter@redhat.com>
Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/alpha/include/asm/local64.h   | 1 -
 arch/arc/include/asm/Kbuild        | 1 -
 arch/arm/include/asm/Kbuild        | 1 -
 arch/arm64/include/asm/Kbuild      | 1 -
 arch/csky/include/asm/Kbuild       | 1 -
 arch/h8300/include/asm/Kbuild      | 1 -
 arch/hexagon/include/asm/Kbuild    | 1 -
 arch/ia64/include/asm/local64.h    | 1 -
 arch/m68k/include/asm/Kbuild       | 1 -
 arch/microblaze/include/asm/Kbuild | 1 -
 arch/mips/include/asm/Kbuild       | 1 -
 arch/nds32/include/asm/Kbuild      | 1 -
 arch/parisc/include/asm/Kbuild     | 1 -
 arch/powerpc/include/asm/Kbuild    | 1 -
 arch/riscv/include/asm/Kbuild      | 1 -
 arch/s390/include/asm/Kbuild       | 1 -
 arch/sh/include/asm/Kbuild         | 1 -
 arch/sparc/include/asm/Kbuild      | 1 -
 arch/x86/include/asm/local64.h     | 1 -
 arch/xtensa/include/asm/Kbuild     | 1 -
 include/asm-generic/Kbuild         | 1 +
 21 files changed, 1 insertion(+), 20 deletions(-)
 delete mode 100644 arch/alpha/include/asm/local64.h
 delete mode 100644 arch/ia64/include/asm/local64.h
 delete mode 100644 arch/x86/include/asm/local64.h

diff --git a/arch/alpha/include/asm/local64.h b/arch/alpha/include/asm/local64.h
deleted file mode 100644
index 36c93b5cc239b..0000000000000
--- a/arch/alpha/include/asm/local64.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/local64.h>
diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index 81f4edec0c2a9..3c1afa524b9c2 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y += extable.h
 generic-y += kvm_para.h
-generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += parport.h
 generic-y += user.h
diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index 383635b68763c..f1398b9267c08 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -2,7 +2,6 @@
 generic-y += early_ioremap.h
 generic-y += extable.h
 generic-y += flat.h
-generic-y += local64.h
 generic-y += parport.h
 generic-y += seccomp.h
 
diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index ff9cbb6312128..07ac208edc894 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y += early_ioremap.h
-generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += qrwlock.h
 generic-y += qspinlock.h
diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
index 64876e59e2ef9..2a5a4d94fafad 100644
--- a/arch/csky/include/asm/Kbuild
+++ b/arch/csky/include/asm/Kbuild
@@ -2,7 +2,6 @@
 generic-y += asm-offsets.h
 generic-y += gpio.h
 generic-y += kvm_para.h
-generic-y += local64.h
 generic-y += qrwlock.h
 generic-y += seccomp.h
 generic-y += user.h
diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
index ddf04f32b5467..60ee7f0d60a8f 100644
--- a/arch/h8300/include/asm/Kbuild
+++ b/arch/h8300/include/asm/Kbuild
@@ -2,7 +2,6 @@
 generic-y += asm-offsets.h
 generic-y += extable.h
 generic-y += kvm_para.h
-generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += parport.h
 generic-y += spinlock.h
diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
index 373964bb177e4..3ece3c93fe086 100644
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -2,5 +2,4 @@
 generic-y += extable.h
 generic-y += iomap.h
 generic-y += kvm_para.h
-generic-y += local64.h
 generic-y += mcs_spinlock.h
diff --git a/arch/ia64/include/asm/local64.h b/arch/ia64/include/asm/local64.h
deleted file mode 100644
index 36c93b5cc239b..0000000000000
--- a/arch/ia64/include/asm/local64.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/local64.h>
diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 1bff55aa2d54e..0dbf9c5c6faeb 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -2,6 +2,5 @@
 generated-y += syscall_table.h
 generic-y += extable.h
 generic-y += kvm_para.h
-generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += spinlock.h
diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index 63bce836b9f10..29b0e557aa7c5 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -2,7 +2,6 @@
 generated-y += syscall_table.h
 generic-y += extable.h
 generic-y += kvm_para.h
-generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += parport.h
 generic-y += syscalls.h
diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 198b3bafdac97..95b4fa7bd0d1f 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -6,7 +6,6 @@ generated-y += syscall_table_64_n64.h
 generated-y += syscall_table_64_o32.h
 generic-y += export.h
 generic-y += kvm_para.h
-generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += parport.h
 generic-y += qrwlock.h
diff --git a/arch/nds32/include/asm/Kbuild b/arch/nds32/include/asm/Kbuild
index ff1e94299317d..82a4453c9c2d5 100644
--- a/arch/nds32/include/asm/Kbuild
+++ b/arch/nds32/include/asm/Kbuild
@@ -4,6 +4,5 @@ generic-y += cmpxchg.h
 generic-y += export.h
 generic-y += gpio.h
 generic-y += kvm_para.h
-generic-y += local64.h
 generic-y += parport.h
 generic-y += user.h
diff --git a/arch/parisc/include/asm/Kbuild b/arch/parisc/include/asm/Kbuild
index e3ee5c0bfe80f..a1bd2adc63e3a 100644
--- a/arch/parisc/include/asm/Kbuild
+++ b/arch/parisc/include/asm/Kbuild
@@ -3,7 +3,6 @@ generated-y += syscall_table_32.h
 generated-y += syscall_table_64.h
 generated-y += syscall_table_c32.h
 generic-y += kvm_para.h
-generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += seccomp.h
 generic-y += user.h
diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index 90cd5c53af666..e1f9b4ea1c537 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -5,7 +5,6 @@ generated-y += syscall_table_c32.h
 generated-y += syscall_table_spu.h
 generic-y += export.h
 generic-y += kvm_types.h
-generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += qrwlock.h
 generic-y += vtime.h
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 59dd7be550054..445ccc97305a5 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -3,6 +3,5 @@ generic-y += early_ioremap.h
 generic-y += extable.h
 generic-y += flat.h
 generic-y += kvm_para.h
-generic-y += local64.h
 generic-y += user.h
 generic-y += vmlinux.lds.h
diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index 319efa0e6d024..1a18d7b82f86d 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -7,5 +7,4 @@ generated-y += unistd_nr.h
 generic-y += asm-offsets.h
 generic-y += export.h
 generic-y += kvm_types.h
-generic-y += local64.h
 generic-y += mcs_spinlock.h
diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index 7435182ef8465..fc44d9c88b419 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 generated-y += syscall_table.h
 generic-y += kvm_para.h
-generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += parport.h
diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index 5269a704801fa..3688fdae50e45 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -6,5 +6,4 @@ generated-y += syscall_table_64.h
 generated-y += syscall_table_c32.h
 generic-y += export.h
 generic-y += kvm_para.h
-generic-y += local64.h
 generic-y += mcs_spinlock.h
diff --git a/arch/x86/include/asm/local64.h b/arch/x86/include/asm/local64.h
deleted file mode 100644
index 36c93b5cc239b..0000000000000
--- a/arch/x86/include/asm/local64.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/local64.h>
diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
index c59c42a1221a8..adefb1636f7ae 100644
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -2,7 +2,6 @@
 generated-y += syscall_table.h
 generic-y += extable.h
 generic-y += kvm_para.h
-generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += param.h
 generic-y += qrwlock.h
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index e78bbb9a07e90..d1300c6e0a471 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -34,6 +34,7 @@ mandatory-y += kmap_types.h
 mandatory-y += kprobes.h
 mandatory-y += linkage.h
 mandatory-y += local.h
+mandatory-y += local64.h
 mandatory-y += mm-arch-hooks.h
 mandatory-y += mmiowb.h
 mandatory-y += mmu.h
-- 
2.27.0

