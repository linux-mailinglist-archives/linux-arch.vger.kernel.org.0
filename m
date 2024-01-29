Return-Path: <linux-arch+bounces-1788-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B62A8411AF
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 19:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAEC1287BBE
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 18:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAB515A49F;
	Mon, 29 Jan 2024 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I1V788Gb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F39915A485
	for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 18:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551558; cv=none; b=eRqb4fHiFzfC1/X3RWstHBGozE5uTcvRZNaw8w5pOVdZUzucZikp2abOSjuU85XCCoNbnVSbOYHN0MxYvHpHaCrV7RfQ02BA0fTEf6PEfivJ/KEFRlIoig8SaFBd2Cwl81KwRC66SqczFQyLe3hd1LkTh8rndZqDhgtv1tTIkDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551558; c=relaxed/simple;
	bh=BHUup4Ao15H5a0x4s+HXfGoWgWU/14gkkZKIK0ZXAdk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hjviLRNptwlypvTGWQrbVtwNlz+riX20FhqoApUHmBhyUp7h+Y4TQoKrTabsFLD6OwXg5U/hx+MPsmGMHY4pLHCQTwmbvZB4fWH1YyWI+/FT6vPkefTskE0PN7W1rZACYzbNGrVfa5hlnhfNxhETbztdIMuEFNP7Vf0QQe/iTao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I1V788Gb; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-40e40126031so28490775e9.0
        for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 10:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706551555; x=1707156355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=usiDcusxejCbluC36Vpk0on80rVNZ7Itzv8e5WwmSQI=;
        b=I1V788GbqvKtKxxYQnLQzkd87zUujtwsJrEsJtzWQtl7X1BEhozGG3JraJCpp6pEAT
         wjOnayYq44aWOdRcgjaYdefkwCD532Aw3Awogc8dGVhjbMDxL2/8WiEKC+7ksff3GRkE
         MYP6U+QivGClA9HEiE4ve+CxSty3BXEGTJZobqd1MIBTcJ9Ewi/mSSFtQ2x/04NjNAN7
         xpzk3Xop3BJh3sDvfcM3d3HamVDH7wI4LeemoYRMI5udVyRPe+KUiZF5fX+X8Djjg8hJ
         qYgUK9VBReJpA0xc/5IbQl4iAijpH1zpSNzcaXHDyuT+OX20QIxmTQ2p1wSt5FED6gJ6
         BNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551555; x=1707156355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=usiDcusxejCbluC36Vpk0on80rVNZ7Itzv8e5WwmSQI=;
        b=us2ISXUmsL3s3GAyiGxEqFY9GQmfeqdLuLJ6G3k/76NuZm1TyKlbtHk/Mzcs/FGrfA
         lXzg8jbu5gka08NssIiaRPWktiNK+r/Mqe5WCHdILrTEVoGyXwKukdLlFQDznFwzPT0H
         wEeOA/E4erAUgM/T7Zcia3sPCKtk71ryfjnl2jB1Ar0O7Itc0hsFTxYJD4/x7HzHgc1g
         xhRL2jE7n8CubL1KugiOTbPB1DXoCUxUg/euQk/sO+bFwEKYTAu0tn+zJMrtrEsO6Zqe
         2uAReX72Nly6zQM6610kJoupdZ5fGpCk0cXoJAFi9hiozMz3fNDQNZ0nSkZw89z/QjF/
         v1Ng==
X-Gm-Message-State: AOJu0Yz8n3rhpN9Nqvz6latp5B4u6cd/mNcHwqHY5WUUX6RF0DUN+BF0
	jPm1QsflDmWeiGhvi/w/KGpfelKIOzB0+hjxcNOKdmvLZUTzmNAWScpe2k7iHEEsGhWNTA==
X-Google-Smtp-Source: AGHT+IEH4d52wGH8vbNwfzvpV2wqsfdLfYYhb20TejcQqFRaHlU9GjFY3tNK9qHPkBnSWswi3vS1ehXT
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:1d88:b0:40e:f9fa:14ea with SMTP id
 p8-20020a05600c1d8800b0040ef9fa14eamr11573wms.6.1706551554793; Mon, 29 Jan
 2024 10:05:54 -0800 (PST)
Date: Mon, 29 Jan 2024 19:05:14 +0100
In-Reply-To: <20240129180502.4069817-21-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1335; i=ardb@kernel.org;
 h=from:subject; bh=+Hn8XwOONyFACfVl0+TV+ToDQrCQwdquUdW+H4YgWKM=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXX7i9u7Fp4sj3V7udXtpNY9MXsR10NPBb0cuP92X1ry+
 VW5ZJd4RykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIfTOG/9We01eGNZ24aN3g
 GLjUIHZG9EL9Tn/mrwzhRufLA4NNixl+s9z50czfGr3v0OlmYdt8rSt7pp3lK5l6zCp89pbDm8z uswAA
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129180502.4069817-32-ardb+git@google.com>
Subject: [PATCH v3 11/19] x86: Move return_thunk to __pitext section
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

The x86 return thunk will function correctly even when it is called via
a different virtual mapping than the one it was linked at, so it can
safely be moved to .pi.text. This allows other code in that section to
call it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/vmlinux.lds.S | 2 +-
 arch/x86/lib/retpoline.S      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index a349dbfc6d5a..77262e804250 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -134,7 +134,7 @@ SECTIONS
 		SOFTIRQENTRY_TEXT
 #ifdef CONFIG_RETPOLINE
 		*(.text..__x86.indirect_thunk)
-		*(.text..__x86.return_thunk)
+		*(.pi.text..__x86.return_thunk)
 #endif
 		STATIC_CALL_TEXT
 
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 7b2589877d06..003b35445bbb 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -136,7 +136,7 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
  * relocations for same-section JMPs and that breaks the returns
  * detection logic in apply_returns() and in objtool.
  */
-	.section .text..__x86.return_thunk
+	.section .pi.text..__x86.return_thunk, "ax"
 
 #ifdef CONFIG_CPU_SRSO
 
-- 
2.43.0.429.g432eaa2c6b-goog


