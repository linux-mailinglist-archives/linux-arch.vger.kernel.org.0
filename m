Return-Path: <linux-arch+bounces-11755-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD488AA5272
	for <lists+linux-arch@lfdr.de>; Wed, 30 Apr 2025 19:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3AB77B09C4
	for <lists+linux-arch@lfdr.de>; Wed, 30 Apr 2025 17:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641992641FB;
	Wed, 30 Apr 2025 17:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PmKPxZYp"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB5B2620F1
	for <linux-arch@vger.kernel.org>; Wed, 30 Apr 2025 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746033344; cv=none; b=pM3oa1ShRMqad0HqgjtJyRnao57tR/FyiDjFy1laVNWz3jNX6UeJo+2X3USDS+8JsVkTKd90Yb8YrbF0XU+/Q19B1BEAWTn2gKUu/53d8rOghZQv2gMAoN8Q9LTfAVrGNP3mjm+F8dw9q0Oi3StX57RSHTBPQqK100vSrMfU2G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746033344; c=relaxed/simple;
	bh=lm5ga5E1Bh0WGysa1ZSSmKbnAd9w4JpDDVcJpw+p0k4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=OIt/YnlPHOXcFEqAI/1agWP2oUfUlAfV4td1zFi/we4IGjHUNf7EZw96SgXRnkes1Q5WLx85Ei04sPFtw//xNwK/xu5aV97Gb0So8RyDuWYWZmEJxVgq65hw7/+aKd4JtKl52qcAgL803vCYtnUWOTGG0xycfijcOX4g0bjkVoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PmKPxZYp; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736cd27d51fso100430b3a.2
        for <linux-arch@vger.kernel.org>; Wed, 30 Apr 2025 10:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746033342; x=1746638142; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FpIgS0wmOV5UbvgaGzkA8qij/rEeOqGzeG6VWVukYPI=;
        b=PmKPxZYptul18cSKHetms8n+PTcVIzKUlAVUFOQgagL5/znyW/MBGYppFcxrDsnUpA
         Ermr+cqYzHLXL7RUKbxvb8H9vTwMAjn2NkBn242oJ2bwrezB5K7naNc9tFXtF8jV8aXA
         NSjCHVPL2ntKIVTFZnoIkXx7inIx/ZY56zsg8LVD3+FJJYd6h3tIuexxAoSxvMGihqBE
         1OVGqyp+Z6yYdp8/gum8K2OWtoUdvtzrXhSd8k505E/ILCHcmirvFUQI9I9ig4nCRnAk
         zhDEkazss/WPAJhXXFS0QNOMb/i5ZXd0vdnj6EV88u0TAfqmaFuMS/NXx+Hfo0k3tXmv
         E2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746033342; x=1746638142;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FpIgS0wmOV5UbvgaGzkA8qij/rEeOqGzeG6VWVukYPI=;
        b=wSnYUuPXiyKA8qlGeQPCmKAnZCifX4ZdcNTFfJUXWBw+SzGAuP0mhJmQTRkuWF06YA
         L8HGeHaqGmtg2/vaq5Ogfdrxe3lg65b80rWj6+dHhf3f3CTMqL6YpAZ/A+uhWLzc9fhR
         7TYBUnRanc6D16qN2TnalXFUaXmbASNddhIczVuspU2tRbyDhSE2UyQRELY78HV24VDe
         +rTTTJZgjwFguXRYyq2gHCmRbwSOjueKocG+viytKuzvzwSGcRmCHXbJV/vJGxJRDx/0
         s03m9t1A8CaiOVD7L3QpgHCnICjh+dyTGLPZHnbYOCZphD5nQVFNKuQr3T5KEy2TsvnU
         Lzrw==
X-Forwarded-Encrypted: i=1; AJvYcCVSp7gs1/73qJN4LNxfo0Hhh/5rdQatcUnHl+1KSDJ+KuSwrWiYUF85Cdmb0uAF3pSqjKfvqg4tS+v4@vger.kernel.org
X-Gm-Message-State: AOJu0YwpPaDv+gxKBDsFFy85i28u9MGLFRLba64OUc1ntXe5PfNWLLtf
	Ugu/1kPgLxmVaNIjM9e1czBiHclwYO4nNzIyyv+ihJDPzHBTBffDoELnDDIWc6RLHxeNWojoov1
	4OEiuWA==
X-Google-Smtp-Source: AGHT+IGv8XMgRIoeJR1rySLXISqqmVQqJou5NGwUjKxk7iOH4VQdGHhiObrDzUu60o16T054lU4v3OaRDTR/
X-Received: from pgkb21.prod.google.com ([2002:a63:eb55:0:b0:b1f:857e:2198])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e617:b0:1f5:75a9:526c
 with SMTP id adf61e73a8af0-20a87c5680dmr5326067637.13.1746033342084; Wed, 30
 Apr 2025 10:15:42 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:15:30 -0700
In-Reply-To: <20250430171534.132774-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430171534.132774-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430171534.132774-2-irogers@google.com>
Subject: [PATCH v2 1/5] bitfield: Silence a clang -Wshorten-64-to-32 warning
From: Ian Rogers <irogers@google.com>
To: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Jakub Kicinski <kuba@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"

The clang warning -Wshorten-64-to-32 can be useful to catch
inadvertent truncation. In some instances this truncation can lead to
changing the sign of a result, for example, truncation to return an
int to fit a sort routine. Silence the warning by making the implicit
truncation explicit. This isn't to say the code is currently incorrect
but without silencing the warning it is hard to spot the erroneous
cases.

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
2.49.0.906.g1f30a19c02-goog


