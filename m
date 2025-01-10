Return-Path: <linux-arch+bounces-9705-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196A9A09A0D
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 19:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DB3F3A35E1
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 18:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62EE24B222;
	Fri, 10 Jan 2025 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fjztZ9hY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f74.google.com (mail-lf1-f74.google.com [209.85.167.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A609921B195
	for <linux-arch@vger.kernel.org>; Fri, 10 Jan 2025 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736534880; cv=none; b=Xfm7pR2vTEX+MMWDn1FoijYo7soNjOOvgBHEB6Cul2O5U+E2rpzl17LFLhAVqCEe4lkfWe50qhcdxNle70pIx/i8T6lusBr33DW88WByGlMEqjr/cRgSISQC8ZD7RYqK2J3uiTXF1P5wHd+1A3P7cuDAiUEEGoOB3R+wWGgesb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736534880; c=relaxed/simple;
	bh=8oJWV2blYGjdlDquSZFlq/fzMSlPhCK7jJm0Q6N72yc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lT/oHMRWaPi54Yc0dnE3zup/1zx0bXn5wknK5lrtLuLD8dKp51VYa80QEXX9wDEwy/ME0HO+8/wT1jvapF9EYKU8XLT5pCyeeodG47d0gzbk5YoO37fh8PIIq+992ZwyXSQNoaN+Vla5ITyb8/kqmxvLrks0ujXRG5oq4iX6n5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fjztZ9hY; arc=none smtp.client-ip=209.85.167.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-lf1-f74.google.com with SMTP id 2adb3069b0e04-5428d385b93so1231714e87.3
        for <linux-arch@vger.kernel.org>; Fri, 10 Jan 2025 10:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736534873; x=1737139673; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P63tWziIl5MLfOevD/STQnofaJPDmGipUyDaNTwON8A=;
        b=fjztZ9hYsk25P1MjoDBliHEiqb+6AUUnjLGZ8SMs7vZSrk+hEy5wyfIocm6lqAePjI
         A9gvu/r/F1sjKWuWvZGAGg3V07gBEp8JKqh1MEtg6cLyVEBl7S2Q1+ATNzg9S46AyF3Z
         OeDOQSDHFhNZ/bYAW/QrHrXoezeqyodXxSJPUgj4UrYxgSPvLODHf5mfh1Wiboh0f3li
         D2/XjqLvnqfhyAjh6FlXh2ehZqb9CLnIrdD45s1bEULrKdLwHT91/t0A1/RKVYJyy031
         tJtwAZyKjEBj+LdFDwJTFzoNePOz8wi/VUNit7IqOzkJwSOT0A4RYxseBxv4athqLfDd
         CG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736534873; x=1737139673;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P63tWziIl5MLfOevD/STQnofaJPDmGipUyDaNTwON8A=;
        b=fUCsHdNBZ+Sl3Cn5wljKyb7UrWN7VyMuUvZX2Y1i2d6ELcwV3cCDhvoq1zz5tzqaPK
         5WbLXu/LEV5BfkX6EgV0TWGfg5Pyb7Pe1BFeW2vbl8pGfwgVDqZuKHsW2L3as59DKSht
         uCmXXzPl4SYjHB/aq6daja/9t5e9dx/o0e0wRF3uCrYRU/ZViHLmWGxaK4lcB+WA6P+5
         JUEXZyPTfjm/FCR/I/ItWyvUPAEr+7DlGE6V73pzOsBITA+xbN/VIgd7MmDm6lOGYkvQ
         k54Y3p8lRAozgwuG44x0ZfvW96jpxDSqjOoVhwUuVNoXwCb1DlhB4IuH4xAU0Al+I5MP
         Dx/A==
X-Forwarded-Encrypted: i=1; AJvYcCXx+xxEQ9xjGhdLmJQg8BTRrhEM+J8agupBQRsqyFlg0xRWUwAfDGB6RmIyV/auSb93Nlu5cm56ilwo@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+RF5AB441qMjE9awV45igxe0mfQpF+w43WgjqekRVb0bsnZiE
	ytwrgtAxNeKecpmPEawzmxXcP/3PN5fzsmZ6G3XuMTQHTbyu9R8XalAWT3IS0nF7/Ci9Td4j2x5
	UlzWNtyfKsg==
X-Google-Smtp-Source: AGHT+IFpLRoJ7ZhWq6f6CfOMCmb66msRmVLu03/rxTgeCGcpzkKTsEslMdO3oeVqCUER7+YbrfuCetVYZstiXQ==
X-Received: from wmbew14.prod.google.com ([2002:a05:600c:808e:b0:436:16c6:831])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:156c:b0:385:e3c5:61ae with SMTP id ffacd0b85a97d-38a873125c3mr11343217f8f.31.1736534499784;
 Fri, 10 Jan 2025 10:41:39 -0800 (PST)
Date: Fri, 10 Jan 2025 18:40:50 +0000
In-Reply-To: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250110-asi-rfc-v2-v2-24-8419288bc805@google.com>
Subject: [PATCH RFC v2 24/29] mm: asi: Add infrastructure for mapping
 userspace addresses
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Chris Zankel <chris@zankel.net>, 
	Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mike Rapoport <rppt@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	kvm@vger.kernel.org, linux-efi@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>, Junaid Shahid <junaids@google.com>, 
	Reiji Watanabe <reijiw@google.com>
Content-Type: text/plain; charset="utf-8"

In preparation for sandboxing bare-metal processes, teach ASI to map
userspace addresses into the restricted address space.

Add a new policy helper to determine based on the class whether to do
this. If the helper returns true, mirror userspace mappings into the ASI
pagetables.

Later, it will be possible for users who do not have a significant
security boundary between KVM guests and their VMM process, to take
advantage of this to reduce mitigation costs when switching between
those two domains - to illustrate this idea, it's now reflected in the
KVM taint policy, although the KVM class is still hard-coded not to map
userspace addresses.

Co-developed-by: Junaid Shahid <junaids@google.com>
Signed-off-by: Junaid Shahid <junaids@google.com>
Co-developed-by: Reiji Watanabe <reijiw@google.com>
Signed-off-by: Reiji Watanabe <reijiw@google.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/include/asm/asi.h        | 11 +++++
 arch/x86/include/asm/pgalloc.h    |  6 +++
 arch/x86/include/asm/pgtable_64.h |  4 ++
 arch/x86/kvm/x86.c                | 12 +++--
 arch/x86/mm/asi.c                 | 92 +++++++++++++++++++++++++++++++++++++++
 include/asm-generic/asi.h         |  4 ++
 6 files changed, 125 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/asi.h b/arch/x86/include/asm/asi.h
index 555edb5f292e4d6baba782f51d014aa48dc850b6..e925d7d2cfc85bca8480c837548654e7a5a7009e 100644
--- a/arch/x86/include/asm/asi.h
+++ b/arch/x86/include/asm/asi.h
@@ -133,6 +133,7 @@ struct asi {
 	struct mm_struct *mm;
 	int64_t ref_count;
 	enum asi_class_id class_id;
+	spinlock_t pgd_lock;
 };
 
 DECLARE_PER_CPU_ALIGNED(struct asi *, curr_asi);
@@ -147,6 +148,7 @@ const char *asi_class_name(enum asi_class_id class_id);
 
 int asi_init(struct mm_struct *mm, enum asi_class_id class_id, struct asi **out_asi);
 void asi_destroy(struct asi *asi);
+void asi_clone_user_pgtbl(struct mm_struct *mm, pgd_t *pgdp);
 
 /* Enter an ASI domain (restricted address space) and begin the critical section. */
 void asi_enter(struct asi *asi);
@@ -286,6 +288,15 @@ static __always_inline bool asi_in_critical_section(void)
 
 void asi_handle_switch_mm(void);
 
+/*
+ * This function returns true when we would like to map userspace addresses
+ * in the restricted address space.
+ */
+static inline bool asi_maps_user_addr(enum asi_class_id class_id)
+{
+	return false;
+}
+
 #endif /* CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION */
 
 #endif
diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index dcd836b59bebd329c3d265b98e48ef6eb4c9e6fc..edf9fe76c53369eefcd5bf14a09cbf802cf1ea21 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -114,12 +114,16 @@ static inline void p4d_populate(struct mm_struct *mm, p4d_t *p4d, pud_t *pud)
 {
 	paravirt_alloc_pud(mm, __pa(pud) >> PAGE_SHIFT);
 	set_p4d(p4d, __p4d(_PAGE_TABLE | __pa(pud)));
+	if (!pgtable_l5_enabled())
+		asi_clone_user_pgtbl(mm, (pgd_t *)p4d);
 }
 
 static inline void p4d_populate_safe(struct mm_struct *mm, p4d_t *p4d, pud_t *pud)
 {
 	paravirt_alloc_pud(mm, __pa(pud) >> PAGE_SHIFT);
 	set_p4d_safe(p4d, __p4d(_PAGE_TABLE | __pa(pud)));
+	if (!pgtable_l5_enabled())
+		asi_clone_user_pgtbl(mm, (pgd_t *)p4d);
 }
 
 extern void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud);
@@ -137,6 +141,7 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, p4d_t *p4d)
 		return;
 	paravirt_alloc_p4d(mm, __pa(p4d) >> PAGE_SHIFT);
 	set_pgd(pgd, __pgd(_PAGE_TABLE | __pa(p4d)));
