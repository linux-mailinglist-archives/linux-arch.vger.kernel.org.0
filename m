Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D830F3E29C2
	for <lists+linux-arch@lfdr.de>; Fri,  6 Aug 2021 13:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242881AbhHFLeg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Aug 2021 07:34:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:33052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232704AbhHFLef (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Aug 2021 07:34:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16D2E60FE7;
        Fri,  6 Aug 2021 11:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628249660;
        bh=1+KiZplv3MguZUZepGmue5Z/n03MIoOuRn2s0KMeuIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eWHjhLQAAnrtFOQ2us3+TgZtQZtaAToDcCSN6k7dni+sBjzSJAmDcimFdlF2rGmcs
         8lCvShrSLS1Xa/Y0k+hkekDfsKbYrwA7loz5OK5TnyPicR6Zfu7WdxsIZt6XvJ/ECc
         Y9cewdnJdpyNNqvbgC84DMw4nkI4m8hSRPZtTpfasKx/sHG9b7Y1yrEIZYllVWz+Aq
         M48x7rxWhWHtyAfcmgpI5pIFETl4PPVRkK7goaGtppvUEl4I23yIGFbl73WCM8G8QQ
         nALdSk0XhrTHRL8oGQC3Pxn+h3D9G+TzmkaMI/eifnwtUiwktT8KK7rqc1mUb45/0B
         IOmEtsiaD3z0Q==
Date:   Fri, 6 Aug 2021 12:34:14 +0100
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     kernel-team@android.com, Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Jade Alglave <jade.alglave@arm.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        Claire Chang <tientzu@chromium.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] of: restricted dma: Don't fail device probe on rmem init
 failure
Message-ID: <20210806113414.GA2531@willie-the-truck>
References: <20210806113109.2475-1-will@kernel.org>
 <20210806113109.2475-3-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806113109.2475-3-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 06, 2021 at 12:31:05PM +0100, Will Deacon wrote:
> If CONFIG_DMA_RESTRICTED_POOL=n then probing a device with a reference
> to a "restricted-dma-pool" will fail with a reasonably cryptic error:
> 
>   | pci-host-generic: probe of 10000.pci failed with error -22
> 
> Print a more helpful message in this case and try to continue probing
> the device as we do if the kernel doesn't have the restricted DMA patches
> applied or either CONFIG_OF_ADDRESS or CONFIG_HAS_DMA =n.
> 
> Cc: Claire Chang <tientzu@chromium.org>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  drivers/of/address.c    | 8 ++++----
>  drivers/of/device.c     | 2 +-
>  drivers/of/of_private.h | 8 +++-----
>  3 files changed, 8 insertions(+), 10 deletions(-)

Sorry, didn't mean to send this patch a second time, it was still kicking
around in my tree from yesterday and I accidentally picked it up when
sending my TLBI series.

Please ignore.

Will
