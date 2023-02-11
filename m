Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7806932CE
	for <lists+linux-arch@lfdr.de>; Sat, 11 Feb 2023 18:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjBKRSY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 11 Feb 2023 12:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBKRSW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 11 Feb 2023 12:18:22 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098F016312
        for <linux-arch@vger.kernel.org>; Sat, 11 Feb 2023 09:18:20 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id q13so9387934qtx.2
        for <linux-arch@vger.kernel.org>; Sat, 11 Feb 2023 09:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rt94ODpGzToIGuiugKNP8sTPsxgShvJ5t+d54bpkATI=;
        b=isXX/fBIHoWr9pj5V+k4FGzpoQYb6cHvvHeTZco7/A8Rlom/fga0taLPOaVpkBOBYk
         9UeIVQej6DggjoJPuz+UxTpwEv8AnssHPFGBoygWR0iM8JVFeQbmKYLh597ofo1JMtKp
         HnMoRHeDhkoEOUOUwWJO87Rgr6M0zEor1keXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rt94ODpGzToIGuiugKNP8sTPsxgShvJ5t+d54bpkATI=;
        b=IcKM6kVHF8uy0tDFTqwtdiV+MmYsuui34oD8prQqN3KvyGnXWW6/SD+V6mSG55X6Ya
         RQzUtalGwtE4NeAFVGCGTDEZYF4ET75sLvvuQDD4Ctt8zF8wrDWM1gYxaafmApEWFciz
         ehs6uItEPSCFMPrSQ8HUhx4L32aZ+7FpVeROWIgQT4VBp7nfQM56IjHEsERKl6d5+mmA
         z7vFtzY8OADiI5YFGhb3QXzka4kUabHkBvuPOwOP3dU488MMdq3dV8Tb/wQLF/WeaKOh
         Tm8zPWzi8g06xP80E8o4hiSq+qurjbgw8AZ7c7HdQZruaLrHpW6KztX8KcxXDeEjiso2
         g6Uw==
X-Gm-Message-State: AO0yUKVYaINJ2dOYs4z+qc00a0Mh/oZlVlOvrIXawAr8MENgnBgNTc1h
        FstvsNQrh5VWIULl2p+kIlL+2w==
X-Google-Smtp-Source: AK7set/N7Y0as6ZG7e/Zr/eUqDMvW3qUjjBSg83rJTcRExflVo3PK+MGY8qYLaQSIy2xQLkziGiVBQ==
X-Received: by 2002:ac8:7d88:0:b0:3b4:2b61:da32 with SMTP id c8-20020ac87d88000000b003b42b61da32mr36238315qtd.59.1676135899033;
        Sat, 11 Feb 2023 09:18:19 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id p73-20020a37424c000000b0072692330190sm5978113qka.64.2023.02.11.09.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 09:18:18 -0800 (PST)
Date:   Sat, 11 Feb 2023 17:18:17 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: Current LKMM patch disposition
Message-ID: <Y+fN2fvUjGDWBYrv@google.com>
References: <20230204004843.GA2677518@paulmck-ThinkPad-P17-Gen-1>
 <Y920w4QRLtC6kd+x@rowland.harvard.edu>
 <20230204014941.GS2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y95yhJgNq8lMXPdF@rowland.harvard.edu>
 <20230204222411.GC2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9+41ctA54pjm/KG@google.com>
 <Y+FJSzUoGTgReLPB@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+FJSzUoGTgReLPB@rowland.harvard.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 06, 2023 at 01:39:07PM -0500, Alan Stern wrote:
> On Sun, Feb 05, 2023 at 02:10:29PM +0000, Joel Fernandes wrote:
> > On Sat, Feb 04, 2023 at 02:24:11PM -0800, Paul E. McKenney wrote:
> > > On Sat, Feb 04, 2023 at 09:58:12AM -0500, Alan Stern wrote:
> > > > On Fri, Feb 03, 2023 at 05:49:41PM -0800, Paul E. McKenney wrote:
> > > > > On Fri, Feb 03, 2023 at 08:28:35PM -0500, Alan Stern wrote:
> > > > > > The "Provide exact semantics for SRCU" patch should have:
> > > > > > 
> > > > > > 	Portions suggested by Boqun Feng and Jonas Oberhauser.
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
> 
> Joel, would you like to write an extra paragraph of two for that file, 
> explaining in more detail how SRCU lock-to-unlock matching is different 
> from regular RCU and how the definition of the srcu-rscs relation works?  
> I'd be happy to edit anything you come up with.
> 

I am happy to make changes to explanation.txt (I am assuming that's the file
you mentioned), but I was wondering what you thought of the following change.
If the formulas are split up, that itself could be some documentation as
well. I did add a small paragraph on the top of the formulas as well though.

Some light testing shows it works with the cross-CPU litmus test (could still
have bugs though and needs more testing).

Let me know how you feel about it, and if I should submit something along
these lines along with your suggestion to edit the explanation.txt. Thanks!

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index ce068700939c..1390d1b8ceee 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -57,9 +57,28 @@ let rcu-rscs = let rec
 flag ~empty Rcu-lock \ domain(rcu-rscs) as unmatched-rcu-lock
 flag ~empty Rcu-unlock \ range(rcu-rscs) as unmatched-rcu-unlock
 
-(* Compute matching pairs of nested Srcu-lock and Srcu-unlock *)
-let carry-srcu-data = (data ; [~ Srcu-unlock] ; rf)*
-let srcu-rscs = ([Srcu-lock] ; carry-srcu-data ; data ; [Srcu-unlock]) & loc
+(* SRCU read-side section modeling
+ * Compute matching pairs of nested Srcu-lock and Srcu-unlock:
+ * Each SRCU read-side critical section is treated as independent, of other
+ * overlapping SRCU read-side critical sections even when on the same domain.
+ * For this, each Srcu-lock and Srcu-unlock pair is treated as loads and
+ * stores, with the data-dependency flow also treated as independent to prevent
+ * fusing. *)
+
+(* Data dependency between lock and idx store *)
+let srcu-lock-to-store-idx = ([Srcu-lock]; data)
+
+(* Data dependency between idx load and unlock *)
+let srcu-load-idx-to-unlock = (data; [Srcu-unlock])
+
+(* Read-from dependency between idx store on one CPU and load on same/another.
+ * This is required to model the splitting of critical section across CPUs. *)
+let srcu-store-to-load-idx = (rf ; srcu-load-idx-to-unlock)
+
+(* SRCU data dependency flow. Exclude the Srcu-unlock to not transcend back to back rscs *)
+let carry-srcu-data = (srcu-lock-to-store-idx ; [~ Srcu-unlock] ; srcu-store-to-load-idx)*
+
+let srcu-rscs = ([Srcu-lock] ; carry-srcu-data ; [Srcu-unlock]) & loc
 
 (* Validate nesting *)
 flag ~empty Srcu-lock \ domain(srcu-rscs) as unmatched-srcu-lock
-- 
2.39.1.581.gbfd45094c4-goog