+	asi_clone_user_pgtbl(mm, pgd);
 }
 
 static inline void pgd_populate_safe(struct mm_struct *mm, pgd_t *pgd, p4d_t *p4d)
@@ -145,6 +150,7 @@ static inline void pgd_populate_safe(struct mm_struct *mm, pgd_t *pgd, p4d_t *p4
 		return;
 	paravirt_alloc_p4d(mm, __pa(p4d) >> PAGE_SHIFT);
 	set_pgd_safe(pgd, __pgd(_PAGE_TABLE | __pa(p4d)));
+	asi_clone_user_pgtbl(mm, pgd);
 }
 
 static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index d1426b64c1b9715cd9e4d1d7451ae4feadd8b2f5..fe6d83ec632a6894527784f2ebdbd013161c6f09 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -157,6 +157,8 @@ static inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
 static inline void native_p4d_clear(p4d_t *p4d)
 {
 	native_set_p4d(p4d, native_make_p4d(0));
+	if (!pgtable_l5_enabled())
+		asi_clone_user_pgtbl(NULL, (pgd_t *)p4d);
 }
 
 static inline void native_set_pgd(pgd_t *pgdp, pgd_t pgd)
@@ -167,6 +169,8 @@ static inline void native_set_pgd(pgd_t *pgdp, pgd_t pgd)
 static inline void native_pgd_clear(pgd_t *pgd)
 {
 	native_set_pgd(pgd, native_make_pgd(0));
+	if (pgtable_l5_enabled())
+		asi_clone_user_pgtbl(NULL, pgd);
 }
 
 /*
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3e0811eb510650abc601e4adce1ce4189835a730..920475fe014f6503dd88c7bbdb6b2707c084a689 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9712,11 +9712,15 @@ static inline int kvm_x86_init_asi_class(void)
 	/*
 	 * And the same for data left behind by code in the userspace domain
 	 * (i.e. the VMM itself, plus kernel code serving its syscalls etc).
-	 * This should eventually be configurable: users whose VMMs contain
-	 * no secrets can disable it to avoid paying a mitigation cost on
-	 * transition between their guest and userspace.
+	 *
+	 *
+	 * If we decided to map userspace into the guest's restricted address
+	 * space then we don't bother with this since we assume either no bugs
+	 * allow the guest to leak that data, or the user doesn't care about
+	 * that security boundary.
 	 */
