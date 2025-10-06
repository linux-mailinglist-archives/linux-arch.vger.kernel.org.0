Return-Path: <linux-arch+bounces-13938-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9515BBFB5B
	for <lists+linux-arch@lfdr.de>; Tue, 07 Oct 2025 00:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90010189A66C
	for <lists+linux-arch@lfdr.de>; Mon,  6 Oct 2025 22:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8D3214801;
	Mon,  6 Oct 2025 22:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rKo5bJJ0"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15A1288A2;
	Mon,  6 Oct 2025 22:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759790538; cv=none; b=LdW9b08xkx1WrAtjl7qJfKU1O9WR8ezAQLf8qcG0RL54F/CX2zc8Ns+Exwlgf/loo8hDRuqdxWsqIyeCEntdHcHBxLLjv2k2qJJ4H75JHuzWnV1holVtHFWZaDB08tJ7sq6TNMRJ2fRQosG4eWz5yQBYO8rnO3J3r1Z+QUKdhxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759790538; c=relaxed/simple;
	bh=4QFWhw/VhPH8Jg9vfMQpWMMN0VSErg30cgw08sZp81E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ugwf2BEToAvFD+3fNWquwWzD/IrywYzzhkuGwXxsgxvXSkLx0iGDviYFnpUwJdv8awA95GyifOylsjB3wAU0pUWjwD03UyTkcE+sY6Ks3IzWoKcugjxFh7dKLvwEh98X+G1xzlKwF0QLw9EZlMyBYLrhyb2ZL5ulVZYpvbrAuBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rKo5bJJ0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id A7BA5211CDF5;
	Mon,  6 Oct 2025 15:42:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A7BA5211CDF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759790536;
	bh=shIB0wSQTVqlYsvlrJ8+kHGgr1N/kb1B3QWxAVfE8N0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rKo5bJJ0IQToDB3Ti7yd6bUByY4p76mCRW4AR++9x3iBxpdnGmbcOajjiywDXZRfl
	 5RHgMQ+vYFY+eSddc5ByPMHHXXAM1Oqw2LvlOUIjYUXlYhsDX+Ga5jOjGtTbtZe53Z
	 MbQCualM0e5XR+zzDvACPxz1qGPenhVNrt7ncHT0=
From: Mukesh Rathor <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de
Subject: [PATCH v3 2/6] hyperv: Add two new hypercall numbers to guest ABI public header
Date: Mon,  6 Oct 2025 15:42:04 -0700
Message-Id: <20251006224208.1060990-3-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
In-Reply-To: <20251006224208.1060990-1-mrathor@linux.microsoft.com>
References: <20251006224208.1060990-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for the subsequent crashdump patches, copy two hypercall
numbers to the guest ABI header published by Hyper-V. One to notify
hypervisor of an event that occurs in the root partition, other to ask
hypervisor to disable the hypervisor.

Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
---
 include/hyperv/hvgdk_mini.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 77abddfc750e..bec54a103d62 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -469,6 +469,7 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
 #define HVCALL_MAP_DEVICE_INTERRUPT			0x007c
 #define HVCALL_UNMAP_DEVICE_INTERRUPT			0x007d
 #define HVCALL_RETARGET_INTERRUPT			0x007e
+#define HVCALL_NOTIFY_PARTITION_EVENT                   0x0087
 #define HVCALL_NOTIFY_PORT_RING_EMPTY			0x008b
 #define HVCALL_REGISTER_INTERCEPT_RESULT		0x0091
 #define HVCALL_ASSERT_VIRTUAL_INTERRUPT			0x0094
@@ -492,6 +493,7 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
 #define HVCALL_GET_VP_CPUID_VALUES			0x00f4
 #define HVCALL_MMIO_READ				0x0106
 #define HVCALL_MMIO_WRITE				0x0107
+#define HVCALL_DISABLE_HYP_EX                           0x010f
 
 /* HV_HYPERCALL_INPUT */
 #define HV_HYPERCALL_RESULT_MASK	GENMASK_ULL(15, 0)
-- 
2.36.1.vfs.0.0


