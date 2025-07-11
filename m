Return-Path: <linux-arch+bounces-12701-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFC2B0252E
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 21:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55C01C40006
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 19:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9972FBFE5;
	Fri, 11 Jul 2025 19:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="2OpCg8pO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7682FA629
	for <linux-arch@vger.kernel.org>; Fri, 11 Jul 2025 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752263231; cv=none; b=aQyDZCT6zuKuhc3k/WVhYI2sexM8QXv2SBGx+plzW9TEx1JnPbLoQtqs01QH/G3KGCRZmk+7znUwcIGU2ssFxGecdh1K/k4/FKyQZpCK6NCLiR+uSo2nz61iYlUaL8sqblfWlodfc8EboKTodFTxuv9VR0+eP77AQy8im++jpoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752263231; c=relaxed/simple;
	bh=kI0JEIvhnozf7HW2k2LoLdj2L7bNb8dWhw7SVD1JQVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MofT4zU39wgiBVwbMWqPShxgQS+OuTjhhza2VZIsBVY2NvGtnSfj2nSzKDfX+3qTjzNBWk7LojXtuhM2Jx4yVnXcZDewsk0Vtk4wf3zvO4rpze/Xozj8l1Ix7Oar38M5ryDYyZSfvJW26D6HMs8gRe0iye6SIUl8+m2QSbwk6iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=2OpCg8pO; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-748d982e92cso1690975b3a.1
        for <linux-arch@vger.kernel.org>; Fri, 11 Jul 2025 12:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1752263229; x=1752868029; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaOhr4B8UIBnpyYSF4WgF0h84c6zm8BnVR368xQHyas=;
        b=2OpCg8pObVOYOk0IxJ99Xsy9202DiQbdaJTkB8dhuKrWZ1XzYBMVqL5C/DUlgg+UWx
         +uiTOt9qblOaYt7U86x6ZzRI5vsbZZ0O49kj0IW+cSVkaByLQkBjz76Xw8wr1Gyf2DYw
         99v59nsltnF4t1f1x7E35gJypdP91X7G9ixnGDDhTC0HTcL/x9+UamhwEAxkdDP4YgsS
         cwL+vE0Bt8LP43gQytSB1q+cJ43NisAAMxUdBdc7XWIL3Qb6iR0n6GKGLYLOLeGFH1NN
         kOzFA4S2jjgjWyWQ3SAix0tnBjdc+HC1Ua56pjsgA5lKAjBWtEtLX5bacik8GhzDFLyw
         kjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752263229; x=1752868029;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aaOhr4B8UIBnpyYSF4WgF0h84c6zm8BnVR368xQHyas=;
        b=czDQ7YWGfXDZDDYO7mB2COUll0p+w2fcSy9JjFx0m0unUlvItrxnl7JS+HmRwEGlJK
         RnUndS2Ah4s+RHHl11HmJVgSDczqTJnjnbm5CZiD/SCm1DZAC8H862D1fIrd1jVkPYBx
         1spyTDgRrCIb+Fqdc6GshEto+Q6w1J0vE2gCCwQq7u3rYm8aYjkIumegG0IMPjYQlXXB
         4A8nu3b62EDir/hUq/LzKxWlZit6bV2VgzqjUIJRIFxrc/5/5oywryuWzWi64JruUSzr
         s2cOxGcAznqlKsgZKEgBYzNdvxIHWd1OoxyrQULwjAHYYjEEDhqmPXTRH91ubp/KDt3p
         Wybw==
X-Forwarded-Encrypted: i=1; AJvYcCXABnUtXj7B7mlgJmH6L2bKrcsMerqJMOKvo4zWQdIvLPRYLTBmAo6yf4oD00kZGhHOY7RtgabjrDbh@vger.kernel.org
X-Gm-Message-State: AOJu0YxFeb/qrB+aN1m0YQP+3/rQuZu63v0L6fusyo3GzLJATegt5zPJ
	rPIzb9H8u0e/aj5/sUlrhPN9sdrL/mr7WzcyruX3vfVlLtg6ky0Gw2xarHqrf/oy1Tg=
X-Gm-Gg: ASbGncuKhfSUanqPS1RypzCJeUz9zSBxvgtXey98TS9RIMBOb2ebwVo8XMj4YGGQOod
	L0t3FZi+Je+SAQYIn81m03iE0NQi45j6yr109UDEiBMNgCz2uV16/BwawE+ZixYCOhl5N45cCX2
	M4kTh10r+SQPa6F7rHUgAQVgsHjaPx2u7zt1xobN3///GR8EBpR9B7O5Kv0rc7HXColflTaGAR2
	IHf6W7QqIx3wgYw7JLmYQWtOQMTto3JoHhF3pzVvnUwvTJPRjPWVByjTB9D4gIAViO73C1P21VL
	aIXhAapjFyVmLwQ/fAw9DcxGIm/1kIs4YhNkbcwhOKdf4pLvyYZtV0zMEqWwEcWGXLL/x/4FEoL
	ZUVxZ/dPDF6r4AFMkrBU1c2tj461AeJg2
X-Google-Smtp-Source: AGHT+IGMRlPkCtoSr/DdLAT4x1zW1ahni9MMTdhSvmgOPFcqLwaQsTjIrpUSbeL2qcQ1/fjo21TBHQ==
X-Received: by 2002:a05:6a21:48b:b0:224:a21:6b6f with SMTP id adf61e73a8af0-231203133b5mr7517648637.28.1752263229244;
        Fri, 11 Jul 2025 12:47:09 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e06995sm5840977b3a.38.2025.07.11.12.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 12:47:08 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 11 Jul 2025 12:46:23 -0700
Subject: [PATCH v18 18/27] riscv/kernel: update __show_regs to print shadow
 stack register
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-v5_user_cfi_series-v18-18-a8ee62f9f38e@rivosinc.com>
References: <20250711-v5_user_cfi_series-v18-0-a8ee62f9f38e@rivosinc.com>
In-Reply-To: <20250711-v5_user_cfi_series-v18-0-a8ee62f9f38e@rivosinc.com>
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
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

Updating __show_regs to print captured shadow stack pointer as well.
On tasks where shadow stack is disabled, it'll simply print 0.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 91db51413fab..a88b06ad2f9a 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -93,8 +93,8 @@ void __show_regs(struct pt_regs *regs)
 		regs->s8, regs->s9, regs->s10);
 	pr_cont(" s11: " REG_FMT " t3 : " REG_FMT " t4 : " REG_FMT "\n",
 		regs->s11, regs->t3, regs->t4);
-	pr_cont(" t5 : " REG_FMT " t6 : " REG_FMT "\n",
-		regs->t5, regs->t6);
+	pr_cont(" t5 : " REG_FMT " t6 : " REG_FMT " ssp : " REG_FMT "\n",
+		regs->t5, regs->t6, get_active_shstk(current));
 
 	pr_cont("status: " REG_FMT " badaddr: " REG_FMT " cause: " REG_FMT "\n",
 		regs->status, regs->badaddr, regs->cause);

-- 
2.43.0


