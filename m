Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DEA488F89
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jan 2022 06:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238633AbiAJFSD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jan 2022 00:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238664AbiAJFSD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jan 2022 00:18:03 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1E7C06173F
        for <linux-arch@vger.kernel.org>; Sun,  9 Jan 2022 21:18:02 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so21033871pjj.2
        for <linux-arch@vger.kernel.org>; Sun, 09 Jan 2022 21:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=tsk0ZfALq1n4jqWZNQvTxt7zK6Hd0cLUCOgzvKzOT7Q=;
        b=L9hiAl1ipUjDpLn4q3dVqWfGzb0cISuulrG/gJaEjTtoGQR27jMUvINHmLBST6yfzz
         M2lVcqsGGcKw/r50AvbKcXxVZkqasCX86+w1DFQuhRFINUa/LVu0f+Yt9biB9kEBpujt
         aZkLzRDcM5fXe6CtnaVDd82JiauPq+apAkrStgvNkJLMqGDEy4q/MAH07MD5WjbDuVOE
         ZTG0rxpBweLljMsaLiZJNTu8uI6dzXMbA+CBXmsRJCx1mibSeAhS4/LyGCbVg/mj1BE0
         lrWNQeFB7SuMTqm0pVaoLN2fxVx+mwPujRE59isjGR5tShaMjFj9/6UjbTM9085uWKDa
         5PzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=tsk0ZfALq1n4jqWZNQvTxt7zK6Hd0cLUCOgzvKzOT7Q=;
        b=Y8F62R0quJkRAN09jjtX0KHOeW5aq4TZi8u7neYsGKuFP0R0YVV4tqiTNBTNeFs3vp
         69aeDe+CIQ9hosLDcsZ79umuF+r/hoRCSJnE05qLucH7rLjv+eflEtUr7IFPze0TlavX
         4wM9XKPno3/oOYhgDHgIMfWcrx4hM237Hblmg38cUebEpuCF3GwC9rq1GrZkfMZhcG6t
         sZn94jiyntY1vkEk/BSMvb1WZitax8i5tiKQIFfBHGIptAuZzwcGzcCQNrIKENGIbXcE
         kvGZrvxof3fYLPj8DC2aIQ9KIzxzZxULNYAsTU6/PQfQ6FLHVAhUeHgr1sW3RJYbFcoq
         Ffvw==
X-Gm-Message-State: AOAM5337OoJHJXVkPnsvKXBOaIgmSxSfQNy/io1AO7f8QN+HAltV1NuT
        G+WaWwuJb6fb7by/uM1COgs=
X-Google-Smtp-Source: ABdhPJxtQP5LInQ7rBXj7oJen4YOTVSnpiTcuiDer7t2JO1ySr4WOB/uUubH/EiqElDrtJhYGY71Fw==
X-Received: by 2002:a17:90b:388d:: with SMTP id mu13mr28760249pjb.86.1641791882483;
        Sun, 09 Jan 2022 21:18:02 -0800 (PST)
Received: from localhost (124-171-74-95.tpgi.com.au. [124.171.74.95])
        by smtp.gmail.com with ESMTPSA id t21sm975404pjs.37.2022.01.09.21.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 21:18:02 -0800 (PST)
Date:   Mon, 10 Jan 2022 15:17:56 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 16/23] sched: Use lightweight hazard pointers to grab lazy
 mms
To:     Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Will Deacon <will@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
References: <cover.1641659630.git.luto@kernel.org>
        <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
        <CAHk-=wj4LZaFB5HjZmzf7xLFSCcQri-WWqOEJHwQg0QmPRSdQA@mail.gmail.com>
        <3586aa63-2dd2-4569-b9b9-f51080962ff2@www.fastmail.com>
        <CAHk-=wi2MtYYTs08RKHtj9Vtm0dri-saWwYh0tj=QUUUDSJFRQ@mail.gmail.com>
        <430e3db1-693f-4d46-bebf-0a953fe6c2fc@www.fastmail.com>
        <CAHk-=wjkbFFvgnUqgO8omHgTJx0GDwhxP9Cw0g6E03zOVbC7HQ@mail.gmail.com>
        <484a7f37-ceed-44f6-8629-0e67a0860dc8@www.fastmail.com>
        <CAHk-=whJYoKgAAtb6pYQVSPnyLQsnS6+rU=0jBUqrZU76LyDqg@mail.gmail.com>
        <CAHk-=wgnTWk2zeOO1YQ_8S-xPf4Pr0vXBs7DnhOPdKQFHXOnxw@mail.gmail.com>
        <1641790309.2vqc26hwm3.astroid@bobo.none>
