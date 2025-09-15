Return-Path: <linux-arch+bounces-13642-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7756B58869
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 01:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F4B71AA6C17
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 23:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07C12D592B;
	Mon, 15 Sep 2025 23:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jtyIs3jT"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6417829617D;
	Mon, 15 Sep 2025 23:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757979981; cv=none; b=WVkQIUoGGyb5DvFQ/Q35ufqgKy62bZUxyNrU+AENH4Bf+9f8oPqGcLdiGrZxq/ZGqTr/wnbFRMjeaRNj4mlDl2e/RbEC6ZCrC1DB5HGn4zK2fRPrzuIyqJ1GIqhgO0g0S1PxtMHhnro7T1nmm/2Oei9nzGs+T2mDaQM2Titr9qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757979981; c=relaxed/simple;
	bh=lW3xNWJvBeUd78+N4Yyo06/B2znJyfp8Mxfc+3/obNA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ej/C3FtzONFg6Uy0Sk7eN1qqR9fPu8tGF1XNjF5F4qU4EDzqPa13nhsduFM9/Z4zGzI12vylxaSZm3wFLkTW6xB34bPw22OxmmOAanYfH/6jKE46ckq5Y2Dy42XqAlBGMl53PFkspv5RHEMfnnXNJc5AWT3qJmVuy3N+hzMsAN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jtyIs3jT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id A6840212329C;
	Mon, 15 Sep 2025 16:46:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A6840212329C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757979979;
	bh=7luzChTMUszkb9nUQYYy7F6No80YdK2nCBJEz1e/6Zs=;
	h=From:To:Cc:Subject:Date:From;
	b=jtyIs3jTrdwZXnDw9vxxokbXUXOLvwgRveEkFIwYiy+pMrWiva5ENlTdDcwoZTzmu
	 FBJ51hSc8k8vMU9Fiwr1q8p1aQUcRRLs2BkWEZHNAsahuKe/NddZwgTT7E21RFLNJR
	 5fJJ1WTPMe2vBTDNUjFz+vcGC294CxqRnKvMTVqE=
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
Subject: [PATCH v2 0/2] Fix CONFIG_HYPERV and vmbus related anamoly
Date: Mon, 15 Sep 2025 16:46:02 -0700
Message-Id: <20250915234604.3256611-1-mrathor@linux.microsoft.com>
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

V2:
 o rebased on hyper-next: commit 553d825fb2f0 
        ("x86/hyperv: Switch to msi_create_parent_irq_domain()")

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
 drivers/hv/Kconfig             | 13 ++++++++++---
 drivers/hv/Makefile            |  4 ++--
 drivers/input/serio/Kconfig    |  4 ++--
 drivers/net/hyperv/Kconfig     |  2 +-
 drivers/pci/Kconfig            |  2 +-
 drivers/scsi/Kconfig           |  2 +-
 drivers/uio/Kconfig            |  2 +-
 drivers/video/fbdev/Kconfig    |  2 +-
 include/asm-generic/mshyperv.h |  8 +++++---
 net/vmw_vsock/Kconfig          |  2 +-
 13 files changed, 28 insertions(+), 19 deletions(-)

-- 
2.36.1.vfs.0.0


