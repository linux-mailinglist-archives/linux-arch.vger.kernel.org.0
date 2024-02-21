Return-Path: <linux-arch+bounces-2562-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EED785D719
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 12:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46882281E4A
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 11:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3433482D0;
	Wed, 21 Feb 2024 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GFm1YhzK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5FD481AA
	for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515342; cv=none; b=jT+Xl97dQuJIdwVUimGXz7MamZxLlly5oWiR0sINxodwBmc/Tjw0S5for6DG6/3Ksi7v0ev37FVo1qSg+tUTxtUn64jxcRz4ZOhfRGXo/aEnFo/H7yi30ufWqXRySY/quGjiXa9vckLuv0sR9zDSEo+T62Cnf0rUJ78dv4X3Il8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515342; c=relaxed/simple;
	bh=/B1OP6vbuA5phGZhjfg4uQ2vHMJ2nJmV3L2eYZwfJcM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T+YILn2zkPvEeng6U89PlhnP3x0JR2LKa2oEHtgKPZjk5/IR4fECChnuk0KoFVLC5MIt4BjDCwZhGF7uKmdX6AzdBKBwoUeZZIZzJ+IaQFPJ8dyqLumHWcTqD1K/f7/lSv8vqBm6D/AGAAvl72A6aBpLy2W8owY22WARQzBYhkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GFm1YhzK; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-33d3097ba9aso2578613f8f.2
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 03:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708515339; x=1709120139; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gwOWSXeXshx2pDY4YsRb8c4OJtdf4hRb8S0itmSW07o=;
        b=GFm1YhzKXCOxWJ742d1dqiKQB7zcXqKlcJY29YH5vgmp2CT2n/lZZ7q5jZ//A8FmYu
         UOY+2+kkyFTpnIWYAorBz47xlqkdP9wiO2VjdIp18JRtXbY/S5wP3cvhcr1LdPKwXweE
         lIlRYHcnx4oS4uhh3urfQ2jCVxBuvri37Q2nTInwL7lA4zecL85vrHaYop89H2iDurNz
         34ae5Cg6xoeYRxtTQ1Ifd08bC3pfUKcYgNC2TB16kYFBBEMH8lvVzTzTst+Nf+bWWIHs
         grcfCCnmkI5JjRuWPky9iaBOzDqyNCFyeA9jx9QOexBMhlZguS6A9SJHJLpEhqGQRnAX
         42QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708515339; x=1709120139;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gwOWSXeXshx2pDY4YsRb8c4OJtdf4hRb8S0itmSW07o=;
        b=Jrs42utLELD4Wo0U5OAHJfWq/DuewaairtFFZ+yhpGbS8jDwI0KPjwQbG28VNZcBy7
         pfQPowwQVF3VNGwAAVnymlLa4G92A7KrXyKj3MM9La8PbLvANx0TVlQAk5SEuvRz4SSk
         TdWyTKGb4rcYkyDbJMx0L0Ux93NffX3nODjYOS3w/gt8/4i8XUmjJAwWYJfkga/BopwF
         MNZzFobcOyu777UB/t7EuvODCl+u6xhu7DB4m/O+zw/Q8ogSzab9r/Q+KP/r+kT83leU
         f5htA+7Xd09CvZ1kIiH4muiUBcTOAsoRk418PASTy6+m9x8pEMvS5Qvo/tx7MGJNuAfK
         QHAA==
X-Forwarded-Encrypted: i=1; AJvYcCU1AlU6S0RfNAPvFFaxKtQWT7DXZcGEOtwJtA3em7icsOPoeOVVyOmV8vma8i9r/FsBiK70VZAzd1fUetcSkA6HyIkOfr+8fyI+Kg==
X-Gm-Message-State: AOJu0YzfnAYwK9b9mxMjWWEHpxwqRuxMwb/wMjn5/0jP5dtuzMZ3h2zI
	4TlUa221NpRO6W7+o6WPYGDjRJBk505D0mm/C4emPlzl0yop4hclarcoy/uGrvaKbvxQ8A==
X-Google-Smtp-Source: AGHT+IHY0yDlZceW9DCshrucq0GT/cSofAVrcM+fPLiEfYoqdkQbvMcAdRHU8ZT9iCvMSz0OftA424pR
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6000:1c03:b0:33d:804f:7bb3 with SMTP id
 ba3-20020a0560001c0300b0033d804f7bb3mr2030wrb.7.1708515339021; Wed, 21 Feb
 2024 03:35:39 -0800 (PST)
Date: Wed, 21 Feb 2024 12:35:09 +0100
In-Reply-To: <20240221113506.2565718-18-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221113506.2565718-18-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1451; i=ardb@kernel.org;
 h=from:subject; bh=HV5cVzg2bsj7zm/lufPEjuRMFtl5r6GlxXU96Wc4Zjs=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXq/TfS/Ie8Tyfs4TiZ2dY8/eqXuOJb6hbTC/44bpZM/
 NZ6Myeko5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExk2llGhlXHMqck8tmt/CX0
 Ov6+atSy9U7+7FpOJUqvY+44crG28jH8D31+U3aHolG6bniHk2Phz7Pu3be/MxQ4L/q8NmmSX3w YDwA=
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221113506.2565718-20-ardb+git@google.com>
Subject: [PATCH v5 02/16] x86/startup_64: Use RIP_REL_REF() to assign phys_base
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

phys_base is assigned from code that executes from a 1:1 mapping so it
cannot use a plain access from C. Replace the use of fixup_pointer()
with RIP_REL_REF(), which is better and simpler.

While at it, move the assignment to before the addition of the SME mask
so there is no need to subtract it again, and drop the unnecessary
addition (phys_base is statically initialized to 0x0)

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head64.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 1d6865eafe6a..f98f5b6a06b5 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -192,6 +192,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * and the address I am actually running at.
 	 */
 	load_delta = physaddr - (unsigned long)(_text - __START_KERNEL_map);
+	RIP_REL_REF(phys_base) = load_delta;
 
 	/* Is the address not 2M aligned? */
 	if (load_delta & ~PMD_MASK)
@@ -301,12 +302,6 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	for (; i < PTRS_PER_PMD; i++)
 		pmd[i] &= ~_PAGE_PRESENT;
 
-	/*
-	 * Fixup phys_base - remove the memory encryption mask to obtain
-	 * the true physical address.
-	 */
-	*fixup_long(&phys_base, physaddr) += load_delta - sme_get_me_mask();
-
 	return sme_postprocess_startup(bp, pmd);
 }
 
-- 
2.44.0.rc0.258.g7320e95886-goog


