Return-Path: <linux-arch+bounces-11956-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDDEAB86F9
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 14:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18D2C1887F5B
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 12:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B53B2BD59C;
	Thu, 15 May 2025 12:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1aljM3L"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331252BD599;
	Thu, 15 May 2025 12:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313245; cv=none; b=Q3Mc3zgd/4Wav07QEh1l+KX2GQLo4RiuIju5plHFDw477/WHS7fLC1fX/wBCERRSw8AVQ7muUqNAGtEwJmoIrzL3OhqVQA6bPPnwREpRdh+CoRc+8G7AQCpu/L35zr0+n5LdbmtVgl5RlT+opDajmciq7XEb7mb4wqaEk3UJSQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313245; c=relaxed/simple;
	bh=kORrG9EAFiE5Ir3BGCvLe+XHB6B3NqvA0AZg108fjMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EFy7S4A/cODXeGVjvPz3Rh5FDTLWzjjJcg+W1d+CH0MaFuuvb5Hvuxe34RpHn8YlXJLqqIAHIyYseW8alU7uFnHanLcQTpXeRLbaLQSPpfXTEo4l38QF7jFzO3lcWECIaUkFgzfhmVJ5wmWxg2LOYvV1LoZ/W3mqMusZxz/4bFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1aljM3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D43AC4CEE7;
	Thu, 15 May 2025 12:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747313244;
	bh=kORrG9EAFiE5Ir3BGCvLe+XHB6B3NqvA0AZg108fjMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i1aljM3L5gSWJbRhNyJ8p9AThS0NMm/qxhkqJ/ZxUCcKCfg6eO22J7CTot3XRudEy
	 CUfvGdP6u/qFWGreLcUuL6n3h1lFqCu6Z3CBjuVbwENSFh0oJB63ydGrYaCZA2AfE5
	 qx1r+djZE/tSLeI+PB3Z83AieIZISAbs1ndTww+m7FPWyPykNfAWky8vUIC1J5yNY/
	 nRAtH3VS6o4evHuUp+SFdAV64hgbcxRiQyTgmvXz72ohkiANy7x/jffF/Rr2saSJ+H
	 1CHDmul038q5K5ekRooWISB8HZNjpXtqiBz8cF+xdaZ03ies3VKkGdj4MaBC889COG
	 F/g4QbuvBXJXA==
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-arch@vger.kernel.org
Subject: [PATCH 15/15] bugs/core: Reorganize fields in the first line of WARNING output, add ->comm[] output
Date: Thu, 15 May 2025 14:46:44 +0200
Message-ID: <20250515124644.2958810-16-mingo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250515124644.2958810-1-mingo@kernel.org>
References: <20250515124644.2958810-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the introduction of the condition string as part of the 'file'
string output of kernel warnings, the first line has become a bit
harder to read:

   WARNING: CPU: 0 PID: 0 at [ptr == 0 && 1] kernel/sched/core.c:8511 sched_init+0x20/0x410

Re-order the fields by importance (higher to lower), make the 'at' meaningful
again, and add '->comm[]' output which is often more valuable than a PID.

Also, remove the 'PID' prefix - in combination with comm it's clear what it is.

These changes make the output only slightly longer:

   WARNING: [ptr == 0 && 1] kernel/sched/core.c:8511 at sched_init+0x20/0x410 CPU#0: swapper/0

While adding more information and making it better organized.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: <linux-arch@vger.kernel.org>
---
 kernel/panic.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index a3889f38153d..f03fffca7bcb 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -725,13 +725,15 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 
 	disable_trace_on_warning();
 
-	if (file)
-		pr_warn("WARNING: CPU: %d PID: %d at %s:%d %pS\n",
-			raw_smp_processor_id(), current->pid, file, line,
-			caller);
-	else
-		pr_warn("WARNING: CPU: %d PID: %d at %pS\n",
-			raw_smp_processor_id(), current->pid, caller);
+	if (file) {
+		pr_warn("WARNING: %s:%d at %pS, CPU#%d: %s/%d\n",
+			file, line, caller,
+			raw_smp_processor_id(), current->comm, current->pid);
+	} else {
+		pr_warn("WARNING: at %pS, CPU#%d: %s/%d\n",
+			caller,
+			raw_smp_processor_id(), current->comm, current->pid);
+	}
 
 #pragma GCC diagnostic push
 #ifndef __clang__
-- 
2.45.2


