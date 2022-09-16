Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63C25BA805
	for <lists+linux-arch@lfdr.de>; Fri, 16 Sep 2022 10:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiIPITG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Sep 2022 04:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIPITE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Sep 2022 04:19:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60CE4F19A;
        Fri, 16 Sep 2022 01:19:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53807B82435;
        Fri, 16 Sep 2022 08:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B70C433D6;
        Fri, 16 Sep 2022 08:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663316341;
        bh=ZMveutqhGk6e+KXaRUgdFyV/gB/vNZw5k+vQwPEt5i8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NswZ4MxPXpEXjTamgxV/ZJcIvcyijmzWBMZp/t3+Hho7SBJLO6dAOakAn5ZivP8Fx
         y9IVOn0AqGkXNO4Ble43aKRZgtvb+uuxE6u4WGTHY1smMaQ6vc3pw5+mWLYceuNcmO
         DUyR9iWqQYn3NujLQaCt2i9aJgmEEiiAH/BFK/AOfSPafd0KNo8EqVD2f10qM+vakI
         bCDRHnqrwMNHOhHwhkcGfW3ZFhGcyJlFPSBIm6mSrcnT4GV61TsanbfFejEKB2WFqF
         2wTFT15Lt2DJCVdRWhVw0386lKLEPrsgBB5o+VBqwwAYhrfmO1wwhATbdmgel8Ni9o
         sZmZv8ngO1yGQ==
Date:   Fri, 16 Sep 2022 09:18:54 +0100
From:   Will Deacon <will@kernel.org>
To:     Dan Lustig <dlustig@nvidia.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Zijlstra <peterz@infradead.org>, parri.andrea@gmail.com,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: "Verifying and Optimizing Compact NUMA-Aware Locks on Weak
 Memory Models"
Message-ID: <20220916081852.GA6475@willie-the-truck>
References: <20220826124812.GA3007435@paulmck-ThinkPad-P17-Gen-1>
 <YwjzfASTcODOXP1f@worktop.programming.kicks-ass.net>
 <Ywj+j2kC+5xb6DmO@rowland.harvard.edu>
 <20220826204219.GX6159@paulmck-ThinkPad-P17-Gen-1>
 <20220913112416.GC3752@willie-the-truck>
 <e0e83886-457b-2f55-8019-899acfd81e99@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0e83886-457b-2f55-8019-899acfd81e99@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 13, 2022 at 08:21:02AM -0400, Dan Lustig wrote:
> On 9/13/2022 7:24 AM, Will Deacon wrote:
> > On Fri, Aug 26, 2022 at 01:42:19PM -0700, Paul E. McKenney wrote:
> >> PPC MP+lwsyncs+atomic
> >> "LwSyncdWW Rfe LwSyncdRR Fre"
> >> Cycle=Rfe LwSyncdRR Fre LwSyncdWW
> >> {
> >> 0:r2=x; 0:r4=y;
> >> 1:r2=y; 1:r5=2;
> >> 2:r2=y; 2:r4=x;
> >> }
> >>  P0           | P1              | P2           ;
> >>  li r1,1      | lwarx r1,r0,r2  | lwz r1,0(r2) ;
> >>  stw r1,0(r2) | stwcx. r5,r0,r2 | lwsync       ;
> >>  lwsync       |                 | lwz r3,0(r4) ;
> >>  li r3,1      |                 |              ;
> >>  stw r3,0(r4) |                 |              ;
> >> exists (1:r1=1 /\ 2:r1=2 /\ 2:r3=0)
> > 
> > Just catching up on this, but one possible gotcha here is if you have an
> > architecture with native load-acquire on P2 and then you move P2 to the end
> > of P1. e.g. at a high-level:
> > 
> > 
> >   P0		P1
> >   Wx = 1	RmW(y) // xchg() 1 => 2
> >   WyRel = 1	RyAcq = 2
> > 		Rx = 0
> > 
> > arm64 forbids this, but it's not "natural" to the hardware and I don't
> > know what e.g. risc-v would say about it.
> > 
> 
> RISC-V doesn't currently have native load-acquire instructions other than
> load-reserve-acquire, but if it did, it would forbid this outcome as well.

Thanks for chipping in, Dan. Somehow, I hadn't realised that you didn't
have native load-acquire instructions.

Will
