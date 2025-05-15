Return-Path: <linux-arch+bounces-11946-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D92AB86DF
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 14:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D5521898838
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 12:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A9829CB3C;
	Thu, 15 May 2025 12:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9mQumRm"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC0629CB38;
	Thu, 15 May 2025 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313219; cv=none; b=XhanvwIIE0d6Xs+/3wiLO3NlyA1cQ6dpiBUU2v2k42UPH95nFVSPOq9/r9yx/lTulEuGDsKgpjhkpAzxwPon+IeFNkRDcdQ8tXOtls7IyUaRB0jQmLf+F9lZrsFhTPPL5YseONREdvvF68V8Oek/voYhfRdAwjw8j6iqZLFf85o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313219; c=relaxed/simple;
	bh=hA1c0OyENsr1ysGC987MlXCevo9xNowDqcLFfqACaOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/Ka4he3fZ3+oSaRCec97c3vt1ea6eyqODydX1Q6SCyPTPBOnjJbo4bIGe/z23N4P+hIRQWPfWvn+Fp8N+xBHGW4roY5ylLs7wHby/1nKVhnGUmvv3nV0TDTvT0V4TF4hb4q4QPwy94kNB7/VFgX5VlusyuBP6YDSgle0MOViAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9mQumRm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B0BC4CEEF;
	Thu, 15 May 2025 12:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747313218;
	bh=hA1c0OyENsr1ysGC987MlXCevo9xNowDqcLFfqACaOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b9mQumRm1F0RMkdDZpcOxAUJ/zoHcaVMMHKBdnkUUnjcaRE7AfE25yeigRdb0cSNz
	 G7pkIDmuGeemx+Bv+r8i8jj7FmRVspQXbXqC9wdtARJc299MQF8mxkloLmEUfKYiih
	 JNfQt3TkEG/SRgo6Pi1kXIOUlDH5dv5l9dnByXbm8E3QEgPLrorMZLE+nwR+ZfptTz
	 KvipShkx1kIQym54LhXQR5UwqtLEc7XA2o4TlcST6rD7WiUTHBWm0uJNceXKn0R6a+
	 8lrhA+tPJRFAS2ygm5YqADJVmirww0ISiZkUA0k+ODF8sduKSnJ2wSxwc1U3k/GS9h
	 QTWY0V2RdpeaA==
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-arch@vger.kernel.org
Subject: [PATCH 05/15] bugs/x86: Augment warnings output by concatenating 'cond_str' with the regular __FILE__ string in _BUG_FLAGS()
Date: Thu, 15 May 2025 14:46:34 +0200
Message-ID: <20250515124644.2958810-6-mingo@kernel.org>
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

This allows the reuse of the UD2 based 'struct bug_entry' low-overhead
_BUG_FLAGS() implementation and string-printing backend, without
having to add a new field.

An example:

If we have the following WARN_ON_ONCE() in kernel/sched/core.c:

	WARN_ON_ONCE(idx < 0 && ptr);

Then previously _BUG_FLAGS() would store this string in bug_entry::file:

	"kernel/sched/core.c"

After this patch, it would store and print:

	"[idx < 0 && ptr] kernel/sched/core.c"

Which is an extended string that will be printed in warnings.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: <linux-arch@vger.kernel.org>
---
 arch/x86/include/asm/bug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index aff1c6b7a7f3..8593976b32cb 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -50,7 +50,7 @@ do {									\
 		     "\t.org 2b+%c3\n"					\
 		     ".popsection\n"					\
 		     extra						\
-		     : : "i" (__FILE__), "i" (__LINE__),		\
+		     : : "i" (WARN_CONDITION_STR(cond_str) __FILE__), "i" (__LINE__),		\
 			 "i" (flags),					\
 			 "i" (sizeof(struct bug_entry)));		\
 } while (0)
-- 
2.45.2


