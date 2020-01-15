Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD3613C734
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jan 2020 16:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgAOPSq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jan 2020 10:18:46 -0500
Received: from verein.lst.de ([213.95.11.211]:51488 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbgAOPSp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Jan 2020 10:18:45 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id BB36268B20; Wed, 15 Jan 2020 16:18:39 +0100 (CET)
Date:   Wed, 15 Jan 2020 16:18:38 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Zigotzky <chzigotzky@xenosoft.de>
Cc:     Christoph Hellwig <hch@lst.de>, Mike Rapoport <rppt@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arch@vger.kernel.org, darren@stevens-zone.net,
        mad skateman <madskateman@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        paulus@samba.org, rtd2@xtra.co.nz,
        "contact@a-eon.com" <contact@a-eon.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        nsaenzjulienne@suse.de
Subject: Re: Bug 205201 - Booting halts if Dawicontrol DC-2976 UW SCSI
 board installed, unless RAM size limited to 3500M
Message-ID: <20200115151838.GA30884@lst.de>
References: <20191204085634.GA25929@lst.de> <533E86ED-00F4-4FB2-9D91-D4705088817D@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <533E86ED-00F4-4FB2-9D91-D4705088817D@xenosoft.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 10, 2020 at 08:10:28AM +0100, Christian Zigotzky wrote:
> Hi All,
> 
> The SCSI cards work again. [1, 2]
> 
> Sorry for bothering you.

No problem, and sorry for not following up earlier.  The Christmas
holiday and catch up phase led to a lot of delay.

Thanks a lot for taking care of these ppc platforms!
