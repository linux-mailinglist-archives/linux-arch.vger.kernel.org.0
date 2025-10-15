Return-Path: <linux-arch+bounces-14111-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E935BDCB1A
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 08:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82C7519A662C
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 06:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D287530FC01;
	Wed, 15 Oct 2025 06:20:44 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECA430F956;
	Wed, 15 Oct 2025 06:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509242; cv=none; b=HsxSVF0yBRuyCxoG9O/vdpzVu/jmWNualHcHxsQpq/pVd8Nvb9f75ypIln5N2LC2Txl8wHi+p8v19JAisXjx0uCYVcBr6KJcMg4p5RToG2C8rmz+q3cG4+0UJ3DsfjzapQV1/yOePPaXA9UxqOL4F0nH8r+vA2BwPcwUet1UeRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509242; c=relaxed/simple;
	bh=mxpuMiUTRYCSgSeahpphZP0KRUV5gJ7/k69WdZ4eDk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DY9zQJSAu0A6NEKTFAuzeoJ6/rHLcy/io1PW8U2Fq062YUYGYzuqyfYRgy5JlmUrS3wsxPwUpXNHt6dzqqt3Ga+AlnyANs9oVr5qU/bze5mEXAsItLeOFexfz6RLPBCmmTEdZNJGwhfY2shO9CYUNxbOGUhJgfPGpY1pUUzwPIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org; spf=pass smtp.mailfrom=tinylab.org; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinylab.org
X-QQ-mid: zesmtpsz6t1760509173te78262a4
X-QQ-Originating-IP: u3H1w+MhVp5h6FxUuPEeE01YpOSGlM/XWUOC3g4qmu4=
Received: from GPU-Server-A6000.. ( [202.201.1.132])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 15 Oct 2025 14:19:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16704342638795234820
EX-QQ-RecipientCnt: 14
From: Yuan Tan <tanyuan@tinylab.org>
To: arnd@arndb.de,
	masahiroy@kernel.org,
	nathan@kernel.org,
	palmer@dabbelt.com,
	linux-kbuild@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	i@maskray.me,
	tanyuan@tinylab.org,
	falcon@tinylab.org,
	ronbogo@outlook.com,
	z1652074432@gmail.com,
	lx24@stu.ynu.edu.cn
Subject: [PATCH v2 6/8] compiler.h: introduce PUSHSECTION macro to establish proper references
Date: Wed, 15 Oct 2025 14:19:20 +0800
Message-ID: <40854460DE090346+c30007da67d26ae0e8651732f32a8ede4926db14.1760463245.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1760463245.git.tanyuan@tinylab.org>
References: <cover.1760463245.git.tanyuan@tinylab.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: OKKHiI6c9SH3NWplfEdQvnkgxVSivyXpkBuL/axxpl/Cw8vkJRWUxIg3
	HnJnLIJn1Vso5lCrTHERFND2Ac71fMqpoJpzhLKM/tNaKuz9NpD7d+rQiUljVR/GWuET1mt
	3UaqN9XgxVhmUHLpHSHiofcU3XjIq6Nn6vWFfy1qzYjjaeOyAFF9pfiH89nZqsThMYOVbU9
	7CnM9Hb+6zBiCgKSCVP1TFrkRdrMTt14fDfFevi4AVidq8HQ2A4lXjmJxrLF/61Nm+ckGC8
	TrsU+uN0N4V69Ib04ucUt5reAn4u+PWLGRozgAi339J1G5MNP+wxbFXW4K2b833OmXlqfcq
	x4Lv6Qr0W/J4QJjv6S6u4Uf9IANZOadhwGhvKOzdQo0a8fDotfumAoZSxmqSwksIlLZoNdy
	+YjDpNhmfwQUaMbjrPRXYlTO7VX7MnpMO+XOXg/Lr/sNVJNIDs4Jk5xWgP4PaFh3ruFaitm
	wTOkiK0RuFStXCkuIo1NuAFyV0CSXSnymAqZ1skVLsV6xgc2YlecQQJRgB6dqCqai5oCvnG
	hLN+7v/MQQBkK+V99Fadrk4q4EmlFAGRzg77qfWvPQp9ge76QSOU+lZtayzdrzEwhuAo18d
	CpnHzOXv28z2tvxOGOFpamFQvswm3VWfgUuZP0FGZCKKYk4jBFQEJ0xhlh1bCPK8dgDfdv6
	L8w3Qz2G+tzK0P/54t7VG9Ji7/harpqcwFlsLCrjCEPbzasbHewR4na9964hter6LwgGyIX
	zHm4rQYD7msdNncbis1usBYIoVM7M9+jH83trUe28Q3Wv5R0CllhAOjj8NpWE1fChhSKSGM
	SsTzIpLxA9CC6dDgRHG2boniS2d+cF1S3pyM9f8wE9GdqHOV+hwV5bP4D+vJHWUUYwfSNUP
	fTESbxrygLNfIYLVYpNw7L4nTUI6+KQJTQ0JXmn1NVlCWrtZFH409SWmS9qmWYzf34ROfLF
	VpGy6tXpOTbZxTouwQ1+OHlK4j2Ht0hIi4XP1eMqKC3hH9+2kBEtdKEZYxKK3SaMqpmIhEU
	lIUpqE+2TRFGcZvDMO
