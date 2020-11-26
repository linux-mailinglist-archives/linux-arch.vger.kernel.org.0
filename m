Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DA62C53AD
	for <lists+linux-arch@lfdr.de>; Thu, 26 Nov 2020 13:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388916AbgKZMMN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Nov 2020 07:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731806AbgKZMMN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Nov 2020 07:12:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6E1C0613D4;
        Thu, 26 Nov 2020 04:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=x9yV4MsXYN4evctZVqtcAzH/k7fEYwzyTJA1mVQojdk=; b=b/jro0EAjRk9MVIUYG9HS+fW/3
        hQeipYAoaciICIAXFSNoYpO8L00XWfDKB3ZewmWxlbskGKaId+H1j2tegtmICsyq5ZtWQRvf/t0z3
        8o3IhsZmflSd+ew+6aO3V8Fp/MW9nhqtz1931ruCjacJjznuxw0AIY3gQom/yH20bZ60oIf/g0qeG
        cf/tfPV5eR03FvXWAVxAq4hrL2urC9LwM89RDGnWP9guOOTcPfNh6EuU1yyrM1rcCidRqTWO22yjg
        wDXdNqjxI2TqnVuZDk++W1rFZdWwNlBCj0toDHq8mLhsa2vGU42auBG0qUqKyte2RQLqvT6oldcNn
        QVIe2Kig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiG7b-0000OH-S8; Thu, 26 Nov 2020 12:11:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E3D0530767C;
        Thu, 26 Nov 2020 13:11:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 087362D167BEA; Thu, 26 Nov 2020 13:11:34 +0100 (CET)
Message-ID: <20201126121121.364451610@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 26 Nov 2020 13:01:20 +0100
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
Subject: [PATCH v2 6/6] powerpc/8xx: Implement pXX_leaf_size() support
References: <20201126120114.071913521@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Christophe Leroy wrote:

> I can help with powerpc 8xx. It is a 32 bits powerpc. The PGD has 1024
> entries, that means each entry maps 4M.
>
> Page sizes are 4k, 16k, 512k and 8M.
>
> For the 8M pages we use hugepd with a single entry. The two related PGD
> entries point to the same hugepd.
>
> For the other sizes, they are in standard page tables. 16k pages appear
> 4 times in the page table. 512k entries appear 128 times in the page
> table.
>
> When the PGD entry has _PMD_PAGE_8M bits, the PMD entry points to a
> hugepd with holds the single 8M entry.
>
> In the PTE, we have two bits: _PAGE_SPS and _PAGE_HUGE
>
> _PAGE_HUGE means it is a 512k page
> _PAGE_SPS means it is not a 4k page
>
> The kernel can by build either with 4k pages as standard page size, or
> 16k pages. It doesn't change the page table layout though.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/powerpc/include/asm/nohash/32/pte-8xx.h |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -135,6 +135,29 @@ static inline pte_t pte_mkhuge(pte_t pte
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


