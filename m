Return-Path: <linux-arch+bounces-14068-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DE5BD677B
	for <lists+linux-arch@lfdr.de>; Tue, 14 Oct 2025 00:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F3944F8DA0
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 21:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE5730C36F;
	Mon, 13 Oct 2025 21:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="cdWWKhYy"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A278530C341
	for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 21:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760392581; cv=none; b=mo9sE/hEVA4+hZSpESg51r/1l0Sro9dsW136DhEm9IWJovGSE/ziFmgJA6R3TZ2dzv3KkIkgCkW41rPlh2ZBafrnx1AEnpFmm5v4fZfNCEuIiZFtXY1AXOLD2n2PvL3x8Kcr+QQabuZpTUvg/TRSFSmLG4qzK7aYmJQYI3sHFK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760392581; c=relaxed/simple;
	bh=zG1PvbsubgVB7UstpLjRtN915FxsRLFbcnYegAn0YwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pNQ0LubVKsc5IARS1RHY7ovDAReT6mQ3xiEzz6BOz46fTdQlgUkHPJPlPNnGfH+K1QbnMkkqxjalji7ZaTVB79A+Qtgxyrt8o9oL117JJvBF0HJsxXOxYbE/iKaKOQCVWSql5Pe+09P8I3z+LM7C4YZomHVxN0BeEg9/zJwD+mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=cdWWKhYy; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3304a57d842so3771282a91.3
        for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 14:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760392579; x=1760997379; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9H2LPWU9+l2k2EeL07qQml9rdpRAXigNCc3vd68LC0=;
        b=cdWWKhYyIVjqBfHQzqQoAkzmW+wim/2SkMOHRvQlvPHCJKw74fobHOBxgmDeOczV+l
         mRgIn65367OxcvAIhWlQvAVIib9OwY5xkGOmVCSS2PMs/OJbZpICwKF3bsUDsT7Ax61h
         ni0iqAOkgKViPsAq/KvfY6mG4/S8ksKB99j91vaL9a2iJ2T9QqoBGPP3ycfB1LlFxjPs
         1xCr0TQ0g01UmFhbOi2nDu8B3Xze5SDky0fzT/C5DXiLdgza45n6JZo3OdA0llGSfhW5
         Jaj8vFpO5JJofbvseVCISJcPnSIXmX6iZlldBmPR2rpx033KDGZlXgWGJV0fbp9ZiKru
         leIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760392579; x=1760997379;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9H2LPWU9+l2k2EeL07qQml9rdpRAXigNCc3vd68LC0=;
        b=EvTnjxs7fUonVHeNHoO+wTxqFH/8EENH73XrOGSTRtKXsksKyUTHXXCFh+ULYWVvuj
         ZCveq15hIDKq8rz4mQYX9yOJ+9vNLlkqJYOlRQBJEaM1pVX5yB3XWkvWq02j9M/u0htb
         9gbaRDFI6ojBcXuOHNTZePGF5S2VqJcHyO8lQO6ZAFfNfHSgsJsO235msBDYAa0zpxdv
         yXKLe4MLcUjgNNrvqjkK+t7/Gp4stUG3mQvv35gagpBYLIFCt3ct4P/TacjPEf/7l6Jv
         L8HUNkntcfuTbSo76qOebA0DQJFGnW+Jk0SLjPTN231mKCd00VJZiV03D7HJ0Yw1Wp6I
         U5wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhG1jl68/1bBElluZfdbm12QdqtcVRNxpw8uoyCMsWvicV50jiDLUU2CmzCgOwxVKrXLQ5HlsDTdYs@vger.kernel.org
X-Gm-Message-State: AOJu0YyZMJzF3Hv5wtrW9shREjiwYKRLCUDSKVNjoCe6dVk7+LChyw0x
	rH7p9QLfbY8qSm75vX9KYgaq65mNvhVFmpWu568InU2NimLdatDSfB9C2T+3hAfmErs=
X-Gm-Gg: ASbGncsABEQT1TsFW+jSbfsiMYbvBB9mjsjJ68/JiqJpoZEMYO6vTobj18sftrbRffE
	cLghHb6/pkLMapdW9/8wrnVTyv/hcxLoDYIoL86Bf7eLMuiFABWidF7yJFg3TM9sky4uS5DZrCH
	WNWOEndVdxVAz0H+7h6rhMZNliYx0H3N3yidlx1CPYsEM5/UDEqpjNxetcfgjkSieXgGUs3Ud7o
	2x9poyz6JjwAW3VR3jrawd4VGP1idJ6jbjp/Ngz7r3vH480svtUGvWws/8B+4/VC151mGQOGUNI
	2tKexBgh5IS/GpRMTsGEVH+ELxXQ3xSfvw2c0WugDeFsglXZKiA1HKvRouVnMX0SjkYBPGJTF6E
	zodbV6u7EsZthJ5Z9docUCJNJD8QAe2ADNJJeSbW6HGwxJT1mfYY=
X-Google-Smtp-Source: AGHT+IFzR9QDYamHYpCjkFw7ZosGRTg3GUVmZHKGAXWmLamhYw9LpV35U9SRuq2pbLs+pbK1awqRow==
X-Received: by 2002:a17:90b:3a92:b0:32e:4924:690f with SMTP id 98e67ed59e1d1-33b5114b5c6mr35939819a91.6.1760392578914;
        Mon, 13 Oct 2025 14:56:18 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626bb49esm13143212a91.12.2025.10.13.14.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 14:56:18 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 13 Oct 2025 14:56:01 -0700
Subject: [PATCH v20 09/28] riscv/mm: write protect and shadow stack
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-v5_user_cfi_series-v20-9-b9de4be9912e@rivosinc.com>
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

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index b03e8f85221f..df4a04b64944 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -415,7 +415,7 @@ static inline int pte_special(pte_t pte)
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~(_PAGE_WRITE));
+	return __pte((pte_val(pte) & ~(_PAGE_WRITE)) | (_PAGE_READ));
 }
 
 /* static inline pte_t pte_mkread(pte_t pte) */
@@ -611,7 +611,15 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
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
2.43.0


