Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67592B4BD8
	for <lists+linux-arch@lfdr.de>; Mon, 16 Nov 2020 17:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731709AbgKPQ5Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Nov 2020 11:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729629AbgKPQ5Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Nov 2020 11:57:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D122BC0613CF;
        Mon, 16 Nov 2020 08:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vVmVS+ZLD4y6jfU+uTyXnLUroIERo1h2ZpfnRA9jMKc=; b=lEeB7IzByDr301YPeJ40VBxNvA
        CtrkOR9QCt3ARajDnOfqwNHdM5ieJEShyAB05oqrbEOfSoQmGLpyInWcjIUwCdHS+CqhwQNX5AFwq
        sJM6ZL685xdaGd3dj8fB3568d9YRcoWUa2yyw1rxpN0qQZlcPqAPr9p1DaHZEuYsUN/0onJJ8g5/p
        zviV3Oo9s73aXyrWzOa2FmL8zFShtC7st/xxEwPa1/MTcren+Z34TdPqL+13orQGhyGCwwxNuiPA7
        HCZiTKZh+47wdY6GZ+pKgqrivXu3IKb6KDlxju1SqLdbkEsg+QyQv1NVGga/0MnXPI52fdzgXIK4Q
        qZRj+aSA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kehoS-0006Im-E5; Mon, 16 Nov 2020 16:57:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6DF3F301959;
        Mon, 16 Nov 2020 17:57:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5976F20282DFC; Mon, 16 Nov 2020 17:57:07 +0100 (CET)
Date:   Mon, 16 Nov 2020 17:57:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        kan.liang@linux.intel.com, mingo@kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, christophe.leroy@csgroup.eu,
        npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, will@kernel.org, aneesh.kumar@linux.ibm.com,
        sparclinux@vger.kernel.org, davem@davemloft.net,
        catalin.marinas@arm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH 0/5] perf/mm: Fix PERF_SAMPLE_*_PAGE_SIZE
Message-ID: <20201116165707.GI3121392@hirez.programming.kicks-ass.net>
References: <20201113111901.743573013@infradead.org>
 <20201116154357.bw64c5ie2kiu5l4x@box>
 <20201116155404.GD29991@casper.infradead.org>
 <eeec67f6-ea05-1115-f249-b6cdcf2c5e2c@intel.com>
 <20201116163213.GG29991@casper.infradead.org>
 <3f2239fe-367a-16de-fcb5-543d39f34c22@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f2239fe-367a-16de-fcb5-543d39f34c22@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 16, 2020 at 08:36:36AM -0800, Dave Hansen wrote:
> On 11/16/20 8:32 AM, Matthew Wilcox wrote:
> >>
> >> That's really the best we can do from software without digging into
> >> microarchitecture-specific events.
> > I mean this is perf.  Digging into microarch specific events is what it
> > does ;-)
> 
> Yeah, totally.

Sure, but the automatic promotion/demotion of TLB sizes is not visible
if you don't know what you startd out with.

> But, if we see a bunch of 4k TLB hit events, it's still handy to know
> that those 4k TLB hits originated from a 2M page table entry.  This
> series just makes sure that perf has the data about the page table
> mapping sizes regardless of what the microarchitecture does with it.

This. 
