Return-Path: <linux-arch+bounces-10016-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCC7A280D7
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2025 02:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF3D3A17EC
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2025 01:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14B122A80F;
	Wed,  5 Feb 2025 01:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="GYWuKvhE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD8D22A4E5
	for <linux-arch@vger.kernel.org>; Wed,  5 Feb 2025 01:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738718531; cv=none; b=BR52N4M1fYBXy4bVG8WPl+/j6iXo3f0L3tRnlte5OxwZTjjYCzrJ1vxkTkBLAastBTvd7ShPXUkAMDWC3sPNHLk+67akXW3oRCczyqKw0mNVKrjCSAgGfJlMPH06/uNerT4pILUZu6j3902Wls2MNvaMu9XEa25Kydq6mUMSC0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738718531; c=relaxed/simple;
	bh=HOQqOSPO+MhBbccjb2UbKqhOT3MYkxspDNQyPTpGYhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k0n0GFDUY444KehobdqRbxfdBYygVCOkbKroXGA5NHw3W/Iwu62DshsO3HOF2FYfaw/lpZI7pcVjujtiZCDbHw3xFZKLxPvyPNErkubnG5MyWqObQLn9L3VkhoL7E3pQ6bSA5Yx82Jvdme86B4Nb8QUsEjl8nhihQLkkvCXTu0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=GYWuKvhE; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f9dbd7d80dso907743a91.1
        for <linux-arch@vger.kernel.org>; Tue, 04 Feb 2025 17:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738718529; x=1739323329; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPde6NcIQ47rHbegQG8dPMP+orPth983zEAPX8ktkAY=;
        b=GYWuKvhE5q6kewHJL2AeIOOIlbys8wkXYWo16hj7BUaqIY03Eod2piqVd+ZsLyjuEG
         XTQuQDJNVQEvwS3RSPWMFVbeXUlX6w00Akc0c7wVcGs1nJGa9I+bb68IYVacK3klMqvn
         oVgAnQAn0gurFpjdq1MdlYYFsKO2XkzLxSZStYgbzgnHL3y4OsgjQf6EK2Atv86K/Agd
         30AICNnrIODMm1QtigZ0R29NyARO978AdDG72LXvUUWmEhhsZ1Y2OMQagb59O/jXGgVn
         dVGloyM0+1Gez+hSN62xGySydNKbomuA1jzk88uHevbjfgy38d2qsq4ftKq202byhT9d
         s4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738718529; x=1739323329;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPde6NcIQ47rHbegQG8dPMP+orPth983zEAPX8ktkAY=;
        b=h1xbFeLWGALAMrR/Lk4VWiSE7KMlOH/ClQpEQKPj+jvaxFmYRWP12TyPr90c3uofpY
         +TtWc3Nnprc0DpLSZofCprvgCeoI25ia+vwoDRiwmNE8DoakYQfcTZFn+BfBQvriARGd
         luNZRkd2SZR3wCiKALu0aOS8egs0T4Z7UOT7FMdQjOqtbIiYDK5p/7J/tURgZL4yRmXc
         An8ZNcOUDZiQv4mU6+W3eqFsukHygYQ2wF+Q/+/tfaMXe63JXo0kX5rx5e/JmQJwbyOl
         +JqaUUn8p+H+VsGN9mCw8wqGdkJfbBnGvRKiTBPt6oq2pjgttlndYWfZt7K+/Po/cXMF
         H3cw==
X-Forwarded-Encrypted: i=1; AJvYcCVcVJhsdOQgDhO4rDZLS02LJ/pEY2d5kdl7Iy8drf894hte5mykkItiiFswJfl0II3fzf0JAEUD07l3@vger.kernel.org
X-Gm-Message-State: AOJu0YyXGaWGvBFplsrRhnMB91XhGZF2ELAHPyA/HqNsNdjGbk6kWe0s
	/NPw/fhVjeDGa4d39WNHVMCpwDeljQA+6Z9+utyE+7zvgy9Xh7b0zLKAVzdCdLI=
X-Gm-Gg: ASbGncutOmcvb7TRH3YKMi0844YVorz6sjQfN3nFhXnwVA3T6BolRtLKTu6MlGGn2Q6
	NhWGbBEZEhDTl/CocMuBJf0hKX83Qms0PaiVWMBAUL68DIOnKCjYP/SVIePzF1WRS4kbcfjZQUr
	+cuqGGZop8d2lC7UjGG1XW7Jq7CihJj/Sn/5DKnpZGXkncjY2fnTMENeRh6sQqHTqqzPqDrgbO7
	zMxO5/nZ9bBbJfgwTkhLBol2zbqDUzEIXpr/qse5sNkyhDk2h0Q44rZbg8hHdLLQh0tO+R+sNIn
	HcrhsHh2HVrTfjv1HZhnBGUEKA==
X-Google-Smtp-Source: AGHT+IEPr/jAZdU1BeAv0MTLO4+mRSsOemI+fwwJ0UmsHYAhZKBwL5jRXw2/FSsvJQ9vrjQzGW+zkw==
X-Received: by 2002:a05:6a00:35cb:b0:72d:8fa2:9999 with SMTP id d2e1a72fcca58-73035140b35mr1685541b3a.11.1738718529305;
        Tue, 04 Feb 2025 17:22:09 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cec0fsm11457202b3a.137.2025.02.04.17.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 17:22:08 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 04 Feb 2025 17:21:55 -0800
Subject: [PATCH v9 08/26] riscv mmu: teach pte_mkwrite to manufacture
 shadow stack PTEs
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-v5_user_cfi_series-v9-8-b37a49c5205c@rivosinc.com>
References: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
In-Reply-To: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
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
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

pte_mkwrite creates PTEs with WRITE encodings for underlying arch.
Underlying arch can have two types of writeable mappings. One that can be
written using regular store instructions. Another one that can only be
written using specialized store instructions (like shadow stack stores).
pte_mkwrite can select write PTE encoding based on VMA range (i.e.
VM_SHADOW_STACK)

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
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
2.34.1


