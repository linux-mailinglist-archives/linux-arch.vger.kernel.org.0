Return-Path: <linux-arch+bounces-1793-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F3D8411B8
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 19:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 232761C247CB
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 18:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F38815B0FA;
	Mon, 29 Jan 2024 18:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yecDlP6k"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9E66F09A
	for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551570; cv=none; b=UbJjrPz482/sEZ3UPt0XvHGTOBJ1aKXvM35s5KEBU12yERTk77atdt7jqdb8679EWbehrRfBzlS1N6G/q4gXlMS1v5QQQR82+Ys7w+/C3M0BluBiNdK3uEENfmDk5YsDrac1UZLNKCFq47KsAtuBD8c+Krfqj0AbH3pFe4zoEDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551570; c=relaxed/simple;
	bh=hGhdgMicSLDQ/VaHKkAj5Vre9mOZCJGZnI0ycPa0ctU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J3FtkDgtyL8ziuPTzbJIOGE1uaDsdrKdbNE2pLIDw+wiN8U1fKkqqX7/2l6vCMpG0xd6gf3sTwt56Axp4rWKln2iXhPfllQ3u5BA9V3FTnBhaOdpfmrqzE24miIjaZqnSP+cLzEQA/g0Z7SlHybS058v7yq7qDWFNxK8Q+yq//8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yecDlP6k; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf618042daso4919208276.0
        for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 10:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706551567; x=1707156367; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OvmdeW4/5l6h8clue2msSF5I8s+RaqVbElGLLzTfnIk=;
        b=yecDlP6kSsuHr3tT4kTeD9GhPtjfMEHL9pWX2txTU5S4LIPca2/DB7gyPux/5tVa5I
         Lqe0/FmLEsQDKA0GEg4VdJOKhEjkAEFTAR/gYFIGYdIlyl7+sse+JarovZC+3PQwtmtK
         tnRpjfW7bKCv7peORhS+x60FhQ5rPB5dfXVR91JFAktaUHvJxqsuNmROURCuNhUp2gVt
         Md2DcaRbbeEeFz2gdKB8ONmjVm0qmnRrEG/TytdgG9Wi12laNR8lbtEj4Iej8jy/4jGl
         NE5k0AGIuHhFKX2MqFYmON+nIsbTfTvGOz0j333cAz1pCfOTAjG6HccinVY91K6pHUNb
         q3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551567; x=1707156367;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OvmdeW4/5l6h8clue2msSF5I8s+RaqVbElGLLzTfnIk=;
        b=lQgklaj8PygPGZsgejNKBgF950ttc+afUX9R+hZQsySL3rnLrX+ldPpv/URXWOtqCZ
         3MHln9Gd6NXIFoYXb/dVjeufWhnIGX+5Svl7yXON5XAH4sUaa3nZiF1p3NFWN+kUtTNg
         3aHDixsxM4hmVL8hItAFE68G3rXYVzKnfx+3WAD8W0sLVC68SrMYpp/m12i5TvrbBcWX
         jvbHLAvOJ1av3++dUIjat+8Xbm6XJfwxPIO/5OwI44l6bBvW3oE/OxCW2Uhgh/kJQUWJ
         HonY718q5eYvicGKea0FPaz6NcMdAp0Ai3yq/16FkFJLpsNLrEPJAfyrWNajkpzM0wKz
         zP3A==
X-Gm-Message-State: AOJu0YysH2GbP6knNNziw9hNbIXcCXcEFKOnq1zfTKxY89cA02lLQXo4
	IUcZY7eBPGZmFpn33phSDm/73RpJBm5d5nNJ30T9PydZJMJ24LlZwTjVAJaAoFS0fU13Lw==
X-Google-Smtp-Source: AGHT+IEvm5tXIhZK0iVzSFxmZq0xz25L/Fykdz68esiBebN0gmjK2KT5a1HMeCysY/4pBr4f9cq1K466
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:2206:b0:dc2:42fc:1366 with SMTP id
 dm6-20020a056902220600b00dc242fc1366mr424438ybb.9.1706551567626; Mon, 29 Jan
 2024 10:06:07 -0800 (PST)
Date: Mon, 29 Jan 2024 19:05:19 +0100
In-Reply-To: <20240129180502.4069817-21-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1898; i=ardb@kernel.org;
 h=from:subject; bh=BAMQXD8G5KJ2RAZEnRCY7V9ynmVKgA6YQxKkMkZhfsc=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXX7iwd2nB82KC89l5dabni8zdb++Mqo/SUlzOIzelh7A
 tI2J/Z2lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgImckGb4Z9S36tFe1cvVWzbu
 ayl98UOoXKWc18nAMa1us+c8oyMr0xn++2XGVlQoGddc37R5goyOv+bk+2UVzxwrL7hu8HNk3C/ PAwA=
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129180502.4069817-37-ardb+git@google.com>
Subject: [PATCH v3 16/19] x86/sev: Avoid WARN() in early code
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

Drop uses of WARN() from code that is reachable from the early primary
boot path which executes via the initial 1:1 mapping before the kernel
page tables are populated. This is unsafe and mostly pointless, given
that printk() does not actually work yet at this point.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/sev.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 62981b463b76..94bf054bbde3 100644
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


