Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAF376D45D
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 18:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjHBQxb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 12:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbjHBQxH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 12:53:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464004224;
        Wed,  2 Aug 2023 09:52:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 847BE61924;
        Wed,  2 Aug 2023 16:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F4CC433C9;
        Wed,  2 Aug 2023 16:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690995150;
        bh=I970M18cE0sneLmm5R/BlQhLI3AT81WZcHrpx7H84QU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YYb/WMImTOTxkBja+DTFICqCdtWSOLtqAZ5e1F5s3EX0MaIYrFheo3mNiGqu1aaVC
         S6ilJfphcbY8Jphf2Q/QQar969Sfbq4aa/GKGRVw5XhOgm4OhP8/t5uVLhsZbYCdMt
         nrsC+aJmUnfMOFlO9tVcOAiqRXH2mFVgyBkVJGx27GUqib/X36BaB8BlvNPST0hC4w
         Cjy0dC8DVwqni8YakWrHZ7gpQsv3q0/mCzodTqg45S0c5vqJBCqgo1NiH6o1nHeO6e
         VzACfbqiOtwTGDMd4WwSyNp1MqFES+QdQ9MIUMZ8k96yQwGIRMklwWPOQUhdzRDdWR
         5eh6ORHu6V/UQ==
From:   guoren@kernel.org
To:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn
Cc:     linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH V10 18/19] locking/qspinlock: Move pv_ops into x86 directory
Date:   Wed,  2 Aug 2023 12:47:00 -0400
Message-Id: <20230802164701.192791-19-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230802164701.192791-1-guoren@kernel.org>
References: <20230802164701.192791-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The pv_ops belongs to x86 custom infrastructure and cleans up the
cna_configure_spin_lock_slowpath() with standard code. This is
preparation for riscv support CNA qspoinlock.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/x86/include/asm/qspinlock.h |  3 ++-
 arch/x86/kernel/alternative.c    |  6 +++++-
 kernel/locking/qspinlock_cna.h   | 14 ++++++--------
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index f48a2a250e57..100adad70bf5 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -28,7 +28,8 @@ static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lo
 }
 
 #ifdef CONFIG_NUMA_AWARE_SPINLOCKS
-extern void cna_configure_spin_lock_slowpath(void);
+extern bool cna_configure_spin_lock_slowpath(void);
+extern void __cna_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
 #endif
 
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index c36df5aa3ab1..68b7392016c3 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1538,7 +1538,11 @@ void __init alternative_instructions(void)
 	paravirt_set_cap();
 
 #if defined(CONFIG_NUMA_AWARE_SPINLOCKS)
-	cna_configure_spin_lock_slowpath();
+	if (pv_ops.lock.queued_spin_lock_slowpath == native_queued_spin_lock_slowpath) {
+		if (cna_configure_spin_lock_slowpath())
+			pv_ops.lock.queued_spin_lock_slowpath =
+							__cna_queued_spin_lock_slowpath;
+	}
 #endif
 
 	/*
diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
index 17d56c739e57..5e297dc687d9 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -406,20 +406,18 @@ void __cna_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
  * multiple NUMA nodes in native environment, unless the user has
  * overridden this default behavior by setting the numa_spinlock flag.
  */
-void __init cna_configure_spin_lock_slowpath(void)
+bool __init cna_configure_spin_lock_slowpath(void)
 {
 
 	if (numa_spinlock_flag < 0)
-		return;
+		return false;
 
-	if (numa_spinlock_flag == 0 && (nr_node_ids < 2 ||
-		    pv_ops.lock.queued_spin_lock_slowpath !=
-			native_queued_spin_lock_slowpath))
-		return;
+	if (numa_spinlock_flag == 0 && nr_node_ids < 2)
+		return false;
 
 	cna_init_nodes();
 
-	pv_ops.lock.queued_spin_lock_slowpath = __cna_queued_spin_lock_slowpath;
-
 	pr_info("Enabling CNA spinlock\n");
+
+	return true;
 }
-- 
2.36.1

