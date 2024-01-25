Return-Path: <linux-arch+bounces-1530-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1FD83B993
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 07:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C510DB21D2E
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 06:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F4610A05;
	Thu, 25 Jan 2024 06:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ifq8RkZP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A198A11187
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 06:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164098; cv=none; b=lUvtSHdbFWmdannaplb6+0PsKJGIB9F704u6pTjGdJpvDZ2Hy5jAm2tNWT+3JJT8IUrDxy3M42U9S7uHieSDzEhj8c1MO1EVrXI2BHoMyfxkF7DvfDNKHmim+n7dDFf2v9dosYKOWRqSqHOXwXrKJnz3Kzo4OXHY1PRrQp8IAUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164098; c=relaxed/simple;
	bh=It+EMpSbuxbOFTFir1++Dx10sQovUJfe7FLCGNYgdQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJUQuTCPoFl9kD0qxTHsNMHQfh+2C48KI3WqyjMDiwcaUrKBoUhXPfQEyxN1mRMX/OmiaMKepu3kl/AGnLpmSXyKs4KLhgr8xsSF0tjKxZ4UPHkPeS4T9edOcGkrUIGPo8HphU2MDmmLWZSXQEFOAJlPpZ6bWW9kW19GSimXBdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ifq8RkZP; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-599abffe3e5so1298482eaf.3
        for <linux-arch@vger.kernel.org>; Wed, 24 Jan 2024 22:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706164095; x=1706768895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3e2cTh56cG2GGWTE4NSzcFXiqv/NB8pwrDQ1nq4c+Tw=;
        b=ifq8RkZPnKIrm2FLayVBxtOA0CU1m0MvH2HnDv21gi0E/YDI1b7xMfv+xF6kFvPAU/
         bmMS3gHRBkf+lruk6FXhIfAa76nYmxfSGJG/QJ7uaJtETrOd8FSP/Elo4KIJ1wyhDCxV
         8+/8ax+afQu8JX7PGSJGPYhrvfG6MupgcI63zFUErbSqb6ud2tWXmibVbFmNF6sEgxKY
         TFK37J061MEXTBn0pxLzGeu0x6MkqrxailA/M6syctjcn/PQe3H/Y8Tqzv6FLGmox5yn
         BRVWtmiZSNZR/Wjh+YHBgoL23whvD15Pg98hHgTcXnJesz3qSY/6xJpfiM+vLVN2HzIr
         AguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706164095; x=1706768895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3e2cTh56cG2GGWTE4NSzcFXiqv/NB8pwrDQ1nq4c+Tw=;
        b=DmCzTwcEkgZrM/xRTZNX4s7lLdxnEYIx108X4MfFlgqHW/E5LnvoTcZlCJQsa7ce2x
         OTaFMBcWDjq+ZDnU+bAv5h12jO3yMCxnGWuv45mBaT88wYMd1XNeAUylt/mx5YerWUYg
         k9pc0+PQIeFJxOZ+x6EbaeRsGTbIUbni4gcjpccTBcF45uiHMn9+Z0Nw/6D26/DmHqJ9
         MKEkeYgviaxle30g4w/fsw/Hv7LmsKt3S6GYfm9Z8EnidkgJzTtGLDmH7fDqo6vea6L0
         eMpSVfxMeHlWdDEWOrKen4gqKOm45B24rskiQQjdGm12flI2fbbGlDRBFiGzCc3Bg9sd
         2/Hw==
X-Gm-Message-State: AOJu0YxXZmEpGJppUpbZaEtgKIVAm1cidgT8U+QkmBcA1CqrDxUq1COu
	cgdlZFtYJehDz80vCsJxc89tnKkVLtkMHyc1tm4Y04qs9ZAeG2TOxhRwLzRKSg0=
X-Google-Smtp-Source: AGHT+IHCIEsJoIeVNjGK2Jx0Div0w47akcVOGWIMmQ12q7OuC1Yo4rjhD3STlwvv6dFXihLIPTns6w==
X-Received: by 2002:a05:6358:8404:b0:176:5d11:3071 with SMTP id b4-20020a056358840400b001765d113071mr519801rwk.12.1706164095683;
        Wed, 24 Jan 2024 22:28:15 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a00139300b006dd870b51b8sm3201139pfg.126.2024.01.24.22.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 22:28:15 -0800 (PST)
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
Subject: [RFC PATCH v1 01/28] riscv: abstract envcfg CSR
Date: Wed, 24 Jan 2024 22:21:26 -0800
Message-ID: <20240125062739.1339782-2-debug@rivosinc.com>
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

This patch abstracts envcfg CSR in kernel (as is done for other homonyn
CSRs). CSR_ENVCFG is used as alias for CSR_SENVCFG or CSR_MENVCFG depending
on how kernel is compiled.

Additionally it changes CBZE enabling to start using CSR_ENVCFG instead of
CSR_SENVCFG.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/csr.h   | 2 ++
 arch/riscv/kernel/cpufeature.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 306a19a5509c..b3400517b0a9 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -415,6 +415,7 @@
 # define CSR_STATUS	CSR_MSTATUS
 # define CSR_IE		CSR_MIE
 # define CSR_TVEC	CSR_MTVEC
+# define CSR_ENVCFG CSR_MENVCFG
 # define CSR_SCRATCH	CSR_MSCRATCH
 # define CSR_EPC	CSR_MEPC
 # define CSR_CAUSE	CSR_MCAUSE
@@ -439,6 +440,7 @@
 # define CSR_STATUS	CSR_SSTATUS
 # define CSR_IE		CSR_SIE
 # define CSR_TVEC	CSR_STVEC
+# define CSR_ENVCFG CSR_SENVCFG
 # define CSR_SCRATCH	CSR_SSCRATCH
 # define CSR_EPC	CSR_SEPC
 # define CSR_CAUSE	CSR_SCAUSE
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index b3785ffc1570..98623393fd1f 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -725,7 +725,7 @@ arch_initcall(check_unaligned_access_all_cpus);
 void riscv_user_isa_enable(void)
 {
 	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICBOZ))
-		csr_set(CSR_SENVCFG, ENVCFG_CBZE);
+		csr_set(CSR_ENVCFG, ENVCFG_CBZE);
 }
 
 #ifdef CONFIG_RISCV_ALTERNATIVE
-- 
2.43.0


