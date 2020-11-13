Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17AE72B1AA7
	for <lists+linux-arch@lfdr.de>; Fri, 13 Nov 2020 13:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgKMMEV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Nov 2020 07:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgKMLjg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Nov 2020 06:39:36 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3650C061A4B;
        Fri, 13 Nov 2020 03:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=dkK1YwAwJr6lV1mVrW1fmTp7v30s/RnaMPTh1AauuPg=; b=jwH7GTwDtA84bsBUM9o4vuVEkW
        ZeAbQl6jHxR4+xuUnQIwtknl/di1ZCq40VnwcPZGKy6TagfKuXAh2fLZFicppmulcXlgcvuvh2r8Z
        c7Jq9QnjzcgauBep3FWOb8Y6r9ilHINvVSS7Qr8hGcM5rRp/YYgOH46mSK1wDqLiQ/j8z6oYiPtjR
        GHsPJNEx1oZjKPh7asip5nIE4cHNqeeZeYff4h9vIWDqEyEyRT8YaKuAiYhvu1y9D65398AgCQEh9
        wjxeTXYYIYwvMtVz5qAgWpoPsHLhodoaF0AYy8HbUGpcUgGY25+iuVP4orPPVQ4Guk6Zn0qdt0SIy
        ZlHdpB2A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdXPM-0002Xm-HI; Fri, 13 Nov 2020 11:38:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 60E0D306102;
        Fri, 13 Nov 2020 12:38:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3D7702BCDBFD3; Fri, 13 Nov 2020 12:38:19 +0100 (CET)
Message-ID: <20201113113426.465239104@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 13 Nov 2020 12:19:03 +0100
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
Subject: [PATCH 2/5] mm: Introduce pXX_leaf_size()
References: <20201113111901.743573013@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A number of architectures have non-pagetable aligned huge/large pages.
For such architectures a leaf can actually be part of a larger TLB
entry.

Provide generic helpers to determine the TLB size of a page-table
leaf.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/pgtable.h |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1536,4 +1536,20 @@ typedef unsigned int pgtbl_mod_mask;
 #define pmd_leaf(x)	0
 #endif
 
+#ifndef pgd_leaf_size
+#define pgd_leaf_size(x) PGD_SIZE
+#endif
+#ifndef p4d_leaf_size
+#define p4d_leaf_size(x) P4D_SIZE
+#endif
+#ifndef pud_leaf_size
+#define pud_leaf_size(x) PUD_SIZE
+#endif
+#ifndef pmd_leaf_size
+#define pmd_leaf_size(x) PMD_SIZE
+#endif
+#ifndef pte_leaf_size
+#define pte_leaf_size(x) PAGE_SIZE
+#endif
+
 #endif /* _LINUX_PGTABLE_H */


