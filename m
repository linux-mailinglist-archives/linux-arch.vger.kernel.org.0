Return-Path: <linux-arch+bounces-2572-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350EC85D72E
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 12:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAC0CB24336
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 11:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CC84DA12;
	Wed, 21 Feb 2024 11:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JlK8D5pv"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AECE4EB22
	for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 11:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515367; cv=none; b=uLj2F4x5buMzqDkloKGQnCbrIFYcN3ojlSNppyMVm9L2Lj92K9zBSxLgsSeVYm7AUqthQQ5M/Vn8FEmOY/XYKley/kWEQ5xO1U3B7PqeYXVO5Ae+K3uwQB/4rOGwSrjAcQIZEiMB4MU4OznZykAU9XVHuqtwWBxlW36xVuZ+QMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515367; c=relaxed/simple;
	bh=cyP4xFLZtWmSglaQt1bRPcLQO2AlvE55S6UyeZvMgMM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OPdAqbeP+EyecVnagjPoHIXnF/hFfZslgHJ/TX5Y00XpI8h4aPSGWjO4yNpfeePgqQYvFYcTAbWWCq8lLK6VtpmhCUBhyejDLCTVqXUiwwhlvvLJB554ZU/QLTcWTX3gUoG8cOCjuDhfiNPqkP/WbIu0+DDfSyt+xdMVMX3LWmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JlK8D5pv; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-33d36736772so1484132f8f.0
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 03:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708515363; x=1709120163; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ygqZ0HdVfjjnya+uCKEPe+HOAs/11yLIprq08KYDjCU=;
        b=JlK8D5pvk7Isl6HzBVdYrAm+zaNAlQxeZDLUziDxhFpQBDJ56Zjnx21H64Ku7KZuc1
         CVfkqzNxy14GGjCSaw4GbPcMzv5BMq3c/xfU4MEvmLed8Clsg8yavTsqLncMlh4lUWrb
         8q2tbO9TMckC0lYN++2lBPVnKQyNd0i+5zXtIFoZNCBXwqfMWuER5eH3VEFFIJucgwCC
         hKvAfWJ81UAIAQmTG7UaLpu40yCP69Uphl5+L9uJQLvG+cZ9Z8ZLBv1gaFK3C3zzBOsX
         s9gOSC+0FQEVSerpb0L/dCNWbj8JTVRQRKrRUF4h4vEGmrSC/FNfOP3AeIqzd8OlL7XX
         OBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708515363; x=1709120163;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ygqZ0HdVfjjnya+uCKEPe+HOAs/11yLIprq08KYDjCU=;
        b=qXSA/qYC3Xmiza5aqJZbe2D12OMaLAO8Nmb3N0KgwtK3olEfQ5pG51H2zSn08CH9xc
         rXeQIbPbeSoWgh1HYXZ/nnQ7kxKHNXofp0OIigLlOK0P7O/Y050svsZ5Q1GtlhsK3rvC
         Ii3VWhF6an7ean0+RyMbP3rO+eCYb7HPJGv9PTzp8M5VIhqvmvIFE3ZvjTTSqV/S6R81
         +zxcnPff+1j0qSLhUaquAbQZJ92pZoBVupC8Qc4R8iCGd9iG/9Xn/AkMWuqkoT75S8NH
         0t6axyIB5lQQtPN0Hc3wztYwqJH/OzwMeggFIuN/T/8SaGzjZtJV8OzCNPG66u2GlurV
         wp+A==
X-Forwarded-Encrypted: i=1; AJvYcCU1w9XdlAhJuzWS4Cw6R86c9NHThb4WvJKlz0wkDfNwk0WPn8TS1MeK/h5uNr7Ud5oXgfOlRjVsE6NZOCAKK+yJjg7faxXKZQR98w==
X-Gm-Message-State: AOJu0YyCjWe1/4qjB9ailsQ8a4VjUlic1iAkYj/N/BMKGVD0DleF+A1J
	Oq4HeALPNu3hjLPrw3YcusYwsAFuqj/M8+dt/5aOmPDswbuIGJ1o01NIwEUgOuv7OZwYSQ==
X-Google-Smtp-Source: AGHT+IEwJkOJnuMq7ORoS6GZzEmG8oYrQV57UO2nb6Z/7t71yxkwvghJTIAJpRWx3O/owpBnv+CV3jaE
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6000:68e:b0:33d:6211:4699 with SMTP id
 bo14-20020a056000068e00b0033d62114699mr12133wrb.0.1708515362858; Wed, 21 Feb
 2024 03:36:02 -0800 (PST)
Date: Wed, 21 Feb 2024 12:35:19 +0100
In-Reply-To: <20240221113506.2565718-18-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221113506.2565718-18-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2183; i=ardb@kernel.org;
 h=from:subject; bh=FIfYcIT0zte0p7QudMXkiQVk0sZSk5MJFoxtVIwXDvE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXq/c9nhK593//oPlvM+uJnf5Nc71pP9q7bFnDn2vKpe
 juuWl3h7yhlYRDjYJAVU2QRmP333c7TE6VqnWfJwsxhZQIZwsDFKQATefaLkaGrnXW+jfYSrgsP
 p9+equA17UpPH4dg3J10EcZptlf7eCUYfrN0v79eFNqz2qvx2ofQ+R1Z77et35Z4RktOxt5mUal rEB8A
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221113506.2565718-30-ardb+git@google.com>
Subject: [PATCH v5 12/16] efi/libstub: Add generic support for parsing mem_encrypt=
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
2.44.0.rc0.258.g7320e95886-goog


