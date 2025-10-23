Return-Path: <linux-arch+bounces-14304-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7657AC0167D
	for <lists+linux-arch@lfdr.de>; Thu, 23 Oct 2025 15:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70021891B9D
	for <lists+linux-arch@lfdr.de>; Thu, 23 Oct 2025 13:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AB832E694;
	Thu, 23 Oct 2025 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="SnypopXr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2E732D42B
	for <linux-arch@vger.kernel.org>; Thu, 23 Oct 2025 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225955; cv=none; b=W2bnHZ3PHTCUgpDV2kZax9YyI0EYhEiupw9nCw1kP7UkSU27fnBkrmiKnRfRZM3TpIiAoClhZrPIYG8NGr0OIrkG24PBnXLb9ppKMq0xJfLnF2eJb15pBf0c0haHPwGuSqgXVhEc0Sb64mAK0DAlQlvSy2uHVaaf83URMku6cKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225955; c=relaxed/simple;
	bh=9AtWvDKQ9q5op9YLRgkrDiWaHEAhrRbEgloHu05lQww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ji8U0m7nK1xodBeN52vTxjUr4neGjcOwsjuTNVH89tnrLQCPA/dF/ik3IwL3WA8YO32oNOSgk9ejCC6uoLWyPxR1g6BCxRXrdWLHtqFxdO3Qe6loSQnO+uDyuMtpQKP2Iy9EeCPqZmKqcIyzWKxZfTevfwwlh8CvE4xNEq6IM94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=SnypopXr; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6cf1a95273so584646a12.1
        for <linux-arch@vger.kernel.org>; Thu, 23 Oct 2025 06:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1761225953; x=1761830753; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oeDKcuIcO6+2FhxyceVVS2WWiuktyVdq1WpyUni2wlA=;
        b=SnypopXrwxGqpv29G0ay1xS0eoIRdmPRzMXorS9Ua6v/UapYGLvKggfr4wIc43ppRz
         3/beOhqiwX015mlBypDUdvrSiTBic7bZfw37c5DI3OxkgFzQ2VLKp1OEa+PYLjRCa1hT
         tgbT/6loawSP9CYoiMzWpZqyil0mXdiAifgL3jciUV+0cKucIA60fj4+Cz/sp+1bwWEN
         VbPRkc03c1pgKcRSuI4PjPWucQvEpjKTy+DYJzLCXcfdl+LjNCp8yL7gy7FJS1FCzXQX
         FLBH4aT4CQWI2bArF6TX+NRiPaXd3fJyzliwmbWVXtGrBrcAZofrNm0SZmh19/Bus7io
         m4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761225953; x=1761830753;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oeDKcuIcO6+2FhxyceVVS2WWiuktyVdq1WpyUni2wlA=;
        b=LjWtZKy/lt1+/ISuaM2HShyTa6BmyPc0a1lipvChJ34CTu/IJErAk+nsZsI7Bef94l
         4JOxQb1xFNi7UXmir9scXBh6hoaSRNQl1MXvH2bt/hiPqY/86sExEIV6Fezo/g1cA8rV
         5jiPl3CIHiCwJ4CK7eLQRqeDQWsFxTDrXs+RCsgDfFRkxtCZnv6aV8OdqFp3WixaWeoc
         AVhfXMtIiU8M6fZ3RczlcP+WE7JoRT7qxQeso8YMd6+lg53Sd/YMn8wa7+i3angqhPGG
         Fj1PI9ztylSFi353TtAgeIjwfFsu4ZGOV1cKudMict/9yOHMoPx14h1QoeIDw/BzVGw0
         RmTA==
X-Forwarded-Encrypted: i=1; AJvYcCXsg4dRZFzTVwlpL/wAmk+3tl9+rJqtdwY7dxHj+iRC238yKeoVeaxqWc0bHvHeQlpYUomoYXZBHmcd@vger.kernel.org
X-Gm-Message-State: AOJu0YymyauHCXPMODgt3nkUwGLaoZvxEIhpayaqiBxBZ1Cipdv+IleY
	MTf0vIxZJb+nkIgshthMLDEB/MOG0G+vPOecowpgSy+oNWWz0VULQjnN5EkkoZxWQy8=
X-Gm-Gg: ASbGncuXMRpP0UUzKyoNNMzPM7HTY/RRoSe+qe+pZ6WX+W4umummmJ6iInAjLa6318+
	kvnZ6l0L4qU05VZOXQ0nxgvkzUCcUJPwmO0gYNc7mGk23Q6tUvFz1Qt/lXSWFxYLgw/2tihf9O9
	jvjtZvNUspo2iZox2DxGoPXJz+yMtMd7A10qRrcyLlF6aPxNVBPj2xvb0YytatBmqTF30hDZe8W
	iH1wPV0gP2Au+YvbMfME/ywyB2MqYFcEVEBKW4chOrJQDeDr00KL1KTj+HYZre2drKqRWzMCKD3
	4cbu9R3wSKaSuEhoyuneL3e1pVpV7mQo5IEPyk8v7XieR+XloasCuLpR2IfY6cX7OxPlYiJpEiK
	NDpWxoC9XQTTgT3WtnOalC+NnrDaqeZBJZg70/6GpSklesvV1cp2P5PKdBTX5C8lGfvDLzt0/zs
	iJsBgF/a4aJ0lGJpE46Kt6
X-Google-Smtp-Source: AGHT+IGAxsiF712OrLUPQ8MDODIL3Qk5KsmgHC3vsv1nzcwZbCFCIx22kpnWIeS8R2YjMhFzIyCVEQ==
X-Received: by 2002:a17:902:e5cf:b0:290:a32b:9095 with SMTP id d9443c01a7336-290cb7567fdmr344582925ad.54.1761225952677;
        Thu, 23 Oct 2025 06:25:52 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e23e4b3sm23432035ad.103.2025.10.23.06.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:25:52 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 23 Oct 2025 06:25:36 -0700
Subject: [PATCH v22 07/28] riscv/mm: manufacture shadow stack pte
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-v5_user_cfi_series-v22-7-1d53ce35d8fd@rivosinc.com>
References: <20251023-v5_user_cfi_series-v22-0-1d53ce35d8fd@rivosinc.com>
In-Reply-To: <20251023-v5_user_cfi_series-v22-0-1d53ce35d8fd@rivosinc.com>
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


