Return-Path: <linux-arch+bounces-10826-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC0BA61A71
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 20:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A43189D429
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 19:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20332204F74;
	Fri, 14 Mar 2025 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RT+cdpJM"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80023D531;
	Fri, 14 Mar 2025 19:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741980566; cv=none; b=rKNGKh2Hpn+ReGU6TSK7ZBmLHJcX98CVZxA4hQ7DN6p9L7DXBNmRLNJk37YCAGEkKdTILwGcSe8kfAULYcoYPuPYScA94h+fmCnvPhzgPKU8NbEKNTCub7OEgbE+E3XvywdybMZMIYAT9W/bpsaKPF01GOiCqcqbEBNsoswnkWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741980566; c=relaxed/simple;
	bh=p6CYCu+6cutueEZWfE5SGHb/RPZBZUyczw+yzOZsGio=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ijMQCWPxCi9eMYn7WsH64KUKt6PhOItGve9gnCcpGNKqoa6R2gElivwnVQPG9VQvhC18XveUo0P3JJ+1/voJH4djWuNx74WhdsPH0QubtY58vHduU7JE+wV09zqlTNLzcN99ucd9UvMdaleHBY966dRB5Jj/htQXBJD+h/KG+rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RT+cdpJM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id E01692033454;
	Fri, 14 Mar 2025 12:29:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E01692033454
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741980563;
	bh=HVcDUfdWEV/CxlgnXs/WJ2a6+xXKstleyiakidyOz5Y=;
	h=From:To:Cc:Subject:Date:From;
	b=RT+cdpJMHRpu5zFJKOc4I/uiHnO4Zx4QiWZb67xy0wBe/n2XUGp+EhFp5ZzXIFJ66
	 aybOf8vbQa9elwwrVrw0U0CPjPXQr3NCRdkGjgxum8IdPVjnaXSHScOn/GhUeSdmh/
	 hzp6zRISg9zz6Ccnw0EOD9PfyMPsHp8Qzzkfn1EU=
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
Subject: [PATCH v6 00/10] Introduce /dev/mshv root partition driver
Date: Fri, 14 Mar 2025 12:28:46 -0700
Message-Id: <1741980536-3865-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

This series introduces support for creating and running guest virtual
machines while running on the Microsoft Hypervisor[0] as root partition.
This is done via an IOCTL interface accessed through /dev/mshv, similar to
/dev/kvm. Another series introducing this support was previously posted in
2021[1], and versions 1-4 of this series were posted in 2023[2].

Patches 1-4 are small refactors and additions to Hyper-V code.
Patches 5-6 just export some definitions needed by /dev/mshv.
Patches 7-9 introduce some functionality and definitions in common code, that
are specific to the driver.
Patch 10 contains the driver code.

-----------------
[0] "Hyper-V" is more well-known, but it really refers to the whole stack
    including the hypervisor and other components that run in Windows
    kernel and userspace.
[1] Previous /dev/mshv patch series (2021) and discussion:
https://lore.kernel.org/linux-hyperv/1632853875-20261-1-git-send-email-nunodasneves@linux.microsoft.com/
[2] v4 (2023):
https://lore.kernel.org/linux-hyperv/1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com/

-----------------
Changes since v5:
* Rework patch 1:
 1. Introduce hv_status_printk() logging macros which print the raw HV_STATUS_
    code along with string [Roman Kisel]
 2. Iterate over an array of data items to get the string and errno for the
    hv_result_to_*() functions. [Michael Kelley]
 3. Use hv_status_printk() to log errors in hyperv/irqdomain.c and
    hyperv-iommu.c [Easwar Hariharan]
* Minor cleanup, improvements, and commit wording changes in patches 2, 3, 4, 6
  [Roman Kisel, Easwar Hariharan, Michael Kelley]
* Fix issues with declaration and lifecycle of hv_synic_eventring_tail in patch
  7 [Michael Kelley]
* Improve detail and clarity of commit message in patch 8 [Michael Kelley]
* Minor cleanups in patch 9 - uapi types -> kernel types, #ifdef CONFIG_X86_64
  -> CONFIG_X86 for consistency, fix HVCALL_* ordering, remove redundant
  __packed, use explicit enum value [Stanislav Kinsburskii, Easwar Hariharan,
  Michael Kelley, Tianyu Lan]
* Minor fixes and cleanup in patch 10 [Michael Kelley]
* Add MODULE_DESCRIPTION() to patch 10 [Jeff Johnson]

