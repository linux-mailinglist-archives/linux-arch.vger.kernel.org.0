Return-Path: <linux-arch+bounces-8786-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7F09BA1ED
	for <lists+linux-arch@lfdr.de>; Sat,  2 Nov 2024 18:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 039D21C20B17
	for <lists+linux-arch@lfdr.de>; Sat,  2 Nov 2024 17:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDEB1AD418;
	Sat,  2 Nov 2024 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jdYBA9K5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A211AB508
	for <linux-arch@vger.kernel.org>; Sat,  2 Nov 2024 17:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730569887; cv=none; b=dUZFxgRNMSv+/8abKZ9KybJLB8rBmwR1wvQb0znbnXM1FpET4YdzWrRV5ii/lJdU+vyqRmELeL2loMlwGxmKUqeyjoBZmNCTTz5xKZ/CmOay0WwBSLatSyTug1zGTRiVT98m5GWhhWMFRhh63agwQxLOJmQ7ggHwNYWgxLLGW6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730569887; c=relaxed/simple;
	bh=FPKyPXQZDul1ZksptEQY7pBtcpMHH9Arb5Mz1z5os1w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KSpPkrpen9dwUyjnYelkbJ+f/e2ADvxQD1svXMNbcZjOGub6m1KW3gIw2RcET7L8N5GiHLL0WNx1TVYhZ3lxwNZqvZJOD6yTJx1e25KLSTo9RL3mZyGnDnS4FEzTPC3ckUgKeYTyljeqPGIC7HNYaYMyOaQ2x07ErYa5HVEL+Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jdYBA9K5; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea82a5480fso10923067b3.0
        for <linux-arch@vger.kernel.org>; Sat, 02 Nov 2024 10:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730569884; x=1731174684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zGtzzK2Mgt1e1RFzyQB1x/jfiV7h76XR1pnUzYHJuws=;
        b=jdYBA9K5naZdpUVr7aY3tIBmteqSaOl45Mq3RXJojTyb4CMVuEvgtFKCMCDIOd78k+
         Q0qwC14DtezCY4TAJFWFW5DxcTYZkO2vztmk/I2RbaEY/2n637DxUEp2GjLUQQBUxwwF
         JBuAtSYoi7oAbDcJTzOJvQGn+squz4bYbo5wGqlw6P0lF8JPT2WPTGX9JNjT8enQOsv+
         ogy0wEKszcRvl5989Vh5SZbjBnJg3seEa3FwpMkWAAmbPBtQXB9Ey/uT5bfGMzeqyeVN
         qNC2OngEz/TGlcUsybz2iCYczsLT6Peoz1WhYtLHEx3TfTL9rpB/P47jDYB/omeREAsu
         1JZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730569884; x=1731174684;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zGtzzK2Mgt1e1RFzyQB1x/jfiV7h76XR1pnUzYHJuws=;
        b=H+oxrd+fo9RJN8IELKgWT/vsmgw22PT1grugZHk+rlrzSQvcad5M0DTZGLm7mQeAOX
         LiOfk6WGGNpMMDpjSe54bPcmE7AF6xLvlHrA9+eRzmqVOvSIZzju8OZZ4c2tJkpSsBqa
         ZQrAqQm6ZK4TZkesNz37mvZk4dRw7e9yymq+C5hMzDym3539FRZaOdAJQlQOb+nD+mCJ
         KY3pjZADBzMdDeIzMoHoZjMt2FmGDqNrqiNAPs4ptcU+VawYoMA4vHAs58iNa27gbgYt
         /XdUtbslEbXjrW+t32SRqhTPFwS4yv1926ydWU4v7J3gSBBrLsfk7Oqs1akablt0sWl9
         ulWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6cMxjJofKFtffn8N7RRQ2q9rN7YaO+xQmeAwNgisAA4yn351cmVaJ4T5uxZkzI4fCiykLIOx+iBSZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzgbWvO5j+YCLIbyRzjrSnA8lYVDwOHLv139awBIQucqTGUxqmL
	En9F7YXuhv5wfzUW2bwYfBj5BwZ6oMQmzAnOvu1utJH0hPOIrEAlhLqwhsR3rMJElQ==
