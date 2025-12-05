Return-Path: <linux-arch+bounces-15228-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83279CA8D4B
	for <lists+linux-arch@lfdr.de>; Fri, 05 Dec 2025 19:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E371312099D
	for <lists+linux-arch@lfdr.de>; Fri,  5 Dec 2025 18:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BCC34845C;
	Fri,  5 Dec 2025 18:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="HB821pUV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF703446CF
	for <linux-arch@vger.kernel.org>; Fri,  5 Dec 2025 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764959816; cv=none; b=ciwfB97vqfb9YX7pbifiZhMUKsogEDB34TNLoJ+Z+jvdPSmd9nE31IyZraNokkBAecads2/uB6Z8Ik/JhF0Jthdv1KqlZUAVOUuBpL/SpmUeoM8hxVCmMoMqwDKauU5K5Hv/qN22CWqaFWRo4e4gyLK6r4cqiPe2iBef62d5WRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764959816; c=relaxed/simple;
	bh=BfqrkDAmEYT+r742gKB+SlFctae91M/veuPAGWY6Q04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ifAjGTR/4d9UhNQi6kTEa2GkxfURn38RdAVD3kbAHshKCQqgwpfeSdtwSGO+dPB8S1kWfFWXnP7t6K4GHK0WQm4CbnSEqrZNy2OeJMMuOA4jXGHxWjoOzKoqe0/yLVJOQnh1SUpWxMVvGm+kA9sh2e8eyRKBMZHNk7EuJpdQxJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=HB821pUV; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-bde0f62464cso2153285a12.2
        for <linux-arch@vger.kernel.org>; Fri, 05 Dec 2025 10:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1764959813; x=1765564613; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZzDCu7IaTRxcq9mEPcCPJw7K7qmz1vUabcyA8OBdm1w=;
        b=HB821pUV1vl9H0A3oRaissEDk2LISKxDFsYVfqPT6tn8wBGpbrEI6krNt9XI/mFy33
         0D3q/fE4U6a18UsUfyfkpfJ2UZrHBGWwzbGAHLZngUk6Fazpvkq6/LAt+TnKN5RMSvYS
         wa6S6Lj4lWPdXomOLBmYeQE8XfXyuvOBY1SjY5S9kxUh0kgCYgio4S9m9uwDAfOcuGLo
         J3Qm5ZTPVxEVk/KfB6j7rTG29WtnxuhijC6xlFCw+sxTpz3SaLenSqzMDEYdh8gQIIrk
         umIpqFuw87gYhp9ZC60oHVfiino3jQyMzlimHJvC8oWZAMW4UGYhF68RMAxvUlBFhdS4
         WE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764959813; x=1765564613;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZzDCu7IaTRxcq9mEPcCPJw7K7qmz1vUabcyA8OBdm1w=;
        b=NdZFu/Agw2Uj/nilCbD5lSmd9A+GTXqTeBGP4xTGs5ThXy814wlOE9vR0LuqlXMmFX
         A5vwasXJ0zTzefuAkQtZci1gwZhgUJ8v6mWdjZ28TD+1VvLVYXi1UHDvCmgJOGNfG0rn
         XPmFKMwuK8ihcwNQCpaaMZsKctystFKGhyfSgqGsx4T1/H+rrj7hUbrs3nyyMGX7HHlx
         RJzVHC0UxpnZu/jFrdFWMP2DFosM8EuPg15mKQSpmgumxgR5oUolad9bnfiZ5Ei7IY3N
         nsRom7mGhaddVJJcj4waCunfAz56YhXhNy/dHiEFHmg8NRv12k5EIIrwJPPGm3ODyfHg
         6DHA==
X-Forwarded-Encrypted: i=1; AJvYcCW5ACaxxH3S7s0VcjV/S+99X7s5Qj+587+nwuzKwftNi/ZLjb/mJ4O/8M4uHa2qUshBNYc1YkpqiYTK@vger.kernel.org
X-Gm-Message-State: AOJu0YyHE158kMqfgDfrhg/5ziQsbStBEHIQJjwa6+UM3VHmy2maxHDu
	8mu0ifGC27HNuFIHzugwrqNp6/8RFJPsAE6M+UuHBd4Z2SriNbCgecyUDvlz/ko3sl0=
X-Gm-Gg: ASbGnctHWolMRRbZGLvyTMxNBfgsYqarxpn86JAIwBETw6quV6HbUx1HTaW2hqhLlOI
	Zpv4+LyfWZFklwwzHfPYUZlPNqwuFLEWpZtQezFoO2xdLSQP5iEioScmqJtlqgHvEsTix7PdFgI
	fmvCDIAfe9UApPRx40jIUJUQFbJtqSc/2728x9nzfWjCdtGq2bTFi7w7R1+oMUNLHO01JjC9LX+
	s7CbdiE46l7ptO7JKjS+UhnMmp+3Qptr0ZvAUYQepcsNtV2YHJkgPvQhRMcgtjo20kX83JLH/4i
	M7u1zYkaumebZZewR1gI8OBRK/89F7Md/qs5j1kqDKNgyCWcOxhQ738kZuC6akbQnKmqDSR/tfM
	hEZIweImg5Uwa5130CWlrX3PUlsXnmP0k1EXr3mqdQ4o3Fp2ZmmIVQUPBvP6mYouV1E178n1xCO
	MTmmzL5BLRGrlhaPWiUmn2
X-Google-Smtp-Source: AGHT+IGMTXNhEE0AGobVo0Q+Qpcz65YU2t6Uoez+HvjFdTXQk2XlyYkBUQRk9w4i9DYExo/tp12ayw==
X-Received: by 2002:a05:7300:bb08:b0:2a4:7270:1788 with SMTP id 5a478bee46e88-2abc720149cmr114273eec.19.1764959812961;
        Fri, 05 Dec 2025 10:36:52 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba8395d99sm23933342eec.1.2025.12.05.10.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 10:36:52 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 05 Dec 2025 10:36:47 -0800
Subject: [PATCH v25 01/28] mm: VM_SHADOW_STACK definition for riscv
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-v5_user_cfi_series-v25-1-8a3570c3e145@rivosinc.com>
References: <20251205-v5_user_cfi_series-v25-0-8a3570c3e145@rivosinc.com>
In-Reply-To: <20251205-v5_user_cfi_series-v25-0-8a3570c3e145@rivosinc.com>
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
 Andreas Korb <andreas.korb@aisec.fraunhofer.de>, 
 Valentin Haudiquet <valentin.haudiquet@canonical.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764959808; l=941;
 i=debug@rivosinc.com; s=20251023; h=from:subject:message-id;
 bh=BfqrkDAmEYT+r742gKB+SlFctae91M/veuPAGWY6Q04=;
 b=wb8Cvp9WwhgSAwjQuZXG2bfRw8uKBYeoYJuQ+D08ldqWnIr/+SHvUA9MzZ7+c1hnN4WDZnkHs
 M6IZRQCZeBaCy67MIkBFvjWj4owucJIYwhEmnGzRtLdXw0MOWKyNECN
X-Developer-Key: i=debug@rivosinc.com; a=ed25519;
 pk=O37GQv1thBhZToXyQKdecPDhtWVbEDRQ0RIndijvpjk=

VM_HIGH_ARCH_5 is used for riscv

Reviewed-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Acked-by: David Hildenbrand <david@redhat.com>
Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>
Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
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
2.45.0


