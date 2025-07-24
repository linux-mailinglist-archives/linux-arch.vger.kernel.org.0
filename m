Return-Path: <linux-arch+bounces-12914-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16E2B10C67
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 15:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670FE3B30EC
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 13:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E062E541F;
	Thu, 24 Jul 2025 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Th3aUFFI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166892E3373
	for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365393; cv=none; b=igY89vXCBehRaqcS/DjUKREQwTzP8F+s2TVzzZxjfPxS3Ni8kr3JVkkauixg/+3FVM4sryb9xvru9jyOJVNZdkVemmbv51BAliXvY8WjLHQgR47K2M8MpRS6Xx1Pxky+D003RuZKbKNOGygzdFSHl1KVgU6w9tJq+7cALj67bZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365393; c=relaxed/simple;
	bh=WYZcYfuknZj3jTFjyz/2YrsteC6Vf4UuZMKZmSw4y2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azw6t3l55dzmKSQviaA1Sp4ZuJ8iXHGFdYaMyM+woOR52goLThbZcvuF05Ifld8tITV79i7fl7PsTQgYWI3vesGZLOVlM2jIdGkSriAQRuZSkBUNpycwnW5YgqU1QH8Ux0diiraL6opt1LlJxncfbPtC6yHS8DNG2xyxyt3M1BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Th3aUFFI; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a531fcaa05so491265f8f.3
        for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 06:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365389; x=1753970189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=754ZhLeV6aTccnAi72YeZAlKqe4sOON/R6H0mwMKOfI=;
        b=Th3aUFFIQkGTV6sknzNIOajf27et1WQfLB29fQi7HkufV807DZOWxXheL4MoEi3zZ3
         g902QOkIy0IAJTWMNe5iSjJJUGhTKHuis+4rkDDgWUm27kzTq5615hdX0D1j2gyCp+eK
         JFh39ehqr0lZ6HQkTVfimzsFXYG/ZBJZAkPt/FFTfoekOqtl1ud7Ru6xpM/402OFXp9m
         X9UfeqYaRwjAmhvhFYd2MPMKeq9sZTcWxGXXIrwQsMItziTSrEtm9pWWla2DI0cmEc69
         B2qYsUcWWtp123urQK3cXCBMbWlYXXo8Vvip0LCdwhqw7XcijWppADMQJftEF70WvlZP
         JxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365389; x=1753970189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=754ZhLeV6aTccnAi72YeZAlKqe4sOON/R6H0mwMKOfI=;
        b=iCeOvPajGf+i/Q5yEW31HCux3VFdpHaF//fCyX52nQILB/2VG/oRuCIfynBUWj2Ra4
         x4HYNCu4cibO8sxC+K0Q/WK8RxpZATJ2nbSv/464EXCXYbIIjVLcc+FOs1gsbfXQ4qul
         YbZUp1tuwzsEFHahIrvv2CDO3yiFZuAMfBG69089BkbgmawG1DfYO2mQx3/RQaWuco0F
         z2W9CGDPiMJXfIiN8HRnY7BKvd1EHpSlAznVGk1+pQoWQue4D3OF3het5cuG/GImDJdB
         RuVGon9uvnxs6d6pnDpwF95KwibuM4C7WP7pZimtuZ5PKSS1PKgXvYPhm8sv5HbUc8NJ
         Br/A==
X-Forwarded-Encrypted: i=1; AJvYcCWVyoXL6z/amb79oE4+lTpOkBLO1pVD5Cq5rRurlYcXZklNntnCm7AvOP2vlB0E4EXV86spxfNQhPtY@vger.kernel.org
X-Gm-Message-State: AOJu0YzPsmtf9KrRwid6THYaR7sKPuyRk7Opow2Arf+ZNA4CHH746rwL
	Q66NhVk2le471ctpftFaxW/QspMfZjG/jMCE1u3KrDWv6JAbunTpPEE2hO0mAf5Awzk=
X-Gm-Gg: ASbGncs3kDeoFMGOT1fOGMLHgoAANDg4pGUV/TGbpkAeD7fuSco6zssH1wvii7ZiSHw
	3gB/ZpP2oSg4RAqHE+Rl54C2EVNk3tnK8kmuO8ljDqmiVkGsT4ZrF+jk5FV+V3SoM073GIfeOf+
	5mv/EsgYCMw0EbtyQ/w0Az8GSwbaEemL4XeAvplQkI+Dx0S2rUpvN5Qnb2R9+OI7bFtSnVafJbG
	g8lWw1C+dLPmKvFOUtrJ+ktRGbPsIjwZvUmfx9zRXSVUZS1DWxlyDUao695+2EHpGj/cRKZJRc4
	CZcf0pAPRUKsX6AAuQOZAhRCZ8x+WN0Fwm9WB4RhdpLNo+11wyMSxJvotv/CQhjhzgSD99DPATY
	4+PFev5HOxszeZs16bqKCC+4z+o8mc8h4FNsDk7uhUUC61CyTHui3xQ41ISrXLsBscQDlG6gOat
	L8oq1bMHqhjojfyNDKeNjHpec=
X-Google-Smtp-Source: AGHT+IHl6TFfQx8To8y+XEm2d27DSKV0h+MO3rvshokYEfPVyki8zgMiinC0EkzG8gsJheCG6bV65Q==
X-Received: by 2002:a05:6000:188b:b0:3a8:2f65:3745 with SMTP id ffacd0b85a97d-3b768f11dfbmr6433064f8f.51.1753365389405;
        Thu, 24 Jul 2025 06:56:29 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:29 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	eugen.hristev@linaro.org,
	corbet@lwn.net,
	mojha@qti.qualcomm.com,
	rostedt@goodmis.org,
	jonechou@google.com,
	tudor.ambarus@linaro.org
Subject: [RFC][PATCH v2 08/29] cpu: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:54:51 +0300
Message-ID: <20250724135512.518487-9-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724135512.518487-1-eugen.hristev@linaro.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vital static information into kmemdump:
 - __cpu_present_mask
 - __cpu_online_mask
 - __cpu_possible_mask
 - __cpu_active_mask

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index faf0f23fc5d8..d48e4dd979e9 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -38,6 +38,7 @@
 #include <linux/random.h>
 #include <linux/cc_platform.h>
 #include <linux/parser.h>
+#include <linux/kmemdump.h>
 
 #include <trace/events/power.h>
 #define CREATE_TRACE_POINTS
@@ -3092,18 +3093,22 @@ struct cpumask __cpu_possible_mask __ro_after_init
 struct cpumask __cpu_possible_mask __ro_after_init;
 #endif
 EXPORT_SYMBOL(__cpu_possible_mask);
+KMEMDUMP_VAR_CORE(__cpu_possible_mask, sizeof(__cpu_possible_mask));
 
 struct cpumask __cpu_online_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_online_mask);
+KMEMDUMP_VAR_CORE(__cpu_online_mask, sizeof(__cpu_online_mask));
 
 struct cpumask __cpu_enabled_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_enabled_mask);
 
 struct cpumask __cpu_present_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_present_mask);
+KMEMDUMP_VAR_CORE(__cpu_present_mask, sizeof(__cpu_present_mask));
 
 struct cpumask __cpu_active_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_active_mask);
+KMEMDUMP_VAR_CORE(__cpu_active_mask, sizeof(__cpu_active_mask));
 
 struct cpumask __cpu_dying_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_dying_mask);
-- 
2.43.0


