Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E96A211AAF6
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 13:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbfLKMb3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Dec 2019 07:31:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51050 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbfLKMb3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Dec 2019 07:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WStPWl7EHmUdstQXR4srCPTzKuR9hsSl99Nmt3uj2dk=; b=LAce8X50AVM8BS3e/9HHGQ0CKf
        m7rfVkZyFP+8O4hYosBtqAQueS6cDsUUOkyzh7PbDlfU0GuXjAIQvYS+DCJK9epplpQg9jRoT7Kpr
        ezBEteoupovlta+/3oi0HJFFRyuqNY+z3qlBfq9+5hH2p3G9BNcFE7VRIsENIbFFA2KlKL+4hdirL
        djY8La6VYEpPziZmaAamU+jkNDEeKb9nipBkukW62zgz+j4rIJRWbPQ8xZfhOm95EL9w1xLGwFppO
        6qBGuNihvgQC5pRhZJcXuL2iy9WMjCXy6gLNyhpgonXpkRj6LAv1A9GHrUSKwRB60548MJhWNFjRZ
        WB0YOOoA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1if18z-0001PL-Tl; Wed, 11 Dec 2019 12:31:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 79841300F29;
        Wed, 11 Dec 2019 13:29:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 20C8A20137C8F; Wed, 11 Dec 2019 13:31:02 +0100 (CET)
Message-Id: <20191211122955.825865931@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 11 Dec 2019 13:07:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Burton <paulburton@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Richard Henderson <rth@twiddle.net>,
        Nick Hu <nickhu@andestech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH 03/17] asm-generic/tlb: Add missing CONFIG symbol
References: <20191211120713.360281197@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Without this the symbol will not actually end up in .config files.

Fixes: a30e32bd79e9 ("asm-generic/tlb: Provide generic tlb_flush() based on flush_tlb_mm()")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/Kconfig |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -402,6 +402,9 @@ config HAVE_RCU_TABLE_NO_INVALIDATE
 config HAVE_MMU_GATHER_PAGE_SIZE
 	bool
 
+config MMU_GATHER_NO_RANGE
+	bool
+
 config HAVE_MMU_GATHER_NO_GATHER
 	bool
 


