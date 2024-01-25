Return-Path: <linux-arch+bounces-1538-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB0A83B9C2
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 07:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0111F2609D
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 06:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBEE175BC;
	Thu, 25 Jan 2024 06:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="UsrOrape"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC038171AB
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 06:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164156; cv=none; b=Qt+GINQJCpP6nDVJmHruXEr75ysbv2RGtLqTus4rVO5Mq52G4zpSbUTxNXsN/PT/RH5F+UH6TCLMFQS5UKf+Dhln4gXgfE25Xan5ti3d8FJMuprO0LYa030qimkm7ILo6obGTaB/MZ7r3OfaiBlvKLcziEEDwr9F5tsIRdzbDhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164156; c=relaxed/simple;
	bh=LvZLfFtPohYNVrhlo8kXoghOnc8le0NrJCzRCX+N24Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzneapMACV2YySW0XCJnSzKG8nbZl5a002lSpusWRXOwE1WNTdoRrAfGVVaaeDEazMdlM5DsLmiEuqbaHT+PRFhBgBcafahyLlgGAOYZdg0BLcWkNOUzkeN3XHzO7xK1t1bVDDOe1iYVSjuZaTjzi7SfIzx2SPtIfyoQhfdFQ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=UsrOrape; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bda6c92ce7so3913083b6e.2
        for <linux-arch@vger.kernel.org>; Wed, 24 Jan 2024 22:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706164153; x=1706768953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6jrxQTzk5v6yDwRhrNBVQOQ/gk4SzlXhOza5budY2g=;
        b=UsrOrapetzWJq063MRcQ0mXV0VrorxfFNWACj28CEwZMAbZE+VfaggVsMh80z6EbTm
         CmH7G6EvjiUHmKEUUgBlZ47/r3QGi/KfZUwCbp/xN4UXdhS06fnq1XnyxQ9Goyz8V6rg
         DrxLB1SmQ9kZMHMDgG+XZPr5sQ13kN+MmGOCL8EndylfyshIQdiSncQDi5xUkrOOy6tS
         CYSyWjz0c/8Ehq0ZmPRgsIP8YbEYhu3rbW0Gr8fFDfBr3LKa7CRWggc0uhu3lITacmf4
         EZ5qCAclpQGrHjPC9syyIc2hQGFGsOzLKmtRN16pKgawKH1Il+weI9qf3HPsZmUf7+Lj
         q/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706164153; x=1706768953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6jrxQTzk5v6yDwRhrNBVQOQ/gk4SzlXhOza5budY2g=;
        b=Iuo3RiskIufA8JnB3QeqKD2Rz9mF/jEMB0bS7m1iKaPKJD0WxUQF57UPmOdRHAj/Q2
         RSgTBzMuEsnFl2TSKRayXLLX+O9NjeqRdM4+Euh434Qhz5Ro0OiHIOM5wo/BuB6I2xy/
         /OFlaFdp6TaeneUZs9btMfL3r0o1StulT4Z03YegMBlXDFDoIwSOIvGgYdj82ixnepnr
         wCASGxPFc31KvHRgnlKCjtsQXbVwPBEbF0drOIq2PSbPScO5PLwIjPV+m+RBtSl04yn8
         q8Pc7wn3zDh9CrHv/MhggPgS2moRorE+r+VRRqRnLFSrwkrH2nhyhpTyK1g7ux8WIh3S
         Om2A==
X-Gm-Message-State: AOJu0YyYsuw0JMlWBv6io2zNSWwIjFp+eYx3SzH85dMPYCgrOPRKPn1c
	9ZCdleHL6GfLLOm44ladg4Kg9AFTo1z/ot0qgxiOVSL7UBHv9IAYc+20f6ChSHY=
X-Google-Smtp-Source: AGHT+IE9c8MEdVglNRelh8ZMz256rscxIEtK+0cPNlGjBMQYH53mysOGbUh9rlxjO/qpIC+YDleATw==
X-Received: by 2002:a54:478d:0:b0:3bd:be66:c0c7 with SMTP id o13-20020a54478d000000b003bdbe66c0c7mr441553oic.98.1706164153039;
        Wed, 24 Jan 2024 22:29:13 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a00139300b006dd870b51b8sm3201139pfg.126.2024.01.24.22.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 22:29:12 -0800 (PST)
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
Subject: [RFC PATCH v1 09/28] mm: abstract shadow stack vma behind `arch_is_shadow_stack`
Date: Wed, 24 Jan 2024 22:21:34 -0800
Message-ID: <20240125062739.1339782-10-debug@rivosinc.com>
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

