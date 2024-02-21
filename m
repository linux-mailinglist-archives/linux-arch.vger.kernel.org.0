Return-Path: <linux-arch+bounces-2566-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8751285D721
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 12:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6DB1C221A2
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 11:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A954D11F;
	Wed, 21 Feb 2024 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QsV+4JpE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E08B4CDEB
	for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 11:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515352; cv=none; b=n4R8WPhZsM2qNyUxRfaydgX4tjnbRRe3vda5q+gJ8ihQIRb4WG672n5c1bkWSye70OSS8l70yQzSGHKpvRRp+D0GovZzU4foNMNsg+sMh7wlMbw1xq8hGg+Xt6LSa7ndLZ+1mm/KT/Le5RoUPB8Rj/KLaa+AojWTas+8m4bVuxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515352; c=relaxed/simple;
	bh=98RocWEs5r3eqouBXzUZIZpcbKGYcTds+8Ikdcp77uM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PNeYgp9n5cyDixcAwfLqa9OvOKEOUynj3z9i8UTWUbcDR8b21uRw4AfJ1acGvj/qxUEFVu7m9p2cM/Sh1hY7Fx0awLMfggtZfoNtDW94O+iW0kYt7akexSB4b5HP3LhWkahBoMazCyYXXi/FMQuIbkUTYyEad3EcpmDj+dKZq2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QsV+4JpE; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-40e4478a3afso32158605e9.1
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 03:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708515349; x=1709120149; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OQqG5//oJ4Rct3kZcJJxz5fvctqzzrLZGfPsxPM3FmU=;
        b=QsV+4JpEv4dcyIya22HAbt2otOOKNabd/tyK846x1RtNSKXYeWrciWgTm7mKTPKfBk
         02Bb9IVCB0XOlKs/vr3cl0JsjbC+q5HPMh895FFZBaHQaBUorKyzzEsPng6UJG21x5m9
         YFDei7PpC1qHwSjfomKwJYUwnqH2WM+uKUG8IPeBzPlmNC9p1e/Dd7I1/uYnV9wFCBuU
         zWzkxoxBUhrM+vHFOPxoGpmF/7p8Hya3lea8SWO+1mW8qOjLPTpK4nLnw2e1s0nXR7Ev
         IaJ4gNalIUMSkw+ALpx98cmXyd/1KE+FcKVc6b3FSSH9siVs7na8x/zrD42Vgcay+1Ar
         ZCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708515349; x=1709120149;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQqG5//oJ4Rct3kZcJJxz5fvctqzzrLZGfPsxPM3FmU=;
        b=DEExDeHU/IjVhFBpmrEunYNKUj5Qeh6pEMFPgQxPMAvXMJi0i2hc/6Zd/2jex3hxRx
         SAGXKqegUv5fIPcul4Zu8sov2xky4mSnSTQe56dFxgIcwZW35RP38C3h+8xhNHGhE7TY
         NvGs18SVODwLSqG0+TqbNa0blPwGim6UyvB05oXq1cLxwEdhRcg6TcZcOahUCn2t1lRv
         gZ2ug4fLPl8x7oGa+ZUgtHj3Y7Q60sj3dLqtHiHP437Lwijuh/n1bP5Xwksl038cbc0v
         dNpM9d5iPoOP0tcIsEyo+mwqbJDlrZdhBsBBV3aIJzvhv76bZlag2T7ISpXd0qK8aFho
         ZrmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcSOcEEWVJxpeMqlsHSAqJ99SSlva4T/jZIF7WbBEvjfwEYhtNocTpnooRhopzekDgTRA8FjslnzQqRtYGA1nt4qb3w5z9EcUVqg==
X-Gm-Message-State: AOJu0YxNdt2uirf17JgsakPeRoLEZHZsS8FQQJFgyrhg9k+ZGICEEpU2
	PVPhc37rcgCtwrYkmgAPbCFH62q/0uVxrYAoTlh2IIFS9mLeZmk0Ekb/u5ZBE2m+n6mj4w==
X-Google-Smtp-Source: AGHT+IGLElr1sEXa8rbOXotym5ln7bDsHynKRoK9PUKHlS3cxcNy+AczwcUJE6E0HbGDtqvW/HIfCPr0
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:11:b0:411:bc74:195f with SMTP id
 g17-20020a05600c001100b00411bc74195fmr184621wmc.2.1708515349006; Wed, 21 Feb
 2024 03:35:49 -0800 (PST)
