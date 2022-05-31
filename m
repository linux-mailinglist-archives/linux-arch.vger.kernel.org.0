Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897AF539021
	for <lists+linux-arch@lfdr.de>; Tue, 31 May 2022 13:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240105AbiEaL4F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 May 2022 07:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343989AbiEaL4F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 May 2022 07:56:05 -0400
X-Greylist: delayed 526 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 May 2022 04:56:03 PDT
Received: from mailout1.rbg.tum.de (mailout1.rbg.tum.de [131.159.0.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64491880EE;
        Tue, 31 May 2022 04:56:03 -0700 (PDT)
Received: from mailrelay1.rbg.tum.de (mailrelay1.in.tum.de [IPv6:2a09:80c0:254::14])
        by mailout1.rbg.tum.de (Postfix) with ESMTPS id 63DF0240;
        Tue, 31 May 2022 13:47:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.tum.de;
        s=20220209; t=1653997635;
        bh=9J6pD/CrhjbB1zdbQ/WsFZ5sMWMLDeoTX+MCbCnhM20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cbtV7Ux4Fjo7XMm8Siy+aAHS0F7ijcSiKuOkoUZl1H66Y8YKUS3OfsisbgqKOcoaP
         Rc8ueYVPuPaM0T3vWaB8tI7J2PhsbzPYyLFxbsE5yHOz0cbZRXkvuVpLAqmFe+QjVd
         n/7BRKH7W8E/9Ih3kr8GqvdB4iBw5L1x/GvTBdzh8v/zLtIOEM+wn0LULECYQJ4V0h
         KGuQRJir2lWVFmmwkL7bVLCWhVrTjipBgZlE75zZW3GqWrGhnXGnAfO9P0nJpv3yNk
         RJwtOCkYp1NWhhoack46VVvitEdBldy05j1e7CgmIBzB/jF9ADwigRutNUlVSkNhkM
         BfOjo0+XbmJ3Q==
Received: by mailrelay1.rbg.tum.de (Postfix, from userid 112)
        id 6036B28B; Tue, 31 May 2022 13:47:15 +0200 (CEST)
Received: from mailrelay1.rbg.tum.de (localhost [127.0.0.1])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTP id 3220328A;
        Tue, 31 May 2022 13:47:15 +0200 (CEST)
Received: from mail.in.tum.de (vmrbg426.in.tum.de [131.159.0.73])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTPS id 2DE75286;
        Tue, 31 May 2022 13:47:15 +0200 (CEST)
Received: by mail.in.tum.de (Postfix, from userid 112)
        id 29CBB4A038D; Tue, 31 May 2022 13:47:15 +0200 (CEST)
Received: (Authenticated sender: heidekrp)
        by mail.in.tum.de (Postfix) with ESMTPSA id 4ED874A0367;
        Tue, 31 May 2022 13:47:14 +0200 (CEST)
        (Extended-Queue-bit xtech_rq@fff.in.tum.de)
Date:   Tue, 31 May 2022 13:47:12 +0200
From:   Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <YpYAQLi296UFEdTH@ethstick13.dse.in.tum.de>
References: <YmKE/XgmRnGKrBbB@Pauls-MacBook-Pro.local>
 <20220426203254.GJ4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220426203254.GJ4285@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 26, 2022 at 01:32:54PM -0700, Paul E. McKenney wrote:
> On Fri, Apr 22, 2022 at 12:35:41PM +0200, Paul Heidekrüger wrote:
> > Hi all, 
> > 
> > My dependency checker is flagging yet another broken dependency. For
> > context, see [1].
> > 
> > Thankfully, it is fairly straight-forward to explain this time.
> > 
> > > stable_node = page_stable_node(page);
> > 
> > Line 2032 in mm/ksm.c::cmp_and_merge_page() sees the return value of a
> > call to "page_stable_node()", which can depend on a "READ_ONCE()", being
> > assigned to "stable_node".
> > 
> > > if (stable_node) {
> > >         if (stable_node->head != &migrate_nodes &&
> > >             get_kpfn_nid(READ_ONCE(stable_node->kpfn)) != 
> > >             NUMA(stable_node->nid)) {
> > >                 stable_node_dup_del(stable_node); ‣dup: stable_node
> > >                 stable_node->head = &migrate_nodes;
> > >                 list_add(&stable_node->list, stable_node->head);
> > 
> > The dependency chain then runs into the two following if's, through an
> > assignment of "migrate_nodes" to "stable_node->head" (line 2038) and
> > finally reaches a call to "list_add()" (line 2039) where
> > "stable_node->head" gets passed as the second function argument. 
> 
> Huh.
> 
> But migrate_nodes is nothing more or less than a list_head structure.
> So one would expect that some other mechanism is protecting its ->prev
> and ->next pointers.
> 
> > >         }
> > > }
> > > 
> > > static inline void list_add(struct list_head *new, struct list_head *head)
> > > {
> > >         __list_add(new, head, head->next);
> > > }
> > > 
> > > static inline void __list_add(struct list_head *new,
> > >                               struct list_head *prev,
> > >                               struct list_head *next)
> > > {
> > >         if (!__list_add_valid(new, prev, next))
> > >                 return;
> > > 
> > >         next->prev = new;
> > >         new->next = next;
> > >         new->prev = prev;
> > >         WRITE_ONCE(prev->next, new);
> > > }
> > 
> > By being passed into "list_add()" via "stable_node->head", the
> > dependency chain eventually reaches a "WRITE_ONCE()" in "__list_add()"
> > whose destination address, "stable_node->head->next", is part of the
> > dependency chain and therefore carries an address dependency. 
> > 
> > However, as a result of the assignment in line 2038, Clang knows that
> > "stable_node->head" is "migrate_nodes" and replaces it, thereby breaking
> > the dependency chain. 
> > 
> > What do you think?
> 
> Given that this is a non-atomic update, there had better be something
> protecting it.  This something might be a lock, a decremented-to-zero
> reference count, a rule about only one kthread being permitted to update
> that list, and so on.  In all such cases, the code would not be relying
> on the dependency, but rather on whatever was protecting that operation.
> 
> Or am I missing something here?

Nope, missing nothing, that was exactly it!

In ksm_scan_thread(), which calls ksm_do_scan(), which calls
cmp_and_merge_page(), there is a mutex_lock() / mutex_unlock() pair,
surrounding the dependency. 

Still keeping this as a trophy for our dependency checker though ;-)

Many thanks,
Paul

PS Sorry for the late reply - been distracted ..

> 
> 							Thanx, Paul
> 
> > Many thanks,
> > Paul
> > 
> > --
> > [1]: https://lore.kernel.org/all/Yk7%2FT8BJITwz+Og1@Pauls-MacBook-Pro.local/
> > 
