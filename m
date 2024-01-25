Return-Path: <linux-arch+bounces-1575-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC7083C0F1
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 12:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED9C1C241F7
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 11:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375B15579B;
	Thu, 25 Jan 2024 11:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EUVR1Obo"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFCD53E33
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 11:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182389; cv=none; b=I9I7w7JrY2dz09UhK7XimpFyyi+p2LhhZjW+FDzL7D6Bor+ZKN70MufdsuTN4otiEnsCgyaIeS+9icg88JQS5YZh7scImjGlz6BWB8uzBxNDtIJHk7nVY/PGn2A3PR0cpbYwy7GBFcJ05C+5dxxaxmoHZwCqjEaMG2ryRXavG78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182389; c=relaxed/simple;
	bh=2tkXbI4kkP7Bg5PktzWdMGd8q8tWspLGt7tFV60fDKM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RqgaR0YnCfmmGcWlYHMRZi3NgRnzcZJ4ixrot0KqVhWm74lDCJl2LEkGmGk5uu57hk4JZ3c+SGXqRgjmT+zZlCmlIcoSGg2tpOQ9psedVRftbHt3Z5ZvCMIUfy3exg/OG8TNiFbJQLKIxXdjPH1S//p/a9xoASxS/1noMpEvCOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EUVR1Obo; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-40e4478a3afso2717445e9.1
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 03:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706182385; x=1706787185; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6DdM1fA2/BUC7ScxyUb41JZesEtpKP4YlIE0jOqBF4A=;
        b=EUVR1Obo8J5S4JUDK9Vu9muWNHvllPSi0sc9wX03vWhO4w3P2v3AJwxPr7E+J6mnby
         g8Ptd3X7l7POxEFaU7IAni4pJDqEEej63FRH0bXqUIwkx59lpKl2tykLvvIn9k4uSrsZ
         s7x+y/FSY9gMc1FeH3iJw/CUHTeBWbSXUoSYyeT3jhWB8qN8XLw9QqyrV7Nq/xNOUhe/
         zuPhHi+6lfw6Q4D7l/CNDqH/50WeYu5+e72NuaLiU/9IQHkbpRmb/7r/DNAWU3Dia48w
         lXxNvIMGJfolyNivyguTFvdo8EAez9mnE19BYzisMpeo12AxT4PmETzIrepyPsbt3qfl
         ttrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706182385; x=1706787185;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6DdM1fA2/BUC7ScxyUb41JZesEtpKP4YlIE0jOqBF4A=;
        b=i9Iwzm99+u+RBbBNRysC8COdGkt5HyQW32JRNoHzHaPqhG1pBv50xulHvQrZuC4HRT
         75FRXCiW/+BxyWqkuBjQIu1sWwcA/mcd+LFuubQ8Uq+xarLZ+8/2+LPYhz4DF+/5D+Ru
         gyLcwFW0Es+43wntiEdCyWIfB4CxzM60PQsxoYQWVNsGwQZhx/752jWf8i1AVJffwQU6
         yYIfSA4w0qK5Sn3ogEmlFZOJMcWTz39gsfccR8OGgU1mUEdCDsh639XScziXdjoRzqAc
         VXnpA+5NXTlaVcnvnyt/0QKfcxdlzqEG6l6lrcjJwLN2X872/ageYidgy5U+aPsYuhHE
         jl8g==
X-Gm-Message-State: AOJu0YzU+Gf6G268pCn3THqWMFhq3vLIDI1d/ifkaGgJ/1lO3fj43yG+
	bOzusw6Hx6eBVbwq28IV4aUlWJaBKiEnZZUNOwmEFy2os2u4Zww9Kqdg/PkLq3/w1zG2Xw==
X-Google-Smtp-Source: AGHT+IHwAYKcaMhJLNwywm/Tve5NxG3vi6LLLb9sVcfy2uySRff3UA3thP9CMDCN1Ce+5DrXbz3/AitZ
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:3c8f:b0:40e:541d:dd64 with SMTP id
 bg15-20020a05600c3c8f00b0040e541ddd64mr40221wmb.4.1706182385129; Thu, 25 Jan
 2024 03:33:05 -0800 (PST)
Date: Thu, 25 Jan 2024 12:28:31 +0100
In-Reply-To: <20240125112818.2016733-19-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240125112818.2016733-19-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1516; i=ardb@kernel.org;
 h=from:subject; bh=XIt7BesiIe5Ouf8eLT5Jk6gT3ML8ZNdNuPHWU+248+Y=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXWT65eLE7uWmk2dq6Kz8dWG4PnqX5YX5X3TUYr0tLFyE
 m78IB/TUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZiEczI8LglN+rBwh+LaxmN
 ne73hRUuFn7LcdbD44WH1g6pXXLRfowMa/fpH3z+e/YjJ4esjoxCpfbczZOmiv4Of7fe3k3Zd6Y dDwA=
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240125112818.2016733-31-ardb+git@google.com>
Subject: [PATCH v2 12/17] x86/coco: Make cc_set_mask() static inline
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, llvm@lists.linux.dev
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