In-Reply-To: <1641790309.2vqc26hwm3.astroid@bobo.none>
MIME-Version: 1.0
Message-Id: <1641791321.kvkq0n8kbq.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Nicholas Piggin's message of January 10, 2022 2:56 pm:
> Excerpts from Linus Torvalds's message of January 10, 2022 7:51 am:
>> [ Ugh, I actually went back and looked at Nick's patches again, to
>> just verify my memory, and they weren't as pretty as I thought they
>> were ]
>>=20
>> On Sun, Jan 9, 2022 at 12:48 PM Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>>
>>> I'd much rather have a *much* smaller patch that says "on x86 and
>>> powerpc, we don't need this overhead at all".
>>=20
>> For some reason I thought Nick's patch worked at "last mmput" time and
>> the TLB flush IPIs that happen at that point anyway would then make
>> sure any lazy TLB is cleaned up.
>>=20
>> But that's not actually what it does. It ties the
>> MMU_LAZY_TLB_REFCOUNT to an explicit TLB shootdown triggered by the
>> last mmdrop() instead. Because it really tied the whole logic to the
>> mm_count logic (and made lazy tlb to not do mm_count) rather than the
>> mm_users thing I mis-remembered it doing.
>=20
> It does this because on powerpc with hash MMU, we can't use IPIs for
> TLB shootdowns.
>=20
>> So at least some of my arguments were based on me just mis-remembering
>> what Nick's patch actually did (mainly because I mentally recreated
>> the patch from "Nick did something like this" and what I thought would
>> be the way to do it on x86).
>=20
> With powerpc with the radix MMU using IPI based shootdowns, we can=20
> actually do the switch-away-from-lazy on the final TLB flush and the
> final broadcast shootdown thing becomes a no-op. I didn't post that
> additional patch because it's powerpc-specific and I didn't want to
> post more code so widely.

This is the patch that goes on top of the series I posted. It's not
very clean at the moment it was just a proof of concept. I wrote it
a year ago by the looks so no guarantees. But it exits all other
lazies as part of the final exit_mmap TLB flush so there should not be
additional IPIs at drop-time. Possibly you could get preempted and
moved CPUs between them but the point is the vast majority of the time
you won't require more IPIs.

Well, with powerpc it's not _quite_ that simple, it is possible we
could use broadcast TLBIE instruction rather than IPIs for this, in
practice I think that's not _so much_ faster that the IPIs are a
problem and on highly threaded jobs where you might have hundreds of
other CPUs in the mask, you'd rather avoid the cacheline bouncing in
context switch anyway.

Thanks,
Nick

From 1f7fd5de284fab6b94bf49f55ce691ae22538473 Mon Sep 17 00:00:00 2001
From: Nicholas Piggin <npiggin@gmail.com>
Date: Tue, 23 Feb 2021 14:11:21 +1000
Subject: [PATCH] powerpc/64s/radix: TLB flush optimization for lazy mm
 shootdown refcounting

XXX: could also clear lazy at exit, perhaps?
XXX: doesn't really matter AFAIKS because it will soon go away with mmput
XXX: must audit exit flushes for nest MMU
---
 arch/powerpc/mm/book3s64/radix_tlb.c | 45 ++++++++++++++--------------
 kernel/fork.c                        | 16 ++++++++--
 2 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s6=
4/radix_tlb.c
index 59156c2d2ebe..b64cd0d22b8b 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c
@@ -723,7 +723,7 @@ void radix__local_flush_all_mm(struct mm_struct *mm)
 }
 EXPORT_SYMBOL(radix__local_flush_all_mm);
=20
-static void __flush_all_mm(struct mm_struct *mm, bool fullmm)
+static void radix__flush_all_mm(struct mm_struct *mm, bool fullmm)
 {
 	radix__local_flush_all_mm(mm);
 }
@@ -862,7 +862,7 @@ enum tlb_flush_type {
 	FLUSH_TYPE_GLOBAL,
 };
