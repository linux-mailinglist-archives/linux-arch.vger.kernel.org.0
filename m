Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A939F6031C6
	for <lists+linux-arch@lfdr.de>; Tue, 18 Oct 2022 19:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiJRRtK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Oct 2022 13:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiJRRtJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Oct 2022 13:49:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1882CC82C;
        Tue, 18 Oct 2022 10:49:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6685D616A0;
        Tue, 18 Oct 2022 17:49:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF478C433D6;
        Tue, 18 Oct 2022 17:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666115347;
        bh=h6JE2xNk6lHxh3XrYY63nPsxtKYGE/KNHOKEoSVIx+c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mjAl4E7So3NZg7D7R/t7IwcCgoLqJFNf9f0riOu8XrqaW8Lr9oUafZTPJ6gTvp1n8
         dCgCt2HgYX2DFKTvOMw5oKrRgdPZ75Qg0kQNZK0Qol17QFo5s0FtLx8dcJQLgBt8Qv
         FTc5HPpxRugBt4RaES2AxV8AJL2knwRS51KKZggQ4/WAESoyZ9+Uuc0yMGxZJ2ba7n
         pdK5auRINkZjxWT+aXDGKD5OiISIkXIw9m0UoFhBmI1J1AI0ueWPJzAtM90YvIlwfL
         TtyCWJjQ/jBCg7xud2HmhVLd+bxklrd53+IyOOvQv7vg+4dmwaWZQAy/o69sRd7WF2
         cPuFh2VL75mkw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 581B05C0528; Tue, 18 Oct 2022 10:49:07 -0700 (PDT)
Date:   Tue, 18 Oct 2022 10:49:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Parav Pandit <parav@nvidia.com>,
        bagasdotme@gmail.com, Alan Stern <stern@rowland.harvard.edu>,
        parri.andrea@gmail.com, Peter Zijlstra <peterz@infradead.org>,
        boqun.feng@gmail.com, Nicholas Piggin <npiggin@gmail.com>,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        Akira Yokosawa <akiyks@gmail.com>, dlustig@nvidia.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v4] locking/memory-barriers.txt: Improve documentation
 for writel() example
Message-ID: <20221018174907.GT5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221010101331.29942-1-parav@nvidia.com>
 <d5faaf6f-7de5-49b0-92d6-9989ffbdbf2e@app.fastmail.com>
 <20221018100554.GA3112@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018100554.GA3112@willie-the-truck>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 18, 2022 at 11:05:55AM +0100, Will Deacon wrote:
> On Mon, Oct 17, 2022 at 10:55:00PM +0200, Arnd Bergmann wrote:
> > On Mon, Oct 10, 2022, at 12:13 PM, Parav Pandit wrote:
> > > The cited commit describes that when using writel(), explcit wmb()
> > > is not needed. wmb() is an expensive barrier. writel() uses the needed
> > > platform specific barrier instead of expensive wmb().
> > >
> > > Hence update the example to be more accurate that matches the current
> > > implementation.
> > >
> > > commit 5846581e3563 ("locking/memory-barriers.txt: Fix broken DMA vs. 
> > > MMIO ordering example")
> > >
> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > 
> > I have no objections, though I still don't see a real need to change
> > the wording here.
> 
> FWIW, I also don't think this change is necessary. If anything, I'd say
> we'd be better off _removing_ the text about writel from this section and
> extending the reference to the "KERNEL I/O BARRIER EFFECTS" section,
> as you could make similar comments about e.g. readb() and subsequent
> barriers.
> 
> For example, something like the diff below.

I do like this change, but we might be dealing with two different groups
of readers.  Will and Arnd implemented significant parts of the current
MMIO/DMA ordering infrastructure.  It is thus quite possible that wording
which suffices to remind them of how things work might or might not help
someone new to Linux who is trying to figure out what is required to make
their driver work.

The traditional resolution of this sort of thing is to provide the
documentation to a newbie and take any resulting confusion seriously.

Parav, thoughts?

							Thanx, Paul

> Will
> 
> --->8
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 06f80e3785c5..93d9a90b7cfa 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -1910,7 +1910,8 @@ There are some more advanced barrier functions:
>  
>       These are for use with consistent memory to guarantee the ordering
>       of writes or reads of shared memory accessible to both the CPU and a
> -     DMA capable device.
> +     DMA capable device. See Documentation/core-api/dma-api.rst file for more
> +     information about consistent memory.
>  
>       For example, consider a device driver that shares memory with a device
>       and uses a descriptor status value to indicate if the descriptor belongs
> @@ -1935,18 +1936,15 @@ There are some more advanced barrier functions:
>                 writel(DESC_NOTIFY, doorbell);
>         }
>  
> -     The dma_rmb() allows us guarantee the device has released ownership
> +     The dma_rmb() allows us to guarantee that the device has released ownership
>       before we read the data from the descriptor, and the dma_wmb() allows
>       us to guarantee the data is written to the descriptor before the device
> -     can see it now has ownership.  The dma_mb() implies both a dma_rmb() and
> -     a dma_wmb().  Note that, when using writel(), a prior wmb() is not needed
> -     to guarantee that the cache coherent memory writes have completed before
> -     writing to the MMIO region.  The cheaper writel_relaxed() does not provide
> -     this guarantee and must not be used here.
> -
> -     See the subsection "Kernel I/O barrier effects" for more information on
> -     relaxed I/O accessors and the Documentation/core-api/dma-api.rst file for
> -     more information on consistent memory.
> +     can see it now has ownership.  dma_mb() implies both a dma_rmb() and
> +     a dma_wmb().
> +
> +     Note that the dma_*() barriers do not provide any ordering guarantees for
> +     accesses to MMIO regions.  See the later "KERNEL I/O BARRIER EFFECTS"
> +     subsection for more information about I/O accessors and MMIO ordering.
>  
>   (*) pmem_wmb();
>  
> 
