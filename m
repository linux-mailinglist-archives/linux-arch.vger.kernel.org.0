Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5877D123E3F
	for <lists+linux-arch@lfdr.de>; Wed, 18 Dec 2019 05:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfLREFX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Dec 2019 23:05:23 -0500
Received: from ozlabs.org ([203.11.71.1]:57527 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbfLREFM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Dec 2019 23:05:12 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47d1cj4B0Fz9sRc; Wed, 18 Dec 2019 15:05:09 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 8fabc623238e68b3ac63c0dd1657bf86c1fa33af
In-Reply-To: <20191204123524.22919-1-rppt@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        mad skateman <madskateman@gmail.com>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH] powerpc: ensure that swiotlb buffer is allocated from low memory
Message-Id: <47d1cj4B0Fz9sRc@ozlabs.org>
Date:   Wed, 18 Dec 2019 15:05:09 +1100 (AEDT)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2019-12-04 at 12:35:24 UTC, Mike Rapoport wrote:
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

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/8fabc623238e68b3ac63c0dd1657bf86c1fa33af

cheers
