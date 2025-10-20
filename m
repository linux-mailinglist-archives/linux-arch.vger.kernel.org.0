Return-Path: <linux-arch+bounces-14223-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AA7BF38C5
	for <lists+linux-arch@lfdr.de>; Mon, 20 Oct 2025 22:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BCFD4FDDD1
	for <lists+linux-arch@lfdr.de>; Mon, 20 Oct 2025 20:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0951C333751;
	Mon, 20 Oct 2025 20:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="crbd1l7h"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4519333737
	for <linux-arch@vger.kernel.org>; Mon, 20 Oct 2025 20:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993633; cv=none; b=p1Yt2MhQxr/vqBS0k7M8bF6BI8WplThH63CTNKwZ7/J6F13apTposbiDuaRWyn40/kIgb54HdOnjWUxC9ufuS7DI32Jv74NaUJfLTIYDGl1i/OzuOsbEqrecEwg8mNTMlAIwk1m2XUJhyXBTWqGST2UOkKQvPQ5o9Hat7+mxu4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993633; c=relaxed/simple;
	bh=9AtWvDKQ9q5op9YLRgkrDiWaHEAhrRbEgloHu05lQww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EAVFtKUHhFwgoypQztiiTQIZQRjrEa5u0jhjyyOPF6xxxbgtq3Utq4f+ZmmRPV+pllZdK807c+NPgPcDn+BHcwxhbCnhH0BzpPj6qchHan//Ud5b09zAXeQsLRaxpoPzlUbvzBrZiT6XdaxpacITjlOQj9hzoSAIa2+jGdBBVac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=crbd1l7h; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7a226a0798cso2836483b3a.2
        for <linux-arch@vger.kernel.org>; Mon, 20 Oct 2025 13:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760993630; x=1761598430; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oeDKcuIcO6+2FhxyceVVS2WWiuktyVdq1WpyUni2wlA=;
        b=crbd1l7hj83HVBsdtXuvzQjL1uuAYwffs6KAY1iIEUqnMfXZ2RzDJA66c/Yg/6c2p5
         3oDphni688aLzx4rCr1Tb8tNbSJfNEqR81ilr9l7LTfcK+ueJQDpxNVl/j3E9aklCBxp
         P/48WK6bnN5kOi3SjzPZ7fKr9WzqaEmBPIHZx8H0/Xsy+12GNXCdfo/ymgN3TOsbiOo1
         8sdPuCLb7DSHej6chTQqKkvtKqA3QG8DMUcEQT7a1kXkN/6Aq7Udv9X1dr1d1J6opY7L
         9tWRYVKRdWsDbrdQstNM4vBQ19laKAat8XKKOpMMCP7BLV+dRQwCxOOrFe9X7KSiqevp
         zn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760993630; x=1761598430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oeDKcuIcO6+2FhxyceVVS2WWiuktyVdq1WpyUni2wlA=;
        b=aYaUkzfw6s5EiqB87p1172CPjlEPJnmTt9etTwHMDKF9A7kFBUZh9/4M3bha1mapf0
         9NN8JyM0KE08FR6KgCm8KeE0Al0buvt1knwoXnwHpUtpjkZAyRssLS2RNtlv2oHEDOpu
         kVfA6axV9L/CnaMjwNlHtZRL3qWd4XEhFvpnVX8w295FeVk0kG16iSiow7ic5bIDw/wc
         ohX3l1KV8LukhT1MJljUmev9KsWWtthwO03gw1hUv77oc/D2CA1Fya0hxoDK19FMMLIj
         PJ8lrO6P0SjZKCB6upEBahkUNdgoiLoB6FCE3JMlE4vN7PNQhs+NtCqwaDtjBqvZECtS
         agPA==
X-Forwarded-Encrypted: i=1; AJvYcCUtyuSnbDbxiR83EZLwi1Q0qd1D2DnfqNQuEmZ2qXQ82ZjzHiIYmpiTzcJ+ed+LNGDJAOL3NmSzI+BS@vger.kernel.org
X-Gm-Message-State: AOJu0YywtKl19f6FYUmMQMdXYA3jxb7RRWxHi9HhIsxhBer/3xCXZRtI
	uNElnCi+5YirXgVm+qXVCYrWU/1FeeqAXGemCmORpNe/QcrYW2k8VNaBYVEvGOzKba8=
X-Gm-Gg: ASbGncuSt/8CY5LMaTvdFJvb2bx61fcrI69cuMm0vfQeyGcS43JJNN6DTnDeuSaVIF0
	kMayqTaE3SWRzQWVHUvC+FK03cysAYd7emcvTKriUXZICcE70bSJRdryra5syG6MC92JjTgFRk8
	PbKbHt5TYStS4VWOYf+T9MOlVQjj6uXomMDrJCMzdToJKkJ/KG12SdhdU0oKqyCCVQ0iW/Yxwq9
	e89PYPUSA01LY8mBS2VPLfy9AaAtFDt9wVf2MEMmAa/3XMM6KmT5m6ql4gGSczhM3CTxcPpjukU
	4pxxTx/31Lno4GRsmWj21uw3+wHmfqv+o9YhdUV94zjU7tdZReP0iGdZ8jvIDGeprLDw3NTE52W
	ChSDT3vLSYh1Tln3gAovwesucQxdUg2GuwJ+snxrYvVBQz/jm4lk5aKogsr4NnfPpsm9/5yc1EO
	exZ4+oxwcQmYhLr9rMH2Pd
X-Google-Smtp-Source: AGHT+IFyzyRYR8N4pw/RqABJpFBkHAgssztpR2AfShjzj8U9HBjqzgn01yskrDk53sXzLiQsCgAq5A==
X-Received: by 2002:a05:6a00:21c4:b0:780:f6db:b1af with SMTP id d2e1a72fcca58-7a220acb6a1mr17244647b3a.16.1760993629790;
        Mon, 20 Oct 2025 13:53:49 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff1591dsm9453867b3a.7.2025.10.20.13.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 13:53:49 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 20 Oct 2025 13:53:36 -0700
Subject: [PATCH v22 07/28] riscv/mm: manufacture shadow stack pte
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-v5_user_cfi_series-v22-7-9ae5510d1c6f@rivosinc.com>
References: <20251020-v5_user_cfi_series-v22-0-9ae5510d1c6f@rivosinc.com>
In-Reply-To: <20251020-v5_user_cfi_series-v22-0-9ae5510d1c6f@rivosinc.com>
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

This patch implements creating shadow stack pte (on riscv). Creating
shadow stack PTE on riscv means that clearing RWX and then setting W=1.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 4c4057a2550e..e4eb4657e1b6 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -425,6 +425,11 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_WRITE);
 }
 
+static inline pte_t pte_mkwrite_shstk(pte_t pte)
+{
+	return __pte((pte_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 /* static inline pte_t pte_mkexec(pte_t pte) */
 
 static inline pte_t pte_mkdirty(pte_t pte)
@@ -765,6 +770,11 @@ static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 	return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
 }
 
+static inline pmd_t pmd_mkwrite_shstk(pmd_t pte)
+{
+	return __pmd((pmd_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
 {
 	return pte_pmd(pte_wrprotect(pmd_pte(pmd)));

-- 
2.43.0


