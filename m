Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C5E301B73
	for <lists+linux-arch@lfdr.de>; Sun, 24 Jan 2021 12:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbhAXLh6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Jan 2021 06:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbhAXLhv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Jan 2021 06:37:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716A3C061573;
        Sun, 24 Jan 2021 03:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9h4AKg5XAoX3W6x1GJbMkrCS2pqAAaTDswee0e3owN8=; b=JpLE75htEHbrKGDnLLwvIlbf3w
        ZKuaolnNAZef+NRjQUnniPaFqngzXJS59gp3RjFCVzXY1auarP/T/K3KwTXgBf81s42ojsdM68goB
        pS/pED4GmfOV5l1wHETOLKiLWj+t6qUZFD3hCk/0jqie+/CZ4tL47PUnRWWCNjdiXgLkb3mjGyjT9
        MgbqZSzIydNgjBGuwsqhz9xaGL0tR2xiA8wDzwLO5P8xe79B8kXTBtBQqqwsnJA7Wbj6uUP2wfYUD
        lgfD/+tb1Rmfi4Z6MLSQjQ2wy4t0UW1W4/oYXW/CdTvtAvXFpa3U1oZ4nwchcv0c1uiaFcssO1jnP
        JbO2x6uQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l3dh6-002uwe-OS; Sun, 24 Jan 2021 11:36:44 +0000
Date:   Sun, 24 Jan 2021 11:36:36 +0000
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
Subject: Re: [PATCH v10 04/12] mm/ioremap: rename ioremap_*_range to
 vmap_*_range
Message-ID: <20210124113636.GD694255@infradead.org>
References: <20210124082230.2118861-1-npiggin@gmail.com>
 <20210124082230.2118861-5-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124082230.2118861-5-npiggin@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jan 24, 2021 at 06:22:22PM +1000, Nicholas Piggin wrote:
> This will be used as a generic kernel virtual mapping function, so
> re-name it in preparation.

The new name looks ok, but shouldn't it also move to vmalloc.c with
the more generic name and purpose?
