Return-Path: <linux-arch+bounces-8505-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A006A9AD7FA
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2024 00:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCFEB1C22688
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 22:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E0B200B9A;
	Wed, 23 Oct 2024 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KLUhPZN6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F404F200113
	for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 22:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729723477; cv=none; b=mP+4UJFj/cuMr3dVj2J+SCYccsQJ/8Km/WCvG3gm193Hxbl70VbuSTukJbggk6zAgOlxbR+jAs7DvDxBNvvNappcDP2SInaBPsuK97aphCGH4il8c4NPkr8rZunI89x5kaqjMZpTFNVEJuvsD20cxjb/s7Lgxz0tO8qBa1DxiAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729723477; c=relaxed/simple;
	bh=3Jbi42B7MMxAUyKySYJN1PoZK89JNHXGH1zqEMYynH8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sAMuab5+CtmSVfiS8yQXFHpuocDkjVTPwcRt5ckQRsgW7fIoeEskZHMumKXgb1RLHEQt1oZfmNxGEMhA3bMGs9V5K8bz4MjUGuLSFj7AKoTREIJvmjkgFgpKuVTgP50/DuBifyIPYKMpjSHRNQ2/YNYhzNhuWtHAEdJ30Q/t150=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KLUhPZN6; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e1fbe2a6b1so5987337b3.2
        for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 15:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729723473; x=1730328273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LIBp2l/GHqrPAEiRmUPoNj56KvivSq7/gCNmPiHnCkQ=;
        b=KLUhPZN6DV9Hd9UqMa1zDYB9gkvHDkhkFHJanhWde2Zgn8NB/Z62e+tJBn7H6OmZY2
         /Ozku0bl10cRLzBclPUQ725CW/xdhykoDl+xRbI9DJzKwexOjjDId79+PUABo8LdGgSQ
         tNdps3fuS1Ucj7Gm+kj7/r31NYCxL3wW25XhgyFZEyseB1lGL5Eq6YR4p4nrWNYItB8n
         Ye+v2Zy22CQuAPc7YbSa74MJiQgAnoYI6akKX32JHd5dQhqVoRHfnvd4SdAqXT2dOSlh
         1NmDNpjVPbR2QbdSeG2pF6MzhMGrnugTxeOP6LPt4OmZV8D6VYjZB/ywfM0pOGIQOJpP
         K/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729723473; x=1730328273;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LIBp2l/GHqrPAEiRmUPoNj56KvivSq7/gCNmPiHnCkQ=;
        b=iPX3rUdlZ8QKed5b/mKeczRGDz5B1P7uk5uKybeguRBXlDXXl4sXqGoo9XrdPghK2v
         uWP5YCAoFzQ9qUkHN1F8hZtiGqF7BZwaPxqsIZ/K9/CF7MmoBPeeEBrC7bqnwf6ou35v
         ARaRnYRHX2Jf9Zc6JAp+8qtld/ZzPBjs1JjlSooUk2XIrE6TaUOaGyq716FxVsEw+n2J
         X6mvFlstq7sIiIEaaTbGYHAwg3lWBuHtwQRbpYziEPWmcKXjYy+6lZutL+CAxD44PewU
         Sw580pmDN6TgRvqh08u8APM0OLBAaLyVjURrz9Ny3q2lk6SFzC9mLsVDU+yLvSQF8HQX
         q9kw==
X-Forwarded-Encrypted: i=1; AJvYcCVOZA8GaGU9XqXOmB83W0xUj9oA3cf0EoKUqP1nJEuWMJhEnqiLUeWhzFuwoAsKlpMChbvTH9oZYVHp@vger.kernel.org
X-Gm-Message-State: AOJu0YyKmzl8NdtKwpXsi+xlOXJOKahE92KLGwaUhi0LEes2wsZnh2F3
	u9QUMnSvmstIGOS0t3VrPGuaf66WROcrzJoZ+puJnHNIWojmbbNMsWa0b6Amql4ubA==
