Return-Path: <linux-arch+bounces-6287-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11023955B5D
	for <lists+linux-arch@lfdr.de>; Sun, 18 Aug 2024 08:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92F321F21AD4
	for <lists+linux-arch@lfdr.de>; Sun, 18 Aug 2024 06:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1A414F90;
	Sun, 18 Aug 2024 06:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yaRqC3H6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A55014A90
	for <linux-arch@vger.kernel.org>; Sun, 18 Aug 2024 06:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723963006; cv=none; b=G7CKPYGTNLKNdorekW1orxEYY1fWnBCRR8NPslQGGlGQkPGtmQ5EwxVuS0nDYDseBS9b6+3Sdnf9eyUb+0TkPUupHtyCl93l3JBnRgkxeZvvK2GGpwazXCuVGez7o3g/mlxQ+2yq2Y1ht1qsyecRBgwG51hD/kcqbUjhAVR2g4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723963006; c=relaxed/simple;
	bh=3vAJDoEpGiFg4mI/K3dJV6TDhU2SVBU3QlsfeYAyaSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SRx8VkhwDtraCQ4jU1QAs7qnLtFrfzMCCD9vUFmOPFkr7BEaU6E67o5FNNdkpAPpXfHPxTf9rcVY1K/rfYDEagUt6aWQzQmWOd9RWNqqFVz3B2zvDotK35vlUMCQmpTnOTZQK60PV+18E0X0KGHGqga8soXCt1bK21aK575qt/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=yaRqC3H6; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3718706cf8aso2064559f8f.3
        for <linux-arch@vger.kernel.org>; Sat, 17 Aug 2024 23:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723963003; x=1724567803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ll6PO6fq7jekV3yT3oRS1DwKakMdlEGxiDtEOFhGbwU=;
        b=yaRqC3H6BddAUcVAIIm5XKgPrKVM6Es6Rh9hwBvijOgOJ5DgscQDmRSs6NYazp1wxV
         5Txwp9nUhJpjIB2tFbMGj7lxchQ23HnDXoUNKNeYK57HtXTLUBrfeNrFKYscD2eFTyzB
         GCczJoK1HEFxtiJ3byYGW/Hm0BbL4O0tczOs15r6QYwQi5X1NS6xcd2C4PYgoqT4dXg5
         2P8DVlQ80pygGY8vMSYPv9w91DenJottsjPuWbHhBbu9CkoNQJtLhngonhwiTcfYy5eG
         vRDHc+eLSXbSFQ8AgUg0I8XIXYxs0U9CoMnMJBCh8tTs7oTATS+hWBdmM2pUxGWhKcQ0
         nglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723963003; x=1724567803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ll6PO6fq7jekV3yT3oRS1DwKakMdlEGxiDtEOFhGbwU=;
        b=lRV80xjY7o65vPwCQtUQeDW09yIuein8pRc/JqvkHPbQ5G45mEIDf2I04pUf2WdpCq
         HCetqpd2d8zAHduQrYfeW2Lbnv5JAm72ekIrDNH7mCyJ+onG8f3Z++2ftFDI4EWJSr5b
         WoT38WT9XDjuuVztsUuyb/aZQSmT+ntazO5tuSh1spYupnIpv8pMSwIxpZlaAwb0NIhp
         NPhf5j93+/DUvUzdL1AFyMVnV/q8RuF8AgXe4Cv+Vwn3163Mul60m2IWuOx6+H7+dQ4M
         v/0h++UcdJOkfUb7OZe3ZDRA7y76pnjoz6Ifhx+/c7IqgJ6Qs5AmLgHINHK8I87Zv/6l
         7tzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQbQ0/TgT9LXCNXSW9dIvouil4XJwaW8rDW9fSBIX7nN2FwwRNKac24PLklHFt0OvzVx3jUF1BJWVmhNCwlPbf3jVA0G0h/AybXw==
X-Gm-Message-State: AOJu0YzMaVOjDwBSu7mnTHMLdMWXLtCEZwIqTejJpgat9gPze3QE5gTc
	FF9iCPk0eOPRRBRWsPYwFz/Sg3ijrJkZU4gr3sw+tnmCfPid4jS2U+KQtupluN8=
X-Google-Smtp-Source: AGHT+IEMupb/eaKm5/+VPG7gQL1BT1ElhtPyyJ9e/FdDd2FVBOCIDCIy/gU0Zn16LvTEMnl2YJ5n3Q==
X-Received: by 2002:a5d:4148:0:b0:368:5ba0:622 with SMTP id ffacd0b85a97d-371946a4203mr4585432f8f.44.1723963002780;
        Sat, 17 Aug 2024 23:36:42 -0700 (PDT)
