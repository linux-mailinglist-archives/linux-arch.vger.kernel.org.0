Return-Path: <linux-arch+bounces-11951-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D943AB86E5
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 14:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53E95165532
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 12:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BB929E060;
	Thu, 15 May 2025 12:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlfS+X5g"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B6529E05C;
	Thu, 15 May 2025 12:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313232; cv=none; b=Gu9lohIbjnkz64S9WFGWzxnEwPm3KJ1aQuk5YJ6waeV9KJIV8tqRVv2VxrzQ2ICOAZfulBgMa/InZlqcQ3GeiZYWglx/SM90bVpahfJtjva1P8hOuPNqvS3HNkYH2XtXnHRlrUmaq/ankNWiQeH6C2xNmoUlMTAav9WBga6zaf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313232; c=relaxed/simple;
	bh=D0EBAcu5h+E8B+tSkeOpT9HaAEV4VC97bQRYTcVTptc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKMz9D+nbgKixKTyYrQtSuVHmeIFdTKxpzEMk4vRESRpf46NXBDH+PH3p7LqP05/hWC+YhOc0r8gjKWC+ChFDKc8U6fsO+dRhJA6mpFMZzLZsvMHH0LgkhPeicNFOtg4ktFXAiOjOlsIl1klYSIFoY2Z2UaM8WLf/MLHDjJ0htk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlfS+X5g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFECC4CEEF;
	Thu, 15 May 2025 12:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747313232;
	bh=D0EBAcu5h+E8B+tSkeOpT9HaAEV4VC97bQRYTcVTptc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rlfS+X5gFWhHhd1X1XTm2EOkA5pS93fd1FTpXpCBkg+SeNumUIYdVn/cpOfzaeSnn
	 GQA91Xsy0GMeGm/JML5N9prRQC+/G4l4qjYL594QjNToryitMtiNZf6XMoWROyby18
	 4DrkillrNGWgpwwh4soauzXwiJcJBh87Jqwe6tJ6VYfu+L9gVTaJpdaoHFxTa9FEmd
	 lOjNerM0XD5HMMfbbsbBAR0qR5Dggo9z2xBXw5jv2vScx6BmXn6Sd0qXCbHfWfSNqk
	 BX5OoJOupmkMNLP8bslLyNjKhMycSCz8ksp6vfA4+YRwVyqYHQos4/dJj4BJjJaqob
	 R3Afx5boKunXA==
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-arch@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: [PATCH 10/15] bugs/s390: Pass in 'cond_str' to __EMIT_BUG()
Date: Thu, 15 May 2025 14:46:39 +0200
Message-ID: <20250515124644.2958810-11-mingo@kernel.org>
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

Pass in the condition string from __WARN_FLAGS(), but do not
concatenate it with __FILE__, because the __bug_table is
apparently indexed by 16 bits and increasing string size
overflows it on defconfig builds.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: <linux-arch@vger.kernel.org>
---
 arch/s390/include/asm/bug.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
index ef3e495ec1e3..30f8785a01f5 100644
--- a/arch/s390/include/asm/bug.h
+++ b/arch/s390/include/asm/bug.h
@@ -8,7 +8,7 @@
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 
-#define __EMIT_BUG(x) do {					\
+#define __EMIT_BUG(cond_str, x) do {				\
 	asm_inline volatile(					\
 		"0:	mc	0,0\n"				\
 		".section .rodata.str,\"aMS\",@progbits,1\n"	\
@@ -27,7 +27,7 @@
 
 #else /* CONFIG_DEBUG_BUGVERBOSE */
 
-#define __EMIT_BUG(x) do {					\
+#define __EMIT_BUG(cond_str, x) do {				\
 	asm_inline volatile(					\
 		"0:	mc	0,0\n"				\
 		".section __bug_table,\"aw\"\n"			\
@@ -42,12 +42,12 @@
 #endif /* CONFIG_DEBUG_BUGVERBOSE */
 
 #define BUG() do {					\
-	__EMIT_BUG(0);					\
+	__EMIT_BUG("", 0);				\
 	unreachable();					\
 } while (0)
 
 #define __WARN_FLAGS(cond_str, flags) do {		\
-	__EMIT_BUG(BUGFLAG_WARNING|(flags));		\
+	__EMIT_BUG(cond_str, BUGFLAG_WARNING|(flags));	\
 } while (0)
 
 #define WARN_ON(x) ({					\
-- 
2.45.2


