Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62E72C5254
	for <lists+linux-arch@lfdr.de>; Thu, 26 Nov 2020 11:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388371AbgKZKrj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Nov 2020 05:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388340AbgKZKri (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Nov 2020 05:47:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDC0C0613D4;
        Thu, 26 Nov 2020 02:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tFBEb0BLu3uXogjw3SOLqhrulKz6jh3zxahm8XIOiP8=; b=X3cXyvr1KiNTPPNYsE55p34qzs
        01WR57/NTCJJBTLnooSCiqxRLfe1NoFr12FKiB6sIEBBSutg9ejvt0PVkeecAF+mpv6dTf8ALS0Gm
        xhqbpCHFBeyIrf+sFcr5qLhcRmKH4/FE0Pt3zYF5jFf46D9MsXl8GMUOivcOmSz7vK+xfdAkyV351
        jzDDCgoug6jn/+HFsM1y/JKSSLVp9DlLQ8ZRbbpJ9c6bp/kBfbJCLFmcooHmQW9b98d3DJDJ2/FR0
        xeXgp6zkPj+bioLqm25WdK36TJtI5sB9sBZ3lALxjkdNEuHxVS3oL6SFnqB+2FlF9dqVtYpLh7738
        LsYFbjzA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiEnd-0003Eg-Ub; Thu, 26 Nov 2020 10:46:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 38B21306DD8;
        Thu, 26 Nov 2020 11:46:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 137AC20162619; Thu, 26 Nov 2020 11:46:51 +0100 (CET)
Date:   Thu, 26 Nov 2020 11:46:51 +0100
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
Message-ID: <20201126104651.GG3092@hirez.programming.kicks-ass.net>
References: <20201113111901.743573013@infradead.org>
 <16ad8cab-08e2-27a7-6803-baadc6b8721b@csgroup.eu>
 <2a32b00b-2214-3283-58e0-9cb0ff4bd728@csgroup.eu>
 <20201120122004.GG3021@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120122004.GG3021@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 20, 2020 at 01:20:04PM +0100, Peter Zijlstra wrote:

> > > I can help with powerpc 8xx. It is a 32 bits powerpc. The PGD has 1024
> > > entries, that means each entry maps 4M.
> > > 
> > > Page sizes are 4k, 16k, 512k and 8M.
> > > 
> > > For the 8M pages we use hugepd with a single entry. The two related PGD
> > > entries point to the same hugepd.
> > > 
> > > For the other sizes, they are in standard page tables. 16k pages appear
> > > 4 times in the page table. 512k entries appear 128 times in the page
> > > table.
> > > 
> > > When the PGD entry has _PMD_PAGE_8M bits, the PMD entry points to a
> > > hugepd with holds the single 8M entry.
> > > 
> > > In the PTE, we have two bits: _PAGE_SPS and _PAGE_HUGE
> > > 
> > > _PAGE_HUGE means it is a 512k page
> > > _PAGE_SPS means it is not a 4k page
> > > 
> > > The kernel can by build either with 4k pages as standard page size, or
> > > 16k pages. It doesn't change the page table layout though.
> > > 
> > > Hope this is clear. Now I don't really know to wire that up to your series.

Does the below accurately reflect things?

Let me go find a suitable cross-compiler ..

diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index 1581204467e1..fcc48d590d88 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -135,6 +135,29 @@ static inline pte_t pte_mkhuge(pte_t pte)
 }
 
 #define pte_mkhuge pte_mkhuge
+
+static inline unsigned long pgd_leaf_size(pgd_t pgd)
+{
+	if (pgd_val(pgd) & _PMD_PAGE_8M)
+		return SZ_8M;
+	return SZ_4M;
+}
+
+#define pgd_leaf_size pgd_leaf_size
+
+static inline unsigned long pte_leaf_size(pte_t pte)
+{
+	pte_basic_t val = pte_val(pte);
+
+	if (val & _PAGE_HUGE)
+		return SZ_512K;
+	if (val & _PAGE_SPS)
+		return SZ_16K;
+	return SZ_4K;
+}
+
+#define pte_leaf_size pte_leaf_size
+
 #endif
 
 #endif /* __KERNEL__ */
