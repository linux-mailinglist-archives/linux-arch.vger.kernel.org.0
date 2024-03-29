Return-Path: <linux-arch+bounces-3291-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D828912B0
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 05:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21BB51C23D90
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 04:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA8044C71;
	Fri, 29 Mar 2024 04:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="G+da6zSF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD9343AC5
	for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 04:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711687588; cv=none; b=Lwrs9e1PhJqNrpgu5Py203ajjcMUslgbJCB/1LG4pZt+ykG+21UBZP+dKE+CL5S92fii3PLk/ejCrfvnCvHA2hV9O7Yh9YQKH+4Vupv22ekmiFOJygZQBhG5QZyvl77Tuwu+Kh4YIFnY58U0zI9BSlXzCB2LMe8LRSoIEWbfEcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711687588; c=relaxed/simple;
	bh=7I6zjgCFV6RndlqIEMECkC47T7n+mKP10TbnVazBOuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UwmWp1H/etYy8vNFYgmFdiJZyI/pJkF5iRweeNA+yFGVqlZRK79Mbxdkon7jJj0wKHbKd8sB4rdf6FRSpNIM4ooaEU0NWhJvZarUVBR4oe9OyDNWWo8BFvdfaAVxDm00A5i+qYF0bqW6WzRLq8dvvzlif7+xGQ7h95XRibJ+fro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=G+da6zSF; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ea8a0d1a05so1782290b3a.1
        for <linux-arch@vger.kernel.org>; Thu, 28 Mar 2024 21:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711687585; x=1712292385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4XcZbT52YyPYTbBbJHKVVBDZyhFzr+R5No8SlxzOH0=;
        b=G+da6zSFsHX3UgMCnG11T5CqVbMdBqvSGEKLyoidUP58R6vsbI1gMyYb/rtXlM2x9q
         lZAKpMspurfr8lRn6e161UQqgfdMQyR74oHnYHGkIPKJ1eDg+ptyC89pvYJDif1tjY07
         zVpzy3pbA2OY8Lho+HQKIMnqlOjYIiy4yfu5KoZGlYV5rR8sKGfJO3FtZJM6oPtpgagH
         ar3Y9RSmkhZ1MDj3WQ9W5FGmjHJkExpho21JWRizYDLizvJ0kZoyN2Po8sXaIH2AyWyS
         9zMlMXDoGeQI/zr3yYai/EdmoJfrA3dghbi9TE5MkltPhYtSxbnpsmr89a+J4MS2FEqe
         hByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711687585; x=1712292385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4XcZbT52YyPYTbBbJHKVVBDZyhFzr+R5No8SlxzOH0=;
        b=ouDu6N2xaFXsAMHfncIb6/iOT2ja8YQU8U55ayCwvPb7UTrFrriyUWczYEQ9HtEcY/
         NKbarsBiQSq+SjX4nG8sfiptRupviBQMzIRcDJL1feNM+02Xglk4PTmvUgsIIf7wi00O
         hS/DQ5jBTH/Bbc17IC87/p9ttc9r4Ar+bJuEzrcyANdQq0/mmuinI4WWh1jzTEOg0/pn
         sAyhfbQdR+K+gfeZT3z7KDEZP1dh0sCwX/RIwOrRkIIEuUOz5mTj2VSwc0AUcFC/6edn
         pSTw526pTn/ZfMpOBcj1/urIt+UCqmuiPbGn3y6mNNtOdieRlrYYm5M1jgjNWwtgSeIB
         gt1w==
X-Forwarded-Encrypted: i=1; AJvYcCUQ2OCgDHkqCAtjZRJynDfPAb0EvYtv0Co4tjY2SK9iwZGv9npHFaIR5u0nqTBMg/ywxDK580d1e+QZ6GJIuIrL8F9VuZZ+Li1Qkw==
X-Gm-Message-State: AOJu0Yyuj9csmsAD4h5YuHgo5F+FiL3OqA71K14Iji6Pe2k6QQSBJq9Q
	+pBAsFHGu2AnpePCcPcclCz3EbSpk/qOAy7DOimZ5A20muqwP3TjDons3bHcMPo=
X-Google-Smtp-Source: AGHT+IGU4KJtKBTHpZlkqt9cg1BlBHp1APuo4lcElwp7mwPxz8+nlm5g5TQdTRKqVuVUt4gfjoQ+Lw==
X-Received: by 2002:a05:6a00:a29:b0:6ea:df49:c8b1 with SMTP id p41-20020a056a000a2900b006eadf49c8b1mr2139229pfh.13.1711687585128;
        Thu, 28 Mar 2024 21:46:25 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id i18-20020aa78b52000000b006ea7e972947sm2217120pfd.130.2024.03.28.21.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 21:46:24 -0700 (PDT)
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
Subject: [PATCH v2 12/27] riscv mmu: write protect and shadow stack
Date: Thu, 28 Mar 2024 21:44:44 -0700
Message-Id: <20240329044459.3990638-13-debug@rivosinc.com>
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
index 9b837239d3e8..7a1c2a98d272 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -398,7 +398,7 @@ static inline int pte_special(pte_t pte)
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~(_PAGE_WRITE));
+	return __pte((pte_val(pte) & ~(_PAGE_WRITE)) | (_PAGE_READ));
 }
 
 /* static inline pte_t pte_mkread(pte_t pte) */
@@ -581,7 +581,15 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
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
2.43.2


