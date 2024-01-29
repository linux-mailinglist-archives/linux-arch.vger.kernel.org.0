Return-Path: <linux-arch+bounces-1778-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABFC84119B
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 19:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9028C1C235F7
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 18:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3BC6F070;
	Mon, 29 Jan 2024 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HRNQRDmE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60B63F9F6
	for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551534; cv=none; b=cKlVjN/KDIZoB1OH6o0ifEAO5sNCr8Ii45PegJzc7EMHb7XQSyjuszG5H/WalF/pZsu5U8rIevt4+HQl+9kEUARqzJJg9kv3yPFt8dcpjsj675tZbvXc5R3zPxlgPoo9E9WNosyjDwtxDLCJlkxjPF5GUzl4eeC1Os7LEkkzR1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551534; c=relaxed/simple;
	bh=8EngcPiV4/gVfKgvYtooxy7CfkplaV+JIi8nleL+nv8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r5QMmG7waGinbozTBrIz9/mlIkBapWQ7BDylBiaY+gpe8lmPhKpF5tkskOyg6BImw3Bbeh/Y+xJocq4jk/aT1Ox3LDaAxelRioL+GFgoBJoX8UVy/S+xigFMXLyjlCDNecy3bBR6KcaXxW2bISA3hhQBoGxh+2fttcvXaxYoMAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HRNQRDmE; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-33af4a96c85so308369f8f.3
        for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 10:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706551531; x=1707156331; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKxz5I1lJ14YrwiTICZR28lgBpbE1gmuL2Ys4svPQiQ=;
        b=HRNQRDmEXLWEjS+DYUQxClPctOz2zbJJVbX+8mubQjDVea3RYXHQ2C+NaoFeQSce/9
         YoqhBTr2lLrom/TScTQSSVl38LGRpu5CceDTEyNoeh324ql+BPdbCABtrtMBxz3qj7uA
         eAkmauGX8DH8qywnDiGSMO0DgQPt57fsPzsygNPjwwLQGr+BYLESvJ3B4svejMEqCezA
         kZ6zJgmTtPm+tEQiYhw8zh/JhVfWOesvuWMpQ8GKCQ4SVJ2MB3Fczrukd6rGby0HdmT2
         /4yDA/X1aaxvCtqVHVkmSrj7Tu0496vKEJZWTTHROrAfHeC1beyjN7jv4wCQGZyrbXuK
         Mdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551531; x=1707156331;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKxz5I1lJ14YrwiTICZR28lgBpbE1gmuL2Ys4svPQiQ=;
        b=U5Ue41oi/q5CDOoXsuEc/TIIHCD0nFOhlFcPZOojiassLjltCc/OKmUp+pldngmcep
         ONx/7uXKOoVDIV778Ui7yXDBv2IOIc+e/of3iLfx6+MeLAfZBsCOXB0eNBRNs2fXemdf
         Nua3GpO1WllG8+JjrUACeEK0QSgs+J9WSWPZ5wLrnkK0xiwW6MBTs7QjxtWMkhVYIz4c
         TrVsZMnRC5RNZCT1K3EEvKD7Cy2GWIvKjEZdV36PlrpNriGZD8RgMPMUt8JiBIenCYp5
         soJmc2V///zklXNSFeagzE1+nj1xVvh6O8k4CjtGR08P5MHKjiZuW+Qx1wqqn1LE8Xtu
         b5SA==
X-Gm-Message-State: AOJu0Yz5q3msgZjPHUnHREUgfemAFkjrF6bwbX1HUwd02x8njF+M3HcC
	lNqHFv5AsQmMh96ZM+8NZ/Wwr8/zt0r9EKvAmNXzOjBpSEgrwyEEapvKSoqodNOQeEQZyw==
X-Google-Smtp-Source: AGHT+IHqXoqSxlnq+tXgVV8MITvhCNMHm/mI4bOyTcP8eXKfAYEXj2pInMqp+zkM42KE9U02vk3dc98V
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a5d:5a97:0:b0:33a:f355:7f2a with SMTP id
 bp23-20020a5d5a97000000b0033af3557f2amr3448wrb.8.1706551531045; Mon, 29 Jan
 2024 10:05:31 -0800 (PST)
Date: Mon, 29 Jan 2024 19:05:04 +0100
In-Reply-To: <20240129180502.4069817-21-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2179; i=ardb@kernel.org;
 h=from:subject; bh=cYtM8PUyOXvYlw4FeyoL0t7P65MWzmFujl4gVlusCbs=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXX7iwvJHgmKYd5qZlpNAZqZUfs+Xyudf+rqhncfljw00
 JxmfF26o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExk9nNGhiUtf/QfJmu4l6R7
 +lzQmanC+t38+7/fDQ2K2fFPtm50XcDIcNKRZbZu+RGrc37Gq9csORj73Tspw+TyQoeoVU5WT8O W8gMA
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129180502.4069817-22-ardb+git@google.com>
Subject: [PATCH v3 01/19] efi/libstub: Add generic support for parsing mem_encrypt=
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
2.43.0.429.g432eaa2c6b-goog


