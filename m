Return-Path: <linux-arch+bounces-1579-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C41383C0FA
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 12:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391611C225BE
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 11:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7956B59B7C;
	Thu, 25 Jan 2024 11:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DfgQR618"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1B65914A
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 11:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182397; cv=none; b=gS6RiDKUz4kZLcGsqKTuJcRX5ENiItf+bsvuOlHw9N4aOnRdv92XvHibIkTl4H6g1g8xKVpUXOw2OqS2vHoceb7IADn324XSUY+dKyGOE0DgmVpjqo5BRXJVEcrcUMG1imE9epJZHkbUwtVBloC8urhIjbw+vD8j0l/NM1lBuAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182397; c=relaxed/simple;
	bh=P7SsUUZGFAoKRtQbrSSh80tauvm72OXVWNmZkHlq190=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lg+rBeUFc59EwFDrez6qOwf5xulcJz6ipilQBf/PWvd1fuPrgji14KJdqu+vG0Lrj4GFFjmG5KQVpdq2rtOkgdFGCT9vdhoswnRiiBuZ9PPp8B9faM0MINdhiaXGKRa25WUy//fQXHD9sK6r8vKzKiH2lQWcSeL+G9ttDkfiCz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DfgQR618; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-40eb06001c2so37551415e9.0
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 03:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706182394; x=1706787194; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hBUWnFeDK9kwJnQ8v39o1YEuf+vNzkyqOxxuFopn5io=;
        b=DfgQR618KVP9F9t3DuWRIAiCRRXQtg1odKkiO4gDT2Hl4pmtnL61E9g23dXvk/J7GD
         Fvttl5fiRd3KxTQfFUfxj9cg1SJiHjtAbs7KeQze4TuSh8qgPA6F0PE0C6iebjLC1X7t
         59tl16FCWi3q3+cx4ac/TsRvYibARXRoID3HYC7Mw1999UKU+ChySSOkGyYr6AfCvOPe
         HZvxUT8j1g74HITP9jzfyMFt5YgNIGRZIMV1Pwj4Q9Ql08+1Jj/v0KcyrOZxPA5b9D8K
         EMBkr3nXE5XFMwI2esO8UcJGagZFId07+nOsaIXSPfhIJKsaIxjEDLjRdy3YpSQxPprJ
         FZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706182394; x=1706787194;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hBUWnFeDK9kwJnQ8v39o1YEuf+vNzkyqOxxuFopn5io=;
        b=CB9TPTVx4rwpYFD7bxXEQaHK6HBNRPpOvhbfRQiVRM9wkiQyzOo8MUKTU4Zk6xGrG2
         LQnd5V/R9Vpwzgf0VkIuV6vBUxfdrX9hlz0Y8fYhb0SOhEHYzn5IXP6ZjJnVNVcbN/e1
         MIo59n2V/54+tr6bG/iA9fAiwMqNhPS3ztSysJAJ8yFcabXrFTQ5GrBdbEx2WoooVs4v
         VyPp5n4GPu3LJsYiD9cF56J4We1kGnqWwY55QRNuhtzIWY/vV46+7K8k25yH+7UOmWuk
         8tbmIDEX5R6dEpACp8Fl+WId5GzXWtM+fsh302N+FC0lWdbfXaVHu9Rw6FhDZhsS2KXS
         Ha/g==
X-Gm-Message-State: AOJu0YzThsxl3lenfIYyOL0T9yQOKseOQweFp2QJVCdBQ7p2RDT3WFDF
	hmzwv8rIBHDFpfj2lRIQVR+3k3G6tQh7kuhAwf9Cgd9UFDCmDQKtV0iKbkeIYqyT1eDCqA==
X-Google-Smtp-Source: AGHT+IHzdyFKwRZfLQOx7Liz3jisEWS93tZ5bagY94cYYG4ibLNtFhAJRkFG5YBEzc0iKOjl3ug3Mp3Y
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:1e03:b0:40e:d31f:4cf8 with SMTP id
 ay3-20020a05600c1e0300b0040ed31f4cf8mr16460wmb.3.1706182394116; Thu, 25 Jan
 2024 03:33:14 -0800 (PST)
Date: Thu, 25 Jan 2024 12:28:35 +0100
In-Reply-To: <20240125112818.2016733-19-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240125112818.2016733-19-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3710; i=ardb@kernel.org;
 h=from:subject; bh=JT1olNiwpLiAazvRYxL/s0mN0D+4v2kwCKTsMENT5/8=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXWTG5Om96fFG3IbTStkj79Symr2m+K3+H2fZ6N1zjRVN
 wPZNXs7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwEQ2VjP893miFvbly6s19kvZ
 X+/6Hxq4oTuqS/Xx3b/1m3/WqujxPGf4p6Slc1LTL3iz04Wers3bufROzWqd1m7CrXkmqbRDa1c LMwA=
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240125112818.2016733-35-ardb+git@google.com>
Subject: [PATCH v2 16/17] x86/sev: Drop inline asm LEA instructions for
 RIP-relative references
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

