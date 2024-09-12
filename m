Return-Path: <linux-arch+bounces-7266-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B2297751D
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2024 01:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0056C1F260AA
	for <lists+linux-arch@lfdr.de>; Thu, 12 Sep 2024 23:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749181CDA00;
	Thu, 12 Sep 2024 23:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fIc2P/GS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA351CCEF0
	for <linux-arch@vger.kernel.org>; Thu, 12 Sep 2024 23:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183089; cv=none; b=A0tTSW4LnfipU+mqnj13ov9HPWAlgb17Gib83lOrJ7Kr33i89x3pDvkKu9q8vj/xSX0JYIePZEGuveN1HV/9f6HRrcxp1PMTmFr9vVMCBdXE8TqjvJLSxMUqHIjiWkIN56n1T7168/hmwYHw30fso4kZgWHFzod30+Xtc85gXBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183089; c=relaxed/simple;
	bh=4N65fI+/xmCzFedV5P5kZ1YnMAHj34PISvhhOrSxn9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMgTfgdRmSXLuNENP53WfhgY4M0K8opDxKC7ZOryoZGPQrPkAIXUV9J8dma0kzM2AGd4CvsVrMqON4KWUFVMFVirtaAuYQNV5R+fBqkE+9QijcQEOcUrah+gRDy7mJ+6VBJEX67rsufRwAcb/TMraGhVeGn3gKX471KRixz46DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fIc2P/GS; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2059112f0a7so2639595ad.3
        for <linux-arch@vger.kernel.org>; Thu, 12 Sep 2024 16:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726183087; x=1726787887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBBK/J5ZkF8zw3prIEqqwLEmBIMH3Wf5Ldc6S2vu7i8=;
        b=fIc2P/GShpaB0Td3MsEiH2dbUZI5u9qEg7oguwjOMYcJEDZinlZiXwWLxVLOgQeGvB
         KI6sX8WNFhI/+pXT3F1LTx0RMc2mzzcQKnyKdCu1ZYCz9Zi75PnSt3ui49Qmu9wcZmgB
         s1xiZVmpNe/QdfxTRtzFzZMdtQAsmmAGn6MY9Zgzfe2ucP7Q/VKOrMUUFhfaVGtPUnG6
         jpsem2yE1BxFdYYJ9jsQDgIO0RQRmmFsCGMjfbvYOgvSdan5NKIra93CQ9E9n8ipk6rO
         GfpbZR+XiRvV+uA/pM3igyHkhk5SxFtwwwy1W+Mq5mdlYhhi4gWkzfqd0DwvT+T6tdkd
         Ndrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726183087; x=1726787887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBBK/J5ZkF8zw3prIEqqwLEmBIMH3Wf5Ldc6S2vu7i8=;
        b=LUxqeS4ocqwSIj9wWfZ0yRw1aVVjri7+YlftTUE9k66k9vAFD/5fRabV3Xx3+HJdZe
         SGWiIlGj1L8MPF/M4lyqE89xlc2jjJR2x9LPRaj7FIRyrKBmJbSmPj7vCVo7xUWcsWuk
         bpVEA2vSgi3/cnKxbk+7qqtKkriszihXeIgv6qLpbUbJhJVBDOye1WsRInRvQmNa1Lov
         0SqCJteDyCOkZyvyq4aa+xDZRwkCRcShrkPDj7pDIaNUZJ3vgjn1DE7BIISbvVjmcS13
         p0o2MhKdqSZBrS8N2FVP3d22iV0Oxy3ToYxe4glc8oZ1/cb9YOnnR5s+oAxa8UPpEaMf
         jdog==
X-Forwarded-Encrypted: i=1; AJvYcCW7He1AKvu1KZZknpEqxQnS4TVfT1mjOYTr3rtxSgz4Q3uGAiH1yJBq8k8nvZpYgnXtnMnehT9t/kFe@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ffjiPjWwJ9XuCQ6qYpYIi2xqSZupMiCXeoZKFoSXwEmD7vs3
	vrVpRrbdAWsNafBzdlqdpZDfg87NJ8LSSSdUfW8yrHG1hDwSTrStRI8bia/Bess=
