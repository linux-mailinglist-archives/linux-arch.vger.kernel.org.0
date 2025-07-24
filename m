Return-Path: <linux-arch+bounces-12921-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65594B10C64
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 15:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C042188B5CC
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 13:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5DA2E92B6;
	Thu, 24 Jul 2025 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s/jVAsrS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239622E6D3D
	for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365401; cv=none; b=lXAp2dJjHthRGdW6Qg5fMzFWYtCfoyr8c/0Lhl2j1zvjLQAQkjdg6BqIk3PMbBVlBiMDV6IkH/IB0yfEv5VoAG021MIQX9js0gkXq7kDMVOuxKzPaFjNEH7/cQZCLFukZz+XHsALuxFn6ClgrmI/p18Kls3ATnN+2BJXwuDbO3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365401; c=relaxed/simple;
	bh=IV84GkIv57xHF9DSEvVSmOlbKrWfdF7K1awiWUW2oPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6LVlnLyKtN3UeW9ifY3MB5KTlkLImufdkEUvdyuXmkIJC9zHacItvRf7vKaBy5Wh7Hl4cRFde7qbEr/2JRoaTKZ/Iw8J81LNc64h2JIG8q1qgBRuGhnXk8yDjAtHHt111UQKoE1CD/3ftuyd4X9olcDXUsxDT1W2g5OL/L+syA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s/jVAsrS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so7036865e9.1
        for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 06:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365396; x=1753970196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qf/VqrIHQh0utzrTdiqqaO7yt4rF9Ojfq/Zu+7lemII=;
        b=s/jVAsrSDhWtyo9ZcV5kEKKw/dVAaBJ/nYU0zR+1TTbAwT6C90R6q4o2Fs7FTNl7EC
         JBz/zNnGUfo0C6rjn6bbYNcbu0h17l1DCsyIswwpqRE/Z5YJCnvklYzvHRVr7lDcjmK/
         GDb7UtK5YfwNF6dr2d7lJriWdesbG+04Mp1FaNrZo5ptMuWFm+WWlilSdR9E9Y9TXk5L
         Z24L7aBFpqgoH9WNId2cx3yqQWpySBhKUZFcsPEZpgj6KtjqgWBiLwpTykACJL2KYoW1
         w0EaD37ra0WKDf2vQ68AkDd3tApNxU7ohBQA3Kg9ZgN3ECcv988LGUYKzeUHIywN8eb/
         fBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365396; x=1753970196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qf/VqrIHQh0utzrTdiqqaO7yt4rF9Ojfq/Zu+7lemII=;
        b=lrl5SXhgwms/F4xiZWpFfK3PB06NmMhM51W3rwWoeQp3iqwUPdPswTcN7B7SNSkgcx
         km/0CPyCqsmG+uze3O7h8UQpud11Xlj25VltvGAIlQy8y2VC1sFtaDHh6sUsE+ciStyl
         sZr7VjcD/X/ww7pkTqwubqsHsK+wTM4x4MRNEoF/waqnyLq+g6gs5JR0DsV2NQJHLNe4
         Q9Vj78Qr3SPamgC4Po3pU7ga8rcah923eKo+6u3twK91Gf+sK1uEdwFJA5af3ioXvA8r
         UkonC9gH07d13FS3q9LDNbnNHyTLAff8LF2uWAcpNG2AJ1xkqfZbuEsd/ohiWmAbkMpZ
         fHVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsA1/6AoiIpigaYZk++ks4A1hQM2w70s7bS78r7o6OzLA2tcwPTHn73g8zbY+h4rvoutg+5nzERxEL@vger.kernel.org
X-Gm-Message-State: AOJu0YywxEzKvi0mCNqoene/q6j77L8z/SUUJGND+u7gg92kNj6ClfGt
	XeehWCQy+SVcUUONsHtMIwEilNnAQ+JE3fioV8OHJvtSE9z/JYf/Zh50fUvRROJvoIjmZMwxuje
	o8xe4/Ss=
X-Gm-Gg: ASbGnctcSesX3AOC+GCObGnxk7zERjQEDbwLfzAHpAOPgf2XvNtgPBhYY9eQCSzFg3Q
	0fLZsIurm+iMp+CK6gYgAwzQ4bG0Ax3E+pwBf68fT+lMU5/gA3rrojKcmaBbMzGkgo8z/bWY/VC
	yvyYAo4+QbfaIqFEUEV1qB5UcPWsLtUNK0zqNqRmyUghGpTMSGlC/ewkC8jUMVvglPiSiQS1Dh0
	Y8X6aLetsym5tNFBh5WHVMg4RbeZOz5E0am1cBQpf/ZUoEA8+2NPwu2NBs/iiiMw+ERfZQWdjJ+
	IiP+90/lOCe3HKeI05TCIwzLTCgP5+Npx6n89UfOBMqEQn8WkN/ASSKGDWNQkJwTr6645hvhlDs
	9U+knBKK2GjMG9idZ5bnA0/cerM4m9UajuishGMVcl12qHq6bE7tL+XYfyU/MtDH9HQxrtESJK8
	u0E3uS66jMdjuY
X-Google-Smtp-Source: AGHT+IFzdwFCiaRsVqkw+Vzf0TWhLQA78AFXGtgtYDTFYK39RF9ZemaLlLUrmcl7qJaLyA5hKTyeLQ==
X-Received: by 2002:a05:600c:3b28:b0:456:24aa:958e with SMTP id 5b1f17b1804b1-4586a8cc2famr61338095e9.0.1753365395873;
        Thu, 24 Jul 2025 06:56:35 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:35 -0700 (PDT)
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
Subject: [RFC][PATCH v2 15/29] mm/init-mm: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:54:58 +0300
Message-ID: <20250724135512.518487-16-eugen.hristev@linaro.org>
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
 - init_mm
 - init_mm.pgd

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/init-mm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/init-mm.c b/mm/init-mm.c
index 4600e7605cab..2dbbaf640cf4 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -7,6 +7,7 @@
 #include <linux/cpumask.h>
 #include <linux/mman.h>
 #include <linux/pgtable.h>
+#include <linux/kmemdump.h>
 
 #include <linux/atomic.h>
 #include <linux/user_namespace.h>
@@ -48,6 +49,9 @@ struct mm_struct init_mm = {
 	INIT_MM_CONTEXT(init_mm)
 };
 
+KMEMDUMP_VAR_CORE(init_mm, sizeof(init_mm));
+KMEMDUMP_VAR_CORE_NAMED(init_mm_pgd, init_mm.pgd, sizeof(*init_mm.pgd));
+
 void setup_initial_init_mm(void *start_code, void *end_code,
 			   void *end_data, void *brk)
 {
-- 
2.43.0


