Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20AC882C0D
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2019 08:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731872AbfHFGvQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Aug 2019 02:51:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44840 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731576AbfHFGvQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Aug 2019 02:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0j0/beEZjkNfD9SuCpCi48IxfaTOmOKL1H6G8UPho5A=; b=nIJaSL6FaLS6lzGxjJd1ih+ix
        alhWogFNEZl3NMVpC4OUoiKOLavS5bjEKVDJkbWYnZLFugTsd1sy2Q1LODZ0iqwf9zy+0XtQH79x0
        nJAq30l2Iu3yszeOjrrrWMUfa3ySr0hTjtgNsAVzXl8SwSIWBcsN6d6pMfFN4zg/kcGIfvnsdZ7ew
        vLahltpO8eh3CbsBiKll1HcYdSp0IlIE7pW+t8SRphdzFUnm3QJaruxY7v/dph2mDtiNk8XNCSeG/
        AffIT1ety4CegVe0FPR5R/9Bc/AFuHtTVeD5d4xrGumK1adQ5XQTHXQLpDqV1Kplh8yFFiiymM3ZZ
        3NxUb4dLw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hutJT-0003IO-4f; Tue, 06 Aug 2019 06:51:15 +0000
Date:   Mon, 5 Aug 2019 23:51:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Guo Ren <guoren@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-csky@vger.kernel.org, feng_shizhu@dahuatech.com,
        zhang_jian5@dahuatech.com, zheng_xingjian@dahuatech.com,
        zhu_peng@dahuatech.com, Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH 4/4] csky: Add dma_inv_range for DMA_FROM_DEVICE
Message-ID: <20190806065115.GB2508@infradead.org>
References: <1564488945-20149-1-git-send-email-guoren@kernel.org>
 <1564488945-20149-4-git-send-email-guoren@kernel.org>
 <CAK8P3a0v3oVS5cCkORxA7na+VE7ofTQRxiv5o5xNf5v=esnN9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0v3oVS5cCkORxA7na+VE7ofTQRxiv5o5xNf5v=esnN9A@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 30, 2019 at 03:43:20PM +0200, Arnd Bergmann wrote:
> When syncing 'for_cpu', you should not need to write back, because
> there won't be any dirty cache lines.
> 
> If you have a CPU core that does not do speculative loads, you also don't
> need to invalidate here, because you have already done that in the
> _for_device() case, the only reason to invalidate the CPU cache
> again is if a speculative load created a stale cache line that now
> shadows the data received from the device.

Yes.  And that is one reason why I want to lift a set of common helpers
for both the speculating and non-speculating case to the common code
that just calls arch specific writeback/invalidate/writeback+invalidate
helpers.  It hasn't been a priotity so far, but maybe it becomes one
now.  Especially if I could draft someone else to help with it :)
