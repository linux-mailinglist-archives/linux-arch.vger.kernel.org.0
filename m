Return-Path: <linux-arch+bounces-1534-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3FF83B9A6
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 07:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59924B21F83
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 06:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C5F12E40;
	Thu, 25 Jan 2024 06:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="T5viQhnF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1C512E46
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 06:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164129; cv=none; b=nU+glYP23aBZPy3rQr4UviSn33IcgmU1+zFPKiEQ1XPW6h5H4wHBHRvLl3Ptn4w47ZFcnV6fo6Cga4tXRQ55d6mKjwt9C/KU+5u1IJYVQIHLL1TaIZ0pJ/eVGJ8y7ZbPFWTKTFth0Yz3l6d4/1wGxe2qyX8RqyWLp00H/ZzIgRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164129; c=relaxed/simple;
	bh=5IIzPP0RItrtggjbTzPQCLuAoBzRra5iE382y3BQm5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=to6lgKYUT7gxiinTO+bnYoV9xH9AfHxFK+ebjzVaYfjN3aNCzKbkEWu80IgFP4I/XdIBaDCRY/yXQeuCjF+6umzyvXcdmd0ajy+/eC1Onze81E2gPwz6eW4yEYmDo3IoMi2BEh2Rl/gH6aU611HNA9HGBHVsoCvQg1/hKzoZjQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=T5viQhnF; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ddc1b30458so1123301b3a.1
        for <linux-arch@vger.kernel.org>; Wed, 24 Jan 2024 22:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706164127; x=1706768927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAejTXU0ubiQ5glx+ACfMnILZ3BSyMGr/22gR94zPLU=;
        b=T5viQhnFGDyyoxUR2/AZJoMcQq40nvirqempLroRZaSbGb5ZkzBcoaMySPY12FI0xk
         W14m3k2xyaAX+xBHMSVMED42S8yfZsvyGsirKa00j2G4PTybJgoeg02BC83hCnzJawbS
         Z5YvysVsuRaHKr/ckfTMpVfhmMcGr+GmbX6jGgcNWr+ItD6X5+awGKNAOOo9tV3JiMlI
         QSpMO3oht3dXSNxQggTp1C66oqBywbSdTa0r0JmEDFZGfXaw8Q7jYnKbPYlAn2VHHgqu
         RThP6tMKwZW1xnZ1yW6xBuBc/BkuHX1MZVnO9L+f20WxRggy9Q/jLAs0nH3UMnkiPp8b
         fDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706164127; x=1706768927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAejTXU0ubiQ5glx+ACfMnILZ3BSyMGr/22gR94zPLU=;
        b=bZnYysWkZ29GvyeVgyS5fgFVlt2UBDdkknIa5r/QkjXLm+RkJDW/LcTxmmLmt4bHTA
         f0wzGlY0J2emfzYTnpUcQTDKDodK44/RBP91rYeeigwOF3quHqVgbKRv+m1cjxQ7XKpC
         +Z5w7gA5mCh97XhB1G5oaPGUWaM8xYdRYYVjVGObUhT9+sfIb0T61VYJcSbDAaJlAw3k
         Q3NTZ7B7qvVHf94tfni+mdiASLffVELyCT6zCO2RQDdsBvPl5A0VqV15pYOKQfLIaHit
         sXdwuCHkPxaj0tRBYc7JChVYEGrbx0Dt9dc4cXcL0WV+bHtQx4qvNWg+8u0HgSNCFi/t
         aztA==
X-Gm-Message-State: AOJu0Yxynabz14d0LccJnHiZSd+rs6EdBCIXL5/pWEGAiltruE99N/w1
	ipqMn9qpSWhwkT4HDsfc5FXbxfCRdunYPmDwKplzUkp1BWF0ErBBkRG01VLLc14=
X-Google-Smtp-Source: AGHT+IFqFfG67XTDjoNiouy/3B041dutuvZL3hrVwMOIb2sdzt40BlsHHzBmvSINS1AroXPOL+Y8dw==
X-Received: by 2002:a05:6a20:1447:b0:19a:2e13:667a with SMTP id a7-20020a056a20144700b0019a2e13667amr750598pzi.5.1706164127531;
        Wed, 24 Jan 2024 22:28:47 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a00139300b006dd870b51b8sm3201139pfg.126.2024.01.24.22.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 22:28:47 -0800 (PST)
