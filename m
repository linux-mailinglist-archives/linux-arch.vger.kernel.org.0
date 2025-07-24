Return-Path: <linux-arch+bounces-12923-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB810B10C6E
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 16:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B727E1893461
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 13:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487BC2E9EB0;
	Thu, 24 Jul 2025 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q+n07aCt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9862DCF4B
	for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365403; cv=none; b=oEDZcuMs7/lAEKmk2wTvf9CW3n4MmGAcvBKolehaaW+hIBdac2t/ZiQGAa0wCRHZZapKOc37d6oc417Hq7cfm17dtS1/mugWiUMtX9XxjLsEXVI0fslwhcsC6W73KutekvJxEu4s6QPTHm7Do0ZWmmF4wl+06nXDSE5ZNDj1pwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365403; c=relaxed/simple;
	bh=j52yzR7Gpkc2C7QzVnAL6OhmqWFXWx3JwzJVokNsTms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsRrd4pZjJZoRJRgttxjoALiDgYraFDZBcp5LUJWEJoT9B8rGYDB3O39s0YQk1XSP7KSR9Ywb4J+lDkquI0ef6mZLv5ITmjEE4ziDXldALe4w/DGfOFTw03VQr4KyxDyMDpd8cn6q2Yf1KYS+yQ1YxlH4ndN+6Jn/vVIegkqOgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q+n07aCt; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-455b00339c8so6845875e9.3
        for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 06:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365398; x=1753970198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phPxbutaSa2cHj8lQiAqRNXIpOiUr1sfgJg1sLmhr6Q=;
        b=q+n07aCtzLI5b5OprZDAIq8uAz3mWb20L+1xonnsPcouJj98jigrLf3qnMfoFVGfjI
         OeM+S05Brccvs8IcQCcBzyyTuTZArzaZr8h9ZMfyRrLigg0kpO725gQN5XC2ZzbVUM7L
         y0SjDNgVhz1kD/1GqaIOIxzY9rvg50jLnvwQKhgCp4qLn+r9PwtjQG5brJ+1iI2y9KoD
         kezpmDXrZh+N2x4Ohl6XzyCKFMsfeS0oratUTsc7VHeirpSYKt0fwdUtrXfb5e2FHUE3
         cs7nx92cEbIVH0knZ4w6CwYkO9geZwstvRoJzP/BrqrH7YGor0OWRBqmLrF6Bzl6P2Wc
         fJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365398; x=1753970198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phPxbutaSa2cHj8lQiAqRNXIpOiUr1sfgJg1sLmhr6Q=;
        b=XTRbU9L5noBT+R9OA0RMhOO1/uvhxS7qVM/H+jGGV2j38zGOAtOCLamlEMlad/QgSZ
         IUYnn5xFHawbjc6uVx1bp+vS2ej3jfDBRouOM3GFi4QKFxyKLXr2LuH4wt/HSizyd/3A
         lyLuPGDDIGmRQSzsPGmgdORovkkNxik/6741fN2ZDfcYHoGpx5v7u7E9D4lCOMvoxeLU
         EF0zzMrMza3mDbU3TL5ZtNFDqes1iSm87NlOXzokw+PKRsQ7Io9r6oijOG/5W08qEloJ
         ROjrGSF/vA339kl+5KWlrF/Q3ryOyn8jn3K+QuuL+kOrG8GizFI9ASA9KSNjsoc2Y1sA
         spAw==
X-Forwarded-Encrypted: i=1; AJvYcCUG6EEYqscJtY+2Wwo9W+oMrk56Uxi7SOJUsfePTQbQoLJ29E5CMtgJ1VSh8q/ixknDWCiTiETQRUCz@vger.kernel.org
X-Gm-Message-State: AOJu0YwVbIU18uZ7uVvFe56p9LDe+KfAhKNsphVtPSFN7o3QMp8iqhRH
	jFmSwrUZvjWj6QD6U56p8ufmamPlwWQQfvSsX6m80SP33hcNhyWnN1X4DS3FSEVSQIk=
X-Gm-Gg: ASbGncv/SxJcPDGMpzOQ4AJu7NONpnP7L065Y3bPUuqbjrL02CpmpVIcHtCTYJPm+Gd
	EjOj8fpBIQNq14PezEeF/saQ9HxhZDxQGhOLL15Aa4gI2yHhb5jQicXOWnipE/df+2eePzRhn1P
	5279T9aepXsIa3AbSL5DrwUNQYbMNd8bp7DKKdILE4IiJ+RbRuWf6UO2PEyK4XXwfW0D7VxYW7o
	qjgB7/7+tgZ6CrxIPK51MfCSvDiYrZ+bIN8c4HS7+6LdgBcPijmrz/x8FnF2Gy9gC7tdcXLGMHA
	IClUfQyQEGTi+UCLXrgj28ez3y18/o5EKWbIMCAQhVOHXKoxEHfbVJQxj+eo5OKPOik8d+n7I5n
	AEWKRoR4UFV4JGrzgVcX3qpZF5oxEPRhZr1v1n+gERL8m+FtfRcfrtsSk5zNIbByrsj7iWWc0Ac
	osYVHVDcvwqRH1
X-Google-Smtp-Source: AGHT+IEzG7rA7SjcU5/IexjXqSf6MXBAUKpIcrbkFM4DkAzOo8wQtcA8euIhs0yEfuaDr3L1GJYTKw==
X-Received: by 2002:a05:600d:d:b0:456:207e:fd83 with SMTP id 5b1f17b1804b1-45869ea827amr55222245e9.4.1753365397698;
        Thu, 24 Jul 2025 06:56:37 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:37 -0700 (PDT)
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
Subject: [RFC][PATCH v2 17/29] mm/swapfile: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:55:00 +0300
Message-ID: <20250724135512.518487-18-eugen.hristev@linaro.org>
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
 - nr_swapfiles

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/swapfile.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index b4f3cc712580..ac5a2307a278 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -42,6 +42,7 @@
 #include <linux/suspend.h>
 #include <linux/zswap.h>
 #include <linux/plist.h>
+#include <linux/kmemdump.h>
 
 #include <asm/tlbflush.h>
 #include <linux/swapops.h>
@@ -64,6 +65,7 @@ static inline void unlock_cluster(struct swap_cluster_info *ci);
 
 static DEFINE_SPINLOCK(swap_lock);
 static unsigned int nr_swapfiles;
+KMEMDUMP_VAR_CORE(nr_swapfiles, sizeof(nr_swapfiles));
 atomic_long_t nr_swap_pages;
 /*
  * Some modules use swappable objects and may try to swap them out under
-- 
2.43.0


