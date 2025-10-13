Return-Path: <linux-arch+bounces-14067-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E38BD672E
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 23:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99CEB19A0B83
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 21:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B2130BF74;
	Mon, 13 Oct 2025 21:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Vi3br7Ww"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642A330BBA5
	for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 21:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760392579; cv=none; b=PqI203yG0DEipDNLDEcXxhKnmjFCS3jTeVnlqa2S/0C+ox83OIP6zyVSolVVsBLkZGXMCjcfu+nqLOaL3083UJV/E1lRGF/6SVod9JzlUmuoCI1+qn5B9JIYysJhtpbERqNGzzTmFZfJPh6kdQl5jawbReUtd+Xpdo8h4YLgqog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760392579; c=relaxed/simple;
	bh=hYnrlxG2aSy5XgBcW07Fd+5qY0pd1xI872KUOKzj6JI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FQj63JZOKQvyTzS9FyJd0ZhrCP+Qu15PSemffn+lWmM+8XmGkKWPKC4rfLO11PeFpY/QK7JOA9SWZrBOJ11FhCfoTZRQp5kXKlf8JcuR9yYizBwMJqBI8N7Lx9i0boxhGhXlRP753SgMQdI/BjqUnVMV4zP6w0sDxJDfF2cbfJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Vi3br7Ww; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3383ac4d130so3988991a91.2
        for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 14:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760392576; x=1760997376; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aU5JHaPOPUGgukhD3bad891ElerIE5ocm+VeTPJz1C8=;
        b=Vi3br7WwzMwpAfRdyOpvqLk6q5pnTd14mfZTyVI40X1YgUsZM2MRQWyqQxYySZg9Bf
         jrYUbcU6yVxv5/HI9qljEj5qSMm5OYputLtmtazb9f7i+eQ39qi8bNS+BAy4Vfxa+YmD
         nyydpvmai2inpJYYebsI2spnoAUQq05Q3z1WjK2bcuqBXaVR4lWRomPWifCTnueKAhyD
         DNaUAWeoccXdlyiSv4b17tV/2BwkE6MLL2PbwEoGIYgyQZyp2EPJqSOpWPGliae8WZgl
         ZmldrxCpra+GyIAqxNAqj7QDSflG2gq18KYC+Twxyeqyb+MFlyrsQW8mbmbk8gaHq10N
         s7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760392576; x=1760997376;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aU5JHaPOPUGgukhD3bad891ElerIE5ocm+VeTPJz1C8=;
        b=ZHNE2j0yVOGSTS7IsheGS0gE2BBTFY1mpky25s3T40Xga9ooIw8CBf5iJgFQ/fb5WH
         y+jFEX0OxzNtA4IrsCHbhEaPyoYQnfm6Z1GAkC0m7lOdQ27xqcgjCZTltORGAL0wtXWe
         /xL19r0rfwbJB1ZdjckXolEZlmmRN4iBgGEtaxi1Jzxd2B82IQlfleThph/ypWewsaWY
         vHbpD7+Knz4CD3+7Kza2uRMBz7YJ5r/sjbhgG7QWynQ/LIQ5AWR1Vcc3u7D93XNxGYkZ
         4YnYhL6ahvadBRPBzrzf0LADMS4E9HWdjH9VUyldZQ21CW32EZnHOGocOXG512rhs+WX
         Qq1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCq9wxL0nk1WdP28MyeAX+A0EQcQ1yQpe1WMI1Xle4j7CU9WRW4ITkAJ4MdNwSeRV/8ZRq3ZfUvW7z@vger.kernel.org
X-Gm-Message-State: AOJu0YyME/nSQwj9zrc+6Y9qyRLfWzpSivqkb5BjLuvMJqATk/wpC7VX
	N/I83c6xrn5tEX7duvkuw3PbZCy1F6cdt0liJjl9/Wg5n9P380RTDHNLByENoctxkGo=
X-Gm-Gg: ASbGncsCoqgccfbkz83GKnM60GIzeG97tzbeUvDEb15QpUBEM+C28dcnmOYNBAf85Wc
	tqFIEiI48msxnvofyhaNnEQ1u5s0QZ8XnPvjhNGHRwDsoLY3KjqPXIdQXv/vf37gl7KnVFrbqsA
	13DwGAtZJg3bOUcI9ucachRXw29TiW7ELjP5AgDQk9zWlp8qXzQLUn5XuB6QdPNHV2dkcJ+s4zh
	u74Ybu/Qtgr6N+zwmNTswin9FPt4fMSM9F+Ofrc/ChKaC1pnGXK1N4PMD4XgO4007ps3SlQgXgc
	Nk+VspNRqpDjn/6JClfOenmRngjPeLbtjh4UunVb+WSvr4O5/kbHxaQMRuTMBqNxecjNSJGQw1C
	maB24YBR0Z1Gpp/x7KUf1Xp1/envxsmfm0MywIrEpNF1ksJIGgo8=
X-Google-Smtp-Source: AGHT+IG0kvBEZL2UesWt3Zf4jl6C+rIEnaQvMgWf27eK5kYtzg5PKWU/1867wQV0n3ggQ6xsWgb06w==
X-Received: by 2002:a17:90b:3512:b0:32e:345c:54fe with SMTP id 98e67ed59e1d1-33b5127ac29mr31362526a91.20.1760392576576;
        Mon, 13 Oct 2025 14:56:16 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626bb49esm13143212a91.12.2025.10.13.14.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 14:56:16 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 13 Oct 2025 14:56:00 -0700
Subject: [PATCH v20 08/28] riscv/mm: teach pte_mkwrite to manufacture
 shadow stack PTEs
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-v5_user_cfi_series-v20-8-b9de4be9912e@rivosinc.com>
References: <20251013-v5_user_cfi_series-v20-0-b9de4be9912e@rivosinc.com>
In-Reply-To: <20251013-v5_user_cfi_series-v20-0-b9de4be9912e@rivosinc.com>
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


