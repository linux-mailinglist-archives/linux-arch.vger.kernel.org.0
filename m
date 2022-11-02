Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F3A615C0B
	for <lists+linux-arch@lfdr.de>; Wed,  2 Nov 2022 07:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiKBGGG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Nov 2022 02:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiKBGGF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Nov 2022 02:06:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24573DE87;
        Tue,  1 Nov 2022 23:06:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACFD8617DC;
        Wed,  2 Nov 2022 06:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DD0C433D6;
        Wed,  2 Nov 2022 06:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667369162;
        bh=bvrPUQ1AkdtWDIkrPLtRNfBzvHOW7CeSneSnNTmKJ2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LwYTWx42wGb7JaWR7zd6arvecdUoOxnekCLqF9GagZ6p3oZkyfLd38l2C6kPNKPKg
         2p0V4MA72gH6i73YrS5WVRvT1U3FVI2+DZeSIoI+yLSOGIqN0XCDfMAR5+rsLE8Rvh
         Hva8ARZU+u5QVDBYfoqxGDM3tRGsyBnn7BX4mO4n/4B3fDVKxr4KjE+F9LLMnAby4L
         /fBLka4RB8U7FMxWWhshc+UBeZyHR330jinhi7Uq3qZEmGepUFluhcH13u0WD6FqjO
         w1eGoFeUt3Kz+zyh5Hf82ZPoua2dmeakiDoCKG9I4Ma2Gmlk6AZkTJQF6ae24zEBSe
         +UOgluERW5cmw==
Date:   Wed, 2 Nov 2022 06:05:54 +0000
From:   Will Deacon <will@kernel.org>
To:     Parav Pandit <parav@nvidia.com>
Cc:     bagasdotme@gmail.com, arnd@arndb.de, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, paulmck@kernel.org, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v5] locking/memory-barriers.txt: Improve documentation
 for writel() example
Message-ID: <20221102060553.GA15438@willie-the-truck>
References: <20221027201000.219731-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027201000.219731-1-parav@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
> ---
> changelog:
> v4->v5:
> - Used suggested documentation update from Will
> - Added comment to the writel() pseudo code example
> - updated commit log for newer changes

Sorry for the delay on this, I'm really behind on patches at the moment.
This patch looks good to me, so thanks for doing it. You can either add
my:

Acked-by: Will Deacon <will@kernel.org>

or, since we worked on this together:

Co-developed-by: Will Deacon <will@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>

Cheers,

Will
