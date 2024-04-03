Return-Path: <linux-arch+bounces-3412-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD32897C43
	for <lists+linux-arch@lfdr.de>; Thu,  4 Apr 2024 01:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9436328C9F0
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 23:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B5C1586F2;
	Wed,  3 Apr 2024 23:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="2+rkbx6G"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C411586DD
	for <linux-arch@vger.kernel.org>; Wed,  3 Apr 2024 23:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712187716; cv=none; b=nN3UexqudDnIVQdyMDjCMQVWCaxxFBH2dmAewKCfOGOD11Es2elVD4d76zuUXNQCDI+ij177JzEieVkVYVg3HZlKQnj8rAW2cGZx2v1xdzD1lAutCQUKb1LWS1po9mwk/Ivkf9B5Te4DsfbTVqxBq+rxJqoDy9oO9WJFfeXKM2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712187716; c=relaxed/simple;
	bh=wuffEo00k2gSrTQVE+mHLCh38SejhCpBaK1ioNhuIa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NbHEcCeVJ1qxQiuWM82NweGE5qpBj+rCaxP5pLVWrtY7wfRNoGdNfMUO2g4CrnQhyAidltgfrXQP4Y0KEJUxJO6c+2JCZdxW2dxc6yQTqQy3RCxUDUQ6sNviJG8yjCUKwB6vDJ2x6q5eMasf0y6m3+/JptON7jRR7WyFHzSWiOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=2+rkbx6G; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e2a7b5ef7bso2594775ad.1
        for <linux-arch@vger.kernel.org>; Wed, 03 Apr 2024 16:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712187714; x=1712792514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54i5AOpZ8eaoGeKx2/tq2pnpvo0kkfTAlmLvvQQ7IdM=;
        b=2+rkbx6GtLEqKXFduQ9nWERJclW/1DHNK1/cIsgglUSmY1g5pq9bswNuN7CHRhXb1d
         km0X/vk1Uw2oGbHE9bn6glSG2WeiDE1kCO2B9hotUrRY56nczcxjFX1oPCEHnEI4A/oB
         GBiZYkc2Zxo4XDh64MNCqcGhP5+2T7/gk7oz1EezUD27Jhbl4rjP2Ta8QbSk+TQTFRNR
         gTQ4HIcxp9NxoJr9+z3gwKlkoDZGuNp8jZTqtfkVvHMsMBArwa6F3NUIMpnLHFxiN+Qb
         woU2YZ/8RAwFq3BffrVXew1iP1JIFiwQ8mdEDrAkG0Uop5K965eVHyFBvEa7Wri4kXuP
         fHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712187714; x=1712792514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54i5AOpZ8eaoGeKx2/tq2pnpvo0kkfTAlmLvvQQ7IdM=;
        b=QP1kBuHRLllQTcSmbFluRqzXHapkdnE72gA6oi/3CGOQnZ1oWv7zEkt65v5PBUKikE
         Y9Xqb+2ZkP8sqa9MyjOu61h63uSgh9CLZtaQ550Vt1usoZ1sCIWEZuZs1EYXGM7jDQT7
         AlnOVZXjejtaXs5IDnBnWEAfdq51rDSAo3psCuTEcr9NfvPUk18/d7XVz62OwyHnkULv
         aJbmVV2nWamGgTpYXuqIb5rsTcJAuUj8ToMnsJhsmcYjgwk6IXmsWrgPXlijZQYMkws6
         /dx/5f2nQMInjSGvlhBOtPJlcoy6+L9CIVwTjIaiN6pvzSY7X5B80VetpqrvcQ3eIC5W
         ex/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXdWZETvTeS+zMFXmftgVbzHrMBcPhi8YJ61/BI8/X9NBuWOxHyf1oR2fvm3g2FFhYpFBxdtJ55IWnoRAiljWCA0Isvc5LeHL+Ew==
X-Gm-Message-State: AOJu0YzCrtgIPZH1bLQ2Ew6/baNTB+RU/bgQQgdRagiM2IHKU0t+Y15P
	Sucqc6i1pRYeJ2pgrx0AcrPW0Q2VvO0HXmyH4Z8qLFFxDyw7G5zROEvuWFiTNjA=
