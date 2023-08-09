Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC56774FC9
	for <lists+linux-arch@lfdr.de>; Wed,  9 Aug 2023 02:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjHIA1T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Aug 2023 20:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjHIA1T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Aug 2023 20:27:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739CE10C8;
        Tue,  8 Aug 2023 17:27:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E401F62872;
        Wed,  9 Aug 2023 00:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82209C433C8;
        Wed,  9 Aug 2023 00:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691540837;
        bh=S9A8lsMPD5vafBC3exul64JZFYrfYwASuWTO2d/SczI=;
        h=From:To:Cc:Subject:Date:From;
        b=prZMMinNj84sV1SosgrzU6L4y95I4VW73g2owfDDcTnql7djpQD50G0OvSMQ/i3tv
         6BcPAWeyKwP+2kppZFYRUkioPsiEj758yt8PIcLt/miPHMzbnHMfX3eF0IGAZMsCS3
         1ue3/vL8OMMGUYoYW1yvZ3jEnoTvIvKsek6+17jucPinvgq7dsApK1vcw05RCE8qPd
         BRk31vQ6EoH3RWdtJGwnuTwGiS6MrsDHF6m/q4MEIRnZZxvFVLGain5vcRJ9G3Ej+o
         vl+9NnpJA2MRnKbE0+QiRfMxKoGdyg7WSASokdrqxJuzKCQ8g6PQ7WWiQYGo4sXCId
         Fhsu1Vv8+0gBw==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] csky: pgtable: Invalidate stale I-cache lines in update_mmu_cache
Date:   Tue,  8 Aug 2023 20:27:07 -0400
Message-Id: <20230809002707.1190435-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The final icache_flush was in the update_mmu_cache, and update_mmu_cache
is after the set_pte_at. Thus, when CPU0 sets the pte,  the other CPU
would see it before the icache_flush broadcast happens, and their
icaches may have cached stale VIPT cache lines in their I-caches. When
address translation was ready for the new cache line, they will use the
stale data of icache, not the fresh one of the dcache.

The csky instruction cache is VIPT, and it needs an origin virtual
address to invalidate the virtual address index entries of cache ways.
The current implementation uses a temporary mapping mechanism -
kmap_atomic, which returns a new virtual address for invalidation. But,
the original virtual address cache line may still in the I-cache.

So force invalidation I-cache in update_mmu_cache, and prevent
flush_dcache when there is an EXEC page. This bug was detected in the
4*c860 SMP system, and this patch could pass the stress test.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/csky/abiv2/cacheflush.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/csky/abiv2/cacheflush.c b/arch/csky/abiv2/cacheflush.c
index 9923cd24db58..500eb8f69397 100644
--- a/arch/csky/abiv2/cacheflush.c
+++ b/arch/csky/abiv2/cacheflush.c
@@ -27,11 +27,9 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 
 	addr = (unsigned long) kmap_atomic(page);
 
+	icache_inv_range(address, address + PAGE_SIZE);
 	dcache_wb_range(addr, addr + PAGE_SIZE);
 
-	if (vma->vm_flags & VM_EXEC)
-		icache_inv_range(addr, addr + PAGE_SIZE);
-
 	kunmap_atomic((void *) addr);
 }
 
-- 
2.36.1

