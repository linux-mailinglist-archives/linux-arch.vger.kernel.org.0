Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E61229931F
	for <lists+linux-arch@lfdr.de>; Mon, 26 Oct 2020 17:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786805AbgJZQ6Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Oct 2020 12:58:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1786804AbgJZQ6P (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Oct 2020 12:58:15 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4B30223EA;
        Mon, 26 Oct 2020 16:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603731495;
        bh=j4ZJ0ALTlBi01PelKlMy/pXKWQkR64pN+1l1EFNzW6E=;
        h=From:To:Cc:Subject:Date:From;
        b=w/hect0rN/ox0i8GTy86V7ms8R9HKv1UviPAUIwgcZMBhJeKVWvRNIA+Hn2cUCUVy
         9Z73VdZb826O7Z+jn02ThOY/YSe6+VWvQw1eb2Zy2IkuqFz9O5rJQ6mlQNVdNkzief
         Kk+DrMbc3gN7giRWetojrUHby1v7asg78oyL1TBg=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] qspinlock: use signed temporaries for cmpxchg
Date:   Mon, 26 Oct 2020 17:57:51 +0100
Message-Id: <20201026165807.3724647-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When building with W=2, the build log is flooded with

include/asm-generic/qrwlock.h:65:56: warning: pointer targets in passing argument 2 of 'atomic_try_cmpxchg_acquire' differ in signedness [-Wpointer-sign]
include/asm-generic/qrwlock.h:92:53: warning: pointer targets in passing argument 2 of 'atomic_try_cmpxchg_acquire' differ in signedness [-Wpointer-sign]
include/asm-generic/qspinlock.h:68:55: warning: pointer targets in passing argument 2 of 'atomic_try_cmpxchg_acquire' differ in signedness [-Wpointer-sign]
include/asm-generic/qspinlock.h:82:52: warning: pointer targets in passing argument 2 of 'atomic_try_cmpxchg_acquire' differ in signedness [-Wpointer-sign]

The atomics are built on top of signed integers, but the caller
doesn't actually care. Just use signed types as well.

Fixes: 27df89689e25 ("locking/spinlocks: Remove an instruction from spin and write locks")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/qrwlock.h   | 8 ++++----
 include/asm-generic/qspinlock.h | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
index 3aefde23dcea..84ce841ce735 100644
--- a/include/asm-generic/qrwlock.h
+++ b/include/asm-generic/qrwlock.h
@@ -37,7 +37,7 @@ extern void queued_write_lock_slowpath(struct qrwlock *lock);
  */
 static inline int queued_read_trylock(struct qrwlock *lock)
 {
-	u32 cnts;
+	int cnts;
 
 	cnts = atomic_read(&lock->cnts);
 	if (likely(!(cnts & _QW_WMASK))) {
@@ -56,7 +56,7 @@ static inline int queued_read_trylock(struct qrwlock *lock)
  */
 static inline int queued_write_trylock(struct qrwlock *lock)
 {
-	u32 cnts;
+	int cnts;
 
 	cnts = atomic_read(&lock->cnts);
 	if (unlikely(cnts))
@@ -71,7 +71,7 @@ static inline int queued_write_trylock(struct qrwlock *lock)
  */
 static inline void queued_read_lock(struct qrwlock *lock)
 {
-	u32 cnts;
+	int cnts;
 
 	cnts = atomic_add_return_acquire(_QR_BIAS, &lock->cnts);
 	if (likely(!(cnts & _QW_WMASK)))
@@ -87,7 +87,7 @@ static inline void queued_read_lock(struct qrwlock *lock)
  */
 static inline void queued_write_lock(struct qrwlock *lock)
 {
-	u32 cnts = 0;
+	int cnts = 0;
 	/* Optimize for the unfair lock case where the fair flag is 0. */
 	if (likely(atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED)))
 		return;
diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index 4fe7fd0fe834..d74b13825501 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -60,7 +60,7 @@ static __always_inline int queued_spin_is_contended(struct qspinlock *lock)
  */
 static __always_inline int queued_spin_trylock(struct qspinlock *lock)
 {
-	u32 val = atomic_read(&lock->val);
+	int val = atomic_read(&lock->val);
 
 	if (unlikely(val))
 		return 0;
@@ -77,7 +77,7 @@ extern void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
  */
 static __always_inline void queued_spin_lock(struct qspinlock *lock)
 {
-	u32 val = 0;
+	int val = 0;
 
 	if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL)))
 		return;
-- 
2.27.0

