Return-Path: <linux-arch+bounces-9831-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F69A17426
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2025 22:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52BF016A0E2
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2025 21:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581321EF0AC;
	Mon, 20 Jan 2025 21:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLgIXfzq"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAD61EE029;
	Mon, 20 Jan 2025 21:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737408579; cv=none; b=QOqoDkfV4gV66l0+ku2mhYNJoMHZjN4ai5zL0uZhxtZiGFemRLQP4AgCRHbJ4znNncekKH2X8xe8GarlJ9cdok1+uSotNNvl/uJcXyHQrFM5/HmjQzds0lQlVI/W/lf0U4I6Gc7RWLzpdfUCGIfsrrfB0pYF4FpD8lTqBX4HzMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737408579; c=relaxed/simple;
	bh=0A/IiwipF4tufFW9x7U3QF3BH14PZviyNA/40f6bGAU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F9qLRO1ftRKEPnhMGToK9gopfEzANS6KxgrvrQ1JKJKAGVqK8l3PCceQp9aS+ll0TEnLTj4Jljr0Tpb7nbw3FpElZ6XXarUq5/VOf4ZgqH/svykGd/d6mNaLn+6SZl7MASMLx+oGdPLY2aAfUwXA7UFM6aUVl1E7nlmiQ0CdNkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLgIXfzq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346B5C4CEDD;
	Mon, 20 Jan 2025 21:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737408578;
	bh=0A/IiwipF4tufFW9x7U3QF3BH14PZviyNA/40f6bGAU=;
	h=From:To:Cc:Subject:Date:From;
	b=hLgIXfzqmMUs45JJuClzWs5uAYelisTd+yHnenKrMAMNtIH/YwGHTSkWKQmT24hTf
	 RM8ay04a01oKCHVGrMMJfOrX4u1ktuFGcRou12+FFxadNkJOMJQrx+FcXKsoTE8en3
	 9Lv8k1xqAg1W8CRaytKOH5LV5aF5Dg4f2p7Yf0SR/XBnZGlK5SJPPBxUMP49NRUGop
	 FA/9I6CVUAs7V88mK1GEa70rI59MDDdkABqhvB3PK+nEPrVH29RZ0M+e+31eFpHoGA
	 XodweUtGCthEAANHYjjR99YuMOWhj/pUPuNXE0riethxv+sSa6tG/DvWTecUlTua76
	 veTFsd8uKTEXA==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kbuild@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	regressions@lists.linux.dev,
	Han Shen <shenhan@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Rong Xu <xur@google.com>,
	Jann Horn <jannh@google.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arch@vger.kernel.org
Subject: [PATCH] [RFC, DO NOT APPLY] vmlinux.lds: revert link speed regression
Date: Mon, 20 Jan 2025 22:21:27 +0100
Message-Id: <20250120212839.1675696-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

I noticed a regression in the time it takes to fully link some randconfig
kernels and bisected this to commit 0043ecea2399 ("vmlinux.lds.h: Adjust
symbol ordering in text output section"), which (among other changes) moves
.text.unlikely ahead of .text.

Partially reverting this makes the final link over six times faster again,
back to what it was in linux-6.12:

		linux-6.12	linux-6.13
ld.lld v20	1.2s		1.2s
ld.bfd v2.36	3.2s		5.2s
ld.bfd v2.39	59s		388s

According to the commit description, that revert is not allowed here
because with CONFIG_LD_DEAD_CODE_DATA_ELIMINATION, the .text.unlikely
section name conflicts with the function-section names. On the other
hand, the excessive link time happens both with and without that
option, so the order could be conditional.

I did not try to bisect the linker beyond trying multiple versions
I had installed already, and it does feel like the behavior of recent
versions (tested 2.39 and 2.42 with identical results) is broken in
some form that earlier versions were not. According to 'perf', most
of the time is spent in elf_link_adjust_relocs() and ext64l_r_offset().

I also did not try to narrow the problem down to specific kernel
configuration options, but from my first impression it does appear
to be rare, and unrelated to the Propeller options added in 6.13.

Cc: regressions@lists.linux.dev
Cc: Han Shen <shenhan@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Fixes: 0043ecea2399 ("vmlinux.lds.h: Adjust symbol ordering in text output section")
Link: https://pastebin.com/raw/sWpbkapL (config)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/vmlinux.lds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 54504013c749..61fa047023b5 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -588,10 +588,10 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 		*(.text.asan.* .text.tsan.*)				\
 		*(.text.unknown .text.unknown.*)			\
 		TEXT_SPLIT						\
-		TEXT_UNLIKELY						\
 		. = ALIGN(PAGE_SIZE);					\
 		TEXT_HOT						\
 		*(TEXT_MAIN .text.fixup)				\
+		TEXT_UNLIKELY						\
 		NOINSTR_TEXT						\
 		*(.ref.text)
 
-- 
2.39.5