X-QQ-XMRINFO: OJlEh3abS6gXi5NWrXbD0WI=
X-QQ-RECHKSPAM: 0

When a section is created by .pushsection in assembly, there is no
reference between the caller function and the newly created section. As a
result, --gc-sections may incorrectly discard the newly created section.

To prevent such incorrect garbage collection, kernel code often wraps these
sections with KEEP() in linker scripts. While this guarantees that the
sections are retained, it introduces a dependency inversion: unused
sections are kept unnecessarily, and any sections they reference are also
forcibly retained. This prevents the linker from eliminating truly unused
code or data.

Introduce a new PUSHSECTION macro in include/linux/compiler.h to create a
proper reference between the .pushsection caller and the generated section.
The macro is fully compatible with all existing .pushsection parameters and
has no side effects, making it safe to replace all current .pushsection
usages with this version.

PUSHSECTION works by emitting a unique label inside the new section, and
adding a relocation from the caller function to that label. This ensures
the linker recognizes the dependency and keeps both sections alive
together. So we don't need to wrap the section with KEEP() in linker
anymore.

To guarantee uniqueness of the section and label names, both __COUNTER__
and %= are used:
Either alone is insufficient:
  - __COUNTER__ alone fails when the function containing PUSHSECTION is
    inlined multiple times, causing duplicate labels.
  - %= alone fails when multiple PUSHSECTION directives appear within a
    single inline assembly block.

In assembly code, a separate definition is provided because the C macro
cannot ensure unique section/label names when expanded inside an assembler
macro (.macro).

Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
Signed-off-by: Xiao Liu <lx24@stu.ynu.edu.cn>
Signed-off-by: Peihan Liu <ronbogo@outlook.com>
---
 include/linux/compiler.h | 43 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 5b45ea7dff3e..bba79cedbe24 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -3,6 +3,7 @@
 #define __LINUX_COMPILER_H
 
 #include <linux/compiler_types.h>
+#include <linux/stringify.h>
 
 #ifndef __ASSEMBLY__
 
@@ -267,7 +268,47 @@ static inline void *offset_to_ptr(const int *off)
 	return (void *)((unsigned long)off + *off);
 }
 
-#endif /* __ASSEMBLY__ */
+#ifdef CONFIG_PUSHSECTION_WITH_RELOC
+#define __PUSHSECTION_RELOC(lbl) ".reloc ., BFD_RELOC_NONE, " lbl "\n\t"
+#define __PUSHSECTION_HELPER(prefix) __stringify(prefix.%=) "_" __stringify(__COUNTER__)
+#define __PUSHSECTION_LABEL(lbl) lbl ":\n\t"
+#else
+#define __PUSHSECTION_RELOC(lbl)
+#define __PUSHSECTION_HELPER(prefix) __stringify(prefix)
+#define __PUSHSECTION_LABEL(lbl)
+#endif
+
+#define _PUSHSECTION(lbl, sec, ...)					\
+	__PUSHSECTION_RELOC(lbl)					\
+	".pushsection " sec ", " #__VA_ARGS__ "\n\t" __PUSHSECTION_LABEL(lbl)
+
+#define PUSHSECTION(sec, ...)						\
+	_PUSHSECTION(__PUSHSECTION_HELPER(.Lsec), __PUSHSECTION_HELPER(sec), __VA_ARGS__)
+
+#else /* __ASSEMBLY__ */
+
+#ifdef CONFIG_PUSHSECTION_WITH_RELOC
+#define __PUSHSECTION_RELOC .reloc ., BFD_RELOC_NONE, \label
+#define __PUSHSECTION_HELPER(prefix) prefix\().\@
+#define __PUSHSECTION_LABEL \label:
+#else
+#define __PUSHSECTION_RELOC
+#define __PUSHSECTION_HELPER(prefix) prefix
+#define __PUSHSECTION_LABEL
+#endif
+
+.macro  _PUSHSECTION label:req, section:req, args:vararg
+	__PUSHSECTION_RELOC
+	.pushsection __PUSHSECTION_HELPER(\section), \args
+	__PUSHSECTION_LABEL
+.endm
+
+.macro  PUSHSECTION section:req, args:vararg
+	_PUSHSECTION .Lsec\@, \section, \args
+.endm
+
+#endif /* !__ASSEMBLY__ */
+
 
 #ifdef CONFIG_64BIT
 #define ARCH_SEL(a,b) a
-- 
2.43.0


