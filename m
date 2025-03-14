Return-Path: <linux-arch+bounces-10786-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 670C7A609C0
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 08:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19DA188D64F
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 07:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338731A23A6;
	Fri, 14 Mar 2025 07:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3CD0Ebo"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0C0188CA9
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 07:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936356; cv=none; b=j4tF2Q/tfpzyU7X4X5sk7W0xoXrl2XPi18ESbCCBC8+eDIqx1AV/a2gCmPfbGQs/VJt9GwveA/wu5ULe+1h2zMH4j2q4X+BaGrAt4Umot/12XDQ9yvMPv1c/Td5yCjxWk5d3XhkrPKctCByVr5aixO9ORtaMR7VMwN4c+NEE39g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936356; c=relaxed/simple;
	bh=lk1bbwD+ITw+Ck3T1FvPLRT2Qf9WcYsbd8BMgKxvblE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8kp4gbF3uaM8hH4wchOa5MeOrEjn7gx8xsXGM0dXVqLmHiFoaWceMgH8Sj4Gaw5EsXfMCEsn309wJ7BbEAYWtYmB2Y8T4tb91gVj+lNGFpoGoGgoJ+7FCbFAXieMl0pB+N58S3+I4jOYSwlkvz75ifMCX107VQyljBdwHu2vxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d3CD0Ebo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gAMzgkA07Lt3/9LqwxIu+APFbSDSNFcyS8SfP5U1rhc=;
	b=d3CD0EboJOdociu913lzugwqmUoTFCY/KQwxF3nBPdSuKJidZmGhoaHzjyXZ1ikqVuHZxy
	exJBfkkFLpLTOOZpyVBL3wmOlxRKZnC1hbDaZWmjAaM8Ejrhk0kuNOTDSuPYAMZMtzk8J8
	qredkcnNYJyRPKwot3ohdgEpFSAA2tw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-bj4mrfR6O46asQGmn1rBVw-1; Fri,
 14 Mar 2025 03:12:23 -0400
X-MC-Unique: bj4mrfR6O46asQGmn1rBVw-1
X-Mimecast-MFC-AGG-ID: bj4mrfR6O46asQGmn1rBVw_1741936342
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 388A61800258;
	Fri, 14 Mar 2025 07:12:22 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E112618001DE;
	Fri, 14 Mar 2025 07:12:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 27/41] powerpc: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
Date: Fri, 14 Mar 2025 08:09:58 +0100
Message-ID: <20250314071013.1575167-28-thuth@redhat.com>
In-Reply-To: <20250314071013.1575167-1-thuth@redhat.com>
References: <20250314071013.1575167-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

While the GCC and Clang compilers already define __ASSEMBLER__
automatically when compiling assembly code, __ASSEMBLY__ is a
macro that only gets defined by the Makefiles in the kernel.
This can be very confusing when switching between userspace
and kernelspace coding, or when dealing with uapi headers that
rather should use __ASSEMBLER__ instead. So let's standardize on
the __ASSEMBLER__ macro that is provided by the compilers now.

This is almost a completely mechanical patch (done with a simple
"sed -i" statement), apart from tweaking two comments manually in
arch/powerpc/include/asm/bug.h and arch/powerpc/include/asm/kasan.h
(which did not have proper underscores at the end) and fixing a
checkpatch error about spaces in arch/powerpc/include/asm/spu_csa.h.

Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/powerpc/boot/page.h                           |  2 +-
 arch/powerpc/include/asm/asm-const.h               |  2 +-
 arch/powerpc/include/asm/barrier.h                 |  2 +-
 arch/powerpc/include/asm/book3s/32/kup.h           |  4 ++--
 arch/powerpc/include/asm/book3s/32/mmu-hash.h      |  8 ++++----
 arch/powerpc/include/asm/book3s/32/pgtable.h       | 12 ++++++------
 arch/powerpc/include/asm/book3s/64/hash-4k.h       |  4 ++--
 arch/powerpc/include/asm/book3s/64/hash-64k.h      |  4 ++--
 arch/powerpc/include/asm/book3s/64/hash.h          |  4 ++--
 arch/powerpc/include/asm/book3s/64/kup.h           |  6 +++---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h      | 12 ++++++------
 arch/powerpc/include/asm/book3s/64/mmu.h           |  8 ++++----
 arch/powerpc/include/asm/book3s/64/pgtable-64k.h   |  4 ++--
 arch/powerpc/include/asm/book3s/64/pgtable.h       | 10 +++++-----
 arch/powerpc/include/asm/book3s/64/radix.h         |  8 ++++----
 arch/powerpc/include/asm/book3s/64/slice.h         |  4 ++--
 arch/powerpc/include/asm/bug.h                     | 14 +++++++-------
 arch/powerpc/include/asm/cache.h                   |  4 ++--
 arch/powerpc/include/asm/cpu_has_feature.h         |  4 ++--
 arch/powerpc/include/asm/cpuidle.h                 |  2 +-
 arch/powerpc/include/asm/cputable.h                |  8 ++++----
 arch/powerpc/include/asm/cputhreads.h              |  4 ++--
 arch/powerpc/include/asm/dcr-generic.h             |  4 ++--
 arch/powerpc/include/asm/dcr-native.h              |  4 ++--
 arch/powerpc/include/asm/dcr.h                     |  4 ++--
 arch/powerpc/include/asm/epapr_hcalls.h            |  4 ++--
 arch/powerpc/include/asm/exception-64e.h           |  2 +-
 arch/powerpc/include/asm/exception-64s.h           |  6 +++---
 arch/powerpc/include/asm/extable.h                 |  2 +-
 arch/powerpc/include/asm/feature-fixups.h          |  6 +++---
 arch/powerpc/include/asm/firmware.h                |  4 ++--
 arch/powerpc/include/asm/fixmap.h                  |  4 ++--
 arch/powerpc/include/asm/ftrace.h                  |  8 ++++----
 arch/powerpc/include/asm/head-64.h                 |  4 ++--
 arch/powerpc/include/asm/hvcall.h                  |  4 ++--
 arch/powerpc/include/asm/hw_irq.h                  |  4 ++--
 arch/powerpc/include/asm/interrupt.h               |  4 ++--
 arch/powerpc/include/asm/irqflags.h                |  2 +-
 arch/powerpc/include/asm/jump_label.h              |  2 +-
 arch/powerpc/include/asm/kasan.h                   |  4 ++--
 arch/powerpc/include/asm/kdump.h                   |  4 ++--
 arch/powerpc/include/asm/kexec.h                   |  4 ++--
 arch/powerpc/include/asm/kgdb.h                    |  4 ++--
 arch/powerpc/include/asm/kup.h                     |  8 ++++----
 arch/powerpc/include/asm/kvm_asm.h                 |  2 +-
 arch/powerpc/include/asm/kvm_book3s_asm.h          |  6 +++---
 arch/powerpc/include/asm/kvm_booke_hv_asm.h        |  4 ++--
 arch/powerpc/include/asm/lv1call.h                 |  4 ++--
 arch/powerpc/include/asm/mmu.h                     |  8 ++++----
 arch/powerpc/include/asm/mpc52xx.h                 | 12 ++++++------
 arch/powerpc/include/asm/nohash/32/kup-8xx.h       |  4 ++--
 arch/powerpc/include/asm/nohash/32/mmu-44x.h       |  4 ++--
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h       |  4 ++--
 arch/powerpc/include/asm/nohash/32/pgtable.h       | 12 ++++++------
 arch/powerpc/include/asm/nohash/32/pte-8xx.h       |  2 +-
 arch/powerpc/include/asm/nohash/64/pgtable-4k.h    |  8 ++++----
 arch/powerpc/include/asm/nohash/64/pgtable.h       |  4 ++--
 arch/powerpc/include/asm/nohash/kup-booke.h        |  4 ++--
 arch/powerpc/include/asm/nohash/mmu-e500.h         |  4 ++--
 arch/powerpc/include/asm/nohash/pgtable.h          |  6 +++---
 arch/powerpc/include/asm/nohash/pte-e500.h         |  4 ++--
 arch/powerpc/include/asm/opal-api.h                |  4 ++--
 arch/powerpc/include/asm/opal.h                    |  4 ++--
 arch/powerpc/include/asm/page.h                    | 14 +++++++-------
 arch/powerpc/include/asm/page_32.h                 |  4 ++--
 arch/powerpc/include/asm/page_64.h                 |  4 ++--
 arch/powerpc/include/asm/pgtable.h                 |  8 ++++----
 arch/powerpc/include/asm/ppc_asm.h                 |  4 ++--
 arch/powerpc/include/asm/processor.h               |  8 ++++----
 arch/powerpc/include/asm/ptrace.h                  |  6 +++---
 arch/powerpc/include/asm/reg.h                     |  6 +++---
 arch/powerpc/include/asm/reg_booke.h               |  4 ++--
 arch/powerpc/include/asm/reg_fsl_emb.h             |  4 ++--
 arch/powerpc/include/asm/setup.h                   |  4 ++--
 arch/powerpc/include/asm/smp.h                     |  4 ++--
 arch/powerpc/include/asm/spu_csa.h                 |  4 ++--
 arch/powerpc/include/asm/synch.h                   |  4 ++--
 arch/powerpc/include/asm/thread_info.h             |  8 ++++----
 arch/powerpc/include/asm/tm.h                      |  4 ++--
 arch/powerpc/include/asm/types.h                   |  4 ++--
 arch/powerpc/include/asm/unistd.h                  |  4 ++--
 arch/powerpc/include/asm/vdso.h                    |  6 +++---
 arch/powerpc/include/asm/vdso/getrandom.h          |  4 ++--
 arch/powerpc/include/asm/vdso/gettimeofday.h       |  4 ++--
 arch/powerpc/include/asm/vdso/processor.h          |  4 ++--
 arch/powerpc/include/asm/vdso/vsyscall.h           |  4 ++--
 arch/powerpc/include/asm/vdso_datapage.h           |  6 +++---
 arch/powerpc/kernel/head_booke.h                   |  4 ++--
 arch/powerpc/net/bpf_jit.h                         |  2 +-
 arch/powerpc/platforms/powernv/subcore.h           |  4 ++--
 arch/powerpc/xmon/xmon_bpts.h                      |  4 ++--
 .../selftests/powerpc/include/instructions.h       |  2 +-
 92 files changed, 232 insertions(+), 232 deletions(-)

