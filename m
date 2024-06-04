Return-Path: <linux-arch+bounces-4660-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE378FA98D
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 07:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6A61C233C7
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 05:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF16713E027;
	Tue,  4 Jun 2024 05:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U01oW3qS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F3B13D28B;
	Tue,  4 Jun 2024 05:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717477840; cv=none; b=oZzszEqsUvGHhPemDDthC7hmX/2TP8TrHnIG/f3bVu60oj70ORBC/4uCcs7CZtIRBixMyd5tZsvc+/Q2TPuy6RysSggRwwZn71+VFtsbTzewyzp7uSsjXa59CVk6w0T7F489XOL8pV/pQw1EmHbEWhEGiPcPPIqspMdXsi4VIS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717477840; c=relaxed/simple;
	bh=4Bvo+apk2N2nn6cjDyl5CQhxEltWUBZFYmNRgBJhxgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fOs1qTJGLHigeADaGDOTFCfcXa/u48g4+jpD0dG5XX2hnJsP4/+X4Ze832lMT75YxNOp+A7IEI6mLolPk0qcu48uwWBrYMzJVJMykQ9ri3s3x0+T+7uu6N/cno7AVX9k+uaAZ+q/tqN5aQa+TOlLN37K1Y0xhFUjGZh0MU5ioeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U01oW3qS; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6c7bf648207so2258002a12.0;
        Mon, 03 Jun 2024 22:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717477839; x=1718082639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5YKAeu5Z5tm9aQZs9F3XxaISr/2oY38/ITUqBxWif4w=;
        b=U01oW3qSe827FcEeFRmM9nlmpBduxt7BIH7qq+7CH+XDFDJz23Xc0/Lm9RqSherobX
         IEoaPgOTQ2V5ZBJFFln5H74MazOv/LB1kYpueZpkiUu5vsZertJpS6wE8UHiABbsm3RR
         PzDNrZKMJhGohS9d5C4Clg//Em1mhcQIqVTVqSMe7CwvTV5OlAgNTU2sJem7NNwUbabF
         K0oWt12jR2AvSnqfsk7NfB8CjJVX/JZGjYJLQSycGzE7ANwL1EM4BUZdmyBMlrP7fTXD
         k9r7cXBV+XlFTcxtejfQ6hP3aoJzRVrhOsHFd1fpA57GWoLZlcv3/dFurzX4ZG7I8035
         a+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717477839; x=1718082639;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5YKAeu5Z5tm9aQZs9F3XxaISr/2oY38/ITUqBxWif4w=;
        b=m/04jISTOAy3AAf3LLsbCpD7MfL7toh1fIxp8cSAlqVR6Hb+YemdQNgc8i5O8FmngF
         A3ez8Y3Kwc5t2RIXJ5jhj0IBdHW7g9yx+ebF3fQOlzMqyzYXkgUYRaO7/OduJrFdno5N
         7LABe8RJH9RV5iDtwbaJYFDh4sUW7ocMdxfEaVgVX5bRe0LoQJuxSOtQLp0fsLTRY6VQ
         5s67tdOuJq8lBJOy1+yUhxKEMkL9us6WmVt12BXNHnG7xKO4hby3uwXjWdYkglgVgZZd
         Qgr4/x9d4x5XflRlfy7f3ebvywZlNQV0M/0Tcks4iGMi1Ey0MPbWZPnizFjmyl8AChdd
         e66w==
X-Forwarded-Encrypted: i=1; AJvYcCXu6eubyj3b19jh/XfmYGuO6MIifWSvyiTcNEc/PnMUwk1RCEJiuf+7aljI/xj3Mk4Pm3aQ/KVR+89LoIZ05NpFzdPC2SghmOpSsanbBA5os535I2rkWrRI8NZnvBUkfvfFW6YV1ngATIpec1siMolI6lu57iqJFgtkTyr+cMMkucVEJ/r/FPL7d6JWpD18zuSS+g3mFxy+13BmO53YCzkfihoRJhkNcxrOfAoKT7UjhU7ZFjTSoCkSUTdpaPY=
X-Gm-Message-State: AOJu0YzohobAEKnfBJh6uZFJIdmRI36ikaGvdwYwhAAWuUNoblaHDHTV
	OjF3Gwfws3LSJ37xnLslhN1juCueL4KD1DRPZkFgaZ04eVIk+3FD
X-Google-Smtp-Source: AGHT+IHKnRboB5tCmxwmDAJRCzrZ1L4NYqoQuhFMq5JMjnWnuknQC44+KcCK4lbhV5B4umVkIn2zaQ==
X-Received: by 2002:a05:6a20:9184:b0:1a3:b642:5fc3 with SMTP id adf61e73a8af0-1b26f253adamr14486371637.41.1717477838675;
        Mon, 03 Jun 2024 22:10:38 -0700 (PDT)
Received: from localhost.localdomain (c-67-161-114-176.hsd1.wa.comcast.net. [67.161.114.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242c270c7sm6298153b3a.220.2024.06.03.22.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 22:10:38 -0700 (PDT)
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
Subject: [RFC 02/12] Drivers: hv: vmbus: Fix error path that deletes non-existent sysfs group
Date: Mon,  3 Jun 2024 22:09:30 -0700
Message-Id: <20240604050940.859909-3-mhklinux@outlook.com>
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

If vmbus_device_create() returns an error to vmbus_add_channel_work(),
the cleanup path calls free_channel(), which in turn calls
vmbus_remove_channel_attr_group(). But the channel attr group hasn't
been created yet, causing sysfs_remove_group() to generate multiple
WARNs about non-existent entries.

Fix the WARNs by adding a flag to struct vmbus_channel to indicate
whether the sysfs group for the channel has been created. Use the
flag to determine if the sysfs group should be removed.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/vmbus_drv.c | 5 ++++-
 include/linux/hyperv.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 12a707ab73f8..291a8358370b 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1842,6 +1842,7 @@ int vmbus_add_channel_kobj(struct hv_device *dev, struct vmbus_channel *channel)
 		dev_err(device, "Unable to set up channel sysfs files\n");
 		return ret;
 	}
+	channel->channel_attr_set = true;
 
 	kobject_uevent(kobj, KOBJ_ADD);
 
@@ -1853,7 +1854,9 @@ int vmbus_add_channel_kobj(struct hv_device *dev, struct vmbus_channel *channel)
  */
 void vmbus_remove_channel_attr_group(struct vmbus_channel *channel)
 {
-	sysfs_remove_group(&channel->kobj, &vmbus_chan_group);
+	if (channel->channel_attr_set)
+		sysfs_remove_group(&channel->kobj, &vmbus_chan_group);
+	channel->channel_attr_set = false;
 }
 
 /*
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 5e39baa7f6cb..d52c916cc492 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -980,6 +980,7 @@ struct vmbus_channel {
 	 * For sysfs per-channel properties.
 	 */
 	struct kobject			kobj;
+	bool channel_attr_set;
 
 	/*
 	 * For performance critical channels (storage, networking
-- 
2.25.1


