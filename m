Return-Path: <linux-arch+bounces-9418-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA87B9F57C9
	for <lists+linux-arch@lfdr.de>; Tue, 17 Dec 2024 21:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 514E7188F626
	for <lists+linux-arch@lfdr.de>; Tue, 17 Dec 2024 20:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC591FA160;
	Tue, 17 Dec 2024 20:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jp5PCoEE"
X-Original-To: linux-arch@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6911FA141;
	Tue, 17 Dec 2024 20:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734467411; cv=none; b=gG7h5UkfuFrmKpteXLbFRAOETIifzwvxhqYYeuOojCtbdBFpIV+aKdvb4BNJVsRHk9CoYi27TJU+5voR6SAMuKJEpGpS9kvP4GF7t/YLoCndm9v+hXey2A+JtkHIjl5eI1nN0HdS17FU1pFY3DWFKjNbohbrmI06sfiCjIHaz2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734467411; c=relaxed/simple;
	bh=GMDVzuQNflKsXt8Ams72LmA7hrTPf5xwTvnBqM8M5Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzb3M+TuqUEsRTXemu07P/ZONPeXAhCYY7vttLym4zA3xkLu/PK5ZNY6J76TKf1bVO1FzkjvY8+4Ck6TOwt7i0vRlEuCoMyTUgPXP9ZEoik6V+oYJPsmYka3fLRasxenaN1kLffVcSmT0WJx243hAn/D7Z3KP1cb1pn0+GJZHVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jp5PCoEE; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=2AjmcsgTzx3TIo/NiPZF3pU4weuGY3iYJ3AIwf8Kn/s=;
	t=1734467409; x=1735677009; b=jp5PCoEEASrMQs9Kkq+XwReFaVtnPpsis17t4DsOKTbQeyq
	M6iCgj77uui6R6Ek9WO0Syvfcp5P70eFBru8O2Foj+gFbhVwA5WzeK+TEM781bAF2zORvQYlxrSsx
	NfVjVelGAlmNqS11omBh/ULkoYF8J2i1pORUNZTbEIgLIuICb9auNp5PNA8rk1aiEdMtMGTHeej9i
	x3Y6xPlNG5HqWeXBP33Cq9d4jRqM4BK4FzEQuzLwKpRBnih5fLzHochRu5dr8V3buZ2aGelt6FGS6
	flkD4HGcxi2+8VYEGFOZc5Gf4V0jJD38YTCyAv3sSA3EZJTWT1HhLJuXkDTMT6FQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tNeCk-00000002NwX-3MTY;
	Tue, 17 Dec 2024 21:30:07 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-arch@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	briannorris@chromium.org
Cc: linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 3/3] x86: avoid copying dynamic FP state from init_task
Date: Tue, 17 Dec 2024 21:27:45 +0100
Message-ID: <20241217202745.1402932-4-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217202745.1402932-1-benjamin@sipsolutions.net>
References: <20241217202745.1402932-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The init_task instance of struct task_struct is statically allocated and
may not contain the full FP state for userspace. As such, limit the copy
to the valid area of init_task and fill the rest with zero.

Note that the FP state is only needed for userspace, and as such it is
entirely reasonable for init_task to not contain parts of it.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Fixes: 5aaeb5c01c5b ("x86/fpu, sched: Introduce CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT and use it on x86")
---
 arch/x86/kernel/process.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index f63f8fd00a91..1be45fe70cad 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -92,7 +92,15 @@ EXPORT_PER_CPU_SYMBOL_GPL(__tss_limit_invalid);
  */
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 {
-	memcpy(dst, src, arch_task_struct_size);
+	/* init_task is not dynamically sized (incomplete FPU state) */
+	if (unlikely(src == &init_task)) {
+		memcpy(dst, src, sizeof(init_task));
+		memset((void *)dst + sizeof(init_task), 0,
+		       arch_task_struct_size - sizeof(init_task));
+	} else {
+		memcpy(dst, src, arch_task_struct_size);
+	}
+
 #ifdef CONFIG_VM86
 	dst->thread.vm86 = NULL;
 #endif
-- 
2.47.1


