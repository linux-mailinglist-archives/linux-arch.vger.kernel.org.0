Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA612CE95C
	for <lists+linux-arch@lfdr.de>; Fri,  4 Dec 2020 09:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgLDISO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Dec 2020 03:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgLDISN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Dec 2020 03:18:13 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D04C061A4F;
        Fri,  4 Dec 2020 00:17:33 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id x15so2701020pll.2;
        Fri, 04 Dec 2020 00:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ln++9Eg71n524JlS9NV8GRrodOh9pkKHZvYyLb9NMN8=;
        b=tDMVJKyflN4AytQ5BZaaYAnTvD40r+ph9Q8CJrtzq7qK9cpK3KDT6NOzafwsRREUcD
         cFOOnkH3VCh4P6E9SdpOxq99EPa00kcFmWHnSoHwuuBUU9wzc2BnYLtTa8cnb+wgzfWA
         cYOKmCVOuNPAnNExrsPEQ05s7tlIMsCdXuWeTR/ULMR768eflA18ANFzJp+tE6n7ZDbI
         Yi0bGLF9muM5t6o5/PHdMx2RcQylbUroFG3yhwwc92dxPrF0kAFGFslctsribroovhp6
         dvfEzYiMCqlGfhspEHuBVSRWoyJ6QkaJU9DwZ3WgttxlG5yI+Ee7qGY1fTD1cuKjoG8m
         KyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ln++9Eg71n524JlS9NV8GRrodOh9pkKHZvYyLb9NMN8=;
        b=BSX14aMzPBDT0hRSCi2pwYk1WncaiIoJ7sGMlBCwoPg1qf5jtgzbTGPuy/UtcijELX
         LwXhLKQOinI8B2DcRJaS/c1SRlZbNKPhrJ2h7iO4lob9xT+enh5/kWwN2WYmMkBdyqvR
         xBX7IbKkHn9ClPfr+jit2QFI1xTVkhsgR6W3B0QyeMEhXDExNidENybehP4c/HnV4Jii
         bTqx1MeGjnUn8AzTJIA5e9At1UolUODgXvzfp4Y5Jm/HuNTZiRhg+PRuRLKdBXP6fm7c
         EwFBmYh/gfKubvwKZdYymZZ+t5Fzl5Wbo4dAg2L8QXaT8RzRpu0F7kwosJKoxMdyELJ6
         p7bQ==
X-Gm-Message-State: AOAM530dWG8unHZHGfFEWsqqJy214mUzlxErxcIvwlCB1dA/p6aVFsbE
        98ruJSMChnVmbEgz9JPHK/8=
X-Google-Smtp-Source: ABdhPJx1Ho3dBYScBiLMsFzyMeRifNVoKPOlG/ESpTJs/U21Gcdn1OiMMq9h+u0zR4BCVQgth9i5dQ==
X-Received: by 2002:a17:902:b498:b029:da:84a7:be94 with SMTP id y24-20020a170902b498b02900da84a7be94mr2861306plr.52.1607069852915;
        Fri, 04 Dec 2020 00:17:32 -0800 (PST)
Received: from ?IPv6:2601:647:4700:9b2:e462:2bde:2e8b:f9df? ([2601:647:4700:9b2:e462:2bde:2e8b:f9df])
        by smtp.gmail.com with ESMTPSA id g16sm3842217pfb.201.2020.12.04.00.17.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Dec 2020 00:17:31 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [RFC v2 1/2] [NEEDS HELP] x86/mm: Handle unlazying membarrier
 core sync in the arch code
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <203d39d11562575fd8bd6a094d97a3a332d8b265.1607059162.git.luto@kernel.org>
Date:   Fri, 4 Dec 2020 00:17:29 -0800
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        X86 ML <x86@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jann Horn <jannh@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A61977A7-F0B2-4492-AB6D-06E24417FA59@gmail.com>
References: <cover.1607059162.git.luto@kernel.org>
 <203d39d11562575fd8bd6a094d97a3a332d8b265.1607059162.git.luto@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

I am not very familiar with membarrier, but here are my 2 cents while =
trying
to answer your questions.

> On Dec 3, 2020, at 9:26 PM, Andy Lutomirski <luto@kernel.org> wrote:
> @@ -496,6 +497,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, =
struct mm_struct *next,
> 		 * from one thread in a process to another thread in the =
same
> 		 * process. No TLB flush required.
> 		 */
> +
> +		// XXX: why is this okay wrt membarrier?
> 		if (!was_lazy)
> 			return;

I am confused.

On one hand, it seems that membarrier_private_expedited() would issue an =
IPI
to that core, as it would find that this core=E2=80=99s =
cpu_rq(cpu)->curr->mm is the
same as the one that the membarrier applies to. But=E2=80=A6 (see below)


> @@ -508,12 +511,24 @@ void switch_mm_irqs_off(struct mm_struct *prev, =
struct mm_struct *next,
> 		smp_mb();
> 		next_tlb_gen =3D atomic64_read(&next->context.tlb_gen);
> 		if (this_cpu_read(cpu_tlbstate.ctxs[prev_asid].tlb_gen) =
=3D=3D
> -				next_tlb_gen)
> +		    next_tlb_gen) {
> +			/*
> +			 * We're reactivating an mm, and membarrier =
might
> +			 * need to serialize.  Tell membarrier.
> +			 */
> +
> +			// XXX: I can't understand the logic in
> +			// membarrier_mm_sync_core_before_usermode().  =
What's
> +			// the mm check for?
> +			membarrier_mm_sync_core_before_usermode(next);

On the other hand the reason for this mm check that you mention =
contradicts
my previous understanding as the git log says:

commit 2840cf02fae627860156737e83326df354ee4ec6
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Thu Sep 19 13:37:01 2019 -0400

    sched/membarrier: Call sync_core only before usermode for same mm
   =20
    When the prev and next task's mm change, switch_mm() provides the =
core
    serializing guarantees before returning to usermode. The only case
    where an explicit core serialization is needed is when the scheduler
    keeps the same mm for prev and next.

> 	/*
> 	 * When switching through a kernel thread, the loop in
> 	 * membarrier_{private,global}_expedited() may have observed =
that
> 	 * kernel thread and not issued an IPI. It is therefore possible =
to
> 	 * schedule between user->kernel->user threads without passing =
though
> 	 * switch_mm(). Membarrier requires a barrier after storing to
> -	 * rq->curr, before returning to userspace, so provide them =
here:
> +	 * rq->curr, before returning to userspace, and mmdrop() =
provides
> +	 * this barrier.
> 	 *
> -	 * - a full memory barrier for {PRIVATE,GLOBAL}_EXPEDITED, =
implicitly
> -	 *   provided by mmdrop(),
> -	 * - a sync_core for SYNC_CORE.
> +	 * XXX: I don't think mmdrop() actually does this.  There's no
> +	 * smp_mb__before/after_atomic() in there.

I presume that since x86 is the only one that needs
membarrier_mm_sync_core_before_usermode(), nobody noticed the missing
smp_mb__before/after_atomic(). These are anyhow a compiler barrier in =
x86,
and such a barrier would take place before the return to userspace.

