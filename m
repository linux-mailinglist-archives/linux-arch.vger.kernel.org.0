Return-Path: <linux-arch+bounces-8118-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EDB99D920
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 23:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A0361F229D3
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 21:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926FA1D6DC8;
	Mon, 14 Oct 2024 21:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bseQDC1R"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9091D2B34
	for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 21:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728941633; cv=none; b=Q4Jjkzj03pb+k9HMaF3tEXeFRkK39ZrhJbdkCPlSAfoNFRJ0cz4z/m/h6ueCTHFUn+4KIqJqwbfVgrGKLxitXjyJLeqVf3CDEJcfYGhTRa4HcmBLSia3E1hI65/D2DOY8kH3qe17E2ZY9IbYOAdaUphUZ2JoK+askwHHV+d3sDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728941633; c=relaxed/simple;
	bh=LqcsOVQmv5GpC5shRDpw1q19kzqKid+XE2EfW/9oI3s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ck0UF0ZGHNa8X+7vd+7r6VwC3Byt4GpIiYMMMaaXwC5T45+S4bZfxePivD1Bgf2BOZrke1QJXdo3ZeW8maIDKr/rymRTqUU0GB2uf36VvlZqBZSxdmDzBUrztwSrLDx3lskf8ed6xdHMlU6f7Q++DzLjYQuMr8lvYNoPIyKX0ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bseQDC1R; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e383ba6763so22605247b3.3
        for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 14:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728941630; x=1729546430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3BOqTSYvoekh3ysMWFRZqW1diZJBhOLc/W4rCwg+Ukg=;
        b=bseQDC1RXWv0A5TH7LbZUyoKhNXnGuI8+aprXQFAcgli9TkldlU4cfwVFgTYjg+8zX
         ujBcNJVA6nDlrOtTpjnNS15UMOLLVhCDBCkBTppWMS7KlaGPV13mq6Fcxg0v4EvsfpR7
         nvKfrgnH/JrnirGKZgUiT8l/NMd6T4sBqW0JXvTVCWOnIz76GAoscbJU/ofIOkrTlb9/
         JKQOXgBN23kKp36BaT6Bh0mS6RONVzFK8HhjsR5ResLCQTT9Tqsq4/SVHSMUcbUcG4Z7
         yHOJVaqMn4phSIZ6BCKtvNp6VNBPSOtiKHyLyOcRs91kR2wWMibEa/P3WOOyvUDxWl8N
         36KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728941630; x=1729546430;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3BOqTSYvoekh3ysMWFRZqW1diZJBhOLc/W4rCwg+Ukg=;
        b=ekSLsFY8g4wYCbZ1C7+sF0649mQ/p9vTwejHXLZsPmiI0VksXf2UCszKApjgqDuuXm
         IssCRwHFTfg7ipO8qxaVHLvgAjB7W4jy0aMe5WRjX4ppDDbafaG3bJJy0zulMUAevjh2
         wc7YWo+uTdK1F+ut6D7ohlUsPpel4I1D6IIH/0EsVtz2SzVBq94u7i5ajOnhlq4/Qw6p
         ry/qs8wxRwtMYEHgB1NRJAQrCgFxEjVYcHAwxMji5Xl5Ox5azKyEp6sEjH8/1A+JXtdg
         zIPPPFCY3OTP7iMvweuVMLRtxpwv9BDa0PLHN93+eiUtdi/OHg/v2WHWF/L4MgZ/1KUW
         ma7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVO7SMuAclfn2Nl35GVz+JOueGJN2Wo4LAdrpyjQQL6Ul932IBjFintj5EkCO2uP+iWyXhsqfz8hjGg@vger.kernel.org
X-Gm-Message-State: AOJu0YwfDAqVe9Pk2L/zF4Dl+ONIwz18wL4NPf1hNVN4hWMQQph1itMX
	0JT0BDCgRDRz2YkhTTVjZFsvpzA96EZn7zVpVl+OoTZHNhxii3huiVhGbLEgzByqlA==
X-Google-Smtp-Source: AGHT+IGJAf1dyn6T0B9hkA7jpV9sHV0gdw83rZtNGaxxQS6w9BKyM0bMWv36PdPXm3t7rejUADUFc3c=
X-Received: from xur.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2330])
 (user=xur job=sendgmr) by 2002:a25:3607:0:b0:e28:e74f:4cb with SMTP id
 3f1490d57ef6-e2918e5347amr56303276.0.1728941630550; Mon, 14 Oct 2024 14:33:50
 -0700 (PDT)
Date: Mon, 14 Oct 2024 14:33:37 -0700
In-Reply-To: <20241014213342.1480681-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241014213342.1480681-1-xur@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241014213342.1480681-4-xur@google.com>
Subject: [PATCH v4 3/6] Change the symbols order when --ffuntion-sections is enabled
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
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Maksim Panchenko <max4bolt@gmail.com>
Cc: x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Sriraman Tallam <tmsriram@google.com>, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>
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
a suffix to "..". This patch modifies the order of subsections within the
text output section when the -ffunction-sections flag is enabled.
Specifically, it repositions sections with certain fixed patterns (for
example .text.unlikely) before TEXT_MAIN, ensuring that they are grouped
and matched together.

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
---
 include/asm-generic/vmlinux.lds.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinu=
x.lds.h
index eeadbaeccf88..5df589c60401 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -554,9 +554,21 @@
  * during second ld run in second ld pass when generating System.map
  *
  * TEXT_MAIN here will match .text.fixup and .text.unlikely if dead
- * code elimination is enabled, so these sections should be converted
- * to use ".." first.
+ * code elimination or function-section is enabled. Match these symbols
+ * first when in these builds.
  */
+#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CL=
ANG)
+#define TEXT_TEXT							\
+		ALIGN_FUNCTION();					\
+		*(.text.asan.* .text.tsan.*)				\
+		*(.text.unknown .text.unknown.*)			\
+		*(.text.unlikely .text.unlikely.*)			\
+		. =3D ALIGN(PAGE_SIZE);					\
+		*(.text.hot .text.hot.*)				\
+		*(TEXT_MAIN .text.fixup)				\
+		NOINSTR_TEXT						\
+		*(.ref.text)
+#else
 #define TEXT_TEXT							\
 		ALIGN_FUNCTION();					\
 		*(.text.hot .text.hot.*)				\
@@ -566,6 +578,7 @@
 		NOINSTR_TEXT						\
 		*(.ref.text)						\
 		*(.text.asan.* .text.tsan.*)
+#endif
=20
=20
 /* sched.text is aling to function alignment to secure we have same
--=20
2.47.0.rc1.288.g06298d1525-goog


