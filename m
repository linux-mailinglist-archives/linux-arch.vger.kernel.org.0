Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1424F21F263
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jul 2020 15:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgGNNXz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jul 2020 09:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbgGNNXy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jul 2020 09:23:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA85C061755;
        Tue, 14 Jul 2020 06:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T7rggtXykXMc4C3uWwX+AsNgDJpkydxTqpZAtzGfPZw=; b=Kh3uWg7u8XQglQ4xrw+ceXYX8S
        CWYZSH7s+NgPkTUhlq3N/9wlFTdrJWTUnC9eq/G9rVKsKpa3nSNgKcvTJyVzIzkn5nUzA/PZoDzoU
        dLfUT4nS8snnIwOWcrOzkVucwrUhbZdhbvN+5Dr/QZ+Asez6AXurhhpzMkQ2139xhUsSPU2xWIIQQ
        7gxe6uFmEEyfFAzvaexTRkN7d5JSEbyo9mJKoddyBTvgQyAvEWHAF6x06dSySkk64A+k4SRf2+Nf6
        wB4G28sTRoDwXUGqj2sP0qL2DpJotZ27Aa94peKoOJ0bT/0WvZ+cCmHU5fXW+e2BbzVlAJRePIXXd
        TkX/DowA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvKuM-0004mD-H6; Tue, 14 Jul 2020 13:23:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BF165302753;
        Tue, 14 Jul 2020 15:23:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AB5BC2BE34E09; Tue, 14 Jul 2020 15:23:41 +0200 (CEST)
Date:   Tue, 14 Jul 2020 15:23:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        X86 ML <x86@kernel.org>
Subject: Re: [RFC PATCH 7/7] lazy tlb: shoot lazies, a non-refcounting lazy
 tlb option
Message-ID: <20200714132341.GY10769@hirez.programming.kicks-ass.net>
References: <1594708054.04iuyxuyb5.astroid@bobo.none>
 <6D3D1346-DB1E-43EB-812A-184918CCC16A@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6D3D1346-DB1E-43EB-812A-184918CCC16A@amacapital.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 14, 2020 at 05:46:05AM -0700, Andy Lutomirski wrote:
> x86 has this exact problem. At least no more than 64*8 CPUs share the cache line :)

I've seen patches for a 'sparse' bitmap to solve related problems.

It's basically the same code, except it multiplies everything (size,
bit-nr) by a constant to reduce the number of active bits per line.

This sadly doesn't take topology into account, but reducing contention
is still good ofcourse.
