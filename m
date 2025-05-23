Return-Path: <linux-arch+bounces-12093-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73111AC1C07
	for <lists+linux-arch@lfdr.de>; Fri, 23 May 2025 07:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE4F3A2182F
	for <lists+linux-arch@lfdr.de>; Fri, 23 May 2025 05:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED1D27146B;
	Fri, 23 May 2025 05:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dVyi6Rbp"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F7C271453
	for <linux-arch@vger.kernel.org>; Fri, 23 May 2025 05:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747978301; cv=none; b=RidkeAea0JGleGQCP8CY9VTKepXlljKVqAvaxhO0aBTnnIRQiLrSkduuQJHT7isFBzGSkeyPqamFSUo/r/+r9dk28wQxBUxUmL14EKpX4Ot8T2fJudt/0bZHvEldHQW6YTlbmTQFrI/gadU9qgq7ZT4CnWBRmL+2dezGn9AWohA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747978301; c=relaxed/simple;
	bh=botWNQij/L5jZa9ComPdhZ+E/aGmcXy6ciNlZPypsCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Axtk6cYOEZqBBRbzvgtV60JrAB6sqisFsAISLy/AOes6ZMyktypoTiF+BXgVE1U6XdD+c0E9z4olN6XbWUB1lktdncgWn2cliqcpSKYySW3FyX2GLPu6VlkJnVic4F5HNiyNUdIcpl7ClETkikjFfY3ojzH6T/qDco4ol3LXN48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dVyi6Rbp; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-742af848148so5285562b3a.1
        for <linux-arch@vger.kernel.org>; Thu, 22 May 2025 22:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747978299; x=1748583099; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIAdpVF04Dq2IgOKnxPyubvKXBbe4mWx866NZtbwafw=;
        b=dVyi6RbpFltRyth55+f+zEEFCmn8zXBoCh8nCNUDUIkwZBVn6mIABe1DxNwTHVsbgA
         5W8qpVMPG+wnaXRcTba6X5wM9ugfmshWMlW2cHFG3N+Z/IhD4Y/2gfGyXgOz8Z4Ux46c
         +qadvfALYbns45OT08srypI3grvG33c5ced/b8+ypn1lRBCLq8q0wapCeCGk4z3eDSkb
         Cm7ov1WEyYpexsgo2zKQHkLgUar5GYXYAZh40/XG33ZzUQlnSli8evt7JKHut9Y/a2dm
         i7Pt8RmIZKBksvoa4xNojJFxMgdlGwebmna2OgfOfSxRO9v/zfOW166xbO0GxSiOftcJ
         PXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747978299; x=1748583099;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIAdpVF04Dq2IgOKnxPyubvKXBbe4mWx866NZtbwafw=;
        b=RHW2xF+h+JJbO6RPM+N1gRK171CZXJjay0GaylSWx47/ANdYS4BuB/uH84FDyIb3Fg
         czqsJUeEqJYBuSSSqjz7ml9vdVQS4aXv7b7Abc4aSPtdUkBa05t8LDUgg0hCbSmK5MOC
         kXT5Jl8Xd7SEUg0rRA4cYrRGcWiTHE2Ogb/xwkOqD8fpAkG2Piqa5xqFcWyjdqaHQ9af
         S9Jj+MmrGtgM2u739+fJ9uOV191hP4Q+aY57jlgfcwb4Ix5LwDkL4HMAmw+1YnpZC+zO
         JmBnzbdp1iwDyhPJ2dwLSiaBhlDD+dlCpqeyWXKl7wASVsN0grnTRepR6UL+dz6tLoVK
         fjsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeywSG87XawzoTUikgwp0wfzi5MO1l9qafwxrN02dQH8gn9SNrpjJn88Sode60sodu6Hen2XXVbFqS@vger.kernel.org
X-Gm-Message-State: AOJu0YxUP7u/tNTr5hxDUbVRqwRY1v/LmjTqVQxscY2rtiXHzIXZZLFn
	8yf+z7mLjERryJwJAyULPOx15JivvDbkOSrizIbBLT/fGSNitaQTbpe25w2Dl7QeUdc=
X-Gm-Gg: ASbGncsXTom1lev/dnjAblhEERbiU8/1j6mBP8w9BV2RasRSYa8qXVfm+7felWq4FfT
	tYQ+Kj6+2yDv4JtC4ToXedDUk/FPAiiGBy3JfaWJDXStDsf2Q9APFk+Fx5VTt5xwl8PW4ZZ297Y
	C1Cw56OWHxMpWU5q++/TdMmlSbynF9HLeYfIYv1hDylWwJrzURpCjXrNFLqPFSbBfLPW0AycGOT
	tvOGR1hfKPMSvwUhrquAMm2znBaXZ8dDZ0/5CaMxWPj8LtxFdcJFi0CLFNXQX4Rg4ye1s2dBvwz
	Hpqvf4o8MJuTlnl9SCD/i3eSGRV6sKgtD8eFVbCHt4NfJamX3xSp0pQaycTpUw==
X-Google-Smtp-Source: AGHT+IEqqbbYW6BfuGslnbv1XZjKBqrXHXdbK528Ztzva0n5EWuU2uAXzUGqp84UVkK4Ta38abk2wQ==
X-Received: by 2002:aa7:8890:0:b0:73f:ff25:90b3 with SMTP id d2e1a72fcca58-745ed90b72bmr2802658b3a.24.1747978299213;
        Thu, 22 May 2025 22:31:39 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a982a0a4sm12474336b3a.101.2025.05.22.22.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 22:31:38 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 22 May 2025 22:31:11 -0700
Subject: [PATCH v16 08/27] riscv mmu: teach pte_mkwrite to manufacture
 shadow stack PTEs
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-v5_user_cfi_series-v16-8-64f61a35eee7@rivosinc.com>
References: <20250522-v5_user_cfi_series-v16-0-64f61a35eee7@rivosinc.com>
In-Reply-To: <20250522-v5_user_cfi_series-v16-0-64f61a35eee7@rivosinc.com>
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
index f21c888f59eb..60d4821627d2 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -428,6 +428,10 @@ static inline pte_t pte_wrprotect(pte_t pte)
 
 /* static inline pte_t pte_mkread(pte_t pte) */
 
+struct vm_area_struct;
+pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma);
+#define pte_mkwrite pte_mkwrite
+
 static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_WRITE);
@@ -778,6 +782,9 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
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


