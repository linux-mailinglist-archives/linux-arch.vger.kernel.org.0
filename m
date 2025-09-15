Return-Path: <linux-arch+bounces-13644-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B1EB58877
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 01:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB55E1AA67C2
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 23:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CFE2E0405;
	Mon, 15 Sep 2025 23:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LRgTB/yg"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791732DECB9;
	Mon, 15 Sep 2025 23:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757979984; cv=none; b=HsRHNx61YRRinteJ66+B/4S8NZkQhe3CIcBidiGtev8wR0QhEh5yDKbRfX6L9W/3KwPPmXPGOI1TjG85CjY3+bN6aMQNydH+ANyxlSXvbZm6DXZYKWusGfJ/saiXds1QMGgzOwKzS/FnoINXbatqC0tShC4Kol4e2QTVRoaQ8Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757979984; c=relaxed/simple;
	bh=G6ThnZ+1aDmmFO6ry/Hei0sezizSoDrzer+Eg7bVH9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rcz4P4mGu0TrOSa5caA3Q4hw6rl8R+vqVW/GjmxcySEJaofbVoiV07pUwYTaFo5UZT/fNgvuVr8eFwxA1exM2kZZa3+GMR8iaJmwP0vdmR+5gkaptGET+QZFaSz5GOrHI5+RSwmtC2x4UdpzIWAbFyuavNZh4W/bXs95CQ1c3kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LRgTB/yg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id CE92E212329F;
	Mon, 15 Sep 2025 16:46:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CE92E212329F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757979982;
	bh=gs16ls5Och2HyyMzPWy5wjtp6Giar6v2cihGMYFiDfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LRgTB/yg0F3upRJmZZ2276i8xhsWZd64Q4YUv9nQmQzBtN3VlzJQ81lurrbYaCfhn
	 0UaiirGPm6vk6DhOPYu0tUFKZi8HIKcDSJwK/PHYzrTJ0ZsDUTAtPUbY8CKlMgnjvS
	 cKizZeKdQnGdwSlzTXU42nEF8VO/b9lLeIITG7HE=
From: Mukesh Rathor <mrathor@linux.microsoft.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-arch@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	jikos@kernel.org,
	bentiss@kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	dmitry.torokhov@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bhelgaas@google.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	gregkh@linuxfoundation.org,
	deller@gmx.de,
	arnd@arndb.de,
	sgarzare@redhat.com,
	horms@kernel.org
Subject: [PATCH v2 2/2] Drivers: hv: Make CONFIG_HYPERV bool
Date: Mon, 15 Sep 2025 16:46:04 -0700
Message-Id: <20250915234604.3256611-3-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
In-Reply-To: <20250915234604.3256611-1-mrathor@linux.microsoft.com>
References: <20250915234604.3256611-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With CONFIG_HYPERV and CONFIG_HYPERV_VMBUS separated, change CONFIG_HYPERV
to bool from tristate. CONFIG_HYPERV now becomes the core Hyper-V
hypervisor support, such as hypercalls, clocks/timers, Confidential
Computing setup, PCI passthru, etc. that doesn't involve VMBus or VMBus
devices.

Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
---
 drivers/Makefile    | 2 +-
 drivers/hv/Kconfig  | 2 +-
 drivers/hv/Makefile | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index b5749cf67044..7ad5744db0b6 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -161,7 +161,7 @@ obj-$(CONFIG_SOUNDWIRE)		+= soundwire/
 
 # Virtualization drivers
 obj-$(CONFIG_VIRT_DRIVERS)	+= virt/
-obj-$(subst m,y,$(CONFIG_HYPERV))	+= hv/
+obj-$(CONFIG_HYPERV)		+= hv/
 
 obj-$(CONFIG_PM_DEVFREQ)	+= devfreq/
 obj-$(CONFIG_EXTCON)		+= extcon/
diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 29f8637f441a..0b8c391a0342 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -3,7 +3,7 @@
 menu "Microsoft Hyper-V guest support"
 
 config HYPERV
-	tristate "Microsoft Hyper-V client drivers"
+	bool "Microsoft Hyper-V core hypervisor support"
 	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
 		|| (ARM64 && !CPU_BIG_ENDIAN)
 	select PARAVIRT
diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index 4bb41663767d..1a1677bf4dac 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -16,5 +16,5 @@ mshv_root-y := mshv_root_main.o mshv_synic.o mshv_eventfd.o mshv_irq.o \
 	       mshv_root_hv_call.o mshv_portid_table.o
 
 # Code that must be built-in
-obj-$(subst m,y,$(CONFIG_HYPERV)) += hv_common.o
+obj-$(CONFIG_HYPERV) += hv_common.o
 obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) += hv_proc.o mshv_common.o
-- 
2.36.1.vfs.0.0


