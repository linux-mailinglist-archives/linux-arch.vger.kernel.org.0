Return-Path: <linux-arch+bounces-7999-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5C4999239
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 21:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583121C241D7
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 19:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597A51E379F;
	Thu, 10 Oct 2024 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PSJSPEGc"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F921E1A32
	for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2024 19:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728588257; cv=none; b=c1PFzvtSoow8wrW3NxJCojf5hSkfFkA+EzR1cIIJbs0/RNK2knnzUiR2+oJ54Me9U3JyOioRtXvfsDSJ0wWBhY8pxGVKfD+QCx+FReWhPJNewhaWc3YcnpBQf0x8tI2NgCeyVmEX/zuVPb4PeiD6Pxfb6bKQFjS5G+6Cb7Kmnwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728588257; c=relaxed/simple;
	bh=sTdPsc9TlDcP9fj9qZnzf9a6N2MHYfNB5acRtfCguZg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u4QdCuwPc3XfjMHMvWw3Kdoyacrzomhf/DukMufa37KbvwbkzfWdu+WrfsYv/mwsFIphvKttqWm4uQUco/mvnpc7zmlaOfo37nvijXGfKBghlOviBc9MTKlsqaaPixBbIqzcfy1HGVq5QwMRsrll/QsZTN4E99gOe6Jp/pxPT9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PSJSPEGc; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e290d41291bso1689288276.1
        for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2024 12:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728588254; x=1729193054; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=56GXdyw+jn4VfhhYEfGPQRjvArCzv+g18r0M8mTXpxs=;
        b=PSJSPEGc1ICrZR4kXlEtx0Rwvct4gMl1FL6geWt9CoeT31Aj1Htur6L9rMoVeQUSnC
         wEOAUkj+OzZnmuAf4Er9O7m3jfET+nuGYRjubK6+XOeQrQA+zLwWOnKBkfB1zdtEIUQS
         mgbaw9Y22REIA/D7bfTUQqn+aK9Tv/1SnHgJhzD9VjnmGHFKZdu34Z9BBTgphuBcq/4D
         JnsHDFbOrBdjbPqQUOL4F2Q/mwSaCXVWXMlN+cKk8SKoAwd5kfM93RRC2jbFfEC0EUFN
         BltEnFDFdo8lesO9AY4SZAtg374VFe6aKn5iV0MgCINFELLDM548NlZtxIZbqTQxV53/
         eX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728588254; x=1729193054;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=56GXdyw+jn4VfhhYEfGPQRjvArCzv+g18r0M8mTXpxs=;
        b=JvD/tfBkXM+lqGFN9BDfCE+FcCE4jsBGV7btpp+N8C0NfwqgM7UKOdreJUEaYNPpVI
         NE4WQQN/WovXuVVbyURzKECCGx5oKr69gdn4XReMY8g3nn16LFdcouS4gaKiZxqUO8zd
         TH/8J1qN8S95breCpqGaFh7IT1e6NUoStec+SulGxPTUSphIdVISx8Lt87fU34f4rlnC
         WoFnAs7/QMuc9eSfhO4TQW/9Wvkaf+UUQizGkS7B/+zsbkiZ32oYoRMjO/h2pAlIYnEA
         LEb3tIv+52pvWHyaNazPOFOh2J2fNpmNEkRlS1mWfHtlrZbXwyPVfEUO3L/LqdcvnCm7
         z7Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXgWBsWUc1sgPhp1AEpyW7yH+lO4N39AMzeBQiRSS+ND3SUicmn5y/IwiLgKBYB/dTk8z2u5VOX5k1A@vger.kernel.org
X-Gm-Message-State: AOJu0YzFH+LJqAWrAdDY9Hixent0dPJD23iM4qMB1wQtMGadiWF0W4/z
	055BIjw3EnxWSpfmJg2qNYHY93zqqynH7g9tl6OQMIjpUd9WW7VNMuY3Lf0XXwW/4A==
