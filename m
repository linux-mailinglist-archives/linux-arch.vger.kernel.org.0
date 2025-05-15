Return-Path: <linux-arch+bounces-11945-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02249AB86DD
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 14:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEACD3B59F6
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 12:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0977929C357;
	Thu, 15 May 2025 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOTi7X2V"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78BE29C352;
	Thu, 15 May 2025 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313216; cv=none; b=HH7lmtKdQhU3zny1yrVT9CpEQglBi+fQF2Fd4BQTl66y3KAqLkDvprBRHn2sP8EYUXXijJxchfL6LXI4Ymiu94R+apKuSEhjYERLFTyHK2L+gS5cB7xhDMMQJmbJYJKFqlQL8JR6MiKKrU6+/4eA+vAAb6kl3NK0IcrvvGM8P+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313216; c=relaxed/simple;
	bh=v63/wEjVZ21rpDvd+eA4iuuSMVSV/g81NATswursLNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=av8Rl27PSWviuqhIeAS6UYEwhijGkiQn1Zo0b32mPCcETfvuQDwywlbayqfCJBzmGGepd19BbFKgHh3n2gK8hadVgHrMGEFk/u8DrS0Lj+TPZ9AEiLbMefKxTHt+3pR3rUj7zCmx4mYMvzLFeO1oFeA5LYZY3369eXc7FY/Yokc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOTi7X2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F19C4CEE7;
	Thu, 15 May 2025 12:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747313216;
	bh=v63/wEjVZ21rpDvd+eA4iuuSMVSV/g81NATswursLNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lOTi7X2VED/CKwvYP+p0bKz0+glQ/4CsoBRPTxl8buNvdB1TXF2mJPaVyQp506AQQ
	 Lyw5m730UVmcYSlXqEMWELNbF6r/m3gjvBFOjel04cbpoLhnvR2Gq5sCBOXf2QlSVx
	 WgxBY5s7LtY+xP1F/RArEXk/picujXML/6YaGJKLVJZaEC/ZQGnwFNoLpEdQ5hX5Lc
	 F5VGVhRkiW2MulS747aMX0WgZyZjkFAc7IS0vD96O2NemZFkvIqX+HqNrGtt/Brb/e
	 yXNnLEqTOFiSc0CbENjKVEmCTh/ENjJHu8AEh1Plu+9/VJpXkOdaPOnx9xhxpUog5s
	 Hggyy4s9jxAUQ==
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-arch@vger.kernel.org
Subject: [PATCH 04/15] bugs/x86: Extend _BUG_FLAGS() with the 'cond_str' parameter
Date: Thu, 15 May 2025 14:46:33 +0200
Message-ID: <20250515124644.2958810-5-mingo@kernel.org>
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

Just pass down the parameter, don't do anything with it yet.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: <linux-arch@vger.kernel.org>
---
 arch/x86/include/asm/bug.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 413b86b876d9..aff1c6b7a7f3 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -39,7 +39,7 @@
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 
-#define _BUG_FLAGS(ins, flags, extra)					\
+#define _BUG_FLAGS(cond_str, ins, flags, extra)				\
 do {									\
 	asm_inline volatile("1:\t" ins "\n"				\
 		     ".pushsection __bug_table,\"aw\"\n"		\
@@ -57,7 +57,7 @@ do {									\
 
 #else /* !CONFIG_DEBUG_BUGVERBOSE */
 
-#define _BUG_FLAGS(ins, flags, extra)					\
+#define _BUG_FLAGS(cond_str, ins, flags, extra)				\
 do {									\
 	asm_inline volatile("1:\t" ins "\n"				\
 		     ".pushsection __bug_table,\"aw\"\n"		\
@@ -74,7 +74,7 @@ do {									\
 
 #else
 
-#define _BUG_FLAGS(ins, flags, extra)  asm volatile(ins)
+#define _BUG_FLAGS(cond_str, ins, flags, extra)  asm volatile(ins)
 
 #endif /* CONFIG_GENERIC_BUG */
 
@@ -82,7 +82,7 @@ do {									\
 #define BUG()							\
 do {								\
 	instrumentation_begin();				\
-	_BUG_FLAGS(ASM_UD2, 0, "");				\
+	_BUG_FLAGS("", ASM_UD2, 0, "");				\
 	__builtin_unreachable();				\
 } while (0)
 
@@ -96,7 +96,7 @@ do {								\
 do {								\
 	__auto_type __flags = BUGFLAG_WARNING|(flags);		\
 	instrumentation_begin();				\
-	_BUG_FLAGS(ASM_UD2, __flags, ANNOTATE_REACHABLE(1b));	\
+	_BUG_FLAGS(cond_str, ASM_UD2, __flags, ANNOTATE_REACHABLE(1b)); \
 	instrumentation_end();					\
 } while (0)
 
-- 
2.45.2


