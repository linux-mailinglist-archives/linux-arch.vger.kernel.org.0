Return-Path: <linux-arch+bounces-9417-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0C39F57C7
	for <lists+linux-arch@lfdr.de>; Tue, 17 Dec 2024 21:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D55D31890ED6
	for <lists+linux-arch@lfdr.de>; Tue, 17 Dec 2024 20:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC78B1F9EDA;
	Tue, 17 Dec 2024 20:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FdBz/X7i"
X-Original-To: linux-arch@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAA31F9431;
	Tue, 17 Dec 2024 20:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734467409; cv=none; b=qz2LpYMaC3NRlDsLM/Q2KtV2dWbS5tOiXE811900tn7v0WyA/9ygJsIfDGFYcGWjlFpkBKZGH5tWMWOuHIxx7qI7kkn4FF4s1nxsR4Htywxymx3nMzgAWFVnJyWsDuMsSdDn+RT/j2dcTrijBG0NAc+UoWlbOTfjNQe6adEaJx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734467409; c=relaxed/simple;
	bh=oSvxRtG8yd0aOUYBeKLnJlF2PXIbnGjHvP4nj8t7UXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PfA4SV06IztJw4L4pDtQA3l8OP5FS7F0q/nl2NhjF4my1ku5+RHHbcF48EB70jwk6XnaSDnir221tQ9U41gmy9NT5i3SP407Z792sJT8nmpypQHo5LM3KIkI5sxBJn+igRNDptO7z1QBS1T3RcqHmOmeUBr407XKrKBAlSnfZDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FdBz/X7i; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=111IE7H4zmyUsr2adVE7p7sD/t82ixlQP2Vi9ldpbO4=;
	t=1734467408; x=1735677008; b=FdBz/X7iCetpt2oP9LthYNdDBo42VRFczGUxXOo5C5dSykA
	DhyQXRc22Bpa2plqqN5Sd1kqMHNMHTTfUNdM6nEz+MwXlfWtJvd0F3l26NQ4w5vbaBKiVrGnb75s7
	aUYhhip8eoiGnFmlSfuQpKbXi98TejeKn30qcAT7UIgBTB8cLpmEVTWO/HIXoqbFbBjEyz5MYNa0d
	K7SQRSmaxlzAXkm7hzgv/GHsZFkGwGv4ys7krQY2o8oWCBDm6tPq7yltSBX2ADDpo0HPABiuueB64
	DFO/OPqIgaWuhyGss/lobuQKsiOmDJQWGRjaVLSmJZpW1Oap6KF0vQE8gkEN/N9A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tNeCh-00000002NwX-3323;
	Tue, 17 Dec 2024 21:30:04 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-arch@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	briannorris@chromium.org
Cc: linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 2/3] um: avoid copying FP state from init_task
Date: Tue, 17 Dec 2024 21:27:44 +0100
Message-ID: <20241217202745.1402932-3-benjamin@sipsolutions.net>
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
does not contain the dynamic area for the userspace FP registers. As
such, limit the copy to the valid area of init_task and fill the rest
with zero.

Note that the FP state is only needed for userspace, and as such it is
entirely reasonable for init_task to not contain it.

Reported-by: Brian Norris <briannorris@chromium.org>
Closes: https://lore.kernel.org/Z1ySXmjZm-xOqk90@google.com
Fixes: 3f17fed21491 ("um: switch to regset API and depend on XSTATE")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/kernel/process.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 30bdc0a87dc8..3a67ba8aa62d 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -191,7 +191,15 @@ void initial_thread_cb(void (*proc)(void *), void *arg)
 int arch_dup_task_struct(struct task_struct *dst,
 			 struct task_struct *src)
 {
-	memcpy(dst, src, arch_task_struct_size);
+	/* init_task is not dynamically sized (missing FPU state) */
+	if (unlikely(src == &init_task)) {
+		memcpy(dst, src, sizeof(init_task));
+		memset((void *)dst + sizeof(init_task), 0,
+		       arch_task_struct_size - sizeof(init_task));
+	} else {
+		memcpy(dst, src, arch_task_struct_size);
+	}
+
 	return 0;
 }
 
-- 
2.47.1


