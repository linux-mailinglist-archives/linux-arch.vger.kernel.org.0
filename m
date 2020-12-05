Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520A42CFFAF
	for <lists+linux-arch@lfdr.de>; Sun,  6 Dec 2020 00:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgLEXPq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Dec 2020 18:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgLEXPq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Dec 2020 18:15:46 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB87C0613D1;
        Sat,  5 Dec 2020 15:15:05 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id o4so5913743pgj.0;
        Sat, 05 Dec 2020 15:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=L+vg4JbP0FJBCP1pF1I695Sm385f278Rs5jRmS9rNXg=;
        b=QqSC0/j6vjRBOiUDUATi/LPsIVAKUy7bK3rktA0IiR7ML8OM2DpeGXtMsUyK3nMwvk
         pSIpV88iDIfxTLuHlmK8QbBnKk9K3t3fr+y6EQaJIyRri4NV/kXIDMmBsMZJZSctTZtK
         HhdYeIA6jeB/vHZdcEGMnXvdBMLb3PuBdsn0rJvHnz/Lly9SVkMu+NWh4/mOtxfPk22B
         G98NTD3lNPX4TNB+6ZX95CA788LnFcXhbCyOA600VVkyE4El+oW55ey3b5hgAYD+ZvMV
         XEhp7uyplSDklj4P9m6cf1EiAoFeRjIeP8qF9dgrcpjqlXWreqnm2tGOqgBF6WlFcWiJ
         4FLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=L+vg4JbP0FJBCP1pF1I695Sm385f278Rs5jRmS9rNXg=;
        b=js+5CWAzZhwlp8x97vYdjl9tKnmugqScV8+PLLz8H+GkhVwkFlW98Au7CMSNIZQvIX
         wHXNE87XwarFlWLtzVJ3eMUl09aKFhRkJ+CDH+2G349iYEKzxzSwRHO3CXPKOcGWPWGa
         KyyW6AXZOzVDrdraRssjomIcfmmTayfd6Kp7g7AfPKOrNq2zVeSIY84nQaaKKDDEXA9c
         0YWjWxtk7/vCdKwA84MLQ8sWJ39XrBNCzw6n+7bfEVCb+M4GMCM6gUQg9vi4nHk0i5f4
         SqbXjRoHTmABOxYSPt6BOUW/h6MvR8P+/+MtWzvkDT4qncvP137fP6r3rRSQ+JADtmY7
         cF2w==
X-Gm-Message-State: AOAM533Pzm2iGBcYLlHC3mpAYcc6lmeQ6ixoq5zYboCJmc1HFlfNMHHo
        rV/NEhqoHNAOECz+sP/aQ26baZ5qaBI=
X-Google-Smtp-Source: ABdhPJzfxzuJbfqX3AxcZgkq+sDJtUgImoz4dGsHTfVrStKXtO6JvVyi6Isgck4AhVl4gjBk5OYlzg==
X-Received: by 2002:a63:1107:: with SMTP id g7mr12703758pgl.432.1607210105367;
        Sat, 05 Dec 2020 15:15:05 -0800 (PST)
Received: from localhost ([1.129.241.238])
        by smtp.gmail.com with ESMTPSA id k26sm9514644pfg.8.2020.12.05.15.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 15:15:04 -0800 (PST)
Date:   Sun, 06 Dec 2020 09:14:57 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/8] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>
References: <1607152918.fkgmomgfw9.astroid@bobo.none>
        <116A6B40-C77B-4B6A-897B-18342CD62CEC@amacapital.net>
In-Reply-To: <116A6B40-C77B-4B6A-897B-18342CD62CEC@amacapital.net>
MIME-Version: 1.0
Message-Id: <1607209402.fogfsh8ov4.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Andy Lutomirski's message of December 6, 2020 2:11 am:
>=20
>> On Dec 5, 2020, at 12:00 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
>>=20
>>=20
>> I disagree. Until now nobody following it noticed that the mm gets
>> un-lazied in other cases, because that was not too clear from the
>> code (only indirectly using non-standard terminology in the arch
>> support document).
>=20
>> In other words, membarrier needs a special sync to deal with the case=20
>> when a kthread takes the mm.
>=20
> I don=E2=80=99t think this is actually true. Somehow the x86 oddities abo=
ut=20
> CR3 writes leaked too much into the membarrier core code and comments.=20
> (I doubt this is x86 specific.  The actual x86 specific part seems to=20
> be that we can return to user mode without syncing the instruction=20
> stream.)
>=20
> As far as I can tell, membarrier doesn=E2=80=99t care at all about lazine=
ss.=20
> Membarrier cares about rq->curr->mm.  The fact that a cpu can switch=20
> its actual loaded mm without scheduling at all (on x86 at least) is=20
> entirely beside the point except insofar as it has an effect on=20
> whether a subsequent switch_mm() call serializes.

Core membarrier itself doesn't care about laziness, which is why the
membarrier flush should go in exit_lazy_tlb() or other x86 specific
code (at least until more architectures did the same thing and we moved
it into generic code). I just meant this non-serialising return as=20
documented in the membarrier arch enablement doc specifies the lazy tlb
requirement.

If an mm was lazy tlb for a kernel thread and then it becomes unlazy,
and if switch_mm is serialising but return to user is not, then you
need a serialising instruction somewhere before return to user. unlazy
is the logical place to add that, because the lazy tlb mm (i.e.,=20
switching to a kernel thread and back without switching mm) is what=20
opens the hole.

> If we notify=20
> membarrier about x86=E2=80=99s asynchronous CR3 writes, then membarrier n=
eeds=20
> to understand what to do with them, which results in an unmaintainable=20
> mess in membarrier *and* in the x86 code.

How do you mean? exit_lazy_tlb is the opposite, core scheduler notifying
arch code about when an mm becomes not-lazy, and nothing to do with
membarrier at all even. It's a convenient hook to do your un-lazying.
I guess you can do it also checking things in switch_mm and keeping state
in arch code, I don't think that's necessarily the best place to put it.

So membarrier code is unchanged (it cares that the serialise is done at
un-lazy time), core code is simpler (no knowledge of this membarrier=20
quirk and it already knows about lazy-tlb so the calls actually improve=20
the documentation), and x86 code I would argue becomes nicer (or no real
difference at worst) because you can move some exit lazy tlb handling to
that specific call rather than decipher it from switch_mm.

>=20
> I=E2=80=99m currently trying to document how membarrier actually works, a=
nd=20
> hopefully this will result in untangling membarrier from mmdrop() and=20
> such.

That would be nice.

>=20
> A silly part of this is that x86 already has a high quality=20
> implementation of most of membarrier(): flush_tlb_mm().  If you flush=20
> an mm=E2=80=99s TLB, we carefully propagate the flush to all threads, wit=
h=20
> attention to memory ordering.  We can=E2=80=99t use this directly as an=20
> arch-specific implementation of membarrier because it has the annoying=20
> side affect of flushing the TLB and because upcoming hardware might be=20
> able to flush without guaranteeing a core sync.  (Upcoming means Zen=20
> 3, but the Zen 3 implementation is sadly not usable by Linux.)
>=20

A hardware broadcast TLB flush, you mean? What makes it unusable by=20
Linux out of curiosity?
