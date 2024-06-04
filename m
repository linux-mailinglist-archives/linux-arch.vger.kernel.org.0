Return-Path: <linux-arch+bounces-4663-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 870258FA99E
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 07:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8A481C23578
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 05:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B151411DB;
	Tue,  4 Jun 2024 05:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCadiSsd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F8B13FD9D;
	Tue,  4 Jun 2024 05:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717477844; cv=none; b=qigPTb1BXbFM4oz4WRQ29ddn5x3480uxvXjZgM8SeP+5RxLUKouRBE06XIqEuM7YzgzJtX3j0AuwT0Oe1IsmypxImsNXSEL1H0teNljGPWu8J6ATthDoQ8B6WmtZvnTYJl92+uPdDK6zrlB1/w9uLclTEqG+m4XMbbbZVvwMvaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717477844; c=relaxed/simple;
	bh=IqYFKETOx4ZEABhYk+CFGp7F4wFOKDydc/vQs12EN78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cnBQAuzecfmB9VvcgU8aw6p1Ghvcm+s0cersmwRlhCmuFU2cdGNJSosj3RFpROtpOK8Zem2QZ+/BIuIFRA0Pw/Q6Zy+rTr3JcHaiPFIYxh0vDY6ng87ugR9JNSZzdVHfr1dZiUWhlB4gZwz3U6UEQOqeyqHTGQlslVrN9GlerIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCadiSsd; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7025b84c0daso1946939b3a.2;
        Mon, 03 Jun 2024 22:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717477842; x=1718082642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EJqMDDGIN+lFQ1M8fhUyjmsJ5wMGfKMbSehKHoi0sAs=;
        b=TCadiSsdC2MLNKUp7ZPmtYmHtvvyJ8E2H4WwpErN5fiY6MW+2+TTpAWnl1jMNi5OqR
         r6qBJYgU+eYQf2Ieg3IklH92yfCxeL1QKwoQkipso6SElEtUjwgorcXf9xN1xnujArRR
         HrTPQD+vdcYbOrkZr/8Ar68hG7EhdrWe0kzREKXu/MXuWvc1g84oAWlmE/rvaA4wf/8O
         GN5cL38HY4Z7w0RCDmJ3KacqH4XFXb/kqSyiFF9XSbHn8QXE08+8t3EX0UTgQHb45EY/
         w8BJK3Rg75T0eyCUGXz5W1JX8rg0iu+JTJYEBx4OMRanr/nt267Mo33ZrzPLMULOUlRH
         HRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717477842; x=1718082642;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EJqMDDGIN+lFQ1M8fhUyjmsJ5wMGfKMbSehKHoi0sAs=;
        b=uN17L4saVxFptCgphL1jcyF5sdnR770kAMwLVcc/OlGNGBDmde+LeeQcHD0aIkZGJA
         Z1gnAJ2t7dkud6Knp5fK2gA9vMhPnxZ6aE8Ed3Azc9T1zalnQSqyHKLZ+edddYDMDXk2
         bOxl6nrdCn1/uyGHsfOCBAVMn3aMLOQj6zuyw3lCfd10L6dc4N9VrbowTXs/5qECDUgR
         TwRCrMXB8RM8Dw7JdQFKWiAHlcyOaLA6FF4z71dY9f2d7p8enWozNAAR1LwBK1mx5FlH
         OhAnKdVzJ9XZOUWjydHzyKxt2PskpvWRTbbpR3fUAN9hvvGf3WUb/a2nNCg7b6dLaNCL
         0BcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPrt8PfzC+3uKj8aCDZ9czcetS4tntlUrhk90GQjbH+hcFdphhGRPF5klvOXrk4QY9z+3R63mZoK/p8/V+oqmn4XnkI29BE3ojdcQVGkLjsa40ToX0+8FWofVsahO5Mv22C/z3dP/datF1jkIovecm3rafNZsAqbUa90cl0V0mxgyGh1ejpM1vymVPDk+B40HqkETvfUdF5fHXA67mxhkso64ZG9jtLgtwHuvYwEgxtRaO5B15uHzYl9ENicQ=
X-Gm-Message-State: AOJu0Yz43P0ID3eqIXaMORUadL0PVriTtEmPVPRQBPGJVtSRiNJMelge
	QphaxW1RahZPQh2UFtP14T86GUG+uifAyra/oL4br7L+0x5RWJgs
X-Google-Smtp-Source: AGHT+IHtRsaw2+6nASXeqSpTfk7BQZcffCsouxI2iBmgROU4XGXj+c/Mw8gWcFSMTNAGumyngsyiDA==
X-Received: by 2002:a05:6a00:2e90:b0:702:5950:178b with SMTP id d2e1a72fcca58-702595017e1mr8916905b3a.30.1717477842482;
        Mon, 03 Jun 2024 22:10:42 -0700 (PDT)
Received: from localhost.localdomain (c-67-161-114-176.hsd1.wa.comcast.net. [67.161.114.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242c270c7sm6298153b3a.220.2024.06.03.22.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 22:10:42 -0700 (PDT)
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
Subject: [RFC 05/12] scsi: storvsc: Annotate the VMBus channel IRQ name
Date: Mon,  3 Jun 2024 22:09:33 -0700
Message-Id: <20240604050940.859909-6-mhklinux@outlook.com>
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

In preparation for assigning Linux IRQs to VMBus channels, annotate the
IRQ name in the VMBus channels used by the virtual IDE, SCSI, and Fibre
Channel controllers in a Hyper-V guest. Distinguish the primary channel
and sub-channels with "pri" and "sub" prefixes. Identify controllers
with a numeric suffix that matches the numeric part of the "host<n>"
name displayed by "lsscsi" and SCSI-related entries in sysfs.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/scsi/storvsc_drv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 7ceb982040a5..11b3fc3b24c9 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -686,6 +686,8 @@ static void handle_sc_creation(struct vmbus_channel *new_sc)
 	new_sc->max_pkt_size = STORVSC_MAX_PKT_SIZE;
 
 	new_sc->next_request_id_callback = storvsc_next_request_id;
+	snprintf(new_sc->irq_name, VMBUS_CHAN_IRQ_NAME_MAX, "sub@storvsc%d",
+			stor_device->host->host_no);
 
 	ret = vmbus_open(new_sc,
 			 aligned_ringbuffer_size,
@@ -1322,6 +1324,7 @@ static int storvsc_connect_to_vsp(struct hv_device *device, u32 ring_size,
 				  bool is_fc)
 {
 	struct vmstorage_channel_properties props;
+	struct storvsc_device *stor_device;
 	int ret;
 
 	memset(&props, 0, sizeof(struct vmstorage_channel_properties));
@@ -1329,6 +1332,12 @@ static int storvsc_connect_to_vsp(struct hv_device *device, u32 ring_size,
 	device->channel->max_pkt_size = STORVSC_MAX_PKT_SIZE;
 	device->channel->next_request_id_callback = storvsc_next_request_id;
 
+	stor_device = get_out_stor_device(device);
+	if (!stor_device)
+		return -EINVAL;
+	snprintf(device->channel->irq_name, VMBUS_CHAN_IRQ_NAME_MAX, "pri@storvsc%d",
+			stor_device->host->host_no);
+
 	ret = vmbus_open(device->channel,
 			 ring_size,
 			 ring_size,
-- 
2.25.1


