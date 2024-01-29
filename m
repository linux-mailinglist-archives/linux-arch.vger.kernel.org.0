Return-Path: <linux-arch+bounces-1780-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 757D984119F
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 19:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4931C23997
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 18:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DFA3F9FB;
	Mon, 29 Jan 2024 18:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N5GNZ1+H"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2036F093
	for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551539; cv=none; b=btvQOlUwl5Zr+jjUYIJ9MCfq1/WNRzTGf/fAs3gsxdNJ47vKGt4TAZNAEtYRIhcoZt8N0Gqk6ZTXZlLGQNzLdvGHwEfnLaSvRFysEYx6Hw9EcD7bvZwp5XFeg2qqmeLw1y7Cd2eux/QznViCtjsSVeK2WhqxY5RflUkuWnxEDII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551539; c=relaxed/simple;
	bh=ksYtquI/zNJoo09z1kn9EIIXegn4h7RVzbkZ+iPv7gQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mPCerUWbYB6ycF1/mm0lcb8wI+odz6RU/HC4eb2i3YrLGQ/fc4ek8pKzCTHqaZHtOQ8QHTXxpv7UAZDWu3iH2OnwoClh2jQIVAl5Vjx0X25dIzQ21h4UmLCUo2PHNVmF7g9iRCBuwsVbR+QKDo7AQ93KTGjFDF5AqctVWz7aCiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N5GNZ1+H; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-602dae507caso48466927b3.0
        for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 10:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706551536; x=1707156336; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VlzuORvF37cHhQgjoovr2a86HYjlNB8YTzXdR4Eq8S8=;
        b=N5GNZ1+HcdiMDaLoHriuiPIQ11RvN29Xx0ePSgvy2/TcZEUqNV476uWVlc5098jmV3
         xp83LLEGPdgFnE8JTCrQrqjrOGwHRLfeJqtwmWg6lYstTdofsuyD/K22sfxFugdgwlWy
         ZP5uczstj19b0jCTfSyQINffGtO6p/7j/q2d1RNLMUkgmUNxqKYzM+pixGreb1NyhwiV
         QwFgxKa6LHA9JInQlmzSFjYtq0KdAzM2X9guUTUQ2EzdKy6IbOvJBBRJ1g5dbc3TsZSg
         bllZHKJrS+mIjlPL9JlSFz/Y+D45PA6aiCRZvfV+zWg5HX0vHs3Le6QcWfnLlu+dS6Al
         jLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551536; x=1707156336;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VlzuORvF37cHhQgjoovr2a86HYjlNB8YTzXdR4Eq8S8=;
        b=tUjAjUHsdYUlpM8nTe3SaJ78mpumKtPL9II7F9U6jd4VrK1igJ0D2Dpvd/oPazDtem
         2hrQvJUebbqHwZH2OHbqHb66sfEvDHygS7BsVoD0jHsLPjKRQCgaw/gpJWiK3EhQSJYl
         sEMaq9khrlVJ3zvzsBn3SiouuecZO3PCPLoLrKGtSqgmaT1gprijOk/OFIw/evBbWr1I
         GIylmwS3RT/2w6lyYTI4tUiUqxizkdMmDuJf+kYk1PmwfviHfBSWuTTpVpDBA3kVLlLP
         gojOXAWAxgbGnTgJLupTvxxw0ItcUu3nRNavUe24nt+LOAg0ikMAKm7o8EI2AVM6+64A
         +eyw==
X-Gm-Message-State: AOJu0YyuWilLJNPRUk2HI7LcAr8y4C5t/NQd0+Q4OTAdQNr8NSlLGJtw
	e+Az/e4GDCwfpUamAsyT/hR95xHW+GvuDUQ7NkadqnL6GdSb4V5B/TJdRbuPzHOgj8FuGg==
X-Google-Smtp-Source: AGHT+IGM+P7GQyXug67b8mdUFbt5ptfNQBVn5gYHUdfmOmMI6DLMe8HFvy5Binsc1qtv+dC8mi8TsPNt
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1b8d:b0:dc2:2f33:bc28 with SMTP id
 ei13-20020a0569021b8d00b00dc22f33bc28mr2399097ybb.6.1706551536040; Mon, 29
 Jan 2024 10:05:36 -0800 (PST)
Date: Mon, 29 Jan 2024 19:05:06 +0100
In-Reply-To: <20240129180502.4069817-21-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2268; i=ardb@kernel.org;
 h=from:subject; bh=TSUaLCMOyIRIkxI+e58H4dzOT8JQVh2xiOSo20k09Yg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXX7i0sznR4wlbbnZirKqb0/tlnidNu/zpjLc3ccECxra
 OiZErm+o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzEVpXhD0+FxcHZC/v5WsNe
 XhTRq9Et+jDvZFyi/tRpcvrJhS3X1zAytLxUqjGVObPST0DFle299G5uPgeeD8eX7t+/rfqL0pE 8BgA=
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129180502.4069817-24-ardb+git@google.com>
Subject: [PATCH v3 03/19] x86/startup_64: Drop long return to initial_code pointer
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

Since commit 866b556efa12 ("x86/head/64: Install startup GDT"), the
primary startup sequence sets the code segment register (CS) to __KERNEL_CS
before calling into the startup code shared between primary and
secondary boot.

This means a simple indirect call is sufficient here.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head_64.S | 35 ++------------------
 1 file changed, 3 insertions(+), 32 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d4918d03efb4..4017a49d7b76 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -428,39 +428,10 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	movq	%r15, %rdi
 
 .Ljump_to_C_code:
-	/*
-	 * Jump to run C code and to be on a real kernel address.
-	 * Since we are running on identity-mapped space we have to jump
-	 * to the full 64bit address, this is only possible as indirect
-	 * jump.  In addition we need to ensure %cs is set so we make this
-	 * a far return.
-	 *
-	 * Note: do not change to far jump indirect with 64bit offset.
-	 *
-	 * AMD does not support far jump indirect with 64bit offset.
-	 * AMD64 Architecture Programmer's Manual, Volume 3: states only
-	 *	JMP FAR mem16:16 FF /5 Far jump indirect,
-	 *		with the target specified by a far pointer in memory.
-	 *	JMP FAR mem16:32 FF /5 Far jump indirect,
-	 *		with the target specified by a far pointer in memory.
-	 *
-	 * Intel64 does support 64bit offset.
-	 * Software Developer Manual Vol 2: states:
-	 *	FF /5 JMP m16:16 Jump far, absolute indirect,
-	 *		address given in m16:16
-	 *	FF /5 JMP m16:32 Jump far, absolute indirect,
-	 *		address given in m16:32.
-	 *	REX.W + FF /5 JMP m16:64 Jump far, absolute indirect,
-	 *		address given in m16:64.
-	 */
-	pushq	$.Lafter_lret	# put return address on stack for unwinder
 	xorl	%ebp, %ebp	# clear frame pointer
-	movq	initial_code(%rip), %rax
-	pushq	$__KERNEL_CS	# set correct cs
-	pushq	%rax		# target address in negative space
-	lretq
-.Lafter_lret:
-	ANNOTATE_NOENDBR
+	ANNOTATE_RETPOLINE_SAFE
+	callq	*initial_code(%rip)
+	int3
 SYM_CODE_END(secondary_startup_64)
 
 #include "verify_cpu.S"
-- 
2.43.0.429.g432eaa2c6b-goog


