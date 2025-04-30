Return-Path: <linux-arch+bounces-11758-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF49AA5278
	for <lists+linux-arch@lfdr.de>; Wed, 30 Apr 2025 19:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352C21B674A0
	for <lists+linux-arch@lfdr.de>; Wed, 30 Apr 2025 17:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70495269CED;
	Wed, 30 Apr 2025 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x/1N4HOn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7E8266585
	for <linux-arch@vger.kernel.org>; Wed, 30 Apr 2025 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746033350; cv=none; b=HGoT6O8X0fWdCw6ysPD+bU4UpSc6Z0tX2LgxTYj7Wzz1UKvBcrA+cDcOBcdqCVYbtQlr2nwvhldBtCpn4S6/HVGtlo+bc+mSt4Raq7mo2/2m87pzscjqRGxGdCddgG932stz3OS4ogC2ZHe1kI/DFLZX2Hc+/yBU7l0J1xgGY1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746033350; c=relaxed/simple;
	bh=0giGEwbxakAUv76u37w4z4HZNA3HR28IEwGrKloZfbQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=LPD+DOsNJ9b+1heeYOJs4vHbFBeBhfTCK50zTz/zE/RubC0Q//nXEBdDzZkMynfKVxAaEBbCNEpgau8kmACZ5uMrgNgmodFbLv5dF3DAAVWzlTBdBpLA3C9s3+Sz7gH726oAVF6wSaPh/iIrWbz0CM5C5ye5Vg+dZx40Q+LQiGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x/1N4HOn; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3032ea03448so129522a91.2
        for <linux-arch@vger.kernel.org>; Wed, 30 Apr 2025 10:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746033348; x=1746638148; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fOjn9I/CPl6hOGWikVl+PEhxM6YNnhs+3iDFhqJ7e1Q=;
        b=x/1N4HOnrjhrEuaC+/BduGHIgnd9t3WVz8bjvEjk5WlhqqB/SUKujBNRP82AaIoGh4
         Ff7UaID+dL5ZEtcYQwTdhCtgL2upjme2iCZMjxTx6kaMSl+x3DxoYAphKIA5KBJt1lVM
         PpcUX9ZRuxu0cK9yAH9f+L3GLwIjjaVMQae3ly9RoVz+A8K/OQkw31erSbj2MhLTBx3q
         ySFOKrO9F4A0skALa85MX5nPUE1yNhPZCsySMZQlT3S5aM41jJ/jkf1Au9hX/KOrRGHp
         TbrESs3eF1v/rWS0Jleuw32xBUsyKX4DG/Uw0p5Ff/c7arWfU3TSviZThsFnchfh24Dk
         HXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746033348; x=1746638148;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fOjn9I/CPl6hOGWikVl+PEhxM6YNnhs+3iDFhqJ7e1Q=;
        b=YPVotYpgW/ICMaoHA40ouq9cg7wy9I9CJScdkpCyDIo+V88pfndeaC+Ude06Z4DCD/
         Mg00i5dW1G3IaXa5m5Azw/6w0Ysy29/ZnOyboifIsx+WYcMlVfO6auV8CoRciqSrmbKs
         9lAsyQp6pUkMwbMWjo0QOfX8aWe/pFRwbnZWyxxGKZOTRYpop7NOExHqRxlQUPD/BXpp
         3W2toYn5OBZVDY3N/SRWn4ssbLsiPLBc/mnM6ro06XHvMia+dmc6SY3/xxxay9ODnS5Y
         zh8qgMnCEFCIbcg3SL5+grUojfo2iPVc+JU6MoT/mvsVl03X8XOVxV3rx5xQEibjzAuN
         3R7A==
X-Forwarded-Encrypted: i=1; AJvYcCV0nR7jBCPXtl1aT6r7APpFfEsYCxw8FY7Xi44g62UOVYPB3goaCC2zmwassK3PpxDF/aCZKKh2zlTS@vger.kernel.org
X-Gm-Message-State: AOJu0YyIHyA2bKNcSOVtCVnMHbXhiqQNEQY7ckZ9XQHfCRR1eO3vHebL
	fmhE/4VN0KDKEEenJWfEv/N41uXxMuZ+3eP+Qhist2YQc5It2cT/HuP/QjrH/bXS4uGrj2VCIIT
	+wvrCVQ==
X-Google-Smtp-Source: AGHT+IHK97p3d4624e1GJoE8HKE9+msldMS/AyxZk3q0FqC3fhWjqcopfMGNBtO9wUuHcIl2vdgL7V5NAXJ3
X-Received: from pjbsm11.prod.google.com ([2002:a17:90b:2e4b:b0:309:f831:28e0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4984:b0:2ff:796b:4d05
 with SMTP id 98e67ed59e1d1-30a343ffdcbmr5747063a91.11.1746033348290; Wed, 30
 Apr 2025 10:15:48 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:15:33 -0700
In-Reply-To: <20250430171534.132774-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430171534.132774-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430171534.132774-5-irogers@google.com>
Subject: [PATCH v2 4/5] math64: Silence a clang -Wshorten-64-to-32 warning
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
 include/linux/math64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/math64.h b/include/linux/math64.h
index 6aaccc1626ab..f32fcb2a2331 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -179,7 +179,7 @@ static __always_inline u64 mul_u64_u64_shr(u64 a, u64 mul, unsigned int shift)
 #ifndef mul_u64_u32_shr
 static __always_inline u64 mul_u64_u32_shr(u64 a, u32 mul, unsigned int shift)
 {
-	u32 ah = a >> 32, al = a;
+	u32 ah = a >> 32, al = (u32)a;
 	u64 ret;
 
 	ret = mul_u32_u32(al, mul) >> shift;
-- 
2.49.0.906.g1f30a19c02-goog


