Return-Path: <linux-arch+bounces-14937-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A84C6FC2E
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 16:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 3D1A22F284
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 15:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C423A3A1CF1;
	Wed, 19 Nov 2025 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TDFZ1Lau"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4BB2EBBB7
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567154; cv=none; b=r25+7kJFsSa8as4bAAC4LzqcRou4503CTmVAxvDRw9MJ8klE2H+DEQQeHc45U7fKtoiNue5oxcHn0kuf2KMKNMXh1zBtpsi9X12JxWbMF0wyMuVbgL3oC5X5/kg3pUHdCIOuCR+SJqDO4q0Th9T7mL4377+dXhnoNPEiyoYRCAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567154; c=relaxed/simple;
	bh=1fpsqew6FkRmrcxog8da4NhZ+AALs5Fn4Z4m4DLttGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhAe8rXJixwFZTBlsOAZlIMmXWTScFXKh0b8xI0ECsi2siz71oCRLhdoONfEa88ZrpBWWcQOVljTypvPiGuiK6Q0xPiGuOZhQJLS6nThRBGC5DCD03SxzcBsn6SRoF7rsozh9dbNPn9wJvtl1dm+x1wRkvxGrQ5G1/uenfoeMqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TDFZ1Lau; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477563e28a3so8031095e9.1
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 07:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567145; x=1764171945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qf0q06JpGKFVTNkejD0yb20CFvUyN2OLH5ZYFwRjaWU=;
        b=TDFZ1Lau6WPw6tyZUAI40mJfoARSjm8gLGa8hZEvOVsTVCAvvEoljNzjcqBTO3a1h9
         UX3wEiFW6HWi3GXSZ7R7C/wR9O0fSPFtMH1z8YTC6poYITj+PkCAMn2Uxa8k1QP9IEZg
         ZT3mUC3nibavdyK8E1rX5NRrHwzyeBVoWusZ8P1ljTrYjPJxQoBpdiQ9aW/xIQ7zdBfl
         lURYj6pwWn0cfxS5Fv226Pjg+zV/5OcnYIJN+UrO37SelHg2c+odhEiQCb4xNHL5/wh1
         2AzQ6Z/LAR1mF/VSx3U8b0YZ7wWAXgFO6Bw6877BgJDcul1GYRjqMQGMkLv8OYLKigZv
         TsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567145; x=1764171945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qf0q06JpGKFVTNkejD0yb20CFvUyN2OLH5ZYFwRjaWU=;
        b=FlqbXt9sRG8X6+SNOnCEiPljANlqh6z499Z1dvt0h4YTCPU6vJeWxXVTIEqzcvLjiO
         61ZVvltFaDE0vFEpBAcS09aLBb1gM3Xstt3BZxhjg6ASH4v8XU22bwmgO1jh6xZTHyZv
         U8WwFyV82MF6cRRexn3z9wYeANlTuD9ItklA+HbT0HWiOveNqu+YpRS01gwO3ETYMulR
         4i5bia9BLK85Q1VgvHn3s5JUoJoz/D9pFgISQ5KZrrtWdHffp4EhQMaDSmXDqiOoigtB
         DrNaeKbwpLR5f3v5fz7c1NAeB4YMQI+Chrn8EPlva4qq+4eU0L7fuwgxQh+Ubxk5Noyw
         4BnA==
X-Forwarded-Encrypted: i=1; AJvYcCVHUQ6l/PvPlrEk1SoAKKtw8vlyaF+tp9aNthnItYrkHbokRE7uc0ArCCD2YC8o5N1x48g1B3bkmczE@vger.kernel.org
X-Gm-Message-State: AOJu0YwC1T29jH3a/0x8DsElZl/6Unl/aZnuQqOgyYL8Hn0+xq3L9L9Q
	xWsiRcyGxZ/P5zTQvbqxk5tMjHhUQjWlAwsd8bgk6qMYrlMDCu5OCzqVPtXz4v/HxUU=
X-Gm-Gg: ASbGncvygBAbQgd2Qr2BHP9gakQjr0Eyn2ew9HyQLdUkLLwx1oLwYlPhKOj38Pg7gS9
	VLVfZM/q7T/XjH/+Bx4+RzkmAunv8XiEpkWjgsmRz4pAQA4WPpArM0JsSFwqG5uaoFuPRZFD5uh
	pJEdCHgbS7S7PA6w322w2Ctf7BrR7N1U/TPxNGFqT2gs8qvPI/7nhZTeCs7av66CFyCUxsDPrDu
	OUAnBk+gRJjHlWss4F00FBd2tQPAzeXNdeopelw7yu9UoX5YkBrxMyLcho6RQzYscIxBdd/TR9W
	gzvTHNR97b5BC6TboIHeOAHIO9agrGP4+E6mRpwlfvpkD9zFFrtF6YRUWAD6ohcFWD3JV8/BIKH
	kVMaMJjuGgP287evZNtFcZ5pfpOeiGtS2oLGF/YIvLhIXSGKSZmIcapmf3WStvnsVsQ8EgTiU/B
	m6MUXwLGU3SRW0HXGf0UBie2g1+RFOow==
X-Google-Smtp-Source: AGHT+IG9WtxjjgmkiAX9yQZlIznike3yBomBYuHSDjoJXaquW6OMMeXhxlHfzRespLZJBzb+ERriSg==
X-Received: by 2002:a05:600c:2313:b0:471:793:e795 with SMTP id 5b1f17b1804b1-477b1787bafmr21362035e9.0.1763567144657;
        Wed, 19 Nov 2025 07:45:44 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:44 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com,
	rdunlap@infradead.org,
	corbet@lwn.net,
	david@redhat.com,
	mhocko@suse.com
Cc: tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	jonechou@google.com,
	rostedt@goodmis.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-arch@vger.kernel.org,
	tony.luck@intel.com,
	kees@kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH 16/26] mm/mm_init: Annotate static information into meminspect
Date: Wed, 19 Nov 2025 17:44:17 +0200
Message-ID: <20251119154427.1033475-17-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119154427.1033475-1-eugen.hristev@linaro.org>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vital static information into inspection table:
 - high_memory

Information on these variables is stored into dedicated inspection section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/mm_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 3db2dea7db4c..c31062a3ff47 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -32,6 +32,7 @@
 #include <linux/vmstat.h>
 #include <linux/kexec_handover.h>
 #include <linux/hugetlb.h>
+#include <linux/meminspect.h>
 #include "internal.h"
 #include "slab.h"
 #include "shuffle.h"
@@ -52,6 +53,7 @@ EXPORT_SYMBOL(mem_map);
  */
 void *high_memory;
 EXPORT_SYMBOL(high_memory);
+MEMINSPECT_SIMPLE_ENTRY(high_memory);
 
 #ifdef CONFIG_DEBUG_MEMORY_INIT
 int __meminitdata mminit_loglevel;
-- 
2.43.0


