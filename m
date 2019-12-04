Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78034112D06
	for <lists+linux-arch@lfdr.de>; Wed,  4 Dec 2019 14:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfLDN4h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Dec 2019 08:56:37 -0500
Received: from verein.lst.de ([213.95.11.211]:49290 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbfLDN4g (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 4 Dec 2019 08:56:36 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 95DA468BFE; Wed,  4 Dec 2019 14:56:32 +0100 (CET)
Date:   Wed, 4 Dec 2019 14:56:32 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Paul Mackerras <paulus@samba.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] powerpc: ensure that swiotlb buffer is allocated from
 low memory
Message-ID: <20191204135632.GA31262@lst.de>
References: <20191204123524.22919-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204123524.22919-1-rppt@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 04, 2019 at 02:35:24PM +0200, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Some powerpc platforms (e.g. 85xx) limit DMA-able memory way below 4G. If a
> system has more physical memory than this limit, the swiotlb buffer is not
> addressable because it is allocated from memblock using top-down mode.
> 
> Force memblock to bottom-up mode before calling swiotlb_init() to ensure
> that the swiotlb buffer is DMA-able.
> 
> Link: https://lkml.kernel.org/r/F1EBB706-73DF-430E-9020-C214EC8ED5DA@xenosoft.de
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
