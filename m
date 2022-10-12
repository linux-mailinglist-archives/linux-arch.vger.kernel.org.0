Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979205FC07D
	for <lists+linux-arch@lfdr.de>; Wed, 12 Oct 2022 08:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiJLGQr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Oct 2022 02:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJLGQp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Oct 2022 02:16:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00138AA34F;
        Tue, 11 Oct 2022 23:16:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34BC3613FB;
        Wed, 12 Oct 2022 06:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665C3C433D6;
        Wed, 12 Oct 2022 06:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665555403;
        bh=I6RnW5IpmR7g0+YGxHas+7A6fFvaR/Qzrs1BzkOlIRw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=u5v/8LidQwH30eIemf1uWspk1VX+z6vdU8BHsiU3NWXnUtGPNX3WY8YlDH5AEv8+M
         3FKSLWDLv5HXlP7fWBy+wf6+ZJw8VnbS/edEHRH7cLeK4o6kreGQR8jf/Sz7ig65fQ
         KQKY6jYJ3hpTE2jOL6bUJHRa045kjdgTQOd/wg+c511b3TDJeAlgTA51e2zGG1vkHT
         k7juB0v98t08ulBVxJy7dQmaYb7/IwghWelH2f/5y+O4v3gte5q9EphjI3c+aY6Kr/
         R/iT98WoGlfjd2iS6OWqusMIDJ+ouNfWwWGyILq31fEtiyyAaXnBdGIKuNMOCvAFlS
         +8pfwIs/QnHsA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8882B5C196D; Tue, 11 Oct 2022 23:16:39 -0700 (PDT)
Date:   Tue, 11 Oct 2022 23:16:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     corbet@lwn.net, lyj7694@gmail.com, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] docs/memory-barriers/kokr: Update the content
Message-ID: <20221012061639.GK4221@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221011025809.25821-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011025809.25821-1-sj@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 10, 2022 at 07:58:06PM -0700, SeongJae Park wrote:
> There are updates to memory-barriers.txt that not applied to the Korean
> translation.  This patchset applies the changes.
> 
> Changes from v1
> (https://lore.kernel.org/all/20221008174928.13479-1-sj@kernel.org/)
> - Drop first one, which is not for translation and already pulled
> - Use better expressions for Korean (Yunjae Lee)
> - Fix a typo (Yunjae Lee)
> 
> SeongJae Park (3):
>   docs/memory-barriers.txt/kokr: introduce io_stop_wc() and add
>     implementation for ARM64
>   docs/memory-barriers.txt/kokr: Add memory barrier dma_mb()
>   docs/memory-barriers.txt/kokr: Fix confusing name of 'data dependency
>     barrier'

Hearing no objections, I pulled these in.  If someone else wants to take
them, please let me know.

							Thanx, Paul

>  .../translations/ko_KR/memory-barriers.txt    | 149 ++++++++++--------
>  1 file changed, 85 insertions(+), 64 deletions(-)
> 
> -- 
> 2.17.1
> 