X-Google-Smtp-Source: AGHT+IG6GlC+ZgzT+vgM3OEvECwnyeJlz7W2zSZ3hW3riRhMkNJ5fFd9UMQXlTdOrd5KXzyMbVV4Yg==
X-Received: by 2002:a17:902:f085:b0:1e2:a5b2:ee0f with SMTP id p5-20020a170902f08500b001e2a5b2ee0fmr628269pla.24.1712187714025;
        Wed, 03 Apr 2024 16:41:54 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902d51200b001deeac592absm13899117plg.180.2024.04.03.16.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 16:41:53 -0700 (PDT)
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
	jhubbard@nvidia.com,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v3 09/29] mm: abstract shadow stack vma behind `vma_is_shadow_stack`
Date: Wed,  3 Apr 2024 16:34:57 -0700
Message-ID: <20240403234054.2020347-10-debug@rivosinc.com>
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

VM_SHADOW_STACK (alias to VM_HIGH_ARCH_5) to encode shadow stack VMA.

This patch changes checks of VM_SHADOW_STACK flag in generic code to call
to a function `vma_is_shadow_stack` which will return true if its a
shadow stack vma and default stub (when support doesnt exist) returns false.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Suggested-by: Mike Rapoport <rppt@kernel.org>
---
 include/linux/mm.h | 13 ++++++++++++-
 mm/gup.c           |  5 +++--
 mm/internal.h      |  2 +-
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 64109f6c70f5..9952937be659 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -363,8 +363,19 @@ extern unsigned int kobjsize(const void *objp);
 
 #ifndef VM_SHADOW_STACK
 # define VM_SHADOW_STACK	VM_NONE
+
+static inline bool vma_is_shadow_stack(vm_flags_t vm_flags)
+{
+	return false;
+}
+#else
+static inline bool vma_is_shadow_stack(vm_flags_t vm_flags)
+{
+	return (vm_flags & VM_SHADOW_STACK);
+}
 #endif
 
+
 #if defined(CONFIG_X86)
 # define VM_PAT		VM_ARCH_1	/* PAT reserves whole VMA at once (x86) */
 #elif defined(CONFIG_PPC)
@@ -3473,7 +3484,7 @@ static inline unsigned long stack_guard_start_gap(struct vm_area_struct *vma)
 		return stack_guard_gap;
 
 	/* See reasoning around the VM_SHADOW_STACK definition */
-	if (vma->vm_flags & VM_SHADOW_STACK)
+	if (vma->vm_flags && vma_is_shadow_stack(vma->vm_flags))
 		return PAGE_SIZE;
 
 	return 0;
diff --git a/mm/gup.c b/mm/gup.c
index df83182ec72d..a7a02eb0a6b3 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1053,7 +1053,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 		    !writable_file_mapping_allowed(vma, gup_flags))
 			return -EFAULT;
 
-		if (!(vm_flags & VM_WRITE) || (vm_flags & VM_SHADOW_STACK)) {
+		if (!(vm_flags & VM_WRITE) || vma_is_shadow_stack(vm_flags)) {
 			if (!(gup_flags & FOLL_FORCE))
 				return -EFAULT;
 			/* hugetlb does not support FOLL_FORCE|FOLL_WRITE. */
@@ -1071,7 +1071,8 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 			if (!is_cow_mapping(vm_flags))
 				return -EFAULT;
 		}
-	} else if (!(vm_flags & VM_READ)) {
+	} else if (!(vm_flags & VM_READ) && !vma_is_shadow_stack(vm_flags)) {
+	/* reads allowed if its shadow stack vma */
 		if (!(gup_flags & FOLL_FORCE))
 			return -EFAULT;
 		/*
diff --git a/mm/internal.h b/mm/internal.h
index f309a010d50f..5035b5a58df0 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -572,7 +572,7 @@ static inline bool is_exec_mapping(vm_flags_t flags)
  */
 static inline bool is_stack_mapping(vm_flags_t flags)
 {
-	return ((flags & VM_STACK) == VM_STACK) || (flags & VM_SHADOW_STACK);
+	return ((flags & VM_STACK) == VM_STACK) || vma_is_shadow_stack(flags);
 }
 
 /*
-- 
2.43.2


