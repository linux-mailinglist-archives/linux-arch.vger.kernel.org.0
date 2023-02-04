Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB8268AAB6
	for <lists+linux-arch@lfdr.de>; Sat,  4 Feb 2023 15:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjBDO6R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 4 Feb 2023 09:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbjBDO6P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 4 Feb 2023 09:58:15 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id F1C33212BB
        for <linux-arch@vger.kernel.org>; Sat,  4 Feb 2023 06:58:13 -0800 (PST)
Received: (qmail 597198 invoked by uid 1000); 4 Feb 2023 09:58:12 -0500
Date:   Sat, 4 Feb 2023 09:58:12 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: Current LKMM patch disposition
Message-ID: <Y95yhJgNq8lMXPdF@rowland.harvard.edu>
References: <20230204004843.GA2677518@paulmck-ThinkPad-P17-Gen-1>
 <Y920w4QRLtC6kd+x@rowland.harvard.edu>
 <20230204014941.GS2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230204014941.GS2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 03, 2023 at 05:49:41PM -0800, Paul E. McKenney wrote:
> On Fri, Feb 03, 2023 at 08:28:35PM -0500, Alan Stern wrote:
> > On Fri, Feb 03, 2023 at 04:48:43PM -0800, Paul E. McKenney wrote:
> > > Hello!
> > > 
> > > Here is what I currently have for LKMM patches:
> > > 
> > > 289e1c89217d4 ("locking/memory-barriers.txt: Improve documentation for writel() example")
> > > ebd50e2947de9 ("tools: memory-model: Add rmw-sequences to the LKMM")
> > > aae0c8a50d6d3 ("Documentation: Fixed a typo in atomic_t.txt")
> > > 9ba7d3b3b826e ("tools: memory-model: Make plain accesses carry dependencies")
> > > 
> > > 	Queued for the upcoming (v6.3) merge window.
> > > 
> > > c7637e2a8a27 ("tools/memory-model: Update some warning labels")
> > > 7862199d4df2 ("tools/memory-model: Unify UNLOCK+LOCK pairings to po-unlock-lock-")
> > > 
> > > 	Are ready for the next (v6.4) merge window.  If there is some
> > > 	reason that they should instead go into v6.3, please let us
> > > 	all know.
> > > 
> > > a6cd5214b5ba ("tools/memory-model: Document LKMM test procedure")
> > > 
> > > 	This goes onto the lkmm-dev pile because it is documenting how
> > > 	to use those scripts.
> > > 
> > > https://lore.kernel.org/lkml/Y9GPVnK6lQbY6vCK@rowland.harvard.edu/
> > > https://lore.kernel.org/lkml/20230126134604.2160-3-jonas.oberhauser@huaweicloud.com
> > > https://lore.kernel.org/lkml/20230203201913.2555494-1-joel@joelfernandes.org/
> > > 5d871b280e7f ("tools/memory-model: Add smp_mb__after_srcu_read_unlock()")
> > > 
> > > 	These need review and perhaps further adjustment.
> > > 
> > > So, am I missing any?  Are there any that need to be redirected?
> > 
> > The "Provide exact semantics for SRCU" patch should have:
> > 
> > 	Portions suggested by Boqun Feng and Jonas Oberhauser.
> > 
> > added at the end, together with your Reported-by: tag.  With that, I 
> > think it can be queued for 6.4.
> 
> Thank you!  Does the patch shown below work for you?
> 
> (I have tentatively queued this, but can easily adjust or replace it.)

It looks fine.

Alan
