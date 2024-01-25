Return-Path: <linux-arch+bounces-1577-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3711483C0F5
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 12:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7A271F2433A
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 11:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFC85677D;
	Thu, 25 Jan 2024 11:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="av+QYO+S"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF0855C31
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 11:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182391; cv=none; b=gi4qy3zQv8nZgoL8jdt34zyp6H2ghVcyCO/E9IF+eujVw8Zy+DSke5ckIe1qJszehCi9IaRfk/iMK69EaEdn6uPu7x3UK96/lIeRiOAJVqzDHUa6XcqhFhLjNSEy9NOju+VKmO0amUikkBB+R3hYY4AH4doJMRSprEXc6nwIh7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182391; c=relaxed/simple;
	bh=0byiLPnDWEQfwFYPOageH65AoBGROCIbfIjdgEIOffg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hQuKOsilfbEAPqgFpQ/0PI+swjK8/iTKOVh9tFjdj9X9GQxzcSBoh+Ws6gJuS4nWqpVftkCt21jgNp32NQQ3xtzS3Kuv3WpRcV3mXtiThi61gQ2p6TF8i8IRkTViHkGX0C9ZLchDz4TI+Z3OHlVKtlwO19TZQNjxgId+5ODpq8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=av+QYO+S; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5fffb2798bfso72123607b3.2
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 03:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706182389; x=1706787189; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vu5UpmPKB2YLCZqvfGM/x/cMDohVrJdP/wVfbDfAQyQ=;
        b=av+QYO+S1Ypn4bbQm60XaJny8/I4M0doE43MnICJrrdmJvb0Mb1FrBppM6mJCTCyrs
         pdJpCQjDs2UqTdbuvnI4hdL3n5+qE5heWujv5qBDWibzy8RaEp4UJk+VCUluGFdahg6W
         0CtKZnVW+YkK9Gcjj+wdRrdSdU8h1E3gR5pj54z9PHa37kpywZBd58xgfZ3QZ1VGT4xA
         XEwekOrgB2LYWcO5Y4rJY4ZCtNifrH4JTHO/EOZj8qU6xD8Ain5g6b16pbPilz2GIHUq
         1StI/8LQNN3uwqjHZMwQFm7UcvvHFbgGYBXZNVQPaso2UlcPSwJTsHCfQB1voIDL/eeY
         YvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706182389; x=1706787189;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vu5UpmPKB2YLCZqvfGM/x/cMDohVrJdP/wVfbDfAQyQ=;
        b=kFMxk0aT94IQ5QjO0UE1Yz99DuuW0yIpyy0rFNp/jvAN2U9PuBjd3V7uexI+W8OqqO
         BHEnR3tQ4Hv46v9VGw8K8meFuofvMbKv44CcfwOyfQl3uhNZjem3uTdyL1P8C1uG8hsY
         s9bqr0QzWwRdgF5/Y6AAnvCtMQtTxjw9IzXaN1N0n2SS/WKM9iH7DJ2vKxdMgNeXlIoM
         PU4FrBclMA718/pA3mvmMWikxqEuicjMtUdBJj1pypyilgEOhstsyd+JyAoDI5TknOLC
         jsHTmKmrBLAG9ckmiNfYJWhWJffEJQnxot8aANV26APErR2PMeZdE8cmKarARfe8twxJ
         3XdA==
X-Gm-Message-State: AOJu0Yw6bYC216wlen/j+3Oqrjpkrs7ZSJGlEnBx8vntzQie7ZT/+CTs
	GMJ7DPpUp50cgGr/zAJXVd4Zm+NZyNHLuHS/xtXI70ox4fBVV2tcwEI+1aRLL5yhUO7YDA==
X-Google-Smtp-Source: AGHT+IH2ZMdK0yFVs9V28oU4JUMZ4C9voPcHonSkBQFa+Qf4lSb0VDC+TkQiCrNKNkecK2pTIjdLakiz
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1ac5:b0:dbe:642c:2124 with SMTP id
 db5-20020a0569021ac500b00dbe642c2124mr453115ybb.0.1706182389569; Thu, 25 Jan
 2024 03:33:09 -0800 (PST)
Date: Thu, 25 Jan 2024 12:28:33 +0100
In-Reply-To: <20240125112818.2016733-19-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240125112818.2016733-19-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1898; i=ardb@kernel.org;
 h=from:subject; bh=Hd3xYUTi1QV5SlyH4OmfppihXDWH6zHA/zraGYWG1jw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXWT6y/2x/MP/uz3CVv7baNn60+dbbIHuA/9mfjj3f1fR
 1/P6RIq7yhlYRDjYJAVU2QRmP333c7TE6VqnWfJwsxhZQIZwsDFKQATmaTAyPD2+pa2Dxbsd/fN
 jrsvvvyopfMmqYBp+f8FDP72z02YFf2V4X+B2iyJ35HcJiKreLw4Tjw9tO5KjeqymsqthxJdpnt 0O7MAAA==
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240125112818.2016733-33-ardb+git@google.com>
Subject: [PATCH v2 14/17] x86/sev: Avoid WARN() in early code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Drop uses of WARN() from code that is reachable from the early primary
boot path which executes via the initial 1:1 mapping before the kernel
page tables are populated. This is unsafe and mostly pointless, given
that printk() does not actually work yet at this point.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/sev.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index e5793505b307..8eb6454eadd6 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -698,7 +698,7 @@ static void __pitext early_set_pages_state(unsigned long vaddr, unsigned long pa
 		if (op == SNP_PAGE_STATE_SHARED) {
 			/* Page validation must be rescinded before changing to shared */
 			ret = pvalidate(vaddr, RMP_PG_SIZE_4K, false);
-			if (WARN(ret, "Failed to validate address 0x%lx ret %d", paddr, ret))
+			if (ret)
 				goto e_term;
 		}
 
@@ -711,21 +711,16 @@ static void __pitext early_set_pages_state(unsigned long vaddr, unsigned long pa
 
 		val = sev_es_rd_ghcb_msr();
 
-		if (WARN(GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP,
-			 "Wrong PSC response code: 0x%x\n",
-			 (unsigned int)GHCB_RESP_CODE(val)))
+		if (GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP)
 			goto e_term;
 
-		if (WARN(GHCB_MSR_PSC_RESP_VAL(val),
-			 "Failed to change page state to '%s' paddr 0x%lx error 0x%llx\n",
-			 op == SNP_PAGE_STATE_PRIVATE ? "private" : "shared",
-			 paddr, GHCB_MSR_PSC_RESP_VAL(val)))
+		if (GHCB_MSR_PSC_RESP_VAL(val))
 			goto e_term;
 
 		if (op == SNP_PAGE_STATE_PRIVATE) {
 			/* Page validation must be performed after changing to private */
 			ret = pvalidate(vaddr, RMP_PG_SIZE_4K, true);
-			if (WARN(ret, "Failed to validate address 0x%lx ret %d", paddr, ret))
+			if (ret)
 				goto e_term;
 		}
 
-- 
2.43.0.429.g432eaa2c6b-goog


