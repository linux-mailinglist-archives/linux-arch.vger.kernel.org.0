Return-Path: <linux-arch+bounces-13393-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7E0B467C0
	for <lists+linux-arch@lfdr.de>; Sat,  6 Sep 2025 03:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB9E1BC5C24
	for <lists+linux-arch@lfdr.de>; Sat,  6 Sep 2025 01:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC2816A956;
	Sat,  6 Sep 2025 01:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TKfcPcw2"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FEA487BE;
	Sat,  6 Sep 2025 01:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757121000; cv=none; b=oYJGjK/R+AUZxGLlnDr3ZwzeMfXIn6qEojH4BvYDxHHqp7V7tquJV6NgXIr3Cs+FcBGKU+0eX/WtoUA7/CbzZ2LIRrT1tPjfwlvOlwlBPjDNIL17awl4fjaVEfCT+YX0PKgJz9RxrjazHWYw1omd9VeDb9qoIrt9qkgxYDZcjfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757121000; c=relaxed/simple;
	bh=ssSMPbMNqm6vATTkHkNx+dsREmUcGBvV4+XO9+ZGKCI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rVVtgmlHQOAX41nuenybeB8UsUpHtGi/TncKacV8ru43jgpdOFwnm4setBt/Bf2ZsHlqHkOnKeMusTunCKalNzo38s3fkvTE2dfzgJ2WRNGU+U7nEYaLt/D4tEva3Fr7AeQVMz0ZTX6m1GMFCEijtneC2koo2pdZ2Y949npG5nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TKfcPcw2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 910D720171A1;
	Fri,  5 Sep 2025 18:09:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 910D720171A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757120998;
	bh=L2LrN/02c+CCHSzoFDSRbLxalinHUHHHAu03h9ivscY=;
	h=From:To:Cc:Subject:Date:From;
	b=TKfcPcw2u7lleLXeX742d4QKN1Na6agETBG4QonJoT/6MSI0SOIIVGkn+XN2E6Pf/
	 lAw45bf0QqvUBBg95HdVEcqqPhx2nZVd9PVSi+bTi/sNNBSZbRTSbE/yHnl0RkESIF
	 sjJpFmiFyVv/+yfkRazcm5WVZCH3aFBF1jNn9cnw=
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
Subject: [PATCH v1 0/2] Fix CONFIG_HYPERV and vmbus related anamoly
Date: Fri,  5 Sep 2025 18:09:50 -0700
Message-Id: <20250906010952.2145389-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At present, drivers/Makefile will subst =m to =y for CONFIG_HYPERV
for hv subdir. Also, drivers/hv/Makefile replaces =m to =y to build in
hv_common.c that is needed for the drivers. Moreover, vmbus driver is
built if CONFIG_HYPER is set, either loadable or builtin.

This is not a good approach. CONFIG_HYPERV is really an umbrella
config that encompasses builtin code and various other things and not
a dedicated config option for VMBus. VMBus should really have a config
option just like CONFIG_HYPERV_BALLOON etc. This small series introduces
CONFIG_HYPERV_VMBUS to build VMBus driver and make that distinction
explicit. With that CONFIG_HYPERV could be changed to bool.

For now, hv_common.c is left as is to reduce conflicts for upcoming
patches, but once merges are mostly done, that and some others should
be moved to virt/hyperv directory.

V1:
 o Change subject from hyper-v to "Drivers: hv:"
 o Rewrite commit messages paying attention to VMBus and not vmbus
 o Change some wordings in Kconfig
 o Make new VMBUS config option default to HYPERV option for a smoother
   transition

Mukesh Rathor (2):
  Driver: hv: Add CONFIG_HYPERV_VMBUS option
  Drivers: hv: Make CONFIG_HYPERV bool

 drivers/Makefile               |  2 +-
 drivers/gpu/drm/Kconfig        |  2 +-
 drivers/hid/Kconfig            |  2 +-
 drivers/hv/Kconfig             | 15 +++++++++++----
 drivers/hv/Makefile            |  4 ++--
 drivers/input/serio/Kconfig    |  4 ++--
 drivers/net/hyperv/Kconfig     |  2 +-
 drivers/pci/Kconfig            |  2 +-
 drivers/scsi/Kconfig           |  2 +-
 drivers/uio/Kconfig            |  2 +-
 drivers/video/fbdev/Kconfig    |  2 +-
 include/asm-generic/mshyperv.h |  8 +++++---
 net/vmw_vsock/Kconfig          |  2 +-
 13 files changed, 29 insertions(+), 20 deletions(-)

-- 
2.36.1.vfs.0.0


