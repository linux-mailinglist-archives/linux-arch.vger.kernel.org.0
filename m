Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DFA6119B0
	for <lists+linux-arch@lfdr.de>; Fri, 28 Oct 2022 19:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJ1R4J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Oct 2022 13:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJ1R4H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Oct 2022 13:56:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D06FB71C;
        Fri, 28 Oct 2022 10:56:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A01A629F9;
        Fri, 28 Oct 2022 17:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4EE6C433C1;
        Fri, 28 Oct 2022 17:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666979765;
        bh=Wlp0wy+aIPCdmybVNAMcWJ4RF9OAgXH+GCCz9N2qmuQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bg6Gr1uP3lQVc319yWgc7sVOo3b7TF2Yca3ELPzK9xdqzDdnO5EPljY8P1AMeEFgY
         fr1Djhrce+3ic3vozX9UN71kyskBoI+hZPozMCdVoGbN8je1GQZKB6RpdzdyuxvHKu
         TuGX1uaVRkH821fjv6QmdUVbsVuoWWdESHL4dYeuDHPyRHjUNr1f11oeRarvrAr5AQ
         7ROrJlJyXZqAcdLcgY8UTCe87GDXmR9NbBLhakdHFfR1+S4MOejQoeHJLwOeltfsjL
         +CawrV+0L7/1ZxmkrD2uVRk/h1OyncIAcCb/O7Xwutv0/UrPkwrPQMgWmSy8++zSRr
         JT5b/L1BXvBgA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 70AAC5C0692; Fri, 28 Oct 2022 10:56:05 -0700 (PDT)
Date:   Fri, 28 Oct 2022 10:56:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Parav Pandit <parav@nvidia.com>
Cc:     bagasdotme@gmail.com, arnd@arndb.de, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v5] locking/memory-barriers.txt: Improve documentation
 for writel() example
Message-ID: <20221028175605.GO5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221027201000.219731-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027201000.219731-1-parav@nvidia.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 27, 2022 at 11:10:00PM +0300, Parav Pandit wrote:
> The cited commit describes that when using writel(), explicit wmb()
> is not needed. wmb() is an expensive barrier. writel() uses the needed
> platform specific barrier instead of wmb().
> 
> writeX() section of "KERNEL I/O BARRIER EFFECTS" already describes
> ordering of I/O accessors with MMIO writes.
> 
> Hence add the comment for pseudo code of writel() and remove confusing
> text around writel() and wmb().
> 
> commit 5846581e3563 ("locking/memory-barriers.txt: Fix broken DMA vs. MMIO ordering example")
> 
> Signed-off-by: Parav Pandit <parav@nvidia.com>

Hearing no immediate objections, I have pulled this in for further
review.  If all goes well, I intend to submit this during the upcoming
v6.2 merge window.

							Thanx, Paul

> ---
> changelog:
> v4->v5:
> - Used suggested documentation update from Will
> - Added comment to the writel() pseudo code example
> - updated commit log for newer changes
> v3->v4:
> - further trimmed the documentation for redundant description
> v2->v3:
> - removed redundant description for writeX()
> - updated text for alignment and smaller change lines
> - updated commit log with blank line before signed-off-by line
> v1->v2:
> - Further improved description of writel() example
> - changed commit subject from 'usage' to 'example'
> v0->v1:
> - Corrected to mention I/O barrier instead of dma_wmb().
> - removed numbered references in commit log
> - corrected typo 'explcit' to 'explicit' in commit log
> ---
>  Documentation/memory-barriers.txt | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 06f80e3785c5..e698093bade1 100644
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
> @@ -1931,22 +1932,21 @@ There are some more advanced barrier functions:
>  		/* assign ownership */
>  		desc->status = DEVICE_OWN;
>  
> -		/* notify device of new descriptors */
> +		/* Make descriptor status visible to the device followed by
> +		 * notify device of new descriptor
> +		 */
>  		writel(DESC_NOTIFY, doorbell);
>  	}
>  
> -     The dma_rmb() allows us guarantee the device has released ownership
> +     The dma_rmb() allows us to guarantee that the device has released ownership
>       before we read the data from the descriptor, and the dma_wmb() allows
>       us to guarantee the data is written to the descriptor before the device
>       can see it now has ownership.  The dma_mb() implies both a dma_rmb() and
> -     a dma_wmb().  Note that, when using writel(), a prior wmb() is not needed
> -     to guarantee that the cache coherent memory writes have completed before
> -     writing to the MMIO region.  The cheaper writel_relaxed() does not provide
> -     this guarantee and must not be used here.
> -
> -     See the subsection "Kernel I/O barrier effects" for more information on
> -     relaxed I/O accessors and the Documentation/core-api/dma-api.rst file for
> -     more information on consistent memory.
> +     a dma_wmb().
> +
> +     Note that the dma_*() barriers do not provide any ordering guarantees for
> +     accesses to MMIO regions.  See the later "KERNEL I/O BARRIER EFFECTS"
> +     subsection for more information about I/O accessors and MMIO ordering.
>  
>   (*) pmem_wmb();
>  
> -- 
> 2.26.2
> 
