Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E4B6093A9
	for <lists+linux-arch@lfdr.de>; Sun, 23 Oct 2022 15:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiJWNd7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 23 Oct 2022 09:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiJWNd4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 23 Oct 2022 09:33:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762C969181;
        Sun, 23 Oct 2022 06:33:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1134060EA2;
        Sun, 23 Oct 2022 13:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DEDC433C1;
        Sun, 23 Oct 2022 13:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666532034;
        bh=HM2oYzakfdXfJJzbe5qVxXYIO2tAmfA0Z3AF7nO+COs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J+LaVmkYWNM8WRyG7XrRI2PdMKBhVkMak40G66C7VtwH/Kr0Zl+kaP9Lc4w9DZarR
         aPv6uKX+1AHYRXKEgTublGNogmX+cYSNu2CZY40m6LRy36Er0uipUDC4eWo3HcNRfm
         dXeTPt13+wyzYnotwEdF3XT72+LTd9DKpn7UJmF5w/Xl2mS+rphOSvB8Y6AG4HR/0m
         mrP5NC1mukgGEXbdcRCv2TbiA05MdenMXkR+HiezGv+RexxXv41Dekska9vb8uqSlX
         nlOcZ965NqKjt9iFjG8efAclxrCruGeiuxHP9I4ifNH0zHm9xf/OUDGAwCxOhKJPDl
         TtQqLUtUwGzgg==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, palmer@rivosinc.com,
        heiko@sntech.de, arnd@arndb.de, songmuchun@bytedance.com,
        catalin.marinas@arm.com, chenhuacai@loongson.cn,
        Conor.Dooley@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>,
        Steven Price <steven.price@arm.com>
Subject: [PATCH 1/2] riscv: Fixup race condition on PG_dcache_clean in flush_icache_pte
Date:   Sun, 23 Oct 2022 09:32:04 -0400
Message-Id: <20221023133205.3493564-2-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221023133205.3493564-1-guoren@kernel.org>
References: <20221023133205.3493564-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

RISC-V follows the arm64 flush_icache_pte mechanism and also includes
its bug. The patch ensures that instructions are observable in a new
mapping. For more details, see 588a513d3425 ("arm64: Fix race condition
on PG_dcache_clean in __sync_icache_dcache()").

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Steven Price <steven.price@arm.com>
---
 arch/riscv/mm/cacheflush.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 6cb7d96ad9c7..7c9f97fa3938 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -82,7 +82,9 @@ void flush_icache_pte(pte_t pte)
 {
 	struct page *page = pte_page(pte);
 
-	if (!test_and_set_bit(PG_dcache_clean, &page->flags))
+	if (!test_bit(PG_dcache_clean, &page->flags)) {
 		flush_icache_all();
+		set_bit(PG_dcache_clean, &page->flags);
+	}
 }
 #endif /* CONFIG_MMU */
-- 
2.36.1

