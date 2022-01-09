Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579D64887A4
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jan 2022 05:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbiAIEoO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 23:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbiAIEoN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 23:44:13 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA57C06173F
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 20:44:13 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id u13so31731814lff.12
        for <linux-arch@vger.kernel.org>; Sat, 08 Jan 2022 20:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cKLmBwFRChKjyGRlhA5QZ69vyjO3Rc64fIylW8FYkO8=;
        b=CqZjyqzn1xhOUvCPKeEnFZJ7UtJlgKL+16636LsOxfmx7vb5I7ijvSiwSYhJxJ0vQ7
         tY5fUnpXVJfOS4jYOLQ0xhfhie0Q1pYNEpmbnzvsdCd3PNOu88aD0tW5eGe6uel/D+RR
         3qxE6TDOHUCM3VuuUTsy4Sc4cIHAdBxQ4gyAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cKLmBwFRChKjyGRlhA5QZ69vyjO3Rc64fIylW8FYkO8=;
        b=3m679PClfzBK8QGVM96amNiZVkBwgOi4EoCvr7Yn6Emw9GRSKzjAF9BMpz+VWHyWC4
         fz5ijqlimdqiJGEksxDxTCEnkWq2oAGYjQ8IqgQdedkNgJE24c23fS3SuBI2rVww7XyJ
         dUO8PTDo2aV45PUcd/BF3u/iJEC6N0r1zhtBm0J6VcJ+veTYZ9dar4sD98OHSau8zKp/
         NcW792W7uEYLGCQC1+YopG4F6JzOqDsYl40/v9qa8lZ5SfzKlVY3KJf1vgcZhscIz3vp
         DyFIKBRm65Yjztv80WtEVL2tCxjQ4JFDrNzs7W9WegAhPo225eD9WTFKYiVjsIYAfilo
         7mjA==
X-Gm-Message-State: AOAM531J+Ti2b1/uoSN2EJNOsZVB/Ck4eBFrpQp30km8e/XuE0WsiyB8
        AN5NuhJuRHzuUav40zC1cVFcGCjlo7cOVzUZTV0=
X-Google-Smtp-Source: ABdhPJyGlicB7XsERHnKjnsPtBZBGZlO9Z5y/mTOAxOcPLUJKXv/x5DWv/LaDxjXma0TnVTmjFx1CQ==
X-Received: by 2002:a05:651c:1043:: with SMTP id x3mr10761592ljm.258.1641703451092;
        Sat, 08 Jan 2022 20:44:11 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id k16sm475543lfg.257.2022.01.08.20.44.10
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jan 2022 20:44:10 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id j11so31840538lfg.3
        for <linux-arch@vger.kernel.org>; Sat, 08 Jan 2022 20:44:10 -0800 (PST)
X-Received: by 2002:adf:f54e:: with SMTP id j14mr59075968wrp.442.1641703098055;
 Sat, 08 Jan 2022 20:38:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641659630.git.luto@kernel.org> <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
 <CAHk-=wj4LZaFB5HjZmzf7xLFSCcQri-WWqOEJHwQg0QmPRSdQA@mail.gmail.com>
 <3586aa63-2dd2-4569-b9b9-f51080962ff2@www.fastmail.com> <CAHk-=wi2MtYYTs08RKHtj9Vtm0dri-saWwYh0tj=QUUUDSJFRQ@mail.gmail.com>
 <430e3db1-693f-4d46-bebf-0a953fe6c2fc@www.fastmail.com>
In-Reply-To: <430e3db1-693f-4d46-bebf-0a953fe6c2fc@www.fastmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 Jan 2022 20:38:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjkbFFvgnUqgO8omHgTJx0GDwhxP9Cw0g6E03zOVbC7HQ@mail.gmail.com>
Message-ID: <CAHk-=wjkbFFvgnUqgO8omHgTJx0GDwhxP9Cw0g6E03zOVbC7HQ@mail.gmail.com>
Subject: Re: [PATCH 16/23] sched: Use lightweight hazard pointers to grab lazy mms
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 8, 2022 at 7:59 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> > Hmm. The x86 maintainers are on this thread, but they aren't even the
> > problem. Adding Catalin and Will to this, I think they should know
> > if/how this would fit with the arm64 ASID allocator.
> >
>
> Well, I am an x86 mm maintainer, and there is definitely a performance problem on large x86 systems right now. :)

Well, my point was that on x86, the complexities of the patch you
posted are completely pointless.

So on x86, you can just remove the mmgrab/mmdrop reference counts from
the lazy mm use entirely, and voila, that performance problem is gone.
We don't _need_ reference counting on x86 at all, if we just say that
the rule is that a lazy mm is always associated with a
honest-to-goodness live mm.

So on x86 - and any platform with the IPI model - there is no need for
hundreds of lines of complexity at all.

THAT is my point. Your patch adds complexity that buys you ABSOLUTELY NOTHING.

You then saying that the mmgrab/mmdrop is a performance problem is
just trying to muddy the water. You can just remove it entirely.

Now, I do agree that that depends on the whole "TLB IPI will get rid
of any lazy mm users on other cpus". So I agree that if you have
hardware TLB invalidation that then doesn't have that software
component to it, you need something else.

But my argument _then_ was that hardware TLB invalidation then needs
the hardware ASID thing to be useful, and the ASID management code
already effectively keeps track of "this ASID is used on other CPU's".
And that's exactly the same kind of information that your patch
basically added a separate percpu array for.

So I think that even for that hardware TLB shootdown case, your patch
only adds overhead.

And it potentially adds a *LOT* of overhead, if you replace an atomic
refcount with a "for_each_possible_cpu()" loop that has to do cmpxchg
things too.

Now, on x86, where we maintain that mm_cpumask, and as a result that
overhead is much lower - but we maintain that mm_cpumask exactly
*because* we do that IPI thing, so I don't think you can use that
argument in favor of your patch. When we do the IPI thing, your patch
is worthless overhead.

See?

Btw, you don't even need to really solve the arm64 TLB invalidate
thing - we could make the rule be that we only do the mmgrab/mmput at
all on platforms that don't do that IPI flush.

I think that's basically exactly what Nick Piggin wanted to do on powerpc, no?

But you hated that patch, for non-obvious reasons, and are now
introducing this new patch that is clearly non-optimal on x86.

So I think there's some intellectual dishonesty on your part here.

                Linus
