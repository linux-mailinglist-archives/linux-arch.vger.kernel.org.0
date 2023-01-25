Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF4867BD18
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jan 2023 21:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbjAYUk7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Jan 2023 15:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbjAYUks (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jan 2023 15:40:48 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BDA5DC1F;
        Wed, 25 Jan 2023 12:40:23 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id x5so17117269qti.3;
        Wed, 25 Jan 2023 12:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TbYtMBxWJl7HpH4aniDM9ZTHtsKnBM7hjRN8LJEWG5U=;
        b=SkX9TEr3sg3dy87SAvWq8DIz54ZpEt00ln13tm3rnhMcBSkDncjNjyjopwu55pkOkW
         wB/A5QfPb+K/SfXxLsM+zITxPTeERnRpAZqKDxNCbQTYKQ3fqdckGXVhU6xzy4Ttq32n
         EbEFtmNq921vBglrens74rrOpNelQGwVidJGqKutmnVPTHP3+QHkRUJesYNTvPlAAlNf
         whrlP5ijRbEuN5F7vInqOcBvgJ07xH/d/FY1sY4ve+VTERMoGH7dlC+unRv/rHeRC6Sd
         jjA2SUXivg3KJTQ1ppahckzJbOJZtGRN+a4usNCdBBJMfr723331Ii/Th9Ssr+T9mf8p
         R2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TbYtMBxWJl7HpH4aniDM9ZTHtsKnBM7hjRN8LJEWG5U=;
        b=l+Eo3o5p4DwClxqVWZ9A17wqkulMZqm47bADuU8i9vM9RStwejeD1T0PE/qRL2B6nR
         GANs681Kp/7AUzLRLPZtVbhV7BlJeQD9Uumngtac5irZFnFLkUu1dfxDbstiVw7IX+aR
         1rTvwSvhId6wE7o/4IipIeUrZEO6Kh4xoaQ5lO5nyzDqGj5IPRezAjn/JPkdhpOLjMjb
         kbj0Etj46MUNZGEwEQKgy4OHHWffnXDsvA+CFUO1ISzMSFsjHX5DAUfO8NIx4ltXWGsY
         z6qaKbYK/tbMhghplTicQRdO9HCMpDcUCtVPhzi1nDv/jAILqP6OVJjugQdj38VFCJJK
         x+cQ==
X-Gm-Message-State: AFqh2krSpW8ecKutnBEOsi8ngXqK3exKauTeijKfNieKgNQ3qRM2mqyv
        25cLYiC+f+3pztuy/3+ov2XBnjzD7oQ=
X-Google-Smtp-Source: AMrXdXuFfJ7DtS0nw+1SzLJ987RhPcov55CYCRP5qlLRxSV17/tCRMv6yE0Nt0iKhUpCqmPZyh/ZFw==
X-Received: by 2002:ac8:41c7:0:b0:3b6:3042:277a with SMTP id o7-20020ac841c7000000b003b63042277amr42953916qtm.12.1674679214078;
        Wed, 25 Jan 2023 12:40:14 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id x11-20020a05620a098b00b007055dce4cecsm4100016qkx.97.2023.01.25.12.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:40:13 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id AF8AE27C005B;
        Wed, 25 Jan 2023 15:40:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 25 Jan 2023 15:40:12 -0500
X-ME-Sender: <xms:q5PRY_l7JY8FvysGIoGGWKO4YIxkXtYzy3JqA5l5veQtCPiUc7c07A>
    <xme:q5PRYy2b2R-B0UVxLWQSmSmPkwYd3n6ftAyXXlyoFLDa8BtMzmH-8k6pR9_tYOCt2
    ZJOscQPLHmrVdfGsQ>
X-ME-Received: <xmr:q5PRY1rY7RuzcvgR7s-tw13iY_ZXp8o7L0ASdkhOxVNGAj1VypqS_S9esXc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvvddgudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepueho
    qhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpedtgeehleevffdujeffgedvlefghffhleekieeifeegveetjedvgeev
    ueffieehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeeh
    tdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmse
    hfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:q5PRY3lmgViXOGsu1v2Ci0XXvrwExFGeDK-TmilSZjBlcXv3lOaKiQ>
    <xmx:q5PRY90b-ZL8cnKz4m8yxUYF2U97SCf47Dfvhra2UQyn8EnxKb_a6Q>
    <xmx:q5PRY2sHvDnQT3I_uTPl48iN5hsfovfsXolY-zIfNI_Kr66_-d2a6A>
    <xmx:rJPRY-ecmjsMiy3M6GeV2MTcdjWkVgZ8Lm3wrmqCkSGmiAXe5rbJjg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jan 2023 15:40:11 -0500 (EST)
Date:   Wed, 25 Jan 2023 12:39:29 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@tum.de>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Martin Fink <martin.fink@in.tum.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>
Subject: Re: Broken Address Dependency in mm/ksm.c::cmp_and_merge_page()
Message-ID: <Y9GTgdMnGu6OxUZC@boqun-archlinux>
References: <YmKE/XgmRnGKrBbB@Pauls-MacBook-Pro.local>
 <20220426203254.GJ4285@paulmck-ThinkPad-P17-Gen-1>
 <YpYAQLi296UFEdTH@ethstick13.dse.in.tum.de>
 <20220531150312.GH1790663@paulmck-ThinkPad-P17-Gen-1>
 <0EC00B0E-554A-4BF3-B012-ED1E36B12FD1@tum.de>
 <Y8F3LMlTnT5ZtVTq@rowland.harvard.edu>
 <9E7A62DD-D5DC-4B9C-A592-1A626482563B@tum.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9E7A62DD-D5DC-4B9C-A592-1A626482563B@tum.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

[Cc Rust-for-Linux folks]

No hurries but is your tool avaiable somewhere so that we can have a
try.

Although Rust doesn't support dependencies ordering, but it's good to
know which dependency is reserved after optimization. 

Regards,
Boqun

On Wed, Jan 18, 2023 at 11:42:23AM +0100, Paul Heidekrüger wrote:
> On 13 Jan 2023, at 16:22, Alan Stern wrote:
> 
> > On Fri, Jan 13, 2023 at 12:11:25PM +0100, Paul Heidekrüger wrote:
> >> Hi all,
> >>
> >> FWIW, here are two more broken address dependencies, both very similar to the
> >> one discussed in this thread. From what I can tell, both are protected by a
> >> lock, so, again, nothing to worry about right now? Would you agree?
> >
> > FWIW, my opinion is that in both cases the broken dependency can be
> > removed entirely.
> >
> >> Comments marked with "AD:" were added by me for readability.
> >>
> >> 1. drivers/hwtracing/stm/core.c::1050 - 1085
> >>
> >>         /**
> >>          * __stm_source_link_drop() - detach stm_source from an stm device
> >>          * @src:	stm_source device
> >>          * @stm:	stm device
> >>          *
> >>          * If @stm is @src::link, disconnect them from one another and put the
> >>          * reference on the @stm device.
> >>          *
> >>          * Caller must hold stm::link_mutex.
> >>          */
> >>         static int __stm_source_link_drop(struct stm_source_device *src,
> >>                                           struct stm_device *stm)
> >>         {
> >>                 struct stm_device *link;
> >>                 int ret = 0;
> >>
> >>                 lockdep_assert_held(&stm->link_mutex);
> >>
> >>                 /* for stm::link_list modification, we hold both mutex and spinlock */
> >>                 spin_lock(&stm->link_lock);
> >>                 spin_lock(&src->link_lock);
> >>
> >>                 /* AD: Beginning of the address dependency. */
> >>                 link = srcu_dereference_check(src->link, &stm_source_srcu, 1);
> >>
> >>                 /*
> >>                  * The linked device may have changed since we last looked, because
> >>                  * we weren't holding the src::link_lock back then; if this is the
> >>                  * case, tell the caller to retry.
> >>                  */
> >>                 if (link != stm) {
> >>                         ret = -EAGAIN;
> >>                         goto unlock;
> >>                 }
> >>
> >>                 /* AD: Compiler deduces that "link" and "stm" are exchangeable at this point. */
> >>                 stm_output_free(link, &src->output); list_del_init(&src->link_entry);
> >>
> >>                 /* AD: Leads to WRITE_ONCE() to (&link->dev)->power.last_busy. */
> >>                 pm_runtime_mark_last_busy(&link->dev);
> >
> > In both of these statements, link can safely be replaced by stm.
> >
> > (There's also a control dependency which the LKMM isn't aware of.  This
> > makes it all the more safe.)
> >
> >> 2. kernel/locking/lockdep.c::6319 - 6348
> >>
> >>         /*
> >>          * Unregister a dynamically allocated key.
> >>          *
> >>          * Unlike lockdep_register_key(), a search is always done to find a matching
> >>          * key irrespective of debug_locks to avoid potential invalid access to freed
> >>          * memory in lock_class entry.
> >>          */
> >>         void lockdep_unregister_key(struct lock_class_key *key)
> >>         {
> >>                 struct hlist_head *hash_head = keyhashentry(key);
> >>                 struct lock_class_key *k;
> >>                 struct pending_free *pf;
> >>                 unsigned long flags;
> >>                 bool found = false;
> >>
> >>                 might_sleep();
> >>
> >>                 if (WARN_ON_ONCE(static_obj(key)))
> >>                         return;
> >>
> >>                 raw_local_irq_save(flags);
> >>                 lockdep_lock();
> >>
> >>                 /* AD: Address dependency begins here with an rcu_dereference_raw() into k. */
> >>                 hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
> >>                         /* AD: Compiler deduces that k and key are exchangable iff the if condition evaluates to true.
> >>                         if (k == key) {
> >>                                 /* AD: Leads to WRITE_ONCE() to (&k->hash_entry)->pprev. */
> >>                                 hlist_del_rcu(&k->hash_entry);
> >
> > And here k could safely be replaced with key.  (And again there is a
> > control dependency, but this is one that the LKMM would detect.)
> 
> Ha, I didn't even notice the control dependencies - of course! In that case,
> this doesn't warrant a patch though, given that nothing is really breaking?
> 
> Many thanks,
> Paul


