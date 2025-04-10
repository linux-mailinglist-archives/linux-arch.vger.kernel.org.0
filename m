Return-Path: <linux-arch+bounces-11367-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0F3A834FC
	for <lists+linux-arch@lfdr.de>; Thu, 10 Apr 2025 02:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28DBC467788
	for <lists+linux-arch@lfdr.de>; Thu, 10 Apr 2025 00:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14D1155A4E;
	Thu, 10 Apr 2025 00:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSROBZdD"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EB6154BE2;
	Thu, 10 Apr 2025 00:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744243891; cv=none; b=YCjLPxCpR3s8uALkYl/tjm0vRK0hgEA2GHHeOdHG0ZcLZbiWnLAFvMbWQlgXLz9ze9U+/tniKla1stFTqSz0X1p7bCB2I2dimone8USvc7h9RBPRfI1d2GtsqecAGa+FXehkq5qnla2WbfjblFRlGzS6fOh4R3s6lJi7+3tbQ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744243891; c=relaxed/simple;
	bh=NNatGCeqYrE074to5dbGsLRZybeGe7nqOuNLtoyoWoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2cebiBWd7uyAp26bRCZYb9MmkgI2+7TA/iMrxnjkDIbSFIAEczNXWQss+nsV8EE+2+aYzTaYvHxA7ezFBteCqYVcO7x9iblOJM52oc37v6X+3WhW3Ajt+yRQbuSr/fNffCY/jBeTeirHoC16UDduVnJCJ+CGL6Eh9hp/JxzBEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSROBZdD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931CCC4CEE9;
	Thu, 10 Apr 2025 00:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744243891;
	bh=NNatGCeqYrE074to5dbGsLRZybeGe7nqOuNLtoyoWoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BSROBZdDdz1rfjlqTJVC1jxYlIQaGdMjtzs/1suwOLTOSSX+/nrpCafn4Stxt29Ru
	 5kp3VCEe1FhkVb5voMR1ktfaN3JcQNI0ED1n6fNlDYQInXWn9KOUAJ6KQJE+HaHXn1
	 nHlOuQK+r2xzf8yQduNUGIiLVYdXiABoT3wGFAiDE90xDmP1kfm9n+FCAGFjOziDp/
	 b7EY+aHXrKsB3aMV/qj5sLNbxA39I/qwy0efGEd+62ojj3G4dBbyM32s8bHx2lKwHO
	 bG0OhL1t/GrPmJbdP7p5faGkLttqCUxa8x8o2U/7g25g9vmlBDqoUnK0N8srVp0qaH
	 j3UIxTysRSheA==
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
	linux-arch@vger.kernel.org
Subject: [PATCH 07/10] tools headers: Update the uapi/asm-generic/mman-common.h copy with the kernel sources
Date: Wed,  9 Apr 2025 17:11:22 -0700
Message-ID: <20250410001125.391820-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
In-Reply-To: <20250410001125.391820-1-namhyung@kernel.org>
References: <20250410001125.391820-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up the changes in:

   6d61527d931ba07b mm/pkey: Add PKEY_UNRESTRICTED macro

Addressing this perf tools build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/asm-generic/mman-common.h include/uapi/asm-generic/mman-common.h

Please see tools/include/uapi/README for further details.

Cc: linux-arch@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/asm-generic/mman-common.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/include/uapi/asm-generic/mman-common.h
index 1ea2c4c33b86a263..ef1c27fa3c570fa4 100644
--- a/tools/include/uapi/asm-generic/mman-common.h
+++ b/tools/include/uapi/asm-generic/mman-common.h
@@ -85,6 +85,7 @@
 /* compatibility flags */
 #define MAP_FILE	0
 
+#define PKEY_UNRESTRICTED	0x0
 #define PKEY_DISABLE_ACCESS	0x1
 #define PKEY_DISABLE_WRITE	0x2
 #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
-- 
2.49.0.504.g3bcea36a83-goog


