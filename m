Return-Path: <linux-arch+bounces-3283-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FF4891285
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 05:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DBBCB21CE9
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 04:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287BF3BBCF;
	Fri, 29 Mar 2024 04:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="zrtb8xXv"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B903BB47
	for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 04:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711687562; cv=none; b=uCcGMTqA7KnO84dgRPnnlpVPY+Ki5lNHdl+MSp17FNlyvKYvI3GVYGZcGHcDU+9MSpCFLJ2jHsbyfjMN1DDX4KLCUdoMeJYWEUk1ZPZw6CX/NlgwWC4DmYNr20PYMs2ygOnOlajQC680+rOhhqAazNm4GiuW8jeUx3s8bySYSv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711687562; c=relaxed/simple;
	bh=7yAcfDfCzyzdBPEvC5nHM5bFgFu1FTDzoTgtfxzXpZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZWYcNy5WRpTRyPa2//c7Kbt3cqBlufbUMVWDOjdcnrU/joDNK1+k6CSnebxbmeORANm8BWb9kGy//aixHo+YmHkgbPOciR5FlK3Y+7kzvrkfvAFUoQXINv2GGcLwFgDdhaDqW+Fl1p3w7ORkM2bQ+PqbCGbzt1QAM3hwcC/F1d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=zrtb8xXv; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e6d089f603so1066891a34.1
        for <linux-arch@vger.kernel.org>; Thu, 28 Mar 2024 21:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711687559; x=1712292359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgqTcRj2U8Se9b0MFn8iBZ1MBZsdImVYllpKzi7FoF0=;
        b=zrtb8xXvplheNPMiwyqeG1cu6YHLpFbrN1e/J5SvkicePtLIEiwiRoY8hUTlBdJSZI
         31jBxbL2NO55xK0DZPVXpQQpjjgbNC9XFZxTX2akx3BCxrcrvR0EnDk4CAxO0zVg6Vgt
         MNABhrAh4RYBUcmc/PPb7Mx95CrhSSIlTwpyjxJRf31eBU2RwC51e0HBI/O30Q72SadS
         hyV3alJ6jWyCyS2WXnSuboMz/LYdjf129dkzZ0QBVS8/wqAFfWgztpe1gXpZE9YEu39t
         F+FLMz7nKiy1eX8Hu4Y5drc3kBgxo7pbE6pG1LJVp8P7sHzT/AEfqiWEdshETF9aoDIW
         4kLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711687559; x=1712292359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgqTcRj2U8Se9b0MFn8iBZ1MBZsdImVYllpKzi7FoF0=;
        b=nLVgw5lBbpOUO1xsA8T32NDXmlgiSyRFi7gx7+B9E3nDrm3ayzWkG79LEpbjIpTIBR
         5NrtmQrqZL9uLHY7NrqIAKHFK7Fzp8FMQwY3rkMACyu6VcJDguQDC5HkOackgHCdgRYb
         7FItD0FHE2knY1pBgIyUjs/3zWSaeenpRal46dKynrHVSXQt4Qm/JY+CCOjLIAaZQRqi
         B8T9yyx8YuaPqssfmc4h32oPud3sP4aqeK89Kk3KcEgCazHbYzck5fiTVPtTspRhYXf1
         G6azMjOLazGRs0iIwyoHi/5NXL8d1ELP3w6QwFpDymLut+yrJ5+nxkiUgQHcLe+kJ03x
         VUpw==
X-Forwarded-Encrypted: i=1; AJvYcCV0g1RMBMUmP31BzVw62M8jFysITO6i6mfIQmGI6Efdf3P8wjowr6nnBrBtjA9txsLziwHV8KMycIJPvVoH4n5KTelKDLLNZdcyHQ==
X-Gm-Message-State: AOJu0YyzuqZ+sfZ97OGxlg/UPHDpuvzYQviTCXmiR/o8e55sxF4fAOsw
	WdLaKBVCnwD9uSIwmB1cREMYw6Zr+Td4kA7/jF8HtggP23YBKvUb4Jq3iWKRUdo=
