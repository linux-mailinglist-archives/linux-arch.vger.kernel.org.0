Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07A3301B68
	for <lists+linux-arch@lfdr.de>; Sun, 24 Jan 2021 12:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbhAXLe0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Jan 2021 06:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbhAXLeY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Jan 2021 06:34:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBE7C061573;
        Sun, 24 Jan 2021 03:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ACB8L1iH4Gc89YVix2D94YMUoC0lAHVoOtd7z7k4gbA=; b=UvTPXRec/KKC/vVCNhylGppLtA
        4gnsAaSCRXS7ZbiRj/1I81m2v5V7rxONcoEdtCoTFbPhgDZHWqhrqlE3hNoqnsm4OjM4RIo1+mhj2
        xdDThKzazfQmoaRm+CLVmPbdK+gi8y9nPSLzzgyA1jT+QjKm/0TTUCyPSND4zTKk/B1SFxUeDz2jC
        f44ediPoO5ZYs0CTAUMJUfXGkYxtD7rJ7IKWEa949RJ/6cdBlTeMd1I6z1Rp/78jzVhU+4RJot1/1
        bh3jTbubINajUJMB3xYPQI7D2cCbRTPnaHaGbhM/WhVXvHl4MRmeQ9Hyuu5O9hcbDD+uBJhA7Lxyd
        zddL0biA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l3ddB-002ufv-2n; Sun, 24 Jan 2021 11:32:39 +0000
Date:   Sun, 24 Jan 2021 11:32:33 +0000
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
Subject: Re: [PATCH v10 02/12] mm: apply_to_pte_range warn and fail if a
 large pte is encountered
Message-ID: <20210124113233.GB694255@infradead.org>
References: <20210124082230.2118861-1-npiggin@gmail.com>
 <20210124082230.2118861-3-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124082230.2118861-3-npiggin@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jan 24, 2021 at 06:22:20PM +1000, Nicholas Piggin wrote:
> apply_to_pte_range might mistake a large pte for bad, or treat it as a
> page table, resulting in a crash or corruption. Add a test to warn and
> return error if large entries are found.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
