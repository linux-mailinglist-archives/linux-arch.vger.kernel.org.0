Return-Path: <linux-arch+bounces-11345-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66420A819B5
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 02:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03B314C7329
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 00:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56F741C64;
	Wed,  9 Apr 2025 00:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Of+UYZp2"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8ABCA930;
	Wed,  9 Apr 2025 00:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744157328; cv=none; b=aPvaSlFG9tW5uzV24nzj/53l/jkQdkFpTL7ehMPpoKc6T4tAn7uVL875cbvpL4rS86CcAL0tbomVuGAy7pCMo5tawFoii3hmymo8vAFWv4+/ce2TnA3BCnhZERRDQ9JBRqTMhR0fyvQ9NiNy8CZ1TWRXjlkPDDVIktzFCrh59fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744157328; c=relaxed/simple;
	bh=ET0ZoDUatD+fIJZqkawbH9nsPAnlPh6a5FaEfcrsqL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVZB9eEraRfVVnJbWM41FMXfTKR8vj/o2cV6QJaF7SGJap/1v1HFc+LcpNsih0TM1S53mOKbRwib7ccx7h3Go2pzjXkFOU0bMqaQ34PGojnpWRDhotDrkhqSpV/mHsmQnt32hBvr17uz+IHNAHVW9Kk24V1fZFBOJvCmDxCYiQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Of+UYZp2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 06D292113E9F;
	Tue,  8 Apr 2025 17:08:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 06D292113E9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744157320;
	bh=8ek7c/V4tEPRnWDg9ne0X3d57G2QR4Kt93BNCHQvtsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Of+UYZp2I4weN3I81NEdoIr6gHMQsX3CjbNKnmmILmhtmUf4OHR93sp3AhZBtJ2pd
	 p1p+jiVB2MOUPwfNzvia/zk8pDwYavj+M98l9VP+2iQjxvMKZGei/TzEdRpNb6jH7A
	 QZU2sGxZRVpouYt/yXPi/sDcuyn3Lg+7XMI11FP0=
From: Roman Kisel <romank@linux.microsoft.com>
To: aleksander.lobakin@intel.com,
	andriy.shevchenko@linux.intel.com,
	arnd@arndb.de,
	bp@alien8.de,
	catalin.marinas@arm.com,
	corbet@lwn.net,
	dakr@kernel.org,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	gregkh@linuxfoundation.org,
	haiyangz@microsoft.com,
	hch@lst.de,
	hpa@zytor.com,
	James.Bottomley@HansenPartnership.com,
	Jonathan.Cameron@huawei.com,
	kys@microsoft.com,
	leon@kernel.org,
	lukas@wunner.de,
	luto@kernel.org,
	m.szyprowski@samsung.com,
	martin.petersen@oracle.com,
	mingo@redhat.com,
	peterz@infradead.org,
	quic_zijuhu@quicinc.com,
	robin.murphy@arm.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	will@kernel.org,
	iommu@lists.linux.dev,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next 6/6] drivers: SCSI: Do not bounce-bufffer for the confidential VMBus
Date: Tue,  8 Apr 2025 17:08:35 -0700
Message-ID: <20250409000835.285105-7-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409000835.285105-1-romank@linux.microsoft.com>
References: <20250409000835.285105-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device bit that indicates that the device is capable of I/O
with private pages lets avoid excessive copying in the Hyper-V
SCSI driver.

Set that bit equal to the confidential external memory one to
not bounce buffer

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index a8614e54544e..f647f8fc2f8f 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -686,6 +686,8 @@ static void handle_sc_creation(struct vmbus_channel *new_sc)
 	struct vmstorage_channel_properties props;
 	int ret;
 
+	dev->use_priv_pages_for_io = new_sc->confidential_external_memory;
+
 	stor_device = get_out_stor_device(device);
 	if (!stor_device)
 		return;
-- 
2.43.0


