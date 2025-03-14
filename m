Return-Path: <linux-arch+bounces-10831-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFDEA61A84
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 20:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C56A189EB93
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 19:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AA1205ADC;
	Fri, 14 Mar 2025 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PQ9z6eCq"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495E4204F8C;
	Fri, 14 Mar 2025 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741980567; cv=none; b=iN+kxkkg+ZebIxn05H+2tpqzOBAahpXcafbKAzFPQ/GU+IUyDi9TvSmejDBxDlWLBtUfzDtNoR8pE0uBT5IyT1g30GBCZ4DiagUlQrwpF016E2r10DFpC6MjH0hiweVSUUkUMRku4GbcBV03wd0V9o9OL5FyP8b2/nNqhwwCgOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741980567; c=relaxed/simple;
	bh=/NPjWqFiZUBA9kZVHML09VsP99vtNRasLwzaTdQCo0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=oH+qI4NK/xZdm+QuHsfcTv2YaXS4TuChH6oir21wkbOu3yAaq7DhHBQhahOybUx9lw22xl/MyjL+86irpCQV2RvUtmxMAOHQ2xdvYK6ovhq4qsqqznFXI3AZnD62rwq55KDm3L6ijXVsEhHtHOedVb4TgHo1W6DD1eJzieuaMKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PQ9z6eCq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 972EE2033456;
	Fri, 14 Mar 2025 12:29:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 972EE2033456
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741980564;
	bh=FUdDLeTcFv7peeEsvlaUqyHqo41x8jGlZj8eHhigyuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PQ9z6eCqIupiYkGG5TlmdH1mNJebiDCLhXL8ck324lwF7H/kECeYM8nAzuTF0QAKi
	 spwx2HjSI8QiRV0nMwmoCtwMrd0Ola9VV1TnE9i2o/oV3BIR5HfTYVFmOXTI+hceBy
	 7XdeOQ7VyEHc/nMraIzqQsieqDfk4Lri6rwM1rpY=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	mhklinux@outlook.com,
	ltykernel@gmail.com,
	stanislav.kinsburskiy@gmail.com,
	linux-acpi@vger.kernel.org,
	eahariha@linux.microsoft.com,
	jeff.johnson@oss.qualcomm.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	daniel.lezcano@linaro.org,
	joro@8bytes.org,
	robin.murphy@arm.com,
	arnd@arndb.de,
	jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com,
	skinsburskii@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	apais@linux.microsoft.com,
	gregkh@linuxfoundation.org,
	vkuznets@redhat.com,
	prapal@linux.microsoft.com,
	anrayabh@linux.microsoft.com,
	rafael@kernel.org,
	lenb@kernel.org,
	corbet@lwn.net
Subject: [PATCH v6 05/10] acpi: numa: Export node_to_pxm()
Date: Fri, 14 Mar 2025 12:28:51 -0700
Message-Id: <1741980536-3865-6-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741980536-3865-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1741980536-3865-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

node_to_pxm() is used by hv_numa_node_to_pxm_info().
That helper will be used by Hyper-V root partition module code
when CONFIG_MSHV_ROOT=m.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
---
 drivers/acpi/numa/srat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 00ac0d7bb8c9..ce815d7cb8f6 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -51,6 +51,7 @@ int node_to_pxm(int node)
 		return PXM_INVAL;
 	return node_to_pxm_map[node];
 }
+EXPORT_SYMBOL_GPL(node_to_pxm);
 
 static void __acpi_map_pxm_to_node(int pxm, int node)
 {
-- 
2.34.1