Received: from alex-rivos.guest.squarehotel.net ([130.93.157.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189896de9sm7251293f8f.75.2024.08.17.23.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 23:36:42 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v5 01/13] riscv: Move cpufeature.h macros into their own header
Date: Sun, 18 Aug 2024 08:35:26 +0200
Message-Id: <20240818063538.6651-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240818063538.6651-1-alexghiti@rivosinc.com>
References: <20240818063538.6651-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

asm/cmpxchg.h will soon need riscv_has_extension_unlikely() macros and
then needs to include asm/cpufeature.h which introduces a lot of header
circular dependencies.

So move the riscv_has_extension_XXX() macros into their own header which
prevents such circular dependencies by including a restricted number of
headers.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/cpufeature-macros.h | 66 ++++++++++++++++++++++
 arch/riscv/include/asm/cpufeature.h        | 61 ++------------------
 2 files changed, 70 insertions(+), 57 deletions(-)
 create mode 100644 arch/riscv/include/asm/cpufeature-macros.h

diff --git a/arch/riscv/include/asm/cpufeature-macros.h b/arch/riscv/include/asm/cpufeature-macros.h
new file mode 100644
index 000000000000..a8103edbf51f
--- /dev/null
+++ b/arch/riscv/include/asm/cpufeature-macros.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2022-2024 Rivos, Inc
+ */
+
+#ifndef _ASM_CPUFEATURE_MACROS_H
+#define _ASM_CPUFEATURE_MACROS_H
+
+#include <asm/hwcap.h>
+#include <asm/alternative-macros.h>
+
+#define STANDARD_EXT		0
+
+bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, unsigned int bit);
+#define riscv_isa_extension_available(isa_bitmap, ext)	\
+	__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_##ext)
+
+static __always_inline bool __riscv_has_extension_likely(const unsigned long vendor,
+							 const unsigned long ext)
+{
+	asm goto(ALTERNATIVE("j	%l[l_no]", "nop", %[vendor], %[ext], 1)
+	:
+	: [vendor] "i" (vendor), [ext] "i" (ext)
+	:
+	: l_no);
+
+	return true;
+l_no:
+	return false;
+}
+
+static __always_inline bool __riscv_has_extension_unlikely(const unsigned long vendor,
+							   const unsigned long ext)
+{
+	asm goto(ALTERNATIVE("nop", "j	%l[l_yes]", %[vendor], %[ext], 1)
+	:
+	: [vendor] "i" (vendor), [ext] "i" (ext)
+	:
+	: l_yes);
+
+	return false;
+l_yes:
+	return true;
+}
+
+static __always_inline bool riscv_has_extension_unlikely(const unsigned long ext)
+{
+	compiletime_assert(ext < RISCV_ISA_EXT_MAX, "ext must be < RISCV_ISA_EXT_MAX");
+
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
+		return __riscv_has_extension_unlikely(STANDARD_EXT, ext);
+
+	return __riscv_isa_extension_available(NULL, ext);
+}
+
+static __always_inline bool riscv_has_extension_likely(const unsigned long ext)
+{
+	compiletime_assert(ext < RISCV_ISA_EXT_MAX, "ext must be < RISCV_ISA_EXT_MAX");
+
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
+		return __riscv_has_extension_likely(STANDARD_EXT, ext);
+
+	return __riscv_isa_extension_available(NULL, ext);
+}
+
+#endif /* _ASM_CPUFEATURE_MACROS_H */
diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 45f9c1171a48..87ed88fc950d 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -8,9 +8,11 @@
 
 #include <linux/bitmap.h>
 #include <linux/jump_label.h>
+#include <linux/kconfig.h>
+#include <linux/percpu-defs.h>
+#include <linux/threads.h>
 #include <asm/hwcap.h>
-#include <asm/alternative-macros.h>
-#include <asm/errno.h>
+#include <asm/cpufeature-macros.h>
 
 /*
  * These are probed via a device_initcall(), via either the SBI or directly
@@ -103,61 +105,6 @@ extern const size_t riscv_isa_ext_count;
 extern bool riscv_isa_fallback;
 
 unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap);
-
-#define STANDARD_EXT		0
-
-bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, unsigned int bit);
-#define riscv_isa_extension_available(isa_bitmap, ext)	\
-	__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_##ext)
-
-static __always_inline bool __riscv_has_extension_likely(const unsigned long vendor,
-							 const unsigned long ext)
-{
-	asm goto(ALTERNATIVE("j	%l[l_no]", "nop", %[vendor], %[ext], 1)
-	:
-	: [vendor] "i" (vendor), [ext] "i" (ext)
-	:
-	: l_no);
-
-	return true;
-l_no:
-	return false;
-}
-
-static __always_inline bool __riscv_has_extension_unlikely(const unsigned long vendor,
-							   const unsigned long ext)
-{
-	asm goto(ALTERNATIVE("nop", "j	%l[l_yes]", %[vendor], %[ext], 1)
-	:
-	: [vendor] "i" (vendor), [ext] "i" (ext)
-	:
-	: l_yes);
-
-	return false;
-l_yes:
-	return true;
-}
-
-static __always_inline bool riscv_has_extension_unlikely(const unsigned long ext)
-{
-	compiletime_assert(ext < RISCV_ISA_EXT_MAX, "ext must be < RISCV_ISA_EXT_MAX");
-
-	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
-		return __riscv_has_extension_unlikely(STANDARD_EXT, ext);
-
-	return __riscv_isa_extension_available(NULL, ext);
-}
-
-static __always_inline bool riscv_has_extension_likely(const unsigned long ext)
-{
-	compiletime_assert(ext < RISCV_ISA_EXT_MAX, "ext must be < RISCV_ISA_EXT_MAX");
-
-	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
-		return __riscv_has_extension_likely(STANDARD_EXT, ext);
-
-	return __riscv_isa_extension_available(NULL, ext);
-}
-
 static __always_inline bool riscv_cpu_has_extension_likely(int cpu, const unsigned long ext)
 {
 	compiletime_assert(ext < RISCV_ISA_EXT_MAX, "ext must be < RISCV_ISA_EXT_MAX");
-- 
2.39.2


