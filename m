Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19DB21A3CA1
	for <lists+linux-arch@lfdr.de>; Fri, 10 Apr 2020 00:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgDIW6M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Apr 2020 18:58:12 -0400
Received: from kernel.crashing.org ([76.164.61.194]:42788 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgDIW6M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Apr 2020 18:58:12 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 039Muffv010125
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 9 Apr 2020 17:56:47 -0500
Message-ID: <0f360b9cb72b80bae0d0db8150f65598c2776268.camel@kernel.crashing.org>
Subject: Re: [PATCH 19/28] gpu/drm: remove the powerpc hack in
 drm_legacy_sg_alloc
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, X86 ML <x86@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-hyperv@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        "open list:GENERIC INCLUDE/A..." <linux-arch@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg "
         "Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-s390@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 10 Apr 2020 08:56:41 +1000
In-Reply-To: <CAKMK7uHtkLvdsWFGiAtkzVa5mpnDvXkn3CHZQ6bgJ_enbyAc8A@mail.gmail.com>
References: <20200408115926.1467567-1-hch@lst.de>
         <20200408115926.1467567-20-hch@lst.de>
         <20200408122504.GO3456981@phenom.ffwll.local>
         <eb48f7b6327e482ea9911b129210c0417ab48345.camel@kernel.crashing.org>
         <CAKMK7uHtkLvdsWFGiAtkzVa5mpnDvXkn3CHZQ6bgJ_enbyAc8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2020-04-09 at 11:41 +0200, Daniel Vetter wrote:
> Now if these boxes didn't ever have agp then I think we can get away
> with deleting this, since we've already deleted the legacy radeon
> driver. And that one used vmalloc for everything. The new kms one does
> use the dma-api if the gpu isn't connected through agp

Definitely no AGP there.

Cheers
Ben.


