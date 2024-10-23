Return-Path: <linux-arch+bounces-8503-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BA59AD7F4
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2024 00:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 841D11F243C8
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 22:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681A62003A7;
	Wed, 23 Oct 2024 22:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y15+4WaL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B361FF7BD
	for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 22:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729723475; cv=none; b=HoXSqMbpa9Ezal/KnEB8GSg2N5FySW23I5JpE20atH9eLWmIRPfg9/LGsxB+E+zCeCGBc+/wA6tztFmJUd8EOPh8UR5a32OllPjzslhPDTFbcDFV1DY3BfbyrpQ6I0vsHabXJLCq+bxqFfD20Zp9PwtaTybQaCJE8iiC4isIu5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729723475; c=relaxed/simple;
	bh=XCT6aaTLHKjPcWknzKtL2kN2dgyL7VsWQXuDCGu+eS8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z0KmW3GEMWEn5qS3baRzxYHdjuZVewUIQXtZ1KMJGZKbSFwOJU3OYt7kB5uH5+lEiLs1PCZJq2nzz6Y2M3/C9Rp6bAGDt3iuTGlYgGlwtegtsysn0qYlf3ZSwN9vNpEfMFUHcWgHBRJ79Yy5O/y+LUq9M3pM6fwOiFld5Q1MSQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y15+4WaL; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2bd4b29887so516099276.1
        for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 15:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729723471; x=1730328271; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/vLG0anO7BwgfLeQ/LDy3VoS1eB3+zLyO2ls8DxPK6U=;
        b=Y15+4WaL9f2YwCx9FobQYnPOV/9bX7RSrqLtTofv9PGFGi24GFoq3ey7XRRqj+wrT/
         VHJ/mZLyQpSqk3CdTq1b3GQ2B0QIi0zNrIo+sFgIQpY0HeKFFWBpRqVECPw8swWyN1jP
         nz6ZWttz80n6Y3ZohdQwd2FaIm4LS181iuxT00r85dECNRHU0b8ydyaHkLOG3EomeON6
         h3fKLlahVk1lO0lRDw/GHUUmIGOyMa3AlxRqy09Z8/TpLZeFVApCdJET6ye68oQZXin4
         PjKSnQiTh4nqB7utMMlbRUD3LJftCOx5FLnCvmHfF52rvF43A8OC3lb6n89iUEAwsqYV
         qsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729723471; x=1730328271;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vLG0anO7BwgfLeQ/LDy3VoS1eB3+zLyO2ls8DxPK6U=;
        b=YyNafS5hpF9IhJgXu1sQbVmFpQ2pHu3Ssvx7yUTcGL7errf3/pJiCDv6OQ/Khbmbn+
         7bLP7G1kxQ3e11RtgasKa/DMohmBfTdvLR8gT5tPzMp0KYCew3+KjS7A9tuO0uKjeS04
         lCdYPq0c6n+z/xFJuamqsnRbRj1GWlmNMhOAGM5wMia912pqz02imPCha7vUnb60K1lv
         9Eb4zIPVxIHh1mOrHGN8urlolijlY2phevK6bMTyp91gaKsu5cDH3tvhEOIIk0lfDbTO
         pX/phr2vY1m4Zequ3jFoa6+lYqaysK35c7H5YIFtf55DxSO0wSbPO0rP7SnWvaOaFysG
         LgOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtN/haIVhCT+9JcG9NJ/1K7G2W+mvt1cs3+zkvKxTJNkqBAiXlFMNmnUofBx/2Ra7RnFt2L2tWDUHo@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3dUwJAYeMYVm22Wuy2vJpxb3lYudRCClCDjHpIpMYABsxQwsS
	/P8DgonrMvt8ahZ0YDsNw4Yim/wHbzajFBZ1Iq29nQOQ1rzsN3jfUr8+pkM62kOSKw==
X-Google-Smtp-Source: AGHT+IFVfeyPxqRI2j0ASqUhKvoQx2zCQAV5DC4JpUQnoNgn6IsLNLrBhRCJGUXKM0TlEVsIqSS9Uj8=
X-Received: from xur.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2330])
 (user=xur job=sendgmr) by 2002:a25:b307:0:b0:e25:6701:410b with SMTP id
 3f1490d57ef6-e2e3a652cf0mr7023276.5.1729723471236; Wed, 23 Oct 2024 15:44:31
 -0700 (PDT)
Date: Wed, 23 Oct 2024 15:44:01 -0700
In-Reply-To: <20241023224409.201771-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241023224409.201771-1-xur@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241023224409.201771-3-xur@google.com>
Subject: [PATCH v5 2/7] objtool: Fix unreachable instruction warnings for weak functions
From: Rong Xu <xur@google.com>
To: Alice Ryhl <aliceryhl@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Bill Wendling <morbo@google.com>, Borislav Petkov <bp@alien8.de>, 
	Breno Leitao <leitao@debian.org>, Brian Gerst <brgerst@gmail.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Li <davidxl@google.com>, 
	Han Shen <shenhan@google.com>, Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolas Schier <nicolas@fjasle.eu>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Rong Xu <xur@google.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Wei Yang <richard.weiyang@gmail.com>, workflows@vger.kernel.org, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Maksim Panchenko <max4bolt@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Yabin Cui <yabinc@google.com>, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>, Sriraman Tallam <tmsriram@google.com>, 
	Stephane Eranian <eranian@google.com>
Cc: x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

In the presence of both weak and strong function definitions, the
linker drops the weak symbol in favor of a strong symbol, but
leaves the code in place. Code in ignore_unreachable_insn() has
some heuristics to suppress the warning, but it does not work when
-ffunction-sections is enabled.

Suppose function foo has both strong and weak definitions.
Case 1: The strong definition has an annotated section name,
like .init.text. Only the weak definition will be placed into
.text.foo. But since the section has no symbols, there will be no
"hole" in the section.

Case 2: Both sections are without an annotated section name.
Both will be placed into .text.foo section, but there will be only one
symbol (the strong one). If the weak code is before the strong code,
there is no "hole" as it fails to find the right-most symbol before
the offset.

The fix is to use the first node to compute the hole if hole.sym
is empty. If there is no symbol in the section, the first node
will be NULL, in which case, -1 is returned to skip the whole
section.

Co-developed-by: Han Shen <shenhan@google.com>
Signed-off-by: Han Shen <shenhan@google.com>
Signed-off-by: Rong Xu <xur@google.com>
Suggested-by: Sriraman Tallam <tmsriram@google.com>
Suggested-by: Krzysztof Pszeniczny <kpszeniczny@google.com>
Tested-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/objtool/elf.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 3d27983dc908..6f64d611faea 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -224,12 +224,17 @@ int find_symbol_hole_containing(const struct section *sec, unsigned long offset)
 	if (n)
 		return 0; /* not a hole */
 
-	/* didn't find a symbol for which @offset is after it */
-	if (!hole.sym)
-		return 0; /* not a hole */
+	/*
+	 * @offset >= sym->offset + sym->len, find symbol after it.
+	 * When hole.sym is empty, use the first node to compute the hole.
+	 * If there is no symbol in the section, the first node will be NULL,
+	 * in which case, -1 is returned to skip the whole section.
+	 */
+	if (hole.sym)
+		n = rb_next(&hole.sym->node);
+	else
+		n = rb_first_cached(&sec->symbol_tree);
 
-	/* @offset >= sym->offset + sym->len, find symbol after it */
-	n = rb_next(&hole.sym->node);
 	if (!n)
 		return -1; /* until end of address space */
 
-- 
2.47.0.105.g07ac214952-goog


