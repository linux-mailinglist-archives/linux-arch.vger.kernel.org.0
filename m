Return-Path: <linux-arch+bounces-13060-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2C5B1A8E1
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 20:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EBA9188BA69
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 18:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B4B28B7D6;
	Mon,  4 Aug 2025 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eo4tgzbU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B0C28AAE0;
	Mon,  4 Aug 2025 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754330735; cv=none; b=DXS2VvHYoz6p4O6pTUiWcyISYHDC3Vu1XVx+Pf49u9K6uoQz7hk/+h+h/ecScB2boJ53+CmdVic2NplBRiv1qBSY4Wg1aBqVnoK8FT7c8d31FCTtBbguR7Aj+JlHW+NCncM/GumI+4R3ncrd7aVjQgG/xe9hc+/BxUcd9KL1mLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754330735; c=relaxed/simple;
	bh=xXVjNI9bERkha9J0Rv0R70Dz7EfNyp1kbReuTtDg3Vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rQuADiJ/Z5MKfMHJJ2dTlDBIjtRKR6OPdw3S06KavrzA/h8pp3aEvHU4B1dYm2ayobd4pARewkDlHJF+mr9aBSYfCyqajrZ9ibDgTPq8vesVK3GwcX8t8XhMqg6ZgjpimnGJ8gzJWA5En334qBhpk1MYfsMCUdgldQ3yqoWlX6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eo4tgzbU; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23636167afeso31019245ad.3;
        Mon, 04 Aug 2025 11:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754330733; x=1754935533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sV7Buk+s0msso3TQBY+k1lyKNaQLXX/KlAJMeu8bD0=;
        b=Eo4tgzbUWlS9qwdDcSGxwoivDlm37hFuW9WqF9jdXmKx2Fa4ZsgyObnY4tdpzGU5pf
         phDsasiijga0rcsXMB2TUOQIZuNAOsQIjClSPtYhyESJmPn7P00ChpVDukLnYJ5Ek6cP
         Xjg5c9RE3MqtFb5yV24cu4FEgWWU6r6a4mFy6+RKga4y3NwJNrcbBj2J5RHAqYYk4gWC
         GvdA+4uEBZJsj8yiKZtpw6D7J3jQFOjFo3SOK77rrhes8I9bgxWwYQYPfSvYBPc8oHqL
         ztaFqVBfgw4zASl35a5PWnxcKB6fwmNDFMRyUqxZcY/645ZQH3I+dIpeICE4IL2WZIsx
         C6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754330733; x=1754935533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sV7Buk+s0msso3TQBY+k1lyKNaQLXX/KlAJMeu8bD0=;
        b=sDxqoM5QtOJ1h/Z4h/9Tcqh1APMnvIsh2KnesHQ6WK/0eApZTL7P5GPEh4+NyeZ0/G
         1HLKLCzbYT6Xsd55tDCdbtnF8qZoboGSmt6wL6Q6OSiyd3PDi9hdiakWL4T38lHK67Ft
         Q0GRs44rxQBxMWB0GNQHkVUvEYjshagrLVmlvrHgx1e2zfRr+mzIPmpPSyPuHi0YwGeO
         P8MJIOsoQNUsaZtXwnqgG4X3wMwHHhStsKSkTWS6etP4fktG4XewATAhxv1CiiGT3Twl
         tuznunhyC1LytkXkFVOa9jZplTWolfn1UAv9ceG/dsJ2b3KLFgFIeiL/hmdlNQBBZ5Am
         GIww==
X-Forwarded-Encrypted: i=1; AJvYcCVEq5r16SDphQtgchWV83KhrOfPPp97vLlP4l2GdFyvcKDFsnzI0/Yn+5LmKFn41sYyFqxI/O+s7DLN@vger.kernel.org, AJvYcCVHvgUBqrFomwH0RkdPMwRETQ1oa+hShWlcfCM1WGBvXxAqvbb2weKt2sUEOOkKK5g6c85rRTr69xBl2Zta@vger.kernel.org, AJvYcCXLzV+MG6YX9RKLQ8Kde7g9pvha9GIfoyuD4lOxNRlE9EQWEAWmXAyKSw6sj+89bRNOVguwoVYbszgp7VR9@vger.kernel.org
X-Gm-Message-State: AOJu0YxJTkIZPXhzi/v1fLpA7TiqizbcEQRAzr5CNAYFAuHM7YC4UWMz
	9VB1BiBF9O0l8aHEoQnOU8ZjWEIxESVz40l560tN2qAdRqruTpmBqkM/
X-Gm-Gg: ASbGncty2pDrkr5BGEa8wHZUcQFA2xEuYm5GD9etMyvYA3YiRLX3xBSHb1I7o22sKjx
	vEQiU1O4PgBxpbbqy6LLkZH8jutSm3p995fSHN1buLoAedLxmdx3lGc4VS2ZSr+1mgFobpdCcRo
	utj7JOw8ysHABMbc83LgFV2DQOLzKcy8UcGGBLhmT6Yeul4hmHyEiHnkzCbHvLRHR5LnLBRpO3m
	rnGVzEGYEpxf7dkHcP7YLl5qX0SBpT7263RTaLLYs6WeCDHPqiDRFZBKHHELOQIeM/jQ7lmsADw
	/hlqqlbNDqz9OEvsMY/Sq7uFWLdeZMyyEwzuB1jfJ6fvLrMpWTwI+3f9T+Bcn33S5PUra5y6xky
	xuXEDpopDfedIJrzezfk/NqVM4MGx8+FRtR+78LVGQWhBA88nJCeX4KghF76XUFc=
X-Google-Smtp-Source: AGHT+IHidO3JlMsUdCvn2NIDfEWvvn3rDGKLvRlIU/kIsYPJJznQJz6KzmpB4+Nff29tXdXuwVrVIg==
X-Received: by 2002:a17:903:1b50:b0:240:25f3:211b with SMTP id d9443c01a7336-24247163dedmr130244045ad.51.1754330732967;
        Mon, 04 Aug 2025 11:05:32 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:6f:2b47:96b8:6281:35ea])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aafb34sm114144825ad.173.2025.08.04.11.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 11:05:32 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	Neeraj.Upadhyay@amd.com,
	kvijayab@amd.com
Cc: Tianyu Lan <tiala@microsoft.com>,
	linux-arch@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: [RFC PATCH V5 3/4] x86/hyperv: Don't use auto-eoi when Secure AVIC is available
Date: Mon,  4 Aug 2025 14:05:24 -0400
Message-Id: <20250804180525.32658-4-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250804180525.32658-1-ltykernel@gmail.com>
References: <20250804180525.32658-1-ltykernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tianyu Lan <tiala@microsoft.com>

Hyper-V doesn't support auto-eoi with Secure AVIC.
So set the HV_DEPRECATING_AEOI_RECOMMENDED flag
to force writing the EOI register after handling an interrupt.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
Change since RFC V3:
       - Update title prefix from "x86/Hyper-V" to "x86/hyperv"
---
 arch/x86/kernel/cpu/mshyperv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index c78f860419d6..8f029650f16c 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -463,6 +463,8 @@ static void __init ms_hyperv_init_platform(void)
 		 ms_hyperv.max_vp_index, ms_hyperv.max_lp_index);
 
 	hv_identify_partition_type();
+	if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
+		ms_hyperv.hints |= HV_DEPRECATING_AEOI_RECOMMENDED;
 
 	if (ms_hyperv.hints & HV_X64_HYPERV_NESTED) {
 		hv_nested = true;
-- 
2.25.1


