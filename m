Return-Path: <linux-arch+bounces-13462-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B35B50994
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 02:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85B961C2807F
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 00:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF49A224D6;
	Wed, 10 Sep 2025 00:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oA6ai5T5"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EEF442C;
	Wed, 10 Sep 2025 00:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757463032; cv=none; b=alfehl9dhaxz8kC+tpCyuRpONiXn42SnhLf8dxOy5NwWVMPIByBF1SnEfKW9sLaH7j74BQmOLxVXDqcmbNqtohenf+VNBt7698wB5k/DCc/4bCvl+ncq/lQDKZsXrXR0DmCi7EQgMqpNz0telaCfRG6+yhxlVwTFTXW6zZ9c5pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757463032; c=relaxed/simple;
	bh=9ICHi1pM9HLaL+V4f8WYT9DRofaFIP3+WNyJ5oGj/KM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mEtfSo8nCpwJolY0kiwZrr6u0HNleTLOmJ+wW75f7hsagiaeFwQ0X+BCXJ8DOAnK7d0TnKQeMq+xc5eHlNTizGoxN5Lztj4O8i+uAAw5QFAaUS9S85SNueWsV0TXzKzRXZHzKlDAJbwbKWq70wKey1LnK3FM3mABhnxs+C+toB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oA6ai5T5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6490B2018E52;
	Tue,  9 Sep 2025 17:10:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6490B2018E52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757463030;
	bh=4FExu4Fssl/B2WMYYzV8pBir3oT3mfzt3nTlCllrVvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oA6ai5T52e+CEW8f7sbx5dEHCMZ+shUixdMZAoCTjkXTb3yiCoXWcsMnT1aPwaFoy
	 +z08794IUU3Cbf183OHjkoWkUaYMYN8AYIai6PRD7tjGCBxEvgyVsztIC0YG5M3TAf
	 54viQ+xF6pgDM9JnlNWwBVtFNvAS8CsLtIhzLCME=
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
Subject: [PATCH v1 2/6] hyperv: Add two new hypercall numbers to guest ABI public header
Date: Tue,  9 Sep 2025 17:10:05 -0700
Message-Id: <20250910001009.2651481-3-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
In-Reply-To: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
References: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
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
index 1be7f6a02304..5441bf47059a 100644
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


