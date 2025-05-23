Return-Path: <linux-arch+bounces-12092-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2512AC1C04
	for <lists+linux-arch@lfdr.de>; Fri, 23 May 2025 07:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F102B16DB0B
	for <lists+linux-arch@lfdr.de>; Fri, 23 May 2025 05:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7621B224882;
	Fri, 23 May 2025 05:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="z/0uMVmZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1343227E9F
	for <linux-arch@vger.kernel.org>; Fri, 23 May 2025 05:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747978298; cv=none; b=o0h1z6BHqGo1pasL6/dBwvug0lo0wFIAH12iR3VTbKu6VhXqbQl7u5zmY2U4umnAr2lwPqkxWP1KNDG890Y03o7QVZbhhmGs5vFQRsUEPYwuqdpBmE4VD3CZ7HmHRMUjLJRqcX2UAYgdSbXkiNGsAHyWnND22vTv3cbZ2MYM+oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747978298; c=relaxed/simple;
	bh=5l4eYXK/UGIl+TXQnZwANU66ClnBTNssKdiHYV/yMZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BwZO8vzuWe/M5B4knSkW0pcRPUoU3A0uJgxWyiyM/r719RNAeykHgRNBT6nztOdCICgD3oKliEnKggzEcXEkPAUztw1aSOjVxkIsisn54xzsv54bY2vZuB8pKxTMLyB+bYvj2H7Z2VFl5xPX55prWeTbuUr3dlYGeFtrRhz3WLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=z/0uMVmZ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-742c9563fafso4924095b3a.0
        for <linux-arch@vger.kernel.org>; Thu, 22 May 2025 22:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747978296; x=1748583096; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tvKQDIIBJb26wPDVIJoD2xzubcY8uay1NjKLxC4PFw=;
        b=z/0uMVmZpDv5zwxFek8js9xVH9cXB2le2L02EF7uN2rHvzZOei48EiFrsYZZE0fsFL
         DL2lEpPdNBacS+2aX8C54dVtBZgkNwtFfW/tn2owTtGFmTz06BCze0n0kBSrx3lS0eLD
         q9r7/Rco07W4WQt4KtjYeFY0IlEKxreW8ijt1r/taj23YmSz2eQT9aHIvWglsQx6KKhE
         eoHPAROibPTrQT4NUpN5fOa7aV3M607IblxJI2j+CVoX8rRl9H6SFtAO3MJ7eEFJYtCs
         HJm2e0GjZ6jTzGqhn1PoIspLR50ag8FySpjOBHFDasFFcplgBAW0sybergzwLcomAEtJ
         gBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747978296; x=1748583096;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tvKQDIIBJb26wPDVIJoD2xzubcY8uay1NjKLxC4PFw=;
        b=nbPadRlMpdfhB9rdaoWvSeN4UDHyxZp3mVZtlq1KjVXXIYDaSwjV5edYeyGoPYjY5d
         5OulTxRdPGwvwpydQZpuvfCKeOkdqunaMvyIMWmYPC8aDWzKngb0O2UowHyWmrtRLtaf
         VRh+q8UHLLD6J/3xZnSGxLYSbL8/jiMLQ7jmx5TpoJM2o6Bkm6sNOtJQAiG2Nu7ada0g
         1tIYSR1FjWSqa6OflgmzkiW3dw5+uOVtQzFWiW+QQMg6z8Iu5rtjb0hHX8EA96F/cQLy
         UltvFQadGMLA7mjNGCUB/CMThQu4+mnDo+va3fubM25RkQ2EER6BSLMJUhFeCFsBJ0+6
         ZaoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUytN4OFmw8nKgfmlUgXFweytMCnz1iN38+WLdZYzNZrgdiAz+BJNGVaT4z2E1nD0A5mU7mZYyjXS1B@vger.kernel.org
X-Gm-Message-State: AOJu0YxWHiMEURAnKDcWd9NA59SxrxGAO/4xjDPbuCEpKCqW7DYif/zB
	3vESj1CaBzFVC8JLQ2J+iX3dHJ+rf7doWIpmKdXmOu92I76QxUFORfZnWyu1X+ajdCo=
X-Gm-Gg: ASbGncsLcv0aiwDev3GyUQONEJVbtYzgbZc8fsUuUXMNgUvkLNLh1H4kRFCOD5w/2wt
	xxxWQaNUGr2qC9L+WBIRVgkE+hod6LT/preS8Dd/Q9sperkt8bxIqwckSjmOm9LNWC830f5dTSE
	ZQf3ggDlChx76oW+FtD9Q0Aj3bpWqabQDecBC07a2R5/7bk9LT0sZO2qxve4rOdpXTv6UsDznCH
	ODrfeihxSK6Li6frMpkP7ZyqxXDwLbkULJTNzSkWN5CQU0/YS3hs3hMJlQQ9Vsb1AUh7lAdBqAZ
	kqlbNJ28cd+CsdPokW82i3dOBKuAmLH/2pykRVFr54bHDgVKu8J6irb3X64TxA==
X-Google-Smtp-Source: AGHT+IE8rK05QdJ1ITD+5XvR94KKlymVkOHWAITS/NaW03DRq0vlii2hXT8T9gkaCsqN/qPnStmT9w==
X-Received: by 2002:a05:6a00:9186:b0:736:5e28:cfba with SMTP id d2e1a72fcca58-742a98a323bmr38743995b3a.18.1747978296025;
        Thu, 22 May 2025 22:31:36 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a982a0a4sm12474336b3a.101.2025.05.22.22.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 22:31:35 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 22 May 2025 22:31:10 -0700
Subject: [PATCH v16 07/27] riscv mm: manufacture shadow stack pte
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-v5_user_cfi_series-v16-7-64f61a35eee7@rivosinc.com>
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

This patch implements creating shadow stack pte (on riscv). Creating
shadow stack PTE on riscv means that clearing RWX and then setting W=1.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index dba257cc4e2d..f21c888f59eb 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -433,6 +433,11 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_WRITE);
 }
 
+static inline pte_t pte_mkwrite_shstk(pte_t pte)
+{
+	return __pte((pte_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 /* static inline pte_t pte_mkexec(pte_t pte) */
 
 static inline pte_t pte_mkdirty(pte_t pte)
@@ -778,6 +783,11 @@ static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
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


