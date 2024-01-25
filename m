Return-Path: <linux-arch+bounces-1564-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5751783C0DA
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 12:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA7391F2417A
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 11:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6027C321AF;
	Thu, 25 Jan 2024 11:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y9Cdx3//"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22C12C69D
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 11:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182363; cv=none; b=Q+n4TuXBLpVbKsOVMCQzqNWNgHm662bDpvwyJv2BtldkJqH16vBIGBf16lSJOUNzTletaw21gv0U8CpYKdNyqUdz2T5T6AnP8V+rfpXiWRP4xwE+AbIe9vBu8wcke6Wl8b7SJN+e/L8kIM7MUPvpKGOB57J4tVS2ngv1hTNBR/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182363; c=relaxed/simple;
	bh=ksYtquI/zNJoo09z1kn9EIIXegn4h7RVzbkZ+iPv7gQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TDa2wLBHY9ulS70450XvmV3x0TS5+CRU3YKsK/9VMxRqQJfKhu1eb5/fsFTDdAyfBx9m2gFVEszIyGmD+UukPkV0HzoDhiTck7hVIUwPt+6c0TnvDgCxChsC3v7XQEMo5xu1gXayn5rhzcV62vb0moES0kprKwB/hLADmERpU20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y9Cdx3//; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-40eaf5c52d3so34985925e9.1
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 03:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706182360; x=1706787160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VlzuORvF37cHhQgjoovr2a86HYjlNB8YTzXdR4Eq8S8=;
        b=y9Cdx3//r/vJpa/ctay760QmH747x6gRelL35ji6SSGpB7W1WT+qbtofUZFip8ilLN
         Qsj+Wob4Eh++Z+EFqd2glypUpg8sQioa3IcHyxrU3TFcfK4xv2cICDQRTiVpK7JpCA2W
         Nw5lC+luKKdAXrDKhL6z5b/81pbQk8p9QV2tNJs2PY2rEbeEF+mv7tBUN/W7coa3LiC7
         i4WPUl6RRCcNk6cN5QPn2WWufat0n1YCKnNNI4AV185nnOfJ8d1Z6PiX0zfgpQHxhYHG
         SECQyLJFUBT7I1j4+PLzdPKzROI+KZFd5ite/NN1pRgHVpCUrkEXr5qBpXmj0NISsiKA
         b3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706182360; x=1706787160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VlzuORvF37cHhQgjoovr2a86HYjlNB8YTzXdR4Eq8S8=;
        b=VRre94Z2OoFzv+UqgTbvQdFDz0UUOwTbnCCb+V3wNlbKTUZzG1LyRpDGJKIv92iTol
         lS0Q9D0FDJINM5xnsvuL2miuOFwKaH+clwRGdDwMa3tkatMB+mtNO42154mV+3oeWPo7
         H4Wrknk5Z6Y7hMdHqmGDjpP7KvOF6OFpzzwSb2XQwr0SgI5RYgZyIqZ86am+rtLz/Fuq
         hriqraZ/2LOsFTb7AX++wtGJVQ5NjW8cRs70WoJAcCO95V0smv76eoOlNaYPiR1v3cd6
         ztnKA088JS1+GOpuIPsxDxePYWkE4x3v6ccCV9EuI9fdSs5cyosks9CsNC/Fb9Z1/REq
         PGvg==
X-Gm-Message-State: AOJu0Yw/TmSnvv9RWUWMLqV0hWjPqu6nrpqRVpbeoZ9NRmtJ8sojQ/Sx
	V2epam61wN+vKgN+eK7eJ3KLE+SL0Mt1EsbjmFpdPaeALP25ttucmdCa1qMpX9i+O/610Q==
X-Google-Smtp-Source: AGHT+IGtY7tYLIru0pd93LO7EN9LsWVAam3Z4OJZtE1j4M5l3m+txD1KEhKBcaP4jOsokdvWjxhxtIdH
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:c0f:b0:40e:d1ab:3421 with SMTP id
 fm15-20020a05600c0c0f00b0040ed1ab3421mr5142wmb.5.1706182359900; Thu, 25 Jan
 2024 03:32:39 -0800 (PST)
Date: Thu, 25 Jan 2024 12:28:20 +0100
In-Reply-To: <20240125112818.2016733-19-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240125112818.2016733-19-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2268; i=ardb@kernel.org;
 h=from:subject; bh=TSUaLCMOyIRIkxI+e58H4dzOT8JQVh2xiOSo20k09Yg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXWT69WZTg+YSttzMxXl1N4f2yxxuu1fZ8zluTsOCJY1N
 PRMiVzfUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACaSGcTIsGH3y0MrT1/cVLj5
 bzrbMoGWoqPnJwQ3XZov0mO0bfWKo6aMDP+ecz9d8DR0D9NBuZinnFO5PjzMFnn5V+p00feprMs 9g/gA
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240125112818.2016733-20-ardb+git@google.com>
Subject: [PATCH v2 01/17] x86/startup_64: Drop long return to initial_code pointer
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


