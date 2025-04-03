Return-Path: <linux-arch+bounces-11247-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F08A7A851
	for <lists+linux-arch@lfdr.de>; Thu,  3 Apr 2025 18:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F2D3B1D44
	for <lists+linux-arch@lfdr.de>; Thu,  3 Apr 2025 16:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C555125178C;
	Thu,  3 Apr 2025 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UD7h5nFc"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596FB25290B
	for <linux-arch@vger.kernel.org>; Thu,  3 Apr 2025 16:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743699437; cv=none; b=X/h918wXvFG9ScGI82HPWp3VwPTCz3/0gmHx9Oo+fpjNvN5MKg+q2x5MdDJt7Jo/EnnvwwR0YKBA7Ph4nSJOpkbg9muIpJ8AJqGu79iypeMdBng9w7IlvoqJCk7vBahZ44UliHcM3MtFKcASHgsoQfM8cKzWZdFvheqQJ2yuE7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743699437; c=relaxed/simple;
	bh=pZlVCJRViECraWY8Y+BJqWX1y/rA40Dggavq4E6VOKI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=cCyjVB5minAfR0zp+DD/4wv3yO8aCSHlGGiPwJGldJQilwKClzCUFc2jNltty7en5ga3rChf9tOn+QCJdnPIszzrPh8wZwlQWyyuIc6r9MSMpY78aDaJ3Hp09cnCGhvxyLZTKXGaGn05CySRFRQ528RLN1Wowh7qipBviu1Wkns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UD7h5nFc; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-af534e796baso775486a12.3
        for <linux-arch@vger.kernel.org>; Thu, 03 Apr 2025 09:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743699436; x=1744304236; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qdGNPnhkmnSYFw1hLabTm19S3ZzmXtS5SLBi0D4Xb94=;
        b=UD7h5nFckPtMTToWNeuNhqeeGR4P949eOZOvtVB4pYPc7Am4d2cbCd6oK4VNkfUhMW
         E8OV8JQWnn5mCcJ2Jk9T+1IweetUq4wU6YKpwwtICtCnsXHBNrZqctzdDNxXpkmSd6Xn
         4yhOwZjeh1Q3FYrJHQdV/lnToVnwKSFbFbTvFdqLe1BOw41+TgLVu1oc2YW4MHrB1e6U
         3Rm4JgeHKRcxcP2ztxzm4CSnpBStxK8p33MAPL7bKsiJbqamY6kuB8TPO+8y6WMN0YXt
         /rNVarHsA5ejduK1PRtF2QkKXJ3tiYcl4mt4qrYjrp2cdOwNu+gmYbV4AMxsePLm+CrB
         dDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743699436; x=1744304236;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdGNPnhkmnSYFw1hLabTm19S3ZzmXtS5SLBi0D4Xb94=;
        b=N9leAEwKSWZKnc6aG+Tagv/mudzq/nRCdizkWRurI7Yi8Pa3draAvEwN+KVNfA1yMw
         GwSZhx7YkL+ycovz7sN4ANDovxxfYLaWKr8Eng6+HYaXTDrpFT6MQVzDr6nxEeyS4Hrm
         z7dfYec1UbgQeMnNLXmsoWM6rUDOZUuBAjJH330BHpMLp6hjYT+dSReVFeXBQvyZ2tT4
         Y2o+2AJwv4di9gkDpgUCBUgr3Hw5C0TEoWp15qMV+H1agaFRzpQgaWRf1nrBS0Fjp/ib
         +y0Vpw3HCEElPM6krwQ7+EpXQLSOR6YD4/7vDwVWs2ttmuuimOR9JBOUhxA+McCc1vdB
         rKnw==
X-Forwarded-Encrypted: i=1; AJvYcCUB6TJuThUNUsl1k+B0TzIYnpPkNpO1RP/CX3+BheSYRFYWDxhNhFB+To6E/KJHDkzt/KHdozNTArZg@vger.kernel.org
X-Gm-Message-State: AOJu0YxAZdCe4Yvpi80UX8TL559SYhJ990upGWgNYipFQDb7beQ37/O+
	wkTIyrTDNsoMj4M3mOT9EbFh02QkNA950iqQxt/MRs5OZJW8WDBNsO3ZtdWHpkj3AeNWEeFgOHV
	C+hGYEw==
X-Google-Smtp-Source: AGHT+IHf4+lZdfNC4Pd+fVVLfgEfGYIen3a2OuSa3UqLYxlvTyLWi+hHtj2Vluq/obtqYLkaNT1ivwRzacjy
X-Received: from plpn4.prod.google.com ([2002:a17:902:9684:b0:227:eb6c:504a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1c2:b0:227:ac2a:1dd6
 with SMTP id d9443c01a7336-2292f974a5bmr344475055ad.24.1743699435654; Thu, 03
 Apr 2025 09:57:15 -0700 (PDT)
Date: Thu,  3 Apr 2025 09:57:01 -0700
In-Reply-To: <20250403165702.396388-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250403165702.396388-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250403165702.396388-5-irogers@google.com>
Subject: [PATCH v1 4/5] math64: Silence a clang -Wshorten-64-to-32 warning
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
2.49.0.504.g3bcea36a83-goog