diff --git a/arch/powerpc/boot/page.h b/arch/powerpc/boot/page.h
index c3d55fc8f34c4..e44a3119720db 100644
--- a/arch/powerpc/boot/page.h
+++ b/arch/powerpc/boot/page.h
@@ -5,7 +5,7 @@
  * Copyright (C) 2001 PPC64 Team, IBM Corp
  */
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define ASM_CONST(x) x
 #else
 #define __ASM_CONST(x) x##UL
diff --git a/arch/powerpc/include/asm/asm-const.h b/arch/powerpc/include/asm/asm-const.h
index bfb3c3534877a..392bdb1f104f4 100644
--- a/arch/powerpc/include/asm/asm-const.h
+++ b/arch/powerpc/include/asm/asm-const.h
@@ -1,7 +1,7 @@
 #ifndef _ASM_POWERPC_ASM_CONST_H
 #define _ASM_POWERPC_ASM_CONST_H
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #  define stringify_in_c(...)	__VA_ARGS__
 #  define ASM_CONST(x)		x
 #else
diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index b95b666f03744..9e9833faa4af8 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -7,7 +7,7 @@
 
 #include <asm/asm-const.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/ppc-opcode.h>
 #endif
 
diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index 4e14a5427a632..873c5146e3261 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -7,7 +7,7 @@
 #include <asm/mmu.h>
 #include <asm/synch.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef CONFIG_PPC_KUAP
 
@@ -170,6 +170,6 @@ __bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
 
 #endif /* CONFIG_PPC_KUAP */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_POWERPC_BOOK3S_32_KUP_H */
diff --git a/arch/powerpc/include/asm/book3s/32/mmu-hash.h b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
index 78c6a5fde1d61..8435bf3cdabfa 100644
--- a/arch/powerpc/include/asm/book3s/32/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
@@ -29,7 +29,7 @@
 #define BPP_RX	0x01		/* Read only */
 #define BPP_RW	0x02		/* Read/write */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /* Contort a phys_addr_t into the right format/bits for a BAT */
 #ifdef CONFIG_PHYS_64BIT
 #define BAT_PHYS_ADDR(x) ((u32)((x & 0x00000000fffe0000ULL) | \
@@ -47,7 +47,7 @@ struct ppc_bat {
 	u32 batu;
 	u32 batl;
 };
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /*
  * Hash table
@@ -64,7 +64,7 @@ struct ppc_bat {
 #define SR_KP	0x20000000	/* User key */
 #define SR_KS	0x40000000	/* Supervisor key */
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 #include <asm/asm-offsets.h>
 
@@ -225,7 +225,7 @@ static __always_inline void update_user_segments(u32 val)
 
 int __init find_free_bat(void);
 unsigned int bat_block_size(unsigned long base, unsigned long top);
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /* We happily ignore the smaller BATs on 601, we don't actually use
  * those definitions on hash32 at the moment anyway
diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 42c3af90d1f0f..61803855b0aad 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -102,7 +102,7 @@
 #define PMD_CACHE_INDEX	PMD_INDEX_SIZE
 #define PUD_CACHE_INDEX	PUD_INDEX_SIZE
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #define PTE_TABLE_SIZE	(sizeof(pte_t) << PTE_INDEX_SIZE)
 #define PMD_TABLE_SIZE	0
 #define PUD_TABLE_SIZE	0
@@ -110,7 +110,7 @@
 
 /* Bits to mask out from a PMD to get to the PTE page */
 #define PMD_MASKED_BITS		(PTE_TABLE_SIZE - 1)
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 #define PTRS_PER_PTE	(1 << PTE_INDEX_SIZE)
 #define PTRS_PER_PGD	(1 << PGD_INDEX_SIZE)
@@ -132,12 +132,12 @@
 
 #define USER_PTRS_PER_PGD	(TASK_SIZE / PGDIR_SIZE)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 int map_kernel_page(unsigned long va, phys_addr_t pa, pgprot_t prot);
 void unmap_kernel_page(unsigned long va);
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /*
  * This is the bottom of the PKMAP area with HIGHMEM or an arbitrary
@@ -199,7 +199,7 @@ void unmap_kernel_page(unsigned long va);
 #define MODULES_SIZE	(CONFIG_MODULES_SIZE * SZ_1M)
 #define MODULES_VADDR	(MODULES_END - MODULES_SIZE)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/sched.h>
 #include <linux/threads.h>
 
@@ -602,6 +602,6 @@ static inline pgprot_t pgprot_writecombine(pgprot_t prot)
 	return pgprot_noncached_wc(prot);
 }
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /*  _ASM_POWERPC_BOOK3S_32_PGTABLE_H */
diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index aa90a048f319a..956abb391e7d8 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -32,7 +32,7 @@
  */
 #define H_KERN_VIRT_START	ASM_CONST(0xc0003d0000000000)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #define H_PTE_TABLE_SIZE	(sizeof(pte_t) << H_PTE_INDEX_SIZE)
 #define H_PMD_TABLE_SIZE	(sizeof(pmd_t) << H_PMD_INDEX_SIZE)
 #define H_PUD_TABLE_SIZE	(sizeof(pud_t) << H_PUD_INDEX_SIZE)
@@ -174,6 +174,6 @@ static inline pmd_t hash__pmd_mkdevmap(pmd_t pmd)
 	return pmd;
 }
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* _ASM_POWERPC_BOOK3S_64_HASH_4K_H */
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 0bf6fd0bf42ae..9c54d59ee8251 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -79,7 +79,7 @@
 #endif
 #define H_PMD_FRAG_NR	(PAGE_SIZE >> H_PMD_FRAG_SIZE_SHIFT)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/errno.h>
 
 /*
@@ -286,6 +286,6 @@ static inline pmd_t hash__pmd_mkdevmap(pmd_t pmd)
 	return __pmd(pmd_val(pmd) | (_PAGE_PTE | H_PAGE_THP_HUGE | _PAGE_DEVMAP));
 }
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 #endif /* _ASM_POWERPC_BOOK3S_64_HASH_64K_H */
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 0755f2567021d..5a8cbd496731e 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -112,7 +112,7 @@
 #define H_PMD_BAD_BITS		(PTE_TABLE_SIZE-1)
 #define H_PUD_BAD_BITS		(PMD_TABLE_SIZE-1)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 static inline int get_region_id(unsigned long ea)
 {
 	int region_id;
@@ -295,6 +295,6 @@ int hash__create_section_mapping(unsigned long start, unsigned long end,
 				 int nid, pgprot_t prot);
 int hash__remove_section_mapping(unsigned long start, unsigned long end);
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_BOOK3S_64_HASH_H */
diff --git a/arch/powerpc/include/asm/book3s/64/kup.h b/arch/powerpc/include/asm/book3s/64/kup.h
index 497a7bd31ecc0..03aec3c6c851c 100644
--- a/arch/powerpc/include/asm/book3s/64/kup.h
+++ b/arch/powerpc/include/asm/book3s/64/kup.h
@@ -10,7 +10,7 @@
 #define AMR_KUEP_BLOCKED	UL(0x5455555555555555)
 #define AMR_KUAP_BLOCKED	(AMR_KUAP_BLOCK_READ | AMR_KUAP_BLOCK_WRITE)
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 .macro kuap_user_restore gpr1, gpr2
 #if defined(CONFIG_PPC_PKEY)
@@ -191,7 +191,7 @@
 #endif
 .endm
 
-#else /* !__ASSEMBLY__ */
+#else /* !__ASSEMBLER__ */
 
 #include <linux/jump_label.h>
 #include <linux/sched.h>
@@ -413,6 +413,6 @@ static __always_inline void restore_user_access(unsigned long flags)
 	if (static_branch_unlikely(&uaccess_flush_key) && flags == AMR_KUAP_BLOCKED)
 		do_uaccess_flush();
 }
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_POWERPC_BOOK3S_64_KUP_H */
diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 1c4eebbc69c94..3463514232071 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -130,7 +130,7 @@
 #define POWER9_TLB_SETS_HASH	256	/* # sets in POWER9 TLB Hash mode */
 #define POWER9_TLB_SETS_RADIX	128	/* # sets in POWER9 TLB Radix mode */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct mmu_hash_ops {
 	void            (*hpte_invalidate)(unsigned long slot,
@@ -220,7 +220,7 @@ static inline unsigned long get_sllp_encoding(int psize)
 	return sllp;
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * Segment sizes.
@@ -248,7 +248,7 @@ static inline unsigned long get_sllp_encoding(int psize)
 #define LP_BITS		8
 #define LP_MASK(i)	((0xFF >> (i)) << LP_SHIFT)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 static inline int slb_vsid_shift(int ssize)
 {
@@ -532,7 +532,7 @@ void slb_set_size(u16 size);
 static inline void slb_set_size(u16 size) { }
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * VSID allocation (256MB segment)
@@ -668,7 +668,7 @@ static inline void slb_set_size(u16 size) { }
 #define SLICE_ARRAY_SIZE	(H_PGTABLE_RANGE >> 41)
 #define LOW_SLICE_ARRAY_SZ	(BITS_PER_LONG / BITS_PER_BYTE)
 #define TASK_SLICE_ARRAY_SZ(x)	((x)->hash_context->slb_addr_limit >> 41)
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef CONFIG_PPC_SUBPAGE_PROT
 /*
@@ -881,5 +881,5 @@ static inline unsigned long mk_vsid_data(unsigned long ea, int ssize,
 	return __mk_vsid_data(get_kernel_vsid(ea, ssize), ssize, flags);
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_POWERPC_BOOK3S_64_MMU_HASH_H_ */
diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index fedbc5d381917..48631365b48cf 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -4,7 +4,7 @@
 
 #include <asm/page.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * Page size definition
  *
@@ -26,12 +26,12 @@ struct mmu_psize_def {
 	};
 };
 extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /* 64-bit classic hash table MMU */
 #include <asm/book3s/64/mmu-hash.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * ISA 3.0 partition and process table entry format
  */
@@ -288,5 +288,5 @@ static inline unsigned long get_user_vsid(mm_context_t *ctx,
 }
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_POWERPC_BOOK3S_64_MMU_H_ */
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
index 4d8d7b4ea16ba..004a03e97e58e 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_POWERPC_BOOK3S_64_PGTABLE_64K_H
 #define _ASM_POWERPC_BOOK3S_64_PGTABLE_64K_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #ifdef CONFIG_HUGETLB_PAGE
 
 #endif /* CONFIG_HUGETLB_PAGE */
@@ -14,5 +14,5 @@ static inline int remap_4k_pfn(struct vm_area_struct *vma, unsigned long addr,
 		BUG();
 	return hash__remap_4k_pfn(vma, addr, pfn, prot);
 }
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 #endif /*_ASM_POWERPC_BOOK3S_64_PGTABLE_64K_H */
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 6d98e6f08d4de..a9b8c7c13d1f8 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -4,7 +4,7 @@
 
 #include <asm-generic/pgtable-nop4d.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/mmdebug.h>
 #include <linux/bug.h>
 #include <linux/sizes.h>
@@ -144,7 +144,7 @@
 #define PAGE_KERNEL_RO	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RO)
 #define PAGE_KERNEL_ROX	__pgprot(_PAGE_BASE | _PAGE_KERNEL_ROX)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * page table defines
  */
@@ -292,7 +292,7 @@ static inline unsigned long pud_leaf_size(pud_t pud)
 	else
 		return PUD_SIZE;
 }
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #include <asm/book3s/64/hash.h>
 #include <asm/book3s/64/radix.h>
