Return-Path: <linux-arch+bounces-529-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DE27FC75D
	for <lists+linux-arch@lfdr.de>; Tue, 28 Nov 2023 22:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87B0DB25C78
	for <lists+linux-arch@lfdr.de>; Tue, 28 Nov 2023 21:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CDE481B8;
	Tue, 28 Nov 2023 21:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnlOH+kM"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8446244361;
	Tue, 28 Nov 2023 21:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD36C433B6;
	Tue, 28 Nov 2023 21:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205745;
	bh=tcud/Eg7by764OGVtAfT59O6ABNRuhiQsjaVx3w5b3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HnlOH+kMDjSwmvxpWwNHuvkS7B7woBQm3/0H4O0r+5f66IUL5KSHRdcfi+Ghd0D5/
	 1AMKdgagF2j7A/GFPAH4a0JKpcFW9+SlkQMwawLIWKS4YJ1YEMpfOwfRN/3G6UpRxL
	 sMZkV7boXUkUh3MHYPL82t5a7DznY5FxpFYs+VKtXYi4TaQCtbmiNqDLj/Bj1Uhs2p
	 bWWUuG0zuyDHxalponNb6zQVCDu4nvOy11bdpzbl6V7PETQtlTzqqfSIYiT0IHyAQP
	 IkmQ3vyO+935in0+OGjmtR+aVxflW1bQISXH6RJmvS7cRMeb7RHxYsaxVC5F0HZM7X
	 VgYT3GS8Ix1/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Guo Ren <guoren@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-arch@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 14/15] asm-generic: qspinlock: fix queued_spin_value_unlocked() implementation
Date: Tue, 28 Nov 2023 16:08:35 -0500
Message-ID: <20231128210843.876493-14-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210843.876493-1-sashal@kernel.org>
References: <20231128210843.876493-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.140
Content-Transfer-Encoding: 8bit

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit 125b0bb95dd6bec81b806b997a4ccb026eeecf8f ]

We really don't want to do atomic_read() or anything like that, since we
already have the value, not the lock.  The whole point of this is that
we've loaded the lock from memory, and we want to check whether the
value we loaded was a locked one or not.

The main use of this is the lockref code, which loads both the lock and
the reference count in one atomic operation, and then works on that
combined value.  With the atomic_read(), the compiler would pointlessly
spill the value to the stack, in order to then be able to read it back
"atomically".

This is the qspinlock version of commit c6f4a9002252 ("asm-generic:
ticket-lock: Optimize arch_spin_value_unlocked()") which fixed this same
bug for ticket locks.

Cc: Guo Ren <guoren@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/all/CAHk-=whNRv0v6kQiV5QO6DJhjH4KEL36vWQ6Re8Csrnh4zbRkQ@mail.gmail.com/
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/asm-generic/qspinlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index d74b138255014..95cfcfb8a3b4d 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -41,7 +41,7 @@ static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
  */
 static __always_inline int queued_spin_value_unlocked(struct qspinlock lock)
 {
-	return !atomic_read(&lock.val);
+	return !lock.val.counter;
 }
 
 /**
-- 
2.42.0


