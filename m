Return-Path: <linux-arch+bounces-3639-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 788AF8A3132
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 16:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0584A1F21968
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 14:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3E814388E;
	Fri, 12 Apr 2024 14:46:03 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05C31419B0;
	Fri, 12 Apr 2024 14:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712933163; cv=none; b=svCKIfuaK7zVITKNTyQmSdzQEx2errDGVSGFiYJsGf97b9rpIOWGv77cab/Q/y2MbE9yu30ZGW3R1e657z1g9rHXOihGgLJ2yjGEAxaHFBIB22em99+PzJ7FVShXgN661qgDydfpBDH++1bbIgVMcwctk5sHcwWp1Eoggm0soL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712933163; c=relaxed/simple;
	bh=at/D2TnqgbwauUxHhWlbNw1UdgkgeRlnps3s3gggvsQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fp6O7nN7uN32P9u1Fomb/FE7uxBCslo7vXsSb3kjeSHDjKtSSnrmsdDWQGABoVooL3sLyb0om5FiRF8nt3pd04HGwuSeNOTcPsmothTfTHVFAsc0xb2Y9+8fylGfaz6vq6n1WCkFtA7+WJ3Xdu1EPjlGbz3thx3kTkoZwQo9kkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VGK4h0yHRz688p7;
	Fri, 12 Apr 2024 22:41:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 773E31400D4;
	Fri, 12 Apr 2024 22:45:58 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 15:45:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kvmarm@lists.linux.dev>, <x86@kernel.org>, Russell King
	<linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>, Miguel
 Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>, Salil Mehta
	<salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
CC: <linuxarm@huawei.com>, <justin.he@arm.com>, <jianyong.wu@arm.com>
Subject: [PATCH v5 17/18] arm64: document virtual CPU hotplug's expectations
Date: Fri, 12 Apr 2024 15:37:18 +0100
Message-ID: <20240412143719.11398-18-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240412143719.11398-1-Jonathan.Cameron@huawei.com>
References: <20240412143719.11398-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

From: James Morse <james.morse@arm.com>

Add a description of physical and virtual CPU hotplug, explain the
differences and elaborate on what is required in ACPI for a working
virtual hotplug system.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v5: No change.
---
 Documentation/arch/arm64/cpu-hotplug.rst | 79 ++++++++++++++++++++++++
 Documentation/arch/arm64/index.rst       |  1 +
 2 files changed, 80 insertions(+)

diff --git a/Documentation/arch/arm64/cpu-hotplug.rst b/Documentation/arch/arm64/cpu-hotplug.rst
new file mode 100644
index 000000000000..76ba8d932c72
--- /dev/null
+++ b/Documentation/arch/arm64/cpu-hotplug.rst
@@ -0,0 +1,79 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. _cpuhp_index:
+
+====================
+CPU Hotplug and ACPI
+====================
+
+CPU hotplug in the arm64 world is commonly used to describe the kernel taking
+CPUs online/offline using PSCI. This document is about ACPI firmware allowing
+CPUs that were not available during boot to be added to the system later.
+
+``possible`` and ``present`` refer to the state of the CPU as seen by linux.
+
+
+CPU Hotplug on physical systems - CPUs not present at boot
+----------------------------------------------------------
+
+Physical systems need to mark a CPU that is ``possible`` but not ``present`` as
+being ``present``. An example would be a dual socket machine, where the package
+in one of the sockets can be replaced while the system is running.
+
+This is not supported.
+
+In the arm64 world CPUs are not a single device but a slice of the system.
+There are no systems that support the physical addition (or removal) of CPUs
+while the system is running, and ACPI is not able to sufficiently describe
+them.
+
+e.g. New CPUs come with new caches, but the platform's cache toplogy is
+described in a static table, the PPTT. How caches are shared between CPUs is
+not discoverable, and must be described by firmware.
+
+e.g. The GIC redistributor for each CPU must be accessed by the driver during
+boot to discover the system wide supported features. ACPI's MADT GICC
+structures can describe a redistributor associated with a disabled CPU, but
+can't describe whether the redistributor is accessible, only that it is not
+'always on'.
+
+arm64's ACPI tables assume that everything described is ``present``.
+
+
+CPU Hotplug on virtual systems - CPUs not enabled at boot
+---------------------------------------------------------
+
+Virtual systems have the advantage that all the properties the system will
+ever have can be described at boot. There are no power-domain considerations
+as such devices are emulated.
+
+CPU Hotplug on virtual systems is supported. It is distinct from physical
+CPU Hotplug as all resources are described as ``present``, but CPUs may be
+marked as disabled by firmware. Only the CPU's online/offline behaviour is
+influenced by firmware. An example is where a virtual machine boots with a
+single CPU, and additional CPUs are added once a cloud orchestrator deploys
+the workload.
+
+For a virtual machine, the VMM (e.g. Qemu) plays the part of firmware.
+
+Virtual hotplug is implemented as a firmware policy affecting which CPUs can be
+brought online. Firmware can enforce its policy via PSCI's return codes. e.g.
+``DENIED``.
+
+The ACPI tables must describe all the resources of the virtual machine. CPUs
+that firmware wishes to disable either from boot (or later) should not be
+``enabled`` in the MADT GICC structures, but should have the ``online capable``
+bit set, to indicate they can be enabled later. The boot CPU must be marked as
+``enabled``.  The 'always on' GICR structure must be used to describe the
+redistributors.
+
+CPUs described as ``online capable`` but not ``enabled`` can be set to enabled
+by the DSDT's Processor object's _STA method. On virtual systems the _STA method
+must always report the CPU as ``present``. Changes to the firmware policy can
+be notified to the OS via device-check or eject-request.
+
+CPUs described as ``enabled`` in the static table, should not have their _STA
+modified dynamically by firmware. Soft-restart features such as kexec will
+re-read the static properties of the system from these static tables, and
+may malfunction if these no longer describe the running system. Linux will
+re-discover the dynamic properties of the system from the _STA method later
+during boot.
diff --git a/Documentation/arch/arm64/index.rst b/Documentation/arch/arm64/index.rst
index d08e924204bf..78544de0a8a9 100644
--- a/Documentation/arch/arm64/index.rst
+++ b/Documentation/arch/arm64/index.rst
@@ -13,6 +13,7 @@ ARM64 Architecture
     asymmetric-32bit
     booting
     cpu-feature-registers
+    cpu-hotplug
     elf_hwcaps
     hugetlbpage
     kdump
-- 
2.39.2


