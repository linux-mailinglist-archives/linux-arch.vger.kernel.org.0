Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2C296F4F
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2019 04:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfHUCQz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Aug 2019 22:16:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53776 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfHUCQy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Aug 2019 22:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6fhtHzg47p/BjEhxXWfY/uri7DF3nACrkqX4IVZvknc=; b=eNFBx0uTZTv3kpObtFFodLkhr
        ZoScbNT4CexDJX8LcyfWQdhMWO/D73I5R7mWungXcjWhlZaK/ANKYmFqL2R5+Md3n2dns6tgiHPIm
        zo411HHOOcZnoPm8UHr3w3gW5CPkM4X9LstsPsQrPC0+vZoH+aZpUY2vsfffjwvXHLluqRzane8aX
        0pcnUiGErQ/lgmwVkmsMD5u2YOyimIEPai+HOwIO22NLDXYqKyHnNCeEUHexFCqhybvrX4Y5pSfZx
        fN+/UjW4lMMWbLcgwTWV2m96FK9oLeP91jXIz6cwZOGcfPKyg5X3QM7l4DRlOG8N6PO5gQ9eDyg3e
        u/5kXRUYQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i0GB8-0003b1-BP; Wed, 21 Aug 2019 02:16:50 +0000
Date:   Tue, 20 Aug 2019 19:16:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
        douzhk@nationalchip.com, Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH 1/3] csky: Fixup arch_get_unmapped_area() implementation
Message-ID: <20190821021650.GA32710@infradead.org>
References: <1566304469-5601-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566304469-5601-1-git-send-email-guoren@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> +/*
> + * We need to ensure that shared mappings are correctly aligned to
> + * avoid aliasing issues with VIPT caches.  We need to ensure that
> + * a specific page of an object is always mapped at a multiple of
> + * SHMLBA bytes.
> + *
> + * We unconditionally provide this function for all cases.
> + */

On something unrelated: If csky has virtually indexed caches you also
need to implement the flush_kernel_vmap_range and
invalidate_kernel_vmap_range functions to avoid data corruption when
doing I/O on vmalloc/vmap ranges.
