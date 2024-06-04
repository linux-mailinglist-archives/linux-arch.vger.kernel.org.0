Return-Path: <linux-arch+bounces-4659-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF7A8FA989
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 07:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5941B2376B
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 05:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A22513DBBD;
	Tue,  4 Jun 2024 05:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1EaCc/x"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0D977A1E;
	Tue,  4 Jun 2024 05:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717477840; cv=none; b=VyvdtlMHdYbmbKG49SicS5Uh9BLTF/B6AoUMDQnwAGNW6UukQQli+AXvEqW+fwCm7klTd5YXTsX7q1qsIuSLymWU6a7GyqP41pxitDxV+7phiO66kYTVEljykmZRzMXb+LbgQnHmyYH6kVaqGVNeg7+O3UKCXSlpzV7gvAmKWII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717477840; c=relaxed/simple;
	bh=VBR98JGVknh0QIXU1LbDkiwLPZeprLJur5lg0RvecfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dXzi8chAOHKg5RPzMD14fmsjxbYOtYi3aYp9aWvZdC1I6IQ+fUWbfb0utLbYR0NcTZaWgq0JCk/59qXI77860zOSs/s0f6R8LT1Cqo4jIEgGfgFTL6wgYHN54pefALlLCp9QY7DDkkvplgxIwYbBxd4AGbEqxA1mqjb7jef6da0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1EaCc/x; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d1facdf12bso224547b6e.0;
        Mon, 03 Jun 2024 22:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717477837; x=1718082637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gOw8AgrUJDkpfPA0Lzrm6o/e4yMy7flaTek+BD0V1x4=;
        b=d1EaCc/xzVsuRc/jIMk93NC6Rd6JYq4x6wAQ/2xKJGnTESMLLInq/rxVQauFaUmav/
         3xZdm+/uIBg8su5/+0O8Z62p8N4MlMnzB/e8SA5xo/kffL0WHwKSt7WWjA/2bftmECUg
         yb880VnAD4J8fVqa6qK+RmHbtrRBJC/kdtyCP8WO8VdsOXlsIdB+5K/q4WxxbDX/lJY/
         9DkFqjY8NOQ2vMOZZ07DgJCdBdUrLxj2rbU1TdDNWIyG/zRDAwUFk7p2Zq7EO+wUXoLn
         mgZn7rBGJhm31ouvZWoGXFFJk4uES6TR8/ObRocQVcZ72W8ol+T3GLgDWUqv1OwgaeAS
         VuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717477837; x=1718082637;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gOw8AgrUJDkpfPA0Lzrm6o/e4yMy7flaTek+BD0V1x4=;
        b=SqeXS0MK57/bEj9MsENLYM7Ju+k+/LfEtWSFQqjBziSw376gktb7jPT/PF3y9MuHUr
         x+jyM5DrkG3A1RaHrCW2Xz+BJSxFKd6la3PSbTFnK10uo0VC3mYFP1ZEDWHg/3fecJ1Q
         6kayjbY3CvbipB1xGkDPZXnTL0gK8eRI4r7Xd+dyX9rV/eLPSggVtb5jZ615JIpUywki
         dZI1HzVbvZs8E8cQ6oXxwcR5dYow1AdEcVCWH4rU7lphUON3ZxOJCudLPm7nh5zqgI3a
         kezgyrLrSGusOqUTn3ZmAS4eYt2sb2wOtpPt89HwQ5RvB26OzJySY6hTpzbj67IIO1dN
         H6HA==
X-Forwarded-Encrypted: i=1; AJvYcCVcQo7+yDJzz5X0FPrSDUUUSnsP3KB/cN/MCebfzUJysqCYcYKsYEL37EEpB3guQb+xK2UMhGjEoz+Iur7/QshjE4n23ltDbP3R+hxwo7WBIhjbW/jcroqQ9c+4w7opxDaQ+naGKT4p2ClPY2Z1MhdtLF2kQKilugW637nUupQtoo8q81KDG/80we+rt3cenSKtaC+HMmAqIVhaCYuwnKOuTApxF+Z1jkKXVLJYyFKRMUA7PcJWHRFiE7CSYBM=
X-Gm-Message-State: AOJu0Yyw4csjZmAHEZvO/SxyOgLbWF38UGqIbPp0WDvkl3SD3z+s9UaC
	1THVUQqjIHAfJ/LyhHPij2QjyWlVah1+ljJHukeE5EkqEnod9Evv
X-Google-Smtp-Source: AGHT+IEyA+H/NUVYyadV6QS+sJdPE+MGaP8srmU6cCY3RydFGapT11Ew5xGOL60RZNIYPFbiiOl3Sw==
X-Received: by 2002:a05:6808:602:b0:3d2:5b:df2d with SMTP id 5614622812f47-3d2005be0acmr41704b6e.35.1717477837405;
        Mon, 03 Jun 2024 22:10:37 -0700 (PDT)
Received: from localhost.localdomain (c-67-161-114-176.hsd1.wa.comcast.net. [67.161.114.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242c270c7sm6298153b3a.220.2024.06.03.22.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 22:10:37 -0700 (PDT)
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
Subject: [RFC 01/12] Drivers: hv: vmbus: Drop unsupported VMBus devices earlier
Date: Mon,  3 Jun 2024 22:09:29 -0700
Message-Id: <20240604050940.859909-2-mhklinux@outlook.com>
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

Because Hyper-V doesn't know ahead-of-time what operating system will be
running in a guest VM, it may offer to Linux guests VMBus devices that are
intended for use only in Windows guests. Currently in Linux, VMBus
channels are created for these devices, and they are processed by
vmbus_device_register(). While nothing further happens because no matching
driver is found, the channel continues to exist.

To avoid having the spurious channel, drop such devices immediately in
vmbus_onoffer(), based on identifying the device in the
vmbus_unsupported_devs table. If Hyper-V should issue a rescind request
for the device, no matching channel will be found and the rescind will
also be ignored.

Since unsupported devices are dropped early, the check for unsupported
devices in hv_get_dev_type() is redundant. Remove it.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/channel_mgmt.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 3c6011a48dab..a216a0aede73 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -203,7 +203,7 @@ static u16 hv_get_dev_type(const struct vmbus_channel *channel)
 	const guid_t *guid = &channel->offermsg.offer.if_type;
 	u16 i;
 
-	if (is_hvsock_channel(channel) || is_unsupported_vmbus_devs(guid))
+	if (is_hvsock_channel(channel))
 		return HV_UNKNOWN;
 
 	for (i = HV_IDE; i < HV_UNKNOWN; i++) {
@@ -1036,6 +1036,16 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
 
 	trace_vmbus_onoffer(offer);
 
+	/*
+	 * Hyper-V may offer pseudo-devices with functionality intended for
+	 * Windows guests. Silently ignore them. There's no value in
+	 * cluttering dmesg with error messages.
+	 */
+	if (is_unsupported_vmbus_devs(&offer->offer.if_type)) {
+		atomic_dec(&vmbus_connection.offer_in_progress);
+		return;
+	}
+
 	if (!vmbus_is_valid_offer(offer)) {
 		pr_err_ratelimited("Invalid offer %d from the host supporting isolation\n",
 				   offer->child_relid);
-- 
2.25.1


