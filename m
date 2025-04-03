Return-Path: <linux-arch+bounces-11250-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E39EEA7B074
	for <lists+linux-arch@lfdr.de>; Thu,  3 Apr 2025 23:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7703AD045
	for <lists+linux-arch@lfdr.de>; Thu,  3 Apr 2025 21:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813D31FDA92;
	Thu,  3 Apr 2025 20:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="MIwNf3ea"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663CC1FDA69
	for <linux-arch@vger.kernel.org>; Thu,  3 Apr 2025 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743712486; cv=none; b=qW3dyk4O0rbZwW3cG60WSdPGTDG9xvRcqFqFa5cRaEyN7xknTjK0QN1q6U4OOKlp9Vzh9lfZWPaviDgTz16d/7G6wvy0e0pU0jV5VBXcZnjGlQHZbAnkkv9LudLgGbJ8cyjc6uusGQkRu6rRjjwdmF09CLAsTGL8rOWb9541qSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743712486; c=relaxed/simple;
	bh=acATyRUbnpdnRgGAcaAXJ3uINgKjESC2cn6Yqi7GuBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RKBUurLm3sU1CeD7Aa4vJGx1t9s//v1xU5ZGfYaWp3oywhMoQ0TmG47X8WZppKYYBULjo/wpZgXqrDaj19xwc8SKWDJN6TXuAAnsaIWErnecJHW6/FczgYC/C0rPNaeOm1G6vgN+S0i1wOJj93G7jN8vH5nrTA9geDNGxJzagpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=MIwNf3ea; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1743712482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uD5iR3j3WFLeggCmYAp0dLJAKr7cyaVudV3J9Ga4myY=;
	b=MIwNf3eaBPBrPG9omxufAUV6tnp5q3ry1N627DcdtUnMzfiH67FN+ZUm12lE2dQVJVcjiB
	bVZjU2tDudJbqxqc0ig1fsk1ti9GkNNbfEUmnqClXrVzOaOJz4JImFPCTJJ5WkBl968Bf1
	8QZScsUZwv/RnH+AELw1It1J4QmMxg5SBRqAEnw2YJATgdsSie8QNRXnB2SAxGKGeCdgZU
	MamUC6LihnbhVDyj1xCzw3rbsqExVOW1/u4kyMKzLyvQx08MVZhaTOnqONnt/kiQbAyrYq
	povq+FHVJouPcG32144mW5tOJKBiWbMzBL7Ex204tZIR77KFOlAYzLRjRTC46w==
From: Ignacio Encinas <ignacio@iencinas.com>
Date: Thu, 03 Apr 2025 22:34:18 +0200
Subject: [PATCH v3 2/2] riscv: introduce asm/swab.h
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-riscv-swab-v3-2-3bf705d80e33@iencinas.com>
References: <20250403-riscv-swab-v3-0-3bf705d80e33@iencinas.com>
In-Reply-To: <20250403-riscv-swab-v3-0-3bf705d80e33@iencinas.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
 skhan@linuxfoundation.org, Zhihang Shao <zhihang.shao.iscas@gmail.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 linux-arch@vger.kernel.org, Ignacio Encinas <ignacio@iencinas.com>
X-Migadu-Flow: FLOW_OUT

Implement endianness swap macros for RISC-V.

Use the rev8 instruction when Zbb is available. Otherwise, rely on the
default mask-and-shift implementation.

Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
---
 arch/riscv/include/asm/swab.h | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/riscv/include/asm/swab.h b/arch/riscv/include/asm/swab.h
new file mode 100644
index 000000000000..7352e8405a99
--- /dev/null
+++ b/arch/riscv/include/asm/swab.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_RISCV_SWAB_H
+#define _ASM_RISCV_SWAB_H
+
+#include <linux/types.h>
+#include <linux/compiler.h>
+#include <asm/cpufeature-macros.h>
+#include <asm/hwcap.h>
+#include <asm-generic/swab.h>
+
+#if defined(CONFIG_RISCV_ISA_ZBB) && !defined(NO_ALTERNATIVE)
+
+#define ARCH_SWAB(size) \
+static __always_inline unsigned long __arch_swab##size(__u##size value) \
+{									\
+	unsigned long x = value;					\
+									\
+	if (riscv_has_extension_likely(RISCV_ISA_EXT_ZBB)) {            \
+		asm volatile (".option push\n"				\
+			      ".option arch,+zbb\n"			\
+			      "rev8 %0, %1\n"				\
+			      ".option pop\n"				\
+			      : "=r" (x) : "r" (x));			\
+		return x >> (BITS_PER_LONG - size);			\
+	}                                                               \
+	return  ___constant_swab##size(value);				\
+}
+
+#ifdef CONFIG_64BIT
+ARCH_SWAB(64)
+#define __arch_swab64 __arch_swab64
+#endif
+
+ARCH_SWAB(32)
+#define __arch_swab32 __arch_swab32
+
+ARCH_SWAB(16)
+#define __arch_swab16 __arch_swab16
+
+#undef ARCH_SWAB
+
+#endif /* defined(CONFIG_RISCV_ISA_ZBB) && !defined(NO_ALTERNATIVE) */
+#endif /* _ASM_RISCV_SWAB_H */

-- 
2.49.0


