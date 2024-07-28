Return-Path: <linux-arch+bounces-5662-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE3E93E951
	for <lists+linux-arch@lfdr.de>; Sun, 28 Jul 2024 22:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EBC51C20BCA
	for <lists+linux-arch@lfdr.de>; Sun, 28 Jul 2024 20:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAC8770E1;
	Sun, 28 Jul 2024 20:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cBfLi/ND"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D9A78B4C
	for <linux-arch@vger.kernel.org>; Sun, 28 Jul 2024 20:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722198658; cv=none; b=Mx4SjUFizSMKIHnoR9UAz98ZHt8N+JyTu/NDbMK44kbPs+bFik1VIDwv211k51WgDeIKHYFXhOf3dII0Sm0hkT6hYO5UiJp8ZcG6zX8cWsfMepgX6CVPnxmLAsA4zc1mKzMWTxvrh2rWmdDXetMcK1hlp2lql3Zv366R7/MxM3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722198658; c=relaxed/simple;
	bh=5P/ds+u1Nc4DlKNiDUD6ZuYs75VWIvFx1DNGM0tCz1Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RAGc8xm21UQ48U3ozVYSi9S9cQ+KqBdok9QRBSHI3+cRvYOxhuDy/1Rfdrd9eBTve9o8dBRYTKUFPcUdrxxq28miYOCJyERcW6fnrEyVBtF99dBbOn2EejYW6qr4j1RTex2u9mh+Fp+/kXVKCoF0/R1fL9/thFP+NBmMbCTDdA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cBfLi/ND; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7a3c6dd559aso1954069a12.1
        for <linux-arch@vger.kernel.org>; Sun, 28 Jul 2024 13:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722198656; x=1722803456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o2mnjrwU8q3IWuUcbnv2YL1wGLUV3JerNGbL3ta/V8U=;
        b=cBfLi/NDtBWBjPzpPP+v5+G1124d8hHZzbXbgoiu4pqz+FAKvbw9E1ZLyEQgrBXN25
         QbpBDIRhwXvjGIFkLpOyTIhPDblH6z/L1doVuTsiqPZBd3276WcIB7fjno5tWbyx2LVp
         o68jtHuRaLpUhnyQpxWw/xwyAg+WMpY61e+epj7knLvBbskeNjDP3nsirkhsx/Uhe9SK
         cmvyKn7Jm0OiGkRZf/q5fyR1FTwd5Hz+yuctGrsZsUQCxLf1Y1wEd50xCsjePOvSawfc
         btR56IofvZ/TgXqTUer2V6Vh4qKhnwGLvDoQerI4gDdZzE1I6CVclK+x3p6QTbCmJgC7
         dH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722198656; x=1722803456;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o2mnjrwU8q3IWuUcbnv2YL1wGLUV3JerNGbL3ta/V8U=;
        b=AOHCveeEUk8lMLOic++7oAwwVxLxQqy6g3EorbwqEjU4aEJBTuJTEuMcFPEg/ToNIn
         eNGakW+z9FjDEQKacAV394xomJdONqqvDXp16LY6d8SVSEfHf/oBYH5pSw15eNGdjqpL
         +6+7OIz2ceZNtMTVarqao/6zWIwjHCSX69G30k2CLUwggs2TIghRE/U1CxOt3PaaA7A+
         +N8gOXw3Yrn4UOvIfag/0+5OojvgbhWp5tnKWLpi2WqMolfrZ0ct2bC2hFeKd9oIjKSr
         liO+WASj5F+Hp6f/WI12quZmidmkAx7Iis25t8Ld7yQfrsf8mHz2c/5LTfXrEJMHU0xs
         RezQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0kJOWbjh3RHXNiuoV1dUEiVTt2SxnWxP9o3zH7S879uywbYhNoKtt/kvLsmvKo9QlKRjamrRefV3j2+21GiAJTxghnnMJRcS3Rg==
X-Gm-Message-State: AOJu0YzTiS6BjO5hLb762w0aSof1Ra5bEd6xqlzc4OiGgX+R58OkSIzJ
	gVs+MAihEdWZSIsNDdPPvK5cMcz4oU2dRXCDcD2pl9HnacSLGtVQu9/AlMjswO1S1g==
X-Google-Smtp-Source: AGHT+IF+cnWDEef0AOr5iV5UnZQ0Nmg6qihUgkJJVOtSeHchBxmd2+NRGmp/GGHZSyrSRRs3cz4mBGg=
X-Received: from xur.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2330])
 (user=xur job=sendgmr) by 2002:a63:e903:0:b0:75c:49a4:2a2c with SMTP id
 41be03b00d2f7-7ac8f942a86mr12318a12.7.1722198655784; Sun, 28 Jul 2024
 13:30:55 -0700 (PDT)
Date: Sun, 28 Jul 2024 13:29:56 -0700
In-Reply-To: <20240728203001.2551083-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240728203001.2551083-1-xur@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240728203001.2551083-4-xur@google.com>
Subject: [PATCH 3/6] Change the symbols order when --ffuntion-sections is enabled
From: Rong Xu <xur@google.com>
To: Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>, 
	Sriraman Tallam <tmsriram@google.com>, David Li <davidxl@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
	John Moon <john@jmoon.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>, Mike Rapoport <rppt@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Rafael Aquini <aquini@redhat.com>, Petr Pavlu <petr.pavlu@suse.com>, 
	Eric DeVolder <eric.devolder@oracle.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Benjamin Segall <bsegall@google.com>, 
	Breno Leitao <leitao@debian.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Kees Cook <kees@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Xiao Wang <xiao.w.wang@intel.com>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-arch@vger.kernel.org, llvm@lists.linux.dev, 
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
 include/asm-generic/vmlinux.lds.h | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinu=
x.lds.h
index 5703526d6ebf..f3de66bda293 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -582,9 +582,21 @@
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
+		*(.text.asan.* .text.tsan.*)				\
+		*(.text.unknown .text.unknown.*)			\
+		*(.text.unlikely .text.unlikely.*)			\
+		ALIGN_FUNCTION();					\
+		*(.text.hot .text.hot.*)				\
+		*(TEXT_MAIN .text.fixup)				\
+		NOINSTR_TEXT						\
+		*(.ref.text)						\
+	MEM_KEEP(init.text*)
+#else
 #define TEXT_TEXT							\
 		ALIGN_FUNCTION();					\
 		*(.text.hot .text.hot.*)				\
@@ -594,7 +606,8 @@
 		NOINSTR_TEXT						\
 		*(.ref.text)						\
 		*(.text.asan.* .text.tsan.*)				\
-	MEM_KEEP(init.text*)						\
+	MEM_KEEP(init.text*)
+#endif
=20
=20
 /* sched.text is aling to function alignment to secure we have same
--=20
2.46.0.rc1.232.g9752f9e123-goog