Date: Wed, 21 Feb 2024 12:35:13 +0100
In-Reply-To: <20240221113506.2565718-18-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221113506.2565718-18-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3506; i=ardb@kernel.org;
 h=from:subject; bh=FS+JqcMc/MiCOd6PCGmTrr43k29kYK2wA+gFcF5Sq7k=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXq/fca9UsD/iQ9/atd2jT1UMuJC+kqF22uPVv69lO06
 7zp++xXdZSyMIhxMMiKKbIIzP77bufpiVK1zrNkYeawMoEMYeDiFICJLDvO8N+/Vjiw7BXTwRca
 zh+5VXYePPr2M+vh159WGVQ4KGb1qc1lZGi+u9OA44l9zbxqL8fcm21lu4tWeCt0nbx97Nbp2WV /HnEDAA==
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221113506.2565718-24-ardb+git@google.com>
Subject: [PATCH v5 06/16] x86/startup_64: Use RIP_REL_REF() to access early_top_pgt[]
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

early_top_pgt[] is assigned from code that executes from a 1:1 mapping
so it cannot use a plain access from C. Replace the use of
fixup_pointer() with RIP_REL_REF(), which is better and simpler.

For legibility and to align with the code that populates the lower page
table levels, statically initialize the root level page table with an
entry pointing to level3_kernel_pgt[], and overwrite it when needed to
enable 5-level paging.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head64.c  | 21 +++++++++-----------
 arch/x86/kernel/head_64.S |  3 ++-
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 7e2c9b581d58..72351c3121a6 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -77,6 +77,7 @@ static struct desc_struct startup_gdt[GDT_ENTRIES] __initdata = {
 	[GDT_ENTRY_KERNEL_DS]           = GDT_ENTRY_INIT(DESC_DATA64, 0, 0xfffff),
 };
 
+#ifdef CONFIG_X86_5LEVEL
 static void __head *fixup_pointer(void *ptr, unsigned long physaddr)
 {
 	return ptr - (void *)_text + (void *)physaddr;
@@ -87,7 +88,6 @@ static unsigned long __head *fixup_long(void *ptr, unsigned long physaddr)
 	return fixup_pointer(ptr, physaddr);
 }
 
-#ifdef CONFIG_X86_5LEVEL
 static unsigned int __head *fixup_int(void *ptr, unsigned long physaddr)
 {
 	return fixup_pointer(ptr, physaddr);
@@ -165,14 +165,14 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
  * doesn't have to generate PC-relative relocations when accessing globals from
  * that function. Clang actually does not generate them, which leads to
  * boot-time crashes. To work around this problem, every global pointer must
- * be adjusted using fixup_pointer().
+ * be accessed using RIP_REL_REF().
  */
 unsigned long __head __startup_64(unsigned long physaddr,
 				  struct boot_params *bp)
 {
 	pmd_t (*early_pgts)[PTRS_PER_PMD] = RIP_REL_REF(early_dynamic_pgts);
-	unsigned long load_delta, *p;
 	unsigned long pgtable_flags;
+	unsigned long load_delta;
 	pgdval_t *pgd;
 	p4dval_t *p4d;
 	pudval_t *pud;
@@ -202,17 +202,14 @@ unsigned long __head __startup_64(unsigned long physaddr,
 
 	/* Fixup the physical addresses in the page table */
 
-	pgd = fixup_pointer(early_top_pgt, physaddr);
-	p = pgd + pgd_index(__START_KERNEL_map);
-	if (la57)
-		*p = (unsigned long)level4_kernel_pgt;
-	else
-		*p = (unsigned long)level3_kernel_pgt;
-	*p += _PAGE_TABLE_NOENC - __START_KERNEL_map + load_delta;
+	pgd = &RIP_REL_REF(early_top_pgt)->pgd;
+	pgd[pgd_index(__START_KERNEL_map)] += load_delta;
 
 	if (la57) {
-		p4d = fixup_pointer(level4_kernel_pgt, physaddr);
-		p4d[511] += load_delta;
+		p4d = (p4dval_t *)&RIP_REL_REF(level4_kernel_pgt);
+		p4d[MAX_PTRS_PER_P4D - 1] += load_delta;
+
+		pgd[pgd_index(__START_KERNEL_map)] = (pgdval_t)p4d | _PAGE_TABLE_NOENC;
 	}
 
 	RIP_REL_REF(level3_kernel_pgt)[PTRS_PER_PUD - 2].pud += load_delta;
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 3cac98c61066..fb2a98c29094 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -653,7 +653,8 @@ SYM_CODE_END(vc_no_ghcb)
 	.balign 4
 
 SYM_DATA_START_PTI_ALIGNED(early_top_pgt)
-	.fill	512,8,0
+	.fill	511,8,0
+	.quad	level3_kernel_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
 	.fill	PTI_USER_PGD_FILL,8,0
 SYM_DATA_END(early_top_pgt)
 
-- 
2.44.0.rc0.258.g7320e95886-goog