X-Google-Smtp-Source: AGHT+IEvwg0QE/x7k999AZ0ljEk65daAHi3xwSh4xvBKBGQs6PiwWHkyniwX3qAJqons1DUpx3rkK9Q=
X-Received: from xur.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2330])
 (user=xur job=sendgmr) by 2002:a05:690c:3391:b0:62c:ea0b:a447 with SMTP id
 00721157ae682-6ea64a7db3fmr597937b3.2.1730569883860; Sat, 02 Nov 2024
 10:51:23 -0700 (PDT)
Date: Sat,  2 Nov 2024 10:51:10 -0700
In-Reply-To: <20241102175115.1769468-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241102175115.1769468-1-xur@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241102175115.1769468-4-xur@google.com>
Subject: [PATCH v7 3/7] Adjust symbol ordering in text output section
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
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Yabin Cui <yabinc@google.com>, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>, Sriraman Tallam <tmsriram@google.com>, 
	Stephane Eranian <eranian@google.com>
Cc: x86@kernel.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
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
section. Specifically, it changes current order:
  .text.hot, .text, .text_unlikely, .text.unknown, .text.asan
to the new order:
  .text.asan, .text.unknown, .text_unlikely, .text.hot, .text

Here is the rationale behind the new layout:

The majority of the code resides in three sections: .text.hot, .text,
and .text.unlikely, with .text.unknown containing a negligible amount.
.text.asan is only generated in ASAN builds.

The primary goal is to group code segments based on their execution
frequency (hotness).

First, we want to place .text.hot adjacent to .text. Since we cannot put
.text.hot after .text (Due to constraints with -ffunction-sections,
placing .text.hot after .text is problematic), we need to put
.text.hot before .text.

Then it comes to .text.unlikely, we cannot put it after .text (same
-ffunction-sections issue) . Therefore, we position .text.unlikely
before .text.hot.

.text.unknown and .tex.asan follow the same logic.

This revised ordering effectively reverses the original arrangement (for
.text.unlikely, .text.unknown, and .tex.asan), maintaining a similar level
of affinity between sections.

It also places .text.hot section at the beginning of a page to better
utilize the TLB entry.

Note that the limitation arises because the linker script employs glob
patterns instead of regular expressions for string matching. While there
is a method to maintain the current order using complex patterns, this
significantly complicates the pattern and increases the likelihood of
errors.

This patch also changes vmlinux.lds.S for the sparc64 architecture to
accommodate specific symbol placement requirements.

Co-developed-by: Han Shen <shenhan@google.com>
Signed-off-by: Han Shen <shenhan@google.com>
Signed-off-by: Rong Xu <xur@google.com>
Suggested-by: Sriraman Tallam <tmsriram@google.com>
Suggested-by: Krzysztof Pszeniczny <kpszeniczny@google.com>
Tested-by: Yonghong Song <yonghong.song@linux.dev>
Tested-by: Yabin Cui <yabinc@google.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 arch/sparc/kernel/vmlinux.lds.S   |  5 +++++
 include/asm-generic/vmlinux.lds.h | 19 ++++++++++++-------
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.ld=
s.S
index d317a843f7ea9..f1b86eb303404 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -48,6 +48,11 @@ SECTIONS
 	{
 		_text =3D .;
 		HEAD_TEXT
+	        ALIGN_FUNCTION();
+#ifdef CONFIG_SPARC64
+	        /* Match text section symbols in head_64.S first */
+	        *head_64.o(.text)
+#endif
 		TEXT_TEXT
 		SCHED_TEXT
 		LOCK_TEXT
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinu=
x.lds.h
index eeadbaeccf88b..fd901951549c0 100644
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
2.47.0.163.g1226f6d8fa-goog


