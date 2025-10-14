Return-Path: <linux-arch+bounces-14103-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6CFBDBCD6
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 01:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B753619A36B9
	for <lists+linux-arch@lfdr.de>; Tue, 14 Oct 2025 23:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7EC2F6193;
	Tue, 14 Oct 2025 23:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKdDKOWi"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8952F5472;
	Tue, 14 Oct 2025 23:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760484437; cv=none; b=RyHZ80F9AKFL+eto4L/L8FIvbtnlPHTMX8Hdii2Qtga12tsq9lizx3um6saVOGLCHcv6SuYCok0oF7+i90r8kRD+t88Q70MLc91UdVRb0ZQXHiSzVuVH09Ov0wTchch+FSdJvMpVwXWuxAX9oWYP/0qFwPisQEjFKXo/xJmYP4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760484437; c=relaxed/simple;
	bh=QGg+cLDwaefAIpaStFsfisZ/bUz9GPM0JcN2ANfbxL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKYGNgnIB3S0aILuDb+QeN8Vl+NLWFvJgEKDuxEdytDTqW1ARcWtp1qLnRiwPMz5HyqQg4B8hetjyDCSVq+1Mc0J5YH5m5crhlBxZ7nJkMuxcPO3ahj5NImxFGBt2O/eDxqlYF1GM8ttC3y7zEVX5sZ8fmK94bHm/+Shpma48gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKdDKOWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B694CC4CEE7;
	Tue, 14 Oct 2025 23:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760484436;
	bh=QGg+cLDwaefAIpaStFsfisZ/bUz9GPM0JcN2ANfbxL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pKdDKOWiCCF0uO5b9ZcYY1BKNr+frW1mUAru6DUz9aXZJTdh6ZWlh5tnRp95mgDfQ
	 RdfvUAJTqnZX1mtiK631WnZGgekKT0nhK6WXDPiqCNtoAsYYNZU2O9AFP1RQgkTv+t
	 f6dVDm/cXoDfYVbTQsj29DLBis4ZYBqIUcVVGfj9DF9PunCEJ/C+ko7w1gTcEw1kSy
	 qD3WijxGv+RiypVFw9Fn14vqwIqKR/vXB4zqgM5KMiJ01EtOk7LEh6KJlB4dbOKbuD
	 E8M5VPBwNRnnqOLqNgkorR3uN7/hb/dh7blUarL6QnXAdyEV+UOAN7pLPsEUxxWIGU
	 IT/smkxEufu2Q==
From: Sasha Levin <sashal@kernel.org>
To: nathan@kernel.org
Cc: Matt.Kelly2@boeing.com,
	akpm@linux-foundation.org,
	andrew.j.oppelt@boeing.com,
	anton.ivanov@cambridgegreys.com,
	ardb@kernel.org,
	arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	chuck.wolber@boeing.com,
	dave.hansen@linux.intel.com,
	dvyukov@google.com,
	hpa@zytor.com,
	jinghao7@illinois.edu,
	johannes@sipsolutions.net,
	jpoimboe@kernel.org,
	justinstitt@google.com,
	kees@kernel.org,
	kent.overstreet@linux.dev,
	linux-arch@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	llvm@lists.linux.dev,
	luto@kernel.org,
	marinov@illinois.edu,
	masahiroy@kernel.org,
	maskray@google.com,
	mathieu.desnoyers@efficios.com,
	matthew.l.weber3@boeing.com,
	mhiramat@kernel.org,
	mingo@redhat.com,
	morbo@google.com,
	ndesaulniers@google.com,
	oberpar@linux.ibm.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	richard@nod.at,
	rostedt@goodmis.org,
	samitolvanen@google.com,
	samuel.sarkisian@boeing.com,
	sashal@kernel.org,
	steven.h.vanderleest@boeing.com,
	tglx@linutronix.de,
	tingxur@illinois.edu,
	tyxu@illinois.edu,
	wentaoz5@illinois.edu,
	x86@kernel.org
Subject: [RFC PATCH 3/4] x86: disable llvm-cov instrumentation
Date: Tue, 14 Oct 2025 19:26:38 -0400
Message-ID: <20251014232639.673260-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014232639.673260-1-sashal@kernel.org>
References: <20250829181007.GA468030@ax162>
 <20251014232639.673260-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wentao Zhang <wentaoz5@illinois.edu>

Disable instrumentation for arch/x86/crypto/curve25519-x86_64.c. Otherwise
compilation would fail with "error: inline assembly requires more registers
than available".

Similar behavior was reported with gcov as well. See c390c452ebeb ("crypto:
x86/curve25519 - disable gcov").

Signed-off-by: Wentao Zhang <wentaoz5@illinois.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/crypto/Makefile | 1 +
 lib/crypto/Makefile      | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
index 2d30d5d361458..9fac64c39766f 100644
--- a/arch/x86/crypto/Makefile
+++ b/arch/x86/crypto/Makefile
@@ -77,3 +77,4 @@ aria-aesni-avx2-x86_64-y := aria-aesni-avx2-asm_64.o aria_aesni_avx2_glue.o
 
 obj-$(CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64) += aria-gfni-avx512-x86_64.o
 aria-gfni-avx512-x86_64-y := aria-gfni-avx512-asm_64.o aria_gfni_avx512_glue.o
+
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index bded351aeacef..9a8040ea7b626 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -81,8 +81,9 @@ libchacha20poly1305-$(CONFIG_CRYPTO_SELFTESTS)	+= chacha20poly1305-selftest.o
 obj-$(CONFIG_CRYPTO_LIB_CURVE25519) += libcurve25519.o
 libcurve25519-y := curve25519.o
 
-# Disable GCOV in odd or sensitive code
+# Disable GCOV and llvm-cov in odd or sensitive code
 GCOV_PROFILE_curve25519.o := n
+LLVM_COV_PROFILE_curve25519-x86_64.o := n
 
 ifeq ($(CONFIG_ARCH_SUPPORTS_INT128),y)
 libcurve25519-$(CONFIG_CRYPTO_LIB_CURVE25519_GENERIC) += curve25519-hacl64.o
-- 
2.51.0