The SEV code that may run early is now built with -fPIC and so there is
no longer a need for explicit RIP-relative references in inline asm,
given that is what the compiler will emit as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/mm/mem_encrypt_identity.c | 37 +++-----------------
 1 file changed, 5 insertions(+), 32 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 20b23da4a26d..2d857e3a560a 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -86,10 +86,6 @@ struct sme_populate_pgd_data {
  */
 static char sme_workarea[2 * PMD_SIZE] __section(".init.scratch");
 
-static char sme_cmdline_arg[] __initdata = "mem_encrypt";
-static char sme_cmdline_on[]  __initdata = "on";
-static char sme_cmdline_off[] __initdata = "off";
-
 static void __pitext sme_clear_pgd(struct sme_populate_pgd_data *ppd)
 {
 	unsigned long pgd_start, pgd_end, pgd_size;
@@ -333,14 +329,6 @@ void __pitext sme_encrypt_kernel(struct boot_params *bp)
 	}
 #endif
 
-	/*
-	 * We're running identity mapped, so we must obtain the address to the
-	 * SME encryption workarea using rip-relative addressing.
-	 */
-	asm ("lea sme_workarea(%%rip), %0"
-	     : "=r" (workarea_start)
-	     : "p" (sme_workarea));
-
 	/*
 	 * Calculate required number of workarea bytes needed:
 	 *   executable encryption area size:
@@ -350,7 +338,7 @@ void __pitext sme_encrypt_kernel(struct boot_params *bp)
 	 *   pagetable structures for the encryption of the kernel
 	 *   pagetable structures for workarea (in case not currently mapped)
 	 */
-	execute_start = workarea_start;
+	execute_start = workarea_start = (unsigned long)sme_workarea;
 	execute_end = execute_start + (PAGE_SIZE * 2) + PMD_SIZE;
 	execute_len = execute_end - execute_start;
 
@@ -517,9 +505,9 @@ static int __pitext __strncmp(const char *cs, const char *ct, size_t count)
 
 void __pitext sme_enable(struct boot_params *bp)
 {
-	const char *cmdline_ptr, *cmdline_arg, *cmdline_on, *cmdline_off;
 	unsigned int eax, ebx, ecx, edx;
 	unsigned long feature_mask;
+	const char *cmdline_ptr;
 	bool active_by_default;
 	unsigned long me_mask;
 	char buffer[16];
@@ -590,21 +578,6 @@ void __pitext sme_enable(struct boot_params *bp)
 		goto out;
 	}
 
-	/*
-	 * Fixups have not been applied to phys_base yet and we're running
-	 * identity mapped, so we must obtain the address to the SME command
-	 * line argument data using rip-relative addressing.
-	 */
-	asm ("lea sme_cmdline_arg(%%rip), %0"
-	     : "=r" (cmdline_arg)
-	     : "p" (sme_cmdline_arg));
-	asm ("lea sme_cmdline_on(%%rip), %0"
-	     : "=r" (cmdline_on)
-	     : "p" (sme_cmdline_on));
-	asm ("lea sme_cmdline_off(%%rip), %0"
-	     : "=r" (cmdline_off)
-	     : "p" (sme_cmdline_off));
-
 	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT))
 		active_by_default = true;
 	else
@@ -613,12 +586,12 @@ void __pitext sme_enable(struct boot_params *bp)
 	cmdline_ptr = (const char *)((u64)bp->hdr.cmd_line_ptr |
 				     ((u64)bp->ext_cmd_line_ptr << 32));
 
-	if (cmdline_find_option(cmdline_ptr, cmdline_arg, buffer, sizeof(buffer)) < 0)
+	if (cmdline_find_option(cmdline_ptr, "mem_encrypt", buffer, sizeof(buffer)) < 0)
 		return;
 
-	if (!__strncmp(buffer, cmdline_on, sizeof(buffer)))
+	if (!__strncmp(buffer, "on", sizeof(buffer)))
 		sme_me_mask = me_mask;
-	else if (!__strncmp(buffer, cmdline_off, sizeof(buffer)))
+	else if (!__strncmp(buffer, "off", sizeof(buffer)))
 		sme_me_mask = 0;
 	else
 		sme_me_mask = active_by_default ? me_mask : 0;
-- 
2.43.0.429.g432eaa2c6b-goog


