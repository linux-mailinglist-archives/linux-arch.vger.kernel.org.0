Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D436695CB
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jan 2023 12:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241219AbjAMLkA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Jan 2023 06:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240229AbjAMLjK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Jan 2023 06:39:10 -0500
X-Greylist: delayed 601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 Jan 2023 03:30:14 PST
Received: from postout2.mail.lrz.de (postout2.mail.lrz.de [IPv6:2001:4ca0:0:103::81bb:ff8a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345843E874;
        Fri, 13 Jan 2023 03:30:12 -0800 (PST)
Received: from lxmhs52.srv.lrz.de (localhost [127.0.0.1])
        by postout2.mail.lrz.de (Postfix) with ESMTP id 4Ntdyl3jpFzyTf;
        Fri, 13 Jan 2023 12:11:27 +0100 (CET)
Authentication-Results: postout.lrz.de (amavisd-new); dkim=pass (2048-bit key)
        reason="pass (just generated, assumed good)" header.d=tum.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tum.de; h=
        content-type:content-type:mime-version:references:in-reply-to
        :message-id:x-mailer:date:date:subject:subject:from:from
        :received:received; s=tu-postout21; t=1673608287; bh=P8InxNefme9
        obWDMap1ZRiAF5zKZ+lI2Q+l+08SR/j8=; b=d/gCb3D/iWS2JQAQLM36NnJKENo
        8k1Qwb6s3U69BRqpL6Q6wydpBYEvG522owGIO+FgY/BMmT0zagJn+iqlHuGiraIz
        yhEaT2LXxaRw6qVPxaJA7JB9p82JmX8OIsmE4gwGra9khENOa00TDywyzQYrmq81
        AU1Lpr+Z3T5SsLmR19nK2wsE6DEESVkKGGhCySGshl4D/rGhP67CjylOC/+ZWBlk
        K1ExXy9FfBBcFWWZWLVeLuQ1Hf0DWxnCDUwaw6KkHY74sJ7thwvhun1eDtPWouOC
        o42ACwa+2orM1pUmVSBAaTBVNSUttZCiyY3WAWBtacyCSV33Cwgla3mLUiQ==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs52.srv.lrz.de
X-Spam-Score: -2.876
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from postout2.mail.lrz.de ([127.0.0.1])
        by lxmhs52.srv.lrz.de (lxmhs52.srv.lrz.de [127.0.0.1]) (amavisd-new, port 20024)
        with LMTP id twqBvrLsvW7L; Fri, 13 Jan 2023 12:11:27 +0100 (CET)
Received: from [131.159.38.35] (unknown [IPv6:2a09:80c0:192:0:ed85:b6c:e76c:b9f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by postout2.mail.lrz.de (Postfix) with ESMTPSA id 4Ntdyk2rYBzySS;
        Fri, 13 Jan 2023 12:11:26 +0100 (CET)
From:   =?utf-8?q?Paul_Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>
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
Date:   Fri, 13 Jan 2023 12:11:25 +0100
X-Mailer: MailMate (1.14r5918)
Message-ID: <0EC00B0E-554A-4BF3-B012-ED1E36B12FD1@tum.de>
In-Reply-To: <20220531150312.GH1790663@paulmck-ThinkPad-P17-Gen-1>
References: <YmKE/XgmRnGKrBbB@Pauls-MacBook-Pro.local>
 <20220426203254.GJ4285@paulmck-ThinkPad-P17-Gen-1>
 <YpYAQLi296UFEdTH@ethstick13.dse.in.tum.de>
 <20220531150312.GH1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

FWIW, here are two more broken address dependencies, both very similar to the
one discussed in this thread. From what I can tell, both are protected by a
lock, so, again, nothing to worry about right now? Would you agree?

Comments marked with "AD:" were added by me for readability.

1. drivers/hwtracing/stm/core.c::1050 - 1085

        /**
         * __stm_source_link_drop() - detach stm_source from an stm device
         * @src:	stm_source device
         * @stm:	stm device
         *
         * If @stm is @src::link, disconnect them from one another and put the
         * reference on the @stm device.
         *
         * Caller must hold stm::link_mutex.
         */
        static int __stm_source_link_drop(struct stm_source_device *src,
                                          struct stm_device *stm)
        {
                struct stm_device *link;
                int ret = 0;

                lockdep_assert_held(&stm->link_mutex);

                /* for stm::link_list modification, we hold both mutex and spinlock */
                spin_lock(&stm->link_lock);
                spin_lock(&src->link_lock);

                /* AD: Beginning of the address dependency. */
                link = srcu_dereference_check(src->link, &stm_source_srcu, 1);

                /*
                 * The linked device may have changed since we last looked, because
                 * we weren't holding the src::link_lock back then; if this is the
                 * case, tell the caller to retry.
                 */
                if (link != stm) {
                        ret = -EAGAIN;
                        goto unlock;
                }

                /* AD: Compiler deduces that "link" and "stm" are exchangeable at this point. */
                stm_output_free(link, &src->output); list_del_init(&src->link_entry);

                /* AD: Leads to WRITE_ONCE() to (&link->dev)->power.last_busy. */
                pm_runtime_mark_last_busy(&link->dev);

2. kernel/locking/lockdep.c::6319 - 6348

        /*
         * Unregister a dynamically allocated key.
         *
         * Unlike lockdep_register_key(), a search is always done to find a matching
         * key irrespective of debug_locks to avoid potential invalid access to freed
         * memory in lock_class entry.
         */
        void lockdep_unregister_key(struct lock_class_key *key)
        {
                struct hlist_head *hash_head = keyhashentry(key);
                struct lock_class_key *k;
                struct pending_free *pf;
                unsigned long flags;
                bool found = false;

                might_sleep();

                if (WARN_ON_ONCE(static_obj(key)))
                        return;

                raw_local_irq_save(flags);
                lockdep_lock();

                /* AD: Address dependency begins here with an rcu_dereference_raw() into k. */
                hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
                        /* AD: Compiler deduces that k and key are exchangable iff the if condition evaluates to true.
                        if (k == key) {
                                /* AD: Leads to WRITE_ONCE() to (&k->hash_entry)->pprev. */
                                hlist_del_rcu(&k->hash_entry);
                                found = true;
                                break;
                        }
                }

Many thanks,
Paul
