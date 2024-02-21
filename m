Return-Path: <linux-arch+bounces-2565-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0970C85D71F
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 12:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AD731C22FD9
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 11:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8F64C602;
	Wed, 21 Feb 2024 11:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yoKn8IIl"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77A445BED
	for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515349; cv=none; b=Ll3ZSfkVIzjcnD3DcU+ZvVCuUxXQPIv5xsUp80NZMSfcZimUjKkzi/x32DROuZFkmMfzQDdr8cA38LogUkhAWwPsUeyo+anB9UWGl8PqAli842FKBXDA/qxQx9YHBjmitiIMcCuqBkjjUmBI+0AdjUTmlXjdfX33JGz4uD7aAeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515349; c=relaxed/simple;
	bh=GAlPtq8JkQJ3A2WVw8c46QbR1WtxNjQfx1w8AVpPTjc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kzMTYKZnkG+1bJho1PtFODPzrkZvK7v8IqtjjpoVROoba2R9VDyLoqDe+Za0DG4ZGA1Zprecyc/POp2uXgeoaCRZMW5y1shI65L0Kc3ZUeLO8Vlkkd2AMaNNx6nqHqBiUuOzzgTHx7W8gA3hVcWbOJhFN7xZUEj+4T+N4VeI4xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yoKn8IIl; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608575317f8so35420587b3.3
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 03:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708515347; x=1709120147; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mh8YQtdjDFBeR5IIfvtfOkH3iYneTElPPQWzRP3dQ5U=;
        b=yoKn8IIlNUE26g5hYhsL1NTTncQyij9u7eThJAI1n31mtRwVIUbMO+3bu8DBrMeK1/
         /9tmcPZhQOXj2cPSN20U0RoUnEgKacAlF91tOZRn7oJJ7dRQyJlZtogAx4jeXUTGXS2w
         h3L4azD7aePLTJHCavuwYWbDOVXMSLm7W5YUsRspBZtW9UBqza77wkMZhBVLG2w3tJoW
         qOAkYTzo1cZUumRgQl7o8S4r5zKKKbnZqkCGn4P5I4lK+9Pn42eq2OZLxppNWrUHxKJt
         Ybe2qaTZA3zbvj/mLGqnpeYeYSmb+mfGi5UpB4X08PB6+4pSlA+2V0VjgRmFIqpQ71aB
         MSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708515347; x=1709120147;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mh8YQtdjDFBeR5IIfvtfOkH3iYneTElPPQWzRP3dQ5U=;
        b=gB/RxXWdZQAa5t/GWJcXAPD+RthASyQmI4Ru7yxjbC9sOQFyd2Ln4RM+OMo3BofSLW
         Tg5Kawr7JzkbSeWdjfw4wg0liaO7ew+4/YynSSJQNwCG5BVFhqK87ryvvxtcyIrFqh+Y
         Qtl1aFtUuFKM74NKB99hg37q25oBhQ722iMSkc2suE4cZzp+lBrzKcMwNrbwtlxZk1U/
         vh6o3FylFqljR1VFOb+Kerrg4DEdpFrvEXu34XbougxoZLajsV5vfnQXX9/jZm6vIwj3
         u96sDnlyz39DTIbh5OuK/NWSAbGwni6zkqybSj8rqBPevsfWQrPyRgS/grnn5aJJiMNa
         MW4A==
X-Forwarded-Encrypted: i=1; AJvYcCVtkBhx/Niglpx5GusIomCuzlO6k2Ow8b5X1PhAL3mnAeIWosQbILQUOvqRZ+a+xKFk8UWs2F965hJKd+QhpALhuGf3VKmA3ngwMg==
X-Gm-Message-State: AOJu0YzaiROnWHaTQMiXqae7922VyuOSl8If977GHJO2oWCxz4qiOXHr
	FxAS4kEzPDvSB5jDg/mwoze0CuQGzWBt5WQ+3STnC1lHTR1iqtMPGwYQSVI/ZqoBeBqBow==
X-Google-Smtp-Source: AGHT+IG0fEnqGUG8+oiRHZDhntx0M4FmHH2tN93YTFeHU2r24HPHbQJjdVqv46rLLzginl6PjhXpfFFp
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a0d:e6c5:0:b0:608:801a:e66e with SMTP id
 p188-20020a0de6c5000000b00608801ae66emr232627ywe.3.1708515346559; Wed, 21 Feb
 2024 03:35:46 -0800 (PST)
Date: Wed, 21 Feb 2024 12:35:12 +0100
In-Reply-To: <20240221113506.2565718-18-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221113506.2565718-18-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1582; i=ardb@kernel.org;
 h=from:subject; bh=cvzedKkAgUYV71bwW+wRLG9NvEsRD1LqBxLDjio6avo=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXq/XcfP02y/sG1PGlJDc9qpSi1Q69MXf6u41urqrbMb
 sH7yR81OkpZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBEJmxi+B/G7rLguUZMl3+R
 0vtNEibBlX9ZVJt10g8o/TM9Ily2zY2RYZFpSYf4SxEfXrMP20O46g6+2tbuk+T93lr0pKL5u+8 PGQA=
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221113506.2565718-23-ardb+git@google.com>
Subject: [PATCH v5 05/16] x86/startup_64: Use RIP_REL_REF() to access early
 page tables
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

The early statically allocated page tables are populated from code that
executes from a 1:1 mapping so it cannot use plain accesses from C.
Replace the use of fixup_pointer() with RIP_REL_REF(), which is better
and simpler.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head64.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index e2573ddae32f..7e2c9b581d58 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -215,13 +215,11 @@ unsigned long __head __startup_64(unsigned long physaddr,
 		p4d[511] += load_delta;
 	}
 
-	pud = fixup_pointer(level3_kernel_pgt, physaddr);
-	pud[510] += load_delta;
-	pud[511] += load_delta;
+	RIP_REL_REF(level3_kernel_pgt)[PTRS_PER_PUD - 2].pud += load_delta;
+	RIP_REL_REF(level3_kernel_pgt)[PTRS_PER_PUD - 1].pud += load_delta;
 
-	pmd = fixup_pointer(level2_fixmap_pgt, physaddr);
 	for (i = FIXMAP_PMD_TOP; i > FIXMAP_PMD_TOP - FIXMAP_PMD_NUM; i--)
-		pmd[i] += load_delta;
+		RIP_REL_REF(level2_fixmap_pgt)[i].pmd += load_delta;
 
 	/*
 	 * Set up the identity mapping for the switchover.  These
@@ -284,7 +282,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * error, causing the BIOS to halt the system.
 	 */
 
-	pmd = fixup_pointer(level2_kernel_pgt, physaddr);
+	pmd = &RIP_REL_REF(level2_kernel_pgt)->pmd;
 
 	/* invalidate pages before the kernel image */
 	for (i = 0; i < pmd_index((unsigned long)_text); i++)
-- 
2.44.0.rc0.258.g7320e95886-goog


