Return-Path: <linux-arch+bounces-3505-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC4289CC0C
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 20:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC982284E80
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 18:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F57314831F;
	Mon,  8 Apr 2024 18:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zi04pRXS"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59FA147C9F;
	Mon,  8 Apr 2024 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712602526; cv=none; b=Wz9aAbD+SP3V+pXvputaeh7y6/mpQa75p078tiickigOZO3pPO9zR7LNAYb3ftAh7jTt59NM/YrTBOktsBxtNAhrBW3V3UXNDIbHP2/2cIC3Gt0F04HQ5LxPAiT76wETzHLWfimrcD1095YZ4uQC0kksM71DJkd6DPQJOFSZxOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712602526; c=relaxed/simple;
	bh=6IP15GRrvoLWh+SkcnFaIq4Jq+IWeRLFF0e6voiaEoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEdOu78rp3pl7Ua5zJ7e4d4I5pm6USLFcQ7bivwBVlaQdNM8/JSNPkK/2IR1rVgo5ffIC013ahmg4AbwrM2Qt52Y2EDkQt3ROI9SVaXRY3s177U/ZHXCZT33UxJs2Nx/hPyGYAva43+EZxPIZh5Nr0yJyTKbgU9WeRo59BvaNlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zi04pRXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E37DC433A6;
	Mon,  8 Apr 2024 18:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712602526;
	bh=6IP15GRrvoLWh+SkcnFaIq4Jq+IWeRLFF0e6voiaEoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zi04pRXSNJM5LcEtZVPcOcxUMaCTLL4pxB6O4fqD6TkkJFEJxsd17dTOgXSYenG1u
	 dj/l8g51Dw5KXwcRxwP97wX+tXuq1O/EhkhelbctuW0dxvHmAEPnpK6vfykTfAbT6P
	 wv5ORA4MOYaRzLN550SCGqCBzUOTiAlh/o6r4fEa9wBmwCWrzrlFgKD+7OmDt2XouZ
	 yQ9jZ03/lnP3I/fpL54zNhlNbYIswSd95jrPso4lYBi3zZHKXkAya28RHIWT7ZWMrS
	 m31luBCIshtkxKdbrCjdCisRQjlnyvBnyyu1nI8F8L8+SFlJr94yg5Cul9nySQKHfM
	 KXFY8FFfsWlOA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arch@vger.kernel.org
Subject: [PATCH 8/9] tools/include: Sync asm-generic/bitops/fls.h with the kernel sources
Date: Mon,  8 Apr 2024 11:55:19 -0700
Message-ID: <20240408185520.1550865-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240408185520.1550865-1-namhyung@kernel.org>
References: <20240408185520.1550865-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up the changes from:

  cb4ede926134 ("riscv: Avoid code duplication with generic bitops implementation")

This should address these tools/perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/include/asm-generic/bitops/__fls.h include/asm-generic/bitops/__fls.h
    diff -u tools/include/asm-generic/bitops/fls.h include/asm-generic/bitops/fls.h

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/asm-generic/bitops/__fls.h | 8 ++++++--
 tools/include/asm-generic/bitops/fls.h   | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/include/asm-generic/bitops/__fls.h b/tools/include/asm-generic/bitops/__fls.h
index 03f721a8a2b1..54ccccf96e21 100644
--- a/tools/include/asm-generic/bitops/__fls.h
+++ b/tools/include/asm-generic/bitops/__fls.h
@@ -5,12 +5,12 @@
 #include <asm/types.h>
 
 /**
- * __fls - find last (most-significant) set bit in a long word
+ * generic___fls - find last (most-significant) set bit in a long word
  * @word: the word to search
  *
  * Undefined if no set bit exists, so code should check against 0 first.
  */
-static __always_inline unsigned long __fls(unsigned long word)
+static __always_inline unsigned long generic___fls(unsigned long word)
 {
 	int num = BITS_PER_LONG - 1;
 
@@ -41,4 +41,8 @@ static __always_inline unsigned long __fls(unsigned long word)
 	return num;
 }
 
+#ifndef __HAVE_ARCH___FLS
+#define __fls(word) generic___fls(word)
+#endif
+
 #endif /* _ASM_GENERIC_BITOPS___FLS_H_ */
diff --git a/tools/include/asm-generic/bitops/fls.h b/tools/include/asm-generic/bitops/fls.h
index b168bb10e1be..26f3ce1dd6e4 100644
--- a/tools/include/asm-generic/bitops/fls.h
+++ b/tools/include/asm-generic/bitops/fls.h
@@ -3,14 +3,14 @@
 #define _ASM_GENERIC_BITOPS_FLS_H_
 
 /**
- * fls - find last (most-significant) bit set
+ * generic_fls - find last (most-significant) bit set
  * @x: the word to search
  *
  * This is defined the same way as ffs.
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
 
-static __always_inline int fls(unsigned int x)
+static __always_inline int generic_fls(unsigned int x)
 {
 	int r = 32;
 
@@ -39,4 +39,8 @@ static __always_inline int fls(unsigned int x)
 	return r;
 }
 
+#ifndef __HAVE_ARCH_FLS
+#define fls(x) generic_fls(x)
+#endif
+
 #endif /* _ASM_GENERIC_BITOPS_FLS_H_ */
-- 
2.44.0.478.gd926399ef9-goog


