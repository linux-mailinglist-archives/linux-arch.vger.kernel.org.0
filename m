Return-Path: <linux-arch+bounces-14060-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3CDBD66B1
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 23:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA0754F4D07
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 21:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8D92FB967;
	Mon, 13 Oct 2025 21:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="FHIl2z6w"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E792C2FAC09
	for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 21:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760392562; cv=none; b=dR68Mr9UwXX8CVg1+S1NmzPklAT9ZDCWbKfE+kHcAWz3O+mw0t+uGUuFWTdBLugdRGzvGqoLYXyJTKwEfjyntThwtVSuelTaxL6JyfmpkSjaIcDaivOnOpeLZPKQ06A2pZj0cQQPcgxo1T+CTWkjv6t5qTyqzOVyHjXJ/nYAQ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760392562; c=relaxed/simple;
	bh=pkBAvc0IieGGas1vvYQtOkKUWHcQF724uRmRqVMGgPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lz/dqHqaP7F8yAr8RIpj0/xY/HEqh8QfSpq++9yhGNvgq2jvu8YL2WdiP22krr0HFxufCREUs29HrhDUrUbAb73zCnL/oHd+Wdzwnqp+L1c0zl9HA6bGx9MuYtuH/X3WLtV59jWi/Ow6JpPGWeMY7QG4PmopV+L8Fiq4W/V3esg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=FHIl2z6w; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3381f041d7fso6102570a91.0
        for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 14:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760392560; x=1760997360; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RuPJu5G7SzSWQtkc01838lduYo70q11KgqBzT6e6NXg=;
        b=FHIl2z6w3GRUpXJbpNIgjen4+RSRY3+nE/wWuRtp31VjDsg/HR7UR/8ERyalZhU6bh
         e0zb1Sd6MVuAQLa5lOyKv1VkWYkvu0rqsBGt+xmlkpkMADvYWVipVCgmP2frOuSE/P49
         HHxG+Wr/I9WBcp+XAnlENfU4dxIBySQIKj4j6bxBj3aI6es+lhJNm80j7tNPfoUxTaYU
         0bBzaxqiPxhHER+bK2rdG8i7kkm2nSYYUgnVnp4KZGzOMptqpJAw69cL6aGdhwvgFDGb
         U3HOPVb9sLSiB5fsGlB20ACyFPKLLKHoeh2KRexH1+RLJ0vFcNvPJ9gnzgJZ0ua4ng74
         8rSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760392560; x=1760997360;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuPJu5G7SzSWQtkc01838lduYo70q11KgqBzT6e6NXg=;
        b=GqR5BGtydnl/pOcrERDOP65tKV+j+IHMcs6/YF1m0UQWyrHHCvB6gybhIkThmIRmlI
         VFZU+9O6112xELw0+N8jD5EtefYteg4QIOSQq4Q57qGQe1gsBS7vJM3SkqxI0FwcY2+d
         KNLRzsHV7OK2LJ1pLDpLpKaE/jRNW3Sui7YblLPL7e1o6E39xMes+WIVJUxpcqvrKSbd
         M30/cQDvnFRl+NvLNZl5xHUjstX7a+6g+r6GgW47SM6e8yyJFw42QSFutalwTLvPVs/g
         F0ZcVRzsZpdGwrBJT+yP0o9YQz/o0Wk6QiyW66hEqj5Q0xJ66ui/LK/01DkZVgaGq7vk
         J5eA==
X-Forwarded-Encrypted: i=1; AJvYcCXYXQzD4dlkJOFubiKMHjtYi+04LsbsD9cvsPs+KYO+wQwim9zsDmW1rpqoIgPAfcVd65d3LQnCx9+9@vger.kernel.org
X-Gm-Message-State: AOJu0YzYtQXbElGLIZHSmeMFyvv3GkRZPU1zSMFFWrlCX7cdWRBoSzua
	iDQjnx2zugirKud5z0xE9h3oPmLHAlmEkboIff3GFnY5stQjRMZ2SFFV7K2zLY4ME7g=
X-Gm-Gg: ASbGncvjuEBesdWh04H9kdZeyzkOrK4pulATeGNvnsYP/qkUkvWQoYmhepqmin2l5Gi
	kYmt5GS/F31ZRo0M7xEG7Xz1+i8td+3+/+t3+1KyQ6XVtHB6+TeGf7VvBE0SPj7P4zkVjmrN2QJ
	F0Zpp0mHPC/F8vA3x4QHj+zlWy60v3KYFEEaNmJY6olbZlxAH7b6HK0LUUiiUtr3QmhkJIjWAyb
	aVVEUdM4s83/N4uqvjDElf5iIUGDkl5TDFaD68dlaGrseZTPBNX+GJPeR8xjC1ur/7YX4WSUD7Y
	+HbHEGM1hQogFRZk5MZMIGSVM3/4GaVLPv5IL4KJoSaDfPVmaFo8if+ZN5mQ+XmSzLCNtqRhuUs
	sXsxnzjCUFCaN8OBSxVLMA0Nvx4ullI2ndbZ3DmOKKapy+UUy8dEiIqArYkFYRA==
X-Google-Smtp-Source: AGHT+IFqzpISbqmNZOG0bEFOm6WKZWXC8Tmhcil3Siykq0hDNGwZJ8D8UA33BLPp/sr08wWkDb8lvg==
X-Received: by 2002:a17:90b:2691:b0:330:55de:8c20 with SMTP id 98e67ed59e1d1-339eda4935emr36148338a91.2.1760392560121;
        Mon, 13 Oct 2025 14:56:00 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626bb49esm13143212a91.12.2025.10.13.14.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 14:55:59 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 13 Oct 2025 14:55:53 -0700
Subject: [PATCH v20 01/28] mm: VM_SHADOW_STACK definition for riscv
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-v5_user_cfi_series-v20-1-b9de4be9912e@rivosinc.com>
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
 Zong Li <zong.li@sifive.com>, David Hildenbrand <david@redhat.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

VM_HIGH_ARCH_5 is used for riscv

Reviewed-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/linux/mm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d16b33bacc32..2032d3f195f1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -380,6 +380,13 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_SHADOW_STACK	VM_HIGH_ARCH_6
 #endif
 
+#if defined(CONFIG_RISCV_USER_CFI)
+/*
+ * Following x86 and picking up the same bitpos.
+ */
+# define VM_SHADOW_STACK	VM_HIGH_ARCH_5
+#endif
+
 #ifndef VM_SHADOW_STACK
 # define VM_SHADOW_STACK	VM_NONE
 #endif

-- 
2.43.0


