Return-Path: <linux-arch+bounces-1541-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD90A83B9D0
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 07:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E071C24C71
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 06:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477FA125B6;
	Thu, 25 Jan 2024 06:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sJs6+JdF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82696199BE
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 06:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164182; cv=none; b=d586cDOdGoKRcBLg2IHfJH2xUYi89Crn9LiPlgIWl1cBMyzl3pbU/VZVbZchRHSjIzqvLuY4Gzd+PTLOpVK9wztmCVelsG/WjECUTA2JuhcAEKYd9/hEJHhtCIzpG+l7WL1Cn0gCYt9XSPr0DGrm2UVlHqjFDIQwDZHqd2V/MfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164182; c=relaxed/simple;
	bh=yGHZsYT52As0iEg7iPcfGB1vnJ1Qj3UnSp8T8gtPGCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knr2t0tISfA9jWR5TVGPVkz90D2Tt6BOkqKCTJBrB767hmZSdNBrDn4Uf8qvy18wfYISRSNAk8bY2rQMLhKDuMUNZ1VX9GOgDFtOs+vB4sRvJgJtiwURgXUkLG4y6ocQtpkK+xGMZEFQhm9UvggWZbIzdfJ4QwzZBbBq9uY0Yhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sJs6+JdF; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ddc2a78829so698301b3a.3
        for <linux-arch@vger.kernel.org>; Wed, 24 Jan 2024 22:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706164180; x=1706768980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9U4/v4w/mrwXRuPEpy9c03cIo3F2WWlXK10aLJp76Yo=;
        b=sJs6+JdF4isADJZ1Tn6y+quG+jcKyWheHjkxGaZ1FWKsWGdf40ViLb1G8SULnNHGlV
         wz1gERUtyvwPfF2o0TXzvJyKYZNQMQLOiMJ2ND2Kkmj8Usvdv5oV9ITx8l1KQImuHHcU
         xrToPu4uNaDCkQs9rLYO2tgb0bBLqUeZb1CioLlkc3lYkjOijJ4fj0+D6BBKfjVfzNlK
         C4rgDcdLUaxPFKQI33SWV3FhUERSChp0+mc2UGJYCESGxbeVi4rtsHewP4ZG//xv+wo1
         kInOSARHP6vGVFsJzjx/En+4VI4dZ1xi/vx7679lOMKKMgaVtRjp7QUQDSupkgyCqe86
         hkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706164180; x=1706768980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9U4/v4w/mrwXRuPEpy9c03cIo3F2WWlXK10aLJp76Yo=;
        b=eBUsl0SdpDglHdV9JHyUkXoTAJ7JbSSkcePl65jfKtmCixDBru7bKxIt85kaYGJckp
         e3BFHn7XEdgEnc/Dpk9IP6bSJlg8Y6RdX9lbjACyewBAc6IjcbUnE7ZXaxWjI3M6ZRG9
         gQYN/97QjdijAVbNcPRw6jvoA32gXDi7ouXjVKrqjqd0SWnMMXo0s1WCXd9VGNbU56r4
         mwYLun/CNJHt1z6jB3KrafptW1yCCeiw3joDPYaJAYEduvYfdoIyOv8GQq1oLgPLQSaZ
         rwHviZlwzrIUiK825SuYf+v3Zwuil+D957RVL8NYkoZ+9mRsIqqg00tmLosoBPH88MKW
         TVqA==
X-Gm-Message-State: AOJu0YwTyq1XMrOmhooRXrmlSER1RWfx4XihPAW1J/eC6BBIH904Pjbf
	tzRn9s3nVEsU26h0NIIsH3WKkf8TGGwIEAIXLwPqFzV+GUAfsovZ6Z81t5SqXrE=
X-Google-Smtp-Source: AGHT+IFE6DJFyN+P/UFNG3VqxG06rTZRsSyHKHiD9aR2/YyBQCkrTLXVopsPYOyeiHivgMNZUq582Q==
X-Received: by 2002:a05:6a00:4006:b0:6dd:a072:867 with SMTP id by6-20020a056a00400600b006dda0720867mr290270pfb.15.1706164179881;
        Wed, 24 Jan 2024 22:29:39 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a00139300b006dd870b51b8sm3201139pfg.126.2024.01.24.22.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 22:29:39 -0800 (PST)
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
Subject: [RFC PATCH v1 12/28] riscv mm: manufacture shadow stack pte
Date: Wed, 24 Jan 2024 22:21:37 -0800
Message-ID: <20240125062739.1339782-13-debug@rivosinc.com>
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

This patch implements creating shadow stack pte (on riscv). Creating
shadow stack PTE on riscv means that clearing RWX and then setting W=1.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 54a8dde29504..7ed00b4cc73d 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -408,6 +408,12 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_WRITE);
 }
 
+static inline pte_t pte_mkwrite_shstk(pte_t pte)
+{
+	/* shadow stack on risc-v is XWR = 010. Clear everything and only set _PAGE_WRITE */
+	return __pte((pte_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 /* static inline pte_t pte_mkexec(pte_t pte) */
 
 static inline pte_t pte_mkdirty(pte_t pte)
@@ -705,6 +711,12 @@ static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 	return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
 }
 
+static inline pmd_t pmd_mkwrite_shstk(pmd_t pte)
+{
+	/* shadow stack on risc-v is XWR = 010. Clear everything and only set _PAGE_WRITE */
+	return __pmd((pmd_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
 {
 	return pte_pmd(pte_wrprotect(pmd_pte(pmd)));
-- 
2.43.0


