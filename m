Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2871168C887
	for <lists+linux-arch@lfdr.de>; Mon,  6 Feb 2023 22:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjBFVXN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Feb 2023 16:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjBFVXM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 16:23:12 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47062CDC2
        for <linux-arch@vger.kernel.org>; Mon,  6 Feb 2023 13:23:11 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id x29so13530137ljq.0
        for <linux-arch@vger.kernel.org>; Mon, 06 Feb 2023 13:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4kSVpgLpfM16u0prsMj5jU/ue6IDxqmnToHq6QUNxFI=;
        b=QVnH1fzLuEWANQs865eJE5IPrTtuRI3E0A/CtmjmZR36JF8L4gyFfRGEICOOADsEoN
         v3bjR5GGXhWc3RcDQovKq2aoGHXRO7np4dT9wBoa7eEU8pnMsLclKabUsRCdU09wDcAF
         mq3m60Q9TQaUYN/+BDcmH2Q4pBT5J7IhBaubw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4kSVpgLpfM16u0prsMj5jU/ue6IDxqmnToHq6QUNxFI=;
        b=S48xqqkzPsSTkSy1t0Xyymzf8ZSOTiFZpG/GBcr2fr5gYOC4W9xdp7ZKXwmx+wNY4z
         CTWTqu+YfnfecHxw85bE0mt6fj93Y9h3xONpDqlebIw86DPxZe0p4rqb8fG+W43g3u2P
         on/S/0I6kE3pzbUwaZC5ZV5NyqPe2PTI48TWADJpkAbd6O5iHqdvtnbFm8ARJc27bdVZ
         ID414N7FyHIdSyY/XuBg4KhGomU98XkwzcI+Mg7eUjjuMoT27w0N7GselLqOcLkEZhy1
         HRAxFvwrKzxBBtxfBSwghYaclJF/sqiTOC++I8AzT9ub59jga13EMSu7sSrTu35YRtRW
         06Kg==
X-Gm-Message-State: AO0yUKXbyrNse7QofuB+NcPaQz6VddJefsdW2F8kIKKBSg6atx5F43ca
        dMh1NWdGlT6HkGSh5Kct48StMaqmPfmI8pw2BcUFJw==
X-Google-Smtp-Source: AK7set9fK7J0IK+MG0K9RQCkZfeTedz1prUlL8PM87ENTqelebResyhus+ftvqsn/9kgRydR8fsKtrzM1IdL/YkP0ck=
X-Received: by 2002:a2e:b4b2:0:b0:290:66b3:53e5 with SMTP id
 q18-20020a2eb4b2000000b0029066b353e5mr113940ljm.57.1675718589520; Mon, 06 Feb
 2023 13:23:09 -0800 (PST)
MIME-Version: 1.0
References: <20230204004843.GA2677518@paulmck-ThinkPad-P17-Gen-1>
 <Y920w4QRLtC6kd+x@rowland.harvard.edu> <20230204014941.GS2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y95yhJgNq8lMXPdF@rowland.harvard.edu> <20230204222411.GC2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9+41ctA54pjm/KG@google.com> <Y+FJSzUoGTgReLPB@rowland.harvard.edu>
In-Reply-To: <Y+FJSzUoGTgReLPB@rowland.harvard.edu>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 6 Feb 2023 16:22:57 -0500
Message-ID: <CAEXW_YR=J9Y9acRaZrU_F7S5Fwe7rhxwqKmxV2NOGwo0pjNBnA@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 6, 2023 at 1:39 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Sun, Feb 05, 2023 at 02:10:29PM +0000, Joel Fernandes wrote:
> > On Sat, Feb 04, 2023 at 02:24:11PM -0800, Paul E. McKenney wrote:
> > > On Sat, Feb 04, 2023 at 09:58:12AM -0500, Alan Stern wrote:
> > > > On Fri, Feb 03, 2023 at 05:49:41PM -0800, Paul E. McKenney wrote:
> > > > > On Fri, Feb 03, 2023 at 08:28:35PM -0500, Alan Stern wrote:
> > > > > > The "Provide exact semantics for SRCU" patch should have:
> > > > > >
> > > > > >       Portions suggested by Boqun Feng and Jonas Oberhauser.
> > > > > >
> > > > > > added at the end, together with your Reported-by: tag.  With that, I
> > > > > > think it can be queued for 6.4.
> > > > >
> > > > > Thank you!  Does the patch shown below work for you?
> > > > >
> > > > > (I have tentatively queued this, but can easily adjust or replace it.)
> > > >
> > > > It looks fine.
> > >
> > > Very good, thank you for looking it over!  I pushed it out on branch
> > > stern.2023.02.04a.
> > >
> > > Would anyone like to ack/review/whatever this one?
> >
> > Would it be possible to add comments, something like the following? Apologies
> > if it is missing some ideas. I will try to improve it later.
> >
> > thanks!
> >
> >  - Joel
> >
> > ---8<-----------------------
> >
> > diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
> > index ce068700939c..0a16177339bc 100644
> > --- a/tools/memory-model/linux-kernel.bell
> > +++ b/tools/memory-model/linux-kernel.bell
> > @@ -57,7 +57,23 @@ let rcu-rscs = let rec
> >  flag ~empty Rcu-lock \ domain(rcu-rscs) as unmatched-rcu-lock
> >  flag ~empty Rcu-unlock \ range(rcu-rscs) as unmatched-rcu-unlock
> >
> > +(***************************************************************)
> >  (* Compute matching pairs of nested Srcu-lock and Srcu-unlock *)
> > +(***************************************************************)
> > +(*
> > + * carry-srcu-data: To handle the case of the SRCU critical section split
> > + * across CPUs, where the idx is used to communicate the SRCU index across CPUs
> > + * (say CPU0 and CPU1), data is between the R[srcu-lock] to W[once][idx] on
> > + * CPU0, which is sequenced with the ->rf is between the W[once][idx] and the
> > + * R[once][idx] on CPU1.  The carry-srcu-data is made to exclude Srcu-unlock
> > + * events to prevent capturing accesses across back-to-back SRCU read-side
> > + * critical sections.
> > + *
> > + * srcu-rscs: Putting everything together, the carry-srcu-data is sequenced with
> > + * a data relation, which is the data dependency between R[once][idx] on CPU1
> > + * and the srcu-unlock store, and loc ensures the relation is unique for a
> > + * specific lock.
> > + *)
> >  let carry-srcu-data = (data ; [~ Srcu-unlock] ; rf)*
> >  let srcu-rscs = ([Srcu-lock] ; carry-srcu-data ; data ; [Srcu-unlock]) & loc
>
> My tendency has been to keep comments in the herd7 files to a minimum
> and to put more extended descriptions in the explanation.txt file.
> Right now that file contains almost nothing (a single paragraph!) about
> SRCU, so it needs to be updated to talk about the new definition of
> srcu-rscs.  In my opinion, that's where this sort of comment belongs.

That makes sense, I agree.

> Joel, would you like to write an extra paragraph of two for that file,
> explaining in more detail how SRCU lock-to-unlock matching is different
> from regular RCU and how the definition of the srcu-rscs relation works?
> I'd be happy to edit anything you come up with.

Yes I would love to, I'll spend some more time studying this up a bit
more so I don't write nonsense. But yes, I am quite interested in
writing something up and I will do so!

Thanks,

 - Joel


> Alan
>
> PS: We also need to update the PLAIN ACCESSES AND DATA RACES section of
> explanation.txt, to mention the carry-dep relation and why it is
> important.
