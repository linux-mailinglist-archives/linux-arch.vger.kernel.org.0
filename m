Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A207D1DE4
	for <lists+linux-arch@lfdr.de>; Sat, 21 Oct 2023 17:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjJUPbI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 21 Oct 2023 11:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjJUPbH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 21 Oct 2023 11:31:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1601126;
        Sat, 21 Oct 2023 08:31:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD85C433C7;
        Sat, 21 Oct 2023 15:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697902262;
        bh=BRwAnioFJ5Gt3L5fQu7mvOCVZv/G3cxg1M++mEiIZKI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SYrqXT6scVy41lqQPUxZH976uFG25t0I7KbyNy8RmLAV/lemHGkyB+r9RCa0u/o51
         JnK8kcAbvwPCHoKeUKZfUz44WmZcVCgNV0l4ijZjAJtT6VhpOY2Gvr8KplJIXOer5E
         EsmSlrUzB7TTW25+5B68WJmJul04xs7QCaeXICAiCsqQbOzbqvMCpAfUb8jQ6sit3I
         wFt+QO9V2YoRDs38ZVvqHhWmesiabKLNgxqKXSm6FiUfQVsW+FlxfjBy0LJUU2ynBr
         9kuNy6t/OGfLdY2uzxEzXJahk+Sk8AiY4CWf07+AOyunQwnXgEMPAJbynBaZMuSlku
         8HOIeeXTsohYA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C9D77CE0ED1; Sat, 21 Oct 2023 08:31:01 -0700 (PDT)
Date:   Sat, 21 Oct 2023 08:31:01 -0700
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
Message-ID: <77666e6b-8aad-49f5-b936-ef306773f8dc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ceaeba0a-fc30-4635-802a-668c859a58b2@paulmck-laptop>
 <4110a58a-8db5-57c4-2f5a-e09ee054baaa@huaweicloud.com>
 <1c731fdc-9383-21f2-b2d0-2c879b382687@huaweicloud.com>
 <f363d6e0-5682-43e7-9a3f-6b896c3cd920@paulmck-laptop>
 <b96cfbc1-f6b0-2fa6-b72d-d57c34bbf14b@huaweicloud.com>
 <2694e6e1-3282-4a69-b955-06afd7d7f87f@paulmck-laptop>
 <03ea8aea-2d0c-48ab-bb0d-e585571f1926@gmail.com>
 <8322165e-c287-6e43-239e-3fcd0b375c1e@huaweicloud.com>
 <f2a94468-b99a-412b-9336-60a76f04cda3@paulmck-laptop>
 <596cb20e-a03c-cc69-d525-719d5a5b4c12@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <596cb20e-a03c-cc69-d525-719d5a5b4c12@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Oct 21, 2023 at 03:45:16PM +0200, Jonas Oberhauser wrote:
> 
> Am 10/20/2023 um 7:56 PM schrieb Paul E. McKenney:
> > On Fri, Oct 20, 2023 at 06:13:34PM +0200, Jonas Oberhauser wrote:
> > > Am 10/20/2023 um 5:24 PM schrieb Akira Yokosawa:
> > > > Hi Paul,
> > > > 
> > > > On 2023/10/20 22:57, Paul E. McKenney wrote:
> > > > [...]
> > > > > So if there are things that rcu_dereference.rst is missing, they do
> > > > > need to be added.
> > > > As far as I can see, there is no mention of "address dependency"
> > > > in rcu_dereference.rst.
> > > > Yes, I see the discussion in rcu_dereference.rst is all about how
> > > > not to break address dependency by proper uses of rcu_dereference()
> > > > and its friends.  But that might not be obvious for readers who
> > > > followed the references placed in memory-barriers.txt.
> > > > 
> > > > Using the term "address dependency" somewhere in rcu_dereference.rst
> > > > should help such readers, I guess.
> > > I think that's a good point.
> > How about the commit shown at the end of this email,
> 
> I think it's very clear.

Thank you for looking it over!

> > with a Reported-by for both of you?
> 
> I haven't reported anything.

I doubt that Akira would have said anything had you not initiated this
discussion.  But if you would like, I can remove your Reported-by,
though I would need you to explicitly ask.

> > > > [...]
> > > > > > Thanks for the response, I started thinking my mails aren't getting through
> > > > > > again.
> > > > Jonas, FWIW, your email archived at
> > > > 
> > > >       https://lore.kernel.org/linux-doc/1c731fdc-9383-21f2-b2d0-2c879b382687@huaweicloud.com/
> > > > 
> > > > didn't reach my gmail inbox.  I looked for it in the spam folder,
> > > > but couldn't find it there either.
> > > > [...]
> > > 
> > > Thanks Akira!
> > > 
> > > I wrote the gmail support a while ago, but no response.
> > > 
> > > Currently no idea who to talk to... Oh well.
> > Your emails used to end up in my spam folder quite frequently, but
> > they have been coming through since you changed your email address.
> 
> In return, I receive all mail from the mailing list, if is also addressed to
> me, twice.
> So it evens out, somehow? (I suspect this is a configuration error in my
> mail filters on my side though)

Too much fun!

							Thanx, Paul
