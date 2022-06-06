Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C6953EB2B
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jun 2022 19:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbiFFJZn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jun 2022 05:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbiFFJZk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jun 2022 05:25:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284F19418A;
        Mon,  6 Jun 2022 02:25:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1CA261323;
        Mon,  6 Jun 2022 09:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FA8C385A9;
        Mon,  6 Jun 2022 09:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654507538;
        bh=SGyOc8QTUXhFBU0FK2dbWFATxGIrz/5ZeL4pH3h6UnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o5+R3V8oO4+EAgAGTpyjUIQqB3KNAeJts/jhrJSGEBRzH1PN9a+gCBfvBwaJfsi0j
         S+xDAbHwdHZEgYXeWMOFMcC/5op2p7s+cMgBf8QSuvMTb6YuVTYwduPx5uxc+DOYFd
         fr4c0yZ5gapUx5x3IKS7vTtcG+YZNWc9Hh4gX5Rc=
Date:   Mon, 6 Jun 2022 11:25:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        Khalid Aziz <khalid@gonehiking.org>,
        linux-scsi@vger.kernel.org,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Martyn Welch <martyn@welchs.me.uk>,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-parisc@vger.kernel.org, Denis Efremov <efremov@linux.com>
Subject: Re: [PATCH 0/6] phase out CONFIG_VIRT_TO_BUS
Message-ID: <Yp3ID86TBFxl7qyL@kroah.com>
References: <20220606084109.4108188-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606084109.4108188-1-arnd@kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 06, 2022 at 10:41:03AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The virt_to_bus/bus_to_virt interface has been deprecated for
> decades. After Jakub Kicinski put a lot of work into cleaning out the
> network drivers using them, there are only a couple of other drivers
> left, which can all be removed or otherwise cleaned up, to remove the
> old interface for good.
> 
> Any out of tree drivers using virt_to_bus() should be converted to
> using the dma-mapping interfaces, typically dma_alloc_coherent()
> or dma_map_single()).
> 
> There are a few m68k and ppc32 specific drivers that keep using the
> interfaces, but these are all guarded with architecture-specific
> Kconfig dependencies, and are not actually broken.
> 
> There are still a number of drivers that are using virt_to_phys()
> and phys_to_virt() in place of dma-mapping operations, and these
> are often broken, but they are out of scope for this series.

I'll take patches 1 and 2 right now through my staging tree if that's
ok.

thanks,

greg k-h
