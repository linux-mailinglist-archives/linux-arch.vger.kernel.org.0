Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5059A7D1544
	for <lists+linux-arch@lfdr.de>; Fri, 20 Oct 2023 19:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjJTR43 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Oct 2023 13:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJTR42 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Oct 2023 13:56:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB34D5A;
        Fri, 20 Oct 2023 10:56:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDE8C433C8;
        Fri, 20 Oct 2023 17:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697824586;
        bh=QQCAtaH9YLSph9w1L2P7GP1gut9U89O48oU0UgDe/rI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JZ/be4hYScXz68gVUHsTJuTdtAuAdaAybZ6idonXADhejF4NUM/ZxbrtMtvJj7HHq
         ATpn/HcZYvrELCdIPYpc0qhR8WiRu/qamr8xrddxjZpXwZSae1JPxO9wl+Vm5Rb2Cj
         P3wl3MQQsMNR2ulZ12wO2J+W3sTzeyuo5nAPi9NQrfQCsH/PIHUuWDG+yK8ujvV6+r
         yfh6506Ka7s1H/T+b06d5aPf0pH7TI7G0fB47LwiJbzxaQltGMSEzfa9vNtAAg5QtC
         IawQki3d59W+mVenxZVkY7j2tad6bYCD3dhWylKGGN8Q/H0WCl5MyPGPM21XnonZtn
         /oX0PwCzuPOJg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8C922CE059F; Fri, 20 Oct 2023 10:56:25 -0700 (PDT)
Date:   Fri, 20 Oct 2023 10:56:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH memory-model] docs: memory-barriers: Add note on compiler
 transformation and address deps
Message-ID: <f2a94468-b99a-412b-9336-60a76f04cda3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ceaeba0a-fc30-4635-802a-668c859a58b2@paulmck-laptop>
 <4110a58a-8db5-57c4-2f5a-e09ee054baaa@huaweicloud.com>
 <1c731fdc-9383-21f2-b2d0-2c879b382687@huaweicloud.com>
 <f363d6e0-5682-43e7-9a3f-6b896c3cd920@paulmck-laptop>
 <b96cfbc1-f6b0-2fa6-b72d-d57c34bbf14b@huaweicloud.com>
 <2694e6e1-3282-4a69-b955-06afd7d7f87f@paulmck-laptop>
 <03ea8aea-2d0c-48ab-bb0d-e585571f1926@gmail.com>
 <8322165e-c287-6e43-239e-3fcd0b375c1e@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8322165e-c287-6e43-239e-3fcd0b375c1e@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 20, 2023 at 06:13:34PM +0200, Jonas Oberhauser wrote:
> 
> Am 10/20/2023 um 5:24 PM schrieb Akira Yokosawa:
> > Hi Paul,
> > 
> > On 2023/10/20 22:57, Paul E. McKenney wrote:
> > [...]
> > > So if there are things that rcu_dereference.rst is missing, they do
> > > need to be added.
> > As far as I can see, there is no mention of "address dependency"
> > in rcu_dereference.rst.
> > Yes, I see the discussion in rcu_dereference.rst is all about how
> > not to break address dependency by proper uses of rcu_dereference()
> > and its friends.  But that might not be obvious for readers who
> > followed the references placed in memory-barriers.txt.
> > 
> > Using the term "address dependency" somewhere in rcu_dereference.rst
> > should help such readers, I guess.
> I think that's a good point.

How about the commit shown at the end of this email, with a Reported-by
for both of you?

> > [...]
> > > > Thanks for the response, I started thinking my mails aren't getting through
> > > > again.
> > Jonas, FWIW, your email archived at
> > 
> >      https://lore.kernel.org/linux-doc/1c731fdc-9383-21f2-b2d0-2c879b382687@huaweicloud.com/
> > 
> > didn't reach my gmail inbox.  I looked for it in the spam folder,
> > but couldn't find it there either.
> > 
> > Your first reply on Oct 6, which is archived at
> > 
> >      https://lore.kernel.org/linux-doc/4110a58a-8db5-57c4-2f5a-e09ee054baaa@huaweicloud.com/
> > 
> > ended up in my spam folder.
> > 
> > I have no idea why gmail has trouble with your emails so often ...
> > 
> > Anyway, LKML did accept your mails this time.
> > 
> > HTH,
> >          Akira
> 
> 
> Thanks Akira!
> 
> I wrote the gmail support a while ago, but no response.
> 
> Currently no idea who to talk to... Oh well.

Your emails used to end up in my spam folder quite frequently, but
they have been coming through since you changed your email address.

							Thanx, Paul

------------------------------------------------------------------------

commit 982ad36df15d48177d7b1501c8afa0b18ff3c8c9
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Fri Oct 20 10:51:26 2023 -0700

    doc: Mention address and data dependencies in rcu_dereference.rst
    
    This commit adds discussion of address and data dependencies to the
    beginning of rcu_dereference.rst in order to enable readers to more
    easily make the connection to the Linux-kernel memory model in general
    and to memory-barriers.txt in particular.
    
    Reported-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
    Reported-by: Akira Yokosawa <akiyks@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/Documentation/RCU/rcu_dereference.rst b/Documentation/RCU/rcu_dereference.rst
index 3b739f6243c8..659d5913784d 100644
--- a/Documentation/RCU/rcu_dereference.rst
+++ b/Documentation/RCU/rcu_dereference.rst
@@ -3,13 +3,26 @@
 PROPER CARE AND FEEDING OF RETURN VALUES FROM rcu_dereference()
 ===============================================================
 
-Most of the time, you can use values from rcu_dereference() or one of
-the similar primitives without worries.  Dereferencing (prefix "*"),
-field selection ("->"), assignment ("="), address-of ("&"), addition and
-subtraction of constants, and casts all work quite naturally and safely.
-
-It is nevertheless possible to get into trouble with other operations.
-Follow these rules to keep your RCU code working properly:
+Proper care and feeding of address and data dependencies is critically
+important to correct use of things like RCU.  To this end, the pointers
+returned from the rcu_dereference() family of primitives carry address and
+data dependencies.  These dependencies extend from the rcu_dereference()
+macro's load of the pointer to the later use of that pointer to compute
+either the address of a later memory access (representing an address
+dependency) or the value written by a later memory access (representing
+a data dependency).
+
+Most of the time, these dependencies are preserved, permitting you to
+freely use values from rcu_dereference().  For example, dereferencing
+(prefix "*"), field selection ("->"), assignment ("="), address-of
+("&"), casts, and addition or subtraction of constants all work quite
+naturally and safely.  However, because current compilers do not take
+either address or data dependencies into account it is still possible
+to get into trouble.
+
+Follow these rules to preserve the address and data dependencies emanating
+from your calls to rcu_dereference() and friends, thus keeping your RCU
+readers working properly:
 
 -	You must use one of the rcu_dereference() family of primitives
 	to load an RCU-protected pointer, otherwise CONFIG_PROVE_RCU
