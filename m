Return-Path: <linux-arch+bounces-2783-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 823FF86E18A
	for <lists+linux-arch@lfdr.de>; Fri,  1 Mar 2024 14:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0CB51C2089D
	for <lists+linux-arch@lfdr.de>; Fri,  1 Mar 2024 13:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED2A6DCF5;
	Fri,  1 Mar 2024 13:06:01 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B210C6CDA2;
	Fri,  1 Mar 2024 13:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298361; cv=none; b=qWe9cc7YzAZzRTfSVZ9Q4g6s3ECsG1JlbXlxE3bGlBtbe6JxgprGZzJ1Gd0yWV7jezxs447IcBuBjpi7HIH379YyOJcZhXwB7YKOX0LWWuO0FK08ecUPZcFZt8YcmR4nvVL0B56/IuLhP2QsbIyGtkefoxih+SdwdMhDmzMKH6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298361; c=relaxed/simple;
	bh=CjDE5ydNR/BncURT9vZlYDlNHu0bNpYjqN4jeVRjGyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rEQEvQUujosVusR+1TDIo2+9vGjtodoE5ABTV2kzBlQ6umH/rsfYxOIf6MWJVRnlG2E4IJllTHIMJXMmHIIWf0onT95ImVAv3ly93KzgrGgeC56x13upcDzQ/Ei3A6cLwA44ikwIU86Pk6GIYIB1D77s7zsJh+h0WwvCgM/MV2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264E1C433C7;
	Fri,  1 Mar 2024 13:05:57 +0000 (UTC)
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
Subject: [PATCH 2/2] mmiowb: Hook up mmiowb helpers to mutexes as well as spinlocks
Date: Fri,  1 Mar 2024 21:05:32 +0800
Message-ID: <20240301130532.3953167-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240301130532.3953167-1-chenhuacai@loongson.cn>
References: <20240301130532.3953167-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit fb24ea52f78e0d595852e ("drivers: Remove explicit invocations of
mmiowb()") remove all mmiowb() in drivers, but it says:

"NOTE: mmiowb() has only ever guaranteed ordering in conjunction with
spin_unlock(). However, pairing each mmiowb() removal in this patch with
the corresponding call to spin_unlock() is not at all trivial, so there
is a small chance that this change may regress any drivers incorrectly
relying on mmiowb() to order MMIO writes between CPUs using lock-free
synchronisation."

The mmio in radeon_ring_commit() is protected by a mutex rather than a
spinlock, but in the mutex fastpath it behaves similar to spinlock. We
can add mmiowb() calls in the radeon driver but the maintainer says he
doesn't like such a workaround, and radeon is not the only example of
mutex protected mmio.

So we extend the mmiowb tracking system from spinlock to mutex, hook up
mmiowb helpers to mutexes as well as spinlocks.

Without this, we get such an error when run 'glxgears' on weak ordering
architectures such as LoongArch:

radeon 0000:04:00.0: ring 0 stalled for more than 10324msec
radeon 0000:04:00.0: ring 3 stalled for more than 10240msec
radeon 0000:04:00.0: GPU lockup (current fence id 0x000000000001f412 last fence id 0x000000000001f414 on ring 3)
radeon 0000:04:00.0: GPU lockup (current fence id 0x000000000000f940 last fence id 0x000000000000f941 on ring 0)
radeon 0000:04:00.0: scheduling IB failed (-35).
[drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
radeon 0000:04:00.0: scheduling IB failed (-35).
[drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
radeon 0000:04:00.0: scheduling IB failed (-35).
[drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
radeon 0000:04:00.0: scheduling IB failed (-35).
[drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
radeon 0000:04:00.0: scheduling IB failed (-35).
[drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
radeon 0000:04:00.0: scheduling IB failed (-35).
[drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
radeon 0000:04:00.0: scheduling IB failed (-35).
[drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)

Link: https://lore.kernel.org/dri-devel/29df7e26-d7a8-4f67-b988-44353c4270ac@amd.com/T/#t
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 kernel/locking/mutex.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index cbae8c0b89ab..f51d09aec643 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -127,8 +127,10 @@ static inline struct task_struct *__mutex_trylock_common(struct mutex *lock, boo
 		}
 
 		if (atomic_long_try_cmpxchg_acquire(&lock->owner, &owner, task | flags)) {
-			if (task == curr)
+			if (task == curr) {
+				mmiowb_in_lock();
 				return NULL;
+			}
 			break;
 		}
 	}
@@ -168,8 +170,10 @@ static __always_inline bool __mutex_trylock_fast(struct mutex *lock)
 	unsigned long curr = (unsigned long)current;
 	unsigned long zero = 0UL;
 
-	if (atomic_long_try_cmpxchg_acquire(&lock->owner, &zero, curr))
+	if (atomic_long_try_cmpxchg_acquire(&lock->owner, &zero, curr)) {
+		mmiowb_in_lock();
 		return true;
+	}
 
 	return false;
 }
@@ -178,6 +182,7 @@ static __always_inline bool __mutex_unlock_fast(struct mutex *lock)
 {
 	unsigned long curr = (unsigned long)current;
 
+	mmiowb_in_unlock();
 	return atomic_long_try_cmpxchg_release(&lock->owner, &curr, 0UL);
 }
 #endif
@@ -918,6 +923,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	 * Except when HANDOFF, in that case we must not clear the owner field,
 	 * but instead set it to the top waiter.
 	 */
+	mmiowb_in_unlock();
 	owner = atomic_long_read(&lock->owner);
 	for (;;) {
 		MUTEX_WARN_ON(__owner_task(owner) != current);
-- 
2.43.0


