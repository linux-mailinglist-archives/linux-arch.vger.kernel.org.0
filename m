Return-Path: <linux-arch+bounces-530-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 549467FC779
	for <lists+linux-arch@lfdr.de>; Tue, 28 Nov 2023 22:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870AB1C20983
	for <lists+linux-arch@lfdr.de>; Tue, 28 Nov 2023 21:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB3C481D6;
	Tue, 28 Nov 2023 21:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWAhZBV+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F325B44366;
	Tue, 28 Nov 2023 21:09:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0E5C433BB;
	Tue, 28 Nov 2023 21:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205772;
	bh=iM1cy4P0huEOxEwkxOs6q1oMtWWdpFkt1uhyrWDoZtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UWAhZBV+VU4BjwNew9l04pav19csXW1iUDozXe+KnG3eCThVBwznBEQ9gfd0Inyo0
	 LTgdtOtNnJ3aMq60UwvXb39XnK4r4MlG0keqdifOmbFDn8FKZm9uPBHSQKv4LxsskM
	 +iRCDzMC4zPUJ066ABVDk3FvL0pVkb2mVNdXCWGAw/C/BylKDMdN3u3S+qePatYC+Q
	 fhqKucM8YmiI23pm2DaMm9AjYc/PRdBoQfbVShACrVn3LQhyNDoWi3Q6qE2oiE2hZJ
	 khnV9vjQMbY34QDtPcYZ3TI3gCh1Z7x4HVbU2APf/+28cb1uQAvoSa6KcEq+1Y1l8B
	 8FeU+UKcoJzzQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Guo Ren <guoren@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-arch@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 12/13] asm-generic: qspinlock: fix queued_spin_value_unlocked() implementation
Date: Tue, 28 Nov 2023 16:09:06 -0500
Message-ID: <20231128210914.876813-12-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210914.876813-1-sashal@kernel.org>
References: <20231128210914.876813-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.202
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
index 4fe7fd0fe834d..d1ddbcf71791d 100644
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


