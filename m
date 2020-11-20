Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9942BAA01
	for <lists+linux-arch@lfdr.de>; Fri, 20 Nov 2020 13:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgKTMUk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Nov 2020 07:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbgKTMUj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Nov 2020 07:20:39 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4DFC0613CF;
        Fri, 20 Nov 2020 04:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=RieTlZ511oNdtW4GxNUs6a6Utuq22ytoeluqJUu+SVU=; b=K6Unqb6n6jQf0gaapg8CDg1AY+
        pOxPtrWgGIPvARaM+xG3TbG/yi7iEeVecnro+xj5V+AmQBnFUWyVBYRBY2+emfpYcgPXcdbAkrfw+
        ruHS3YeUGEzTfOU4M7HSDffEVhetfs0wX5Qoyt9soEjXEq/eAmMPqVyqhIEGSbidhvQaArLCiRlKB
        PXWmB9sqCBWdAVG2lYnUDQz8v7WYxDoAbzVqwCzEW9KQqDWCoNimAtvCtxGnTekm4pISsltD78NKt
        Lenk03xpvVsBBBuIKZLy+41Tv8tdcNTKBk/i3U6dvIIQmJvDJtB4n1qrOyTWwcE4vOgjBUgMyV5dR
        j9AII6Kg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kg5OZ-0005e0-AQ; Fri, 20 Nov 2020 12:20:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CF5B93012DC;
        Fri, 20 Nov 2020 13:20:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B33DF210782E4; Fri, 20 Nov 2020 13:20:04 +0100 (CET)
Date:   Fri, 20 Nov 2020 13:20:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kan.liang@linux.intel.com, mingo@kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, will@kernel.org,
        willy@infradead.org, aneesh.kumar@linux.ibm.com,
        sparclinux@vger.kernel.org, davem@davemloft.net,
        catalin.marinas@arm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH 0/5] perf/mm: Fix PERF_SAMPLE_*_PAGE_SIZE
Message-ID: <20201120122004.GG3021@hirez.programming.kicks-ass.net>
References: <20201113111901.743573013@infradead.org>
 <16ad8cab-08e2-27a7-6803-baadc6b8721b@csgroup.eu>
 <2a32b00b-2214-3283-58e0-9cb0ff4bd728@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a32b00b-2214-3283-58e0-9cb0ff4bd728@csgroup.eu>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 20, 2020 at 12:18:22PM +0100, Christophe Leroy wrote:
> Hi Peter,
> 
> Le 13/11/2020 à 14:44, Christophe Leroy a écrit :
> > Hi
> > 
> > Le 13/11/2020 à 12:19, Peter Zijlstra a écrit :
> > > Hi,
> > > 
> > > These patches provide generic infrastructure to determine TLB page size from
> > > page table entries alone. Perf will use this (for either data or code address)
> > > to aid in profiling TLB issues.
> > > 
> > > While most architectures only have page table aligned large pages, some
> > > (notably ARM64, Sparc64 and Power) provide non page table aligned large pages
> > > and need to provide their own implementation of these functions.
> > > 
> > > I've provided (completely untested) implementations for ARM64 and Sparc64, but
> > > failed to penetrate the _many_ Power MMUs. I'm hoping Nick or Aneesh can help
> > > me out there.
> > > 
> > 
> > I can help with powerpc 8xx. It is a 32 bits powerpc. The PGD has 1024
> > entries, that means each entry maps 4M.
> > 
> > Page sizes are 4k, 16k, 512k and 8M.
> > 
> > For the 8M pages we use hugepd with a single entry. The two related PGD
> > entries point to the same hugepd.
> > 
> > For the other sizes, they are in standard page tables. 16k pages appear
> > 4 times in the page table. 512k entries appear 128 times in the page
> > table.
> > 
> > When the PGD entry has _PMD_PAGE_8M bits, the PMD entry points to a
> > hugepd with holds the single 8M entry.
> > 
> > In the PTE, we have two bits: _PAGE_SPS and _PAGE_HUGE
> > 
> > _PAGE_HUGE means it is a 512k page
> > _PAGE_SPS means it is not a 4k page
> > 
> > The kernel can by build either with 4k pages as standard page size, or
> > 16k pages. It doesn't change the page table layout though.
> > 
> > Hope this is clear. Now I don't really know to wire that up to your series.
> 
> Does my description make sense ? Is there anything I can help with ?

It did, and I had vague memories from when we fixed that pgd_t issue.
I've just not had time to dig through the powerpc code yet to find the
right mmu header to stick it in.

I was meaning to get another version of these patches posted this week,
but time keeps slipping away, I'll try.
