Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CF458C3C7
	for <lists+linux-arch@lfdr.de>; Mon,  8 Aug 2022 09:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237357AbiHHHPT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Aug 2022 03:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237399AbiHHHOn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Aug 2022 03:14:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC02F13D2A;
        Mon,  8 Aug 2022 00:14:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8250560CD4;
        Mon,  8 Aug 2022 07:14:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC53EC433D7;
        Mon,  8 Aug 2022 07:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659942863;
        bh=CLonVkqPKNEwEB3qnFlqdH4Ppf6SvHvhKmodWZTZpYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PuDuImkclhNbC6O6GNgnZxySgPcZGrdEUoOSbjm4ohK808vUD0GFt3aQfm7jIJZbL
         U8IM3Rvxrm+dcREdZjLlVyAgVGgnVJwjtr7PXoX/20iKUWAREx5SR1D3NgL9h8x1CM
         qXDQXiIfEiLMNDQRuIJ4DdRwB6Razsn2ZT0XsdJvXp+i1DpvkpvRAFibRiIw6mFgCY
         GP7VDQzkM5UE9bOGsTT+Kootm5rBDslJ5POK7h/mGrhoEYQ+bU9EE9dZOzBmQ9tbqF
         VgFRBnaGHKtgdr6lYtsnfv4y2hWxswjBIqZkZ6YxwVZEBm6wzNryjMvZsblUcOWllb
         2MnQTsVjwL77w==
From:   guoren@kernel.org
To:     palmer@rivosinc.com, heiko@sntech.de, hch@infradead.org,
        arnd@arndb.de, peterz@infradead.org, will@kernel.org,
        boqun.feng@gmail.com, longman@redhat.com, shorne@gmail.com,
        conor.dooley@microchip.com
Cc:     linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>, Guo Ren <guoren@kernel.org>
Subject: [PATCH V9 08/15] riscv: cmpxchg: Forbid arch_cmpxchg64 for 32-bit
Date:   Mon,  8 Aug 2022 03:13:11 -0400
Message-Id: <20220808071318.3335746-9-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220808071318.3335746-1-guoren@kernel.org>
References: <20220808071318.3335746-1-guoren@kernel.org>
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

RISC-V 32-bit couldn't support lr.d/sc.d instructions, so using
arch_cmpxchg64 would cause error. Add forbid code to prevent the
situation.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/cmpxchg.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 567ed2e274c4..14c9280c7f7f 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -25,6 +25,7 @@
 			: "memory");					\
 		break;							\
 	case 8:								\
+		BUILD_BUG_ON(IS_ENABLED(CONFIG_32BIT));			\
 		__asm__ __volatile__ (					\
 			"	amoswap.d %0, %2, %1\n"			\
 			: "=r" (__ret), "+A" (*__ptr)			\
@@ -58,6 +59,7 @@
 			: "memory");					\
 		break;							\
 	case 8:								\
+		BUILD_BUG_ON(IS_ENABLED(CONFIG_32BIT));			\
 		__asm__ __volatile__ (					\
 			"	amoswap.d.aqrl %0, %2, %1\n"		\
 			: "=r" (__ret), "+A" (*__ptr)			\
@@ -101,6 +103,7 @@
 			: "memory");					\
 		break;							\
 	case 8:								\
+		BUILD_BUG_ON(IS_ENABLED(CONFIG_32BIT));			\
 		__asm__ __volatile__ (					\
 			"0:	lr.d %0, %2\n"				\
 			"	bne %0, %z3, 1f\n"			\
@@ -146,6 +149,7 @@
 			: "memory");					\
 		break;							\
 	case 8:								\
+		BUILD_BUG_ON(IS_ENABLED(CONFIG_32BIT));			\
 		__asm__ __volatile__ (					\
 			"0:	lr.d %0, %2\n"				\
 			"	bne %0, %z3, 1f\n"			\
@@ -192,6 +196,7 @@
 			: "memory");					\
 		break;							\
 	case 8:								\
+		BUILD_BUG_ON(IS_ENABLED(CONFIG_32BIT));			\
 		__asm__ __volatile__ (					\
 			"0:	lr.d %0, %2\n"				\
 			"	bne %0, %z3, 1f\n"			\
@@ -220,6 +225,7 @@
 #define arch_cmpxchg_local(ptr, o, n)					\
 	(__cmpxchg_relaxed((ptr), (o), (n), sizeof(*(ptr))))
 
+#ifdef CONFIG_64BIT
 #define arch_cmpxchg64(ptr, o, n)					\
 ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
@@ -231,5 +237,6 @@
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
 	arch_cmpxchg_relaxed((ptr), (o), (n));				\
 })
+#endif /* CONFIG_64BIT */
 
 #endif /* _ASM_RISCV_CMPXCHG_H */
-- 
2.36.1

