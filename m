Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDCF69BF17
	for <lists+linux-arch@lfdr.de>; Sun, 19 Feb 2023 09:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjBSIJ2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Feb 2023 03:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBSIJ1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Feb 2023 03:09:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9346113D0;
        Sun, 19 Feb 2023 00:09:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE5D160BB9;
        Sun, 19 Feb 2023 08:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8B9C433D2;
        Sun, 19 Feb 2023 08:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676794164;
        bh=4eziLVCcDlde0H0XGo8q3JtUuswdaThfLP8DQgsvEDc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=X0RfJR4tjukJvhSLo1OzPcqaCx3EDz6GUrs1aHah353dIQCBqSXVjOC3KCUzVq4Hr
         MQ3z7JQB10rD3VeZHr/Nq89jtErCENWTTrUTlWZ3eD528UZLX5yQ1pECwypaZA7UIX
         AtyUq3lx4GWz3lE5i+6io0ojVmV0/QTT6CIeUSS2MIdetNur3cGMOmfUYeHJcNpzEU
         P1nGu52d7huP7KJ/LS3CoJF2YjKh0DGwLR5kOFuXHxzeiQq1BZu1gKnmDgFjWd6czR
         eW4AK34E9AdRjquGGVMjV/Z2oM/xZ0A3X57CCKFLciYhMe+etsG4vDab+PNnoOnc00
         hxHbVpS3gKBxg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C025F5C0A1A; Sun, 19 Feb 2023 00:09:21 -0800 (PST)
Date:   Sun, 19 Feb 2023 00:09:21 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: Current LKMM patch disposition
Message-ID: <20230219080921.GG2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230204222411.GC2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9+41ctA54pjm/KG@google.com>
 <Y+FJSzUoGTgReLPB@rowland.harvard.edu>
 <Y+fN2fvUjGDWBYrv@google.com>
 <Y+f4TYZ9BPlt8y8B@rowland.harvard.edu>
 <CAEXW_YRuTfjc=5OAskTV0Qt_zSJTPP3-01=Y=SypMdPsF_weAQ@mail.gmail.com>
 <Y+hWAksfk4C0M2gB@rowland.harvard.edu>
 <CAEXW_YQ3fvFDNi9wG5w4Zqkbda8SUByOnM6y6MXQpxT9oQw8xQ@mail.gmail.com>
 <20230218192123.GC2948950@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YT-wMxQUXzB0hinCf-f7d7+cG3cALF55ehDe1b4aYob3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YT-wMxQUXzB0hinCf-f7d7+cG3cALF55ehDe1b4aYob3Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 18, 2023 at 10:20:39PM -0500, Joel Fernandes wrote:
> On Sat, Feb 18, 2023 at 2:21 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Sat, Feb 18, 2023 at 01:13:59AM -0500, Joel Fernandes wrote:
> > > Hi Alan,
> > >
> > > On Sat, Feb 11, 2023 at 9:59 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > >
> > > [...]
> > > >
> > > > Would you like to post a few examples showing some of the most difficult
> > > > points you encountered?  Maybe explanation.txt can be improved.
> > >
> > > One additional feedback I wanted to mention, regarding this paragraph
> > > under "WARNING":
> > > ===========
> > > The protections provided by READ_ONCE(), WRITE_ONCE(), and others are
> > > not perfect; and under some circumstances it is possible for the
> > > compiler to undermine the memory model. Here is an example. Suppose
> > > both branches of an "if" statement store the same value to the same
> > > location:
> > > r1 = READ_ONCE(x);
> > > if (r1) {
> > > WRITE_ONCE(y, 2);
> > > ... /* do something */
> > > } else {
> > > WRITE_ONCE(y, 2);
> > > ... /* do something else */
> > > }
> > > ===========
> > >
> > > I tried lots of different compilers with varying degrees of
> > > optimization, in all cases I find that the conditional instruction
> > > always appears in program order before the stores inside the body of
> > > the conditional. So I am not sure if this is really a valid concern on
> > > current compilers, if not - could you provide an example of a compiler
> > > and options that cause it?
> > >
> > > In any case, if it is a theoretical concern, it could be clarified
> > > that this is a theoretical possibility in the text.  And if it is a
> > > real/practical concern, then it could be mentioned the specific
> > > compiler/arch this was seen in.
> >
> > I could be misremembering, but I believe that this reordering has been
> > seen in the past.
> >
> 
> Thank you! And I also confirmed putting a barrier() in the branch
> body, also "cures" the optimization... I did not know compilers
> optimize so aggressively..

And the compilers are just getting started...  :-/

							Thanx, Paul
