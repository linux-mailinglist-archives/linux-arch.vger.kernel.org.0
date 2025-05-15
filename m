Return-Path: <linux-arch+bounces-11943-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C4AAB86D4
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 14:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24801171731
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 12:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF2C29B8F6;
	Thu, 15 May 2025 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FungqfUV"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483A729ACC1;
	Thu, 15 May 2025 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313213; cv=none; b=ijq3c1p388zt9ysjvO3Jxh6+gYTMUv2f2uZI9k9MlwA38azNeIqjw2PWAhEk6/qWQraLVtW7slwgTrUFX8LyTZbos+iQKgP2Vc0HJgmE6R7rxCRtM7l6Ed+LUIQ5K3TO37rnrO5R0dv/WvC2E0rzuu+CjnDfNuZ/szFZ+GNXx6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313213; c=relaxed/simple;
	bh=tLoDff4noC9eDpa+e8BeKdNFYnRcpSD+Synn8gBfa78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTFuhVKuCVrJWCFv1ERUi8LDx3WTzHIi2a+qP0qLo7VCWaaPIU6oLDhOofMZGZ6EfpPLS0u9tn3rSBwu/32c+IElbBLvCh4mELiCFNnHlHsKAD7hRvun6yHwGSy9a0V84cepHa19n4kHJzkShYqMGVgMiNA1pTkztHiV8p+CPqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FungqfUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD887C4CEE7;
	Thu, 15 May 2025 12:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747313213;
	bh=tLoDff4noC9eDpa+e8BeKdNFYnRcpSD+Synn8gBfa78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FungqfUVfH4ShUaXOORoWuXvh3JoDb7WjXXRJCA2ZX+Ka/s/rGzDIJphR75ZVt005
	 ggOFmmVJlvHr/ZP5Kssl5ExrqaxHrLwuz694kara/+5cOz7im0hr8/OMW5mWJnYQCm
	 4EsVfMliT9fg/DKF2p71rmZXONJS9jfKheVWimmIxDLauMgsMZpHeXThw9NsE56oV5
	 iT01M2MhU1/fT9ls6pun5X07GfEg9+e63x9IvNUrOZle2b2YsmbZm2xZKUcWfd1HMq
	 lPYVEEDPAAqNnEUEGS2NwzuA8l/e6qKOFzW8pKo/3RDL7YO/zRoNuZ9agHLFYAkteR
	 2FqVhThCy3B5w==
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-arch@vger.kernel.org
Subject: [PATCH 02/15] bugs/core: Pass down the condition string of WARN_ON_ONCE(cond) warnings to __WARN_FLAGS()
Date: Thu, 15 May 2025 14:46:31 +0200
Message-ID: <20250515124644.2958810-3-mingo@kernel.org>
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

Doing this will allow architecture code to store and print out
this information as part of the WARN_ON and BUG_ON facilities.

The format of the string is '[condition]', for example:

  WARN_ON_ONCE(idx < 0 && ptr);

Will get the '[idx < 0 && ptr]' string literal passed down as 'cond_str'
in __WARN_FLAGS().

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: <linux-arch@vger.kernel.org>
---
 include/asm-generic/bug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index af76e4a04b16..c8e7126bc26e 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -110,7 +110,7 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 #define WARN_ON_ONCE(condition) ({				\
 	int __ret_warn_on = !!(condition);			\
 	if (unlikely(__ret_warn_on))				\
-		__WARN_FLAGS("",				\
+		__WARN_FLAGS("["#condition"] ",			\
 			     BUGFLAG_ONCE |			\
 			     BUGFLAG_TAINT(TAINT_WARN));	\
 	unlikely(__ret_warn_on);				\
-- 
2.45.2


