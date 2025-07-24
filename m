Return-Path: <linux-arch+bounces-12924-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA71B10C83
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 16:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29DA03AF7C5
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 13:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2B32E9EB6;
	Thu, 24 Jul 2025 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C6mxlAnj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA842E8884
	for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365403; cv=none; b=DU0shkS56FraYv1+EdEQxt1DESS4DfsnXgLnbszhUacAPEssQMJsxByvF0OnbBdEsvUBpu5VHGWVRuW5PTPD3ZxQTVIZ8jzOuvrWZU128+8RiljQWM2piWsHHmwtiYHUJcPP1jv0tGveanoZ4UGYetzKOKszgh58k9Eq+khpNoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365403; c=relaxed/simple;
	bh=17QGeEGZ9coLnHYcyt7u8QDI4NZW28xAVJJwsgh3bn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DnDYXUyyOMZx3hA5/34AGzfdQ8ix+WR6K5mjCSmDMlqo4VbpP1EzzaTiAMlD9AsZNMBx89lwGB7Y9ZM5enWj/oVXxOR7kVAuqC3ubBZeORfooGBvxjy3gGuxhIaW74V4gb+lsD/MIKNSIZaqGkGabDKtgonZEcKUjuh/O46cwmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C6mxlAnj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45611a6a706so4974335e9.1
        for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 06:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365399; x=1753970199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJKFOh1t0BpMtsqdCvtkoNZefWX67AppBNjz3MRLfF4=;
        b=C6mxlAnjxxjv8X3k7Jnlv4sZr9Pj4TpM/k4nKrykg4D0lOJYUyc523/PaxPNtpEJL/
         TXdsZL+OlLgXOkacE0AtbuEMn4kpSzX+yHu9F2eDDir2xZ8YNwP7wPzFLOjiUvx0Xj9m
         LKLhOoAcHEXYVrjUsjP7Ga5v4BeuXxRYovBExttSURq+FqlMGJFitUcqGrI98yXatdGd
         SRAbA2++JzajT/CvO7GQWsAcy3obbNBjvf7AtoDaX7Ig/8krnLnaOT34aaaG16Lpv+dC
         GM52ktZzXM7zphMDsSTG9mUdN9y3OtIjMOOtcyA5x4tQcjZuMA8VQJ2wR3zQ+pgNFloA
         +AVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365399; x=1753970199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJKFOh1t0BpMtsqdCvtkoNZefWX67AppBNjz3MRLfF4=;
        b=FrG5qonWlKNa4IH8kiJWLZjbw2igeyY4rT/yiEljGKPtOFrc45/K6jv8lDA/o2adRZ
         e6vSGItefbQfWGMwMN7G24V3ELx25DGDEPNqHrY2JV5/QPdZChSM5Nt9ofVw/i7dZbJh
         b4L31oWU8oE4wfTw/zCnGwg+Ga4Ocj0ufyiePEeSVKC+q4VAxoG1VUkQyYgo/ZrTnUcn
         AJEHfRffD5GtxvXb6oEc9HnT78lh8jKYokMdmiVyYvIxdFrzCLPnS+NWBkUg70VOQSuU
         EjpT+WKdo+xbW5tLdis3kBiK9xArZr9ahgUvH50f8qFJUgvKhQTGyOPmhsePm//0x8IC
         tDXA==
X-Forwarded-Encrypted: i=1; AJvYcCWIoXgnzl873V7dxlVIqOBKXyj6dI+dmJrFsC1k2Ln9p1j7hTKoq8TWPYCmXKGYjbjWK1kRawLDRawK@vger.kernel.org
X-Gm-Message-State: AOJu0YzaH2e8HV5SYnhxjG9YCupmO1IWEt9q4WtBRZk7aI21itKdwKGl
	uIebeavIOba0fC605tUCKawk601iZ7SwKgDeE2k1nDUOosyKjmxrZ4dAaPQZZNnT0K8=
X-Gm-Gg: ASbGnctUTTQLcPFijesj2SNMTlselfTr8HZPgN/EWPnkSRCm6Y3OaTL2Zx6RELtlB3J
	1Y93Nbhopmhb9h3Eu9r5cAcKf7yEYTypLDPyXGNEl40liIFNxZqJ4AVf14hvptomR9rm2heAApI
	Y0lTuE/miNQAP0A9ArzGrseOdXimWHWijHydm00xzxNXgZokqaHPb0W2ovFLEob6imu+PS/203o
	vk8SUAPLflAMrAW1hQ8mb3ksiC9l5GProvk6SzyV2Cct9pCoDSPPp8JZYONjW+Vaw9YZmh69RRA
	6o0zZDLB0AP7iwowOtu2FH6c3jaAwSRSMsK+ZXF/qF5wfl+d7n29ENYFC+Jvy0Zx1U15K8pR5w3
	KVCLXtjm7UhU+Pg5bgfe5aEBedXkA2Z7WVLXs4XcegkYzY9B8y9s/5AFqHGyX6dbfHovCUA8yn9
	UwaXcWf1DntyXa
X-Google-Smtp-Source: AGHT+IFBpfszojCM9BH8+214LoTonUL/68z7rgbLH3wV7lPKq/S6zSGoTIX7zNxB5lRzwaUzCOOn2w==
X-Received: by 2002:a05:600c:3ba0:b0:456:8eb:a35c with SMTP id 5b1f17b1804b1-4586ef5cdb4mr25803445e9.31.1753365398629;
        Thu, 24 Jul 2025 06:56:38 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:38 -0700 (PDT)
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
Subject: [RFC][PATCH v2 18/29] mm/percpu: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:55:01 +0300
Message-ID: <20250724135512.518487-19-eugen.hristev@linaro.org>
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
 - __per_cpu_offset

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/percpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/percpu.c b/mm/percpu.c
index d9cbaee92b60..0cfe4d7818e9 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -87,6 +87,7 @@
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
 #include <linux/memcontrol.h>
+#include <linux/kmemdump.h>
 
 #include <asm/cacheflush.h>
 #include <asm/sections.h>
@@ -3342,6 +3343,8 @@ void __init setup_per_cpu_areas(void)
 
 #endif	/* CONFIG_SMP */
 
+KMEMDUMP_VAR_CORE(__per_cpu_offset, sizeof(__per_cpu_offset));
+
 /*
  * pcpu_nr_pages - calculate total number of populated backing pages
  *
-- 
2.43.0


