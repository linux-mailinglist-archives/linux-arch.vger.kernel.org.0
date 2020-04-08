Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCD31A247B
	for <lists+linux-arch@lfdr.de>; Wed,  8 Apr 2020 17:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgDHPAv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Apr 2020 11:00:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50860 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgDHPAv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Apr 2020 11:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=81odF68XeQyz5jBMv8t8odv+sDTY8EdfdldOmQeF490=; b=IhSlLhSPOtjqYY/bC2Q6xlyDfP
        m1ceIdJcBETNE/Y33JdbhHsvpge+6CjtfJsWHx1BpQcWBXjftAaee8FByw6Cdxa0CsNGXWIuvcf83
        xnAtPrci8XC2DIFadIhS9JksFEX+yOAYM6aA1RFRL6uHNYV8EhnP/i2kX1hHci3Wv94VOVJTuJKSP
        G1tx9zEYlSIqequjnivlIGE/e+mOWwqxQFda+FI/sDZ08X9Anunbas5cXcur96QRuBucxZDZKZj6/
        J/9uJ+MVyF/WYC9jyY/8CZGaLRWsaMjKhbw+xXWv6F24KTz6Kd/zJ2fXrs8MbDJ0sIgVGl3Y7dzYl
        5PngBiLQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMCC9-0006TO-7r; Wed, 08 Apr 2020 15:00:49 +0000
Subject: Re: [PATCH 09/28] mm: rename CONFIG_PGTABLE_MAPPING to
 CONFIG_ZSMALLOC_PGTABLE_MAPPING
To:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, x86@kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-10-hch@lst.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b0c35646-208e-d49f-72d9-06fb2b7b8869@infradead.org>
Date:   Wed, 8 Apr 2020 08:00:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200408115926.1467567-10-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/8/20 4:59 AM, Christoph Hellwig wrote:
> Rename the Kconfig variable to clarify the scope.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/configs/omap2plus_defconfig | 2 +-
>  include/linux/zsmalloc.h             | 2 +-
>  mm/Kconfig                           | 2 +-
>  mm/zsmalloc.c                        | 8 ++++----
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 

Looks good. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>


-- 
~Randy

