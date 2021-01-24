Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04DE301CD7
	for <lists+linux-arch@lfdr.de>; Sun, 24 Jan 2021 15:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbhAXOxB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Jan 2021 09:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbhAXOxB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Jan 2021 09:53:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDC1C061573;
        Sun, 24 Jan 2021 06:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0fqOjNcCL/MkI3sk7KGvZEuNxaClIpuc50C4dBrJHu0=; b=GQuHbRFjBiAoFWYlxDsw7V6j67
        2o8tNWNRZ/nUPyrBXHbF2T2dGy0W08n2sjMkry9zg9afOVkO7w7EkmyDIBzkuwovzgajvGIRTWFmy
        TnDN3OGpq6OYZMiEB5921fzSaI1NMw9l6D1App0aCCvDXPciS2eair+UlMOZ8ouSemanIQTl+KGdE
        LjGVWXI0gOJomkNBl9b5a+zfNTvx17JWyfK86/fli0zOQnMYbVqkNNGynQVZWVS0ye9VV0TE84M40
        xfH5D4IfjmKaJZFVRfgdAlmzfi/p+wNhSDRRm+JkqEFUypICZS9NdeFhZ9uvP32qeCMFO9JMan+If
        jW0Eg6ZQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l3gjf-003550-7y; Sun, 24 Jan 2021 14:51:31 +0000
Date:   Sun, 24 Jan 2021 14:51:27 +0000
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
Subject: Re: [PATCH v10 10/12] mm/vmalloc: add vmap_range_noflush variant
Message-ID: <20210124145127.GB733865@infradead.org>
References: <20210124082230.2118861-1-npiggin@gmail.com>
 <20210124082230.2118861-11-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124082230.2118861-11-npiggin@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jan 24, 2021 at 06:22:28PM +1000, Nicholas Piggin wrote:
> As a side-effect, the order of flush_cache_vmap() and
> arch_sync_kernel_mappings() calls are switched, but that now matches
> the other callers in this file.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
