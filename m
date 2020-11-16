Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56FC82B4B36
	for <lists+linux-arch@lfdr.de>; Mon, 16 Nov 2020 17:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbgKPQci (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Nov 2020 11:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgKPQci (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Nov 2020 11:32:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E50C0613CF;
        Mon, 16 Nov 2020 08:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iB0y9J1IMDI66YKSWITVEM2aiz/Z5fCZJNJJPMLMkso=; b=MJkQpTrW56osExBi/dMXVJnpIw
        NIlim9BCJT5F5tgyRdOgmQc+boPZNK9p2apNt7gPcoXA8jA0ovSWzSY10zPEiqSr3+oMaxVZb70AP
        oE1d8y1M8GC1BVl1Wrgr8+EiIX5BHNeGxGVFYf5OwmuUoHZ5G+9NE3FNqws2aN4aXapXlr3S1WyFf
        MbxONtk+/fXp/gZ91aXIK4qBADADnY8JNHkvgF+q4Ey3/9x69E8S246Qfv4I+hyERDvT2eZjzBth0
        O8m5XecVDdfXHdAapE9jDEwN00NEgE6m/+zq3aerrhQasuizLEzJYlqT7tFfNyF4+14x1giM/kFn9
        KoCNtN9w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kehQL-0004lE-3b; Mon, 16 Nov 2020 16:32:13 +0000
Date:   Mon, 16 Nov 2020 16:32:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20201116163213.GG29991@casper.infradead.org>
References: <20201113111901.743573013@infradead.org>
 <20201116154357.bw64c5ie2kiu5l4x@box>
 <20201116155404.GD29991@casper.infradead.org>
 <eeec67f6-ea05-1115-f249-b6cdcf2c5e2c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeec67f6-ea05-1115-f249-b6cdcf2c5e2c@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 16, 2020 at 08:28:23AM -0800, Dave Hansen wrote:
> On 11/16/20 7:54 AM, Matthew Wilcox wrote:
> > It gets even more complicated with CPUs with multiple levels of TLB
> > which support different TLB entry sizes.  My CPU reports:
> > 
> > TLB info
> >  Instruction TLB: 2M/4M pages, fully associative, 8 entries
> >  Instruction TLB: 4K pages, 8-way associative, 64 entries
> >  Data TLB: 1GB pages, 4-way set associative, 4 entries
> >  Data TLB: 4KB pages, 4-way associative, 64 entries
> >  Shared L2 TLB: 4KB/2MB pages, 6-way associative, 1536 entries
> 
> It's even "worse" on recent AMD systems.  Those will coalesce multiple
> adjacent PTEs into a single TLB entry.  I think Alphas did something
> like this back in the day with an opt-in.

I debated mentioning that ;-)  We can detect in software whether that's
_possible_, but we can't detect whether it's *done* it.  I heard it
sometimes takes several faults on the 4kB entries for the CPU to decide
that it's beneficial to use a 32kB TLB entry.  But this is all rumour.

> Anyway, the changelog should probably replace:
> 
> > This enables PERF_SAMPLE_{DATA,CODE}_PAGE_SIZE to report accurate TLB
> > page sizes.
> 
> with something more like:
> 
> This enables PERF_SAMPLE_{DATA,CODE}_PAGE_SIZE to report accurate page
> table mapping sizes.
> 
> That's really the best we can do from software without digging into
> microarchitecture-specific events.

I mean this is perf.  Digging into microarch specific events is what it
does ;-)
