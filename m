Return-Path: <linux-arch+bounces-13079-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE3EB1C5B2
	for <lists+linux-arch@lfdr.de>; Wed,  6 Aug 2025 14:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A925622B0
	for <lists+linux-arch@lfdr.de>; Wed,  6 Aug 2025 12:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DAB28A721;
	Wed,  6 Aug 2025 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/LrRqxN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E209C26E710;
	Wed,  6 Aug 2025 12:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754482742; cv=none; b=AVGBrMP/c1kgDxsx1RyzCf0FGP47Xf3Xr0ER302gUzMiffN3R0xUmEEGEyufr5IWdYtDG0dIcGPc3XCfqM88qAKDn/Ro3RXJHHuIMAeC6lHD5MP/whgGJLUArs2hqeryRyGU5pyxypPdbU8Sl0y4XaTayJzVRVsJs30SeUtdmrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754482742; c=relaxed/simple;
	bh=hSFA8qtVfzMc5s9jfMNEqt+3cXNT7uR7K30ErKjltc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XHMYRMjQbI0nHa7ZP/klDtuH19SX5bytug1+PZbIyP7CvUFQTm8yebbostOickMvdavi8NW1rIUCQYou7EQAYskKild6Xy2fy1djJ7cfkphW36uIJNmMitd6ToEfFg+DIjpG61wYmWE1AG7mqNWoFOWZSz6efyKYlCOkcY2t5n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/LrRqxN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24022261323so9081565ad.1;
        Wed, 06 Aug 2025 05:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754482739; x=1755087539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jgc038c2v6U/eJUJ8uwSr0YExE6QXlfF5ru9RBAi2LQ=;
        b=c/LrRqxNtDnblEAMLKwSIkg8PSKjYLpsroQIeT3jxojkifjh3dKm4/DIwGXjjYGKe1
         3YuJg/q1bTFy+Prp9hH9V1pzcflT2aTRaHdb+1Fz4L1VXRmAhhU4RazEtvtwt41ESPAR
         Mddtrz+HHR/BERc3m9qldb5uHwxL363nHVx/ucvjKLqk6JlL1z35H95Owz2JAslxO7OM
         H0lR+8ivll/lzr0nEggmm4gXx7Dxrl5JqAD71j43bbr121HvT6pquj3hgwJlzbn4E3nF
         NXd/ofqaby4/C6cbqT1nrvcLC7ppsuiuUUXkFHgf31qzJ3IdBjJtYQo/poaoFPms8fPV
         rZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754482739; x=1755087539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jgc038c2v6U/eJUJ8uwSr0YExE6QXlfF5ru9RBAi2LQ=;
        b=TxMaiiBdVwEKRq/1W0jyNrCPun6YvhBEB/qxURj/V6hoU1fsTU3tcIRKFadUQgSB0/
         7T7/wx+y812BCYdS5ODtFtaWh0ALoEap9VyiDNnFuQPDHzgrYRUoLTWIEuCXGMKdPOV9
         JIU4Fsey9rq2tAFYw6qES6j1B97rFXT5c8Xg/Q8Zox5+zgEVlRs+CV1N6mpcp6/gKjwm
         n1VtM9pa3GfvzaZLLZpf1U3eBxjmPAPl2VLLxga6+Rmk4abpHVDEleRCBpWEDlBVzyFB
         B/CarvbnDelxGk8q6tjtiffft+pU096O2RN0Hqp6bO6Ydu6rquXFCH0FyMDdrQyWZHN1
         Ks2g==
X-Forwarded-Encrypted: i=1; AJvYcCU5d4KG03zWBBeEKrcQE9d3CvP+12b18MOfpGU+ntjYyASE91bsqPA8WgyCL7XXMtbRjbt8ha2x/ABToyDw@vger.kernel.org, AJvYcCUYrH1VK4zj62Beuv9LOmSNqMPSU2Oo7Tz5Ig8kfbGD0s2REFdnqDT+l5IACaRezrTzsiImyqN2BjPz@vger.kernel.org, AJvYcCVm70ed0tV2xSHOw6qt0hTl4RPWT4Sbvs8UQsBuJPCSuwwQLoqN2D4qypxR2n+u8AC3eqx55JmHBFOX9Ape@vger.kernel.org
X-Gm-Message-State: AOJu0YyJhDbiG0ug5mfJ+fnR+fwV/bI2WHcCnP13QoKkKNcAxyaJVFNK
	xeaQOvd/fBZpEoBc+x/wCRwYiYtffPPGbYgb84u5YSHrgW3cVAqdgxEn
X-Gm-Gg: ASbGncsPP28B3ENWBPXL0tdgqcGLb8S8dWWbTVVVZejsktEBwMavmATvgJcDzw0aV9Z
	M+vT6GEqVub+B38w0YcC8sCKeaGHdC/nBweG7b0bGIfAhdq6rxYyF+Ov2HXL8h4sj/rEbZ8vW5D
	sx0l6RpQgtidk5Ryr1eJMgw0eVZROXUggAVjl3y93eBSbIR31wR6TnwF+LF/7aITUdsDrGgX5AP
	M5ZLMbK8CXJReWJwV5vCxHZFEr54qybSmgY0BbNHlYh5/F3mxtA6qXkf5aws1uJ+58K3NaFDlvU
	eaeioNnHigIQyXkbf93UbvN4jvzyT8VhCN5bDsLNzuEvbxiajI3ks15fsaIDCJEXf4iUH6TfrOl
	vcOLU56MgOF4wQB/Mp0fRXtzxkUhLgtTWpbipCxb3KLBvl623yomav3K8Zw==
X-Google-Smtp-Source: AGHT+IFRbVNsZORFWmlieLEs9UJTH8Ete4v10TjNCdWe6b/8eyK68rAdTvNvkUDxj6YK6D6ki+zIhQ==
X-Received: by 2002:a17:903:13c8:b0:23f:f39b:eae4 with SMTP id d9443c01a7336-2429f8d46eamr43696345ad.9.1754482739060;
        Wed, 06 Aug 2025 05:18:59 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.mshome.net ([70.37.26.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0e81dsm157512705ad.46.2025.08.06.05.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 05:18:58 -0700 (PDT)
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
Subject: [RFC PATCH V6 1/4 Resend] x86/hyperv: Don't use hv apic driver when Secure AVIC is available
Date: Wed,  6 Aug 2025 20:18:52 +0800
Message-Id: <20250806121855.442103-2-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250806121855.442103-1-ltykernel@gmail.com>
References: <20250806121855.442103-1-ltykernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tianyu Lan <tiala@microsoft.com>

When Secure AVIC is available, the AMD x2apic Secure
AVIC driver will be selected. In that case, have hv_apic_init()
return immediately without doing anything.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
Change since RFC V3:
       - Update Change log and fix coding style issue.
---
 arch/x86/hyperv/hv_apic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index bfde0a3498b9..01bc02cc0590 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -25,6 +25,7 @@
 #include <linux/clockchips.h>
 #include <linux/slab.h>
 #include <linux/cpuhotplug.h>
+#include <linux/cc_platform.h>
 #include <asm/hypervisor.h>
 #include <asm/mshyperv.h>
 #include <asm/apic.h>
@@ -293,6 +294,9 @@ static void hv_send_ipi_self(int vector)
 
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


