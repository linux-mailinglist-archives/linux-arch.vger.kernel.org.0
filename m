Return-Path: <linux-arch+bounces-2782-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE2F86E188
	for <lists+linux-arch@lfdr.de>; Fri,  1 Mar 2024 14:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2B21F22D50
	for <lists+linux-arch@lfdr.de>; Fri,  1 Mar 2024 13:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4AB6A8AD;
	Fri,  1 Mar 2024 13:05:56 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51FC69E1C;
	Fri,  1 Mar 2024 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298355; cv=none; b=KwnA41mGiuOf/Fo5xY+u5Kcg3tyBhAcToH93zhB/pypZiczG0s1C5A8bk6L94e//bShkLd6CR5m3fF+xIeeObGExPj0S2EGa4VtasQxTEAROEvqKk9DlyRwdcrkhu5tK4PE4+X50gurfuQW6rSuQusx2moEEYtTguDNdTjRxWJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298355; c=relaxed/simple;
	bh=IiKch8zeWz42IEmKp8mhTIm+LF6IgS04Jf5vRlLvZpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HcgR6ZkZcgxvZXHjVZ58T5vvXRjHPDr/+ntDY7Loy/xPcAZFn1iMqt/KAGmsr4zW9goCrN5LopJYOY3D8O78OIfvnQ/K7buPUH0gsTd0f8al3McU8bHtQMRuGdNogrf1XpDmDZv8vz2jBO41HiT2kMPbk1AcZBAU8OBqO/TIZhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4072BC433C7;
	Fri,  1 Mar 2024 13:05:52 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Guo Ren <guoren@kernel.org>,
	Rui Wang <wangrui@loongson.cn>,
	WANG Xuerui <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 1/2] mmiowb: Rename mmiowb_spin_{lock, unlock}() to mmiowb_in_{lock, unlock}()
Date: Fri,  1 Mar 2024 21:05:31 +0800
Message-ID: <20240301130532.3953167-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are extending mmiowb tracking system from spinlock to mutex, so
rename mmiowb_spin_{lock, unlock}() to mmiowb_in_{lock, unlock}() to
reflect the fact. No functional changes.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 include/asm-generic/mmiowb.h    | 8 ++++----
 include/linux/spinlock.h        | 6 +++---
 kernel/locking/spinlock_debug.c | 6 +++---
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/asm-generic/mmiowb.h b/include/asm-generic/mmiowb.h
index 5698fca3bf56..eb2335f9f35e 100644
--- a/include/asm-generic/mmiowb.h
+++ b/include/asm-generic/mmiowb.h
@@ -40,13 +40,13 @@ static inline void mmiowb_set_pending(void)
 		ms->mmiowb_pending = ms->nesting_count;
 }
 
-static inline void mmiowb_spin_lock(void)
+static inline void mmiowb_in_lock(void)
 {
 	struct mmiowb_state *ms = __mmiowb_state();
 	ms->nesting_count++;
 }
 
-static inline void mmiowb_spin_unlock(void)
+static inline void mmiowb_in_unlock(void)
 {
 	struct mmiowb_state *ms = __mmiowb_state();
 
@@ -59,7 +59,7 @@ static inline void mmiowb_spin_unlock(void)
 }
 #else
 #define mmiowb_set_pending()		do { } while (0)
-#define mmiowb_spin_lock()		do { } while (0)
-#define mmiowb_spin_unlock()		do { } while (0)
+#define mmiowb_in_lock()		do { } while (0)
+#define mmiowb_in_unlock()		do { } while (0)
 #endif	/* CONFIG_MMIOWB */
 #endif	/* __ASM_GENERIC_MMIOWB_H */
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 3fcd20de6ca8..60eda70cddd0 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -185,7 +185,7 @@ static inline void do_raw_spin_lock(raw_spinlock_t *lock) __acquires(lock)
 {
 	__acquire(lock);
 	arch_spin_lock(&lock->raw_lock);
-	mmiowb_spin_lock();
+	mmiowb_in_lock();
 }
 
 static inline int do_raw_spin_trylock(raw_spinlock_t *lock)
@@ -193,14 +193,14 @@ static inline int do_raw_spin_trylock(raw_spinlock_t *lock)
 	int ret = arch_spin_trylock(&(lock)->raw_lock);
 
 	if (ret)
-		mmiowb_spin_lock();
+		mmiowb_in_lock();
 
 	return ret;
 }
 
 static inline void do_raw_spin_unlock(raw_spinlock_t *lock) __releases(lock)
 {
-	mmiowb_spin_unlock();
+	mmiowb_in_unlock();
 	arch_spin_unlock(&lock->raw_lock);
 	__release(lock);
 }
diff --git a/kernel/locking/spinlock_debug.c b/kernel/locking/spinlock_debug.c
index 87b03d2e41db..632a88322433 100644
--- a/kernel/locking/spinlock_debug.c
+++ b/kernel/locking/spinlock_debug.c
@@ -114,7 +114,7 @@ void do_raw_spin_lock(raw_spinlock_t *lock)
 {
 	debug_spin_lock_before(lock);
 	arch_spin_lock(&lock->raw_lock);
-	mmiowb_spin_lock();
+	mmiowb_in_lock();
 	debug_spin_lock_after(lock);
 }
 
@@ -123,7 +123,7 @@ int do_raw_spin_trylock(raw_spinlock_t *lock)
 	int ret = arch_spin_trylock(&lock->raw_lock);
 
 	if (ret) {
-		mmiowb_spin_lock();
+		mmiowb_in_lock();
 		debug_spin_lock_after(lock);
 	}
 #ifndef CONFIG_SMP
@@ -137,7 +137,7 @@ int do_raw_spin_trylock(raw_spinlock_t *lock)
 
 void do_raw_spin_unlock(raw_spinlock_t *lock)
 {
-	mmiowb_spin_unlock();
+	mmiowb_in_unlock();
 	debug_spin_unlock(lock);
 	arch_spin_unlock(&lock->raw_lock);
 }
-- 
2.43.0


