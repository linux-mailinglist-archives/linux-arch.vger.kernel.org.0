Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2922C53B9
	for <lists+linux-arch@lfdr.de>; Thu, 26 Nov 2020 13:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388957AbgKZMMY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Nov 2020 07:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731806AbgKZMMQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Nov 2020 07:12:16 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C753C0613D4;
        Thu, 26 Nov 2020 04:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=rpbquXH+0OLb9Ygx9Cjnl4wM8Crhm2/za8S9KIMZWMw=; b=d8ikFQ5g9M8lBrRxWBmLTEkJDp
        VtICYG1lRvUYUCUKr1BN1rH5eaPykQr9wx7UdLxj1LfOfrqIjYl0Z5jFvOSUB/ghUdKTpO11zcGbT
        utQNSFHw4QUryo41ulTed+h+zQ+gzYo258idCY/G3jxQlzPYgTtrfO+eD8SpMXj8iZHHqRgU+cKsS
        k4AvReMGVW4kp01jhyYq9tbgf0FxvTgPRuYjicUbVV7F8pT2jjLgS8nw2A4OqvrluwdX2dx7g35Du
        qe5qc5fulD1C/pVIjenroQAKrK9p1+mC7ZGz2zBi0c0XKnkzKrRPwRGEzaZyz6teVOCMNtiSmwX28
        qk8lisXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiG7c-0006M3-SX; Thu, 26 Nov 2020 12:11:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1BDE43059DE;
        Thu, 26 Nov 2020 13:11:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 003CE2D167BE7; Thu, 26 Nov 2020 13:11:33 +0100 (CET)
Message-ID: <20201126121121.226210959@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 26 Nov 2020 13:01:18 +0100
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
Subject: [PATCH v2 4/6] arm64/mm: Implement pXX_leaf_size() support
References: <20201126120114.071913521@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ARM64 has non-pagetable aligned large page support with PTE_CONT, when
this bit is set the page is part of a super-page. Match the hugetlb
code and support these super pages for PTE and PMD levels.

This enables PERF_SAMPLE_{DATA,CODE}_PAGE_SIZE to report accurate
pagetable leaf sizes.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm64/include/asm/pgtable.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -503,6 +503,9 @@ extern pgprot_t phys_mem_access_prot(str
 				 PMD_TYPE_SECT)
 #define pmd_leaf(pmd)		pmd_sect(pmd)
 
+#define pmd_leaf_size(pmd)	(pmd_cont(pmd) ? CONT_PMD_SIZE : PMD_SIZE)
+#define pte_leaf_size(pte)	(pte_cont(pte) ? CONT_PTE_SIZE : PAGE_SIZE)
+
 #if defined(CONFIG_ARM64_64K_PAGES) || CONFIG_PGTABLE_LEVELS < 3
 static inline bool pud_sect(pud_t pud) { return false; }
 static inline bool pud_table(pud_t pud) { return true; }


