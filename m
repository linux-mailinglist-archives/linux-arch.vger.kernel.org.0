Return-Path: <linux-arch+bounces-1943-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B879C844553
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 17:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F06E294B9B
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 16:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6409912CDAA;
	Wed, 31 Jan 2024 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WST9ZT4I"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2678712C529;
	Wed, 31 Jan 2024 16:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720178; cv=none; b=pNA7GLHWck0gH+vsOFQpalPEckXN7IFdrLtLMz+5bb3r0F9IKBAFMNKVPvfBCgz9ZvdemJTWLZw4+NxZh6SHMzDVUEHQVrc+b7qTRFDSekK8MMYT4ty8DUmlt3BlCyuZ5toTag4PL9VIW2XwSCit6/I/XCmCd1kL36WfrALTavk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720178; c=relaxed/simple;
	bh=N3yfAwrXdbWnKEC7JEi6UMvlnhfTRzUgbGyHCjTjkv4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=G6Mv0juAnSapD0eBms4W9aGVrWJv7f4ybx9kKeJLcYY/8K+ldAe2ljh0tgrZlNnabzA/GSfQMAKsdQqpb17xAhriS/0+Eq91ncU1fXspZIj6mcWmPx4iUkh5YW2r04iDceFdymaoVgVl45y75kxkMPaXMavVmUaL7WkboE6GFRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WST9ZT4I; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HIKiEqJHlqAoHSTcyc1lunHTLLDGXtjVEHntkNIvOuo=; b=WST9ZT4I7jP51/eX2oNrvtrRHV
	wU6QZFWeTQWW8sPeBCnuCuNC1AnDk7b9q70y/GrgnFJos9VC9y6U1i7FtUW43bUhkdevBQD3B4Oie
	7+6onvsDFYPKmy3QA5Uxe6yNaNImJZhWZ74ovvo66fwxQGkwI7CUIa3DkIZZTR2B/lXKDC4MXuoAR
	5XX9H7a4N8e5EFal5Z6bSGeGTU4LuoT+3WKxZkFeaWDgHuevPlNkEu2OcfBLzMTn2NoDZnOwEi3Z0
	T9LEIjgG6QCSpsXhBR50vItfTtkNirOlL3gP99WuwKkfDU5fYW9lUsm4O+ZrTPKr5OMl5pdu+bEaC
	XdNmy2SA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33600 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rVDnW-0003Wh-1L;
	Wed, 31 Jan 2024 16:50:50 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rVDnU-0027Zf-GF; Wed, 31 Jan 2024 16:50:48 +0000
In-Reply-To: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk>
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk>
From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
To: linux-pm@vger.kernel.org,
	 loongarch@lists.linux.dev,
	 linux-acpi@vger.kernel.org,
	 linux-arch@vger.kernel.org,
	 linux-kernel@vger.kernel.org,
	 linux-arm-kernel@lists.infradead.org,
	 linux-riscv@lists.infradead.org,
	 kvmarm@lists.linux.dev,
	 x86@kernel.org,
	 acpica-devel@lists.linuxfoundation.org,
	 linux-csky@vger.kernel.org,
	 linux-doc@vger.kernel.org,
	 linux-ia64@vger.kernel.org,
	 linux-parisc@vger.kernel.org
Cc: Salil Mehta <salil.mehta@huawei.com>,
	 Jean-Philippe Brucker <jean-philippe@linaro.org>,
	 jianyong.wu@arm.com,
	 justin.he@arm.com,
	 James Morse <james.morse@arm.com>,
	 Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	 "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH RFC v4 14/15] arm64: document virtual CPU hotplug's
 expectations
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rVDnU-0027Zf-GF@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 31 Jan 2024 16:50:48 +0000

From: James Morse <james.morse@arm.com>

Add a description of physical and virtual CPU hotplug, explain the
differences and elaborate on what is required in ACPI for a working
virtual hotplug system.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Outstanding comment:
 https://lore.kernel.org/r/20230914174137.00000a62@Huawei.com
 https://lore.kernel.org/r/20231215170428.00000d81@Huawei.com
---
 Documentation/arch/arm64/cpu-hotplug.rst | 79 ++++++++++++++++++++++++
 Documentation/arch/arm64/index.rst       |  1 +
 2 files changed, 80 insertions(+)
 create mode 100644 Documentation/arch/arm64/cpu-hotplug.rst

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
2.30.2


