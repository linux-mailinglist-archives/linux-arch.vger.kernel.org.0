Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FF651B6CC
	for <lists+linux-arch@lfdr.de>; Thu,  5 May 2022 05:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242246AbiEED72 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 May 2022 23:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242231AbiEED71 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 23:59:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A9D25EA6;
        Wed,  4 May 2022 20:55:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A09AB82B79;
        Thu,  5 May 2022 03:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6ACC385B0;
        Thu,  5 May 2022 03:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651722945;
        bh=ycOArejrZ4wjdQN/FwZtyJLMUvQeie7e/tBekexR1Pg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n9eEqytqxgDf0VPmrt6zlMu3c3irjitX/I2CI49aa+hS/g1MICM9/XdXsivNJGBGy
         eOWEYo89jXAp2I2QUDSedMGcTmjIQFKuwPiAizJBpTZ1L94tLPFYveMynIfrGyZScf
         e4X2rd/1kz9Tiv6R9vJsWyPlzCgJKWwJkw+D+AcQb0U+4kV2bniiyUxstme5+NFTYv
         AeW7uEDY0y0gAbJJkKc4p3TdQVldYDf7bz15iKb8XW3cZuHn9XzCGUeiKweCc5Ui0C
         2UTjBQEhDYWHWd4ztlXKgwfj//hcXg/xljSr4rNmJqIjPLLdt1F42Lbj5j+SMY6P5x
         bUKi9mEBMIsuQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de, palmer@dabbelt.com,
        mark.rutland@arm.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, dlustig@nvidia.com, parri.andrea@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V4 1/5] riscv: atomic: Cleanup unnecessary definition
Date:   Thu,  5 May 2022 11:55:22 +0800
Message-Id: <20220505035526.2974382-2-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505035526.2974382-1-guoren@kernel.org>
References: <20220505035526.2974382-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The cmpxchg32 & cmpxchg32_local are not used in Linux anymore. So
clean up asm/cmpxchg.h.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/riscv/include/asm/cmpxchg.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 36dc962f6343..12debce235e5 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -348,18 +348,6 @@
 #define arch_cmpxchg_local(ptr, o, n)					\
 	(__cmpxchg_relaxed((ptr), (o), (n), sizeof(*(ptr))))
 
-#define cmpxchg32(ptr, o, n)						\
-({									\
-	BUILD_BUG_ON(sizeof(*(ptr)) != 4);				\
-	arch_cmpxchg((ptr), (o), (n));					\
-})
-
-#define cmpxchg32_local(ptr, o, n)					\
-({									\
-	BUILD_BUG_ON(sizeof(*(ptr)) != 4);				\
-	arch_cmpxchg_relaxed((ptr), (o), (n))				\
-})
-
 #define arch_cmpxchg64(ptr, o, n)					\
 ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-- 
2.25.1

