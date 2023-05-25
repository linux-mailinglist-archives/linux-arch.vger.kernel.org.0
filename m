Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6A5710DC4
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 16:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241435AbjEYOAg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 May 2023 10:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241445AbjEYOAf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2023 10:00:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F531A8;
        Thu, 25 May 2023 07:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11766645FF;
        Thu, 25 May 2023 14:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CD96C4339E;
        Thu, 25 May 2023 14:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685023221;
        bh=gfRrbhhyEcqbLyZDyAZGcAkDAS8G/fyE/7edxRHWzWA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tFs1hrqMAOfe3D+3+g6imFRefaUOB1J+FtU3P2LhkbSR/PiRkavm8sFdT1CPgKbs1
         K1JcAF61qCTDSr/Gi37M29/vn98Lt9AN0oWH1P2T49BKd5WKwyVqAxFPo0mc4v9Zhc
         m42SMhyZvafGwLSTma8taYbhqev06FL8JwUWc/w/vDt2D/+auWB1Y5FvlifLV+9ccS
         gsEtFkOKNz/mjjV6UpIrFqa7sdXgSmZv5l7OfrtwM/fHDptFuGboQw9Gdabhkovjro
         ZAsIYaSO+nS9Idjqlrj0erH32LUcxiaoyiDufXA/nyw+5USvbph0wbDN10IRPdrENg
         q5NjHmg2C5w9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4695CC395DF;
        Thu, 25 May 2023 14:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] s390/ism: Set DMA coherent mask
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168502322128.12931.12742922917026189347.git-patchwork-notify@kernel.org>
Date:   Thu, 25 May 2023 14:00:21 +0000
References: <20230524075411.3734141-1-schnelle@linux.ibm.com>
In-Reply-To: <20230524075411.3734141-1-schnelle@linux.ibm.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     kuba@kernel.org, davem@davemloft.net, wintera@linux.ibm.com,
        wenjia@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, mjrosato@linux.ibm.com,
        pmorel@linux.ibm.com, linux-s390@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 24 May 2023 09:54:10 +0200 you wrote:
> A future change will convert the DMA API implementation from the
> architecture specific arch/s390/pci/pci_dma.c to using the common code
> drivers/iommu/dma-iommu.c which the utilizes the same IOMMU hardware
> through the s390-iommu driver. Unlike the s390 specific DMA API this
> requires devices to correctly set the coherent mask to be allowed to use
> IOVAs >2^32 in dma_alloc_coherent(). This was however not done for ISM
> devices. ISM requires such addresses since currently the DMA aperture
> for PCI devices starts at 2^32 and all calls to dma_alloc_coherent()
> would thus fail.
> 
> [...]

Here is the summary with links:
  - [net-next] s390/ism: Set DMA coherent mask
    https://git.kernel.org/netdev/net-next/c/657d42cf5df6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


