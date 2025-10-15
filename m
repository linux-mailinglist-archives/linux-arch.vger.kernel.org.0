Return-Path: <linux-arch+bounces-14131-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D9DBE0102
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 20:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA3753AE3F9
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 18:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C367434167B;
	Wed, 15 Oct 2025 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="AfknOSdC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01BA340D99
	for <linux-arch@vger.kernel.org>; Wed, 15 Oct 2025 18:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552043; cv=none; b=Ne7e4ALSHwOvfO+JK2Wz22mE/0AzoNmm00b8eWbQ7ox934DgrXBzmDufU2bt57Noj8CgqCCF4hoW4BGyY/ZZVbkpNmTi9URkscc/vNe5X6wLPfnh8vPiq/URXfVhXA4gXs2a9F5rBuUSYxHT4dBbxgOYC0Ea3CFaZwvfZm4LrRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552043; c=relaxed/simple;
	bh=hYnrlxG2aSy5XgBcW07Fd+5qY0pd1xI872KUOKzj6JI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TFyDjG5LixwjOYyWgvTtJcNv3AU0ZyvgzOyhbRmNhBQZkObl2pKa8veSr7lKfqCW4AwYhEoeBEAzcQbYYkKX3R9oeLz35wDwobxu4uFv8/zIJJcJkPdd+EPbC5Anmm+IFkyJrYKGkIqQZm5XL96BEdYaZ+LAn3uiY4RiUqUuA4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=AfknOSdC; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29094f23f56so2933495ad.2
        for <linux-arch@vger.kernel.org>; Wed, 15 Oct 2025 11:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760552041; x=1761156841; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aU5JHaPOPUGgukhD3bad891ElerIE5ocm+VeTPJz1C8=;
        b=AfknOSdCaK8DQzAEPmcEmm8+o6fNUlnV/xC2BDdGZ/qV9O7pWrFbe8cfvfj1hyD9eX
         uVqVnB+1oVh5VC5KRY8Rxr8K7LmLvtPt0FjJ/OFadw4Fg53jK76I11ABoZApqV7iyicV
         Pt1fLkheRoA3OwFWRgT2oYyZYsb4DnM3ppXiJr9kNOp1m0SUQyDOyiSAKfuvYAfaI2Vi
         598jPuu+pf6petabMGeu+LWfsto/Iq0ZvKpwly8ofMIcsfQC+Rn1wfYidYyOPhcNU+8I
         tnJcRnEom4/aQS3I6QOa45oYjms+lR3P96D8uEFGsLqC88X+Cc/M92rsbLqB6ofU32Mc
         xqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760552041; x=1761156841;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aU5JHaPOPUGgukhD3bad891ElerIE5ocm+VeTPJz1C8=;
        b=lI6gHIKxsAL69koU2JwfwooUWbFzPlyi/wNQbPWfzr5xWOGTKfYGUWJPVWtdduMUNp
         29iNHYeGQFfMfAJSFLLSGufWcLE3855Rs6nUf6zuQ3i8veIWMofV0acPIo3TkxykKO2Z
         oLH1UWJ550Uvl53dkiF8TLR9i5RgtfZBQdCaLCBzV+8zVFrt59+xqer6sj6GhB9vO7JC
         Fb1wQ5djDOK6A429fVflSHh2wVAfnnFvtmTjCEUL17Fu+kMqPtNTtTddr4/zRFYFD5yV
         vq5oSJ9wwjkPEkX812G3n5/ogrAB21yuKMsjw2kFnV2akaWm6wX3kcugTKKOo0OX72xE
         q/Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXuPXY6U1OnPgEZ2HpcoeE4nsFRFxB9o4ZFzkNNMCA1pPFFtASFk9WuGhIDIgtVKQ3va+qlR5NrdSqE@vger.kernel.org
X-Gm-Message-State: AOJu0YxLqLSCKIT0hNln71N0w3ICr31g132+b3Jxj2x/8w/jXhOZSXHs
	iB30cx/eKh60I9CAk52vxNCvGzohkEfUu3ty1Ta2VBCOV1akMyznPE9/3B5wA79YBMk=
X-Gm-Gg: ASbGncuXNvzPxovC9ej5LXE2dLAFeJ0SwjVeP2zQqxluvuvKmrgN0M3m1TrP5UarC6q
	qc/Gi8MnatmRHfCVPMFsdsRDz59vtkwgAsptMJKayAJf7CEUntsD+0D5ten6cR1SM406BFvokyy
	4pqYNDKCxi+fs/SfGiOvNw3DBiWFcg1rpYGqqVLgS4R6s8k2h1W3bZzt1uPK52PM+V38+MWwEvq
	hh5KOLAp3vmCRTPI+pjb3CRk/JjWNZcrZx6oyr8Wjkxarnm7O4KhX1+iwDQ/3jdn5JH6h43i2kE
	Dqa0XSHoWWfzHmnN1vUEZzgRYAZuh8IRoCuMooATsSIERmwywtpG/umy84jQ6aIGHXz1okWZdHP
	NxBtNktAcbpvE90n6kjmGIKZB6qoSuZQreUspLt+cI7bfyiIM05Ck1r+QeOlujA==
X-Google-Smtp-Source: AGHT+IFrOG3ULzvwQS6yNdWhBAVzXbLv96KEjuoxMPCKu397hcHmuMnjPrfbwr8q4JTAGI3XJs0nvA==
X-Received: by 2002:a17:902:e784:b0:269:ae5a:e32b with SMTP id d9443c01a7336-2902723eef0mr366261105ad.13.1760552041166;
        Wed, 15 Oct 2025 11:14:01 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930a72esm3126625ad.21.2025.10.15.11.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 11:14:00 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 15 Oct 2025 11:13:40 -0700
Subject: [PATCH v21 08/28] riscv/mm: teach pte_mkwrite to manufacture
 shadow stack PTEs
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-v5_user_cfi_series-v21-8-6a07856e90e7@rivosinc.com>
References: <20251015-v5_user_cfi_series-v21-0-6a07856e90e7@rivosinc.com>
In-Reply-To: <20251015-v5_user_cfi_series-v21-0-6a07856e90e7@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
 Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

pte_mkwrite creates PTEs with WRITE encodings for underlying arch.
Underlying arch can have two types of writeable mappings. One that can be
written using regular store instructions. Another one that can only be
written using specialized store instructions (like shadow stack stores).
pte_mkwrite can select write PTE encoding based on VMA range (i.e.
VM_SHADOW_STACK)

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h |  7 +++++++
 arch/riscv/mm/pgtable.c          | 16 ++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index e4eb4657e1b6..b03e8f85221f 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -420,6 +420,10 @@ static inline pte_t pte_wrprotect(pte_t pte)
 
 /* static inline pte_t pte_mkread(pte_t pte) */
 
+struct vm_area_struct;
+pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma);
+#define pte_mkwrite pte_mkwrite
+
 static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_WRITE);
@@ -765,6 +769,9 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 	return pte_pmd(pte_mkyoung(pmd_pte(pmd)));
 }
 
+pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
+#define pmd_mkwrite pmd_mkwrite
+
 static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 {
 	return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
index 8b6c0a112a8d..17a4bd05a02f 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -165,3 +165,19 @@ pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
 	return old;
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & VM_SHADOW_STACK)
+		return pte_mkwrite_shstk(pte);
+
+	return pte_mkwrite_novma(pte);
+}
+
+pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & VM_SHADOW_STACK)
+		return pmd_mkwrite_shstk(pmd);
+
+	return pmd_mkwrite_novma(pmd);
+}

-- 
2.43.0


