Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600822C53AB
	for <lists+linux-arch@lfdr.de>; Thu, 26 Nov 2020 13:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388728AbgKZMML (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Nov 2020 07:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731806AbgKZMMK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Nov 2020 07:12:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F12C0617A7;
        Thu, 26 Nov 2020 04:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=WXAvlj8sBk2RdzEpcLbJIMj6YxrEqCvZ8aLKdoJEykM=; b=vBt34BckTzuxfPdRs6WzS6jl4U
        VMOgpb4TEclazpBWZFkBbC8RDZzxfyaCCsqZTH10v33Y9GOCdAchDmgd6bC8otUGCCPj1bOt0oACC
        u10faOlb2zRaRVENzRze4mruA5lUFRcTwut9JpdIhzKkqPyyAet1vZRoUhpTwN3KsL6Xuh2qhDYsb
        MNxFGsfN+kP/94UUc8oj7U/AWLpIgnf6qmwssN0L3COcdvoIaJNwgXkMSzyjn0zvb9KjalQIBX1Fq
        5utgHyiFydFkKzl2tMDsnnLgOlK/BgCGb/3/drFLdfgrh8UTj+JUn/oJ6fDra3kDabeuw3NgnPvj5
        IcE5bbnA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiG7c-0000OT-Ol; Thu, 26 Nov 2020 12:11:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1342330280E;
        Thu, 26 Nov 2020 13:11:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EBF8E25F0FB42; Thu, 26 Nov 2020 13:11:33 +0100 (CET)
Message-ID: <20201126121121.102580109@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 26 Nov 2020 13:01:16 +0100
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
Subject: [PATCH v2 2/6] mm: Introduce pXX_leaf_size()
References: <20201126120114.071913521@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A number of architectures have non-pagetable aligned huge/large pages.
For such architectures a leaf can actually be part of a larger entry.

Provide generic helpers to determine the size of a page-table leaf.

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
+#define pgd_leaf_size(x) (1ULL << PGDIR_SHIFT)
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


