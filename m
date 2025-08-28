Return-Path: <linux-arch+bounces-13300-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2044B39050
	for <lists+linux-arch@lfdr.de>; Thu, 28 Aug 2025 03:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E29D681259
	for <lists+linux-arch@lfdr.de>; Thu, 28 Aug 2025 01:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30651B0F1E;
	Thu, 28 Aug 2025 01:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EVUhRe0o"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388AE176ADB;
	Thu, 28 Aug 2025 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756342822; cv=none; b=DzkFeuHC4OnH9NC/OqDsXehHVX4Ry/tmkD6WWIzPvHDaHiurPXsd14PoWWCi9mtdLynRkqboAvtuCdLViKLpPwuCTNb80/9dSDHYarvAXUAVrYODy4wsCyaDKIFXSl8s1pM+cvmQArJ7wZDN/qpV6dSvunQYvvfVlcSD4Nh8ceA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756342822; c=relaxed/simple;
	bh=XQu1rdxxUinGT7Y9vLuOwBTb0UwZx4H12j6Ewo+CEhY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GiZ75Y/4D499LFrjHJl+NGq9SX6/rNpftm9QMN7Iaum5B2G3Nxqnjqg4i+IhMgzSXp4+69t+c96Jepsrdcp0jsGVfogCRB8LNyzymoAFLV6qZPVfcfWsJNWeTRyoximbMa0EKR5w9e0enJTiKTYwsp8zbTtuQ0lXeseupRPck+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EVUhRe0o; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 40DB3211082D;
	Wed, 27 Aug 2025 18:00:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 40DB3211082D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756342815;
	bh=ZR3q/sqU11jc+D0wNTmcaAct75MXJv7BhHNEAQ7boIU=;
	h=From:To:Cc:Subject:Date:From;
	b=EVUhRe0ohRSnQF/YYNdCLVZptm6BIAk+Hq6DVhul1oAbqMlFRe0KvhyhxKPoM7efX
	 rMQI8XEKVQhtmJoKGyGeHa0irYjiEI8GWCSnQeC796ekCftvH1sfujFiin5aYZn37O
	 3/MMjWjjAmmF9NONI30kvVGYQdEhMti1myllwkL0=
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
Subject: [PATCH V0 0/2] Fix CONFIG_HYPERV and vmbus related anamoly
Date: Wed, 27 Aug 2025 17:59:50 -0700
Message-Id: <20250828005952.884343-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At present, drivers/Makefile will subst =m to =y for CONFIG_HYPERV for hv
subdir. Also, drivers/hv/Makefile replaces =m to =y to build in
hv_common.c that is needed for the drivers. Moreover, vmbus driver is
built if CONFIG_HYPER is set, either loadable or builtin.

This is not a good approach. CONFIG_HYPERV is really an umbrella config that
encompasses builtin code and various other things and not a dedicated config
option for VMBUS. Vmbus should really have a config option just like
CONFIG_HYPERV_BALLOON etc. This small series introduces CONFIG_HYPERV_VMBUS
to build VMBUS driver and make that distinction explicit. With that
CONFIG_HYPERV could be changed to bool.

For now, hv_common.c is left as is to reduce conflicts for upcoming patches,
but once merges are mostly done, that and some others should be moved to
virt/hyperv directory.

Mukesh Rathor (2):
  hyper-v: Add CONFIG_HYPERV_VMBUS option
  hyper-v: Make CONFIG_HYPERV bool

 drivers/Makefile               |  2 +-
 drivers/gpu/drm/Kconfig        |  2 +-
 drivers/hid/Kconfig            |  2 +-
 drivers/hv/Kconfig             | 14 ++++++++++----
 drivers/hv/Makefile            |  4 ++--
 drivers/input/serio/Kconfig    |  4 ++--
 drivers/net/hyperv/Kconfig     |  2 +-
 drivers/pci/Kconfig            |  2 +-
 drivers/scsi/Kconfig           |  2 +-
 drivers/uio/Kconfig            |  2 +-
 drivers/video/fbdev/Kconfig    |  2 +-
 include/asm-generic/mshyperv.h |  8 +++++---
 net/vmw_vsock/Kconfig          |  2 +-
 13 files changed, 28 insertions(+), 20 deletions(-)

-- 
2.36.1.vfs.0.0


