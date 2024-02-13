Return-Path: <linux-arch+bounces-2291-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909558530C3
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 13:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 078CCB23F6A
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 12:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2506D537ED;
	Tue, 13 Feb 2024 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Guw1y8z/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5801753397
	for <linux-arch@vger.kernel.org>; Tue, 13 Feb 2024 12:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828141; cv=none; b=hx5lvYIiwvU2Ec+Kt1Ei7AWHCqgO6ud+ay48Oq1taDha0GmhnLkiwPZbIyTjxz/9Xliar3q8TTX1azUN1E9A2EqqxLsphh51VzWfX+o9ZrOVPxuFZJW2uWrHgBRuCXFtPhbXJAysaTMa4Z16MEXoPAfcuHc9FvvMSRIJa5RNWis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828141; c=relaxed/simple;
	bh=CEh5RLJcC6IgrEQHXZSi19euYte1lfU4DaXYg20d8/k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y9QMEmmW53qT9POHN1C66utfth7fuC47+RICVK5KZsl36lAZ6I5mfJEUNEoPY8OXwFVbSeBWNFR3QRj8zUV7PBjaIXxHBcmEk5xbC4Jc72E9bR9Tv/tB1gc5GD0rE1Q9axbKym+D9RkjTmBQHrkoRR37Hpb8+NdxofmflHVVzGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Guw1y8z/; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-411ce6e7708so861425e9.1
        for <linux-arch@vger.kernel.org>; Tue, 13 Feb 2024 04:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707828137; x=1708432937; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tmJq7yGJtig/x243U4iqbWlHcuxPy6IsUUTLst4tAO8=;
        b=Guw1y8z/jNruQ44wvDkygVe5VYi84DDZ5PE2w6cL3ZngpqgHF3v+OUZUJz2KB7HaW2
         zj2PazcKIkRqSWXmQ9uqXIBaFSgzX0+UCjZRRStktaUtBt3oVZXbGULZ5BXQM6ZDmxyC
         SkoH/wyGrvZN9r6EmiidAc/x1saRWa3Kow7gvJhX4ZgE3Py8uufeG4i3Jh/DHYLb7/r9
         MwtYzF4tI260ZUaqZqe0pjeBd1D5ITeHzPopfhyyP0V9+2pYQCqjDvEJ1IrM76YqrAkW
         O6eaHbwqotPrxZTWhoVUZMUven4Ovkm/jX76kpVyHx0sA4Ajj3grY+j9bu16/Pj2dq/H
         V8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707828137; x=1708432937;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tmJq7yGJtig/x243U4iqbWlHcuxPy6IsUUTLst4tAO8=;
        b=r7HgVW9810n6RxUM9Vu5NMLZFe9tAtRLQ5Sl8IQxiJThNwemIt/sTqosuA3ynbCc7I
         w3ZvahNPLfOeVd27WUsK/csSzKsktCWN0XcSWk9FXSmMJuSx8FMdwsl3U3nAAMqUfsNV
         gdCtiIo5qNe0rfldtg0tyBt+tOpbl02ZR4jcFen8/kEbaJk4+QOlXlZ2BhRmMoGrSFQc
         cenZtR3R6VyrdmKWyPS2sXIj1tUZ1sArBtpg32Wx5nh5yeIiSPwekI6PfTDV5HqqTd+r
         ze5X0nIRDA5olwNND4eIatpqQ3CVWSkBRPMt0zJg5TtsmE5HY7/4XrTxg0AE2IzzJW/U
         y4eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ/RWwAvKNgv4KzLK5ylIasaQ36J6sDzlr8t9/iMAUpRsNz1W0UcLYGAjJE1yEjOxh2zF9bCksUE3CX5KX1y/JizXLMWpWxADEOg==
X-Gm-Message-State: AOJu0YwVpY44zXapuVgNBQPuEyfrGZGIvE+CV+ndD439gGGisxn8P2U0
	lFdhONHQzNW0k0XlxOjKHpB/46W1r5+t80gT2UCcMYJ5V0txZQm0D+I/4obngaHjRnQbLw==
X-Google-Smtp-Source: AGHT+IGyQVWB+fo+LR59Bx8+rlXEeatDD6WUWmQdXk1EX1AAwc7fU6kdYHiiwnYm8ZP3Z4zYoEQQLvHS
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6000:1e0c:b0:33b:4a51:f0ed with SMTP id
 bj12-20020a0560001e0c00b0033b4a51f0edmr18827wrb.4.1707828137638; Tue, 13 Feb
 2024 04:42:17 -0800 (PST)
Date: Tue, 13 Feb 2024 13:41:51 +0100
In-Reply-To: <20240213124143.1484862-13-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213124143.1484862-13-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2179; i=ardb@kernel.org;
 h=from:subject; bh=SH5BCZpD7eT9rYWqZ8AiKPxoLpu9BlwPcI3lpvrnWyw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfV0cn/7uaRP4tGTt8a01H99Oak74PEDlrXnFvfZ+AsXH
 pF9buLQUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbycw7Df++Drjf+P264pyab
 4jnl+emnm7K3nNr8cPvT223G2e5TkmYxMhw42hws/q71rUN8xDQV3cq5AQunJUxU/O+a+Fn8zG3 +aFYA
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213124143.1484862-20-ardb+git@google.com>
Subject: [PATCH v4 07/11] efi/libstub: Add generic support for parsing mem_encrypt=
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

Parse the mem_encrypt= command line parameter from the EFI stub if
CONFIG_ARCH_HAS_MEM_ENCRYPT=y, so that it can be passed to the early
boot code by the arch code in the stub.

This avoids the need for the core kernel to do any string parsing very
early in the boot.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 8 ++++++++
 drivers/firmware/efi/libstub/efistub.h         | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index bfa30625f5d0..3dc2f9aaf08d 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -24,6 +24,8 @@ static bool efi_noinitrd;
 static bool efi_nosoftreserve;
 static bool efi_disable_pci_dma = IS_ENABLED(CONFIG_EFI_DISABLE_PCI_DMA);
 
+int efi_mem_encrypt;
+
 bool __pure __efi_soft_reserve_enabled(void)
 {
 	return !efi_nosoftreserve;
@@ -75,6 +77,12 @@ efi_status_t efi_parse_options(char const *cmdline)
 			efi_noinitrd = true;
 		} else if (IS_ENABLED(CONFIG_X86_64) && !strcmp(param, "no5lvl")) {
 			efi_no5lvl = true;
+		} else if (IS_ENABLED(CONFIG_ARCH_HAS_MEM_ENCRYPT) &&
+			   !strcmp(param, "mem_encrypt") && val) {
+			if (parse_option_str(val, "on"))
+				efi_mem_encrypt = 1;
+			else if (parse_option_str(val, "off"))
+				efi_mem_encrypt = -1;
 		} else if (!strcmp(param, "efi") && val) {
 			efi_nochunk = parse_option_str(val, "nochunk");
 			efi_novamap |= parse_option_str(val, "novamap");
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 212687c30d79..a1c6ab24cd99 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -37,8 +37,8 @@ extern bool efi_no5lvl;
 extern bool efi_nochunk;
 extern bool efi_nokaslr;
 extern int efi_loglevel;
+extern int efi_mem_encrypt;
 extern bool efi_novamap;
-
 extern const efi_system_table_t *efi_system_table;
 
 typedef union efi_dxe_services_table efi_dxe_services_table_t;
-- 
2.43.0.687.g38aa6559b0-goog


