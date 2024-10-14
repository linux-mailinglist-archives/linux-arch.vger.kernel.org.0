Return-Path: <linux-arch+bounces-8080-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 003AA99CAD4
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 14:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61DCDB20E81
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 12:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B9C1AA7A1;
	Mon, 14 Oct 2024 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fOQVT/Yj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB8A1AA78C
	for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 12:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910636; cv=none; b=h5ctRwLAxr4rk8k4A67Nlko3t7KcF5992dDt8r6g3xKiiKFtDbCJvPFeOkq4lRU9kv16Zb3vHIV5zqFf/zfsG+a4FR2V+YhVsKtKNmzVJvEWNzYrLBO9NLfNHIE0UwqduHNxPt/V7ss2cMO5ogrErizY/TPAhFOkn6NF+dVNhTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910636; c=relaxed/simple;
	bh=Y9/b/wtZYRsm/vDiOxMweK3dyx0nHcdUNMyHEeTnqgA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C6h7B1WZcXTBpPyQb+bB+uWROUvOuVtOW1D0x1ydMk2+yL6RMJPSdC2bJe3bERMxdEDGf5wWBd9rURHXn+79URmkmAPmtQoHFd/+4R/9CT5OYnj2ms28q7dgrR2EvlMEWQOlUawANH7f4PiiSC6DhBZJTu0wNF/RucEUXEoDmjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fOQVT/Yj; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2928d9e615so3548472276.0
        for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 05:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728910634; x=1729515434; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jr6gvJaG1W/UpmtkFcAoLuQg+5nDfK5k6tZ9Bo4jz64=;
        b=fOQVT/Yj2m8ZDbm8A9xDrla4EFkrvwhweWhTNoM6HrdHAcWjzpWFrzDW6px742NUO9
         eps5av5l7U7FZqae4z1hD5KZNlRfbJ8WYH2woCnvUCJdPSrIKfzqurV71HXqaOnUMZhQ
         PydtwXLA9TYp+Or/TqXCgSL14IzfZGq+0G4yiR66swdYiQJTJxldkL2yt19UoZZO6hz0
         0sy/MWysl1zt4Mo3ODaLgMSksleCw5PMV5hBLbByh48b9cvbHElpXDka5nqDPXTW3QnW
         sMMiWVL536JlPbk6AaGwttNtaIlI7NKEF/s7KUxcvGUQmrNxnoCo13XhbrfS8tAzAbU3
         zENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728910634; x=1729515434;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jr6gvJaG1W/UpmtkFcAoLuQg+5nDfK5k6tZ9Bo4jz64=;
        b=JjlJPjo7zFVc6K1n8nl6IE4qgHFoFGx7VfEpKhJ0sVQmijXx8fjr0oxhL2Jvp4xa+9
         yvZ7v0jHtWHnUiqfb+1kpfrBqQqnCReATJikQ55SIMa7g1FPNKHgFc1BKfkVqIXmkX/Q
         6mzRoaaSOOoSbexEKV18XwhInNDnSpFGDrReIzt6BM1HWXqJFugOIMJZ120US9MPRsII
         6wvGG0ygCPf7XBj6GJ8y4EMpr+yo/z+6LI08nBxVUqSPV2w1A077DDykOp11kfLnWBA/
         7ilz2SUXLC5MRGNp52WOh0bCi+VjXwuznGwHSuwpWPxEUkGxaVxo/1RoHm0RqLqDORuH
         wrqg==
X-Forwarded-Encrypted: i=1; AJvYcCUecrQ/Gzpeb0SpTtivEeIp60UVWWwKzJXFHJd3EMA8MsIm8m9wLnwod6SOYn3UYAwK3grtMEWNsWuh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/jZiWc6B44esfEBzljk+Rby/5UNeqUTufo2vB/Yten7a0iIjF
	SQn/N7EMMJN6sbsc3dUXLpv/f+o0bHGM5YUsRljEtitHZaIEOEe4RxmlkjxNWW9FJsHuJw==
X-Google-Smtp-Source: AGHT+IEqZs2ag5HAsjw3w4ECPuvmKzmJ37fRfQ+HNG7wdnrxnT87LnWCSThnt7WZIiUCd09hr/MntVqv
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a25:9cc3:0:b0:e28:f1e8:6596 with SMTP id
 3f1490d57ef6-e2919d523eemr60405276.1.1728910634152; Mon, 14 Oct 2024 05:57:14
 -0700 (PDT)
Date: Mon, 14 Oct 2024 14:57:06 +0200
In-Reply-To: <20241014125703.2287936-4-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241014125703.2287936-4-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3929; i=ardb@kernel.org;
 h=from:subject; bh=XLQa+AmTzeuAR0O/nY3+iU4kWyjdOKPiaa9Oa0UT+Zo=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ1XVPHlsnWbD98/su/dP/0/+j+yM89MPCgYbRZx6Vlc3
 Kze4Ev/OkpZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBEzOoYGX6YbYn+c8Bj/zI+
 9SddFwx59numHtmzpUlw8Y7dAceS/+xm+O/4RWHR6eO8juWFT38urWL+2Hi7LvHC398yx8w6NZf uNuUGAA==
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241014125703.2287936-6-ardb+git@google.com>
Subject: [PATCH 2/2] runtime-const: Use dot prefix for section names
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Sections typically use leading dots in their names, and deviating from
this breaks some assumptions in the existing code, e.g., in strip_relocs
on x86, as the linker prepends .rela to the section names when emitting
static relocations.

  [59] .relaruntime_ptr_dentry_hashtable RELA            0000000000000000 792c758 000078 18   I 56  38  8
  [60] .relaruntime_shift_d_hash_shift RELA            0000000000000000 792c7d0 000078 18   I 56  37  8

