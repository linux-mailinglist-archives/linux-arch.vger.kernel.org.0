Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE7D25F44B
	for <lists+linux-arch@lfdr.de>; Mon,  7 Sep 2020 09:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgIGHtM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Sep 2020 03:49:12 -0400
Received: from verein.lst.de ([213.95.11.211]:48064 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbgIGHtM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Sep 2020 03:49:12 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1719868BEB; Mon,  7 Sep 2020 09:49:08 +0200 (CEST)
Date:   Mon, 7 Sep 2020 09:49:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Hillf Danton <hdanton@sina.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH] dma-direct: zero out DMA_ATTR_NO_KERNEL_MAPPING buf
Message-ID: <20200907074908.GA20762@lst.de>
References: <20200904152550.17964-1-hdanton@sina.com> <20200905073528.9464-1-hdanton@sina.com> <CGME20200905155056eucas1p2d4a2249f73506a765fce2d2f7089748d@eucas1p2.samsung.com> <1599321042.11726.6.camel@HansenPartnership.com> <1eb4a2b0-2fd4-9f3c-e610-c8f856027181@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eb4a2b0-2fd4-9f3c-e610-c8f856027181@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 07, 2020 at 09:02:34AM +0200, Marek Szyprowski wrote:
> > That's not a reason ... that comment was put in for coherent mappings.
> > What is the reason we should incur all this expense for clearing pages
> > which aren't unmapped in the kernel, because we can update the comment?
> >   The usual rationale for kernel mapped pages is security, because they
> > may leak information but unmapped pages shouldn't have this problem.
> 
> Any dma_alloc_attrs() buffer might be mmaped to userspace, so the 
> security reason is still valid. Possible lack if kernel mapping was only 
> a hint that driver doesn't need it, so it might be skipped on some 
> architectures, where creating it requires significant resources (i.e. 
> vmalloc area).

Yes.  It seems actually mapping it to userspace in media/drm drivers
seems to be one of the big use cases.  There other one is memory not
used by the host at all and just as an extra buffer for hardware so
that the PCIe device can cut down on DRAM cost.  For that could
potentially skip the zeroing, but then again you'd need to trust the
device, which with thunderbolt might not always be a good idea.
