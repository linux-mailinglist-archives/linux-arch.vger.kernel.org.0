Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93EBD301CD4
	for <lists+linux-arch@lfdr.de>; Sun, 24 Jan 2021 15:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbhAXOvA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Jan 2021 09:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbhAXOu7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Jan 2021 09:50:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8625DC061574;
        Sun, 24 Jan 2021 06:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dXXpQWAfsGNBGd1LppB2DZ4PimtbkGmVFd20xAnJkfM=; b=Yr/x4eoIOWAHoHAMhlXY1zbeVO
        yIEVDx6UYjY5tfYgBr1qkKI8trlNUe43FW9APG66C45pQEEhCroA8a5Sp+eodRZtGBhbdRctkZI/0
        wg/4XgRol08LFLYumZiA3brfJ1XXe5WxnVfVZhHLiPzyFet9onzXn5tnV5QxTkQx6ORfFptz0BrRl
        0bfy0xc2pTZ5IoRQA+JH2TRoTMUQY7gjwKBgKUdT+AcVhxubXwI3xcx+Vt1Sg3tnhTGPQedqgX1RM
        YTl/hhl+Xar/Uw4NuIowb36/ie3TkKsfRU6LDYDWhff4W61A+zYlWv4oW7C97qDmfHelivM251XdW
        d5OzOIvg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l3ghs-0034xa-Ec; Sun, 24 Jan 2021 14:49:48 +0000
Date:   Sun, 24 Jan 2021 14:49:36 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>
Subject: Re: [PATCH v10 09/12] mm: Move vmap_range from mm/ioremap.c to
 mm/vmalloc.c
Message-ID: <20210124144936.GA733865@infradead.org>
References: <20210124082230.2118861-1-npiggin@gmail.com>
 <20210124082230.2118861-10-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124082230.2118861-10-npiggin@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jan 24, 2021 at 06:22:27PM +1000, Nicholas Piggin wrote:
> This is a generic kernel virtual memory mapper, not specific to ioremap.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Although it would be nice if you could fix up the > 80 lines while
you're at it.
