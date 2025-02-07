Return-Path: <linux-arch+bounces-10052-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 853B2A2CC3B
	for <lists+linux-arch@lfdr.de>; Fri,  7 Feb 2025 20:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29AA4188D084
	for <lists+linux-arch@lfdr.de>; Fri,  7 Feb 2025 19:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013641B0409;
	Fri,  7 Feb 2025 19:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sgtvWWA/"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38393176AB5;
	Fri,  7 Feb 2025 19:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738955024; cv=none; b=oHbRZrJfi6HILOI5jiZSw33OTk0NIaPdez7tM6jeS1q/NCRfMPMowvrBBU0wTKxnTk7pp5IXU1hcSCaCMeBjWDok2xZYW81K0EA7TYQK+1UNKk0BefffbFId7TPh+UGGQsv4EybiU2cw+KZf9iGXXaMuvojkAyJnGPj82G1fXJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738955024; c=relaxed/simple;
	bh=eb4LAcVD5QHfvrYZxDdMIn+cbVK4NQTuxZZZC6j+NWU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=luz+s23dSxj/m7BoD4UdPBj5volvHVqbwFkboSA3WhzBM0Tg9Ie9EzmCiUEXXy3llBh1hQUo6yUWvguP6qLbQPGEB5H4SwWHkcwKVPBSzhEVwijUUK8MFEJk79U0s98swMdANvKHclysoohXeGyO/b0yw6NlPY9jre6CTOBhNYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sgtvWWA/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 249502107305;
	Fri,  7 Feb 2025 11:03:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 249502107305
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738955017;
	bh=xX+XVFZmDa0loQ6xNj16gwk+BuKlZVk5CTsEHisc09Q=;
	h=From:To:Cc:Subject:Date:From;
	b=sgtvWWA/hqIKpssFoNrKh1/hgsZgqNSTWihh0PLe3YUb92zm0ou8GkXK1Y/xwP8lo
	 59LKpGV01e7zseYnHKRZsw6aBlDlUwGc++m+Q+Co/AAbAtZxdgzLEsCYXVwiRFOPdX
	 VHWwaXqF5A0IfG7YL08bM9sKZknzolFsPXktCSuI=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	wei.liu@kernel.org,
	mhklinux@outlook.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com,
	skinsburskii@linux.microsoft.com,
	mukeshrathor@microsoft.com
Subject: [PATCH v3 0/2] hyperv: Move some features to common code
Date: Fri,  7 Feb 2025 11:03:20 -0800
Message-Id: <1738955002-20821-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

There are several bits of Hyper-V-related code that today live in
arch/x86 but are not really specific to x86_64 and will work on arm64
too.

Some of these will be needed in the upcoming mshv driver code (for
Linux as root partition on Hyper-V). So this is a good time to move
them to drivers/hv.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
Changes in v3:
* Just use percpu input page for the hypercall [Michael Kelley]
* Move the calls to hv_get_partition_id() back to arch code [Michael Kelley]
* Rename struct hv_get_partition_id to hv_output_get_partition_id
  [Michael Kelley]

Changes in v2:
* Fix dependence on percpu output page by using a stack variable for the
  hypercall output [Michael Kelley]
* Remove unnecessary WARN()s [Michael Kelley]
* Define hv_current_partition_id in hv_common.c [Michael Kelley]
* Move entire hv_proc.c to drivers/hv [Michael Kelley]

Nuno Das Neves (2):
  hyperv: Move hv_current_partition_id to arch-generic code
  hyperv: Move arch/x86/hyperv/hv_proc.c to drivers/hv

 arch/arm64/hyperv/mshyperv.c              |  3 +++
 arch/x86/hyperv/Makefile                  |  2 +-
 arch/x86/hyperv/hv_init.c                 | 25 +----------------------
 arch/x86/include/asm/mshyperv.h           |  6 ------
 drivers/hv/Makefile                       |  2 +-
 drivers/hv/hv_common.c                    | 22 ++++++++++++++++++++
 {arch/x86/hyperv => drivers/hv}/hv_proc.c |  4 ----
 include/asm-generic/mshyperv.h            |  6 ++++++
 include/hyperv/hvgdk_mini.h               |  2 +-
 9 files changed, 35 insertions(+), 37 deletions(-)
 rename {arch/x86/hyperv => drivers/hv}/hv_proc.c (98%)

-- 
2.34.1