X-Google-Smtp-Source: AGHT+IFESUDnoxkBRGGFEsil5vwwqQnr0M2E/rzO5Ah3pXUbKQzjO+St/IUq3wX79za0eMMedUk/mMc=
X-Received: from xur.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2330])
 (user=xur job=sendgmr) by 2002:a5b:94c:0:b0:e28:ef8f:7424 with SMTP id
 3f1490d57ef6-e28fe44d418mr60122276.11.1728588254050; Thu, 10 Oct 2024
 12:24:14 -0700 (PDT)
Date: Thu, 10 Oct 2024 12:23:57 -0700
In-Reply-To: <20241010192400.451187-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010192400.451187-1-xur@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241010192400.451187-6-xur@google.com>
Subject: [PATCH v3 5/6] AutoFDO: Enable machine function split optimization
 for AutoFDO
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

Enable the machine function split optimization for AutoFDO in Clang.

Machine function split (MFS) is a pass in the Clang compiler that
splits a function into hot and cold parts. The linker groups all
cold blocks across functions together. This decreases hot code
fragmentation and improves iCache and iTLB utilization.

MFS requires a profile so this is enabled only for the AutoFDO builds.

Co-developed-by: Han Shen <shenhan@google.com>
Signed-off-by: Han Shen <shenhan@google.com>
Signed-off-by: Rong Xu <xur@google.com>
Suggested-by: Sriraman Tallam <tmsriram@google.com>
Suggested-by: Krzysztof Pszeniczny <kpszeniczny@google.com>
---
 include/asm-generic/vmlinux.lds.h | 6 ++++++
 scripts/Makefile.autofdo          | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index ace617d1af9b..20e46c0917db 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -565,9 +565,14 @@ defined(CONFIG_AUTOFDO_CLANG)
 		__unlikely_text_start = .;				\
 		*(.text.unlikely .text.unlikely.*)			\
 		__unlikely_text_end = .;
+#define TEXT_SPLIT							\
+		__split_text_start = .;					\
+		*(.text.split .text.split.[0-9a-zA-Z_]*)		\
+		__split_text_end = .;
 #else
 #define TEXT_HOT *(.text.hot .text.hot.*)
 #define TEXT_UNLIKELY *(.text.unlikely .text.unlikely.*)
+#define TEXT_SPLIT
 #endif
 
 /*
@@ -584,6 +589,7 @@ defined(CONFIG_AUTOFDO_CLANG)
 		ALIGN_FUNCTION();					\
 		*(.text.asan.* .text.tsan.*)				\
 		*(.text.unknown .text.unknown.*)			\
+		TEXT_SPLIT						\
 		TEXT_UNLIKELY						\
 		. = ALIGN(PAGE_SIZE);					\
 		TEXT_HOT						\
diff --git a/scripts/Makefile.autofdo b/scripts/Makefile.autofdo
index 9c9a530ef090..380042a301cc 100644
--- a/scripts/Makefile.autofdo
+++ b/scripts/Makefile.autofdo
@@ -11,6 +11,7 @@ endif
 
 ifdef CLANG_AUTOFDO_PROFILE
   CFLAGS_AUTOFDO_CLANG += -fprofile-sample-use=$(CLANG_AUTOFDO_PROFILE) -ffunction-sections
+  CFLAGS_AUTOFDO_CLANG += -fsplit-machine-functions
 endif
 
 ifdef CONFIG_LTO_CLANG_THIN
@@ -18,6 +19,7 @@ ifdef CONFIG_LTO_CLANG_THIN
     KBUILD_LDFLAGS += --lto-sample-profile=$(CLANG_AUTOFDO_PROFILE)
   endif
   KBUILD_LDFLAGS += --mllvm=-enable-fs-discriminator=true --mllvm=-improved-fs-discriminator=true -plugin-opt=thinlto
+  KBUILD_LDFLAGS += -plugin-opt=-split-machine-functions
 endif
 
 export CFLAGS_AUTOFDO_CLANG
-- 
2.47.0.rc1.288.g06298d1525-goog


