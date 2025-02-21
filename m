Return-Path: <linux-arch+bounces-10314-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CCAA40037
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 21:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C6B13BCCC6
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 19:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8C8253B4C;
	Fri, 21 Feb 2025 19:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LlJcvvQO"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446EA1FF1BD;
	Fri, 21 Feb 2025 19:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740167804; cv=none; b=h6adcWImPGrby3RGQA/TyoorFLG4mtRq6kwLbMIphvxAxfWP6f11Pe84SuckCt0Y1Fe2a3cPf2lBKRQTpJYMcIlWvkKS9Qi0A9OBrHFlFxtOqDqJkym3C/OHl2uoid7DNwb+jr4RwEBEzLP+Ojw2eOwyya0g2Z9H/bquDHv7VR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740167804; c=relaxed/simple;
	bh=cK5ZkX8ixBppP4FPmLCm8+Ao5vnaEUpf9lYimO9zlWk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=evF4/UKic0vp9JksYUZMN2StsATGaW7m+KBYbSc+m8V1sdZoWUXGDcV3FOe5Dd74o9wz19hC6CfQMzCCUx47cjUPpCt9iXZ6zEXGe8l7Kw1wrqk8/cuPZxmXM8K6GhJHcianmRm22Sg0fLaswgKmkhEsQ4nKVsjNvXhZBu758VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LlJcvvQO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id B6B57204E5BC;
	Fri, 21 Feb 2025 11:56:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B6B57204E5BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740167802;
	bh=DXWUYYhpDF9cbvi+OP+J5thVCYC8+IMsDBUcsoZlY8E=;
	h=From:To:Cc:Subject:Date:From;
	b=LlJcvvQOgZJVX/Q2UUmFgjRVcib/5LYeSbCdU4Zbdhu4HAApNkZgNkHXz9Jrx1nZ6
	 MryWgCW5svmFC9BEHwNZRdQGNVrTMSnT0pNorXrYQvcVL52PRKF8rWic1hWlsT8hP/
	 b6O/RTJ2oaU7gllhyjwO7VBYtZBjNVSNyrI+fOKM=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	iommu@lists.linux.dev,
	mhklinux@outlook.com,
	eahariha@linux.microsoft.com,
	mukeshrathor@microsoft.com
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
	x86@kernel.org,
	hpa@zytor.com,
	daniel.lezcano@linaro.org,
	joro@8bytes.org,
	robin.murphy@arm.com,
	arnd@arndb.de,
	jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com,
	skinsburskii@linux.microsoft.com
Subject: [PATCH v2 0/3] Introduce CONFIG_MSHV_ROOT for root partition code
Date: Fri, 21 Feb 2025 11:56:32 -0800
Message-Id: <1740167795-13296-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Running in the root partition is a unique and specialized case that
requires additional code. CONFIG_MSHV_ROOT allows Hyper-V guest kernels
to exclude this code, which is important since significant additional code
specific to the root partition is expected to be added over time.

To do this, change hv_root_partition to be a function which is stubbed out
to return false if CONFIG_MSHV_ROOT=n, and don't compile hv_proc.c at all,
stubbing out those functions with inline versions.

Store the partition type (guest or root) in an enum hv_curr_partition_type,
which can be extended beyond just guest and root partition.

While at it, introduce hv_result_to_errno() to convert Hyper-V status codes
to regular linux errors. This is useful because the caller of a hypercall
helper function (such as those in hv_proc.c) usually can't and doesn't
interpret the Hyper-V status, so it is better to convert it to an error code
and reduce the possibility of misinterpreting it. This also alows the stubbed
versions of the hv_proc.c functions to just return a linux error code.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
Changes in v3:
* Fix a typo [Easwar Hariharan]
* Fix ret being initialized to HV_STATUS_SUCCESS in some hypercall helpers
  [Michael Kelley]
* Fix CONFIG_MSHV_ROOT being used in patch 2, before it is defined [Michael
  Kelley]
* Shorten hv_current_partition_type to hv_curr_partition_type [Mukesh Rathor]

Changes in v2:
* Add patch to convert hypercall statuses to linux error codes [Easwar
  Hariharan]
* While at it, split the original patch into two logical pieces, one to change
  hv_root_partition into a function, and one to introduce MSHV_CONFIG_ROOT
* Improve the clarity of and add an error message to
  hv_identify_partition_type() [Easwar Hariharan] [Michael Kelley]
* Better explain *why* the patches are useful, in the commit messages [Michael
  Kelley]
* Add a Kconfig comment explaining why PAGE_SIZE_4KB is needed [Michael Kelley]
* Minor style and typo fixes

Nuno Das Neves (3):
  hyperv: Convert hypercall statuses to linux error codes
  hyperv: Change hv_root_partition into a function
  hyperv: Add CONFIG_MSHV_ROOT to gate root partition support

 arch/arm64/hyperv/mshyperv.c       |  2 +
 arch/x86/hyperv/hv_init.c          | 10 ++---
 arch/x86/kernel/cpu/mshyperv.c     | 24 +----------
 drivers/clocksource/hyperv_timer.c |  4 +-
 drivers/hv/Kconfig                 | 16 +++++++
 drivers/hv/Makefile                |  3 +-
 drivers/hv/hv.c                    | 10 ++---
 drivers/hv/hv_common.c             | 69 +++++++++++++++++++++++++++---
 drivers/hv/hv_proc.c               | 10 ++---
 drivers/hv/vmbus_drv.c             |  2 +-
 drivers/iommu/hyperv-iommu.c       |  4 +-
 include/asm-generic/mshyperv.h     | 40 ++++++++++++++---
 12 files changed, 139 insertions(+), 55 deletions(-)

-- 
2.34.1


