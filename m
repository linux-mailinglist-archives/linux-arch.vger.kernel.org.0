Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3FD105903
	for <lists+linux-arch@lfdr.de>; Thu, 21 Nov 2019 19:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfKUSCa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Nov 2019 13:02:30 -0500
Received: from verein.lst.de ([213.95.11.211]:47552 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbfKUSCa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 Nov 2019 13:02:30 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8D95E68BFE; Thu, 21 Nov 2019 19:02:26 +0100 (CET)
Date:   Thu, 21 Nov 2019 19:02:26 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Zigotzky <chzigotzky@xenosoft.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        darren@stevens-zone.net, mad skateman <madskateman@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        paulus@samba.org, rtd2@xtra.co.nz,
        "contact@a-eon.com" <contact@a-eon.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        nsaenzjulienne@suse.de
Subject: Re: Bug 205201 - Booting halts if Dawicontrol DC-2976 UW SCSI
 board installed, unless RAM size limited to 3500M
Message-ID: <20191121180226.GA3852@lst.de>
References: <F1EBB706-73DF-430E-9020-C214EC8ED5DA@xenosoft.de> <20191121072943.GA24024@lst.de> <dbde2252-035e-6183-7897-43348e60647e@xenosoft.de> <6eec5c42-019c-a988-fc2a-cb804194683d@xenosoft.de> <d0252d29-7a03-20e1-ccd7-e12d906e4bdf@arm.com> <b3217742-2c0b-8447-c9ac-608b93265363@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3217742-2c0b-8447-c9ac-608b93265363@xenosoft.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 21, 2019 at 05:34:48PM +0100, Christian Zigotzky wrote:
> I modified the patch and compiled a new RC8 of kernel 5.4 today. (patch 
> attached)
>
> We have to wait to Rolands test results with his SCSI PCI card. I tested it 
> today but my TV card doesn't work with this patch.

I think we have two sorta overlapping issues here.  One is that I think
we need the bus_dma_limit, which should mostly help for something like
a SCSI controller that doesn't need streaming mappings (btw, do we
have more details on that somewhere?).

And something weird with the videobuf things.  Your change of the dma
masks suggests that the driver doesn't do the right allocations and thus
hits bounce buffering (swiotlb).  We should fix that for real, but the
fact that the bounce buffering itself also fails is even more interesting.

Can you try this git branch:

    git://git.infradead.org/users/hch/misc.git fsl-dma-debugging

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/fsl-dma-debugging

and send me the dmesg with that with your TV adapter?
