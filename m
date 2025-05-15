Return-Path: <linux-arch+bounces-11950-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF07AB86E9
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 14:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67A46A02029
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 12:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01F729E04E;
	Thu, 15 May 2025 12:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdcZpvpm"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C865B29DB86;
	Thu, 15 May 2025 12:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313230; cv=none; b=kk9Bhnf9LgGN8gJ23cCqbuGcYOPIqtoleGOipd8ggPQgk1iIC/brG9B2F75uZdbOJfjQovVkl97KeFdmO8BZUPsaJuyPDHqVNPhOi5qNylJZlxINWaVCW6MITM61dLB/It4jpo/ZUThqPJBk1W/K/xnJB8uypk2erEfdQm5cZuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313230; c=relaxed/simple;
	bh=LeJR/zvlqj5Asj/nQfg1x5VrUEA2v3eAMcSq5/MpbRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjQ7R+4FTGSUnJ5gw1Bn/yW0mqVPBErZy6vI8o1hth1ZM5EG/+t/CvMOidRtOtIGN5zvjJtQw7CBc21gT9dfHpiobt3FfVUmxnI37TQrOWoSfx7MCUVBXjD4xUzacPqYEKq8dsdZ/3ncwgTRYyQrW3Lue6817e3lz3E5FgK9GLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdcZpvpm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B54AC4CEE7;
	Thu, 15 May 2025 12:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747313229;
	bh=LeJR/zvlqj5Asj/nQfg1x5VrUEA2v3eAMcSq5/MpbRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gdcZpvpmOGhPzvmOFOQWvJ63XmLv2pUBNt3ajACDolPLQWBEkwtHpx1hxEPFWBo4P
	 htIbJ2GjdbMWquhYSeDK6bLqf5sJqFyuCdCTPch1xbGxJcE86eesZd8ptvoKiC2MuB
	 G70YFdeRns32sbyezhV+P6GxmtINs6cgvscTBJYNR8A/lUxZ4Sf3dOha+xcKAxRbyT
	 TgI43IriwRJatGqS1O9giwXunijyF38O2BG9h0G1fT3MGT5wm6JkG4ddo6impOc2Tp
	 PKWXAXVRBkaY/rcAUoErSBxwVrmHl7pkqfpC9H7MSTdKTG2ZeopiVP5ulO+0KOfmkK
	 L4kGbHK2RlPsw==
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-arch@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 09/15] bugs/LoongArch: Concatenate 'cond_str' with '__FILE__' in __BUG_ENTRY(), to extend WARN_ON/BUG_ON output
Date: Thu, 15 May 2025 14:46:38 +0200
Message-ID: <20250515124644.2958810-10-mingo@kernel.org>
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

Extend WARN_ON and BUG_ON style output from:

  WARNING: CPU: 0 PID: 0 at kernel/sched/core.c:8511 sched_init+0x20/0x410

to:

  WARNING: CPU: 0 PID: 0 at [idx < 0 && ptr] kernel/sched/core.c:8511 sched_init+0x20/0x410

Note that the output will be further reorganized later in this series.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: <linux-arch@vger.kernel.org>
---
 arch/loongarch/include/asm/bug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/bug.h b/arch/loongarch/include/asm/bug.h
index 3c377984457d..cad807b100ad 100644
--- a/arch/loongarch/include/asm/bug.h
+++ b/arch/loongarch/include/asm/bug.h
@@ -26,7 +26,7 @@
 		.pushsection __bug_table, "aw";			\
 		.align 2;					\
 	10000:	.long 10001f - .;				\
-		_BUGVERBOSE_LOCATION(__FILE__, __LINE__)	\
+		_BUGVERBOSE_LOCATION(WARN_CONDITION_STR(cond_str) __FILE__, __LINE__) \
 		.short flags;					\
 		.popsection;					\
 	10001:
-- 
2.45.2