@@ -328,7 +328,7 @@ static inline unsigned long pud_leaf_size(pud_t pud)
 #define FIXADDR_SIZE	SZ_32M
 #define FIXADDR_TOP	(IOREMAP_END + FIXADDR_SIZE)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 static inline unsigned long pte_update(struct mm_struct *mm, unsigned long addr,
 				       pte_t *ptep, unsigned long clr,
@@ -1431,5 +1431,5 @@ static inline bool is_pte_rw_upgrade(unsigned long old_val, unsigned long new_va
 	return false;
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_POWERPC_BOOK3S_64_PGTABLE_H_ */
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 8f55ff74bb680..ed2dc7fb97bbf 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -4,7 +4,7 @@
 
 #include <asm/asm-const.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/cmpxchg.h>
 #endif
 
@@ -14,7 +14,7 @@
 #include <asm/book3s/64/radix-4k.h>
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/book3s/64/tlbflush-radix.h>
 #include <asm/cpu_has_feature.h>
 #endif
@@ -132,7 +132,7 @@
 #define RADIX_VMEMMAP_SIZE	RADIX_KERN_MAP_SIZE
 #define RADIX_VMEMMAP_END	(RADIX_VMEMMAP_START + RADIX_VMEMMAP_SIZE)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #define RADIX_PTE_TABLE_SIZE	(sizeof(pte_t) << RADIX_PTE_INDEX_SIZE)
 #define RADIX_PMD_TABLE_SIZE	(sizeof(pmd_t) << RADIX_PMD_INDEX_SIZE)
 #define RADIX_PUD_TABLE_SIZE	(sizeof(pud_t) << RADIX_PUD_INDEX_SIZE)
@@ -372,5 +372,5 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 					      unsigned long start,
 					      unsigned long end, int node,
 					      struct dev_pagemap *pgmap);
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif
diff --git a/arch/powerpc/include/asm/book3s/64/slice.h b/arch/powerpc/include/asm/book3s/64/slice.h
index 5fbe18544cbd1..6e2f7a74cd759 100644
--- a/arch/powerpc/include/asm/book3s/64/slice.h
+++ b/arch/powerpc/include/asm/book3s/64/slice.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_POWERPC_BOOK3S_64_SLICE_H
 #define _ASM_POWERPC_BOOK3S_64_SLICE_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef CONFIG_PPC_64S_HASH_MMU
 #ifdef CONFIG_HUGETLB_PAGE
@@ -37,6 +37,6 @@ void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
 void slice_init_new_context_exec(struct mm_struct *mm);
 void slice_setup_new_exec(void);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_POWERPC_BOOK3S_64_SLICE_H */
diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
index 1db485aacbd9b..bbaa7e81f8213 100644
--- a/arch/powerpc/include/asm/bug.h
+++ b/arch/powerpc/include/asm/bug.h
@@ -7,7 +7,7 @@
 
 #ifdef CONFIG_BUG
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #include <asm/asm-offsets.h>
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 .macro EMIT_BUG_ENTRY addr,file,line,flags
@@ -31,7 +31,7 @@
 .endm
 #endif /* verbose */
 
-#else /* !__ASSEMBLY__ */
+#else /* !__ASSEMBLER__ */
 /* _EMIT_BUG_ENTRY expects args %0,%1,%2,%3 to be FILE, LINE, flags and
    sizeof(struct bug_entry), respectively */
 #ifdef CONFIG_DEBUG_BUGVERBOSE
@@ -101,12 +101,12 @@
 #define HAVE_ARCH_WARN_ON
 #endif
 
-#endif /* __ASSEMBLY __ */
+#endif /* __ASSEMBLER__ */
 #else
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 .macro EMIT_BUG_ENTRY addr,file,line,flags
 .endm
-#else /* !__ASSEMBLY__ */
+#else /* !__ASSEMBLER__ */
 #define _EMIT_BUG_ENTRY
 #endif
 #endif /* CONFIG_BUG */
@@ -115,7 +115,7 @@
 
 #include <asm-generic/bug.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct pt_regs;
 void hash__do_page_fault(struct pt_regs *);
@@ -128,7 +128,7 @@ void die_mce(const char *str, struct pt_regs *regs, long err);
 extern bool die_will_crash(void);
 extern void panic_flush_kmsg_start(void);
 extern void panic_flush_kmsg_end(void);
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_BUG_H */
diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
index 69232231d2708..6796babc4d310 100644
--- a/arch/powerpc/include/asm/cache.h
+++ b/arch/powerpc/include/asm/cache.h
@@ -37,7 +37,7 @@
 #define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
 #endif
 
-#if !defined(__ASSEMBLY__)
+#if !defined(__ASSEMBLER__)
 #ifdef CONFIG_PPC64
 
 struct ppc_cache_info {
@@ -145,6 +145,6 @@ static inline void iccci(void *addr)
 	asm volatile ("iccci 0, %0" : : "r"(addr) : "memory");
 }
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_CACHE_H */
diff --git a/arch/powerpc/include/asm/cpu_has_feature.h b/arch/powerpc/include/asm/cpu_has_feature.h
index bf8a228229fa9..604fa3b6c33d4 100644
--- a/arch/powerpc/include/asm/cpu_has_feature.h
+++ b/arch/powerpc/include/asm/cpu_has_feature.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_POWERPC_CPU_HAS_FEATURE_H
 #define __ASM_POWERPC_CPU_HAS_FEATURE_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/bug.h>
 #include <asm/cputable.h>
