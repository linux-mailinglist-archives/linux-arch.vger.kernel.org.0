Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7062B1A33
	for <lists+linux-arch@lfdr.de>; Fri, 13 Nov 2020 12:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgKMLka (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Nov 2020 06:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgKMLjg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Nov 2020 06:39:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4608BC061A4C;
        Fri, 13 Nov 2020 03:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=jl8/r0xaMvasSwPtiqvuXDrfgB86XgTbuKStGFmkiqY=; b=TFLbTK0JP/5BAcXKX2HQt08pv9
        +yfdqZ45zKuzf9IDyKKPjB/o3TbxkGrOMnA79gVfHVP6tSs5G4asBxys+mFaGoEMWLuBcLO7hW0Zh
        BVJbQUkn1tosKYOXrYdlG4NsZaHX+wzJz2Q2DcYFfy6MPe2fw4ensHMnO66kO1pJQB0MAyy5ihv/p
        Mzv6U+/wH/1G2ro5d52EcghpQxybxZ90RovOSSa10Rlvbir/gBzAZ53PlVyso0pC9cQ1IpQr5+ozJ
        OLJWhjtmLBPhD5OSVPcl2Y7vlpY7NIpLM4h75aQjSgy6OhfHNPdj0Xn9qaRak6oiHAsDB2wRC4Flm
        rLXSbwMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdXPK-0001jN-TN; Fri, 13 Nov 2020 11:38:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 53967300238;
        Fri, 13 Nov 2020 12:38:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 363C72BB8B0D0; Fri, 13 Nov 2020 12:38:19 +0100 (CET)
Message-ID: <20201113111901.743573013@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 13 Nov 2020 12:19:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com, mingo@kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com
Cc:     christophe.leroy@csgroup.eu, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, will@kernel.org,
        willy@infradead.org, aneesh.kumar@linux.ibm.com,
        sparclinux@vger.kernel.org, davem@davemloft.net,
        catalin.marinas@arm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        peterz@infradead.org
Subject: [PATCH 0/5] perf/mm: Fix PERF_SAMPLE_*_PAGE_SIZE
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

These patches provide generic infrastructure to determine TLB page size from
page table entries alone. Perf will use this (for either data or code address)
to aid in profiling TLB issues.

While most architectures only have page table aligned large pages, some
(notably ARM64, Sparc64 and Power) provide non page table aligned large pages
and need to provide their own implementation of these functions.

I've provided (completely untested) implementations for ARM64 and Sparc64, but
failed to penetrate the _many_ Power MMUs. I'm hoping Nick or Aneesh can help
me out there.

