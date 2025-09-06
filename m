Return-Path: <linux-arch+bounces-13395-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CABD4B467D2
	for <lists+linux-arch@lfdr.de>; Sat,  6 Sep 2025 03:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9E71CC214B
	for <lists+linux-arch@lfdr.de>; Sat,  6 Sep 2025 01:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4278F1DDA15;
	Sat,  6 Sep 2025 01:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BX9NEf/X"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9286B145B16;
	Sat,  6 Sep 2025 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757121008; cv=none; b=es+VMxo9rCetYxd+Pc2rs7SKCS2p0zwvjPG+KmOf9lT+A3vOmdoJ/u82U8vztLC/+gckNTP2Y35cC7Sedkyu/wIqesAcY9ko/aczLfceQdXSi1ug8aFojWb8twg8z6Sd3/rRTxRKzIZ/jFyKg2S/myoZqZQ/97Fl6V1xkHkBW+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757121008; c=relaxed/simple;
	bh=D3d4EEm9KfZVZrOZRrxKFOPjUiMwSN5Ik0Y3pM8gFgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hTu2qd7RthnHw2dMcQaTHwGa9iEbxCp2wtHY1mFbiOCYocZmqJB/X8lzAfIjCFQXILdBkvw2bs9ivj8WyHVj+14Krff5yyZOe4q8b18E2iOu+hyUfRDf4e0uA+EQgG3ncE2IPE4OtUitG4cOgYeFptZ+umL2Wr1PVMxCgTD4otw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BX9NEf/X; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id CA22720171A1;
	Fri,  5 Sep 2025 18:10:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CA22720171A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757121005;
	bh=+CCS9We1Ij6uOlVmGq9+uq+1zOrHP0OdRaRPzrFp1GA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BX9NEf/X1VneNtjEYWoIbC4svFLWsPr6TE+eGFC7ATnibEAF5CZhHO4BkQA3huB1H
	 G+vqfIWfbg5hEOs2bwIui5RjjStP2xdsiq/mMkkajOrdNM34AIT7Bqid50NJZSBjcZ
	 DoYg+VV6O+/ka1HcE7xVbEhJmP4lFjkaKOTv7a2k=
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
Subject: [PATCH v1 2/2] Drivers: hv: Make CONFIG_HYPERV bool
Date: Fri,  5 Sep 2025 18:09:52 -0700
Message-Id: <20250906010952.2145389-3-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
In-Reply-To: <20250906010952.2145389-1-mrathor@linux.microsoft.com>
References: <20250906010952.2145389-1-mrathor@linux.microsoft.com>
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
index fe29f8dca2b5..7e56c51c5080 100644
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
index 050517756a82..8b04a33e4dd8 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -18,7 +18,7 @@ mshv_root-y := mshv_root_main.o mshv_synic.o mshv_eventfd.o mshv_irq.o \
 mshv_vtl-y := mshv_vtl_main.o
 
 # Code that must be built-in
-obj-$(subst m,y,$(CONFIG_HYPERV)) += hv_common.o
+obj-$(CONFIG_HYPERV) += hv_common.o
 obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) += hv_proc.o
 ifneq ($(CONFIG_MSHV_ROOT) $(CONFIG_MSHV_VTL),)
     obj-y += mshv_common.o
-- 
2.36.1.vfs.0.0


