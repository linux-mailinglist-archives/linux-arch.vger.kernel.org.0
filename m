Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF375A4C1D
	for <lists+linux-arch@lfdr.de>; Mon, 29 Aug 2022 14:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiH2MmH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Aug 2022 08:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiH2Ml2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Aug 2022 08:41:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5F4AA36D;
        Mon, 29 Aug 2022 05:25:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9008BB80F9A;
        Mon, 29 Aug 2022 12:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1B6C433D7;
        Mon, 29 Aug 2022 12:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661775952;
        bh=3iB3FPdcSvm99iM6SmOB3c5yrDWVJ8azBbcMqlPGahU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=U9rc4Pl+o0ydfA3ZabupGKgLAeKFGa9VTdEKPzEQfZJGvjz5rf/x1+Pa6RMPxDiBC
         9jqfx+lScrIMrvPA3riy7bAjy4iXqnOeiQ5RpXRLfKI7wATqiPdDv9jOfTtNr2h+Yq
         Wa20ghuu2acgEA3aLSs3uLf5wthIZ6qxjVhNb0qvfc8x3Zav6sSokUCAjA+A0+P5de
         bQNqtx2Zwz2+DaKO6sCI3kLAmL8NA46x3FcuUCCe0t5hFORtboJg0kbLnB+FUuI9EE
         UulxZQCkL5hNebcDXHpxCKz4XhYLZsSfE1TMqSUpfspvZpiyzGy3XWlxAXXfudtV4Q
         DnEHl86Tq6WOA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D087A5C019C; Mon, 29 Aug 2022 05:25:51 -0700 (PDT)
Date:   Mon, 29 Aug 2022 05:25:51 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     stern@rowland.harvard.edu, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: "Verifying and Optimizing Compact NUMA-Aware Locks on Weak
 Memory Models"
Message-ID: <20220829122551.GL6159@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220826124812.GA3007435@paulmck-ThinkPad-P17-Gen-1>
 <YwwlWMmHxD7OPERD@anparri>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YwwlWMmHxD7OPERD@anparri>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 29, 2022 at 04:33:23AM +0200, Andrea Parri wrote:
> On Fri, Aug 26, 2022 at 05:48:12AM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > I have not yet done more than glance at this one, but figured I should
> > send it along sooner rather than later.
> > 
> > "Verifying and Optimizing Compact NUMA-Aware Locks on Weak
> > Memory Models", Antonio Paolillo, Hernán Ponce-de-León, Thomas
> > Haas, Diogo Behrens, Rafael Chehab, Ming Fu, and Roland Meyer.
> > https://arxiv.org/abs/2111.15240
> > 
> > The claim is that the queued spinlocks implementation with CNA violates
> > LKMM but actually works on all architectures having a formal hardware
> > memory model.
> > 
> > Thoughts?
> 
> Section 4 ends with a discussion about certain "spurious" data races.
> Do we have litmus tests with them?  (I could repro with Dartagnan...)

Their Figure 5 clearly shows a data race, but agreed, their claim is
that this race is prevented by other code not in this litmus test.
Me, I currently suspect that the spurious data race might be due to the
failure to guarantee mutual exclusion, though I have not yet read that
paper carefully.  That is scheduled for tomorrow morning.

							Thanx, Paul
