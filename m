Return-Path: <linux-arch+bounces-13671-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5931B856B9
	for <lists+linux-arch@lfdr.de>; Thu, 18 Sep 2025 17:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF14A2A4AC3
	for <lists+linux-arch@lfdr.de>; Thu, 18 Sep 2025 15:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1885B22FE15;
	Thu, 18 Sep 2025 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8o7GE2s"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB31A31
	for <linux-arch@vger.kernel.org>; Thu, 18 Sep 2025 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207668; cv=none; b=HdLttUD/3Fe9QJwZ8e9uyNyJtYGtoeLbDP4PG6VwgNMAO+CWHDE0CzJobrdoyLDXL7vzLq9K2EXOOsAIqas26v8PC+WDkbOlD4uK4CzpbczBCcmUwLBgT25b7B4s4TZy3NIJPfcWy9zT99cR35hKc+9H/gmSFv7zmdPKEC1kW3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207668; c=relaxed/simple;
	bh=BsgbLzi8ykvPS6jo1iruqUwjXtbQRUgckgzTsgqQuRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pbxtBBsSO9otxubtRryWP/Mj95o6ZblOUv1q60u3zD14tt/zyIBEoOfIc+FW8cjkKi+wIPg6U1eNteBOdvgm+MCSaxuX5g1vyyFarMe2mYIA/gHMmSrNo9nQYz/P3Wr6fV/QreZFmMbTOtgOpKSDOOqbY6EEEKhG+jgSTL6g2+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8o7GE2s; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77796ad4c13so770398b3a.0
        for <linux-arch@vger.kernel.org>; Thu, 18 Sep 2025 08:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758207665; x=1758812465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXM1tE5z3e4zIfIy5XocMUApUPbo2Ex8jjAHwT/2auY=;
        b=c8o7GE2sd2jEknOx+5kBt8uDYT4hYeepEl5pDywIrEbRu96OQtTZr3ABh4HsDUDu2h
         e2JxgljErFZriVePnBPEcd9anu4YHujfVTQiIbz2BwjgD6OyuRsQrd6N8DUl7wimmoDr
         wswscDO5/t1Sg7ez8cM8LeszYwWWQHGjQ1qnNkUfNTWfJhfuPq0p5TvYZuhCKwpq1k0a
         CTOVYeEp10/Nen4xRihNZnbHKVQwqcIMa16U539cslGw31D303loZ3M7OgyU4Qik8l9G
         DbqfFqaEG0i2hBHGE5+tTE4rQ15e6LooJG17Xc4gpWI4x4T/CeB8XAXkO6ejVc2aABL2
         /SHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758207665; x=1758812465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXM1tE5z3e4zIfIy5XocMUApUPbo2Ex8jjAHwT/2auY=;
        b=BDLsvIakbcW8LcKk0yHo8QUs80Ca5ETKmKhMwIuDPtVtWM+R6q3Ka/TY5WdbTevjDu
         NaT3Q5tSTek0EuJzeNmTfZs/CopgJ3v7IzEIanIfGLSIKChK5/rlOgK5TyR02ELS8XYZ
         ErmoezvMyDJ4skY67VU+DC+7BNXWIm5/XQa8xddee57oRYNV9aQk5SbWfJzwqlnHMcET
         N8byuUz5QYb7xDTSljs2wHPy57JBbv2eJsask18/ihJXO7gI32A1YvyF86peMsKThGjF
         iqyn79OQiN/QwSIBWD6dOR7v0ciVwez5nKqIsOm0Fg0IQr7k+iITH7VJIpis8u3MLsB9
         s1lw==
X-Gm-Message-State: AOJu0YyDaGuHUKZQBok6N4AG98GGO3Ta3njGjjsytGYLpPQlwEOS+VDP
	36xjqBNL3tlKNeDaGVpjWUTMt+FOTAfF++SjNKdUIahBAW75SLMkUCNA
X-Gm-Gg: ASbGncvtVhqPrw9jFUzP1q+XU/SZw9Q0CDemnGeojeobwtqiMJ16tsc69eLX1DCmy5F
	qV8MKFC0SvRBDMr3dUO4E1gDLD/dl9qhLDG9zg3114l9/+fnbh7uG9d+JUuw2BqgCtzg0yL+d38
	1/TUeud7t7DDD5YR+w/pxCXUWVj/vxqo1r2WSraVmuY/JEJOZLcFXrii2YVIuErhE66tExCrRgD
	Ih+DaIJ82P5h7d6jErtDhMky/p6SFwhchOdWBA0wIfqWzDIrGHQrcu2cyw6ahvTeHyC4YwkMzZm
	JQKKs8qdVLtpve+7a/Hb/8g5/QZCUIJT5Iaw8l9nh/aBCpTg4JJF5Qgw3Y0ABmT9CpuBeI59xSM
	TTpVCnbeTJii54/lKZ+3BMgTXeXlGPMcQy20zSPnWFwzyqWm0f8cH8CVi0WwBcmmgaQ==
X-Google-Smtp-Source: AGHT+IH+J9A3txSiiKsGwoZYqM/WkCKpiuJbHT/7NSTE/twbx2+d6WnfUG7cuj7YDeh4EAjo0eJHNw==
X-Received: by 2002:a17:903:1b24:b0:268:15f:8358 with SMTP id d9443c01a7336-268138fe34cmr88902925ad.42.1758207665172;
        Thu, 18 Sep 2025 08:01:05 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.mshome.net ([70.37.26.59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980302b20sm28425005ad.101.2025.09.18.08.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:01:04 -0700 (PDT)
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
Subject: [PATCH 1/5] x86/hyperv: Don't use hv apic driver when Secure AVIC is available
Date: Thu, 18 Sep 2025 11:00:19 -0400
Message-Id: <20250918150023.474021-2-tiala@microsoft.com>
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

When Secure AVIC is available, the AMD x2apic Secure
AVIC driver will be selected. In that case, have
hv_apic_init() return immediately without doing
anything.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/hyperv/hv_apic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index bfde0a3498b9..e669053b637d 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -293,6 +293,9 @@ static void hv_send_ipi_self(int vector)
 
 void __init hv_apic_init(void)
 {
+	if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
+		return;
+
 	if (ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) {
 		pr_info("Hyper-V: Using IPI hypercalls\n");
 		/*
-- 
2.25.1


