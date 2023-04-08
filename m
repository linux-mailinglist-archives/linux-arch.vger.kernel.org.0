Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729EB6DB7E1
	for <lists+linux-arch@lfdr.de>; Sat,  8 Apr 2023 02:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjDHAtF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Apr 2023 20:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDHAtF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Apr 2023 20:49:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF4EAF3E;
        Fri,  7 Apr 2023 17:49:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE49E65593;
        Sat,  8 Apr 2023 00:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1E4C433EF;
        Sat,  8 Apr 2023 00:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680914943;
        bh=U+av11hX25u4IyfwQg9yYQJu8Wq0oTxiwzajUtWOdug=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Eh67NABHplIbkUbYYBKerJOwmtmuxB+0NXLRY8qJfAOTSbEGAlkWRKyZky8RSOukJ
         XRQO676cLTHlP0F3grhPGpLCSVKtt6XPdhaikuOK3q5WgEjnBTBTP2i1mkOVnYefHG
         LLBSbjJYXSk8pI/Svugkvv8Q9TmvP8T63FecQ8S2uChQfQv6/Hs7XHB1fZOfD204T4
         9PATU+SOBEmo8Pbm5zAkECjHOQuSzSIkA/W0a3k178VFY2PJqYSvErW1/YveIaGAaw
         FvvwjaAAjV6CsKFUfdrselqRH25KB+4lwafgh7x++zY4BMIzBI+rq3W/5K3BF14Pqq
         L161KXqHEFmKg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BCC7615404B5; Fri,  7 Apr 2023 17:49:02 -0700 (PDT)
Date:   Fri, 7 Apr 2023 17:49:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>,
        Will Deacon <will@kernel.org>
Subject: Re: Litmus test names
Message-ID: <d32901a8-3a07-440c-9089-36b37c3f04e5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ea9376b4-4b3d-48ee-9c27-ad8de8a7b5cb@paulmck-laptop>
 <3908932E-17D4-4B87-AB0C-D10564F10623@joelfernandes.org>
 <159545c3-0093-3cbd-e822-7298ae764966@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <159545c3-0093-3cbd-e822-7298ae764966@huaweicloud.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 07, 2023 at 03:05:01PM +0200, Jonas Oberhauser wrote:
> 
> 
> On 4/7/2023 2:12 AM, Joel Fernandes wrote:
> > 
> > 
> > > On Apr 6, 2023, at 6:34 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > 
> > > ﻿On Thu, Apr 06, 2023 at 05:36:13PM -0400, Alan Stern wrote:
> > > > Paul:
> > > > 
> > > > I just saw that two of the files in
> > > > tools/memory-model/litmus-tests have
> > > > almost identical names:
> > > > 
> > > >  Z6.0+pooncelock+pooncelock+pombonce.litmus
> > > >  Z6.0+pooncelock+poonceLock+pombonce.litmus
> > > > 
> > > > They differ only by a lower-case 'l' vs. a capital 'L'.  It's
> > > > not at all
> > > > easy to see, and won't play well in case-insensitive filesystems.
> > > > 
> > > > Should one of them be renamed?
> > > 
> > > Quite possibly!
> > > 
> > > The "L" denotes smp_mb__after_spinlock().  The only code difference
> > > between these is that Z6.0+pooncelock+poonceLock+pombonce.litmus has
> > > smp_mb__after_spinlock() and Z6.0+pooncelock+pooncelock+pombonce.litmus
> > > does not.
> > > 
> > > Suggestions for a better name?  We could capitalize all the letters
> > > in LOCK, I suppose...
> 
> I don't think capitalizing LOCK is helpful.

Greek font, then?  (Sorry, couldn't resist...)

> To be honest, almost all the names are extremely cryptic to newcomers like
> me (like, what does Z6.0 mean? Is it some magic incantation?).
> And that's not something that's easy to fix.

All too true on all counts.  Some of the names abbreviate the litmus
test itself, and there are multiple encodings depending one who/what
generated the test in question.  Others of the names relate to who came
up with them or the code from which they are derived.

New allegedly universal naming schemes have a rather short half-life.

What would be cool would be a way to structurally compare litmus tests.
I bet that there are quite a few duplicates, for example.

> The only use case I can think of for spending time improving the names is
> that sometimes you wanna say something like "oh, this is like
> Z6.0+pooncelock+pooncelockmb+pombonce". And then people can look up what
> that is.
> For that, it's important that the names are easy to disambiguate by humans,
> and I think Joel's suggestion is an improvement.
> (and it also fixes the issue brought up by Alan about case-insensitive file
> systems)
> 
> > 
> > Z6.0+pooncelock+pooncelockmb+pombonce.litmus ?

I am OK with this one, but then again, I was also OK with the original
Z6.0+pooncelock+poonceLock+pombonce.litmus.  ;-)

Would someone like to to a "git mv" send the resulting patch?

							Thanx, Paul
