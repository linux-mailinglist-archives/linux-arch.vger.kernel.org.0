Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61A44884A9
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 17:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbiAHQot (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 11:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234699AbiAHQon (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 11:44:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC5EC061746
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 08:44:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC27EB80B42
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 16:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADC3C36AE3;
        Sat,  8 Jan 2022 16:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641660280;
        bh=x2bPhjVOBxVWcMrIjPF084KnyexnW3t58B9hfB9b+7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=If/YBksUFp4siLcDN32aGTZYhYp8jKQmFbx/sACXi1qXOPrHk1oe2qmd5xmmJpaXc
         9iYEIUy4PgG5ABTeNST4TSNCFLtHSJHo1hTtD5dK75jnum1hKbCu2SZo4HbR1XT5AP
         qeV7HTWOS42HaFmKroGlhmqqLd3HSM8bSNynBCfSnE9yXm4LA6BsH7STIOehwMJSQw
         AfmRI6Iq40t0b7fHdld8UPyC7akRCFoBzSV11sSKYd5uTQaXoC8Juz9paQ3R8m1L3K
         YBFNZ/pl2PPzCgdazBePXcOqonqdPRkkZzCJHoGQq+mkzYpQ40aHoi38cDX90Vh8+9
         mq+2O2hCuwyyA==
From:   Andy Lutomirski <luto@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>, x86@kernel.org,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 21/23] x86/mm: Use unlazy_mm_irqs_off() in TLB flush IPIs
Date:   Sat,  8 Jan 2022 08:44:06 -0800
Message-Id: <3f3daaf3df26e963a38f4d7d05069e866cb6e3e7.1641659630.git.luto@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641659630.git.luto@kernel.org>
References: <cover.1641659630.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When IPI-flushing a lazy mm, we switch away from the lazy mm.  Use
unlazy_mm_irqs_off() so the scheduler knows we did this.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/mm/tlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index e502565176b9..225b407812c7 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -843,7 +843,7 @@ static void flush_tlb_func(void *info)
 		 * This should be rare, with native_flush_tlb_multi() skipping
 		 * IPIs to lazy TLB mode CPUs.
 		 */
-		switch_mm_irqs_off(NULL, &init_mm, NULL);
+		unlazy_mm_irqs_off();
 		return;
 	}
 
-- 
2.33.1

