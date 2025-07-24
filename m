Return-Path: <linux-arch+bounces-12918-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6202B10C79
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 16:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2472FAC1633
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 13:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C82B2E7F28;
	Thu, 24 Jul 2025 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ARqjK83l"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096CE2E5B20
	for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365398; cv=none; b=f9LXQivgyMf95hrRalN5bT3vWzsLiaYEShgU1JQ+MpJDNO87GqOwrqHTfZvFfWVyelIbz8gQU1PX74g9IpbiBOYSs5djClGFjdDXPl7nr0nIOQJ6LMi6m/tEzLsMjYenKKz4EHayS+rAKBoxUV2PYamRnJR3uJtywebrQbETErw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365398; c=relaxed/simple;
	bh=Yxy1SBIj1dJtqJdo+SY4u8s4+niserlLQYp3eIctd7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfGIfzpJLnC9vzNuWWmfwgIKMmz1C3ZqshuOgKl9ONZzc+7NfRNY30UD50xSkeVZhJC8jyzcG9MURha3Ep0hwiE14etBP3fJpfSk+j5rbV//PTGH7Mpbguk0trp4ZRqStsQ/RVO3tWQHx4dgVHSIFh7PXH7YhHrVM3ICwPYK/zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ARqjK83l; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4561ca74829so10972085e9.0
        for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 06:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365393; x=1753970193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3t+kxQ7dPGtocO2eml/1QU47n2YVx1Ic6Vfv+oiY3pc=;
        b=ARqjK83lvYxNl8Lne8lZX/A7LtPSOrgVphMfQnIg2EwWyTqXQeJG6JHMqN6ytAYYmh
         PswH3oHdlWDuPJh8SsW+P3uquLU81BpG58SddVBBy0Nn8UlmV2OzuK68hgaO7EUDF6LJ
         TEnEdrn82pEYtS/XaaL9kdhATZdZC9Yw/1tiUmuiGTcBB9senuRHJzm2RSlloQfSC0KV
         7x+0pMdY5UUIr/s/6C3/n1DWlOmWVWTwWt0PTsVKNnVd5GC2vbkt0wmv2vzKtUF+G6LF
         Oke0h4sskYOveHCn+yARbBb6k9QMauq0FguiI1vkdtqyFqf6DOk2AZaUxJEtoIPheBc7
         +uWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365393; x=1753970193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3t+kxQ7dPGtocO2eml/1QU47n2YVx1Ic6Vfv+oiY3pc=;
        b=bQiEcyN0BkpGGfZFODd1jvQw+p/6Ueod9OVrlUyrgCDWscWxlr00EPOla9va3skEKj
         gQ9I/uIo/vIqVh89n3BtMRMcHPwoLWJrbdXiO3qo7atKOopFTj++8pzHKrC47mV7Kwxp
         UUC2BAzvP3gwsQG3XH0tYXCA+Ob3AILrRZUyXI0qu4xhybE/y088552h+Z6oWCav79Sp
         EHn+w1g0CEfGd+jpHRAIWMJu6CgTjELVhN0EeeNWD7fenRKl5xs2uQSXJa3LDULzIhdN
         C7gkS4FTsUpASXmAcY8XEXmZmM3Q+PiIx8cMRKsY+FUiyEnm92YQB1+HYMF0M9lA2PV3
         HDdA==
X-Forwarded-Encrypted: i=1; AJvYcCVv8Jb12Zd+Rm2e/GnXwDphzzIqeFc5CRuFLjFM1WwlwON5UnfQYk4mYbdoyUkoJm+ypLB8BSgsz/wt@vger.kernel.org
X-Gm-Message-State: AOJu0YxfFHGnJbTvOnypkqgG5HZlu1mRG3K/ppzr+jBr17IxTJORdHa5
	BNacoQ+svL41Nmpnva1DrqAcJ45HsCNYMUlR2yI4raUteD711cCWTp97rVLK4uvUL/4=
X-Gm-Gg: ASbGncvZ2ngXUCUsQzmSWPP5FjHD1tsi+Nh0zD/MmGMIdWJRxUrL/ydUZVV5SYiB0Uh
	wOUuUr2iHSZWRvp8SZ5o780LtF4tuzyUQ5C+ZmzJd87iOIu9Ts61LK3juRVfxGaO4yi2WZiUaua
	F0hZt6nxQ9Ee2z/7Wou3MdjoQnDNb+kX1CuUjGoSUy4e1K7RHVh8Gzc4sWXvLsLLOe79bTs8BbN
	FSJMqvnyClHKmxKtY2GzU39ESOoogfMpaejUO3i+32fL0jmdtbsDCQIq89dltWHyrHxUNvDq5Ji
	4OsrGv2bfuCOuFZwynGX/3RbYAPYhAa8YbdWIThM/GAnjAiKKo/nAi6D+6rssm/OOYPSgOipcsR
	cebq3auo93EpC+RTv3HAcEdSjTeg1n8JxMHESvEad35PGLnphc1B8L5FRW/Q4LyHWvhP54zjcI1
	1iQNCRa44zcU+VUhLIMvcQezQ=
X-Google-Smtp-Source: AGHT+IFgnp7J9pcZF45aCSKJ4GVrrhV0572AUoK1dVlyY1LCSR/mU9Z7mKYUQBRdiPhCDw14ZigOTA==
X-Received: by 2002:a05:600c:a0c:b0:456:19be:5cc with SMTP id 5b1f17b1804b1-45868ca72d1mr74457525e9.14.1753365392991;
        Thu, 24 Jul 2025 06:56:32 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:32 -0700 (PDT)
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
Subject: [RFC][PATCH v2 12/29] timers: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:54:55 +0300
Message-ID: <20250724135512.518487-13-eugen.hristev@linaro.org>
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
 - jiffies_64

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/time/timer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 553fa469d7cc..a5698e3ace2d 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -44,6 +44,7 @@
 #include <linux/compat.h>
 #include <linux/random.h>
 #include <linux/sysctl.h>
+#include <linux/kmemdump.h>
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -60,7 +61,7 @@
 __visible u64 jiffies_64 __cacheline_aligned_in_smp = INITIAL_JIFFIES;
 
 EXPORT_SYMBOL(jiffies_64);
-
+KMEMDUMP_VAR_CORE(jiffies_64, sizeof(jiffies_64));
 /*
  * The timer wheel has LVL_DEPTH array levels. Each level provides an array of
  * LVL_SIZE buckets. Each level is driven by its own clock and therefore each
-- 
2.43.0


