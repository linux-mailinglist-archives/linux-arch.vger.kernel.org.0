Return-Path: <linux-arch+bounces-11244-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E14A7A843
	for <lists+linux-arch@lfdr.de>; Thu,  3 Apr 2025 18:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ADE9172459
	for <lists+linux-arch@lfdr.de>; Thu,  3 Apr 2025 16:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0652517A4;
	Thu,  3 Apr 2025 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L5N/pY3X"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B815725178B
	for <linux-arch@vger.kernel.org>; Thu,  3 Apr 2025 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743699432; cv=none; b=ccxDuEQk8AlBDw9QKu5pJBQHLVHkF45VAsPUcAlM8pmRgwvj/ZUuPo6DPcfzNcpnSc1tvDRtFokxB91v78xDunySmIpCBXwBbjJsQet251HaCuH5qEYbkRueRLAUkGuUjGf5mRKp7UU9KGsoMdIw2a0tNNObQgRkECWDER7UWFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743699432; c=relaxed/simple;
	bh=zILY8QKhcQswVn+rw8O67wBaegmDIoNMhIlfFZckLcs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=qe/HCa9LP0M05jTbG3BJ2I4TegpOEbjDyHr6YNK//30/lZvOb9prJQC4HxZPDhV+SMB8Hb52f85utF2UwbxFC2cjJ8zCRqFcuwJzLgM85iLpEBEJ7MzkKQ1zFQK8uy+EeHUpgLI4tcRNYYmZgjeDp4sVRfeefpUI4YjtOXpfGyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L5N/pY3X; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-224364f2492so10162805ad.3
        for <linux-arch@vger.kernel.org>; Thu, 03 Apr 2025 09:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743699430; x=1744304230; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aH7Ec5u6cTDPfyUdEzfgPdfyysE8iLjLm12xst9ksRw=;
        b=L5N/pY3Xwu7cJGmVOc4s2mpb2+FeeSV97OA4QM1mwXr1eZ5qMjfkw8Jxt7rSJ2aXAy
         mg4deDpMk90HxTJtlVVd/QmxEuH99QpYtrLj5CYyTrGsfC0SPV9awM4e1LiYYkcOFud+
         FA4O0Q+BVQ3tVMItZMCdEOTtgIY+muFvtrubQgpoB5YQ3FIq29X1uJcdRSvfg39OsXVR
         OKLpj90z6KiPvIR45jiUwPDWiLA+3teanIGq42ErtoZoAIuw+En+s1lrs1QUuNPEFYkA
         ur4uWLczv28JaHytg/poE5SJXDEdL6IUqfrLY+6t231t8zVNYdg6LEkZeFzenx2BXBlR
         55Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743699430; x=1744304230;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aH7Ec5u6cTDPfyUdEzfgPdfyysE8iLjLm12xst9ksRw=;
        b=Djg+NRiLpqVbZy/fmpY5wx1zUlSP1N0ZIKBxM6CSy4ciMbPFAUTWYix8MEDwjSg5mR
         s5GpWE7m/BbpKGG3EDGkG5YHejpm/GFmlMpNuQh8pR59cvnxNSWMWLver6b+6dUQP1Su
         pHNKo/Xu8rHBjNKAzTMOXyB+UHIDfsw90exgjfOoiG/4//vFeoAdCKIUSYTyubWMPgZD
         FDxHdY/WGVKeTywNpIg+8J2SEnPJ6VyZdWuG1rTI7F9GWLCG3cUrz93SigWkGVezQikY
         f4kM0FRmHH8qcglue/SqwvXhxP/VDXagsxy3ASGIlyTtA4vc88AAHcK0MTc8ko61xwxr
         l8Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUNGXf8tbcDqN8YdlpsxIex/ByB7lexOiKpUZZnVtEQvwgrabJsXTkSmydFgKyw4KWzGKKQWlEUwRQr@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsm/bSip0pmhOxSK1X6gX5+mdQ1BSaxEcWYyBMouzG4kXNHGd8
	YS5VQWDNf8Y8Ek6RztN5u5LLvGSiPoXQwqZmWo9zYppJ4RigH4bRR3r0oM4MZIQRluD33hLN0Pb
	3/tD71w==
X-Google-Smtp-Source: AGHT+IG9oZEuu6NDkJoIa2JD9l2/TLvpDjP0WeNnnvefNvsoRX5iyB+xveOTqMHwj8Lg+En5G1S8314Nlrs7
X-Received: from plbjw20.prod.google.com ([2002:a17:903:2794:b0:227:e9e8:7153])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22c3:b0:223:f408:c3f8
 with SMTP id d9443c01a7336-22977d8bc8bmr47225985ad.14.1743699429988; Thu, 03
 Apr 2025 09:57:09 -0700 (PDT)
Date: Thu,  3 Apr 2025 09:56:58 -0700
In-Reply-To: <20250403165702.396388-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250403165702.396388-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250403165702.396388-2-irogers@google.com>
Subject: [PATCH v1 1/5] bitfield: Silence a clang -Wshorten-64-to-32 warning
From: Ian Rogers <irogers@google.com>
To: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Jakub Kicinski <kuba@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

The clang warning -Wshorten-64-to-32 can be useful to catch
inadvertent truncation. In some instances this truncation can lead to
changing the sign of a result, for example, truncation to return an
int to fit a sort routine. Silence the warning by making the implicit
truncation explicit.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/linux/bitfield.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 63928f173223..cc5cfed041bb 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -176,7 +176,7 @@ static __always_inline __##type type##_encode_bits(base v, base field)	\
 {									\
 	if (__builtin_constant_p(v) && (v & ~field_mask(field)))	\
 		__field_overflow();					\
-	return to((v & field_mask(field)) * field_multiplier(field));	\
+	return to((__##type)((v & field_mask(field)) * field_multiplier(field))); \
 }									\
 static __always_inline __##type type##_replace_bits(__##type old,	\
 					base val, base field)		\
-- 
2.49.0.504.g3bcea36a83-goog


