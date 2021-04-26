Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43E336B14C
	for <lists+linux-arch@lfdr.de>; Mon, 26 Apr 2021 12:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbhDZKLM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Apr 2021 06:11:12 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:45292 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232178AbhDZKLM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Apr 2021 06:11:12 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 928C2403BA;
        Mon, 26 Apr 2021 10:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1619431830; bh=uEswIh8XDpKzdvjTYxcTqmddGeaHCUIclw9SpAlhPD0=;
        h=From:To:Cc:Subject:Date:From;
        b=C1gS9S1bwlJRh8Qkfn1AR/cQl8dISdmZT6S1yqmIi/ZN4Z3io7EvH6NOUFQcK9OK5
         X0kOaQTY1HcHwwMecBdUiX5b9pNoXyQKDGu8h483S1Bs6rELR5yRn3ZAOsGRr0q9/5
         DGG9LImi68MMl3Q+WPGhvKYYflPlCfiXcjYD3wRFqqxHmG98zdjnfshceVKjqYDil8
         7ETqdgSlzIGAE3EfW0AjB/GZdIrogIokkIyn5d4RQNNQlQvot4hGvOfpNKp0fbOpOW
         IUViNQBgn29/A9UJOdQE7Ijodn7zreIjYQyeJtwVAJAds+N6Xe6t894M7TneUQoh5l
         V0KsMh1Jy2SxA==
Received: from ru20arcgnu1.internal.synopsys.com (ru20arcgnu1.internal.synopsys.com [10.121.9.48])
        by mailhost.synopsys.com (Postfix) with ESMTP id A55A2A005E;
        Mon, 26 Apr 2021 10:10:27 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Vladimir Isaev <Vladimir.Isaev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rppt@linux.ibm.com,
        Vladimir Isaev <Vladimir.Isaev@synopsys.com>
Subject: [PATCH] ARC: Use max_high_pfn as a HIGHMEM zone border
Date:   Mon, 26 Apr 2021 13:10:04 +0300
Message-Id: <20210426101004.42695-1-isaev@synopsys.com>
X-Mailer: git-send-email 2.16.2
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Commit 4af22ded0ecf ("arc: fix memory initialization for systems with two
memory banks") fixed highmem, but not for PAE case when highmem is
actually bigger than lowmem.

Signed-off-by: Vladimir Isaev <isaev@synopsys.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arc/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index ce07e697916c..59bad6f94105 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -157,7 +157,7 @@ void __init setup_arch_memory(void)
 	min_high_pfn = PFN_DOWN(high_mem_start);
 	max_high_pfn = PFN_DOWN(high_mem_start + high_mem_sz);
 
-	max_zone_pfn[ZONE_HIGHMEM] = min_low_pfn;
+	max_zone_pfn[ZONE_HIGHMEM] = max_high_pfn;
 
 	high_memory = (void *)(min_high_pfn << PAGE_SHIFT);
 
-- 
2.16.2

