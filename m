Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16ACD616EC8
	for <lists+linux-arch@lfdr.de>; Wed,  2 Nov 2022 21:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiKBUau (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Nov 2022 16:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiKBUar (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Nov 2022 16:30:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC063896;
        Wed,  2 Nov 2022 13:30:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 844FE61BDF;
        Wed,  2 Nov 2022 20:30:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF51C433C1;
        Wed,  2 Nov 2022 20:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667421045;
        bh=hud8Dpz5A5Zx36M35iJBXmY3CB9VaHEsQIX80WqYh4c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RweD87Fa6HGuEDGwF4YVqM+BdcUvNOQL+CMELNcieFg3TcfJ/1Ez22e9NT+/s1lgd
         e4VU6afapXCtyFo+WA6PmVqy38OSsn/axYwHhoc8Kcxp5LlYykp9q8qjOol2CMmI6D
         4yT8xgHA2rx/YuFRaCqvsbJQVz46bF/chq6ihok0mgH4WO0alIDF59jldBgi7j/ktS
         i2XuGWQSb+8WoSSIZ260tZ4LaDgh+lwN1uQ4h38CqDfdi/dGH8+7Kv3r8lbzjR/46a
         l6SjLq3Sx+Ww+0bBrlQ5qly3VRZ9YCxgASxJ5xw74nT/ST0quoQik10daC5ftS6jY2
         mqFtGJNN+3m5g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7F2415C1813; Wed,  2 Nov 2022 13:30:45 -0700 (PDT)
Date:   Wed, 2 Nov 2022 13:30:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Parav Pandit <parav@nvidia.com>, bagasdotme@gmail.com,
        arnd@arndb.de, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5] locking/memory-barriers.txt: Improve documentation
 for writel() example
Message-ID: <20221102203045.GS5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221027201000.219731-1-parav@nvidia.com>
 <20221102060553.GA15438@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102060553.GA15438@willie-the-truck>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 02, 2022 at 06:05:54AM +0000, Will Deacon wrote:
> On Thu, Oct 27, 2022 at 11:10:00PM +0300, Parav Pandit wrote:
> > The cited commit describes that when using writel(), explicit wmb()
> > is not needed. wmb() is an expensive barrier. writel() uses the needed
> > platform specific barrier instead of wmb().
> > 
> > writeX() section of "KERNEL I/O BARRIER EFFECTS" already describes
> > ordering of I/O accessors with MMIO writes.
> > 
> > Hence add the comment for pseudo code of writel() and remove confusing
> > text around writel() and wmb().
> > 
> > commit 5846581e3563 ("locking/memory-barriers.txt: Fix broken DMA vs. MMIO ordering example")
> > 
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > ---
> > changelog:
> > v4->v5:
> > - Used suggested documentation update from Will
> > - Added comment to the writel() pseudo code example
> > - updated commit log for newer changes
> 
> Sorry for the delay on this, I'm really behind on patches at the moment.
> This patch looks good to me, so thanks for doing it. You can either add
> my:
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> or, since we worked on this together:
> 
> Co-developed-by: Will Deacon <will@kernel.org>
> Signed-off-by: Will Deacon <will@kernel.org>

Thank you!  I will apply these tags on the next rebase.

							Thanx, Paul
