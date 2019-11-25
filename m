Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE7D410894B
	for <lists+linux-arch@lfdr.de>; Mon, 25 Nov 2019 08:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbfKYHjb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Nov 2019 02:39:31 -0500
Received: from verein.lst.de ([213.95.11.211]:34632 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbfKYHjb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 Nov 2019 02:39:31 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0B29A68C65; Mon, 25 Nov 2019 08:39:24 +0100 (CET)
Date:   Mon, 25 Nov 2019 08:39:23 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Zigotzky <chzigotzky@xenosoft.de>
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-arch@vger.kernel.org,
        darren@stevens-zone.net, mad skateman <madskateman@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        paulus@samba.org, rtd2@xtra.co.nz,
        "contact@a-eon.com" <contact@a-eon.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        nsaenzjulienne@suse.de, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: Bug 205201 - Booting halts if Dawicontrol DC-2976 UW SCSI
 board installed, unless RAM size limited to 3500M
Message-ID: <20191125073923.GA30168@lst.de>
References: <F1EBB706-73DF-430E-9020-C214EC8ED5DA@xenosoft.de> <20191121072943.GA24024@lst.de> <dbde2252-035e-6183-7897-43348e60647e@xenosoft.de> <6eec5c42-019c-a988-fc2a-cb804194683d@xenosoft.de> <d0252d29-7a03-20e1-ccd7-e12d906e4bdf@arm.com> <b3217742-2c0b-8447-c9ac-608b93265363@xenosoft.de> <20191121180226.GA3852@lst.de> <2fde79cf-875f-94e6-4a1b-f73ebb2e2c32@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fde79cf-875f-94e6-4a1b-f73ebb2e2c32@xenosoft.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Nov 23, 2019 at 12:42:27PM +0100, Christian Zigotzky wrote:
> Hello Christoph,
>
> Please find attached the dmesg of your Git kernel.

Thanks.  It looks like on your platform the swiotlb buffer isn't
actually addressable based on the bus dma mask limit, which is rather
interesting.  swiotlb_init uses memblock_alloc_low to allocate the
buffer, and I'll need some help from Mike and the powerpc maintainers
to figure out how that select where to allocate the buffer from, and
how we can move it to a lower address.  My gut feeling would be to try
to do what arm64 does and define a new ARCH_LOW_ADDRESS_LIMIT, preferably
without needing too much arch specific magic.

As a quick hack can you try this patch on top of the tree from Friday?

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index f491690d54c6..e3f95c362922 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -344,7 +344,7 @@ static inline int memblock_get_region_node(const struct memblock_region *r)
 #define MEMBLOCK_LOW_LIMIT 0
 
 #ifndef ARCH_LOW_ADDRESS_LIMIT
-#define ARCH_LOW_ADDRESS_LIMIT  0xffffffffUL
+#define ARCH_LOW_ADDRESS_LIMIT  0x0fffffffUL
 #endif
 
 phys_addr_t memblock_phys_alloc_range(phys_addr_t size, phys_addr_t align,
