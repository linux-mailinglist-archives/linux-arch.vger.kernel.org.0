Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75202B4BC7
	for <lists+linux-arch@lfdr.de>; Mon, 16 Nov 2020 17:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbgKPQzd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Nov 2020 11:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731088AbgKPQzc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Nov 2020 11:55:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA385C0613CF;
        Mon, 16 Nov 2020 08:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qwpmaY+3FLIw2My8lpkirBu6QWcmDVtCZWX9oSsd5pI=; b=sCjdaAN7YgUfR5Na4/L2rwidiM
        15tIgEAD8fxyHNfjXSLVkszMh4VTvOdC4da0kQq33F5KN4YSPiZ1pNJ9L3rNDo7hadHux4HVGEMek
        gK6TmC0vH1duDtKuQzo1ZYcV7W6fvsORpiGDSkx6N/FLHn6JtiFfK079qdGhTFdukuBnFzojnMJEG
        soexUqk6dXlXrsFdSZ0FCimGpoCbHwE4Er09GJ3Cs7tnhIyuNpJXdhi3Fp9CJDQA/FmtXMCTtp2Bh
        YPYI07+Be6K6ArB4N8yV3nsqZFzjHUdnpniYgtCJxv2v3RU7k1q3I0QDvlbvjYpcQLy1IaBJccdYa
        3w3WYxuw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kehmU-0006C5-2F; Mon, 16 Nov 2020 16:55:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3D864301959;
        Mon, 16 Nov 2020 17:55:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 28BB820282DFC; Mon, 16 Nov 2020 17:55:04 +0100 (CET)
Date:   Mon, 16 Nov 2020 17:55:04 +0100
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
Message-ID: <20201116165504.GH3121392@hirez.programming.kicks-ass.net>
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
> 
> Anyway, the changelog should probably replace:

ARM64 does too.

> > This enables PERF_SAMPLE_{DATA,CODE}_PAGE_SIZE to report accurate TLB
> > page sizes.
> 
> with something more like:
> 
> This enables PERF_SAMPLE_{DATA,CODE}_PAGE_SIZE to report accurate page
> table mapping sizes.

Sure.
