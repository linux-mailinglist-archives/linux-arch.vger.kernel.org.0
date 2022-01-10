Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4CAF488F0C
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jan 2022 04:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238402AbiAJDvr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Jan 2022 22:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbiAJDvq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jan 2022 22:51:46 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8809BC06173F
        for <linux-arch@vger.kernel.org>; Sun,  9 Jan 2022 19:51:46 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id b7so19146183edj.9
        for <linux-arch@vger.kernel.org>; Sun, 09 Jan 2022 19:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UN/K11NGDAyS29b+tKFTVgzsYRR4azKfnt+fJjqSmE8=;
        b=bgHFnfCcTlfxYQYR0YlEC56rnbIqGhm3dT6YYDmbt0Q4tiRVoLeFZdz4xXCWYt0dm0
         0XAf62/b37mIZPif0YcJ8ZvhdnKcxwPTpTKPPfgteymyvLXL0S+IIzyFEZt2nLWJVZP7
         df2KqDa2N/y30u77VC9u0Pr3r0byN2eiBEG48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UN/K11NGDAyS29b+tKFTVgzsYRR4azKfnt+fJjqSmE8=;
        b=Jxsz8c2e54AazyuPnD7SteAM0iWIOi6eEK1LycyNpjZ4GH72DIkxadHjKYmtzFgmEc
         JkoJcL8PJIBzxLpFxjIzHlBPujYfw4rwDl/CMYw+HuX8fbHT2ZXOMzMn9W+5laA/2oXW
         Qa7EU2/P6tCZvk1TjxyOLhToTTAuN8xvCU4ypNsBBJpmPZ2unhAYn/zC216RMpzPiI0n
         yjUem2UPKJ6XhGhyjAJEirlpcUy0foznW0HfEe7Yp1M86m97WCAj3DXP+gLT4VHcJEB0
         v6Da48VrTCwDoOHeGdKhIerjYSm9I49AvqVEEhudFkoyhwIFb1N69fbB9YKqboYdjNkv
         c4VQ==
X-Gm-Message-State: AOAM533LqdPFC68AGu8TyBLQuc1dZ+J8i01GwESDWipZdaDjVs3/W+Cq
        xKj/AgW9/rix34MC2RR4EQHmMiC5qHDMmTn8oSE=
X-Google-Smtp-Source: ABdhPJyxF1lMmYA9zSSKG+wXOZggTMozug6nxr+wBG/3HhzI9PJZ7uoeu1PL111RM/S5ZRsXvouq2Q==
X-Received: by 2002:a17:906:828a:: with SMTP id h10mr58158174ejx.164.1641786704910;
        Sun, 09 Jan 2022 19:51:44 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id l18sm1919496ejf.7.2022.01.09.19.51.43
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jan 2022 19:51:44 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id e9so22724218wra.2
        for <linux-arch@vger.kernel.org>; Sun, 09 Jan 2022 19:51:43 -0800 (PST)
X-Received: by 2002:adf:f54e:: with SMTP id j14mr62229023wrp.442.1641786703058;
 Sun, 09 Jan 2022 19:51:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641659630.git.luto@kernel.org> <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
 <CAHk-=wj4LZaFB5HjZmzf7xLFSCcQri-WWqOEJHwQg0QmPRSdQA@mail.gmail.com>
 <3586aa63-2dd2-4569-b9b9-f51080962ff2@www.fastmail.com> <CAHk-=wi2MtYYTs08RKHtj9Vtm0dri-saWwYh0tj=QUUUDSJFRQ@mail.gmail.com>
 <430e3db1-693f-4d46-bebf-0a953fe6c2fc@www.fastmail.com> <CAHk-=wjkbFFvgnUqgO8omHgTJx0GDwhxP9Cw0g6E03zOVbC7HQ@mail.gmail.com>
 <484a7f37-ceed-44f6-8629-0e67a0860dc8@www.fastmail.com> <CAHk-=whJYoKgAAtb6pYQVSPnyLQsnS6+rU=0jBUqrZU76LyDqg@mail.gmail.com>
 <CAHk-=wgnTWk2zeOO1YQ_8S-xPf4Pr0vXBs7DnhOPdKQFHXOnxw@mail.gmail.com>
 <00f58dff-9df5-45ac-a078-d852f13b1dfe@www.fastmail.com> <b1d963a8adf4618a53f996283c1bfae37323bbb6.camel@surriel.com>
