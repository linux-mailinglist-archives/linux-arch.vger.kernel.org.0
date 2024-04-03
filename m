Return-Path: <linux-arch+bounces-3409-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5777C897C33
	for <lists+linux-arch@lfdr.de>; Thu,  4 Apr 2024 01:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13501F21F8F
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 23:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFAC1581E5;
	Wed,  3 Apr 2024 23:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="CJLVAddb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01B2157E96
	for <linux-arch@vger.kernel.org>; Wed,  3 Apr 2024 23:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712187708; cv=none; b=rshou3z4M6vVA0iw1dVfyNaKnvOad4xJSaZV+6s4xTx87YXp1A3gr/DK4vtAgDNIJ9RgDH5fP4mVwRSajj0g53SNyXfwwyMj0zWRPShSY0UNQgKuxHwc85FeZ8+FzTg151p8i0G79HTzoPiwZFTcJ7Fx+YdbBSrOi9YKZGmSaZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712187708; c=relaxed/simple;
	bh=h/Tre14WJ45U1+YRacIvsssOX4thi3NoAellOamVugo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SqxyW3shuj9LtDU/wGH56tNeqL8LofPCBEFyijQaeAQ9aKdFSMkeoJsWTIsk/Wqtb/6GoyaggFZjP5w8y0j1/4vUrqCobMhYbBOJGAzJLKnZ17d2RJ2v9TAvapoPOOnt+s6nfIDG1ndyIxfdptDXAvb3qanJkXshe5cOQVPC2TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=CJLVAddb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e0878b76f3so3541815ad.0
        for <linux-arch@vger.kernel.org>; Wed, 03 Apr 2024 16:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712187706; x=1712792506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0eUDSnaDyxqGg81dPEndGGDTB0RLZ2EAet5NZFMb2JI=;
        b=CJLVAddbOo6EucmFc0Wy1D+VdSoIj1jJBTeQYtkAXSe+1Keu+ciP4agzCAi2pWpUwJ
         Tr4isHFU14IbjHwS6DFRxJavyi6HeNk6vF3Wj5+OjB/pioZBeIWaFd8AaNsH3ZIBMPEo
         rPw1TQzPOLn1R6Z/7Q78XsPgQTRcy4DYqX53YSbr6YlDQS4GbkqRtyFLWKrfWMRpOK8P
         3Y/MmTH2pRl0o25cwGcC3JPk/zBYQeCfhVIy0eUOnWUom7Cwl9yBApuHxEbYu72Evxxj
         2Kbv0lv8XCDfvaYzoPmH+t547guOEUbconTdNv4+M1JrM2VU2MQeUyRyKCAXbEu6i9lA
         T/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712187706; x=1712792506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0eUDSnaDyxqGg81dPEndGGDTB0RLZ2EAet5NZFMb2JI=;
        b=iXqQ1XzpCmcCo1YfKJtqvRauh7jXL1rFYlsGLFkFJJ097iKNtxI6Kcg8YMmTcz32c2
         ek36d4/Ls/11cejgqnMTK0rJgk9TQcK39VzyGaMhM63YeFxz6bWnmVPHcJv/GbIJ08XF
         Y8UTV2/RRUvAuhqhb+LOjOS4Zuk6Tq6zaVdxh5EaR/BMTbWfEkDsfMsKvQft02A5hnEm
         +xuNbKAmxmPK9tHPtvtKUpU1+Wv0UDR4LyQaKLfl5e+mYzORKHh+qOvrAqKaRJSIFChq
         jV8PErF74KhU4trfoU7BRtWu5IEsKMQpFmPyVm0153UeMuqj8kHl6F/v3Ir+1VEgn2Bx
         i6OA==
X-Forwarded-Encrypted: i=1; AJvYcCV/+SieYnWrMVaJDWa/ByygNwVlhvqsn16ifQfcfHZJ6WKE7F1RZJlGLdlzI4RnnQcetYs/EMUickB0OU7xzfUyNCmH4VE4q3F9eQ==
X-Gm-Message-State: AOJu0YzIhfpoi+bHkMTENwtjehDv1cMqfnYeD/XTDgnxAaLB61VXIQI7
	HrG14AUMrc0+xKG2LA+slG7vQMr0+LKAX9vLH/qQgj+K3orZGkHwBb7O2m7c1YM=
X-Google-Smtp-Source: AGHT+IFyjyOK4imuMufx/V8FtRsE6RLkCpoEsDyebREmag+E/YQOk+Aiq+uxRiaeRtydulTn7Ig+Gg==
X-Received: by 2002:a17:902:d2c4:b0:1e2:a61e:47fa with SMTP id n4-20020a170902d2c400b001e2a61e47famr1344360plc.15.1712187706092;
        Wed, 03 Apr 2024 16:41:46 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902d51200b001deeac592absm13899117plg.180.2024.04.03.16.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 16:41:45 -0700 (PDT)
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
	conor@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	corbet@lwn.net,
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
Subject: [PATCH v3 06/29] riscv: zicfiss / zicfilp extension csr and bit definitions
Date: Wed,  3 Apr 2024 16:34:54 -0700
Message-ID: <20240403234054.2020347-7-debug@rivosinc.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240403234054.2020347-1-debug@rivosinc.com>
References: <20240403234054.2020347-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zicfiss and zicfilp extension gets enabled via b3 and b2 in *envcfg CSR.
menvcfg controls enabling for S/HS mode. henvcfg control enabling for VS
while senvcfg controls enabling for U/VU mode.

zicfilp extension extends *status CSR to hold `expected landing pad` bit.
A trap or interrupt can occur between an indirect jmp/call and target
instr. `expected landing pad` bit from CPU is recorded into xstatus CSR so
that when supervisor performs xret, `expected landing pad` state of CPU can
be restored.

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


