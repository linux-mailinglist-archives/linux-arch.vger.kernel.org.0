Return-Path: <linux-arch+bounces-4193-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1615A8BC167
	for <lists+linux-arch@lfdr.de>; Sun,  5 May 2024 16:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54A5281CD3
	for <lists+linux-arch@lfdr.de>; Sun,  5 May 2024 14:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E784E78C8F;
	Sun,  5 May 2024 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8RBPZLa"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DF93839C;
	Sun,  5 May 2024 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714919386; cv=none; b=K3JGyDoeQCQ7n7UJKVDjmPwIYAYIzxMlmQKKxYRDsJ/ohY0WhiCxoqhsUGubDEK69FCGieUmjYlzxUeRl+3Obn++izBubKV1tep/wunamKgFAfy9XVLE7/jxkLkqGx3o+n9fN3fHjLZc6FS3tOgWdLQBwRccho8jF/GcerD2CeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714919386; c=relaxed/simple;
	bh=jltW+mxex+RltLVmEvdEIXvbtM9OL57nIYiRLA2L7XA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUxgHD1PwnHSVOsVIDXMFCWoV7VaNfmYCv2xrQtOI3EQB33kkzk+FzTz8SFZYHNaLRCdQcjnGHbZRUE6swtJKKvLCoiwN7suSR4A7JSgoAs8RDnC3foaCBT52XpruNb/xBU0q3XVPhMw/VVGpnvasy1/RVP+y54IAJ+ZW2eZCZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8RBPZLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF5DC4AF67;
	Sun,  5 May 2024 14:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714919386;
	bh=jltW+mxex+RltLVmEvdEIXvbtM9OL57nIYiRLA2L7XA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k8RBPZLaWniIrQ3iX1xRzq7LYGRguu4TjAeVU5ImeurmYjKnTMgH7LC1fVS/xPaWG
	 Ei1rxYohyvJ4MvBnrpxNLXXdhHkPuqcjyx1mPgPPT/hmr8EU7DlkiqiMBUgBBwiRfO
	 YGJqd/rv6So6su7wmo1rrAUGVmw+z+TWjSnUQQrxzllurDPeBLUKNx5WhjcSc8GE9+
	 7C5MxR9hNoqJ51TJU+A6sQLEM7Xeu44i9pZBrgUQwNnBdrtHeh9Wv9jfIuM27SN/xQ
	 0BXXwSLIKlwsoHlL6lW14hzPaBfJMAG5xJSM5Uo7xDZ+JvAqnIMimG/VkxiafIgGD6
	 3QLqoThL3dX5Q==
From: Mike Rapoport <rppt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Liviu Dudau <liviu@dudau.co.uk>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Nadav Amit <nadav.amit@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	Sam Ravnborg <sam@ravnborg.org>,
	Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	netdev@vger.kernel.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v8 17/17] fixup: convert remaining archs: defaults handling
Date: Sun,  5 May 2024 17:26:00 +0300
Message-ID: <20240505142600.2322517-18-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240505142600.2322517-1-rppt@kernel.org>
References: <20240505142600.2322517-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 mm/execmem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/execmem.c b/mm/execmem.c
index f6dc3fabc1ca..0c4b36bc6d10 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -118,7 +118,6 @@ static void __init __execmem_init(void)
 		info->ranges[EXECMEM_DEFAULT].end = VMALLOC_END;
 		info->ranges[EXECMEM_DEFAULT].pgprot = PAGE_KERNEL_EXEC;
 		info->ranges[EXECMEM_DEFAULT].alignment = 1;
-		return;
 	}
 
 	if (!execmem_validate(info))
-- 
2.43.0


