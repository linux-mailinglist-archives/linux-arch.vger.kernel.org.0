Return-Path: <linux-arch+bounces-2563-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2ECA85D71B
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 12:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74C2BB24137
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 11:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CEB4C600;
	Wed, 21 Feb 2024 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uMRV0uIH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14855482EF
	for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515344; cv=none; b=t4SKifCIOtJTWVRLdOc0Oza/c2Izm404OqAaLya8adcgDzHy19UCijdkQO+lw+XyB/TnJuvoKlTPqAilZOABhjnCmx6IO7wVLFVeJF7W5a2XFZ/2ezlbSaCrd/YPqUqISi2j7oNdgdHQUtJhlPmaP7WOCa1XtQ+brEJ8VLP2Huc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515344; c=relaxed/simple;
	bh=2RZc+OzKZCl8YvmipTaTRDsbfIBsnndPUmVKA1yKSts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k89PP/ZYfifO1sooGUv2VntFuiC2JuDCHfRLdO5swEaEBkLDvhYb4DARlnDLMGYDKBGwrKwFd/gujLA4xKbh36T0i9JMb6MfZRxN6bfrQ7wYmywmtEwAZ2h+aqpEwHbAb3AFE7ZeVY/UwW/ZdwVEAA0a5POsTWOgrMZl1bqsWNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uMRV0uIH; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ee22efe5eeso92702847b3.3
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 03:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708515342; x=1709120142; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Y5gC7csmOryHPxIGBtz1GA+4X+0n6cre/zcvSeIDBs=;
        b=uMRV0uIHjXPynQUi/G1NZCFhb53bVLW+n95V///OG5499cUBjiIhG6wME9hKF2h0RT
         uohTMmKBYwXZ89nm/hKdD9Zdmk64sy9YhMy3E0I8JPVhJZjGavl/pTJrYUzH6PYQCaKu
         96w+LKfO3nWpX2TLm9WyVRRXUPKtRCVCaS4Rb1tI47jfXaSjcLM37ta5+k0I18y63c12
         qiDuFO//ARXQIaMg166xpSbZ+jM3nJa89DKZ3pr9WtGF1mFE+he8L53i6iQVEoQHiWt7
         0SzDlReV3V6w40D50HPPfqu3p/lQd4faBRvMfeK9EI9YmHTovfr8QRQyW9+1aMYD+QcM
         z39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708515342; x=1709120142;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Y5gC7csmOryHPxIGBtz1GA+4X+0n6cre/zcvSeIDBs=;
        b=N5s/VDAK3qJ34MuqnfaJGwYuYWVRjSyeChcViWbj7uPNVgx/0gla77kPgETyn0B9jQ
         FHW/wbUiTxq0yMEvbwT0w1kIjwTGjP9Va/cMonXJ7d2Gf2952a0K6/LSciugm3eBvetU
         riSb8S88zoDCywn4ueFF1YFSSh8K2fx7xRp/VGhjKhAumk6OiLAXlC0Eci6Gi3DD6zk6
         ZaixZUJeBu9OBdMl23LISqh44jQTwYAMDNagGGYbDAQVZCc6H3PtEf0I+hH1Mcyq7Vug
         njjn/uPPoeHdgEtJUUkWi0ZgkcFgTmWwNBdZcsSGD3rwH0jmFWAYoeMFuJuvFkuVyDtq
         yoqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOn71D50dIGR+IEbWw9BnRbUcxlLnaOaO7BrCiynKPM9lduSdebuCwPFBC/xuqLPHJqrp9Xq6okFtYGfL3Ucz++4Rv8mh49sE3iw==
X-Gm-Message-State: AOJu0Yz1+btEu2975pNLrVDk2kzUzUxcqfO+NqrQ0EVdWoUjsJSf8LA4
	mVt68rsK4QoKS2rWvVhTkYfZ6LyemisO73JBCXYx9TH07BONxxD7BgmuTPUZlw7XNOfBlQ==
X-Google-Smtp-Source: AGHT+IFELx03HuT0Inbkk/6jf+jmcEOFUz77S85HuXmJ2/vo3Tmzp9E1tSdM6FzUvRXx2iV06N6VbqE/
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a25:c06:0:b0:dbe:387d:a8ef with SMTP id
 6-20020a250c06000000b00dbe387da8efmr680600ybm.1.1708515341658; Wed, 21 Feb
 2024 03:35:41 -0800 (PST)
Date: Wed, 21 Feb 2024 12:35:10 +0100
In-Reply-To: <20240221113506.2565718-18-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221113506.2565718-18-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1903; i=ardb@kernel.org;
 h=from:subject; bh=swM7c8C7m6s+syovcWAlr4I1pvzKmPTAbfvGRxDNNBo=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXq/bf72s8c5X6zfe4kzhLF88Ur7P10Jv1+c5Ij3Kphl
 3trnr9SRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZiISwXDP+Vl63+6nT136ee+
 a7WfF7mxtuzU745WC96z5anM3cc8hWkM/0Nz2E7NSCsXY+vlOrVpn+zruNaY9l8JFYocrFU2Tpo M/AA=
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221113506.2565718-21-ardb+git@google.com>
Subject: [PATCH v5 03/16] x86/startup_64: Use RIP_REL_REF() to access early_dynamic_pgts[]
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

early_dynamic_pgts[] and next_early_pgt are accessed from code that
executes from a 1:1 mapping so it cannot use a plain access from C.
Replace the use of fixup_pointer() with RIP_REL_REF(), which is better
and simpler.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head64.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index f98f5b6a06b5..2ac904110f6a 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -170,6 +170,7 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
 unsigned long __head __startup_64(unsigned long physaddr,
 				  struct boot_params *bp)
 {
+	pmd_t (*early_pgts)[PTRS_PER_PMD] = RIP_REL_REF(early_dynamic_pgts);
 	unsigned long load_delta, *p;
 	unsigned long pgtable_flags;
 	pgdval_t *pgd;
@@ -179,7 +180,6 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	pteval_t *mask_ptr;
 	bool la57;
 	int i;
-	unsigned int *next_pgt_ptr;
 
 	la57 = check_la57_support(physaddr);
 
@@ -231,15 +231,14 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * it avoids problems around wraparound.
 	 */
 
-	next_pgt_ptr = fixup_pointer(&next_early_pgt, physaddr);
-	pud = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++], physaddr);
-	pmd = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++], physaddr);
+	pud = &early_pgts[0]->pmd;
+	pmd = &early_pgts[1]->pmd;
+	RIP_REL_REF(next_early_pgt) = 2;
 
 	pgtable_flags = _KERNPG_TABLE_NOENC + sme_get_me_mask();
 
 	if (la57) {
-		p4d = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++],
-				    physaddr);
+		p4d = &early_pgts[RIP_REL_REF(next_early_pgt)++]->pmd;
 
 		i = (physaddr >> PGDIR_SHIFT) % PTRS_PER_PGD;
 		pgd[i + 0] = (pgdval_t)p4d + pgtable_flags;
-- 
2.44.0.rc0.258.g7320e95886-goog


