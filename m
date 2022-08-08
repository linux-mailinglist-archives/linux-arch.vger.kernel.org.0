Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6009658C4A8
	for <lists+linux-arch@lfdr.de>; Mon,  8 Aug 2022 10:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242251AbiHHIHH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Aug 2022 04:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242088AbiHHIGi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Aug 2022 04:06:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E22D10E;
        Mon,  8 Aug 2022 01:06:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79850B80E06;
        Mon,  8 Aug 2022 08:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACD2C433D7;
        Mon,  8 Aug 2022 08:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659945992;
        bh=oWHU2Ny0CiPTyM5UPNfWTzYpuhtDEvS9sEcV0SmxrWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K+G5/KlKkwLY6Ebo0r9E4N9FTGmZ3uTMDSuv6U5mVHrwZNbrUvgGeha8qE07emesC
         AxKPZwDNHOJ55bTsRJj1B/IMUBmJ6GmRHn/ocEqzyL+oQCmraI6vWcbeDuk9CVuwhW
         lSMe3UykOCmyl3FoFMv8HolaRexAg50Y5cqmRZvFSRhrboZEBa38LgHhDyLLFweBeD
         baRNoe+3NxAne8mCvrm2Ycw426nWoJYE4Osn+UmQw7iWDSY1QEjPEfjRotALSX/kmP
         Kum5pUZJ92+uJ0ahWtd71O4QR+uGf6bZF56r0QT4CiKRUKeayXfKf2J4ID+0DbmMlJ
         werEzzwgbePQQ==
From:   guoren@kernel.org
To:     tj@kernel.org, cl@linux.com, palmer@dabbelt.com, will@kernel.org,
        catalin.marinas@arm.com, peterz@infradead.org, arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>, Guo Ren <guoren@kernel.org>
Subject: [RFC PATCH 4/4] riscv: cmpxchg: Remove unused cmpxchg(64)_local
Date:   Mon,  8 Aug 2022 04:06:00 -0400
Message-Id: <20220808080600.3346843-5-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220808080600.3346843-1-guoren@kernel.org>
References: <20220808080600.3346843-1-guoren@kernel.org>
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

Only cmpxchg64_local is used in drivers/iommu/intel/iommu.c, and
cmpxchg_local has been deprecated in common part. So cmpxchg_local
is unecessary to riscv.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/cmpxchg.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 12debce235e5..0407680b13ad 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -345,19 +345,10 @@
 				       _o_, _n_, sizeof(*(ptr)));	\
 })
 
-#define arch_cmpxchg_local(ptr, o, n)					\
-	(__cmpxchg_relaxed((ptr), (o), (n), sizeof(*(ptr))))
-
 #define arch_cmpxchg64(ptr, o, n)					\
 ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
 	arch_cmpxchg((ptr), (o), (n));					\
 })
 
-#define arch_cmpxchg64_local(ptr, o, n)					\
-({									\
-	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	arch_cmpxchg_relaxed((ptr), (o), (n));				\
-})
-
 #endif /* _ASM_RISCV_CMPXCHG_H */
-- 
2.36.1

