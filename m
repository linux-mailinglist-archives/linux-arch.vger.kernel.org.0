Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CE2539385
	for <lists+linux-arch@lfdr.de>; Tue, 31 May 2022 17:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245057AbiEaPDP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 May 2022 11:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245030AbiEaPDO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 May 2022 11:03:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD615986CE;
        Tue, 31 May 2022 08:03:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D30A6023F;
        Tue, 31 May 2022 15:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E20C385A9;
        Tue, 31 May 2022 15:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654009392;
        bh=m0jg7/GG/1GqctpKJeTLM1iJ6iRQvTeTBHHJu4GUHlQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=n8RzKOwPBEZvK6mSHWVlzIZlgvI6medx09sZwG9C1J0Dd9D0cwCgGYslMXDwq69Fq
         W82WU5oWShwWTPYwV75gwihPKeZy2GM9nTYYtpird0HFGJP43fcrmm2jlOzpI5NLme
         oaO8hbhD4Piyym0t0lGmmZnibACUaLtS80x1zt3Ji6PWjHmgBpdjSR9flsTRL/F4Uy
         sSHnDMDwPDVDabzPC3v7agPny65kOXEVR6EYe955cUTmZUtD52DwG95ZQ8MpGf6EE3
         XMvTAW9AcBW//Nudwab9zLqKd7j3vkUz6nW/Fry7k6IrJ22bUuG2Ko0+6jkm2vHYlr
         GE+3c9oF9ba4A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 461255C02A9; Tue, 31 May 2022 08:03:12 -0700 (PDT)
Date:   Tue, 31 May 2022 08:03:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        llvm@lists.linux.dev, Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>,
        Soham Shakraborty <s.s.chakraborty@tudelft.nl>,
        Martin Fink <martin.fink@in.tum.de>
Subject: Re: Broken Address Dependency in mm/ksm.c::cmp_and_merge_page()
Message-ID: <20220531150312.GH1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YmKE/XgmRnGKrBbB@Pauls-MacBook-Pro.local>
 <20220426203254.GJ4285@paulmck-ThinkPad-P17-Gen-1>
 <YpYAQLi296UFEdTH@ethstick13.dse.in.tum.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YpYAQLi296UFEdTH@ethstick13.dse.in.tum.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 31, 2022 at 01:47:12PM +0200, Paul Heidekrüger wrote:
> On Tue, Apr 26, 2022 at 01:32:54PM -0700, Paul E. McKenney wrote:
> > On Fri, Apr 22, 2022 at 12:35:41PM +0200, Paul Heidekrüger wrote:
> > > Hi all, 
> > > 
> > > My dependency checker is flagging yet another broken dependency. For
> > > context, see [1].
> > > 
> > > Thankfully, it is fairly straight-forward to explain this time.
> > > 
> > > > stable_node = page_stable_node(page);
> > > 
> > > Line 2032 in mm/ksm.c::cmp_and_merge_page() sees the return value of a
> > > call to "page_stable_node()", which can depend on a "READ_ONCE()", being
> > > assigned to "stable_node".
> > > 
> > > > if (stable_node) {
> > > >         if (stable_node->head != &migrate_nodes &&
> > > >             get_kpfn_nid(READ_ONCE(stable_node->kpfn)) != 
> > > >             NUMA(stable_node->nid)) {
> > > >                 stable_node_dup_del(stable_node); ‣dup: stable_node
> > > >                 stable_node->head = &migrate_nodes;
> > > >                 list_add(&stable_node->list, stable_node->head);
> > > 
> > > The dependency chain then runs into the two following if's, through an
> > > assignment of "migrate_nodes" to "stable_node->head" (line 2038) and
> > > finally reaches a call to "list_add()" (line 2039) where
> > > "stable_node->head" gets passed as the second function argument. 
> > 
> > Huh.
> > 
> > But migrate_nodes is nothing more or less than a list_head structure.
> > So one would expect that some other mechanism is protecting its ->prev
> > and ->next pointers.
> > 
> > > >         }
> > > > }
> > > > 
> > > > static inline void list_add(struct list_head *new, struct list_head *head)
> > > > {
> > > >         __list_add(new, head, head->next);
> > > > }
> > > > 
> > > > static inline void __list_add(struct list_head *new,
> > > >                               struct list_head *prev,
> > > >                               struct list_head *next)
> > > > {
> > > >         if (!__list_add_valid(new, prev, next))
> > > >                 return;
> > > > 
> > > >         next->prev = new;
> > > >         new->next = next;
> > > >         new->prev = prev;
> > > >         WRITE_ONCE(prev->next, new);
> > > > }
> > > 
> > > By being passed into "list_add()" via "stable_node->head", the
> > > dependency chain eventually reaches a "WRITE_ONCE()" in "__list_add()"
> > > whose destination address, "stable_node->head->next", is part of the
> > > dependency chain and therefore carries an address dependency. 
> > > 
> > > However, as a result of the assignment in line 2038, Clang knows that
> > > "stable_node->head" is "migrate_nodes" and replaces it, thereby breaking
> > > the dependency chain. 
> > > 
> > > What do you think?
> > 
> > Given that this is a non-atomic update, there had better be something
> > protecting it.  This something might be a lock, a decremented-to-zero
> > reference count, a rule about only one kthread being permitted to update
> > that list, and so on.  In all such cases, the code would not be relying
> > on the dependency, but rather on whatever was protecting that operation.
> > 
> > Or am I missing something here?
> 
> Nope, missing nothing, that was exactly it!
> 
> In ksm_scan_thread(), which calls ksm_do_scan(), which calls
> cmp_and_merge_page(), there is a mutex_lock() / mutex_unlock() pair,
> surrounding the dependency. 

Whew!!!  ;-)

> Still keeping this as a trophy for our dependency checker though ;-)

As well you should!

							Thanx, Paul

> Many thanks,
> Paul
> 
> PS Sorry for the late reply - been distracted ..
> 
> > 
> > 							Thanx, Paul
> > 
> > > Many thanks,
> > > Paul
> > > 
> > > --
> > > [1]: https://lore.kernel.org/all/Yk7%2FT8BJITwz+Og1@Pauls-MacBook-Pro.local/
> > > 