X-Google-Smtp-Source: AGHT+IF8V+3oImQuk/A4crk7sPM/VnCwTyQ17ZYhfUB3qy96qUK1l2ScpaHLIegUvWCFYCKqh7Y5ZQ==
X-Received: by 2002:a05:6808:1a05:b0:3c3:d477:62d3 with SMTP id bk5-20020a0568081a0500b003c3d47762d3mr1372369oib.44.1711687559607;
        Thu, 28 Mar 2024 21:45:59 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id i18-20020aa78b52000000b006ea7e972947sm2217120pfd.130.2024.03.28.21.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 21:45:59 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: paul.walmsley@sifive.com,
	rick.p.edgecombe@intel.com,
	broonie@kernel.org,
	Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com,
	keescook@chromium.org,
	ajones@ventanamicro.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	atishp@atishpatra.org,
	alex@ghiti.fr,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com,
	samuel.holland@sifive.com,
	palmer@sifive.com,
	conor@kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: corbet@lwn.net,
	tech-j-ext@lists.risc-v.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	oleg@redhat.com,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lstoakes@gmail.com,
	shuah@kernel.org,
	brauner@kernel.org,
	debug@rivosinc.com,
	andy.chiu@sifive.com,
	jerry.shih@sifive.com,
	hankuan.chen@sifive.com,
	greentime.hu@sifive.com,
	evan@rivosinc.com,
	xiao.w.wang@intel.com,
	charlie@rivosinc.com,
	apatel@ventanamicro.com,
	mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com,
	sameo@rivosinc.com,
	shikemeng@huaweicloud.com,
	willy@infradead.org,
	vincent.chen@sifive.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	songshuaishuai@tinylab.org,
	gerg@kernel.org,
	heiko@sntech.de,
	bhe@redhat.com,
	jeeheng.sia@starfivetech.com,
	cyy@cyyself.name,
	maskray@google.com,
	ancientmodern4@gmail.com,
	mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com,
	bgray@linux.ibm.com,
	mpe@ellerman.id.au,
	baruch@tkos.co.il,
	alx@kernel.org,
	david@redhat.com,
	catalin.marinas@arm.com,
	revest@chromium.org,
	josh@joshtriplett.org,
	shr@devkernel.io,
	deller@gmx.de,
	omosnace@redhat.com,
	ojeda@kernel.org,
	jhubbard@nvidia.com
Subject: [PATCH v2 04/27] riscv: zicfiss/zicfilp enumeration
Date: Thu, 28 Mar 2024 21:44:36 -0700
Message-Id: <20240329044459.3990638-5-debug@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329044459.3990638-1-debug@rivosinc.com>
References: <20240329044459.3990638-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds description in dt-bindings (extensions.yaml)

This patch adds support for detecting zicfiss and zicfilp. zicfiss and zicfilp
stands for unprivleged integer spec extension for shadow stack and branch
tracking on indirect branches, respectively.

This patch looks for zicfiss and zicfilp in device tree and accordinlgy lights
up bit in cpu feature bitmap. Furthermore this patch adds detection utility
functions to return whether shadow stack or landing pads are supported by
cpu.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 .../devicetree/bindings/riscv/extensions.yaml       | 10 ++++++++++
 arch/riscv/include/asm/cpufeature.h                 | 13 +++++++++++++
 arch/riscv/include/asm/hwcap.h                      |  2 ++
 arch/riscv/include/asm/processor.h                  |  1 +
 arch/riscv/kernel/cpufeature.c                      |  2 ++
 5 files changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 63d81dc895e5..f8d78bf7400b 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -317,6 +317,16 @@ properties:
             The standard Zicboz extension for cache-block zeroing as ratified
             in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
 
+        - const: zicfilp
+          description:
+            The standard Zicfilp extension for enforcing forward edge control-flow
+            integrity as ratified in commit 0036ff2 of riscv-cfi.
+
+        - const: zicfiss
+          description:
+            The standard Zicfiss extension for enforcing backward edge control-flow
+            integrity as ratified in commit 0036ff2 of riscv-cfi.
+
         - const: zicntr
           description:
             The standard Zicntr extension for base counters and timers, as
diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 0bd11862b760..f0fb8d8ae273 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -8,6 +8,7 @@
 
 #include <linux/bitmap.h>
 #include <linux/jump_label.h>
+#include <linux/smp.h>
 #include <asm/hwcap.h>
 #include <asm/alternative-macros.h>
 #include <asm/errno.h>
@@ -137,4 +138,16 @@ static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsi
 
 DECLARE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
 
+static inline bool cpu_supports_shadow_stack(void)
+{
+	return (IS_ENABLED(CONFIG_RISCV_USER_CFI) &&
+		    riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICFISS));
+}
+
+static inline bool cpu_supports_indirect_br_lp_instr(void)
+{
+	return (IS_ENABLED(CONFIG_RISCV_USER_CFI) &&
+		    riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICFILP));
+}
+
 #endif
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 1f2d2599c655..74b6c727f545 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -80,6 +80,8 @@
 #define RISCV_ISA_EXT_ZFA		71
 #define RISCV_ISA_EXT_ZTSO		72
 #define RISCV_ISA_EXT_ZACAS		73
+#define RISCV_ISA_EXT_ZICFILP	74
+#define RISCV_ISA_EXT_ZICFISS	75
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index a8509cc31ab2..6c5b3d928b12 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -13,6 +13,7 @@
 #include <vdso/processor.h>
 
 #include <asm/ptrace.h>
+#include <asm/hwcap.h>
 
 #ifdef CONFIG_64BIT
 #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 79a5a35fab96..d052cad5b82f 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -263,6 +263,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h),
 	__RISCV_ISA_EXT_SUPERSET(zicbom, RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_SUPERSET(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts),
+	__RISCV_ISA_EXT_SUPERSET(zicfilp, RISCV_ISA_EXT_ZICFILP, riscv_xlinuxenvcfg_exts),
+	__RISCV_ISA_EXT_SUPERSET(zicfiss, RISCV_ISA_EXT_ZICFISS, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
 	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
 	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
-- 
2.43.2


