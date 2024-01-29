Return-Path: <linux-arch+bounces-1791-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BEE8411B5
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 19:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB3D21C247D6
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 18:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCC215AAD0;
	Mon, 29 Jan 2024 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HHxwKq+n"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9E115AABF
	for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551565; cv=none; b=pzQud4PjNdhQOKb57tp9oweLLYDGiXQy/qwUP5Zg1kCh9U9hCvLwclju1kKVR9y+5Xg4i8cV13i9Crb0rFeX1UUyXzX/0V6QQj9sX+TFzmIXOQWCz1kMNnqNBIks6Cw+sibgY+jnSZQfOQi+IqHOGqkWnQeECcrRnNtL9SJNYag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551565; c=relaxed/simple;
	bh=2tkXbI4kkP7Bg5PktzWdMGd8q8tWspLGt7tFV60fDKM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tORDC9petFwvVBAAHs3D3qSk8hsyslhW31IgenTEj3mPC9VpXwFEWkwrOMzGxLyen2mk9zLD/yrIPSNa7Q29jTjo9fZmQ8r+xyKEnVzO0y6vXtQfwnuW8x1IuzeUN4oXG1mNiWJBlvxmikmUxAJHp5XBFMtEDgjnX9h2Sd8Illg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HHxwKq+n; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc374283d67so5723415276.3
        for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 10:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706551562; x=1707156362; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6DdM1fA2/BUC7ScxyUb41JZesEtpKP4YlIE0jOqBF4A=;
        b=HHxwKq+nXkk2HJ3qoSkywtt5wIE0R0J/2KgfyyeyC9rWcHw7NdABIQGtgZpoLe3Uqj
         Uik/7h1LPurFgs4BIxuoXsUtCMgybzfcQI8QWBpt0FkTGvWJKebEUh6Os0xiMhENdQSq
         sLKfBDBJj34bxS7dj8ld1eanbODydLv5qIHml66Fl3PXVhZhc7DEiWfD55G9UgkbC5+Z
         ZmKXqE1kQ+9Z9BxW9q/NrYeDkogHX8vwGju/ZBDDZzUbVRmTZuAuv3HsbQuL0aWDr9u+
         HEwdVPtLlrXMZmvt25bVK7JSqIuQlsNzNhXbUpS3UQlr3rBx3SkOKA5MjgOgdcntMe+K
         Hb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551562; x=1707156362;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6DdM1fA2/BUC7ScxyUb41JZesEtpKP4YlIE0jOqBF4A=;
        b=rCe6QAAlYAkff1ryhkFVWDzhg176Dc+IQYgqfH2ro0p1hTWKS2OjYGC4iyIOm9/Q0A
         ewLusDqmd3liEnSgmXs2flO+7qbF+IzDCDdqYfK0XOXbOrNqOb7b/HnHEr0hPlg6PsBp
         lIStUi3DrFdMsdJfKImXIh9oQHR3aJM7XXSHtnykHf6BqbPuKgvWrZz2yOKFc1fIQw5w
         ihkax3Qf1irz0XT2ZrITZJ6aIiYfvboigKuUQqE7MxyI7faMu1LO9iswJEmf6DbgkfKA
         cDShFvqhnEGDj7vnN1thngqZTfK0NOtTubv6yt6f/TcFn2gISNEp5ZIzysqqDCtu8ST0
         b8oQ==
X-Gm-Message-State: AOJu0YyiZgnY8RA80U53o2Ap/v5JGOuGefLVcGbGK3q74JPU+JRaUdCa
	hoMYxmniMrp9OKX003Dco2h7ykK+vyMzBGGyZTOv94ptyRst1rQjFUgKkBiAAROkIzxZLA==
X-Google-Smtp-Source: AGHT+IEtY0wHG6Bv+Cfuwk98fDoP1mB4rkr70PowOvdhb/HTma9T9dk4Ph+McoAi3VylYPwwX4+//SgC
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:e0d:b0:dc3:721f:7a4e with SMTP id
 df13-20020a0569020e0d00b00dc3721f7a4emr2254113ybb.12.1706551562591; Mon, 29
 Jan 2024 10:06:02 -0800 (PST)
Date: Mon, 29 Jan 2024 19:05:17 +0100
In-Reply-To: <20240129180502.4069817-21-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1516; i=ardb@kernel.org;
 h=from:subject; bh=XIt7BesiIe5Ouf8eLT5Jk6gT3ML8ZNdNuPHWU+248+Y=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXX7i3sXJ3YtNZs6V0Vn46sNwfPVvywvyvumoxTpaWPlJ
 Nz4QT6mo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExk7QxGhtn/Pbk3KEkWcd6X
 n8erVbj74eH4N1o8/57WlE5hkr1zU4XhN8vqb2tihGJOxm3c8mZjeq3tTemlor/sxaf2e0qmZ2w +wAoA
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129180502.4069817-35-ardb+git@google.com>
Subject: [PATCH v3 14/19] x86/coco: Make cc_set_mask() static inline
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

Setting the cc_mask global variable may be done early in the boot while
running fromm a 1:1 translation. This code is built with -fPIC in order
to support this.

Make cc_set_mask() static inline so it can execute safely in this
context as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/coco/core.c        | 7 +------
 arch/x86/include/asm/coco.h | 8 +++++++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index eeec9986570e..d07be9d05cd0 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -14,7 +14,7 @@
 #include <asm/processor.h>
 
 enum cc_vendor cc_vendor __ro_after_init = CC_VENDOR_NONE;
-static u64 cc_mask __ro_after_init;
+u64 cc_mask __ro_after_init;
 
 static bool noinstr intel_cc_platform_has(enum cc_attr attr)
 {
@@ -148,8 +148,3 @@ u64 cc_mkdec(u64 val)
 	}
 }
 EXPORT_SYMBOL_GPL(cc_mkdec);
-
-__init void cc_set_mask(u64 mask)
-{
-	cc_mask = mask;
-}
diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index 6ae2d16a7613..ecc29d6136ad 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -13,7 +13,13 @@ enum cc_vendor {
 extern enum cc_vendor cc_vendor;
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
-void cc_set_mask(u64 mask);
+static inline void cc_set_mask(u64 mask)
+{
+	extern u64 cc_mask;
+
+	cc_mask = mask;
+}
+
 u64 cc_mkenc(u64 val);
 u64 cc_mkdec(u64 val);
 #else
-- 
2.43.0.429.g432eaa2c6b-goog