From: debug@rivosinc.com
To: rick.p.edgecombe@intel.com,
	broonie@kernel.org,
	Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com,
	keescook@chromium.org,
	ajones@ventanamicro.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	atishp@atishpatra.org,
	alex@ghiti.fr,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com
Cc: corbet@lwn.net,
	aou@eecs.berkeley.edu,
	oleg@redhat.com,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	shuah@kernel.org,
	brauner@kernel.org,
	debug@rivosinc.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	evan@rivosinc.com,
	xiao.w.wang@intel.com,
	apatel@ventanamicro.com,
	mchitale@ventanamicro.com,
	waylingii@gmail.com,
	greentime.hu@sifive.com,
	heiko@sntech.de,
	jszhang@kernel.org,
	shikemeng@huaweicloud.com,
	david@redhat.com,
	charlie@rivosinc.com,
	panqinglin2020@iscas.ac.cn,
	willy@infradead.org,
	vincent.chen@sifive.com,
	andy.chiu@sifive.com,
	gerg@kernel.org,
	jeeheng.sia@starfivetech.com,
	mason.huo@starfivetech.com,
	ancientmodern4@gmail.com,
	mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com,
	bhe@redhat.com,
	chenjiahao16@huawei.com,
	ruscur@russell.cc,
	bgray@linux.ibm.com,
	alx@kernel.org,
	baruch@tkos.co.il,
	zhangqing@loongson.cn,
	catalin.marinas@arm.com,
	revest@chromium.org,
	josh@joshtriplett.org,
	joey.gouly@arm.com,
	shr@devkernel.io,
	omosnace@redhat.com,
	ojeda@kernel.org,
	jhubbard@nvidia.com,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v1 05/28] riscv: zicfiss/zicfilp enumeration
Date: Wed, 24 Jan 2024 22:21:30 -0800
Message-ID: <20240125062739.1339782-6-debug@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125062739.1339782-1-debug@rivosinc.com>
References: <20240125062739.1339782-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Deepak Gupta <debug@rivosinc.com>

This patch adds support for detecting zicfiss and zicfilp. zicfiss and zicfilp
stands for unprivleged integer spec extension for shadow stack and branch
tracking on indirect branches, respectively.

This patch looks for zicfiss and zicfilp in device tree and accordinlgy lights
up bit in cpu feature bitmap. Furthermore this patch adds detection utility
functions to return whether shadow stack or landing pads are supported by
cpu.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h | 18 ++++++++++++++++++
 arch/riscv/include/asm/hwcap.h      |  2 ++
 arch/riscv/include/asm/processor.h  |  1 +
 arch/riscv/kernel/cpufeature.c      |  2 ++
 4 files changed, 23 insertions(+)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index a418c3112cd6..216190731c55 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -133,4 +133,22 @@ static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsi
 	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
 }
 
+static inline bool cpu_supports_shadow_stack(void)
+{
+#ifdef CONFIG_RISCV_USER_CFI
+	return riscv_isa_extension_available(NULL, ZICFISS);
+#else
+	return false;
+#endif
+}
+
+static inline bool cpu_supports_indirect_br_lp_instr(void)
+{
+#ifdef CONFIG_RISCV_USER_CFI
+	return riscv_isa_extension_available(NULL, ZICFILP);
+#else
+	return false;
+#endif
+}
+
 #endif
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 06d30526ef3b..918165cfb4fa 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -57,6 +57,8 @@
 #define RISCV_ISA_EXT_ZIHPM		42
 #define RISCV_ISA_EXT_SMSTATEEN		43
 #define RISCV_ISA_EXT_ZICOND		44
+#define RISCV_ISA_EXT_ZICFISS	45
+#define RISCV_ISA_EXT_ZICFILP	46
 
 #define RISCV_ISA_EXT_MAX		64
 
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index f19f861cda54..ee2f51787ff8 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -13,6 +13,7 @@
 #include <vdso/processor.h>
 
 #include <asm/ptrace.h>
+#include <asm/hwcap.h>
 
 #ifdef CONFIG_64BIT
 #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 98623393fd1f..16624bc9a46b 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -185,6 +185,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
 	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
 	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
+	__RISCV_ISA_EXT_DATA(zicfiss, RISCV_ISA_EXT_ZICFISS),
+	__RISCV_ISA_EXT_DATA(zicfilp, RISCV_ISA_EXT_ZICFILP),
 };
 
 const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
-- 
2.43.0


