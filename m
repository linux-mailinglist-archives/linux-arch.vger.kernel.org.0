Return-Path: <linux-arch+bounces-3133-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF4E8877B5
	for <lists+linux-arch@lfdr.de>; Sat, 23 Mar 2024 10:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1352B215FF
	for <lists+linux-arch@lfdr.de>; Sat, 23 Mar 2024 09:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8B3DDC5;
	Sat, 23 Mar 2024 09:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9n2IhuT"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AEB53A6;
	Sat, 23 Mar 2024 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711184795; cv=none; b=dv96qe6oCOmJt4Sf3OxySY6jJ9CNIPPjTiw/9Ab/7WD3kDVs77+khupz6QixmtrMyXIPfzGt2a11j6sYpuNnToXQRyQllRuGdVDuTEyAL0VzLZPxBBgvIYrOaf/blvCFbknms94S/9PzMHhwDajCoxyGmfVeLyYllKSAAWMevSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711184795; c=relaxed/simple;
	bh=ZOv3sSaesxblVEAdTM44UPJ7JatqCSeSPmXcVNQm2nw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JQRH0XrNGRuL/V7LNdV+sOouuK/5exqlF+bwzwcPucHx1pRzQxgnthunZW/vAjXIGC7u5HJUIihtQvmcuN45G8crgeQhNwQ6G9sgpz1WpaPL4mMMvq2ch8g7z6Ge1nGaT9RXvWaGKujZZWodoit07kmfMRWVDc55mG0tzyASrKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9n2IhuT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738D9C433F1;
	Sat, 23 Mar 2024 09:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711184794;
	bh=ZOv3sSaesxblVEAdTM44UPJ7JatqCSeSPmXcVNQm2nw=;
	h=From:To:Cc:Subject:Date:From;
	b=k9n2IhuTRpWMUr22Rqdcy09O2XfV33rrrY9XT7OPmgJ0laQCujJxF7Xt1mhHlmSYG
	 v8HI4rH3Y3w2mC/psMahQK9PkPw4atJRajpRe2kaLrI+1rkqq9enn7Jrl77O+ja1pp
	 HSxA/r7b0E9jERyxy1NhCYPLgD6CF3Z4S4yyHYPcVDWe0iACbegoR3P5CQb9rmQfaA
	 4i84kcbPNdpigQ9bpkWe+Zq0uXIlh+6otMFtSHZKd1tvMZ8abnBvJCkvUpTfvrKS9R
	 1egt38OH1p0o/dBRm2WdDk9S6Cdn6bZXKBVEdfL7a4VKqlwmIs5nOQz+tV2Lv5P/1M
	 HZlO2YOvXWM3Q==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Arnd Bergmann <arnd@arndb.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-arch@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] export.h: remove include/asm-generic/export.h
Date: Sat, 23 Mar 2024 18:06:15 +0900
Message-Id: <20240323090615.1244904-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 3a6dd5f614a1 ("riscv: remove unneeded #include
<asm-generic/export.h>") removed the last use of
include/asm-generic/export.h.

This deprecated header can go away.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/asm-generic/export.h | 11 -----------
 1 file changed, 11 deletions(-)
 delete mode 100644 include/asm-generic/export.h

diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
deleted file mode 100644
index 570cd4da7210..000000000000
--- a/include/asm-generic/export.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-#ifndef __ASM_GENERIC_EXPORT_H
-#define __ASM_GENERIC_EXPORT_H
-
-/*
- * <asm/export.h> and <asm-generic/export.h> are deprecated.
- * Please include <linux/export.h> directly.
- */
-#include <linux/export.h>
-
-#endif
-- 
2.40.1


