Return-Path: <linux-arch+bounces-3284-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D08891288
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 05:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09171F21A16
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 04:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1FF3C485;
	Fri, 29 Mar 2024 04:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="DVqjNUxG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3FB3C060
	for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 04:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711687566; cv=none; b=fnXv45L+xtx1NDkJjYvlZJWNyLUqWDNi2W9/Z24JAvfHknFkjTYq9EUq5+YeM1GjiHEkGfLiQU8Of1Txm8RNeIel+jaAKDMMOG+gHUPmUSDmIZUL3JGh5VRzytn8GKeOBnmLk2Oa6k7uHY1rQVewxNMTEeybGdywH5F2zmeJTSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711687566; c=relaxed/simple;
	bh=IbhSvf/dpnKjQwpCPxxuuWngmE7l+H7+W1bSLBUk1+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sW3qOmXez6+6AjuVzVgoC5fjMkzLTE0YxsPUiFStjV/17LildN5zl7czaRgUEFarFK/+MTNedMMyrF098alpZHxMLFU+SJdzHj69IgOBGM4By8VxgX1oelBtMj8i3I/4yTO8vft1qwDRW9h8GfUUUw3Sz4faZTb2u/aRXDJNTVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=DVqjNUxG; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e8f51d0bf0so1448742b3a.3
        for <linux-arch@vger.kernel.org>; Thu, 28 Mar 2024 21:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711687564; x=1712292364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8I6BxlsTuM8aPnLudo3zS/ouO48NeQKH2Qm0sPb12tM=;
        b=DVqjNUxGwmMg66K2p0HBKxBBrM43Yh2iFeD2YfgqiNHjwDoqY+KdqLEZN9PcRga4/F
         ihsZ2VZgxYaXkoMfudPTsu9lGAgb9S52eD+xulnJk5DHSBZftFgIUbIFPY/Yz1wdDnG/
         gNQ/Qv9qu31aOY8Bm0KM/OWsuKRUltGbyrEqoWy1CQ2kLlJyQytb/LeaIOxLxo8rWOqL
         UkWomZVNe4qmxaoqfBJgeOO0aTwaV5eIfqeWmgpVlIZR1S4Y0QcoGbBxlWMNe5Vqf7Sr
         zeslR7z7ev7ip1eQhStA5zdiLXA8p45EYSmGqEBEvROnixgwcDImE391GTCWTi4N4v/h
         h0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711687564; x=1712292364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8I6BxlsTuM8aPnLudo3zS/ouO48NeQKH2Qm0sPb12tM=;
        b=r8mtHVO364BYhHbThNfRmru5saK4X0cuw6qgcjrlme5Gn1HXupaEaMDHU3V4S78c32
         z7+Y9uonGuvBT1p6M7JUVWi63PWGsBDKEH7zMeWv8E422NekHAjlUsZ112ZQn0KIpVnv
         zAW0ikJ3Lg0GrqTTX4JTrbaZNf5FwxmQKPLz91J6F/X+Bx9+YeR2yREj5p9WF49xHRkS
         veArlzkT9860/M1+8qbLUDZyIDyYqtSY/3UhZ5ouV+17wKdpJvCJCLJPX9jv/VK3azBh
         LL4T6U042t9I9L1nP2xz14v3lfjErpliar39jHdgflIbJ2eilazNdWA9CyNViUYayeXt
         1Eog==
X-Forwarded-Encrypted: i=1; AJvYcCUDqPuvBq+8O5oKoffaMpnXjvz7PxjBa0OtOub0F/QCBybQiBg/CUhL4Ylel0GGNqkXZcZTSGsPtrhMQCRZTKUAgR6ldlg77XFqBw==
X-Gm-Message-State: AOJu0YzMlrLmzPoxX5i9siRfAqUpZjPoIXJ34tJEiNeXZqVIH6BKWxu1
	Y8+znFnYrGH/a0AmYS0YluWQJ9OxJ6qHKI+bQHUs6AaEacsP0F2DsKbpH7VY+GM=
X-Google-Smtp-Source: AGHT+IHE6usyMFBQxvFagxY/LvFEXsQVHbAuxvgF7MaJ2nwwxjQI5uC10jSUwmgfFjplPX6uFLGn9A==
X-Received: by 2002:a05:6a00:b46:b0:6ea:d792:b721 with SMTP id p6-20020a056a000b4600b006ead792b721mr1470047pfo.14.1711687564387;
        Thu, 28 Mar 2024 21:46:04 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id i18-20020aa78b52000000b006ea7e972947sm2217120pfd.130.2024.03.28.21.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 21:46:04 -0700 (PDT)
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
Subject: [PATCH v2 05/27] riscv: zicfiss/zicfilp extension csr and bit definitions
Date: Thu, 28 Mar 2024 21:44:37 -0700
Message-Id: <20240329044459.3990638-6-debug@rivosinc.com>
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

zicfiss and zicfilp extension gets enabled via b3 and b2 in *envcfg CSR.
menvcfg controls enabling for S/HS mode. henvcfg control enabling for VS while
senvcfg controls enabling for U/VU mode.

zicfilp extension extends *status CSR to hold `expected landing pad` bit.
A trap or interrupt can occur between an indirect jmp/call and target instr.
`expected landing pad` bit from CPU is recorded into xstatus CSR so that when
supervisor performs xret, `expected landing pad` state of CPU can be restored.

zicfiss adds one new CSR
- CSR_SSP: CSR_SSP contains current shadow stack pointer.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index bbd2207adb39..3bb126d1c5ff 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -18,6 +18,15 @@
 #define SR_MPP		_AC(0x00001800, UL) /* Previously Machine */
 #define SR_SUM		_AC(0x00040000, UL) /* Supervisor User Memory Access */
 
+/* zicfilp landing pad status bit */
+#define SR_SPELP	_AC(0x00800000, UL)
+#define SR_MPELP	_AC(0x020000000000, UL)
+#ifdef CONFIG_RISCV_M_MODE
+#define SR_ELP		SR_MPELP
+#else
+#define SR_ELP		SR_SPELP
+#endif
+
 #define SR_FS		_AC(0x00006000, UL) /* Floating-point Status */
 #define SR_FS_OFF	_AC(0x00000000, UL)
 #define SR_FS_INITIAL	_AC(0x00002000, UL)
@@ -196,6 +205,8 @@
 #define ENVCFG_PBMTE			(_AC(1, ULL) << 62)
 #define ENVCFG_CBZE			(_AC(1, UL) << 7)
 #define ENVCFG_CBCFE			(_AC(1, UL) << 6)
+#define ENVCFG_LPE			(_AC(1, UL) << 2)
+#define ENVCFG_SSE			(_AC(1, UL) << 3)
 #define ENVCFG_CBIE_SHIFT		4
 #define ENVCFG_CBIE			(_AC(0x3, UL) << ENVCFG_CBIE_SHIFT)
 #define ENVCFG_CBIE_ILL			_AC(0x0, UL)
@@ -216,6 +227,11 @@
 #define SMSTATEEN0_HSENVCFG		(_ULL(1) << SMSTATEEN0_HSENVCFG_SHIFT)
 #define SMSTATEEN0_SSTATEEN0_SHIFT	63
 #define SMSTATEEN0_SSTATEEN0		(_ULL(1) << SMSTATEEN0_SSTATEEN0_SHIFT)
+/*
+ * zicfiss user mode csr
+ * CSR_SSP holds current shadow stack pointer.
+ */
+#define CSR_SSP                 0x011
 
 /* symbolic CSR names: */
 #define CSR_CYCLE		0xc00
-- 
2.43.2


