Return-Path: <linux-arch+bounces-8913-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7279C11C9
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 23:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6EE284001
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 22:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C81521A6F6;
	Thu,  7 Nov 2024 22:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JlK+Amog"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34ACE2194A1;
	Thu,  7 Nov 2024 22:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731018760; cv=none; b=kCISvYTnc0upc0u/OnYGg5ylt5M679AE/bCvm+vfs02z8rrc5GLbJvNEcJ6RZXVHNTT1hcp+Sd3Fd2lMWbpXb7hnkQPGBvb3XnfWHNR+mFB0/0SNEG6jgB0+bxSGB3gzOvAXgtEoHA6NGTSFb7ORn6fjooj6I5FN0kn9lyzZ0JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731018760; c=relaxed/simple;
	bh=LMDh14ZVuEDDj9KjM/woVD1TMEMiDTWNs9r6gQAkaTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=arG96DRaVNZy9TLih7wp6NFvzf1Jqr5L5GNTICka4+AUs8Y6Esl/TKk9mQu3wmwLFRPeAEdO17lfSZw0xmVZPS2Jqy6gbLDSu6CVIZfsNUg9m91fbm/5GpFeiI6Y3L+I0ZkW6e5sK+iqQo36wJZmdeBmKK64pwvg2HIp7vxCreo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JlK+Amog; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id C9160212D513;
	Thu,  7 Nov 2024 14:32:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C9160212D513
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731018750;
	bh=GO6EHAy3E9oBRQofog/8t22FjdLbKxZK6Scdg3HvYTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JlK+Amog/eo8deK1brnPwFK7BzPdCUlxv5PoSoR0bOlZ+eutGjTvuM7QKNc3/YMsb
	 JE2rGjnMrDYBhWluzoDDlibGNdpaBh93qQDgcogeVcxGCsebr76N6JTBiwMJcRCbp1
	 pdpwlPJxHlHYH7Rlgx3jRKPU3t/AUOL+6DtGYhDU=
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
	apais@linux.microsoft.com
Subject: [PATCH v2 1/4] hyperv: Move hv_connection_id to hyperv-tlfs.h
Date: Thu,  7 Nov 2024 14:32:23 -0800
Message-Id: <1731018746-25914-2-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1731018746-25914-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1731018746-25914-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

This definition is in the wrong file; it is part of the TLFS doc.

Acked-by: Wei Liu <wei.liu@kernel.org>
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