X-Google-Smtp-Source: AGHT+IED6bhx75V0sSfMV/OQ93Tz4In7ZYA9aOg954NRkaZQI1kaQhNFY4eirsaXsu6I63QGL5SLgN8=
X-Received: from xur.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2330])
 (user=xur job=sendgmr) by 2002:a25:26d0:0:b0:e28:f231:1aa8 with SMTP id
 3f1490d57ef6-e2e3a60a6f9mr6900276.2.1729723472853; Wed, 23 Oct 2024 15:44:32
 -0700 (PDT)
Date: Wed, 23 Oct 2024 15:44:02 -0700
In-Reply-To: <20241023224409.201771-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241023224409.201771-1-xur@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241023224409.201771-4-xur@google.com>
Subject: [PATCH v5 3/7] Change the symbols order when --ffunction-sections is enabled
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
Content-Transfer-Encoding: quoted-printable

When the -ffunction-sections compiler option is enabled, each function
is placed in a separate section named .text.function_name rather than
putting all functions in a single .text section.

However, using -function-sections can cause problems with the
linker script. The comments included in include/asm-generic/vmlinux.lds.h
note these issues.:
  =E2=80=9CTEXT_MAIN here will match .text.fixup and .text.unlikely if dead
   code elimination is enabled, so these sections should be converted
   to use ".." first.=E2=80=9D

It is unclear whether there is a straightforward method for converting
a suffix to "..".

This patch modifies the order of subsections within the text output
section. Specifically, it repositions sections with certain fixed patterns
(for example .text.unlikely) before TEXT_MAIN, ensuring that they are
grouped and matched together. It also places .text.hot section at the
beginning of a page to help the TLB performance.

Note that the limitation arises because the linker script employs glob
patterns instead of regular expressions for string matching. While there
is a method to maintain the current order using complex patterns, this
significantly complicates the pattern and increases the likelihood of
errors.

Co-developed-by: Han Shen <shenhan@google.com>
Signed-off-by: Han Shen <shenhan@google.com>
Signed-off-by: Rong Xu <xur@google.com>
Suggested-by: Sriraman Tallam <tmsriram@google.com>
Suggested-by: Krzysztof Pszeniczny <kpszeniczny@google.com>
Tested-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/asm-generic/vmlinux.lds.h | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinu=
x.lds.h
index eeadbaeccf88..fd901951549c 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -553,19 +553,24 @@
  * .text section. Map to function alignment to avoid address changes
  * during second ld run in second ld pass when generating System.map
  *
- * TEXT_MAIN here will match .text.fixup and .text.unlikely if dead
- * code elimination is enabled, so these sections should be converted
- * to use ".." first.
+ * TEXT_MAIN here will match symbols with a fixed pattern (for example,
+ * .text.hot or .text.unlikely) if dead code elimination or
+ * function-section is enabled. Match these symbols first before
+ * TEXT_MAIN to ensure they are grouped together.
+ *
+ * Also placing .text.hot section at the beginning of a page, this
+ * would help the TLB performance.
  */
 #define TEXT_TEXT							\
 		ALIGN_FUNCTION();					\
+		*(.text.asan.* .text.tsan.*)				\
+		*(.text.unknown .text.unknown.*)			\
+		*(.text.unlikely .text.unlikely.*)			\
+		. =3D ALIGN(PAGE_SIZE);					\
 		*(.text.hot .text.hot.*)				\
 		*(TEXT_MAIN .text.fixup)				\
-		*(.text.unlikely .text.unlikely.*)			\
-		*(.text.unknown .text.unknown.*)			\
 		NOINSTR_TEXT						\
-		*(.ref.text)						\
-		*(.text.asan.* .text.tsan.*)
+		*(.ref.text)
=20
=20
 /* sched.text is aling to function alignment to secure we have same
--=20
2.47.0.105.g07ac214952-goog