-	policy.protect_data |= ASI_TAINT_USER_DATA;
+	if (!asi_maps_user_addr(ASI_CLASS_KVM))
+		policy.protect_data |= ASI_TAINT_USER_DATA;
 
 	return asi_init_class(ASI_CLASS_KVM, &policy);
 }
diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
index c5073af1a82ded1c6fc467cd7a5d29a39d676bb4..093103c1bc2677c81d68008aca064fab53b73a62 100644
--- a/arch/x86/mm/asi.c
+++ b/arch/x86/mm/asi.c
@@ -14,6 +14,7 @@
 #include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
 #include <asm/traps.h>
+#include <asm/pgtable.h>
 
 #include "mm_internal.h"
 #include "../../../mm/internal.h"
@@ -351,6 +352,33 @@ static void __asi_destroy(struct asi *asi)
 	memset(asi, 0, sizeof(struct asi));
 }
 
+static void __asi_init_user_pgds(struct mm_struct *mm, struct asi *asi)
+{
+	int i;
+
+	if (!asi_maps_user_addr(asi->class_id))
+		return;
+
+	/*
+	 * The code below must be executed only after the given asi is
+	 * available in mm->asi[index] to ensure at least either this
+	 * function or __asi_clone_user_pgd() will copy entries in the
+	 * unrestricted pgd to the restricted pgd.
+	 */
+	if (WARN_ON_ONCE(&mm->asi[asi->class_id] != asi))
+		return;
+
+	/*
+	 * See the comment for __asi_clone_user_pgd() why we hold the lock here.
+	 */
+	spin_lock(&asi->pgd_lock);
+
+	for (i = 0; i < KERNEL_PGD_BOUNDARY; i++)
+		set_pgd(asi->pgd + i, READ_ONCE(*(mm->pgd + i)));
+
+	spin_unlock(&asi->pgd_lock);
+}
+
 int asi_init(struct mm_struct *mm, enum asi_class_id class_id, struct asi **out_asi)
 {
 	struct asi *asi;
@@ -388,6 +416,7 @@ int asi_init(struct mm_struct *mm, enum asi_class_id class_id, struct asi **out_
 
 	asi->mm = mm;
 	asi->class_id = class_id;
+	spin_lock_init(&asi->pgd_lock);
 
 	for (i = KERNEL_PGD_BOUNDARY; i < PTRS_PER_PGD; i++)
 		set_pgd(asi->pgd + i, asi_global_nonsensitive_pgd[i]);
@@ -398,6 +427,7 @@ int asi_init(struct mm_struct *mm, enum asi_class_id class_id, struct asi **out_
 	else
 		*out_asi = asi;
 
+	__asi_init_user_pgds(mm, asi);
 	mutex_unlock(&mm->asi_init_lock);
 
 	return err;
@@ -891,3 +921,65 @@ void asi_unmap(struct asi *asi, void *addr, size_t len)
 
 	asi_flush_tlb_range(asi, addr, len);
 }
+
+/*
+ * This function is to copy the given unrestricted pgd entry for
+ * userspace addresses to the corresponding restricted pgd entries.
+ * It means that the unrestricted pgd entry must be updated before
+ * this function is called.
+ * We map entire userspace addresses to the restricted address spaces
+ * by copying unrestricted pgd entries to the restricted page tables
+ * so that we don't need to maintain consistency of lower level PTEs
+ * between the unrestricted page table and the restricted page tables.
+ */
+void asi_clone_user_pgtbl(struct mm_struct *mm, pgd_t *pgdp)
+{
+	unsigned long pgd_idx;
+	struct asi *asi;
+	int i;
+
+	if (!static_asi_enabled())
+		return;
+
+	/* We shouldn't need to take care non-userspace mapping. */
+	if (!pgdp_maps_userspace(pgdp))
+		return;
+
+	/*
+	 * The mm will be NULL for p{4,g}d_clear(). We need to get
+	 * the owner mm for this pgd in this case. The pgd page has
+	 * a valid pt_mm only when SHARED_KERNEL_PMD == 0.
+	 */
+	BUILD_BUG_ON(SHARED_KERNEL_PMD);
+	if (!mm) {
+		mm = pgd_page_get_mm(virt_to_page(pgdp));
+		if (WARN_ON_ONCE(!mm))
+			return;
+	}
+
+	/*
+	 * Compute a PGD index of the given pgd entry. This will be the
+	 * index of the ASI PGD entry to be updated.
+	 */
+	pgd_idx = pgdp - PTR_ALIGN_DOWN(pgdp, PAGE_SIZE);
+
+	for (i = 0; i < ARRAY_SIZE(mm->asi); i++) {
+		asi = mm->asi + i;
+
+		if (!asi_pgd(asi) || !asi_maps_user_addr(asi->class_id))
+			continue;
+
+		/*
+		 * We need to synchronize concurrent callers of
+		 * __asi_clone_user_pgd() among themselves, as well as
+		 * __asi_init_user_pgds(). The lock makes sure that reading
+		 * the unrestricted pgd and updating the corresponding
+		 * ASI pgd are not interleaved by concurrent calls.
+		 * We cannot rely on mm->page_table_lock here because it
+		 * is not always held when pgd/p4d_clear_bad() is called.
+		 */
+		spin_lock(&asi->pgd_lock);
+		set_pgd(asi_pgd(asi) + pgd_idx, READ_ONCE(*pgdp));
+		spin_unlock(&asi->pgd_lock);
+	}
+}
diff --git a/include/asm-generic/asi.h b/include/asm-generic/asi.h
index 4f033d3ef5929707fd280f74fc800193e45143c1..d103343292fad567dcd73e45e986fb3974e59898 100644
--- a/include/asm-generic/asi.h
+++ b/include/asm-generic/asi.h
@@ -95,6 +95,10 @@ void asi_flush_tlb_range(struct asi *asi, void *addr, size_t len) { }
 
 static inline void asi_check_boottime_disable(void) { }
 
+static inline void asi_clone_user_pgtbl(struct mm_struct *mm, pgd_t *pgdp) { };
+
+static inline bool asi_maps_user_addr(enum asi_class_id class_id) { return false; }
+
 #endif /* !CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION */
 
 #endif  /* !_ASSEMBLY_ */

-- 
2.47.1.613.gc27f4b7a9f-goog


