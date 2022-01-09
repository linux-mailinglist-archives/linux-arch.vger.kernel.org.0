Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60A5488CB1
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jan 2022 22:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbiAIVvj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Jan 2022 16:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiAIVvj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jan 2022 16:51:39 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A5DC06173F
        for <linux-arch@vger.kernel.org>; Sun,  9 Jan 2022 13:51:38 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 30so44440020edv.3
        for <linux-arch@vger.kernel.org>; Sun, 09 Jan 2022 13:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vAmdahK+dyjevXdPfaG3db/HofoiSn0UPXYkRU3G81Y=;
        b=IgQWV2jOfLW3hrvXADZvYfvhegngvZHmQuGNoQqURYODIWe6cb+OAttHHaEu8CPiM0
         cqcYCrle5SSBD4WLI06a4FsA7OypGS3+MfzSaa4mLrMzv69tsfms/kpAODZirvOcY1zN
         8I05HQeeLYKw7m7n8QMm4PljVLWgt4t4NXA8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vAmdahK+dyjevXdPfaG3db/HofoiSn0UPXYkRU3G81Y=;
        b=if5WtdEW2fav4KG6tvta2/iuc+pSlgeZUHNR3bEoMGn4Lnbf/6KWWRPtDlCSmSUC70
         FHZV8JsyO7DpnwSI+iUL38ilBbNCeYJdDo56XOpoBrhULA022afXJLHrGTwiEJRdZSbq
         pOU01tTcVf6RCA8+ubTPutg0fFcN76OZDO1n9AlZnFxjvAf6EFwISxjGCa8FnFw+gv79
         yNJgcctIK4rXkP0kd3fGljbwlzIqxmSLEtudFP81gfE/uXYCmWOuM7sJQ2+H8iNx92hu
         62oTkLM82usqUym0x14ot8WYR7sVWTyx1E5Gfx01cONb6ueDbWqCH8mGXqHE0lxsHFsi
         6+rQ==
X-Gm-Message-State: AOAM533qkSvshfuCv+XPD2pTcnBamO9DfRnPYxjbxI2Eg0Ka5NMeEX+k
        6In0oYrcC95x2oO00+Yq4kZbzWWjAsw534b7wl0=
X-Google-Smtp-Source: ABdhPJz2bSMzgRoq5V3crq3RzhLJTZPvFM6Ei2yohZ5yezYvyO4hq/DzgJ+szJ79fM2AcE6rjWeVkg==
X-Received: by 2002:a17:907:d28:: with SMTP id gn40mr711173ejc.248.1641765097274;
        Sun, 09 Jan 2022 13:51:37 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id qw4sm1721058ejc.55.2022.01.09.13.51.36
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jan 2022 13:51:36 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id r9so21481116wrg.0
        for <linux-arch@vger.kernel.org>; Sun, 09 Jan 2022 13:51:36 -0800 (PST)
X-Received: by 2002:a05:6000:10d2:: with SMTP id b18mr61909226wrx.193.1641765096117;
 Sun, 09 Jan 2022 13:51:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641659630.git.luto@kernel.org> <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
 <CAHk-=wj4LZaFB5HjZmzf7xLFSCcQri-WWqOEJHwQg0QmPRSdQA@mail.gmail.com>
 <3586aa63-2dd2-4569-b9b9-f51080962ff2@www.fastmail.com> <CAHk-=wi2MtYYTs08RKHtj9Vtm0dri-saWwYh0tj=QUUUDSJFRQ@mail.gmail.com>
 <430e3db1-693f-4d46-bebf-0a953fe6c2fc@www.fastmail.com> <CAHk-=wjkbFFvgnUqgO8omHgTJx0GDwhxP9Cw0g6E03zOVbC7HQ@mail.gmail.com>
 <484a7f37-ceed-44f6-8629-0e67a0860dc8@www.fastmail.com> <CAHk-=whJYoKgAAtb6pYQVSPnyLQsnS6+rU=0jBUqrZU76LyDqg@mail.gmail.com>
In-Reply-To: <CAHk-=whJYoKgAAtb6pYQVSPnyLQsnS6+rU=0jBUqrZU76LyDqg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 9 Jan 2022 13:51:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgnTWk2zeOO1YQ_8S-xPf4Pr0vXBs7DnhOPdKQFHXOnxw@mail.gmail.com>
Message-ID: <CAHk-=wgnTWk2zeOO1YQ_8S-xPf4Pr0vXBs7DnhOPdKQFHXOnxw@mail.gmail.com>
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

[ Ugh, I actually went back and looked at Nick's patches again, to
just verify my memory, and they weren't as pretty as I thought they
were ]

On Sun, Jan 9, 2022 at 12:48 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'd much rather have a *much* smaller patch that says "on x86 and
> powerpc, we don't need this overhead at all".

For some reason I thought Nick's patch worked at "last mmput" time and
the TLB flush IPIs that happen at that point anyway would then make
sure any lazy TLB is cleaned up.

But that's not actually what it does. It ties the
MMU_LAZY_TLB_REFCOUNT to an explicit TLB shootdown triggered by the
last mmdrop() instead. Because it really tied the whole logic to the
mm_count logic (and made lazy tlb to not do mm_count) rather than the
mm_users thing I mis-remembered it doing.

So at least some of my arguments were based on me just mis-remembering
what Nick's patch actually did (mainly because I mentally recreated
the patch from "Nick did something like this" and what I thought would
be the way to do it on x86).

So I guess I have to recant my arguments.

I still think my "get rid of lazy at last mmput" model should work,
and would be a perfect match for x86, but I can't really point to Nick
having done that.

So I was full of BS.

Hmm. I'd love to try to actually create a patch that does that "Nick
thing", but on last mmput() (ie when __mmput triggers). Because I
think this is interesting. But then I look at my schedule for the
upcoming week, and I go "I don't have a leg to stand on in this
discussion, and I'm just all hot air".

Because code talks, BS walks.

                Linus
