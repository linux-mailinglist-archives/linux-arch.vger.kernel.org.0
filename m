Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145D8488C5C
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jan 2022 21:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbiAIUtC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Jan 2022 15:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbiAIUtB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jan 2022 15:49:01 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6C6C06173F
        for <linux-arch@vger.kernel.org>; Sun,  9 Jan 2022 12:49:01 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id q25so37064069edb.2
        for <linux-arch@vger.kernel.org>; Sun, 09 Jan 2022 12:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MbEyDeqgYbJ2xhJxNtcbQmNzMLNwoT31D9rzWrEDzgc=;
        b=gSjXyOTYJ/ZtTbXp5zrEUee7+gcmi5I7MFLZHm9UtKa11ybb29dF/Qkw7HsGEfZ2KO
         oJhMoNsi13vzZedr5xsSTA5R3Z1JLa1JeOsD2WP2VbPwoCRhiPJnqG0HtFpMrOo+hVHL
         d9nxrfL67kEqAeL+qFp5ppDgnhmlHUsZCxp5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MbEyDeqgYbJ2xhJxNtcbQmNzMLNwoT31D9rzWrEDzgc=;
        b=oJ1sZo6Mp5WG7CgYkqfy8Bq5KxyC43sPyHZpBoXuBLBBhkdS24xNlnF4eHPt+Z5sEm
         3WFsCZRQ8blue5nRVzcLnB0M5VnNN3tPBScTlAzfMJnRKR6cjodK7Ee9gZNL4SOhFk6c
         nlsWlFWsaiMacjLy/mMMktWBoljnvzGeZgle7o0w3L6KNfbahxN7CHJ9cAnccmWNikxl
         8LX+rpNspA6fPt+NmFpuwzxWFHCq6+Qgmw+x+q6VZ/weVR6j3+zRaU1V4OAACqsVzBeU
         fnNfVVagCrjYt71TkdNy00ODDo/Hwm3SFmsTRnovlvmZRKS3xBZguZhTJRSZ4rpL0VvD
         YE/A==
X-Gm-Message-State: AOAM533C2mfX2hd7PZTeEUXIiHZHuHUoBEA4ApCjoPaZJcRyc9HlvQZu
        /rkbxNsEKAo/cQwrBmtw0SAcAYQqZvKce/N77XA=
X-Google-Smtp-Source: ABdhPJy+RZhFN4EXfwYCy3+VsOsi93LDDgpWPqp2juXvwJlgUphgVpOUMm9mvisneGDesexvtelFcg==
X-Received: by 2002:a17:906:3e4b:: with SMTP id t11mr13514880eji.744.1641761339802;
        Sun, 09 Jan 2022 12:48:59 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id 19sm1683227ejv.207.2022.01.09.12.48.59
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jan 2022 12:48:59 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id h10so12890754wrb.1
        for <linux-arch@vger.kernel.org>; Sun, 09 Jan 2022 12:48:59 -0800 (PST)
X-Received: by 2002:a5d:6c68:: with SMTP id r8mr61088416wrz.281.1641761338895;
 Sun, 09 Jan 2022 12:48:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641659630.git.luto@kernel.org> <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
 <CAHk-=wj4LZaFB5HjZmzf7xLFSCcQri-WWqOEJHwQg0QmPRSdQA@mail.gmail.com>
 <3586aa63-2dd2-4569-b9b9-f51080962ff2@www.fastmail.com> <CAHk-=wi2MtYYTs08RKHtj9Vtm0dri-saWwYh0tj=QUUUDSJFRQ@mail.gmail.com>
 <430e3db1-693f-4d46-bebf-0a953fe6c2fc@www.fastmail.com> <CAHk-=wjkbFFvgnUqgO8omHgTJx0GDwhxP9Cw0g6E03zOVbC7HQ@mail.gmail.com>
 <484a7f37-ceed-44f6-8629-0e67a0860dc8@www.fastmail.com>
In-Reply-To: <484a7f37-ceed-44f6-8629-0e67a0860dc8@www.fastmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 9 Jan 2022 12:48:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=whJYoKgAAtb6pYQVSPnyLQsnS6+rU=0jBUqrZU76LyDqg@mail.gmail.com>
Message-ID: <CAHk-=whJYoKgAAtb6pYQVSPnyLQsnS6+rU=0jBUqrZU76LyDqg@mail.gmail.com>
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

On Sun, Jan 9, 2022 at 12:20 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> Are you *sure*? The ASID management code on x86 is (as mentioned
> before) completely unaware of whether an ASID is actually in use
> anywhere.

Right.

But the ASID situation on x86 is very very different, exactly because
x86 doesn't have cross-CPU TLB invalidates.

Put another way: x86 TLB hardware is fundamentally per-cpu. As such,
any ASID management is also per-cpu.

That's fundamentally not true on arm64.  And that's not some "arm64
implementation detail". That's fundamental to doing cross-CPU TLB
invalidates in hardware.

If your TLB invalidates act across CPU's, then the state they act on
are also obviously across CPU's.

So the ASID situation is fundamentally different depending on the
hardware usage. On x86, TLB's are per-core, and on arm64 they are not,
and that's reflected in our code too.

As a result, on x86, each mm has a per-cpu ASID, and there's a small
array of per-cpu "mm->asid" mappings.

On arm, each mm has an asid, and it's allocated from a global asid
space - so there is no need for that "mm->asid" mapping, because the
asid is there in the mm, and it's shared across cpus.

That said, I still don't actually know the arm64 ASID management code.

The thing about TLB flushes is that it's ok to do them spuriously (as
long as you don't do _too_ many of them and tank performance), so two
different mm's can have the same hw ASID on two different cores and
that just makes cross-CPU TLB invalidates too aggressive. You can't
share an ASID on the _same_ core without flushing in between context
switches, because then the TLB on that core might be re-used for a
different mm. So the flushing rules aren't necessarily 100% 1:1 with
the "in use" rules, and who knows if the arm64 ASID management
actually ends up just matching what that whole "this lazy TLB is still
in use on another CPU".

So I don't really know the arm64 situation. And i's possible that lazy
TLB isn't even worth it on arm64 in the first place.

> > So I think that even for that hardware TLB shootdown case, your patch
> > only adds overhead.
>
> The overhead is literally:
>
> exit_mmap();
> for each cpu still in mm_cpumask:
>   smp_load_acquire
>
> That's it, unless the mm is actually in use

Ok, now do this for a machine with 1024 CPU's.

And tell me it is "scalable".

> On a very large arm64 system, I would believe there could be real overhead.  But these very large systems are exactly the systems that currently ping-pong mm_count.

Right.

But I think your arguments against mm_count are questionable.

I'd much rather have a *much* smaller patch that says "on x86 and
powerpc, we don't need this overhead at all".

And then the arm64 people can look at it and say "Yeah, we'll still do
the mm_count thing", or maybe say "Yeah, we can solve it another way".

And maybe the arm64 people actually say "Yeah, this hazard pointer
thing is perfect for us". That still doesn't necessarily argue for it
on an architecture that ends up serializing with an IPI anyway.

                Linus
