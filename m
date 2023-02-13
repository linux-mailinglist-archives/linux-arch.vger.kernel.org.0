Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73ED9693B79
	for <lists+linux-arch@lfdr.de>; Mon, 13 Feb 2023 01:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjBMAyb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Feb 2023 19:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBMAya (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Feb 2023 19:54:30 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD765FF7
        for <linux-arch@vger.kernel.org>; Sun, 12 Feb 2023 16:54:28 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id y19so12937655ljq.7
        for <linux-arch@vger.kernel.org>; Sun, 12 Feb 2023 16:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dz+a3mPWtoysx88tn67g1rPbKFZYyy96xE3GUFKUHts=;
        b=H5UiGmapwOiGC1yt24WxT2LWYXaMz3wEtskkj9kcQXVyellCrNwOPGnVImX0VpssPP
         NlF6rXCNLk9VLnUtqRsNipGu5yP4b+9Pi/HW3ClyaLEgnj3Eks069hz6gG0VCHoj/RWX
         8c/CLn7mAKJmcUwuTdI2nzoOGNJ0y5KKw+J3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dz+a3mPWtoysx88tn67g1rPbKFZYyy96xE3GUFKUHts=;
        b=3e0pajyvfQ7QrT2K9zZYOSkl36lx8o+PO7lFoNV63l75Ls/0J5J0vypd2hTF6gXmB9
         imhGELp0gGR6/rdaVjVmvdnkg3PLhU1zNSBuRDPzWoQyGQE7iIx3kuTGZoABcAYA19p4
         EzeaHuV++tSWG5bDpDYXeBh2Q/48YxUxNXL6gXMIcKmMGZNYZG1R1XAlh3sWk4ZyRxX8
         M97BAltECpT0t2HV+JBvuZKmMfZKk5H0A0LVv+zymZZ/h2BEmgasJ/kQJC2YIrIjHf5H
         6EvEpRTJyq9KLlB1hhVdkN6KREClZJJtILcoJlcR+Qbucgum4S4VS93VZ0t4Vx3AwkBu
         Ot/A==
X-Gm-Message-State: AO0yUKU27fEQzYAG0b/EVLdrUW9Oo5OJfcDbG7DL3XF9LHZ7UjKcbLfY
        w/Scc7EVDntek+M71ipbyD1puJSpIAeK7pbpUljsfA==
X-Google-Smtp-Source: AK7set/ZwJcDlthA7ojaCtH1HvCYwIA2SFhRWcxCP4DA/PdYuRinjHeX1iAlU+S6JOWl2/XfVkKBYMa6d9THdcgN/sg=
X-Received: by 2002:a2e:2f1e:0:b0:293:25c1:808f with SMTP id
 v30-20020a2e2f1e000000b0029325c1808fmr2873798ljv.154.1676249666804; Sun, 12
 Feb 2023 16:54:26 -0800 (PST)
MIME-Version: 1.0
References: <20230204004843.GA2677518@paulmck-ThinkPad-P17-Gen-1>
 <Y920w4QRLtC6kd+x@rowland.harvard.edu> <20230204014941.GS2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y95yhJgNq8lMXPdF@rowland.harvard.edu> <20230204222411.GC2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9+41ctA54pjm/KG@google.com> <Y+FJSzUoGTgReLPB@rowland.harvard.edu>
 <Y+fN2fvUjGDWBYrv@google.com> <Y+f4TYZ9BPlt8y8B@rowland.harvard.edu>
 <CAEXW_YRuTfjc=5OAskTV0Qt_zSJTPP3-01=Y=SypMdPsF_weAQ@mail.gmail.com> <Y+hWAksfk4C0M2gB@rowland.harvard.edu>
In-Reply-To: <Y+hWAksfk4C0M2gB@rowland.harvard.edu>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 12 Feb 2023 19:54:15 -0500
Message-ID: <CAEXW_YQUOgYxYUNkQ9W6PS-JPwPSOFU5B=COV7Vf+qNF1jFC7g@mail.gmail.com>
Subject: Re: Current LKMM patch disposition
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 11, 2023 at 9:59 PM Alan Stern <stern@rowland.harvard.edu> wrote:
[...]
> > is kind of why I want to understand the CAT, because for me
> > explanation.txt is too much at a higher level to get a proper
> > understanding of the memory model.. I tried re-reading explanation.txt
> > many times.. then I realized I am just rewriting my own condensed set
> > of notes every few months.
>
> Would you like to post a few examples showing some of the most difficult
> points you encountered?  Maybe explanation.txt can be improved.

Just to list 2 of the pain points:

1. I think it is hard to reason this section
"PROPAGATION ORDER RELATION: cumul-fence"

All store-related fences should affect propagation order, even the
smp_wmb() which is not A-cumulative should do so (po-earlier stores
appearing before po-later). I think expanding this section with some
examples would make sense to understand what makes "cumul-fence"
different from any other store-related fence.

2. This part is confusing and has always confused me " The
happens-before relation (hb) links memory accesses that have to
execute in a certain order"

It is not memory accesses that execute, it is instructions that
execute. Can we separate out "memory access" from "instruction
execution" in this description?

I think ->hb tries to say that A ->hb B means, memory access A
happened before memory access B exactly in its associated
instruction's execution order (time order), but to be specific --
should that be instruction issue order, or instruction retiring order?

AFAICS ->hb maps instruction execution order to memory access order.
Not all ->po does  fall into that category because of out-of-order
hardware execution. As does not ->co because the memory subsystem may
have writes to the same variable to be resolved out of order. It would
be nice to call out that ->po is instruction issue order, which is
different from execution/retiring and that's why it cannot be ->hb.

->rf does because of data flow causality, ->ppo does because of
program structure, so that makes sense to be ->hb.

IMHO, ->rfi should as well, because it is embodying a flow of data, so
that is a bit confusing. It would be great to clarify more perhaps
with an example about why ->rfi cannot be ->hb, in the
"happens-before" section.

That's really how far I typically get (line 1368) before life takes
over, and I have to go do other survival-related things. Then I
restart the activity. Now that I started reading the CAT file as well,
I feel I can make it past that line :D. But I never wanted to get past
it, till I built a solid understanding of the contents before it.

As I read the file more, I can give more feedback, but the above are
different 2 that persist.

Thanks!

 - Joel