=20
-static enum tlb_flush_type flush_type_needed(struct mm_struct *mm, bool fu=
llmm)
+static enum tlb_flush_type flush_type_needed(struct mm_struct *mm)
 {
 	int active_cpus =3D atomic_read(&mm->context.active_cpus);
 	int cpu =3D smp_processor_id();
@@ -888,14 +888,6 @@ static enum tlb_flush_type flush_type_needed(struct mm=
_struct *mm, bool fullmm)
 	if (atomic_read(&mm->context.copros) > 0)
 		return FLUSH_TYPE_GLOBAL;
=20
-	/*
-	 * In the fullmm case there's no point doing the exit_flush_lazy_tlbs
-	 * because the mm is being taken down anyway, and a TLBIE tends to
-	 * be faster than an IPI+TLBIEL.
-	 */
-	if (fullmm)
-		return FLUSH_TYPE_GLOBAL;
-
 	/*
 	 * If we are running the only thread of a single-threaded process,
 	 * then we should almost always be able to trim off the rest of the
@@ -947,7 +939,7 @@ void radix__flush_tlb_mm(struct mm_struct *mm)
 	 * switch_mm_irqs_off
 	 */
 	smp_mb();
-	type =3D flush_type_needed(mm, false);
+	type =3D flush_type_needed(mm);
 	if (type =3D=3D FLUSH_TYPE_LOCAL) {
 		_tlbiel_pid(pid, RIC_FLUSH_TLB);
 	} else if (type =3D=3D FLUSH_TYPE_GLOBAL) {
@@ -971,7 +963,7 @@ void radix__flush_tlb_mm(struct mm_struct *mm)
 }
 EXPORT_SYMBOL(radix__flush_tlb_mm);
=20
-static void __flush_all_mm(struct mm_struct *mm, bool fullmm)
+void radix__flush_all_mm(struct mm_struct *mm)
 {
 	unsigned long pid;
 	enum tlb_flush_type type;
@@ -982,7 +974,7 @@ static void __flush_all_mm(struct mm_struct *mm, bool f=
ullmm)
=20
 	preempt_disable();
 	smp_mb(); /* see radix__flush_tlb_mm */
-	type =3D flush_type_needed(mm, fullmm);
+	type =3D flush_type_needed(mm);
 	if (type =3D=3D FLUSH_TYPE_LOCAL) {
 		_tlbiel_pid(pid, RIC_FLUSH_ALL);
 	} else if (type =3D=3D FLUSH_TYPE_GLOBAL) {
@@ -1002,11 +994,6 @@ static void __flush_all_mm(struct mm_struct *mm, bool=
 fullmm)
 	}
 	preempt_enable();
 }
-
-void radix__flush_all_mm(struct mm_struct *mm)
-{
-	__flush_all_mm(mm, false);
-}
 EXPORT_SYMBOL(radix__flush_all_mm);
=20
 void radix__flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmadd=
r,
@@ -1021,7 +1008,7 @@ void radix__flush_tlb_page_psize(struct mm_struct *mm=
, unsigned long vmaddr,
=20
 	preempt_disable();
 	smp_mb(); /* see radix__flush_tlb_mm */
-	type =3D flush_type_needed(mm, false);
+	type =3D flush_type_needed(mm);
 	if (type =3D=3D FLUSH_TYPE_LOCAL) {
 		_tlbiel_va(vmaddr, pid, psize, RIC_FLUSH_TLB);
 	} else if (type =3D=3D FLUSH_TYPE_GLOBAL) {
@@ -1127,7 +1114,7 @@ static inline void __radix__flush_tlb_range(struct mm=
_struct *mm,
=20
 	preempt_disable();
 	smp_mb(); /* see radix__flush_tlb_mm */
-	type =3D flush_type_needed(mm, fullmm);
+	type =3D flush_type_needed(mm);
 	if (type =3D=3D FLUSH_TYPE_NONE)
 		goto out;
=20
@@ -1295,7 +1282,18 @@ void radix__tlb_flush(struct mmu_gather *tlb)
 	 * See the comment for radix in arch_exit_mmap().
 	 */
 	if (tlb->fullmm || tlb->need_flush_all) {
-		__flush_all_mm(mm, true);
+		/*
+		 * Shootdown based lazy tlb mm refcounting means we have to
+		 * IPI everyone in the mm_cpumask anyway soon when the mm goes
+		 * away, so might as well do it as part of the final flush now.
+		 *
+		 * If lazy shootdown was improved to reduce IPIs (e.g., by
+		 * batching), then it may end up being better to use tlbies
+		 * here instead.
+		 */
+		smp_mb(); /* see radix__flush_tlb_mm */
+		exit_flush_lazy_tlbs(mm);
+		_tlbiel_pid(mm->context.id, RIC_FLUSH_ALL);
 	} else if ( (psize =3D radix_get_mmu_psize(page_size)) =3D=3D -1) {
 		if (!tlb->freed_tables)
 			radix__flush_tlb_mm(mm);
@@ -1326,10 +1324,11 @@ static void __radix__flush_tlb_range_psize(struct m=
m_struct *mm,
 		return;
=20
 	fullmm =3D (end =3D=3D TLB_FLUSH_ALL);
+	WARN_ON_ONCE(fullmm); /* XXX: this shouldn't get fullmm? */
=20
 	preempt_disable();
 	smp_mb(); /* see radix__flush_tlb_mm */
-	type =3D flush_type_needed(mm, fullmm);
+	type =3D flush_type_needed(mm);
 	if (type =3D=3D FLUSH_TYPE_NONE)
 		goto out;
=20
@@ -1412,7 +1411,7 @@ void radix__flush_tlb_collapsed_pmd(struct mm_struct =
*mm, unsigned long addr)
 	/* Otherwise first do the PWC, then iterate the pages. */
 	preempt_disable();
 	smp_mb(); /* see radix__flush_tlb_mm */
-	type =3D flush_type_needed(mm, false);
+	type =3D flush_type_needed(mm);
 	if (type =3D=3D FLUSH_TYPE_LOCAL) {
 		_tlbiel_va_range(addr, end, pid, PAGE_SIZE, mmu_virtual_psize, true);
 	} else if (type =3D=3D FLUSH_TYPE_GLOBAL) {
