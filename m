Return-Path: <linux-arch+bounces-4402-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E440A8C5DB3
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 00:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07B5A1C20B7C
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2024 22:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E2A182C82;
	Tue, 14 May 2024 22:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hxA4XCe8"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A751DDEE;
	Tue, 14 May 2024 22:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715726728; cv=none; b=k4Lgo8KlKKCTmjCjQJuMg3GQc50enuUlWzhK0LJ+FaxIALlojDirH1ME++96ax/T4n10YzVSuzWifkffE9C2mdHLk0FxOKIyCOG5qvHsMcht0PDS7Xakv8KziGQPit4Tu5HtnrACTdvySTgqooctJBv/00GM/RW1bdMBghbzwq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715726728; c=relaxed/simple;
	bh=HHDHLSCUcDkXx2uqLNf9uPS83M7l1vBf2On96gJLrfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j1vrtLNWT2bDERDzsIpzXWxHPQLC1+tBf8yA5GVrp9nVe+IUEdLilGNuPbaWGj/zcHp+n7pjlYau6UYPB60mOntGW+8HnPMkP69lbwEG9zBqtXFndFjtuml9vPbG+kF7sTJeAwjrYiGS4V02HKattkGT5tXB/IJpxRsdFs1B9uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hxA4XCe8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from xps-8930.corp.microsoft.com (unknown [131.107.160.48])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8524D2095D0A;
	Tue, 14 May 2024 15:45:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8524D2095D0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715726720;
	bh=qxYAU41ufrcEuk5MBvISwhpcVtWEJqX1bSnGVnSsBJA=;
	h=From:To:Cc:Subject:Date:From;
	b=hxA4XCe8Juhir+FZZpJrKKh+6AgX5CJywj6GV8Xi/9mMDaSuTJADZOUG6chVjOeoI
	 iFIa6Lspd7PVMua/OJlt8zSCUs/T4QbGvSO/XjtyBlWqNOG/FKHivMiM5m2YwtLVoM
	 Dmgp84jtkEDkxqeGm8kbKFXVtvJqijFdODzWecY0=
From: Roman Kisel <romank@linux.microsoft.com>
To: arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kw@linux.com,
	kys@microsoft.com,
	lenb@kernel.org,
	lpieralisi@kernel.org,
	mingo@redhat.com,
	mhklinux@outlook.com,
	rafael@kernel.org,
	robh@kernel.org,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	will@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	x86@kernel.org
Cc: ssengar@microsoft.com,
	sunilmut@microsoft.com,
	vdso@hexbites.dev
Subject: [PATCH v2 0/6] arm64/hyperv: Support Virtual Trust Level Boot
Date: Tue, 14 May 2024 15:43:47 -0700
Message-ID: <20240514224508.212318-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch set enables the Hyper-V code to boot on ARM64 inside a Virtual Trust
Level. These levels are a part of the Virtual Secure Mode documented in the
Top-Level Functional Specification available at
https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/vsm

[V2]
    - Decreased number of #ifdef's
    - Updated the wording in the commit messages to adhere to the guidlines
    - Sending to the correct set of maintainers and mail lists

Roman Kisel (6):
  arm64/hyperv: Support DeviceTree
  drivers/hv: Enable VTL mode for arm64
  drivers/hv: arch-neutral implementation of get_vtl()
  arm64/hyperv: Boot in a Virtual Trust Level
  drivers/hv/vmbus: Get the irq number from DeviceTree
  drivers/pci/hyperv/arm64: vPCI MSI IRQ domain from DT

 arch/arm64/hyperv/Makefile          |  1 +
 arch/arm64/hyperv/hv_vtl.c          | 19 +++++++++++++
 arch/arm64/hyperv/mshyperv.c        | 40 +++++++++++++++++++++++----
 arch/arm64/include/asm/mshyperv.h   |  8 ++++++
 arch/x86/hyperv/hv_init.c           | 34 -----------------------
 arch/x86/hyperv/hv_vtl.c            |  2 +-
 arch/x86/include/asm/hyperv-tlfs.h  |  7 -----
 drivers/hv/Kconfig                  |  6 ++--
 drivers/hv/hv_common.c              | 43 +++++++++++++++++++++++++++++
 drivers/hv/vmbus_drv.c              | 37 +++++++++++++++++++++++++
 drivers/pci/controller/pci-hyperv.c | 13 +++++++--
 include/asm-generic/hyperv-tlfs.h   |  7 +++++
 include/asm-generic/mshyperv.h      |  6 ++++
 include/linux/acpi.h                |  9 ++++++
 14 files changed, 179 insertions(+), 53 deletions(-)
 create mode 100644 arch/arm64/hyperv/hv_vtl.c


base-commit: f2580a907e5c0e8fc9354fd095b011301c64f949
-- 
2.45.0


