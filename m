Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2693969FD49
	for <lists+linux-arch@lfdr.de>; Wed, 22 Feb 2023 22:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjBVVAA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Feb 2023 16:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjBVU76 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Feb 2023 15:59:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3CE43475;
        Wed, 22 Feb 2023 12:59:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A69E6158F;
        Wed, 22 Feb 2023 20:59:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A33C433EF;
        Wed, 22 Feb 2023 20:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677099577;
        bh=D1wrizSIqi3j0jqp1oQJjLa1djILF/Q526IINcZA838=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NzR4fM1Z8qmUYmeFNf7tzdyocs4a5l18PUhczpmdWTCUZWdw61twJrSwgkSonngTM
         FevdZAQPD2tzXnogoG/8LQpFJyNMSvj9Py+2ho7U4MTiL1xcmlSdMc2Dcvy32bsCFt
         ZUis5PkTcRtPaHi1IpHzX6dFYFcz9aSDL9aNK+4CUm7Ubs0tHWSkFrYhcb2vSkuiUt
         VxozLe14z50ppYIpf4z7Q3jZm/Etu1lfiR3HZLuIMvl5dOUIC8MFLZUud6Df2lrkn0
         Cfk1A625R1P/2Kl8i5tWxam22iJeRRT60HZU6EvQ3CYIJNXEPQ3Nc4iYbkVtA6a+JK
         0aIyHefUAsRFQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7602F5C088E; Wed, 22 Feb 2023 12:59:37 -0800 (PST)
Date:   Wed, 22 Feb 2023 12:59:37 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] tools/memory-model: Add details about SRCU read-side
 critical sections
Message-ID: <20230222205937.GU2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230213015506.778246-1-joel@joelfernandes.org>
 <Y/JS5SYKPeeDQErL@rowland.harvard.edu>
 <CAEXW_YQrFSiDEM9cuhkTT2_1+CZoGbg7vC9oL-D-Wd5OQ2mm2w@mail.gmail.com>
 <CAEXW_YR6eKDCv+E8Xv2aX=Eo=H0667cqrXkMqKhc_QMZ4Vf59A@mail.gmail.com>
 <Y/PgxRorDQZ7wPKU@rowland.harvard.edu>
 <20230222195051.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y/Z7zIGNUIxymLRO@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/Z7zIGNUIxymLRO@rowland.harvard.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 22, 2023 at 03:32:12PM -0500, Alan Stern wrote:
> On Wed, Feb 22, 2023 at 11:50:51AM -0800, Paul E. McKenney wrote:
> > On Mon, Feb 20, 2023 at 04:06:13PM -0500, Alan Stern wrote:
> > > On Sun, Feb 19, 2023 at 12:13:14PM -0500, Joel Fernandes wrote:
> > > > On Sun, Feb 19, 2023 at 12:11 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > > Even though it may be redundant: would it be possible to also mention
> > > > > (after this paragraph) that this case forms an undesirable "->rf" link
> > > > > between B and C, which then causes us to link A and D as a result?
> > > > >
> > > > > A[srcu-lock] ->data B[once] ->rf C[once] ->data D[srcu-unlock].
> > > > 
> > > > Apologies, I meant here, care must be taken to avoid:
> > > > 
> > > > A[srcu-lock] ->data B[srcu-unlock] ->rf C[srcu-lock] ->data D[srcu-unlock].
> > > 
> > > Revised patch below.  I changed more than just this bit.  Mostly small 
> > > edits to improve readability, but I did add a little additional 
> > > material.
> > 
> > Looks good to me, thank you!
> > 
> > Would you like to send a formal patch, or are you thinking in terms
> > of making other changes first?
> 
> I'll send a formal patch when I find time to write an appropriate 
> Changelog description.
> 
> I also have in mind making other changes along the lines Joel suggested, 
> but they will be separate patches.

Sounds good!

							Thanx, Paul