@@ -51,5 +51,5 @@ static __always_inline bool cpu_has_feature(unsigned long feature)
 }
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* __ASM_POWERPC_CPU_HAS_FEATURE_H */
diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index 0cce5dc7fb1c2..054cd2fcfd551 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -68,7 +68,7 @@
 #define ERR_EC_ESL_MISMATCH		-1
 #define ERR_DEEP_STATE_ESL_MISMATCH	-2
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define PNV_IDLE_NAME_LEN    16
 struct pnv_idle_states_t {
diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 29a529d2ab8b4..ec16c12296da8 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -7,7 +7,7 @@
 #include <uapi/asm/cputable.h>
 #include <asm/asm-const.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /* This structure can grow, it's real size is used by head.S code
  * via the mkdefs mechanism.
@@ -103,7 +103,7 @@ extern void cpu_feature_keys_init(void);
 static inline void cpu_feature_keys_init(void) { }
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /* CPU kernel features */
 
@@ -195,7 +195,7 @@ static inline void cpu_feature_keys_init(void) { }
 #define CPU_FTR_DEXCR_NPHIE		LONG_ASM_CONST(0x0010000000000000)
 #define CPU_FTR_P11_PVR			LONG_ASM_CONST(0x0020000000000000)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define CPU_FTR_PPCAS_ARCH_V2	(CPU_FTR_NOEXECUTE)
 
@@ -602,6 +602,6 @@ enum {
  */
 #define HBP_NUM_MAX	2
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_POWERPC_CPUTABLE_H */
diff --git a/arch/powerpc/include/asm/cputhreads.h b/arch/powerpc/include/asm/cputhreads.h
index f26c430f39826..d06f2b20b8105 100644
--- a/arch/powerpc/include/asm/cputhreads.h
+++ b/arch/powerpc/include/asm/cputhreads.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_POWERPC_CPUTHREADS_H
 #define _ASM_POWERPC_CPUTHREADS_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/cpumask.h>
 #include <asm/cpu_has_feature.h>
 
@@ -107,7 +107,7 @@ static inline u32 get_tensr(void)
 void book3e_start_thread(int thread, unsigned long addr);
 void book3e_stop_thread(int thread);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #define INVALID_THREAD_HWID	0x0fff
 
diff --git a/arch/powerpc/include/asm/dcr-generic.h b/arch/powerpc/include/asm/dcr-generic.h
index 099c28dd40b99..2d8bcff0f2f82 100644
--- a/arch/powerpc/include/asm/dcr-generic.h
+++ b/arch/powerpc/include/asm/dcr-generic.h
@@ -7,7 +7,7 @@
 #ifndef _ASM_POWERPC_DCR_GENERIC_H
 #define _ASM_POWERPC_DCR_GENERIC_H
 #ifdef __KERNEL__
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 enum host_type_t {DCR_HOST_MMIO, DCR_HOST_NATIVE, DCR_HOST_INVALID};
 
@@ -29,7 +29,7 @@ extern u32 dcr_read_generic(dcr_host_t host, unsigned int dcr_n);
 
 extern void dcr_write_generic(dcr_host_t host, unsigned int dcr_n, u32 value);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_DCR_GENERIC_H */
 
diff --git a/arch/powerpc/include/asm/dcr-native.h b/arch/powerpc/include/asm/dcr-native.h
index a92059964579b..65b3fc2dc4043 100644
--- a/arch/powerpc/include/asm/dcr-native.h
+++ b/arch/powerpc/include/asm/dcr-native.h
@@ -7,7 +7,7 @@
 #ifndef _ASM_POWERPC_DCR_NATIVE_H
 #define _ASM_POWERPC_DCR_NATIVE_H
 #ifdef __KERNEL__
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/spinlock.h>
 #include <asm/cputable.h>
@@ -139,6 +139,6 @@ static inline void __dcri_clrset(int base_addr, int base_data, int reg,
 							      DCRN_ ## base ## _CONFIG_DATA,	\
 							      reg, clr, set)
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_DCR_NATIVE_H */
diff --git a/arch/powerpc/include/asm/dcr.h b/arch/powerpc/include/asm/dcr.h
index 64030e3a1f307..f3bc06144a44e 100644
--- a/arch/powerpc/include/asm/dcr.h
+++ b/arch/powerpc/include/asm/dcr.h
@@ -7,7 +7,7 @@
 #ifndef _ASM_POWERPC_DCR_H
 #define _ASM_POWERPC_DCR_H
 #ifdef __KERNEL__
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #ifdef CONFIG_PPC_DCR
 
 #ifdef CONFIG_PPC_DCR_NATIVE
@@ -60,6 +60,6 @@ extern unsigned int dcr_resource_start(const struct device_node *np,
 extern unsigned int dcr_resource_len(const struct device_node *np,
 				     unsigned int index);
 #endif /* CONFIG_PPC_DCR */
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_DCR_H */
diff --git a/arch/powerpc/include/asm/epapr_hcalls.h b/arch/powerpc/include/asm/epapr_hcalls.h
index cdf3c6df5123a..8fc5aaa4bbbad 100644
--- a/arch/powerpc/include/asm/epapr_hcalls.h
+++ b/arch/powerpc/include/asm/epapr_hcalls.h
@@ -52,7 +52,7 @@
 
 #include <uapi/asm/epapr_hcalls.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <asm/byteorder.h>
@@ -571,5 +571,5 @@ static inline long epapr_hypercall4(unsigned int nr, unsigned long p1,
 	in[3] = p4;
 	return epapr_hypercall(in, out, nr);
 }
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 #endif /* _EPAPR_HCALLS_H */
diff --git a/arch/powerpc/include/asm/exception-64e.h b/arch/powerpc/include/asm/exception-64e.h
index b1ef1e92c34a1..1a83b1ff3578a 100644
--- a/arch/powerpc/include/asm/exception-64e.h
+++ b/arch/powerpc/include/asm/exception-64e.h
@@ -149,7 +149,7 @@ exc_##label##_book3e:
 	addi	r11,r13,PACA_EXTLB;					    \
 	TLB_MISS_RESTORE(r11)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern unsigned int interrupt_base_book3e;
 #endif
 
diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index bb6f78fcf981c..a9437e89f69f7 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -53,7 +53,7 @@
  */
 #define MAX_MCE_DEPTH	4
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 #define STF_ENTRY_BARRIER_SLOT						\
 	STF_ENTRY_BARRIER_FIXUP_SECTION;				\
@@ -170,9 +170,9 @@
 	RFSCV;								\
 	b	rfscv_flush_fallback
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 /* Prototype for function defined in exceptions-64s.S */
 void do_uaccess_flush(void);
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif	/* _ASM_POWERPC_EXCEPTION_H */
diff --git a/arch/powerpc/include/asm/extable.h b/arch/powerpc/include/asm/extable.h
index 26ce2e5c0fa8e..d483a9c24ba96 100644
--- a/arch/powerpc/include/asm/extable.h
+++ b/arch/powerpc/include/asm/extable.h
@@ -17,7 +17,7 @@
 
 #define ARCH_HAS_RELATIVE_EXTABLE
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct exception_table_entry {
 	int insn;
diff --git a/arch/powerpc/include/asm/feature-fixups.h b/arch/powerpc/include/asm/feature-fixups.h
index 17d168dd8b491..756a6c694018c 100644
--- a/arch/powerpc/include/asm/feature-fixups.h
+++ b/arch/powerpc/include/asm/feature-fixups.h
@@ -168,7 +168,7 @@ label##5:							\
 #define ALT_FW_FTR_SECTION_END_IFCLR(msk)	\
 	ALT_FW_FTR_SECTION_END_NESTED_IFCLR(msk, 97)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define ASM_FTR_IF(section_if, section_else, msk, val)	\
 	stringify_in_c(BEGIN_FTR_SECTION)			\
@@ -196,7 +196,7 @@ label##5:							\
 #define ASM_MMU_FTR_IFCLR(section_if, section_else, msk)	\
 	ASM_MMU_FTR_IF(section_if, section_else, (msk), 0)
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /* LWSYNC feature sections */
 #define START_LWSYNC_SECTION(label)	label##1:
@@ -276,7 +276,7 @@ label##3:					       	\
 	FTR_ENTRY_OFFSET 956b-957b;			\
 	.popsection;
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/types.h>
 
 extern long stf_barrier_fallback;
diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
index 69ae9cf57d50b..abd7c56f4d55c 100644
--- a/arch/powerpc/include/asm/firmware.h
+++ b/arch/powerpc/include/asm/firmware.h
@@ -58,7 +58,7 @@
 #define FW_FEATURE_WATCHDOG	ASM_CONST(0x0000080000000000)
 #define FW_FEATURE_PLPKS	ASM_CONST(0x0000100000000000)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 enum {
 #ifdef CONFIG_PPC64
@@ -146,6 +146,6 @@ void pseries_probe_fw_features(void);
 static inline void pseries_probe_fw_features(void) { }
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* __KERNEL__ */
 #endif /* __ASM_POWERPC_FIRMWARE_H */
diff --git a/arch/powerpc/include/asm/fixmap.h b/arch/powerpc/include/asm/fixmap.h
index f9068dd8dfce7..bc5109eab5b74 100644
--- a/arch/powerpc/include/asm/fixmap.h
+++ b/arch/powerpc/include/asm/fixmap.h
@@ -14,7 +14,7 @@
 #ifndef _ASM_FIXMAP_H
 #define _ASM_FIXMAP_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/sizes.h>
 #include <linux/pgtable.h>
 #include <asm/page.h>
@@ -111,5 +111,5 @@ static inline void __set_fixmap(enum fixed_addresses idx,
 #define VIRT_IMMR_BASE (__fix_to_virt(FIX_IMMR_BASE))
 #endif
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 #endif
diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index 82da7c7a1d125..bd61a230b19d0 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -15,7 +15,7 @@
 #define FTRACE_MCOUNT_MAX_OFFSET	8
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern void _mcount(void);
 
 unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip,
@@ -69,14 +69,14 @@ struct ftrace_ops;
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs);
 #endif
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 #define ARCH_SUPPORTS_FTRACE_OPS 1
 #endif
 #endif /* CONFIG_FUNCTION_TRACER */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #ifdef CONFIG_FTRACE_SYSCALLS
 /*
  * Some syscall entry functions on powerpc start with "ppc_" (fork and clone,
@@ -160,6 +160,6 @@ static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsi
 static inline void ftrace_free_init_tramp(void) { }
 static inline unsigned long ftrace_call_adjust(unsigned long addr) { return addr; }
 #endif
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* _ASM_POWERPC_FTRACE */
diff --git a/arch/powerpc/include/asm/head-64.h b/arch/powerpc/include/asm/head-64.h
index d73153b0275d6..3966bd5810cb6 100644
--- a/arch/powerpc/include/asm/head-64.h
+++ b/arch/powerpc/include/asm/head-64.h
@@ -4,7 +4,7 @@
 
 #include <asm/cache.h>
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 /*
  * We can't do CPP stringification and concatination directly into the section
  * name for some reason, so these macros can do it for us.
@@ -167,6 +167,6 @@ end_##sname:
 // find label from _within_ sname
 #define ABS_ADDR(label, sname) (label - start_ ## sname + sname ## _start)
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif	/* _ASM_POWERPC_HEAD_64_H */
diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 65d1f291393d2..8d6c0e3f641eb 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -498,7 +498,7 @@
 #define H_GUEST_CAP_POWER11	(1UL<<(63-3))
 #define H_GUEST_CAP_BITMAP2	(1UL<<(63-63))
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/types.h>
 
 /**
@@ -699,6 +699,6 @@ struct hv_gpci_request_buffer {
 	uint8_t bytes[HGPCI_MAX_DATA_BYTES];
 } __packed;
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_HVCALL_H */
diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 569ac1165b069..1078ba88efaf4 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -59,7 +59,7 @@
 #define IRQS_PMI_DISABLED	2
 #define IRQS_ALL_DISABLED	(IRQS_DISABLED | IRQS_PMI_DISABLED)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 static inline void __hard_irq_enable(void)
 {
@@ -516,6 +516,6 @@ static inline unsigned long mtmsr_isync_irqsafe(unsigned long msr)
 
 #define ARCH_IRQ_INIT_FLAGS	IRQ_NOREQUEST
 
-#endif  /* __ASSEMBLY__ */
+#endif  /* __ASSEMBLER__ */
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_POWERPC_HW_IRQ_H */
diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
index 23638d4e73ac0..eb0e4a20b8188 100644
--- a/arch/powerpc/include/asm/interrupt.h
+++ b/arch/powerpc/include/asm/interrupt.h
@@ -64,7 +64,7 @@
 #define INTERRUPT_DATA_LOAD_TLB_MISS_603	0x1100
 #define INTERRUPT_DATA_STORE_TLB_MISS_603	0x1200
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/context_tracking.h>
 #include <linux/hardirq.h>
@@ -675,6 +675,6 @@ unsigned long interrupt_exit_user_restart(struct pt_regs *regs);
 unsigned long interrupt_exit_kernel_restart(struct pt_regs *regs);
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_POWERPC_INTERRUPT_H */
diff --git a/arch/powerpc/include/asm/irqflags.h b/arch/powerpc/include/asm/irqflags.h
index 47d46712928ac..1351fb40fe749 100644
--- a/arch/powerpc/include/asm/irqflags.h
+++ b/arch/powerpc/include/asm/irqflags.h
@@ -5,7 +5,7 @@
 #ifndef _ASM_IRQFLAGS_H
 #define _ASM_IRQFLAGS_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * Get definitions for arch_local_save_flags(x), etc.
  */
diff --git a/arch/powerpc/include/asm/jump_label.h b/arch/powerpc/include/asm/jump_label.h
index 2f2a86ed2280a..d4eaba459a0ed 100644
--- a/arch/powerpc/include/asm/jump_label.h
+++ b/arch/powerpc/include/asm/jump_label.h
@@ -6,7 +6,7 @@
  * Copyright 2010 Michael Ellerman, IBM Corp.
  */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/types.h>
 
 #include <asm/feature-fixups.h>
diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
index b5bbb94c51f6d..db12149446224 100644
--- a/arch/powerpc/include/asm/kasan.h
+++ b/arch/powerpc/include/asm/kasan.h
@@ -12,7 +12,7 @@
 #define EXPORT_SYMBOL_KASAN(fn)
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/page.h>
 #include <linux/sizes.h>
@@ -80,5 +80,5 @@ void kasan_update_early_region(unsigned long k_start, unsigned long k_end, pte_t
 int kasan_init_shadow_page_tables(unsigned long k_start, unsigned long k_end);
 int kasan_init_region(void *start, size_t size);
 
-#endif /* __ASSEMBLY */
+#endif /* __ASSEMBLER__ */
 #endif
diff --git a/arch/powerpc/include/asm/kdump.h b/arch/powerpc/include/asm/kdump.h
index fd128d1e52b3b..802644178f432 100644
--- a/arch/powerpc/include/asm/kdump.h
+++ b/arch/powerpc/include/asm/kdump.h
@@ -31,7 +31,7 @@
 
 #endif /* CONFIG_CRASH_DUMP */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #if defined(CONFIG_CRASH_DUMP) && !defined(CONFIG_NONSTATIC_KERNEL)
 extern void reserve_kdump_trampoline(void);
@@ -42,6 +42,6 @@ static inline void reserve_kdump_trampoline(void) { ; }
 static inline void setup_kdump_trampoline(void) { ; }
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __PPC64_KDUMP_H */
diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 601e569303e1b..23fe1560d5444 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -49,7 +49,7 @@
 #define KEXEC_STATE_IRQS_OFF 1
 #define KEXEC_STATE_REAL_MODE 2
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/reg.h>
 
 typedef void (*crash_shutdown_t)(void);
@@ -208,6 +208,6 @@ static inline void reset_sprs(void)
 }
 #endif
 
-#endif /* ! __ASSEMBLY__ */
+#endif /* ! __ASSEMBLER__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_KEXEC_H */
diff --git a/arch/powerpc/include/asm/kgdb.h b/arch/powerpc/include/asm/kgdb.h
index 715c18b753346..f39531903325a 100644
--- a/arch/powerpc/include/asm/kgdb.h
+++ b/arch/powerpc/include/asm/kgdb.h
@@ -21,7 +21,7 @@
 #ifndef __POWERPC_KGDB_H__
 #define __POWERPC_KGDB_H__
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define BREAK_INSTR_SIZE	4
 #define BUFMAX			((NUMREGBYTES * 2) + 512)
@@ -62,6 +62,6 @@ static inline void arch_kgdb_breakpoint(void)
 /* CR/LR, R1, R2, R13-R31 inclusive. */
 #define NUMCRITREGBYTES		(23 * sizeof(int))
 #endif /* 32/64 */
-#endif /* !(__ASSEMBLY__) */
+#endif /* !(__ASSEMBLER__) */
 #endif /* !__POWERPC_KGDB_H__ */
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index 2bb03d941e3e8..dab63b82a8d4f 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -6,7 +6,7 @@
 #define KUAP_WRITE	2
 #define KUAP_READ_WRITE	(KUAP_READ | KUAP_WRITE)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/types.h>
 
 static __always_inline bool kuap_is_disabled(void);
@@ -28,14 +28,14 @@ static __always_inline bool kuap_is_disabled(void);
 #include <asm/book3s/32/kup.h>
 #endif
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #ifndef CONFIG_PPC_KUAP
 .macro kuap_check_amr	gpr1, gpr2
 .endm
 
 #endif
 
-#else /* !__ASSEMBLY__ */
+#else /* !__ASSEMBLER__ */
 
 extern bool disable_kuep;
 extern bool disable_kuap;
@@ -181,6 +181,6 @@ static __always_inline void prevent_current_write_to_user(void)
 	prevent_user_access(KUAP_WRITE);
 }
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* _ASM_POWERPC_KUAP_H_ */
diff --git a/arch/powerpc/include/asm/kvm_asm.h b/arch/powerpc/include/asm/kvm_asm.h
index d68d71987d5cf..f9af8df090775 100644
--- a/arch/powerpc/include/asm/kvm_asm.h
+++ b/arch/powerpc/include/asm/kvm_asm.h
@@ -9,7 +9,7 @@
 #ifndef __POWERPC_KVM_ASM_H__
 #define __POWERPC_KVM_ASM_H__
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #ifdef CONFIG_64BIT
 #define PPC_STD(sreg, offset, areg)  std sreg, (offset)(areg)
 #define PPC_LD(treg, offset, areg)   ld treg, (offset)(areg)
diff --git a/arch/powerpc/include/asm/kvm_book3s_asm.h b/arch/powerpc/include/asm/kvm_book3s_asm.h
index a36797938620f..3435fe144908f 100644
--- a/arch/powerpc/include/asm/kvm_book3s_asm.h
+++ b/arch/powerpc/include/asm/kvm_book3s_asm.h
@@ -20,7 +20,7 @@
 /* Maximum number of subcores per physical core */
 #define MAX_SUBCORES		4
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 #ifdef CONFIG_KVM_BOOK3S_HANDLER
 
@@ -58,7 +58,7 @@ kvmppc_resume_\intno:
 
 #endif /* CONFIG_KVM_BOOK3S_HANDLER */
 
-#else  /*__ASSEMBLY__ */
+#else  /*__ASSEMBLER__ */
 
 struct kvmppc_vcore;
 
@@ -150,7 +150,7 @@ struct kvmppc_book3s_shadow_vcpu {
 #endif
 };
 
-#endif /*__ASSEMBLY__ */
+#endif /*__ASSEMBLER__ */
 
 /* Values for kvm_state */
 #define KVM_HWTHREAD_IN_KERNEL	0
diff --git a/arch/powerpc/include/asm/kvm_booke_hv_asm.h b/arch/powerpc/include/asm/kvm_booke_hv_asm.h
index 7487ef5821210..3acf2995d364c 100644
--- a/arch/powerpc/include/asm/kvm_booke_hv_asm.h
+++ b/arch/powerpc/include/asm/kvm_booke_hv_asm.h
@@ -8,7 +8,7 @@
 
 #include <asm/feature-fixups.h>
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 /*
  * All exceptions from guest state must go through KVM
@@ -64,5 +64,5 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
 #endif
 .endm
 
-#endif /*__ASSEMBLY__ */
+#endif /*__ASSEMBLER__ */
 #endif /* ASM_KVM_BOOKE_HV_ASM_H */
diff --git a/arch/powerpc/include/asm/lv1call.h b/arch/powerpc/include/asm/lv1call.h
index b11501b30193b..ae70120953a85 100644
--- a/arch/powerpc/include/asm/lv1call.h
+++ b/arch/powerpc/include/asm/lv1call.h
@@ -10,7 +10,7 @@
 #if !defined(_ASM_POWERPC_LV1CALL_H)
 #define _ASM_POWERPC_LV1CALL_H
 
-#if !defined(__ASSEMBLY__)
+#if !defined(__ASSEMBLER__)
 
 #include <linux/types.h>
 #include <linux/export.h>
@@ -211,7 +211,7 @@
     {return _lv1_##name(LV1_##in##_IN_##out##_OUT_ARGS);}
 #endif
 
-#endif /* !defined(__ASSEMBLY__) */
+#endif /* !defined(__ASSEMBLER__) */
 
 /* lv1 call table */
 
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 4182d68d9cd17..5f9c5d436e171 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -137,7 +137,7 @@
 				MMU_FTR_CI_LARGE_PAGE
 #define MMU_FTRS_PA6T		MMU_FTRS_DEFAULT_HPTE_ARCH_V2 | \
 				MMU_FTR_CI_LARGE_PAGE | MMU_FTR_NO_SLBIE_B
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/bug.h>
 #include <asm/cputable.h>
 #include <asm/page.h>
@@ -332,7 +332,7 @@ static inline bool strict_module_rwx_enabled(void)
 {
 	return IS_ENABLED(CONFIG_STRICT_MODULE_RWX) && strict_kernel_rwx_enabled();
 }
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /* The kernel use the constants below to index in the page sizes array.
  * The use of fixed constants for this purpose is better for performances
@@ -377,7 +377,7 @@ static inline bool strict_module_rwx_enabled(void)
 #include <asm/book3s/64/mmu.h>
 #else /* CONFIG_PPC_BOOK3S_64 */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /* MMU initialization */
 extern void early_init_mmu(void);
 extern void early_init_mmu_secondary(void);
@@ -388,7 +388,7 @@ static inline void mmu_early_init_devtree(void) { }
 static inline void pkey_early_init_devtree(void) {}
 
 extern void *abatron_pteptrs[2];
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif
 
 #if defined(CONFIG_PPC_BOOK3S_32)
diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/asm/mpc52xx.h
index 01ae6c351e502..d7ffbd06797d2 100644
--- a/arch/powerpc/include/asm/mpc52xx.h
+++ b/arch/powerpc/include/asm/mpc52xx.h
@@ -13,10 +13,10 @@
 #ifndef __ASM_POWERPC_MPC52xx_H__
 #define __ASM_POWERPC_MPC52xx_H__
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/types.h>
 #include <asm/mpc5xxx.h>
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #include <linux/suspend.h>
 
@@ -30,7 +30,7 @@
 /* Structures mapping of some unit register set                             */
 /* ======================================================================== */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /* Memory Mapping Control */
 struct mpc52xx_mmap_ctl {
@@ -258,14 +258,14 @@ struct mpc52xx_intr {
 	u32 per_error;		/* INTR + 0x38 */
 };
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 
 /* ========================================================================= */
 /* Prototypes for MPC52xx sysdev                                             */
 /* ========================================================================= */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct device_node;
 
@@ -297,7 +297,7 @@ extern void __init mpc52xx_setup_pci(void);
 static inline void mpc52xx_setup_pci(void) { }
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #ifdef CONFIG_PM
 struct mpc52xx_suspend {
diff --git a/arch/powerpc/include/asm/nohash/32/kup-8xx.h b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
index 46bc5925e5fdc..08486b15b2075 100644
--- a/arch/powerpc/include/asm/nohash/32/kup-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
@@ -7,7 +7,7 @@
 
 #ifdef CONFIG_PPC_KUAP
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/reg.h>
 
@@ -82,7 +82,7 @@ __bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
 	return !((regs->kuap ^ MD_APG_KUAP) & 0xff000000);
 }
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* CONFIG_PPC_KUAP */
 
diff --git a/arch/powerpc/include/asm/nohash/32/mmu-44x.h b/arch/powerpc/include/asm/nohash/32/mmu-44x.h
index 2d92a39d8f2e8..c3d1921943244 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu-44x.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu-44x.h
@@ -100,7 +100,7 @@
 #define PPC47x_TLB2_S_RW	(PPC47x_TLB2_SW | PPC47x_TLB2_SR)
 #define PPC47x_TLB2_IMG		(PPC47x_TLB2_I | PPC47x_TLB2_M | PPC47x_TLB2_G)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 extern unsigned int tlb_44x_hwater;
 extern unsigned int tlb_44x_index;
@@ -114,7 +114,7 @@ typedef struct {
 /* patch sites */
 extern s32 patch__tlb_44x_hwater_D, patch__tlb_44x_hwater_I;
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #ifndef CONFIG_PPC_EARLY_DEBUG_44x
 #define PPC44x_EARLY_TLBS	1
diff --git a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
index 2986f9ba40b88..f19115db8072f 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
@@ -174,7 +174,7 @@
 #define MODULES_SIZE	(CONFIG_MODULES_SIZE * SZ_1M)
 #define MODULES_VADDR	(MODULES_END - MODULES_SIZE)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/mmdebug.h>
 #include <linux/sizes.h>
@@ -265,6 +265,6 @@ static inline int arch_vmap_pte_supported_shift(unsigned long size)
 extern s32 patch__itlbmiss_exit_1, patch__dtlbmiss_exit_1;
 extern s32 patch__itlbmiss_perf, patch__dtlbmiss_perf;
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* _ASM_POWERPC_MMU_8XX_H_ */
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index b481738c4bb52..2d71e4b7cd09c 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -4,12 +4,12 @@
 
 #include <asm-generic/pgtable-nopmd.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/sched.h>
 #include <linux/threads.h>
 #include <asm/mmu.h>			/* For sub-arch specific PPC_PIN_SIZE */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #define PTE_INDEX_SIZE	PTE_SHIFT
 #define PMD_INDEX_SIZE	0
@@ -19,14 +19,14 @@
 #define PMD_CACHE_INDEX	PMD_INDEX_SIZE
 #define PUD_CACHE_INDEX	PUD_INDEX_SIZE
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #define PTE_TABLE_SIZE	(sizeof(pte_t) << PTE_INDEX_SIZE)
 #define PMD_TABLE_SIZE	0
 #define PUD_TABLE_SIZE	0
 #define PGD_TABLE_SIZE	(sizeof(pgd_t) << PGD_INDEX_SIZE)
 
 #define PMD_MASKED_BITS (PTE_TABLE_SIZE - 1)
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 #define PTRS_PER_PTE	(1 << PTE_INDEX_SIZE)
 #define PTRS_PER_PGD	(1 << PGD_INDEX_SIZE)
@@ -149,7 +149,7 @@
 #define MAX_POSSIBLE_PHYSMEM_BITS 32
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define	pmd_bad(pmd)		(pmd_val(pmd) & _PMD_BAD)
@@ -199,6 +199,6 @@ static inline void pmd_clear(pmd_t *pmdp)
 /* We borrow LSB 2 to store the exclusive marker in swap PTEs. */
 #define _PAGE_SWP_EXCLUSIVE	0x000004
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_POWERPC_NOHASH_32_PGTABLE_H */
diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index 54ebb91dbdcf3..e2ea8ba9f8cae 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -83,7 +83,7 @@
 
 #include <asm/pgtable-masks.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 static inline pte_t pte_wrprotect(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_RO);
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable-4k.h b/arch/powerpc/include/asm/nohash/64/pgtable-4k.h
index 10f5cf444d72a..fb6fa1d4e0749 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable-4k.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable-4k.h
@@ -14,12 +14,12 @@
 #define PUD_INDEX_SIZE  9
 #define PGD_INDEX_SIZE  9
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #define PTE_TABLE_SIZE	(sizeof(pte_t) << PTE_INDEX_SIZE)
 #define PMD_TABLE_SIZE	(sizeof(pmd_t) << PMD_INDEX_SIZE)
 #define PUD_TABLE_SIZE	(sizeof(pud_t) << PUD_INDEX_SIZE)
 #define PGD_TABLE_SIZE	(sizeof(pgd_t) << PGD_INDEX_SIZE)
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 #define PTRS_PER_PTE	(1 << PTE_INDEX_SIZE)
 #define PTRS_PER_PMD	(1 << PMD_INDEX_SIZE)
@@ -57,7 +57,7 @@
 #define p4d_bad(p4d)		(p4d_val(p4d) == 0)
 #define p4d_present(p4d)	(p4d_val(p4d) != 0)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 static inline pud_t *p4d_pgtable(p4d_t p4d)
 {
@@ -80,7 +80,7 @@ static inline p4d_t pte_p4d(pte_t pte)
 }
 extern struct page *p4d_page(p4d_t p4d);
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #define pud_ERROR(e) \
 	pr_err("%s:%d: bad pud %08lx.\n", __FILE__, __LINE__, pud_val(e))
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 2202c78730e8e..2deb955b7bc89 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -77,7 +77,7 @@
 
 #define H_PAGE_4K_PFN 0
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /* pte_clear moved to later in this file */
 
 #define PMD_BAD_BITS		(PTE_TABLE_SIZE-1)
@@ -209,6 +209,6 @@ void __patch_exception(int exc, unsigned long addr);
 	__patch_exception((exc), (unsigned long)&name); \
 } while (0)
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_POWERPC_NOHASH_64_PGTABLE_H */
diff --git a/arch/powerpc/include/asm/nohash/kup-booke.h b/arch/powerpc/include/asm/nohash/kup-booke.h
index 0c7c3258134c5..d6bbb6d78bbe4 100644
--- a/arch/powerpc/include/asm/nohash/kup-booke.h
+++ b/arch/powerpc/include/asm/nohash/kup-booke.h
@@ -7,7 +7,7 @@
 
 #ifdef CONFIG_PPC_KUAP
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 .macro kuap_check_amr	gpr1, gpr2
 .endm
@@ -105,7 +105,7 @@ __bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
 	return !regs->kuap;
 }
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* CONFIG_PPC_KUAP */
 
diff --git a/arch/powerpc/include/asm/nohash/mmu-e500.h b/arch/powerpc/include/asm/nohash/mmu-e500.h
index b281d9eeaf1e6..2fad5ff426a0a 100644
--- a/arch/powerpc/include/asm/nohash/mmu-e500.h
+++ b/arch/powerpc/include/asm/nohash/mmu-e500.h
@@ -230,7 +230,7 @@
 #define MAS2_M_IF_NEEDED	0
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/bug.h>
 
 extern unsigned int tlbcam_index;
@@ -318,6 +318,6 @@ extern int book3e_htw_mode;
 #include <asm/percpu.h>
 DECLARE_PER_CPU(int, next_tlbcam_idx);
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* _ASM_POWERPC_MMU_BOOK3E_H_ */
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 8d1f0b7062eb2..69d73695cd157 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_POWERPC_NOHASH_PGTABLE_H
 #define _ASM_POWERPC_NOHASH_PGTABLE_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, pte_t *p,
 				     unsigned long clr, unsigned long set, int huge);
 #endif
@@ -27,7 +27,7 @@ static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, p
 #define PAGE_KERNEL_RO	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RO)
 #define PAGE_KERNEL_ROX	__pgprot(_PAGE_BASE | _PAGE_KERNEL_ROX)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 extern int icache_44x_need_flush;
 
@@ -373,5 +373,5 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 int map_kernel_page(unsigned long va, phys_addr_t pa, pgprot_t prot);
 void unmap_kernel_page(unsigned long va);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif
diff --git a/arch/powerpc/include/asm/nohash/pte-e500.h b/arch/powerpc/include/asm/nohash/pte-e500.h
index cb78392494da0..b61efc3ee9040 100644
--- a/arch/powerpc/include/asm/nohash/pte-e500.h
+++ b/arch/powerpc/include/asm/nohash/pte-e500.h
@@ -86,7 +86,7 @@
 
 #include <asm/pgtable-masks.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 static inline pte_t pte_mkexec(pte_t pte)
 {
 	return __pte((pte_val(pte) & ~_PAGE_BAP_SX) | _PAGE_BAP_UX);
@@ -134,7 +134,7 @@ static inline unsigned long pud_leaf_size(pud_t pud)
 
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __KERNEL__ */
 #endif /*  _ASM_POWERPC_NOHASH_PTE_E500_H */
diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 8c9d4b26bf579..d3eaa34257970 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -246,7 +246,7 @@
 #define OPAL_CONFIG_IDLE_UNDO		0
 #define OPAL_CONFIG_IDLE_APPLY		1
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /* Other enums */
 enum OpalFreezeState {
@@ -1183,6 +1183,6 @@ struct opal_mpipl_fadump {
 	struct	opal_mpipl_region region[];
 } __packed;
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __OPAL_API_H */
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index af304e6cb486c..0a398265ba04e 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -10,7 +10,7 @@
 
 #include <asm/opal-api.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/notifier.h>
 
@@ -390,6 +390,6 @@ void opal_powercap_init(void);
 void opal_psr_init(void);
 void opal_sensor_groups_init(void);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_POWERPC_OPAL_H */
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index af9a2628d1df0..b28fbb1d57eb9 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -6,7 +6,7 @@
  * Copyright (C) 2001,2005 IBM Corporation.
  */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/bug.h>
@@ -23,7 +23,7 @@
  */
 #include <vdso/page.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #ifndef CONFIG_HUGETLB_PAGE
 #define HPAGE_SHIFT PAGE_SHIFT
 #elif defined(CONFIG_PPC_BOOK3S_64)
@@ -75,7 +75,7 @@ extern unsigned int hpage_shift;
 #define LOAD_OFFSET	ASM_CONST((CONFIG_KERNEL_START-CONFIG_PHYSICAL_START))
 
 #if defined(CONFIG_NONSTATIC_KERNEL)
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 extern phys_addr_t memstart_addr;
 extern phys_addr_t kernstart_addr;
@@ -84,7 +84,7 @@ extern phys_addr_t kernstart_addr;
 extern long long virt_phys_offset;
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #define PHYSICAL_START	kernstart_addr
 
 #else	/* !CONFIG_NONSTATIC_KERNEL */
@@ -216,7 +216,7 @@ extern long long virt_phys_offset;
 #endif
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 static inline unsigned long virt_to_pfn(const void *kaddr)
 {
 	return __pa(kaddr) >> PAGE_SHIFT;
@@ -261,7 +261,7 @@ static inline const void *pfn_to_kaddr(unsigned long pfn)
 #define is_kernel_addr(x)	((x) >= TASK_SIZE)
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef CONFIG_PPC_BOOK3S_64
 #include <asm/pgtable-be-types.h>
@@ -290,6 +290,6 @@ static inline unsigned long kaslr_offset(void)
 }
 
 #include <asm-generic/memory_model.h>
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_POWERPC_PAGE_H */
diff --git a/arch/powerpc/include/asm/page_32.h b/arch/powerpc/include/asm/page_32.h
index b9ac9e3a771cb..25482405a8111 100644
--- a/arch/powerpc/include/asm/page_32.h
+++ b/arch/powerpc/include/asm/page_32.h
@@ -19,7 +19,7 @@
 #define PTE_SHIFT	(PAGE_SHIFT - PTE_T_LOG2)	/* full page */
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * The basic type of a PTE - 64 bits for those CPUs with > 32 bit
  * physical addressing.
@@ -53,6 +53,6 @@ extern void copy_page(void *to, void *from);
 #define PGD_T_LOG2	(__builtin_ffs(sizeof(pgd_t)) - 1)
 #define PTE_T_LOG2	(__builtin_ffs(sizeof(pte_t)) - 1)
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_POWERPC_PAGE_32_H */
diff --git a/arch/powerpc/include/asm/page_64.h b/arch/powerpc/include/asm/page_64.h
index 79a9b7c6a132c..0f564a06bf684 100644
--- a/arch/powerpc/include/asm/page_64.h
+++ b/arch/powerpc/include/asm/page_64.h
@@ -35,7 +35,7 @@
 #define ESID_MASK_1T		0xffffff0000000000UL
 #define GET_ESID_1T(x)		(((x) >> SID_SHIFT_1T) & SID_MASK_1T)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/cache.h>
 
 typedef unsigned long pte_basic_t;
@@ -82,7 +82,7 @@ extern void copy_page(void *to, void *from);
 /* Log 2 of page table size */
 extern u64 ppc64_pft_size;
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #define VM_DATA_DEFAULT_FLAGS \
 	(is_32bit_task() ? \
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 2f72ad885332e..0736234064b10 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_POWERPC_PGTABLE_H
 #define _ASM_POWERPC_PGTABLE_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/mmdebug.h>
 #include <linux/mmzone.h>
 #include <asm/processor.h>		/* For TASK_SIZE */
@@ -12,7 +12,7 @@
 
 struct mm_struct;
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #ifdef CONFIG_PPC_BOOK3S
 #include <asm/book3s/pgtable.h>
@@ -39,7 +39,7 @@ struct mm_struct;
 #define PAGE_AGP		(PAGE_KERNEL_NC)
 #define HAVE_PAGE_AGP
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define PFN_PTE_SHIFT		PTE_RPN_SHIFT
 
@@ -215,6 +215,6 @@ static inline bool arch_supports_memmap_on_memory(unsigned long vmemmap_size)
 
 #endif /* CONFIG_PPC64 */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_POWERPC_PGTABLE_H */
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 02897f4b0dbf8..80d77d77a5bf0 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -12,7 +12,7 @@
 #include <asm/feature-fixups.h>
 #include <asm/extable.h>
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 #define SZL			(BITS_PER_LONG/8)
 
@@ -868,7 +868,7 @@ END_FTR_SECTION_NESTED(CPU_FTR_CELL_TB_BUG, CPU_FTR_CELL_TB_BUG, 96)
 
 #endif /* !CONFIG_PPC_BOOK3E_64 */
 
-#endif /*  __ASSEMBLY__ */
+#endif /*  __ASSEMBLER__ */
 
 #define SOFT_MASK_TABLE(_start, _end)		\
 	stringify_in_c(.section __soft_mask_table,"a";)\
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 6b94de17201c7..f156bdb43e2be 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -29,14 +29,14 @@
 #ifdef CONFIG_PPC64
 /* Default SMT priority is set to 3. Use 11- 13bits to save priority. */
 #define PPR_PRIORITY 3
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define DEFAULT_PPR (PPR_PRIORITY << 50)
 #else
 #define DEFAULT_PPR ((u64)PPR_PRIORITY << 50)
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* CONFIG_PPC64 */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/types.h>
 #include <linux/thread_info.h>
 #include <asm/ptrace.h>
@@ -460,5 +460,5 @@ int enter_vmx_ops(void);
 void *exit_vmx_ops(void *dest);
 
 #endif /* __KERNEL__ */
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_POWERPC_PROCESSOR_H */
diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 7b9350756875a..94aa1de2b06e1 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -24,7 +24,7 @@
 #include <asm/asm-const.h>
 #include <asm/reg.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 struct pt_regs
 {
 	union {
@@ -165,7 +165,7 @@ struct pt_regs
 #define STACK_INT_FRAME_SIZE	(KERNEL_REDZONE_SIZE + STACK_USER_INT_FRAME_SIZE)
 #define STACK_INT_FRAME_MARKER_LONGS	(STACK_INT_FRAME_MARKER/sizeof(long))
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/paca.h>
 
 #ifdef CONFIG_SMP
@@ -414,7 +414,7 @@ static inline unsigned long regs_get_kernel_argument(struct pt_regs *regs, unsig
 	return 0;
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #ifndef __powerpc64__
 /* We need PT_SOFTE defined at all time to avoid #ifdefs */
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 0228c90bbcc7b..3fe1866354323 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -60,7 +60,7 @@
 #define MSR_RI_LG	1		/* Recoverable Exception */
 #define MSR_LE_LG	0 		/* Little Endian */
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define __MASK(X)	(1<<(X))
 #else
 #define __MASK(X)	(1UL<<(X))
@@ -1358,7 +1358,7 @@
 #define PVR_ARCH_31_P11	0x0f000007
 
 /* Macros for setting and retrieving special purpose registers */
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #if defined(CONFIG_PPC64) || defined(__CHECKER__)
 typedef struct {
@@ -1450,6 +1450,6 @@ extern void scom970_write(unsigned int address, unsigned long value);
 struct pt_regs;
 
 extern void ppc_save_regs(struct pt_regs *regs);
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_REG_H */
diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 656bfaf91526e..56f9d3b1de859 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -576,7 +576,7 @@
 
 #define TEN_THREAD(x)	(1 << (x))
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #define mftmr(rn)	({unsigned long rval; \
 			asm volatile(MFTMR(rn, %0) : "=r" (rval)); rval;})
 #define mttmr(rn, v)	asm volatile(MTTMR(rn, %0) : \
@@ -585,7 +585,7 @@
 
 extern unsigned long global_dbcr0[];
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_POWERPC_REG_BOOKE_H__ */
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/include/asm/reg_fsl_emb.h b/arch/powerpc/include/asm/reg_fsl_emb.h
index 9893d2001b680..ec459c3d9498a 100644
--- a/arch/powerpc/include/asm/reg_fsl_emb.h
+++ b/arch/powerpc/include/asm/reg_fsl_emb.h
@@ -9,7 +9,7 @@
 
 #include <linux/stringify.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /* Performance Monitor Registers */
 static __always_inline unsigned int mfpmr(unsigned int rn)
 {
@@ -32,7 +32,7 @@ static __always_inline void mtpmr(unsigned int rn, unsigned int val)
 	     ".machine pop;"
 	     : [val] "=r" (val) : [rn] "i" (rn));
 }
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /* Freescale Book E Performance Monitor APU Registers */
 #define PMRN_PMC0	0x010	/* Performance Monitor Counter 0 */
diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index eed74c1fb832f..50a92b24628da 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -4,7 +4,7 @@
 
 #include <uapi/asm/setup.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern void ppc_printk_progress(char *s, unsigned short hex);
 
 extern unsigned long long memory_limit;
@@ -89,7 +89,7 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 
 extern struct seq_buf ppc_hw_desc;
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif	/* _ASM_POWERPC_SETUP_H */
 
diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index b77927ccb0ab0..e41b9ea42122b 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -18,7 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/irqreturn.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
@@ -266,7 +266,7 @@ extern char __secondary_hold;
 extern unsigned int booting_thread_hwid;
 
 extern void __early_start(void);
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_SMP_H) */
diff --git a/arch/powerpc/include/asm/spu_csa.h b/arch/powerpc/include/asm/spu_csa.h
index c33df961c0454..1b3271a033928 100644
--- a/arch/powerpc/include/asm/spu_csa.h
+++ b/arch/powerpc/include/asm/spu_csa.h
@@ -43,7 +43,7 @@
 #define SPU_DECR_STATUS_RUNNING 0x1
 #define SPU_DECR_STATUS_WRAPPED 0x2
 
-#ifndef  __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /**
  * spu_reg128 - generic 128-bit register definition.
  */
@@ -243,5 +243,5 @@ struct spu_state {
 
 #endif /* !__SPU__ */
 #endif /* __KERNEL__ */
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 #endif /* _SPU_CSA_H_ */
diff --git a/arch/powerpc/include/asm/synch.h b/arch/powerpc/include/asm/synch.h
index b0b4c64870d77..0d3ccb34adfb2 100644
--- a/arch/powerpc/include/asm/synch.h
+++ b/arch/powerpc/include/asm/synch.h
@@ -7,7 +7,7 @@
 #include <asm/feature-fixups.h>
 #include <asm/ppc-opcode.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern unsigned int __start___lwsync_fixup, __stop___lwsync_fixup;
 extern void do_lwsync_fixups(unsigned long value, void *fixup_start,
 			     void *fixup_end);
@@ -40,7 +40,7 @@ static inline void ppc_after_tlbiel_barrier(void)
 	 */
 	asm volatile(ASM_FTR_IFSET(PPC_CP_ABORT, "", %0) : : "i" (CPU_FTR_ARCH_31) : "memory");
 }
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #if defined(__powerpc64__)
 #    define LWSYNC	lwsync
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 2785c7462ebf7..b0f200aba2b3d 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -41,7 +41,7 @@
 
 #define THREAD_ALIGN		(1 << THREAD_ALIGN_SHIFT)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/cache.h>
 #include <asm/processor.h>
 #include <asm/accounting.h>
@@ -89,7 +89,7 @@ extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src
 void arch_setup_new_exec(void);
 #define arch_setup_new_exec arch_setup_new_exec
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * thread information flag bit numbers
@@ -162,7 +162,7 @@ void arch_setup_new_exec(void);
 #define _TLF_LAZY_MMU		(1 << TLF_LAZY_MMU)
 #define _TLF_RUNLATCH		(1 << TLF_RUNLATCH)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 static inline void clear_thread_local_flags(unsigned int flags)
 {
@@ -233,7 +233,7 @@ static inline int arch_within_stack_frames(const void * const stack,
 extern void *emergency_ctx[];
 #endif
 
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 
 #endif /* __KERNEL__ */
 
diff --git a/arch/powerpc/include/asm/tm.h b/arch/powerpc/include/asm/tm.h
index e94f6db5e367b..d700affba4480 100644
--- a/arch/powerpc/include/asm/tm.h
+++ b/arch/powerpc/include/asm/tm.h
@@ -8,7 +8,7 @@
 
 #include <uapi/asm/tm.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 extern void tm_reclaim(struct thread_struct *thread,
 		       uint8_t cause);
@@ -19,4 +19,4 @@ extern void tm_restore_sprs(struct thread_struct *thread);
 
 extern bool tm_suspend_disabled;
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
diff --git a/arch/powerpc/include/asm/types.h b/arch/powerpc/include/asm/types.h
index 93157a661dcc7..55d7ba6d910bd 100644
--- a/arch/powerpc/include/asm/types.h
+++ b/arch/powerpc/include/asm/types.h
@@ -11,10 +11,10 @@
 
 #include <uapi/asm/types.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 typedef __vector128 vector128;
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_POWERPC_TYPES_H */
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index 027ef94a12fbd..b873fbb6d712f 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -9,7 +9,7 @@
 
 #define NR_syscalls	__NR_syscalls
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 #include <linux/compiler.h>
@@ -52,5 +52,5 @@
 #define __ARCH_WANT_SYS_VFORK
 #define __ARCH_WANT_SYS_CLONE
 
-#endif		/* __ASSEMBLY__ */
+#endif		/* __ASSEMBLER__ */
 #endif /* _ASM_POWERPC_UNISTD_H_ */
diff --git a/arch/powerpc/include/asm/vdso.h b/arch/powerpc/include/asm/vdso.h
index 8d972bc98b55f..916c19ed68430 100644
--- a/arch/powerpc/include/asm/vdso.h
+++ b/arch/powerpc/include/asm/vdso.h
@@ -4,7 +4,7 @@
 
 #define VDSO_VERSION_STRING	LINUX_2.6.15
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef CONFIG_PPC64
 #include <generated/vdso64-offsets.h>
@@ -20,7 +20,7 @@
 
 int vdso_getcpu_init(void);
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 #ifdef __VDSO64__
 #define V_FUNCTION_BEGIN(name)		\
@@ -48,6 +48,6 @@ int vdso_getcpu_init(void);
 
 #endif /* __VDSO32__ */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_POWERPC_VDSO_H */
diff --git a/arch/powerpc/include/asm/vdso/getrandom.h b/arch/powerpc/include/asm/vdso/getrandom.h
index 80ce0709725eb..bf4c537114029 100644
--- a/arch/powerpc/include/asm/vdso/getrandom.h
+++ b/arch/powerpc/include/asm/vdso/getrandom.h
@@ -5,7 +5,7 @@
 #ifndef _ASM_POWERPC_VDSO_GETRANDOM_H
 #define _ASM_POWERPC_VDSO_GETRANDOM_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/vdso_datapage.h>
 
@@ -61,6 +61,6 @@ static __always_inline struct vdso_rng_data *__arch_get_vdso_rng_data(void)
 ssize_t __c_kernel_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state,
 			     size_t opaque_len);
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* _ASM_POWERPC_VDSO_GETRANDOM_H */
diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h b/arch/powerpc/include/asm/vdso/gettimeofday.h
index c6390890a60c2..7ab57669103ff 100644
--- a/arch/powerpc/include/asm/vdso/gettimeofday.h
+++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_POWERPC_VDSO_GETTIMEOFDAY_H
 #define _ASM_POWERPC_VDSO_GETTIMEOFDAY_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/vdso/timebase.h>
 #include <asm/barrier.h>
@@ -150,6 +150,6 @@ int __c_kernel_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz
 			    const struct vdso_data *vd);
 __kernel_old_time_t __c_kernel_time(__kernel_old_time_t *time,
 				    const struct vdso_data *vd);
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_POWERPC_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/powerpc/include/asm/vdso/processor.h b/arch/powerpc/include/asm/vdso/processor.h
index 80d13207c5688..c1f3d7aaf3ee9 100644
--- a/arch/powerpc/include/asm/vdso/processor.h
+++ b/arch/powerpc/include/asm/vdso/processor.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_POWERPC_VDSO_PROCESSOR_H
 #define _ASM_POWERPC_VDSO_PROCESSOR_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /* Macros for adjusting thread priority (hardware multi-threading) */
 #ifdef CONFIG_PPC64
@@ -33,6 +33,6 @@
 #define cpu_relax()	barrier()
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_POWERPC_VDSO_PROCESSOR_H */
diff --git a/arch/powerpc/include/asm/vdso/vsyscall.h b/arch/powerpc/include/asm/vdso/vsyscall.h
index 48560a1195595..f1577b4f654d8 100644
--- a/arch/powerpc/include/asm/vdso/vsyscall.h
+++ b/arch/powerpc/include/asm/vdso/vsyscall.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_POWERPC_VDSO_VSYSCALL_H
 #define _ASM_POWERPC_VDSO_VSYSCALL_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/vdso_datapage.h>
 
@@ -22,6 +22,6 @@ struct vdso_rng_data *__arch_get_k_vdso_rng_data(void)
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* _ASM_POWERPC_VDSO_VSYSCALL_H */
diff --git a/arch/powerpc/include/asm/vdso_datapage.h b/arch/powerpc/include/asm/vdso_datapage.h
index a202f5b634795..7275e8fcf242a 100644
--- a/arch/powerpc/include/asm/vdso_datapage.h
+++ b/arch/powerpc/include/asm/vdso_datapage.h
@@ -9,7 +9,7 @@
  * 		      IBM Corp.
  */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/unistd.h>
 #include <linux/time.h>
@@ -48,7 +48,7 @@ struct vdso_arch_data {
 
 extern struct vdso_arch_data *vdso_data;
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 .macro get_datapage ptr offset=0
 	bcl	20, 31, .+4
@@ -61,7 +61,7 @@ extern struct vdso_arch_data *vdso_data;
 #include <asm/asm-offsets.h>
 #include <asm/page.h>
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __KERNEL__ */
 #endif /* _SYSTEMCFG_H */
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index 0b5c1993809eb..75471fb6fb101 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -7,7 +7,7 @@
 #include <asm/kvm_booke_hv_asm.h>
 #include <asm/thread_info.h>	/* for THREAD_SHIFT */
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 /*
  * Macros used for common Book-e exception handling
@@ -522,5 +522,5 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_EMB_HV)
 	bl	kernel_fp_unavailable_exception;			      \
 	b	interrupt_return
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* __HEAD_BOOKE_H__ */
diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 6beacaec63d30..4ec6fdcb921f3 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -8,7 +8,7 @@
 #ifndef _BPF_JIT_H
 #define _BPF_JIT_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/types.h>
 #include <asm/ppc-opcode.h>
diff --git a/arch/powerpc/platforms/powernv/subcore.h b/arch/powerpc/platforms/powernv/subcore.h
index 77feee8436d48..413fd85d9bc28 100644
--- a/arch/powerpc/platforms/powernv/subcore.h
+++ b/arch/powerpc/platforms/powernv/subcore.h
@@ -9,7 +9,7 @@
 #define SYNC_STEP_REAL_MODE	2	/* Set by secondary when in real mode  */
 #define SYNC_STEP_FINISHED	3	/* Set by secondary when split/unsplit is done */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef CONFIG_SMP
 void split_core_secondary_loop(u8 *state);
@@ -18,4 +18,4 @@ extern void update_subcore_sibling_mask(void);
 static inline void update_subcore_sibling_mask(void) { }
 #endif /* CONFIG_SMP */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
diff --git a/arch/powerpc/xmon/xmon_bpts.h b/arch/powerpc/xmon/xmon_bpts.h
index 377068f52edb9..e14e4fb862e0c 100644
--- a/arch/powerpc/xmon/xmon_bpts.h
+++ b/arch/powerpc/xmon/xmon_bpts.h
@@ -3,12 +3,12 @@
 #define XMON_BPTS_H
 
 #define NBPTS	256
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/inst.h>
 #define BPT_SIZE	(sizeof(ppc_inst_t) * 2)
 #define BPT_WORDS	(BPT_SIZE / sizeof(ppc_inst_t))
 
 extern unsigned int bpt_table[NBPTS * BPT_WORDS];
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* XMON_BPTS_H */
diff --git a/tools/testing/selftests/powerpc/include/instructions.h b/tools/testing/selftests/powerpc/include/instructions.h
index 4efa6314bd963..864f0c9f1afcb 100644
--- a/tools/testing/selftests/powerpc/include/instructions.h
+++ b/tools/testing/selftests/powerpc/include/instructions.h
@@ -67,7 +67,7 @@ static inline int paste_last(void *i)
 #define PPC_INST_PASTE_LAST            __PASTE(0, 0, 1, 1)
 
 /* This defines the prefixed load/store instructions */
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #  define stringify_in_c(...)	__VA_ARGS__
 #else
 #  define __stringify_in_c(...)	#__VA_ARGS__
-- 
2.48.1


