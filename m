Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF1455CAE5
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jun 2022 14:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242607AbiF1ITQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jun 2022 04:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243895AbiF1IS5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jun 2022 04:18:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B3727FE5;
        Tue, 28 Jun 2022 01:17:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7E51B81C0F;
        Tue, 28 Jun 2022 08:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532B8C341CB;
        Tue, 28 Jun 2022 08:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656404245;
        bh=wuMCLxNzxYSmxOh5v/SBPcUTtvTDqjGgAdULUenQIXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pPb+/fENqMFaNUkZi6ql3d0fdSuDA7WTP/Lpo5BBmMl376GJTJ5wk6oq5bjBKJujt
         AUAkSyTrMojK8B6lta+rMW/hVbpHJ4EbCDBZ3s1u2HDX6r9aytN5JiiJVFIfKbSUVJ
         MDsa4DdyVpOAxrwZre4pbBxEtJENcdfdbbsl9zJETI27O4EeiRcHd5ox2nguiOMi57
         7swCaCeIbQK/SbiHBmRrq/8mj7XWoj0oMDQfLt/ldfv4beWX37ef27Zq27Hh9ugOtg
         9n1Ut6VjS0R+FmzLF8AhoEfAsSOtt/Dcz0LJCEAhgal1ah9yWzcfIo1IDAIzhgeCFi
         KH3mqQj9ea+aw==
From:   guoren@kernel.org
To:     palmer@rivosinc.com, arnd@arndb.de, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH V7 1/5] asm-generic: ticket-lock: Remove unnecessary atomic_read
Date:   Tue, 28 Jun 2022 04:17:03 -0400
Message-Id: <20220628081707.1997728-2-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628081707.1997728-1-guoren@kernel.org>
References: <20220628081707.1997728-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
---
 include/asm-generic/spinlock.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
index fdfebcb050f4..f1e4fa100f5a 100644
--- a/include/asm-generic/spinlock.h
+++ b/include/asm-generic/spinlock.h
@@ -84,7 +84,9 @@ static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
 
 static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
 {
-	return !arch_spin_is_locked(&lock);
+	u32 val = lock.counter;
+
+	return ((val >> 16) == (val & 0xffff));
 }
 
 #include <asm/qrwlock.h>
-- 
2.36.1