So use a leading dot for the runtime const sections.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/runtime-const.h | 4 ++--
 arch/s390/include/asm/runtime-const.h  | 4 ++--
 arch/x86/include/asm/runtime-const.h   | 4 ++--
 include/asm-generic/vmlinux.lds.h      | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/runtime-const.h b/arch/arm64/include/asm/runtime-const.h
index be5915669d23..2c3521765cfe 100644
--- a/arch/arm64/include/asm/runtime-const.h
+++ b/arch/arm64/include/asm/runtime-const.h
@@ -14,7 +14,7 @@
 		"movk %0, #0x89ab, lsl #16\n\t"			\
 		"movk %0, #0x4567, lsl #32\n\t"			\
 		"movk %0, #0x0123, lsl #48\n\t"			\
-		".pushsection runtime_ptr_" #sym ",\"a\"\n\t"	\
+		".pushsection .runtime_ptr_" #sym ",\"a\"\n\t"	\
 		".long 1b - .\n\t"				\
 		".popsection"					\
 		:"=r" (__ret));					\
@@ -24,7 +24,7 @@
 	unsigned long __ret;					\
 	asm_inline("1:\t"					\
 		"lsr %w0,%w1,#12\n\t"				\
-		".pushsection runtime_shift_" #sym ",\"a\"\n\t"	\
+		".pushsection .runtime_shift_" #sym ",\"a\"\n\t"\
 		".long 1b - .\n\t"				\
 		".popsection"					\
 		:"=r" (__ret)					\
diff --git a/arch/s390/include/asm/runtime-const.h b/arch/s390/include/asm/runtime-const.h
index 17878b1d048c..d19f54567d48 100644
--- a/arch/s390/include/asm/runtime-const.h
+++ b/arch/s390/include/asm/runtime-const.h
@@ -11,7 +11,7 @@
 	asm_inline(						\
 		"0:	iihf	%[__ret],%[c1]\n"		\
 		"	iilf	%[__ret],%[c2]\n"		\
-		".pushsection runtime_ptr_" #sym ",\"a\"\n"	\
+		".pushsection .runtime_ptr_" #sym ",\"a\"\n"	\
 		".long 0b - .\n"				\
 		".popsection"					\
 		: [__ret] "=d" (__ret)				\
@@ -26,7 +26,7 @@
 								\
 	asm_inline(						\
 		"0:	srl	%[__ret],12\n"			\
-		".pushsection runtime_shift_" #sym ",\"a\"\n"	\
+		".pushsection .runtime_shift_" #sym ",\"a\"\n"	\
 		".long 0b - .\n"				\
 		".popsection"					\
 		: [__ret] "+d" (__ret));			\
diff --git a/arch/x86/include/asm/runtime-const.h b/arch/x86/include/asm/runtime-const.h
index 24e3a53ca255..0de5a40ee6d0 100644
--- a/arch/x86/include/asm/runtime-const.h
+++ b/arch/x86/include/asm/runtime-const.h
@@ -5,7 +5,7 @@
 #define runtime_const_ptr(sym) ({				\
 	typeof(sym) __ret;					\
 	asm_inline("mov %1,%0\n1:\n"				\
-		".pushsection runtime_ptr_" #sym ",\"a\"\n\t"	\
+		".pushsection .runtime_ptr_" #sym ",\"a\"\n\t"	\
 		".long 1b - %c2 - .\n\t"			\
 		".popsection"					\
 		:"=r" (__ret)					\
@@ -19,7 +19,7 @@
 #define runtime_const_shift_right_32(val, sym) ({		\
 	typeof(0u+(val)) __ret = (val);				\
 	asm_inline("shrl $12,%k0\n1:\n"				\
-		".pushsection runtime_shift_" #sym ",\"a\"\n\t"	\
+		".pushsection .runtime_shift_" #sym ",\"a\"\n\t"\
 		".long 1b - 1 - .\n\t"				\
 		".popsection"					\
 		:"+r" (__ret));					\
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index eeadbaeccf88..da097ba2d4d8 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -914,8 +914,8 @@
 
 #define NAMED_SECTION(name) \
 	. = ALIGN(8); \
-	name : AT(ADDR(name) - LOAD_OFFSET) \
-	{ BOUNDED_SECTION_PRE_LABEL(name, name, __start_, __stop_) }
+	. ## name : AT(ADDR(. ## name) - LOAD_OFFSET) \
+	{ BOUNDED_SECTION_PRE_LABEL(. ## name, name, __start_, __stop_) }
 
 #define RUNTIME_CONST(t,x) NAMED_SECTION(runtime_##t##_##x)
 
-- 
2.47.0.rc1.288.g06298d1525-goog


