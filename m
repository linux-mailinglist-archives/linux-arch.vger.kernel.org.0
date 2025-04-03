Return-Path: <linux-arch+bounces-11245-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F84FA7A845
	for <lists+linux-arch@lfdr.de>; Thu,  3 Apr 2025 18:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E18A172359
	for <lists+linux-arch@lfdr.de>; Thu,  3 Apr 2025 16:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8182528E5;
	Thu,  3 Apr 2025 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OgU7Xa/H"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4507C2517A5
	for <linux-arch@vger.kernel.org>; Thu,  3 Apr 2025 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743699433; cv=none; b=HVYQINFJpbST2cs1ngxkPKkArN4b3/BWzqj+O0UKb+YmpgHtRLXSAR/BcJ+8NUvtKstnfI3pDj6HzmKF0OFn0wLQYaULR2T6+t9sfWwPehww0NGHd8IQvD7Jp4yI2Nxq7xlMJBjp/ChyHY55C1TuBBvib8vANPmFccMVRVj0UQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743699433; c=relaxed/simple;
	bh=EZ3OctgXrov4m1SIQQP0GA1CjxgdmMYx1wr5mwi8Yqk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=VfMYHnj5Lcaoef90sSmuEGxLaBTaDQH/gLOTEFGZt92LYN0VuryPGDVZRwpxl/C4z9BSRx7hG3ktS1zn071R6iNjHWNdijDrQo+SeVqG82qNvxUGrkPpGgtAlA2TmVDiFEocx+vd9eacRRiXkuuZ/AiHu7ap3050CVT6gJxn+Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OgU7Xa/H; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22410053005so18998395ad.1
        for <linux-arch@vger.kernel.org>; Thu, 03 Apr 2025 09:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743699431; x=1744304231; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2vMMUbWfGWJtt6qJg5TEjuYkc7LyjFLPOch4giCzBAE=;
        b=OgU7Xa/HYF5IzkO29gyfVS1HKvcN3DWqUnzGJ/wNcJHfe+oPg5b1QyhCIRxI9jmWtJ
         BAOzlGID9msHTmJcl51z+A2aDZmu6YNjI0HL1Ls18FLIoN6EO1yBN0KrL2mwbObxhaVh
         D4yGE7B7aex2fXpFE+RKEe6uRykh5t5VXZE7l/tH6KrSPhc002keSPgOvZLyu6P6TSNV
         L5SxDe863uULVLW4G9ogKEnvBxTIp8oZBr6unndaNdHmXZ8rrCrAjQkFAZOjhoILL4z6
         TYXr35eXJsk63DFj/b2DXo0K2F6Po3nJc0pS8MLkYMsj8t7YNCtIDvqNo3YAgH5Fg8rT
         d+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743699431; x=1744304231;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2vMMUbWfGWJtt6qJg5TEjuYkc7LyjFLPOch4giCzBAE=;
        b=sCEcB3XLhYvEad1f6+dzH4HSMga1+laf23+R0a7BfPm/iktsp9HOs2b9us0xe7Ce0l
         nlkWOTg1k1FhczhtemLUyw37rQMZ71SJnLZlUJ9TcpzdvdTF4QgmcKBPV3VFF24FebgK
         u+UW+5846ge3ibbbIBHPwN7Xwe8RiAqcIH31mxHqVjPiR6rqm7uq/cq9BpyqEpH+s43K
         qFGnlzbiwhz8uanSe+glflTIVR2Syljwkm5b5BtqK4xaeZ03A2R9CqWo0AhA4LgH2lNV
         ENoFJLRwHRACjO2nD5mqoFYo17XqcDZirO86406Vu0kQBkVD9CtBGKyNp+KH4RUlTOZp
         Re3A==
X-Forwarded-Encrypted: i=1; AJvYcCVyelaJrxnUrN0HL+VRmkOw6/JH3DFfaUoW/fxqVpCjXDDaDMSz6At0+rpnXpx6wVPQGtYvWVhENAKR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx16XUU7+Z7rWwirjnFrVKZDnOqAigXP1PsC46CKIfTjtqBSEbR
	iMJDDudGJRXvn8d6PEGHFxc8pJCxEm9UitlqyOlBM5/SxfNRjkmZWEI5/N25J6b1stcDqc1DXo7
	U73PHpQ==
X-Google-Smtp-Source: AGHT+IHVdW6EuuBxX0sM92CTGs0VCjkpUZ5/eKwIrxGT0OKUKkZpfgTf7TdCK0KWd6NyRz82u0in6WUHraY0
X-Received: from plsd21.prod.google.com ([2002:a17:902:b715:b0:224:2ae9:b271])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f552:b0:224:f12:3734
 with SMTP id d9443c01a7336-2292f9e298bmr322176305ad.30.1743699431571; Thu, 03
 Apr 2025 09:57:11 -0700 (PDT)
Date: Thu,  3 Apr 2025 09:56:59 -0700
In-Reply-To: <20250403165702.396388-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250403165702.396388-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250403165702.396388-3-irogers@google.com>
Subject: [PATCH v1 2/5] bitmap: Silence a clang -Wshorten-64-to-32 warning
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
 include/linux/bitmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 595217b7a6e7..4395e0a618f4 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -442,7 +442,7 @@ static __always_inline
 unsigned int bitmap_weight(const unsigned long *src, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
-		return hweight_long(*src & BITMAP_LAST_WORD_MASK(nbits));
+		return (int)hweight_long(*src & BITMAP_LAST_WORD_MASK(nbits));
 	return __bitmap_weight(src, nbits);
 }
 
-- 
2.49.0.504.g3bcea36a83-goog