In-Reply-To: <b1d963a8adf4618a53f996283c1bfae37323bbb6.camel@surriel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 9 Jan 2022 19:51:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgaQkeCW13TnvOxvNhGo4sz3ihLt+iNyQkkR_DpQZ=W7Q@mail.gmail.com>
Message-ID: <CAHk-=wgaQkeCW13TnvOxvNhGo4sz3ihLt+iNyQkkR_DpQZ=W7Q@mail.gmail.com>
Subject: Re: [PATCH 16/23] sched: Use lightweight hazard pointers to grab lazy mms
To:     Rik van Riel <riel@surriel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>,
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
        Dave Hansen <dave.hansen@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jan 9, 2022 at 6:40 PM Rik van Riel <riel@surriel.com> wrote:
>
> Also, while 800 loads is kinda expensive, it is a heck of
> a lot less expensive than 800 IPIs.

Rik, the IPI's you have to do *anyway*. So there are exactly zero extra IPI's.

Go take a look. It's part of the whole "flush TLB's" thing in __mmput().

So let me explain one more time what I think we should have done, at
least on x86:

 (1) stop refcounting active_mm entries entirely on x86

Why can we do that? Because instead of worrying about doing those
mm_count games for the active_mm reference, we realize that any
active_mm has to have a _regular_ mm associated with it, and it has a
'mm_users' count.

And when that mm_users count go to zero, we have:

 (2) mmput -> __mmput -> exit_mmap(), which already has to flush all
TLB's because it's tearing down the page tables

And since it has to flush those TLB's as part of tearing down the page
tables, we on x86 then have:

 (3) that TLB flush will have to do the IPI's to anybody who has that
mm active already

and that IPI has to be done *regardless*. And the TLB flushing done by
that IPI? That code already clears the lazy status (and not doing so
would be pointless and in fact wrong).

Notice? There isn't some "800 loads". There isn't some "800 IPI's".
And there isn't any refcounting cost of the lazy TLB.

Well, right now there *is* that refcounting cost, but my point is that
I don't think it should exist.

It shouldn't exist as an atomic access to mm_count (with those cache
ping-pongs when you have a lot of threads across a lot of CPUs), but
it *also* shouldn't exist as a "lightweight hazard pointer".

See my point? I think the lazy-tlb refcounting we do is pointless if
you have to do IPI's for TLB flushes.

Note: the above is for x86, which has to do the IPI's anyway (and it's
very possible that if you don't have to do IPI's because you have HW
TLB coherency, maybe lazy TLB's aren't what you should be using, but I
think that should be a separate discussion).

And yes, right now we do that pointless reference counting, because it
was simple and straightforward, and people historically didn't see it
as a problem.

Plus we had to have that whole secondary 'mm_count' anyway for other
reasons, since we use it for things that need to keep a ref to 'struct
mm_struct' around regardless of page table counts (eg things like a
lot of /proc references to 'struct mm_struct' do not want to keep
forced references to user page tables alive).

But I think conceptually mm_count (ie mmgrab/mmdrop) was always really
dodgy for lazy TLB. Lazy TLB really cares about the page tables still
being there, and that's not what mm_count is ostensibly about. That's
really what mm_users is about.

Yet mmgrab/mmdrop is exactly what the lazy TLB code uses, even if it's
technically odd (ie mmgrab really only keeps the 'struct mm' around,
but not about the vma's and page tables).

Side note: you can see the effects of this mis-use of mmgrab/mmdrop in
 how we tear down _almost_ all the page table state in __mmput(). But
look at what we keep until the final __mmdrop, even though there are
no page tables left:

        mm_free_pgd(mm);
        destroy_context(mm);

exactly because even though we've torn down all the page tables
earlier, we had to keep the page table *root* around for the lazy
case.

It's kind of a layering violation, but it comes from that lazy-tlb
mm_count use, and so we have that odd situation where the page table
directory lifetime is very different from the rest of the page table
lifetimes.

(You can easily make excuses for it by just saying that "mm_users" is
the user-space page table user count, and that the page directory has
a different lifetime because it's also about the kernel page tables,
so it's all a bit of a gray area, but I do think it's also a bit of a
sign of how our refcounting for lazy-tlb is a bit dodgy).

                Linus
