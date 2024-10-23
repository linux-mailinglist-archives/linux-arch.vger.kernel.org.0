Return-Path: <linux-arch+bounces-8507-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 504A59AD805
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2024 00:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC9E9B21C6B
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 22:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED712038B1;
	Wed, 23 Oct 2024 22:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UKmsct+r"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804AE200BA8
	for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729723480; cv=none; b=qal6JfCQXOwpGR4yCla9WGcDFi7ERR86vTErdxRi0wDccLidHMYhMMCE4oChHcXtWvUiZ2It2JWGkO8D2RELRWc/mlMrwMGJiZfM9+IQCPA/KrJ4dNfUrGQdK6cs0CH9JOq4Jt7d0qYMX3QFnnACv+ddgWYORMRak35ww0tpgiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729723480; c=relaxed/simple;
	bh=GQ83ywusdX8FSxm29bbJdclqT2d6vsgU+PEBocsitO0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fvHZLg7wHSb1N1bTQJ7yd9OonH24LSFoiMFW6tXFX3ZNlKOtU35PIpz1qYI5lsb25RAVpugXbXNZVcIbwMdAxfGFS1NMJJhO/Hto9c7wjcuDShQajSxDCHY2k9NpWHQ0bT378KYuwA4qAEC6zi8xwlC8QIJvLF49Icu/LcAHZGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UKmsct+r; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e165fc5d94fso647648276.2
        for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 15:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729723476; x=1730328276; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kTuJsSOv0TXKkgOZ/uTNzVesPzJyNiyzzwDXk3hx600=;
        b=UKmsct+rTGoM1udseT8z3t7+d+oD63A0kMftZu/iEioutiY5fFLSXgbhN/0nfMT3BP
         +/Xj+rIw/HbGKeu57IYHfSmhA6sYgWWmrK4VzhVU7IJGVwzohsLm1bS+CvufHqfhABSG
         FPKF/ToYLT18AqYW4Fu8QKWRNSWcKdV6Jsm0O73Bq4CvOaiM4w6iObuW4o2nT4c4BB8k
         6yyyaRoiWc+Wr4APmYirmZ0Jo3Vouq4jc+3h1BQsuuZ3pdVjwkl9eEND7ZQCbtKC8rkO
         UMMiYp889+QGXxnQL12c63gLZmlyVE3ZpVg7FYbAnYpP6qvNBNw6LxiSZVPIlXl1QccC
         Y19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729723476; x=1730328276;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kTuJsSOv0TXKkgOZ/uTNzVesPzJyNiyzzwDXk3hx600=;
        b=A4He8fFm9xZsjMvIgoKXXau6B2pOIMBvIX1SmT9avH1PRkpQnFnKECuZ3uJzZK2N8B
         +NuunAjtZci8j9eoRO9LBstc8EX5RghUp3oEE286dhsxbHbEEWfrVfUUnoLuXUtI9p5Z
         kh4ET5LBEESUzhiykhv4C3eKIeqPbel4TegeALUEhrstoG9KD/agZGsBx8pP71v/8VWX
         oetft3jKizm2r87Rsmi8XVcxPrJchc8NfJbxmpuehloLnMkm1s4zn8k/6ZXcS4yVjY/W
         jVbKVU1wKxVdffRc69C39T+D2cxIFeCNSgW89GeP1vmBZtyXtB7ELvv/3WRY8wfwY0I6
         +s9w==
X-Forwarded-Encrypted: i=1; AJvYcCUj1u9Sgn9z4ohEITkaSEcBLv88Imf/qxPbrmtIpI156OV0OpcWp30tIuEOKaiWwE5SsP0Xh/lVlbGp@vger.kernel.org
X-Gm-Message-State: AOJu0YyOrKzsYpnT7UQ9I2utBo7KP0Erc3RJsXcV+T9C0Ndkf+meEW49
	u1KLiYba1AcU5eSQArvkFJ/VFm33Qa/KKC2b+2IrgNAMN66uPqU9J23ci8LJQ/wjmQ==
X-Google-Smtp-Source: AGHT+IFpQ/G7EWyoYT60RN1you6Dj+hT6prCnRF/AChpGyawG8i/BJxIIfyzyg2vkyXeHhpEwaCtalg=
X-Received: from xur.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2330])
 (user=xur job=sendgmr) by 2002:a25:2604:0:b0:e28:fb8b:9155 with SMTP id
 3f1490d57ef6-e2e3a6d71fcmr3638276.9.1729723476306; Wed, 23 Oct 2024 15:44:36
 -0700 (PDT)
Date: Wed, 23 Oct 2024 15:44:04 -0700
In-Reply-To: <20241023224409.201771-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241023224409.201771-1-xur@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241023224409.201771-6-xur@google.com>
Subject: [PATCH v5 5/7] AutoFDO: Enable -ffunction-sections for the AutoFDO build
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

Enable -ffunction-sections by default for the AutoFDO build.

With -ffunction-sections, the compiler places each function in its own
section named .text.function_name instead of placing all functions in
the .text section. In the AutoFDO build, this allows the linker to
utilize profile information to reorganize functions for improved
utilization of iCache and iTLB.

Co-developed-by: Han Shen <shenhan@google.com>
Signed-off-by: Han Shen <shenhan@google.com>
Signed-off-by: Rong Xu <xur@google.com>
Suggested-by: Sriraman Tallam <tmsriram@google.com>
Tested-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/asm-generic/vmlinux.lds.h | 11 +++++++++--
 scripts/Makefile.autofdo          |  2 +-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e02973f3b418..bd64fdedabd2 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -95,18 +95,25 @@
  * With LTO_CLANG, the linker also splits sections by default, so we need
  * these macros to combine the sections during the final link.
  *
+ * With AUTOFDO_CLANG, by default, the linker splits text sections and
+ * regroups functions into subsections.
+ *
  * RODATA_MAIN is not used because existing code already defines .rodata.x
  * sections to be brought in with rodata.
  */
-#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CLANG)
+#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CLANG) || \
+defined(CONFIG_AUTOFDO_CLANG)
 #define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
+#else
+#define TEXT_MAIN .text
+#endif
+#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CLANG)
 #define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..L* .data..compoundliteral* .data.$__unnamed_* .data.$L*
 #define SDATA_MAIN .sdata .sdata.[0-9a-zA-Z_]*
 #define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]* .rodata..L*
 #define BSS_MAIN .bss .bss.[0-9a-zA-Z_]* .bss..L* .bss..compoundliteral*
 #define SBSS_MAIN .sbss .sbss.[0-9a-zA-Z_]*
 #else
-#define TEXT_MAIN .text
 #define DATA_MAIN .data
 #define SDATA_MAIN .sdata
 #define RODATA_MAIN .rodata
diff --git a/scripts/Makefile.autofdo b/scripts/Makefile.autofdo
index ff96a63fea7c..6155d6fc4ca7 100644
--- a/scripts/Makefile.autofdo
+++ b/scripts/Makefile.autofdo
@@ -9,7 +9,7 @@ ifndef CONFIG_DEBUG_INFO
 endif
 
 ifdef CLANG_AUTOFDO_PROFILE
-  CFLAGS_AUTOFDO_CLANG += -fprofile-sample-use=$(CLANG_AUTOFDO_PROFILE)
+  CFLAGS_AUTOFDO_CLANG += -fprofile-sample-use=$(CLANG_AUTOFDO_PROFILE) -ffunction-sections
 endif
 
 ifdef CONFIG_LTO_CLANG_THIN
-- 
2.47.0.105.g07ac214952-goog


