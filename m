Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99A66DAA79
	for <lists+linux-arch@lfdr.de>; Fri,  7 Apr 2023 10:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239663AbjDGIyp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Apr 2023 04:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjDGIyo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Apr 2023 04:54:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59F59B;
        Fri,  7 Apr 2023 01:54:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A30061055;
        Fri,  7 Apr 2023 08:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA56C433EF;
        Fri,  7 Apr 2023 08:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680857682;
        bh=EvA6NlZ91K5IE11Qbj4sH4qqEtPca3tMfVWSQYjOy2A=;
        h=From:To:Cc:Subject:Date:From;
        b=KYcRe90vJBmgZDk8WX2B03GdBkIJFC5DBlP9VgWOsTNpmM3Q9OSey6MhDvrJH1DiC
         Q77Y0KB5RvKe16Rctbo8naMajPOW+XnM9WvnkGRcMfD4HWNM04T9ar3zgyd1CfZiGS
         DUCaZ5Gk2FYEv01y7XEPSLfAKVj0JtJY0a1TUs7HRty/K/pQTR8PudGG6EMyc38Oe3
         h1ARV9YMIazMG1eJ2flkOQAo8o433T1zq4VvrBkDjQqCgvH3Ffq8pf55johrWeSyXX
         ogvCbklSdbgjMBV0GNiojB2qyMvW7LRrzH0MspCZPg8LjkXfAXD1lWs+VJb6gakpr3
         0uNIbfq0Az9aw==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] csky: mmu: Prevent spurious page faults
Date:   Fri,  7 Apr 2023 04:54:34 -0400
Message-Id: <20230407085434.348938-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

C-SKY MMU would pre-fetch invalid pte entries, and it could work with
flush_tlb_fix_spurious_fault, but the additional page fault exceptions
would reduce performance. So flushing the entry of the TLB would prevent
the following spurious page faults. Here is the test code:

define DATA_LEN  4096
define COPY_NUM  (504*100)

unsigned char src[DATA_LEN*COPY_NUM] = {0};
unsigned char dst[DATA_LEN*COPY_NUM] = {0};

unsigned char func_src[DATA_LEN*COPY_NUM] = {0};
unsigned char func_dst[DATA_LEN*COPY_NUM] = {0};

void main(void)
{
	int j;
	for (j = 0; j < COPY_NUM; j++)
		memcpy(&dst[j*DATA_LEN], &src[j*DATA_LEN], 4);
}

perf stat -e page-faults ./main.elf

The amount of page fault traps would be reduced in half with the patch.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/csky/abiv1/cacheflush.c | 2 ++
 arch/csky/abiv2/cacheflush.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/csky/abiv1/cacheflush.c b/arch/csky/abiv1/cacheflush.c
index fb91b069dc69..6f38cc7944e1 100644
--- a/arch/csky/abiv1/cacheflush.c
+++ b/arch/csky/abiv1/cacheflush.c
@@ -40,6 +40,8 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
 	unsigned long pfn = pte_pfn(*ptep);
 	struct page *page;
 
+	flush_tlb_page(vma, addr);
+
 	if (!pfn_valid(pfn))
 		return;
 
diff --git a/arch/csky/abiv2/cacheflush.c b/arch/csky/abiv2/cacheflush.c
index 39c51399dd81..ff39c897c820 100644
--- a/arch/csky/abiv2/cacheflush.c
+++ b/arch/csky/abiv2/cacheflush.c
@@ -12,6 +12,8 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 	unsigned long addr;
 	struct page *page;
 
+	flush_tlb_page(vma, address);
+
 	if (!pfn_valid(pte_pfn(*pte)))
 		return;
 
-- 
2.36.1

