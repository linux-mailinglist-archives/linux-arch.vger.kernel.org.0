Return-Path: <linux-arch+bounces-9239-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB679E1215
	for <lists+linux-arch@lfdr.de>; Tue,  3 Dec 2024 04:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C404163EFF
	for <lists+linux-arch@lfdr.de>; Tue,  3 Dec 2024 03:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E171917E8;
	Tue,  3 Dec 2024 03:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwGT1t3X"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8571418FDAB;
	Tue,  3 Dec 2024 03:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733198036; cv=none; b=Xg4H30S67VUmMaJqBKhQPPjDlZqqSvarxTGPAUWxtax0KD4TO69BhEtNkozrYaBoGwuhIHOA801Vs9vgLPL2ksXEj9dAIrjGD5RCLlOQ+ZRvad0ev6kd5aKxOo1zEzYPdZXgOCf4oAvprVS72Zx8/x4bVksH1QU9yiQkXgHG+F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733198036; c=relaxed/simple;
	bh=G+rSWpFpxVDRx1f4GGYkCBIkGN3M0enVpJhyMLotu/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAllX76Pykpr1uz2fh7PP+VcEJTYlzr7unfwSwUUmN8y9FL37FSV/RdLD3J2JHLiad0PvEU1iHcYy0j8x1fnJqT+gkTjVxPqanPytMeh6/Ag7ACp1JTBn/2evwyK0hAqpJiu9VcKPSyN71TJRwPmKFtm8Q9+BSEPQyxCpAAKx5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwGT1t3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E5BC4CEE3;
	Tue,  3 Dec 2024 03:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733198036;
	bh=G+rSWpFpxVDRx1f4GGYkCBIkGN3M0enVpJhyMLotu/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YwGT1t3XgGeSa8SvRzpCBWMb8M3lzPIhdtjbedF/PVilea3xorqu36NYxzDXttTkO
	 graCMFAjkC3lM95CvsRW7ErZdjxgWXuLGTxoSK0rMY3odlgvdxcoFMM4gKBt8aEiKj
	 Xa2ADYw766pRRYKRJUNNyWi19nA8+4SEfLj7FFVruvphBZCyvYYEb+dmndUuELLPyj
	 b5VAZq4IYH3aZxcx52dCqAJRK8riXDs5nHRFPUSq2+ryZohPUgi2mh7ONCMzGgs6eS
	 mhcg0/A6w/gubWap/XU2/CNLSNUW2VtmMIf/hl/NQcxdLFL3T+BpIMs9bk55LvOHbe
	 aorm8rxMxKSeg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arch@vger.kernel.org
Subject: [PATCH 07/11] tools headers: Sync uapi/asm-generic/mman.h with the kernel sources
Date: Mon,  2 Dec 2024 19:53:45 -0800
Message-ID: <20241203035349.1901262-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241203035349.1901262-1-namhyung@kernel.org>
References: <20241203035349.1901262-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up the changes in this cset:

  3630e82ab6bd2642 ("mman: Add map_shadow_stack() flags")

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/asm-generic/mman.h include/uapi/asm-generic/mman.h

Please see tools/include/uapi/README for further details.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/asm-generic/mman.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/uapi/asm-generic/mman.h b/tools/include/uapi/asm-generic/mman.h
index 406f7718f9ad074f..51d2556af54ac721 100644
--- a/tools/include/uapi/asm-generic/mman.h
+++ b/tools/include/uapi/asm-generic/mman.h
@@ -19,4 +19,8 @@
 #define MCL_FUTURE	2		/* lock all future mappings */
 #define MCL_ONFAULT	4		/* lock all pages that are faulted in */
 
+#define SHADOW_STACK_SET_TOKEN (1ULL << 0)     /* Set up a restore token in the shadow stack */
+#define SHADOW_STACK_SET_MARKER (1ULL << 1)     /* Set up a top of stack marker in the shadow stack */
+
+
 #endif /* __ASM_GENERIC_MMAN_H */
-- 
2.47.0.338.g60cca15819-goog


