Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3622268B035
	for <lists+linux-arch@lfdr.de>; Sun,  5 Feb 2023 15:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjBEOKf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Feb 2023 09:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBEOKe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Feb 2023 09:10:34 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1D41F91D
        for <linux-arch@vger.kernel.org>; Sun,  5 Feb 2023 06:10:31 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id v17so10319632qto.3
        for <linux-arch@vger.kernel.org>; Sun, 05 Feb 2023 06:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKsSW9ZG5fFUmNf5T3NRxiYqTsIJdtp7qpj0pS2GhFo=;
        b=dLh+VQMbBIyiU/DMry7xrtj8On3fwaG8ih2S8RCKlZThibDfHUn4U5LfDLBzHekdKQ
         lUU7YTpn1oHoYNXafeIf2Vl3mUEulf5QaDE42vOHlfiIhLu/0DRfU9Bp9yFhHVX4zUEB
         cxYbPREAP1JhbArUe4MlX/dr5MnYrVEeo1G5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKsSW9ZG5fFUmNf5T3NRxiYqTsIJdtp7qpj0pS2GhFo=;
        b=ftuA0RdDbosperFrmH7IGDOcS/yzN0N67sDppJIvFl/wYrBX2uJRTSJBl3ubFjjfWR
         hi5ZtDAnP1nfmQDTBubk0beZtgUF09oYWqpmK3qsmIZoH5oimIHtqCM7gpFwvOU8mv3/
         GTJB4jZR+RQcTkdbGTgZPKacVqhVl/z1qieIpOYXmFjYNUlSv2n6u9cPfFy55TqUR5hZ
         trPAdo9Rt2jPePja7naV8pU1WOYY3AUG7uhce/sF7Wc7yO11MHQTlVkd8m1yuR7zIlRF
         kWc8awI1IYUZDfJfIYKuWJ7z1mA4RaS+BRfNafYZY9lvnlJPCzgzHoyqcPZKP2gHiOPy
         TLfg==
X-Gm-Message-State: AO0yUKWNo3Ro9lP0FQWqHlBiIV9PsIhcGcsbecjpt7MwG8/F2f2ugqjR
        muZSCWHuDS9rZ7mn44wGnrjxZQ==
X-Google-Smtp-Source: AK7set+KGtTqrROhHpXhHntLnNqEQuTZZihoLrqI35niiPfztaoQM1WQ7kN1kzu+JN3rQY4Qw8tWgA==
X-Received: by 2002:ac8:5c55:0:b0:3b6:359f:39e5 with SMTP id j21-20020ac85c55000000b003b6359f39e5mr34367311qtj.49.1675606230829;
        Sun, 05 Feb 2023 06:10:30 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id d2-20020a05620a204200b0071f0d0aaef7sm5564101qka.80.2023.02.05.06.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 06:10:30 -0800 (PST)
Date:   Sun, 5 Feb 2023 14:10:29 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: Current LKMM patch disposition
Message-ID: <Y9+41ctA54pjm/KG@google.com>
References: <20230204004843.GA2677518@paulmck-ThinkPad-P17-Gen-1>
 <Y920w4QRLtC6kd+x@rowland.harvard.edu>
 <20230204014941.GS2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y95yhJgNq8lMXPdF@rowland.harvard.edu>
 <20230204222411.GC2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230204222411.GC2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 04, 2023 at 02:24:11PM -0800, Paul E. McKenney wrote:
