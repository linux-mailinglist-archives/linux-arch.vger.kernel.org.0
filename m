Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFC73A1BD4
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jun 2021 19:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhFIReZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Jun 2021 13:34:25 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:39841 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhFIReZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jun 2021 13:34:25 -0400
Received: by mail-lj1-f182.google.com with SMTP id c11so871431ljd.6
        for <linux-arch@vger.kernel.org>; Wed, 09 Jun 2021 10:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0MqGGesoGQuVnrKk3vQolI1WP+Da/YReiXXu0+F/PoI=;
        b=oqrytQIghczJbaoOnbzSWOJS9CfMcjLc6HQWxzBmqdZkwma71siufdGQgIdRW/JXvf
         aQ3ZQl1ZJqsCjf2non1uW8mv9R3ZZakVZGUc6rnDKTP49pOI7yiMJkZ17lpteOR7W5Dk
         0BwHWXG2hq4XKRcsmjqTqkbij0Db7HHOsbZyl/8CK3SKIsT4wLExXGcYUzFTrNOWQd2Z
         ATAPBdQQ7QUiQgT1RPAmrira+fA/LePyUxU5OebV2djq5Akg1bCRIQu/FREs/CUxO6s4
         /xqfs/mpZU90BtBFalot+yiDh2ptEj6Qlc3StsLT1Ydf33hnjNPBmgzf+blADrY/8kcC
         x44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0MqGGesoGQuVnrKk3vQolI1WP+Da/YReiXXu0+F/PoI=;
        b=ZwVvlhgQA+7jk1/G+Gg6MUkfE6obeUEDOlx6NalYoSO6ifgVqwvvW6/JRT8KBvexU2
         GySUj9xdQCfoBvYk18RJ9obS0+c+uurIQKQDCciWV3nZlXcZ+1Nd0zc8JtcQy+IFgJfo
         RW5KIfbelBWdlMsunhlf1dOjlwLB6K+2kUrqaZ7cuLIqLLx6zpBbLPOr6NCEuIxiapKV
         qrmKEEpBhENe1x9x7L1mZOHhICRnDOKDPFK1xh+SVOa41wR7onFqpiBvOrhlj31SRmSg
         OW0dIoxON29o41SKD3H9Mkdq+ZiRNHYZAP4dnGUGLaUnZAfYc85O0Iv/SQ2YUoX2tKX8
         AFqg==
X-Gm-Message-State: AOAM532PV7raZorHFnabpXjxHMknWmj57gZAmAM52QzeuGx0NJMee/3M
        eN5wekvxaYP2Kj9sjP+y5gqghTdW/rGlVUow05MdtA==
X-Google-Smtp-Source: ABdhPJzZP34kpS/OBBYpUc74IfvBrOBaQi8ta6LeCvRlqhhJBcG+k+md04w3oN828TXL0lj9FHnQWanfCb8lNJHvRjk=
X-Received: by 2002:a2e:3c06:: with SMTP id j6mr708333lja.495.1623259884911;
 Wed, 09 Jun 2021 10:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LNX.2.20.13.2106070956310.7184@monopod.intra.ispras.ru>
 <CANpmjNMwq6ENUtBunP-rw9ZSrJvZnQw18rQ47U3JuqPEQZsaXA@mail.gmail.com>
 <20210607152806.GS4397@paulmck-ThinkPad-P17-Gen-1> <YL5Risa6sFgnvvnG@elver.google.com>
 <CANpmjNNtDX+eBEpuP9-NgT6RAwHK5OgbQHT9b+8LZQJtwWpvPg@mail.gmail.com>
 <YL9TEqealhxBBhoS@hirez.programming.kicks-ass.net> <20210608152851.GX18427@gate.crashing.org>
 <CANpmjNPJaDT4vBqkTw8XaRfKgDuwh71qmrvNfq-vx-Zyp4ugNg@mail.gmail.com>
 <20210609153133.GF18427@gate.crashing.org> <CANpmjNPq3NBhi_pFpNd6TwXOVjw0LE2NuQ63dWZrYSfEet3ChQ@mail.gmail.com>
 <20210609171419.GI18427@gate.crashing.org>
In-Reply-To: <20210609171419.GI18427@gate.crashing.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 9 Jun 2021 10:31:13 -0700
Message-ID: <CAKwvOdn0t-z9pa5csvqSEJ1LLnwef8HQwZzfJgdkddN6GVZpXA@mail.gmail.com>
Subject: Re: [RFC] LKMM: Add volatile_if()
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Monakov <amonakov@ispras.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 9, 2021 at 10:20 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Wed, Jun 09, 2021 at 06:13:00PM +0200, Marco Elver wrote:
> > On Wed, 9 Jun 2021 at 17:33, Segher Boessenkool
> > <segher@kernel.crashing.org> wrote:
> > [...]
> > > > An alternative design would be to use a statement attribute to only
> > > > enforce (C) ("__attribute__((mustcontrol))" ?).
> > >
> > > Statement attributes only exist for empty statements.  It is unclear how
> > > (and if!) we could support it for general statements.
> >
> > Statement attributes can apply to anything -- Clang has had them apply
> > to non-empty statements for a while.
>
> First off, it is not GCC's problem if LLVM decides to use a GCC
> extension in some non-compatible way.

Reminds me of
https://lore.kernel.org/lkml/CAHk-=whu19Du_rZ-zBtGsXAB-Qo7NtoJjQjd-Sa9OB5u1Cq_Zw@mail.gmail.com/
-- 
Thanks,
~Nick Desaulniers
