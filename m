Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B13B669C30
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jan 2023 16:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjAMP3s (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Jan 2023 10:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjAMP22 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Jan 2023 10:28:28 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id C4E9088A34
        for <linux-arch@vger.kernel.org>; Fri, 13 Jan 2023 07:22:21 -0800 (PST)
Received: (qmail 22532 invoked by uid 1000); 13 Jan 2023 10:22:20 -0500
Date:   Fri, 13 Jan 2023 10:22:20 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@tum.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <Y8F3LMlTnT5ZtVTq@rowland.harvard.edu>
References: <YmKE/XgmRnGKrBbB@Pauls-MacBook-Pro.local>
 <20220426203254.GJ4285@paulmck-ThinkPad-P17-Gen-1>
 <YpYAQLi296UFEdTH@ethstick13.dse.in.tum.de>
 <20220531150312.GH1790663@paulmck-ThinkPad-P17-Gen-1>
 <0EC00B0E-554A-4BF3-B012-ED1E36B12FD1@tum.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0EC00B0E-554A-4BF3-B012-ED1E36B12FD1@tum.de>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 13, 2023 at 12:11:25PM +0100, Paul Heidekrüger wrote:
> Hi all,
> 
> FWIW, here are two more broken address dependencies, both very similar to the
> one discussed in this thread. From what I can tell, both are protected by a
> lock, so, again, nothing to worry about right now? Would you agree?

FWIW, my opinion is that in both cases the broken dependency can be 
removed entirely.

> Comments marked with "AD:" were added by me for readability.
> 
> 1. drivers/hwtracing/stm/core.c::1050 - 1085
> 
>         /**
>          * __stm_source_link_drop() - detach stm_source from an stm device
>          * @src:	stm_source device
>          * @stm:	stm device
>          *
>          * If @stm is @src::link, disconnect them from one another and put the
>          * reference on the @stm device.
>          *
>          * Caller must hold stm::link_mutex.
>          */
>         static int __stm_source_link_drop(struct stm_source_device *src,
>                                           struct stm_device *stm)
>         {
>                 struct stm_device *link;
>                 int ret = 0;
> 
>                 lockdep_assert_held(&stm->link_mutex);
> 
>                 /* for stm::link_list modification, we hold both mutex and spinlock */
>                 spin_lock(&stm->link_lock);
>                 spin_lock(&src->link_lock);
> 
>                 /* AD: Beginning of the address dependency. */
>                 link = srcu_dereference_check(src->link, &stm_source_srcu, 1);
> 
>                 /*
>                  * The linked device may have changed since we last looked, because
>                  * we weren't holding the src::link_lock back then; if this is the
>                  * case, tell the caller to retry.
>                  */
>                 if (link != stm) {
>                         ret = -EAGAIN;
>                         goto unlock;
>                 }
> 
>                 /* AD: Compiler deduces that "link" and "stm" are exchangeable at this point. */
>                 stm_output_free(link, &src->output); list_del_init(&src->link_entry);
> 
>                 /* AD: Leads to WRITE_ONCE() to (&link->dev)->power.last_busy. */
>                 pm_runtime_mark_last_busy(&link->dev);

In both of these statements, link can safely be replaced by stm.

(There's also a control dependency which the LKMM isn't aware of.  This 
makes it all the more safe.)

> 2. kernel/locking/lockdep.c::6319 - 6348
> 
>         /*
>          * Unregister a dynamically allocated key.
>          *
>          * Unlike lockdep_register_key(), a search is always done to find a matching
>          * key irrespective of debug_locks to avoid potential invalid access to freed
>          * memory in lock_class entry.
>          */
>         void lockdep_unregister_key(struct lock_class_key *key)
>         {
>                 struct hlist_head *hash_head = keyhashentry(key);
>                 struct lock_class_key *k;
>                 struct pending_free *pf;
>                 unsigned long flags;
>                 bool found = false;
> 
>                 might_sleep();
> 
>                 if (WARN_ON_ONCE(static_obj(key)))
>                         return;
> 
>                 raw_local_irq_save(flags);
>                 lockdep_lock();
> 
>                 /* AD: Address dependency begins here with an rcu_dereference_raw() into k. */
>                 hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
>                         /* AD: Compiler deduces that k and key are exchangable iff the if condition evaluates to true.
>                         if (k == key) {
>                                 /* AD: Leads to WRITE_ONCE() to (&k->hash_entry)->pprev. */
>                                 hlist_del_rcu(&k->hash_entry);

And here k could safely be replaced with key.  (And again there is a 
control dependency, but this is one that the LKMM would detect.)

Alan Stern

>                                 found = true;
>                                 break;
>                         }
>                 }
> 
> Many thanks,
> Paul
