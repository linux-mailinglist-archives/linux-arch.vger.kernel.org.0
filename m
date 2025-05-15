Return-Path: <linux-arch+bounces-11944-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAA9AB86D9
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 14:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97B001613F6
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 12:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE0C29C33C;
	Thu, 15 May 2025 12:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPHbaL0s"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1481329C338;
	Thu, 15 May 2025 12:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313215; cv=none; b=Ew2hieuN8VQtocXmXgShkRsOwNJPmBJDEuOD0vf1J3eQiR2UWHcCqKBo5Zx6yrljqdetmwbWJACbCVn/E5xn0WD5POtTDwMUm8DiZrbr/eFAvVCf4dJPdIdNGtuUpzIAvvQfvvmHDjV2cpyWu8jlTHLPz4uCthsrimjnt27NDu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313215; c=relaxed/simple;
	bh=Jr76BiKNHlHCaU2fuOPaiTRLzkjpx/dkIdf7yZEGdpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWFULUMJRDPvs2G/j4SbA8L9FDviF14V+eKOy4PewlUXZ/mFtcvYt6aU6UAbWmo4n6ou8247Eeh6sHnGNeOg+E5AhXV7KThuOeLWTCY2yQVKdGpIXM+a9inqReCCI8JAUe4xH66T5yoo6CAP+snp8QOSY/ni+JczbgAdImNVTbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPHbaL0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B770C4CEE7;
	Thu, 15 May 2025 12:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747313215;
	bh=Jr76BiKNHlHCaU2fuOPaiTRLzkjpx/dkIdf7yZEGdpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sPHbaL0seGaXVxQdJtxEhaUphpxdPGwBQe8COvf2EWIOTZPbtgsTnBcDfJ9j18xnc
	 xvAnwiPVsjXoOalkx6mR9A6lKy2JgCql2ZLR4dw10D9z64HmuuntKzoWrhpK9FsPZI
	 iI5Njvez774PHRJfkSxwd0mhb9y53rnGheF92SrqzJgtI+cKYYiMUPijxEPePfh+i+
	 Hm4dwt9R+fT8JFSvhUe4qkktnOlNOxxiwhg230JdQL6iALcfY9iINPiKXzXcYLbSPb
	 VJdo6qjjfZc1ybI+L1pkFo5nWVEftoPjvS9KlEYv4lRPFrqXwfyzvWAKBOXm3Pe4zW
	 qKMSviGAIcrhA==
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-arch@vger.kernel.org
Subject: [PATCH 03/15] bugs/core: Introduce the CONFIG_DEBUG_BUGVERBOSE_DETAILED Kconfig switch
Date: Thu, 15 May 2025 14:46:32 +0200
Message-ID: <20250515124644.2958810-4-mingo@kernel.org>
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

Allow configurability of the inclusion of more detailed
WARN_ON() strings, to be implemented in subsequent
commits.

Since the full cost will be around 100K more memory on
an x86 defconfig, disable it by default.

Provide the WARN_CONDITION_STR() macro to allow the conditional
passing of extra strings to lower level BUG/WARN handlers.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: <linux-arch@vger.kernel.org>
---
 include/asm-generic/bug.h |  6 ++++++
 lib/Kconfig.debug         | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index c8e7126bc26e..bc7a22e2bf49 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -92,6 +92,12 @@ void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
 		       const char *fmt, ...);
 extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 
+#ifdef CONFIG_DEBUG_BUGVERBOSE_DETAILED
+# define WARN_CONDITION_STR(cond_str) cond_str
+#else
+# define WARN_CONDITION_STR(cond_str) ""
+#endif
+
 #ifndef __WARN_FLAGS
 #define __WARN()		__WARN_printf(TAINT_WARN, NULL)
 #define __WARN_printf(taint, arg...) do {				\
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f9051ab610d5..59fb70b307e4 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -206,6 +206,16 @@ config DEBUG_BUGVERBOSE
 	  of the BUG call as well as the EIP and oops trace.  This aids
 	  debugging but costs about 70-100K of memory.
 
+config DEBUG_BUGVERBOSE_DETAILED
+	bool "Verbose WARN_ON_ONCE() reporting (adds 100K)" if DEBUG_BUGVERBOSE
+	help
+	  Say Y here to make WARN_ON_ONCE() output the condition string of the
+	  warning, in addition to the file name and line number.
+	  This helps debugging, but costs about 100K of memory.
+
+	  Say N if unsure.
+
+
 endmenu # "printk and dmesg options"
 
 config DEBUG_KERNEL
-- 
2.45.2


