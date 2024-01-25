Return-Path: <linux-arch+bounces-1543-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7B383B9D8
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 07:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D989289FF2
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 06:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B342012B7E;
	Thu, 25 Jan 2024 06:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="xuxqjw0i"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0503C1B5BB
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 06:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164191; cv=none; b=Wy2OMxYeK1L4tjwn7SDoBYVpa3yUZyatL62H4Wci7xKowNWYslviAaTv10BJ4a080e6D+YadMxCHW1lsngeClJ3FabSeawv1uhzRSZqgoMHhuweLW7x28DaSeCb+jGcbMkDMmEyBymn5+Wny9c3n8sauCt7VHipmZ+PMsvcuVdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164191; c=relaxed/simple;
	bh=b7csYQ90Z6oxnGYgcETNSZcrDyRQTBIZ6wMjGUl4d3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GuNkbsPuPOd8lhCt4hf8AwH2s54lFLu50KOQPrWhtFVVJtSuKiCye6mwxVa2HW/qBlQsDMrY4eTPbw2WiVDdccY1IHs+BIrVkWzv7dafDbe76ol+q7wvojGVggXYYLmIDqfNRFJw6tj4q/1TjxQ/l5dOGxjx+ZnyTB3a0UYOtCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=xuxqjw0i; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bd72353d9fso5070980b6e.3
        for <linux-arch@vger.kernel.org>; Wed, 24 Jan 2024 22:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706164189; x=1706768989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRzF2SZSpJKrBhoESLsApoQWcpLzxI/TelseFUZAskk=;
        b=xuxqjw0iQnVHKByG+iRb+j4XMO8FMJxJviiQe4ZgKYYf1g10WBQXqFRqO62Y1PfMnU
         +x1DMxAsCdTHKhAg2JmaykCmOBPCSGoNUzYac7Vt8C3sbeOL0/7vptaqV8OU1PvdcYj+
         Hso1QXBs/kf4a7TDGM+RJ2ymLCyw6B7YYguWqzDF0fgrITqaXGKiM99dcUSk5OpSMtCu
         xc920ps+vmTtLnXAmdfA3eVCtZ79G7XGObuavJJvB5J3VJ9FT5n2l89WHIRszo/MqwGG
         Z8nU7zyubzAJn7aE7iCdShKCWf6V7q89HirufQdcZ2RBk74J3yJXEPANsYBSYiMlGpnF
         JfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706164189; x=1706768989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRzF2SZSpJKrBhoESLsApoQWcpLzxI/TelseFUZAskk=;
        b=TQT0esyyQ18jmyDHKe57rstJuChoaFVhwECHVy9RMOghAoy8clRGe5Qyxs7q1CRmAQ
         KWUyDHRS5Xerx09b0JjVUBj+5YoYkGoe4B74iPdJT3OgBggOaEYI0sg/2zA6DaIMBMUv
         6DZjtQAnTAQOlPT1qyJ0aNQYevOqpFzhfVxYRT4a4ssJdIIhzZHiYetan475KqvaukTx
         RUzd+HFvmgEPFIXnkSzZqUCrj0bxqt3RE72BBWKAahdxk/ItK7F6EcEmHbKw/C/vCKbI
         f96wdSdBp+tjTIakviRpXZsIXOvXQfOUeVnPbV2Ob5kOM7b9FqdAVGUUzH9H19o5zX1X
         n9Hg==
X-Gm-Message-State: AOJu0YyQyeT4TAsfIyl4isWLobcjbnuJWkhZcrjKCiRiqmLU952IwGjf
	X7LECTCf/0ZG19sAiOw1M2vrErp7o4f+dR8+FGaP52YKIpz905KFdJpf5gYJnBU=
X-Google-Smtp-Source: AGHT+IErjNQJ/wKFk47rmBKTBBYuOvQY9ZOcxL+k+OB28eXMUoqPg8zllrGghQsiXCVST38v7+Fe9g==
X-Received: by 2002:aca:181a:0:b0:3bd:cc3b:a894 with SMTP id h26-20020aca181a000000b003bdcc3ba894mr464457oih.93.1706164189075;
        Wed, 24 Jan 2024 22:29:49 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a00139300b006dd870b51b8sm3201139pfg.126.2024.01.24.22.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 22:29:48 -0800 (PST)
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
Subject: [RFC PATCH v1 14/28] riscv mmu: write protect and shadow stack
Date: Wed, 24 Jan 2024 22:21:39 -0800
Message-ID: <20240125062739.1339782-15-debug@rivosinc.com>
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

`fork` implements copy on write (COW) by making pages readonly in child
and parent both.

ptep_set_wrprotect and pte_wrprotect clears _PAGE_WRITE in PTE.
Assumption is that page is readable and on fault copy on write happens.

To implement COW on such pages, clearing up W bit makes them XWR = 000.
This will result in wrong PTE setting which says no perms but V=1 and PFN
field pointing to final page. Instead desired behavior is to turn it into
a readable page, take an access (load/store) fault on sspush/sspop
(shadow stack) and then perform COW on such pages. This way regular reads
would still be allowed and not lead to COW maintaining current behavior
of COW on non-shadow stack but writeable memory.

On the other hand it doesn't interfere with existing COW for read-write
memory. Assumption is always that _PAGE_READ must have been set and thus
setting _PAGE_READ is harmless.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 9477108e727d..9802e8d48616 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -398,7 +398,7 @@ static inline int pte_special(pte_t pte)
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~(_PAGE_WRITE));
+	return __pte((pte_val(pte) & ~(_PAGE_WRITE)) | (_PAGE_READ));
 }
 
 /* static inline pte_t pte_mkread(pte_t pte) */
@@ -594,7 +594,15 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				      unsigned long address, pte_t *ptep)
 {
-	atomic_long_and(~(unsigned long)_PAGE_WRITE, (atomic_long_t *)ptep);
+	volatile pte_t read_pte = *ptep;
+	/*
+	 * ptep_set_wrprotect can be called for shadow stack ranges too.
+	 * shadow stack memory is XWR = 010 and thus clearing _PAGE_WRITE will lead to
+	 * encoding 000b which is wrong encoding with V = 1. This should lead to page fault
+	 * but we dont want this wrong configuration to be set in page tables.
+	 */
+	atomic_long_set((atomic_long_t *)ptep,
+			((pte_val(read_pte) & ~(unsigned long)_PAGE_WRITE) | _PAGE_READ));
 }
 
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
-- 
2.43.0


