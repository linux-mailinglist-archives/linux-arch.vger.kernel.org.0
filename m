Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA9636C5E5
	for <lists+linux-arch@lfdr.de>; Tue, 27 Apr 2021 14:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbhD0MO4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Apr 2021 08:14:56 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:45520 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235410AbhD0MO4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Apr 2021 08:14:56 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BDFAEC0552;
        Tue, 27 Apr 2021 12:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1619525653; bh=KRq0A/+QMHj5BLNmcw2miTkzyZiUHS4WDq7zHqV5LRg=;
        h=From:To:Cc:Subject:Date:From;
        b=DEgE3TErxy9aZN26Qcm5kU1BgX5NR3HwR+1aS4xNW9Uosf5lcpyVAFKbfRYJ9CnjY
         Vr2nwDhfnpnC51OzFJSDg6xTr8eAaQiNLqRgeMp8hpT51y/YX46GDT79LCokdPhokd
         VneN74QM5RrQdkRXk6pZdBMZsDbiNm7TYUsCslwSbGChjE5T0FIzPTVvA0Qz67MKmB
         8ktP2a9wD+CkrB/LoUHrHvSS1XQqcS6HRk6KriAtHgLI12jUyJnLt3yfoxjoEkiE9w
         HnEe/FouDKZGFaG9EXVVaUENU9hhv9wezeoOm0PUei2VHs/BLqhsI2FOJeQcxVHg0p
         ABZcpiljJkX4A==
Received: from ru20arcgnu1.internal.synopsys.com (ru20arcgnu1.internal.synopsys.com [10.121.9.48])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5B1C6A005C;
        Tue, 27 Apr 2021 12:14:07 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Vladimir Isaev <Vladimir.Isaev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rppt@linux.ibm.com,
        Vladimir Isaev <Vladimir.Isaev@synopsys.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH v2] ARC: Use max_high_pfn as a HIGHMEM zone border
Date:   Tue, 27 Apr 2021 15:13:54 +0300
Message-Id: <20210427121354.3620-1-isaev@synopsys.com>
X-Mailer: git-send-email 2.16.2
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Commit 4af22ded0ecf ("arc: fix memory initialization for systems
with two memory banks") fixed highmem, but for the PAE case it causes
bug messages:

BUG: Bad page state in process swapper  pfn:80000
page:(ptrval) refcount:0 mapcount:1 mapping:00000000 index:0x0 pfn:0x80000
flags: 0x0()
raw: 00000000 00000100 00000122 00000000 00000000 00000000 00000000 00000000
raw: 00000000
page dumped because: nonzero mapcount
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 5.12.0-rc5-00003-g1e43c377a79f #1

Stack Trace:
  arc_unwind_core+0xe8/0x118
Disabling lock debugging due to kernel taint

This is because the fix expects highmem to be always less than
lowmem and uses min_low_pfn as an upper zone border for highmem.

max_high_pfn should be ok for both highmem and highmem+PAE cases.

Signed-off-by: Vladimir Isaev <isaev@synopsys.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
---
Changes for v2:
 - Revised commit message and added comment to code
---
 arch/arc/mm/init.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index ce07e697916c..1bcc6985b9a0 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -157,7 +157,16 @@ void __init setup_arch_memory(void)
 	min_high_pfn = PFN_DOWN(high_mem_start);
 	max_high_pfn = PFN_DOWN(high_mem_start + high_mem_sz);
 
-	max_zone_pfn[ZONE_HIGHMEM] = min_low_pfn;
+	/*
+	 * max_high_pfn should be ok here for both HIGHMEM and HIGHMEM+PAE.
+	 * For HIGHMEM without PAE max_high_pfn should be less than
+	 * min_low_pfn to guarantee that these two regions don't overlap.
+	 * For PAE case highmem is greater than lowmem, so it is natural
+	 * to use max_high_pfn.
+	 *
+	 * In both cases, holes should be handled by pfn_valid().
+	 */
+	max_zone_pfn[ZONE_HIGHMEM] = max_high_pfn;
 
 	high_memory = (void *)(min_high_pfn << PAGE_SHIFT);
 
-- 
2.16.2