X-Google-Smtp-Source: AGHT+IE7QT3LPeXx/i7CBXip6JfNZehNxjoWUrudSu14L33B4uvstSRbHxig02g+rV2oP6p01q6aLg==
X-Received: by 2002:a17:90b:1c88:b0:2d8:9a0c:36c0 with SMTP id 98e67ed59e1d1-2dbb9dc0f39mr1065039a91.8.1726183087183;
        Thu, 12 Sep 2024 16:18:07 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db6c1ac69asm3157591a91.0.2024.09.12.16.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 16:18:06 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: paul.walmsley@sifive.com,
	palmer@sifive.com,
	conor@kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: corbet@lwn.net,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	krzk+dt@kernel.org,
	oleg@redhat.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	kees@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	shuah@kernel.org,
	brauner@kernel.org,
	samuel.holland@sifive.com,
	debug@rivosinc.com,
	andy.chiu@sifive.com,
	jerry.shih@sifive.com,
	greentime.hu@sifive.com,
	charlie@rivosinc.com,
	evan@rivosinc.com,
	cleger@rivosinc.com,
	xiao.w.wang@intel.com,
	ajones@ventanamicro.com,
	anup@brainfault.org,
	mchitale@ventanamicro.com,
	atishp@rivosinc.com,
	sameo@rivosinc.com,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com,
	david@redhat.com,
	libang.li@antgroup.com,
	jszhang@kernel.org,
	leobras@redhat.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	songshuaishuai@tinylab.org,
	costa.shul@redhat.com,
	bhe@redhat.com,
	zong.li@sifive.com,
	puranjay@kernel.org,
	namcaov@gmail.com,
	antonb@tenstorrent.com,
	sorear@fastmail.com,
	quic_bjorande@quicinc.com,
	ancientmodern4@gmail.com,
	ben.dooks@codethink.co.uk,
	quic_zhonhan@quicinc.com,
	cuiyunhui@bytedance.com,
	yang.lee@linux.alibaba.com,
	ke.zhao@shingroup.cn,
	sunilvl@ventanamicro.com,
	tanzhasanwork@gmail.com,
	schwab@suse.de,
	dawei.li@shingroup.cn,
	rppt@kernel.org,
	willy@infradead.org,
	usama.anjum@collabora.com,
	osalvador@suse.de,
	ryan.roberts@arm.com,
	andrii@kernel.org,
	alx@kernel.org,
	catalin.marinas@arm.com,
	broonie@kernel.org,
	revest@chromium.org,
	bgray@linux.ibm.com,
	deller@gmx.de,
	zev@bewilderbeest.net
Subject: [PATCH v4 14/30] riscv mmu: write protect and shadow stack
Date: Thu, 12 Sep 2024 16:16:33 -0700
Message-ID: <20240912231650.3740732-15-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240912231650.3740732-1-debug@rivosinc.com>
References: <20240912231650.3740732-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`fork` implements copy on write (COW) by making pages readonly in child
and parent both.

ptep_set_wrprotect and pte_wrprotect clears _PAGE_WRITE in PTE.
Assumption is that page is readable and on fault copy on write happens.

To implement COW on shadow stack pages, clearing up W bit makes them XWR =
000. This will result in wrong PTE setting which says no perms but V=1 and
PFN field pointing to final page. Instead desired behavior is to turn it
into a readable page, take an access (load/store) fault on sspush/sspop
(shadow stack) and then perform COW on such pages. This way regular reads
would still be allowed and not lead to COW maintaining current behavior
of COW on non-shadow stack but writeable memory.

On the other hand it doesn't interfere with existing COW for read-write
memory. Assumption is always that _PAGE_READ must have been set and thus
setting _PAGE_READ is harmless.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 30fd4874e871..3e05fedb871c 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -415,7 +415,7 @@ static inline int pte_devmap(pte_t pte)
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~(_PAGE_WRITE));
+	return __pte((pte_val(pte) & ~(_PAGE_WRITE)) | (_PAGE_READ));
 }
 
 /* static inline pte_t pte_mkread(pte_t pte) */
@@ -606,7 +606,15 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				      unsigned long address, pte_t *ptep)
 {
-	atomic_long_and(~(unsigned long)_PAGE_WRITE, (atomic_long_t *)ptep);
+	pte_t read_pte = READ_ONCE(*ptep);
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
2.45.0


