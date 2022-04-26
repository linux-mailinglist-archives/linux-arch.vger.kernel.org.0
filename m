Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A526E510A87
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 22:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354985AbiDZUgI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 16:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354988AbiDZUgH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 16:36:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031641A816F;
        Tue, 26 Apr 2022 13:32:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68AB461230;
        Tue, 26 Apr 2022 20:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF77FC385A0;
        Tue, 26 Apr 2022 20:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651005174;
        bh=y6FofLSikYDLr/NdPJbxqfXmtefk+7oqAIS6qhBPU7M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=efmcIrvf0Nxe1a6Q7awgDa+Ms6glT2vUQSBlr12Ze71Jm838snVl4zWjmQ9ti6nm/
         QvSUlF8zvLKZYKRWo2a1pXbBXgPLSmO0HUygeBo4h0Yj1cY1gv46xuiPTrLO3jD08q
         Qn59SOyqfsbLsAuWT2PXAWdYv5sYgRgPgZNZQbiBEw2PaDZ/mox0kCzTDQNmnim4JG
         KZBjQSKpwKWU0cAx+wF3KVvtUHy2PbX3yZO07Sx4t/+wf2kvF4Zj9xqMyS5bpjWLHg
         3YSbB2OlwyvRH/qqmr4oqKJTNAygZzQ/RJHpBjzq3T9RXCD1B9xxi3Zmqvl9yKf0UZ
         VMJQqjZSpqIdg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6A1195C038F; Tue, 26 Apr 2022 13:32:54 -0700 (PDT)
Date:   Tue, 26 Apr 2022 13:32:54 -0700
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
Message-ID: <20220426203254.GJ4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YmKE/XgmRnGKrBbB@Pauls-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YmKE/XgmRnGKrBbB@Pauls-MacBook-Pro.local>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 22, 2022 at 12:35:41PM +0200, Paul Heidekrüger wrote:
> Hi all, 
> 
> My dependency checker is flagging yet another broken dependency. For
> context, see [1].
> 
> Thankfully, it is fairly straight-forward to explain this time.
> 
> > stable_node = page_stable_node(page);
> 
> Line 2032 in mm/ksm.c::cmp_and_merge_page() sees the return value of a
> call to "page_stable_node()", which can depend on a "READ_ONCE()", being
> assigned to "stable_node".
> 
> > if (stable_node) {
> >         if (stable_node->head != &migrate_nodes &&
> >             get_kpfn_nid(READ_ONCE(stable_node->kpfn)) != 
> >             NUMA(stable_node->nid)) {
> >                 stable_node_dup_del(stable_node); ‣dup: stable_node
> >                 stable_node->head = &migrate_nodes;
> >                 list_add(&stable_node->list, stable_node->head);
> 
> The dependency chain then runs into the two following if's, through an
> assignment of "migrate_nodes" to "stable_node->head" (line 2038) and
> finally reaches a call to "list_add()" (line 2039) where
> "stable_node->head" gets passed as the second function argument. 

Huh.

But migrate_nodes is nothing more or less than a list_head structure.
So one would expect that some other mechanism is protecting its ->prev
and ->next pointers.

> >         }
> > }
> > 
> > static inline void list_add(struct list_head *new, struct list_head *head)
> > {
> >         __list_add(new, head, head->next);
> > }
> > 
> > static inline void __list_add(struct list_head *new,
> >                               struct list_head *prev,
> >                               struct list_head *next)
> > {
> >         if (!__list_add_valid(new, prev, next))
> >                 return;
> > 
> >         next->prev = new;
> >         new->next = next;
> >         new->prev = prev;
> >         WRITE_ONCE(prev->next, new);
> > }
> 
> By being passed into "list_add()" via "stable_node->head", the
> dependency chain eventually reaches a "WRITE_ONCE()" in "__list_add()"
> whose destination address, "stable_node->head->next", is part of the
> dependency chain and therefore carries an address dependency. 
> 
> However, as a result of the assignment in line 2038, Clang knows that
> "stable_node->head" is "migrate_nodes" and replaces it, thereby breaking
> the dependency chain. 
> 
> What do you think?

Given that this is a non-atomic update, there had better be something
protecting it.  This something might be a lock, a decremented-to-zero
reference count, a rule about only one kthread being permitted to update
that list, and so on.  In all such cases, the code would not be relying
on the dependency, but rather on whatever was protecting that operation.

Or am I missing something here?

							Thanx, Paul

> Many thanks,
> Paul
> 
> --
> [1]: https://lore.kernel.org/all/Yk7%2FT8BJITwz+Og1@Pauls-MacBook-Pro.local/
> 