x86 has used VM_SHADOW_STACK (alias to VM_HIGH_ARCH_5) to encode shadow
stack VMA. VM_SHADOW_STACK is thus not possible on 32bit. Some arches may
need a way to encode shadow stack on 32bit and 64bit both and they may
encode this information differently in VMAs.

This patch changes checks of VM_SHADOW_STACK flag in generic code to call
to a function `arch_is_shadow_stack` which will return true if arch
supports shadow stack and vma is shadow stack else stub returns false.

There was a suggestion to name it as `vma_is_shadow_stack`. I preferred to
keep `arch` prefix in there because it's each arch specific.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/linux/mm.h | 18 +++++++++++++++++-
 mm/gup.c           |  5 +++--
 mm/internal.h      |  2 +-
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dfe0e8118669..15c70fc677a3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -352,6 +352,10 @@ extern unsigned int kobjsize(const void *objp);
  * for more details on the guard size.
  */
 # define VM_SHADOW_STACK	VM_HIGH_ARCH_5
+static inline bool arch_is_shadow_stack(vm_flags_t vm_flags)
+{
+	return (vm_flags & VM_SHADOW_STACK);
+}
 #endif
 
 #ifdef CONFIG_RISCV_USER_CFI
@@ -362,10 +366,22 @@ extern unsigned int kobjsize(const void *objp);
  * with VM_SHARED.
  */
 #define VM_SHADOW_STACK	VM_WRITE
+
+static inline bool arch_is_shadow_stack(vm_flags_t vm_flags)
+{
+	return ((vm_flags & (VM_WRITE | VM_READ | VM_EXEC)) == VM_WRITE);
+}
+
 #endif
 
 #ifndef VM_SHADOW_STACK
 # define VM_SHADOW_STACK	VM_NONE
+
+static inline bool arch_is_shadow_stack(vm_flags_t vm_flags)
+{
+	return false;
+}
+
 #endif
 
 #if defined(CONFIG_X86)
@@ -3464,7 +3480,7 @@ static inline unsigned long stack_guard_start_gap(struct vm_area_struct *vma)
 		return stack_guard_gap;
 
 	/* See reasoning around the VM_SHADOW_STACK definition */
-	if (vma->vm_flags & VM_SHADOW_STACK)
+	if (vma->vm_flags && arch_is_shadow_stack(vma->vm_flags))
 		return PAGE_SIZE;
 
 	return 0;
diff --git a/mm/gup.c b/mm/gup.c
index 231711efa390..45798782ed2c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1051,7 +1051,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 		    !writable_file_mapping_allowed(vma, gup_flags))
 			return -EFAULT;
 
-		if (!(vm_flags & VM_WRITE) || (vm_flags & VM_SHADOW_STACK)) {
+		if (!(vm_flags & VM_WRITE) || arch_is_shadow_stack(vm_flags)) {
 			if (!(gup_flags & FOLL_FORCE))
 				return -EFAULT;
 			/* hugetlb does not support FOLL_FORCE|FOLL_WRITE. */
@@ -1069,7 +1069,8 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 			if (!is_cow_mapping(vm_flags))
 				return -EFAULT;
 		}
-	} else if (!(vm_flags & VM_READ)) {
+	} else if (!(vm_flags & VM_READ) && !arch_is_shadow_stack(vm_flags)) {
+	/* reads allowed if its shadow stack vma */
 		if (!(gup_flags & FOLL_FORCE))
 			return -EFAULT;
 		/*
diff --git a/mm/internal.h b/mm/internal.h
index b61034bd50f5..0abf00c93fe1 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -572,7 +572,7 @@ static inline bool is_exec_mapping(vm_flags_t flags)
  */
 static inline bool is_stack_mapping(vm_flags_t flags)
 {
-	return ((flags & VM_STACK) == VM_STACK) || (flags & VM_SHADOW_STACK);
+	return ((flags & VM_STACK) == VM_STACK) || arch_is_shadow_stack(flags);
 }
 
 /*
-- 
2.43.0


