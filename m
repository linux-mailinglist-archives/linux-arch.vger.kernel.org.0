Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D20488BF1
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jan 2022 20:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbiAITLR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Jan 2022 14:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbiAITLQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jan 2022 14:11:16 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC63C06173F
        for <linux-arch@vger.kernel.org>; Sun,  9 Jan 2022 11:11:15 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id b36so364250edf.12
        for <linux-arch@vger.kernel.org>; Sun, 09 Jan 2022 11:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YPOuTFQ/EFRlwfSEA3ipij++Ulf3u+5g+8CZYfsItBk=;
        b=AWGxyD2i+0VTrdb8KlRqAQ5n6fHAko3chHEhczjSNVua/1NPfcI4nbx0hg+4qt6xiX
         sS/zBrw6wnKvw92Ksmt5nmllSDLmc3J8Ra1HcjYvjIUoJZ8AzFA72hfzrOyU1vpJJ1ex
         IcvSo8dXW4uOAiE4lOmNhJmQ68qhxiDj69vU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YPOuTFQ/EFRlwfSEA3ipij++Ulf3u+5g+8CZYfsItBk=;
        b=ldy2LL9E6LghZZmmG4BrM/SbkN1sWZnbJp+nOM2zEq2mzXVH/21FxYKe9fjbPPKF/x
         sFSNR+zFWg3sziuyGWfULmv9+HuDZpOMFd2mtOcQfuyWyrmcnKY5f4c5eZg61vhHyCju
         PHCvUrk29sjv5lIOqA5kcjqJ0i1Tp3mosmZW3zkBveNbANYBO9aPfSduKp5cTa+tjPqU
         CR+YVmeNkHyGWXSTlDK45gFzUKnnbOCf7oiLMM7KJOKODutqGTIHXgnOxAa35xMB94Mv
         jUlzgYJinX3OQNbTwuZdK9CJNXoWNnK8/2SdEbp4PG+qG7MQHhskb+6Dse52v2nAg46T
         yOhw==
X-Gm-Message-State: AOAM531UMzXnGIfPRja46szh+8+RZj0aN55H0rf2ZSTuU7jL5M4mWrxi
        4Pag/qrvtrZEb81WBDQSgl2jL8M1sBA0PqWgpas=
X-Google-Smtp-Source: ABdhPJwLSjwvnzwnmodaAG8ro56d/2uPFEygcCa36ZFm6U2z/YPRD7R4+xPLWurFm1uDnDfT46e7zw==
X-Received: by 2002:a17:906:d8a3:: with SMTP id qc3mr8065634ejb.231.1641755473626;
        Sun, 09 Jan 2022 11:11:13 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id sa6sm1632827ejc.6.2022.01.09.11.11.11
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jan 2022 11:11:12 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id v123so7430533wme.2
        for <linux-arch@vger.kernel.org>; Sun, 09 Jan 2022 11:11:11 -0800 (PST)
X-Received: by 2002:a05:600c:4f13:: with SMTP id l19mr19329898wmq.152.1641755471150;
 Sun, 09 Jan 2022 11:11:11 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641659630.git.luto@kernel.org> <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
 <739A3109-04DD-4BA5-A02B-52EE30E820AE@gmail.com> <CAHk-=wiEZO-uyFELSZgYmxF7eOLHrvh-kMWY5qTKjckOdNQxpA@mail.gmail.com>
 <B728EEE2-1EB9-4ACD-9F4E-423276380C0C@gmail.com>
In-Reply-To: <B728EEE2-1EB9-4ACD-9F4E-423276380C0C@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 9 Jan 2022 11:10:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgtS7aNL=bxuwVFKiUzijc1EFiFXWTNLH-CHEgxciUVdg@mail.gmail.com>
Message-ID: <CAHk-=wgtS7aNL=bxuwVFKiUzijc1EFiFXWTNLH-CHEgxciUVdg@mail.gmail.com>
Subject: Re: [PATCH 16/23] sched: Use lightweight hazard pointers to grab lazy mms
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jan 9, 2022 at 12:49 AM Nadav Amit <nadav.amit@gmail.com> wrote:
>
> I do not know whether it is a pure win, but there is a tradeoff.

Hmm. I guess only some serious testing would tell.

On x86, I'd be a bit worried about removing lazy TLB simply because
even with ASID support there (called PCIDs by Intel for NIH reasons),
the actual ASID space on x86 was at least originally very very
limited.

Architecturally, x86 may expose 12 bits of ASID space, but iirc at
least the first few implementations actually only internally had one
or two bits, and hashed the 12 bits down to that internal very limited
hardware TLB ID space.

We only use a handful of ASIDs per CPU on x86 partly for this reason
(but also since there's no remote hardware TLB shootdown, there's no
reason to have a bigger global ASID space, so ASIDs aren't _that_
common).

And I don't know how many non-PCID x86 systems (perhaps virtualized?)
there might be out there.

But it would be very interesting to test some "disable lazy tlb"
patch. The main problem workloads tend to be IO, and I'm not sure how
many of the automated performance tests would catch issues. I guess
some threaded pipe ping-pong test (with each thread pinned to
different cores) would show it.

And I guess there is some load that triggered the original powerpc
patch by Nick&co, and that Andy has been using..

Anybody willing to cook up a patch and run some benchmarks? Perhaps
one that basically just replaces "set ->mm to NULL" with "set ->mm to
&init_mm" - so that the lazy TLB code is still *there*, but it never
triggers..

I think it's mainly 'copy_thread()' in kernel/fork.c and the 'init_mm'
initializer in mm/init-mm.c, but there's probably other things too
that have that knowledge of the special "tsk->mm = NULL" situation.

                  Linus
