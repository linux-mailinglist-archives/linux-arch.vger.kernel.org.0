Return-Path: <linux-arch+bounces-11955-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 608ECAB86F4
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 14:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6384E7407
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 12:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDB32BD58A;
	Thu, 15 May 2025 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCUREwYl"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DCE2BD01D;
	Thu, 15 May 2025 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313243; cv=none; b=tAE6LutD84PjmqwzXg/q4xS78PR+paT65UCllqJJ3Wt53BmVURBnFjpzZrQbTDYK8Q8IEXbbWKVaMhoJoEZVPgB1Byuj5zL3Pohr5wwKiMFt2xj481KUxKYFx2Y2HxqhvMewxqKh1dPOCdX+msuFrFSxP4qMFMQhD1qhF8LhifA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313243; c=relaxed/simple;
	bh=9dOa5FJa50VZuoyhOr1m0v8KpFixv0MsGbwBXNojatQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rg87II14PWSQ8QW+kokzDshUPwJBt6nRBdKpt20jJp5rHpyqRXpvg63hdChvZkeb+QSRcj0rYMwXoXqazm6Znc+0ZVh9T0KmKp7RiO+ZVlI14GkPVIR3U6JTBUEB+61+jnWrywx1Y91O6/jVNFpPaMaL5RcQJha03VX/BvV4s0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCUREwYl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE009C4CEF0;
	Thu, 15 May 2025 12:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747313242;
	bh=9dOa5FJa50VZuoyhOr1m0v8KpFixv0MsGbwBXNojatQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tCUREwYlMVwmOW5TQVoGUh9ScohKkWrvCDCIuVjD3N7GfmSPNssOw16tnHLq2/644
	 XxxmQGmGWF64DRkcOPvP7tgMiEWneTOEcb117fK/fUiG3eSpHRHAJ3YqeXp7KOpuSV
	 pq+Z8GKP9uWT+40iGtZs2yKoHsAZLd8cfibc24Hnx6GwQqYhN7KAz10yNc8l9KCj79
	 giDmhEp1Ah5ntADJaUR3+CAFMk3iUJPMS8FMUxi+VxhKrCt2ad2ypr9cvWtiQke9cU
	 mKGo4VOKmR9l0rlBoT0jGS99PVs6ai4qZ4UVsKqCYcDveyMOaJsjKlLt8exqHRn+Cl
	 dvKdYjJQmWtRA==
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-arch@vger.kernel.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org
Subject: [PATCH 14/15] bugs/sh: Concatenate 'cond_str' with '__FILE__' in __WARN_FLAGS(), to extend WARN_ON/BUG_ON output
Date: Thu, 15 May 2025 14:46:43 +0200
Message-ID: <20250515124644.2958810-15-mingo@kernel.org>
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
Cc: <linux-arch@vger.kernel.org>
---
 arch/sh/include/asm/bug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/include/asm/bug.h b/arch/sh/include/asm/bug.h
index 834c621ab249..891276687355 100644
--- a/arch/sh/include/asm/bug.h
+++ b/arch/sh/include/asm/bug.h
@@ -59,7 +59,7 @@ do {							\
 		 _EMIT_BUG_ENTRY			\
 		 :					\
 		 : "n" (TRAPA_BUG_OPCODE),		\
-		   "i" (__FILE__),			\
+		   "i" (WARN_CONDITION_STR(cond_str) __FILE__),	\
 		   "i" (__LINE__),			\
 		   "i" (BUGFLAG_WARNING|(flags)),	\
 		   "i" (sizeof(struct bug_entry)));	\
-- 
2.45.2


