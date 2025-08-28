Return-Path: <linux-arch+bounces-13302-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B11FB39065
	for <lists+linux-arch@lfdr.de>; Thu, 28 Aug 2025 03:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4C47C3338
	for <lists+linux-arch@lfdr.de>; Thu, 28 Aug 2025 01:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD051FF603;
	Thu, 28 Aug 2025 01:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iB1bgR9k"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3499C1E32D6;
	Thu, 28 Aug 2025 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756342825; cv=none; b=AnBTM7VJk1kAkbuHIZ8OKZZSOB7FG9ApoyXbm7ruzyfNLAq5+VeNYLmhNeWClbuY0vmWEKCIHVXIWyKVaxdp9Q6DXx3TEN9MURaI3wuxo7H+11MdGpq4ykSiAhuX/UXXNGf6ZY6pax4eUJKEVo1vHTMwkklLh6nWI/S3EFSVsU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756342825; c=relaxed/simple;
	bh=j8i3Wmz1xQfrYxcckmdc5MhfwAy/EHQOdVkYHoSMvCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UaLtIe42aVW0wLY2Md2MS1TEjlSfLMMg6vUQ5w/+g7mNVpif8D2WoXs4MkPEl5HFcKhJkgStEdGF+1UvF/P0xEHKzSAPHGtEinV2LTeY/7ff8W/VoJaPcqp6fV5fWW58mJC5QEct0DX+Lak9pZDyLbfcQjcrW08p9Ygd3q0I+VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iB1bgR9k; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 745CD2110830;
	Wed, 27 Aug 2025 18:00:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 745CD2110830
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756342818;
	bh=Ss7JjVNarChnOl65zBgAvUfYxLdS3O+Tfo7rHSNxB9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iB1bgR9k38TWMcBaNOrofX9U3QhRranEqmjY4QBRQWN9iqDfCo+sFbyb+ac0gAYI+
	 UWCZEAmd8YAQt6iI52v4RuD2hczI/STVoaIWYwQONfpLAwwR0reXjYQj0+TYv1eU+h
	 ALWR/RBRW/aykzecJYV3AndpIsKXmPC2xN9RSkyE=
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
Subject: [PATCH V0 2/2] hyper-v: Make CONFIG_HYPERV bool
Date: Wed, 27 Aug 2025 17:59:52 -0700
Message-Id: <20250828005952.884343-3-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
In-Reply-To: <20250828005952.884343-1-mrathor@linux.microsoft.com>
References: <20250828005952.884343-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_HYPERV is an umbrella config option involved in enabling hyperv
support and build of modules like hyperv-balloon, hyperv-vmbus, etc.. As
such it should be bool and the hack in Makefile be removed.

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
index 08c4ed005137..b860bc1026b7 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -3,7 +3,7 @@
 menu "Microsoft Hyper-V guest support"
 
 config HYPERV
-	tristate "Microsoft Hyper-V client drivers"
+	bool "Microsoft Hyper-V client drivers"
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


