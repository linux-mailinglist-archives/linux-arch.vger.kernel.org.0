Return-Path: <linux-arch+bounces-13674-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B150FB856E0
	for <lists+linux-arch@lfdr.de>; Thu, 18 Sep 2025 17:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506EA7E0807
	for <lists+linux-arch@lfdr.de>; Thu, 18 Sep 2025 15:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A098330CB54;
	Thu, 18 Sep 2025 15:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYjWbxCo"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0351B30CB20
	for <linux-arch@vger.kernel.org>; Thu, 18 Sep 2025 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207678; cv=none; b=aoKdBal5HtCdt0Zu5oVDKcB7hg5x323TrpEZ1xcxoSgF/qUFsxH11YmwFMFuTkb3reb4c8GhcsnLRPJi2y4GesuaWvaZxkKfr8LMAhOcrB1o+OgPSaL7g0C6hw/6vWAJYvppAnR1gHhk2ZSiS8dCP4yPt4kmYXxurmT8uKGRPfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207678; c=relaxed/simple;
	bh=Kd85ZUqbXMXjSsnseasdGJ1OpbHCYbM/zpeXnU30bB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UHnJQust6AYxW1NqK+L3blAr4yHM1nF/bV2lFEF4xq7h8cHYjy1kFED9/6XGlOVWkQJqhYnGMqixV1C795/zeUM6rkmlkMhEWsdcajftNSneOWfMTJe8/VFC5UVZ4H3FZ9JyD2WxbQKSI1YkU9bp8Z9In559eldqeCkz1Y6y5j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYjWbxCo; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2445806e03cso12791995ad.1
        for <linux-arch@vger.kernel.org>; Thu, 18 Sep 2025 08:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758207676; x=1758812476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbpUNPOiDYoiEn45wuc0crNJHXScwpSkJ4TCqMU8+dk=;
        b=HYjWbxCoZZKc5mice91v6AUfGrFqZv6ZeRdiSmoSq8+2E3hm6x1LPQ+KbSQPFElhb3
         PiTMdc/XlUsK4JfuphO7G61iDe1l+cWCDI+GLFFVL5bd+pislLD6zJ7/5y+ecibrOebE
         e1l40sy7gnZ1hn+8XNnhwzpB5ILlWsBe8+YZLfxgtqUUABL7HfIhp6WRX11S3zEF6PJ9
         RC/u1AR+cp2u/Wla6HkTU93C5BAGelrgbKpO7TF/JuatOYEYsjqXKYjuxM52A0gW6SLK
         4LkvXJLbTvzBlSkQ6WawlhZLhD9ktEtqC7+sb+8c9xKv24Z4dqA2fTmOAARc9x6ZreuU
         sCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758207676; x=1758812476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbpUNPOiDYoiEn45wuc0crNJHXScwpSkJ4TCqMU8+dk=;
        b=WxeKCbOjHSGjOZpYBN7ng6R6MMSimQtAZOQMzVo8CXniZqFqDRaBCRSuKmq8cgB0Gz
         0zZW+3NVOmCabVXokfZkkcpSIIVztpYVsuX3IJCqqSe5a+kbwlAL7Qy2vYv82CucMqc4
         obBWZKLm/V4OYz+O3T06OO2OVdCu94R4Cvd+/8k1HW/ObAuAlp7Iuaa9N+0PpTW6K82y
         huU3jGLyk2F2K6qESdjtIIJE6pY3V2BLoBvOgTBqS1t13DfPA3qPjJ6vA/nxeA7JyN25
         PgI6XXLRizs1H1KsBUfBJjCYn9tKpViRYx/QnhYVrPbjHMhrvqgzrVLZ+59pHV+xAd4w
         tIVw==
X-Gm-Message-State: AOJu0YzqtEwrFt+ZCQ+dyYICMb5vbnQuIxPo7YeDYHkcrn6ZD1uuJf3d
	5VgDiJZouum6oe8Pg58kVo9DUmCYY+9YrRaDKAUfzdhvZTiCNUBdlV+p
X-Gm-Gg: ASbGncszNta/KW2HADMnFmheja/NysE/ErV48wLGVj5SbJJL/YL4OpTt4ozrq1Yv5z9
	hD60ZfPBuEEjXSezLVKp3d+v3uskcc8kFmrCbWVi+fbDW1bHsAXJ7BTx+/c9IuA28uZdhoVonu5
	UypA46/10dgM/PKsyAMBRX/xikWaWkAV90C0Lef4uaYto6SAC644C21TULUyK0u6+QLzoQjNm24
	hbf69QgYxHZcruIhwEr3iCUP2/kLMdtwTcMhLS7J53tlUw0rP0Sd3T0QdvBs4HVOv3XeZCbKrCH
	dwfPFZwjo/qhkL14B5DR0LZ6ZylBDa46sp4sAfjvHO2VvQzLQcDM2QlN46ONqvkhHNorBcPLHlB
	z0sCtdeRIbnBDDVdv/vEFUh3+YFqjEvwDBvTGqVXiO3E1H5hCSxo26HjAcbARv2HzpQ==
X-Google-Smtp-Source: AGHT+IErSIYbBjTISh274TM0XQdjLCNlviEsTm6HU/bE+ESPLBBXm3Y78kyPvgMPCcKp5u/y/AKUxw==
X-Received: by 2002:a17:903:230a:b0:262:cd8c:bfa8 with SMTP id d9443c01a7336-268137f1e73mr70081335ad.34.1758207675702;
        Thu, 18 Sep 2025 08:01:15 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.mshome.net ([70.37.26.59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980302b20sm28425005ad.101.2025.09.18.08.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:01:07 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
X-Google-Original-From: Tianyu Lan <tiala@microsoft.com>
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
	tiala@microsoft.com,
	kvijayab@amd.com,
	romank@linux.microsoft.com
Cc: linux-arch@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH 3/5] x86/hyperv: Don't use auto-eoi when Secure AVIC is available
Date: Thu, 18 Sep 2025 11:00:21 -0400
Message-Id: <20250918150023.474021-4-tiala@microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250918150023.474021-1-tiala@microsoft.com>
References: <20250918150023.474021-1-tiala@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hyper-V doesn't support auto-eoi with Secure AVIC.
So set the HV_DEPRECATING_AEOI_RECOMMENDED flag
to force writing the EOI register after handling an interrupt.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index c78f860419d6..6dd3ae66a646 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -464,6 +464,9 @@ static void __init ms_hyperv_init_platform(void)
 
 	hv_identify_partition_type();
 
+	if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
+		ms_hyperv.hints |= HV_DEPRECATING_AEOI_RECOMMENDED;
+
 	if (ms_hyperv.hints & HV_X64_HYPERV_NESTED) {
 		hv_nested = true;
 		pr_info("Hyper-V: running on a nested hypervisor\n");
-- 
2.25.1


