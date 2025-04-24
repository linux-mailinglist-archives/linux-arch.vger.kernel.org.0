Return-Path: <linux-arch+bounces-11530-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00741A9A35F
	for <lists+linux-arch@lfdr.de>; Thu, 24 Apr 2025 09:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8AA11945C11
	for <lists+linux-arch@lfdr.de>; Thu, 24 Apr 2025 07:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E174208997;
	Thu, 24 Apr 2025 07:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nbOHAEA9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622EE207A22
	for <linux-arch@vger.kernel.org>; Thu, 24 Apr 2025 07:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479249; cv=none; b=j20LIn2VGNVKUBF/nhXXOYRGamjlR2Of6KVzL1qjvBUsSQbZgT3djeMgTU9WaR/8NRbgfFzV7ka4/YG9VUQTWYJhuGt8MYYmMHQieshNUupjz6AgZjcOTqkIV6rvaVqL7aKYWq1UOqjeMzcaVbLd1CuwBzeEUpsTELx6ugp3TaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479249; c=relaxed/simple;
	bh=v0FhAahB+duYIk/hRzzymYIP6H63IhRuqMQn8myLUBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iddaRPkZDVIPyEu+x0Js0FWafzaR2jGEYlREU4T5KSgpmSHpZYh+ZBYtM+aRDJ9kakCcxeWIJnM7h8DOFCf6K18ROJbeIJR9oHFt3EvdWFbU/f39v/VVbsx03EjdY9ezh9PuUvhtQFxpB4/kC4SsFxkapDjdkj0A0quCpq5SkHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nbOHAEA9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22401f4d35aso7883945ad.2
        for <linux-arch@vger.kernel.org>; Thu, 24 Apr 2025 00:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745479248; x=1746084048; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ylYFmVRjBQGzrdqcn0JjhMraiDjYmLqBMrzaQkDTLs=;
        b=nbOHAEA9kkVtcPzENpnOz33i8q1/SegniPIQzU+Ufn1Fpui+DtmjOysVTgCeYPdhBx
         3gdzkjlIxOwo923bG539rY1GhStgMGqr4SQCDpF088c2nTUffyuub6zreme9KF7rWq38
         eBdd2F8lPnXw9fmTF8M2rdv1tgfn55SQEpJLT5w9lEs3+bph7ymts3gITcvA8eMGga0/
         lpTbYCaA2AIU7RaIJPn7h590oxgC7Uczh6IrCNSmidSARNPRzZ5UZrLh58Rh4TF2a7Sw
         +PkEDRa1fONdHbk7gNy4jIJgyVCmcM6CzQ42cEdZt2lLdmDQhwWU+7YhV7cn7fhD6FMb
         kv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745479248; x=1746084048;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ylYFmVRjBQGzrdqcn0JjhMraiDjYmLqBMrzaQkDTLs=;
        b=P5/b3fCANcxkYgZooPO+n6uYq35C7uwSatZFGws2/G+1RqJnFuA5qOjBt/yl7INwje
         V7y3qfHfEVtYwQPozNrvDyDytf/l6nwpoaJX6Es0Qssn1xmk4FOtFINkaPl9Cx/8oKU6
         /AICKdxvoCkx8F+Ti8444nJrLSHEClNIQFGXnpixRVKDhxiymb648EQlc9nbVK+PQRsw
         sHzKrSdYc+Km6TqHNku5isyOT4t1p7ivXqL6RAtqf3T1+VogsdlLfTMg/nquAYYn0Xkd
         GTQPbxePiIoDlRQcgDXlQRdcU/6t5p9qsTSLX77Q0trUJqh9Xg8Y4m/cAyUYi5xe3/gw
         SjSg==
X-Forwarded-Encrypted: i=1; AJvYcCWMs355dGpG0N+WB5Kq/Tp5MyQR+y6m769Nv3xU6rXzIa2anyr1oB1WiCG9h8B+XLJsrPvWeTHZhSJi@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpjb483v+KwqaoovdSNG1D7t7q/NClZSgTRD5dG0KQ38TaDqtC
	FReVX8FiGYGHESKMCuhtgx1PLAGosjrhEkgI7CGk/HB6atW41XPEeZpimVKigKs=
X-Gm-Gg: ASbGncv+SRocPut5+EnsPItWPAzXZUmNE+dJov60QFP3/SeIG+rQs+4RXf165WyNj8Z
	rv3RiyabqbNbiw8mF5lXb6WEkH1/6u1LnlpdTMJC2CZxnQHi6VE+U1aYr+PB+w7h95M8s2rYoJm
	XDJKnZpozF/DXMKblZTo2DRAWX/DZghI1QW4zJr8S3dg1DVyeWsvQkw3viaApsUYD/vfE231gwu
	xN9c553iFtHb7C/O+2BrboykfgTTtdopmMCfIXqIl/3cpKwGxWpYkC7xcM6jQQhU9EMsMVjs86n
	6NCRp+cIml/fZGEC1MPS6w9z3NoTVA5HXqFvyiUkQzfpti0So9aBs7gjyeu7mQ==
X-Google-Smtp-Source: AGHT+IGjkr4vqGGtTUfWepy4/KRfgzZh10ROLBoP0JZSEZsJlQI5sONvd9/5VHsjRNPTvbU04z+xfg==
X-Received: by 2002:a17:902:f608:b0:223:3396:15e8 with SMTP id d9443c01a7336-22db3c0ec76mr25062265ad.22.1745479247872;
        Thu, 24 Apr 2025 00:20:47 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52163d6sm6240765ad.214.2025.04.24.00.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 00:20:47 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 24 Apr 2025 00:20:23 -0700
Subject: [PATCH v13 08/28] riscv mmu: teach pte_mkwrite to manufacture
 shadow stack PTEs
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-v5_user_cfi_series-v13-8-971437de586a@rivosinc.com>
References: <20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com>
In-Reply-To: <20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com>
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
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
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
 arch/riscv/mm/pgtable.c          | 17 +++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index ede43185ffdf..ccd2fa34afb8 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -416,6 +416,10 @@ static inline pte_t pte_wrprotect(pte_t pte)
 
 /* static inline pte_t pte_mkread(pte_t pte) */
 
+struct vm_area_struct;
+pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma);
+#define pte_mkwrite pte_mkwrite
+
 static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_WRITE);
@@ -749,6 +753,9 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 	return pte_pmd(pte_mkyoung(pmd_pte(pmd)));
 }
 
+pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
+#define pmd_mkwrite pmd_mkwrite
+
 static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 {
 	return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
index 4ae67324f992..be5d38546bb3 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -155,3 +155,20 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
 	return pmd;
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
+

-- 
2.43.0


