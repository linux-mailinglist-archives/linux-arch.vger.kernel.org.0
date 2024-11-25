Return-Path: <linux-arch+bounces-9155-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4609D8EFA
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2024 00:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1B72872EB
	for <lists+linux-arch@lfdr.de>; Mon, 25 Nov 2024 23:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119D8195FE5;
	Mon, 25 Nov 2024 23:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mDXCE3/J"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD1A1925AD;
	Mon, 25 Nov 2024 23:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732577089; cv=none; b=uzkPlbkLlXzEMnmo2D2Q9S9ga8q5NE7tWoYT+y5bDQ/xiqobeueRk0B9jni/m2zGzHwtqmPcHqSWNa7ToUKhS/nkv7b2QuH/crkQkJUQUCpOJi052fCSl9bsIoAoA7sNdd6V/TcoNHu9rPSGpElX9L26gLhEB+WsuzK5tHkMmwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732577089; c=relaxed/simple;
	bh=VQbGCSrD1+D0kBH+DFrNkKRRwwFRhgZvj7nOZjGAAGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=me6sjiW38wyV3VSUgCsLOVGvwxdcqY+cYBy3LPoh+Th6s3UtqFbt7ixBeJGQBwqOyTF0I99jOwBKJOP6L4lSZMUqRFFMa49F1vuA3/bebJKWuRRnJhQIF56gwQFhvdpYdo/QUno1+piwGbiHBs2qr+m0hkfU6SDKx6BtddaDK0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mDXCE3/J; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id E0264205459C;
	Mon, 25 Nov 2024 15:24:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E0264205459C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1732577087;
	bh=rulixayfGXpdE3vTYhwVYuKpo+FI/Iah7yuHtBr+RhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mDXCE3/J9IwuINgRXsMIa3Jr6V29ZnKbRfSlthPZz5X14ST4BRkQrxgdWhTCTPH8F
	 k+IL7V14qIRQLr8AXGqKAN4ovl45UBBOxk7x80sd9XjpZF83Ha19p2HrOEtplSrSTf
	 o7u9GiXUtm0aUI7GrN24C7dzOwmbQeRpWISgMG/Q=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	iommu@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	mhklinux@outlook.com,
	decui@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	seanjc@google.com,
	pbonzini@redhat.com,
	peterz@infradead.org,
	daniel.lezcano@linaro.org,
	joro@8bytes.org,
	robin.murphy@arm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de,
	sgarzare@redhat.com,
	jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com,
	skinsburskii@linux.microsoft.com,
	mukeshrathor@microsoft.com,
	vkuznets@redhat.com,
	ssengar@linux.microsoft.com,
	apais@linux.microsoft.com,
	eahariha@linux.microsoft.com,
	horms@kernel.org
Subject: [PATCH v3 1/5] hyperv: Move hv_connection_id to hyperv-tlfs.h
Date: Mon, 25 Nov 2024 15:24:40 -0800
Message-Id: <1732577084-2122-2-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1732577084-2122-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1732577084-2122-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

This definition is in the wrong file; it is part of the TLFS doc.

Acked-by: Wei Liu <wei.liu@kernel.org>
Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 include/asm-generic/hyperv-tlfs.h | 9 +++++++++
 include/linux/hyperv.h            | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 814207e7c37f..52274c9aefef 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -871,4 +871,13 @@ struct hv_mmio_write_input {
 	u8 data[HV_HYPERCALL_MMIO_MAX_DATA_LENGTH];
 } __packed;
 
+/* Define connection identifier type. */
+union hv_connection_id {
+	u32 asu32;
+	struct {
+		u32 id:24;
+		u32 reserved:8;
+	} u;
+};
+
 #endif
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 22c22fb91042..d0893ec488ae 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -768,15 +768,6 @@ struct vmbus_close_msg {
 	struct vmbus_channel_close_channel msg;
 };
 
-/* Define connection identifier type. */
-union hv_connection_id {
-	u32 asu32;
-	struct {
-		u32 id:24;
-		u32 reserved:8;
-	} u;
-};
-
 enum vmbus_device_type {
 	HV_IDE = 0,
 	HV_SCSI,
-- 
2.34.1