> On Sat, Feb 04, 2023 at 09:58:12AM -0500, Alan Stern wrote:
> > On Fri, Feb 03, 2023 at 05:49:41PM -0800, Paul E. McKenney wrote:
> > > On Fri, Feb 03, 2023 at 08:28:35PM -0500, Alan Stern wrote:
> > > > On Fri, Feb 03, 2023 at 04:48:43PM -0800, Paul E. McKenney wrote:
> > > > > Hello!
> > > > > 
> > > > > Here is what I currently have for LKMM patches:
> > > > > 
> > > > > 289e1c89217d4 ("locking/memory-barriers.txt: Improve documentation for writel() example")
> > > > > ebd50e2947de9 ("tools: memory-model: Add rmw-sequences to the LKMM")
> > > > > aae0c8a50d6d3 ("Documentation: Fixed a typo in atomic_t.txt")
> > > > > 9ba7d3b3b826e ("tools: memory-model: Make plain accesses carry dependencies")
> > > > > 
> > > > > 	Queued for the upcoming (v6.3) merge window.
> > > > > 
> > > > > c7637e2a8a27 ("tools/memory-model: Update some warning labels")
> > > > > 7862199d4df2 ("tools/memory-model: Unify UNLOCK+LOCK pairings to po-unlock-lock-")
> > > > > 
> > > > > 	Are ready for the next (v6.4) merge window.  If there is some
> > > > > 	reason that they should instead go into v6.3, please let us
> > > > > 	all know.
> > > > > 
> > > > > a6cd5214b5ba ("tools/memory-model: Document LKMM test procedure")
> > > > > 
> > > > > 	This goes onto the lkmm-dev pile because it is documenting how
> > > > > 	to use those scripts.
> > > > > 
> > > > > https://lore.kernel.org/lkml/Y9GPVnK6lQbY6vCK@rowland.harvard.edu/
> > > > > https://lore.kernel.org/lkml/20230126134604.2160-3-jonas.oberhauser@huaweicloud.com
> > > > > https://lore.kernel.org/lkml/20230203201913.2555494-1-joel@joelfernandes.org/
> > > > > 5d871b280e7f ("tools/memory-model: Add smp_mb__after_srcu_read_unlock()")
> > > > > 
> > > > > 	These need review and perhaps further adjustment.
> > > > > 
> > > > > So, am I missing any?  Are there any that need to be redirected?
> > > > 
> > > > The "Provide exact semantics for SRCU" patch should have:
> > > > 
> > > > 	Portions suggested by Boqun Feng and Jonas Oberhauser.
> > > > 
> > > > added at the end, together with your Reported-by: tag.  With that, I 
> > > > think it can be queued for 6.4.
> > > 
> > > Thank you!  Does the patch shown below work for you?
> > > 
> > > (I have tentatively queued this, but can easily adjust or replace it.)
> > 
> > It looks fine.
> 
> Very good, thank you for looking it over!  I pushed it out on branch
> stern.2023.02.04a.
> 
> Would anyone like to ack/review/whatever this one?

Would it be possible to add comments, something like the following? Apologies
if it is missing some ideas. I will try to improve it later.

thanks!

 - Joel

---8<-----------------------

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index ce068700939c..0a16177339bc 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -57,7 +57,23 @@ let rcu-rscs = let rec
 flag ~empty Rcu-lock \ domain(rcu-rscs) as unmatched-rcu-lock
 flag ~empty Rcu-unlock \ range(rcu-rscs) as unmatched-rcu-unlock
 
+(***************************************************************)
 (* Compute matching pairs of nested Srcu-lock and Srcu-unlock *)
+(***************************************************************)
+(*
+ * carry-srcu-data: To handle the case of the SRCU critical section split
+ * across CPUs, where the idx is used to communicate the SRCU index across CPUs
+ * (say CPU0 and CPU1), data is between the R[srcu-lock] to W[once][idx] on
+ * CPU0, which is sequenced with the ->rf is between the W[once][idx] and the
+ * R[once][idx] on CPU1.  The carry-srcu-data is made to exclude Srcu-unlock
+ * events to prevent capturing accesses across back-to-back SRCU read-side
+ * critical sections.
+ *
+ * srcu-rscs: Putting everything together, the carry-srcu-data is sequenced with
+ * a data relation, which is the data dependency between R[once][idx] on CPU1
+ * and the srcu-unlock store, and loc ensures the relation is unique for a
+ * specific lock.
+ *)
 let carry-srcu-data = (data ; [~ Srcu-unlock] ; rf)*
 let srcu-rscs = ([Srcu-lock] ; carry-srcu-data ; data ; [Srcu-unlock]) & loc
 
