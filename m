Return-Path: <linux-arch+bounces-4662-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 132F78FA998
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 07:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A45BEB219B7
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 05:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0DF140370;
	Tue,  4 Jun 2024 05:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMaep3ek"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40FF13EFE5;
	Tue,  4 Jun 2024 05:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717477843; cv=none; b=S/ouQervdfAEVovCTjOKiPJDUpHq7kqtnDxWF3JnNGvllS8valdiFaH/0TQkzuFHGnZYXSC+LevJEts6xecPFc53pQm6racSKfQG4O6ICynUyFs9T0lmZqsXCr3OK+9r7BX0opVZJc2279d0Bbm9JBGWm5ysSxSCKRyuIJnmgm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717477843; c=relaxed/simple;
	bh=NDQ/4bdVCsdeoYBuw6VFx+6yBgoNk62i9zXSX9enGps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rpzfPwslRIklIZsXaoHXR7Ii3Zndtm6w42QSH8PzgFd3cXZwVqL+2dHhFwsjFU8noy919H2THwg4DAzm2WYs0TrjUGXWil6eT7r2vAK8UwufIK2ZmMvtaIR2OWTobbWS/52Bhk5q0JN9lJtIEgQn82OvrCxNqGylHj/qJIBx/KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMaep3ek; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7025e7a42dcso667422b3a.1;
        Mon, 03 Jun 2024 22:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717477841; x=1718082641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BAofxEUtzPzqe88fnpeV5QdjFS9qkBRDgafLpMrolX4=;
        b=SMaep3ekQV5KBQ+VYoqJRXj5dgVtAoXpABTo4SV0ERCy3XSOFXPfJ56luqOtj5c61d
         OP35ZnjoywgYSlc68n9VMTnhhm2+t/DjnHHdBTX3oAvGb8bSGWHUabTqOmvUdUqokm/o
         dfKfw8k5KDdT4LoBfG98aJS+YtB5Y+9IvynNPHeDT5KOSE+LL/I+1S3kSjgwYnpwk6Mh
         epDAcn8uSTEkqxUcmcUt2ZQINp4C+j2oAmYdFFPtJwLEYhkFE61buNJiX7RA8Ah5hBZL
         aw9rpOpAfSOSbt+F2T2MnWwEsE+HfC9cxtyVolJLYcx4lmiFNKN8rl+TKHgU1Y0Y6yvd
         slcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717477841; x=1718082641;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BAofxEUtzPzqe88fnpeV5QdjFS9qkBRDgafLpMrolX4=;
        b=Qn/M6xNdmeU0OycO9o4Px+gFsujtYYA4PSxp7kb5641yZ3wIRutLGhUFSzgiuelhFl
         PAkY6svQ8rAtdbDYxTRagurPiOMtxWHH1pJwn2atCvJTrjn+DlOvxqRtTvlmPPls1IbQ
         ZhzwMoEIChxIklqNG3PhhS7UEsH6OVxKtNz/f1cSo1U4Hpp+apmUhPnwGTYzImXXLLPq
         5f8FtLqvDGrOcOW2/TbwLgUqnHsCGN4OKxvhDiSGo4YNsgUCNbfjBT7WtMpF3cdbVNuS
         qaWFe8bcL9KgAuouiJRSH9e1AKgWHKGPeB+jPORH4bgwmcssTdsQ9NGxSRzyEnUCZ4ik
         5Jcw==
X-Forwarded-Encrypted: i=1; AJvYcCV3Cp5BjfAJf+/eYeAb8MfEyQcYVuWuEYpd+Jli6KKnlEBdi/RSoG65k72I/P8eTgtqRmIYcOMEmp6tdkiJ4GDWMN7imlQUlBLUH86oYfx4d9eBzUafnCw3nlwBY28LYHbZmz0darye5NCLGDJqMzmCAhM7D/2TvHrZ+CumOU6oXnp+eR4aP7kqXs8vlnKdeXmYtdvmWe5ZM3ODGc9JbsH87ttL97dtawvZEtaRldWE25ZRjWzGzIdCqqEJDRo=
X-Gm-Message-State: AOJu0YwihcUTZvovuBLkVx04v/xUQXhuS5lJLFLXcGTVMWKtmw15l3rR
	EvmjTcYM7LhAH9AzMMB6i3HEqMRm1lMyccjyv5fIy1RQR6ypENv5
X-Google-Smtp-Source: AGHT+IHYq1EjkLSNHV65k7JemFghR4rO9Oxzcpw2btvtEflNJd9CODY0LBqkqVQGqpF9hi37VEPnCg==
X-Received: by 2002:aa7:8893:0:b0:6ed:cd4c:cc11 with SMTP id d2e1a72fcca58-7024789b0abmr12433927b3a.25.1717477841230;
        Mon, 03 Jun 2024 22:10:41 -0700 (PDT)
Received: from localhost.localdomain (c-67-161-114-176.hsd1.wa.comcast.net. [67.161.114.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242c270c7sm6298153b3a.220.2024.06.03.22.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 22:10:40 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	arnd@arndb.de,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: maz@kernel.org,
	den@valinux.co.jp,
	jgowans@amazon.com,
	dawei.li@shingroup.cn
Subject: [RFC 04/12] PCI: hv: Annotate the VMBus channel IRQ name
Date: Mon,  3 Jun 2024 22:09:32 -0700
Message-Id: <20240604050940.859909-5-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240604050940.859909-1-mhklinux@outlook.com>
References: <20240604050940.859909-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

In preparation for assigning Linux IRQs to VMBus channels, annotate
the IRQ name in the single VMBus channel used for setup and teardown
of a virtual PCI device in a Hyper-V guest. The annotation adds the
16-bit PCI domain ID that the Hyper-V vPCI driver assigns to the
virtual PCI bus for the device.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/pci/controller/pci-hyperv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 5992280e8110..4f70cddb61dc 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3705,6 +3705,9 @@ static int hv_pci_probe(struct hv_device *hdev,
 	hdev->channel->request_addr_callback = vmbus_request_addr;
 	hdev->channel->rqstor_size = HV_PCI_RQSTOR_SIZE;
 
+	snprintf(hdev->channel->irq_name, VMBUS_CHAN_IRQ_NAME_MAX,
+				"vpci:%04x", dom);
+
 	ret = vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL, 0,
 			 hv_pci_onchannelcallback, hbus);
 	if (ret)
@@ -4018,6 +4021,8 @@ static int hv_pci_resume(struct hv_device *hdev)
 	hdev->channel->next_request_id_callback = vmbus_next_request_id;
 	hdev->channel->request_addr_callback = vmbus_request_addr;
 	hdev->channel->rqstor_size = HV_PCI_RQSTOR_SIZE;
+	snprintf(hdev->channel->irq_name, VMBUS_CHAN_IRQ_NAME_MAX,
+				"vpci:%04x", hbus->bridge->domain_nr);
 
 	ret = vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL, 0,
 			 hv_pci_onchannelcallback, hbus);
-- 
2.25.1


