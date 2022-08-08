Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D987758C3AF
	for <lists+linux-arch@lfdr.de>; Mon,  8 Aug 2022 09:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbiHHHNu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Aug 2022 03:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiHHHNt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Aug 2022 03:13:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E31D26ED;
        Mon,  8 Aug 2022 00:13:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F4D3B80A07;
        Mon,  8 Aug 2022 07:13:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63F4C433C1;
        Mon,  8 Aug 2022 07:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659942824;
        bh=x8ThgiIuKR7Cb/zZ7HilMYDMWlq4+j+CW+ILWn7Ti5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P88S4lJbP8Be2yMakC9wEEqudyc7zhXZOAxkmW7Q4X3jhlAy60UklpQ5NbgVP9Vbo
         jA+RgsevhZTRkloqo7fRg1fKVqLlR0qTF5fcFGDOTnufomLj5p2T3WM6Wf75ziKksR
         urnEGYFj3/NEna3JHv6dfjoagv5m0VvBZ1G0mdr1mMTPLT64gYi6jWdzfwZ7sokie/
         h0/OqRQFfyYoSvAtZgRJ3TOJhisPPQ5Gue+pvUtJaLrjF34B9glm3C9Df7/8lkX1w1
         T0a0L51d1mRr+IJZ2+NDxLXHFUl7bHv4bBWQ7sGFuy5p+Q3FWRjAoXIXY5gb3qVGri
         cslMO2EXPJCtg==
From:   guoren@kernel.org
To:     palmer@rivosinc.com, heiko@sntech.de, hch@infradead.org,
        arnd@arndb.de, peterz@infradead.org, will@kernel.org,
        boqun.feng@gmail.com, longman@redhat.com, shorne@gmail.com,
        conor.dooley@microchip.com
Cc:     linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>, Guo Ren <guoren@kernel.org>
Subject: [PATCH V9 01/15] asm-generic: ticket-lock: Remove unnecessary atomic_read
Date:   Mon,  8 Aug 2022 03:13:04 -0400
Message-Id: <20220808071318.3335746-2-guoren@kernel.org>
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

Remove unnecessary atomic_read in arch_spin_value_unlocked(lock),
because the value has been in lock. This patch could prevent
arch_spin_value_unlocked contend spin_lock data again.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 include/asm-generic/spinlock.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
index fdfebcb050f4..90803a826ba0 100644
--- a/include/asm-generic/spinlock.h
+++ b/include/asm-generic/spinlock.h
@@ -68,11 +68,18 @@ static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
 	smp_store_release(ptr, (u16)val + 1);
 }
 
+static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
+{
+	u32 val = lock.counter;
+
+	return ((val >> 16) == (val & 0xffff));
+}
+
 static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
 {
-	u32 val = atomic_read(lock);
+	arch_spinlock_t val = READ_ONCE(*lock);
 
-	return ((val >> 16) != (val & 0xffff));
+	return !arch_spin_value_unlocked(val);
 }
 
 static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
@@ -82,11 +89,6 @@ static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
 	return (s16)((val >> 16) - (val & 0xffff)) > 1;
 }
 
-static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
-{
-	return !arch_spin_is_locked(&lock);
-}
-
 #include <asm/qrwlock.h>
 
 #endif /* __ASM_GENERIC_SPINLOCK_H */
-- 
2.36.1