Changes since v4:
* Slim down the IOCTL interface significantly, via several means:
  1. Use generic "passthrough" call MSHV_ROOT_HVCALL to replace many ioctls.
  2. Use MSHV_* versions of some of the HV_* definitions.
  3. Move hv headers out of uapi altogether, into include/hyperv/, see:
https://lore.kernel.org/linux-hyperv/1732577084-2122-1-git-send-email-nunodasneves@linux.microsoft.com/
* Remove mshv_vtl module altogther, it will be posted in followup series
  * Also remove the parent "mshv" module which didn't serve much purpose
* Update and refactor parts of the driver code for clarity, extensibility

Changes since v3 (summarized):
* Clean up the error and debug logging:
  1. Add a set of macros vp_*() and partition_*() which call the equivalent
     dev_*(), passing the device from the partition struct
     * The new macros also print the partition and vp ids to aid debugging
	   and reduce repeated code
  2. Use dev_*() (mostly via the new macros) instead of pr_*() *almost*
  everywhere - in interrupt context we can't always get the device struct
  3. Remove pr_*() logging from hv_call.c and mshv_root_hv_call.c

Changes since v2 (summarized):
* Fix many checkpatch.pl --strict style issues
* Initialize status in get/set registers hypercall helpers
* Add missing return on error in get_vp_signaled_count

Changes since v1 (summarized):
* Clean up formatting, commit messages

Nuno Das Neves (9):
  hyperv: Log hypercall status codes as strings
  arm64/hyperv: Add some missing functions to arm64
  hyperv: Introduce hv_recommend_using_aeoi()
  acpi: numa: Export node_to_pxm()
  Drivers: hv: Export some functions for use by root partition module
  Drivers: hv: Introduce per-cpu event ring tail
  x86: hyperv: Add mshv_handler() irq handler and setup function
  hyperv: Add definitions for root partition driver to hv headers
  Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs

Stanislav Kinsburskii (1):
  x86/mshyperv: Add support for extended Hyper-V features

 .../userspace-api/ioctl/ioctl-number.rst      |    2 +
 arch/arm64/hyperv/hv_core.c                   |   17 +
 arch/arm64/hyperv/mshyperv.c                  |    1 +
 arch/arm64/include/asm/mshyperv.h             |   13 +
 arch/x86/hyperv/irqdomain.c                   |    6 +-
 arch/x86/kernel/cpu/mshyperv.c                |   16 +-
 drivers/acpi/numa/srat.c                      |    1 +
 drivers/hv/Makefile                           |    5 +-
 drivers/hv/hv.c                               |   12 +-
 drivers/hv/hv_common.c                        |  175 +-
 drivers/hv/hv_proc.c                          |   13 +-
 drivers/hv/mshv.h                             |   30 +
 drivers/hv/mshv_common.c                      |  161 ++
 drivers/hv/mshv_eventfd.c                     |  833 ++++++
 drivers/hv/mshv_eventfd.h                     |   71 +
 drivers/hv/mshv_irq.c                         |  124 +
 drivers/hv/mshv_portid_table.c                |   84 +
 drivers/hv/mshv_root.h                        |  308 +++
 drivers/hv/mshv_root_hv_call.c                |  852 ++++++
 drivers/hv/mshv_root_main.c                   | 2333 +++++++++++++++++
 drivers/hv/mshv_synic.c                       |  665 +++++
 drivers/iommu/hyperv-iommu.c                  |    4 +-
 include/asm-generic/mshyperv.h                |   34 +-
 include/hyperv/hvgdk_mini.h                   |   72 +-
 include/hyperv/hvhdk.h                        |  132 +-
 include/hyperv/hvhdk_mini.h                   |   91 +
 include/uapi/linux/mshv.h                     |  287 ++
 27 files changed, 6266 insertions(+), 76 deletions(-)
 create mode 100644 drivers/hv/mshv.h
 create mode 100644 drivers/hv/mshv_common.c
 create mode 100644 drivers/hv/mshv_eventfd.c
 create mode 100644 drivers/hv/mshv_eventfd.h
 create mode 100644 drivers/hv/mshv_irq.c
 create mode 100644 drivers/hv/mshv_portid_table.c
 create mode 100644 drivers/hv/mshv_root.h
 create mode 100644 drivers/hv/mshv_root_hv_call.c
 create mode 100644 drivers/hv/mshv_root_main.c
 create mode 100644 drivers/hv/mshv_synic.c
 create mode 100644 include/uapi/linux/mshv.h

-- 
2.34.1


