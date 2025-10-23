Return-Path: <linux-arch+bounces-14305-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3602C0164A
	for <lists+linux-arch@lfdr.de>; Thu, 23 Oct 2025 15:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20783AE76D
	for <lists+linux-arch@lfdr.de>; Thu, 23 Oct 2025 13:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA09132F75C;
	Thu, 23 Oct 2025 13:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="atGqRQlB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF06D30C345
	for <linux-arch@vger.kernel.org>; Thu, 23 Oct 2025 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225957; cv=none; b=EfWs/ddgf8JL7qnjkJzciW7EARZ2X0hDXh9h7TFRRvPlrNFTkj5gMxqxBT1qSheKB1kz6skJ/bQ1lu0hjTdyazoI4fvqTPPjaUGz42+n1bpLuK4BOAwjZv/GqZBuXGNUB8YTCYTXx8/6mnrq/UlsPpPE48vQmkWZCmeYAebVkQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225957; c=relaxed/simple;
	bh=hYnrlxG2aSy5XgBcW07Fd+5qY0pd1xI872KUOKzj6JI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gpKNnkkNqe36+2WOwx/ZIrM0wTSJIPP9bn7UI8HAdsC8FMY0uHMJbNsBv9FSZcrzHEkdRKBVMwAPQqN5VRs75v1HVXBKDFBMzqutIyMkW9TG6ENc7KbqeZ7EWzov9981l+E2xbxyqeIt61wLJFl7t2hJcxuuOg+Fc9AqDx0Mig8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=atGqRQlB; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-290b48e09a7so10115065ad.0
        for <linux-arch@vger.kernel.org>; Thu, 23 Oct 2025 06:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1761225955; x=1761830755; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aU5JHaPOPUGgukhD3bad891ElerIE5ocm+VeTPJz1C8=;
        b=atGqRQlBOnY+EU0f/LQqSjMslU7qM0CJpik1DrDAzG7DxzmXpzNnFaPUeXiVBEM7cn
         PQY2rDyH8BQ9zMojPB/FaoEVQww6zY5UdBre/459P6PHgv+PcnAqgiDMzzaT1Wa4t036
         u6xVZf2EJrgbolD4W1vD3+AigeeWek7x75hYaLwwblEM3JxBkkHG+Z0EWLfuSaPDL00F
         na9CO/Rf+wuqXKoHCg9cry2kI9EW1+uVVdaDoXeAYDKvBXBZLNviCXShJ58LWemhoyRG
         OWMkVrYx5kAe05yeduzw8XGMNTp2o4OjlPvQNE/jgKVth/hUmiEya5Mn4HH0cwFR/tQR
         H6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761225955; x=1761830755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aU5JHaPOPUGgukhD3bad891ElerIE5ocm+VeTPJz1C8=;
        b=OxAohHPqBo0+TJFnXMemhm9aUo6iCBB30zzIQmgvpVw4Sjj7AjiyFbhc9SlTL6rH6y
         sjn1HRCwMDNf+EBsntuAdfxGglBiQQzo++VJr/nMxYBujyG1AhVP+Mom+PtPr/iS2vaP
         8DBFS2akkJ+EQZRXjB88xAB9aayNGgyLEaDaMrE5Mk+bqWt+RAHavHxQ6cSP+Rlz0dOQ
         tv0+iqsEHGz3SYXAv0NbBLM9md/nGUHAxVl0hLrd8BOAdHHnyJ+9lQtjOOdEVwnd4O5F
         3y7NBlCDfFW9pifK8l5Piu0YQDxAvbOGn3ko1IT9eLYY42SxRT+0XjjAGWuaeXnHlg6k
         EvzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwyXfH0TwyL0NX4xJYu9PSpJn+82ww3SSTWogJAq3mRVP+BffTFILgqpDdVO54ixodZVRstYGu9gxz@vger.kernel.org
X-Gm-Message-State: AOJu0YxIZzQtaIVeHaSUaJbbkANdmOwq9kmDq7ZmJKOcFgNlBODrhvVj
	2pp6YMCvYNGJhnyBG6ynEaJWSisYUox5W2dDP5Xs5lyLuEleaSZ84PwaKV7PjVdqfNs=
X-Gm-Gg: ASbGncuqIoUG57uyD6aTA6yjxZtGcIHqGLzzMOFg5VKll7ysSWHkW5yi5mCW54dzaZY
	iTRTYTja1PJHPSfF8QSkJROjSpMyO53UICSY3fFOUJBTuIbzfsykB9GcJpSjCXnzqfkY579jBzK
	DzPNw2UpOUF0h+AlWqBe6jWIOVIjTtXjvJYvC9DuKCkk/uG541Y+EXTBnOklRxu4gV5KwFDu+Wx
	6GTjJ38zMOFfyJVCbYr5PnCt3Dfqr1JsxUySZnDyDFtabx4YbiHY1gX09MYg+O3ha9mXqFeJX5s
	QoiKH6ZuR4mQ/7WLLWt6I/AHlAukvk8ZOKn86Lubl0KiS9Gt5JzXqo9G0IM2b+fnfGJzJy/SenW
	ofzP5FEzAqXjsbqoJ97I2n0xf24opWlZScTjN9s2X4OBDhkH30q9yNubMhrMCezHiJ7BToVPS16
	xj7ZryZqvscA==
X-Google-Smtp-Source: AGHT+IHdVVJz5j5gdwIs7i1ckupc3MWiBeucKHlxMmPwS/HD5Gcn1QAjsoFkXcbrRaTvtAeB6lGYFA==
X-Received: by 2002:a17:902:fc8e:b0:267:ed5e:c902 with SMTP id d9443c01a7336-290c9cbcc96mr331173865ad.20.1761225955000;
        Thu, 23 Oct 2025 06:25:55 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e23e4b3sm23432035ad.103.2025.10.23.06.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:25:54 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 23 Oct 2025 06:25:37 -0700
Subject: [PATCH v22 08/28] riscv/mm: teach pte_mkwrite to manufacture
 shadow stack PTEs
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-v5_user_cfi_series-v22-8-1d53ce35d8fd@rivosinc.com>
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


