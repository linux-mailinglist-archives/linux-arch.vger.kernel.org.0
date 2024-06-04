Return-Path: <linux-arch+bounces-4669-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 551E18FA9B9
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 07:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E561A1F25295
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 05:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6845E142E9C;
	Tue,  4 Jun 2024 05:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGuexhTD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5F714291B;
	Tue,  4 Jun 2024 05:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717477853; cv=none; b=ZNcHb10xtJjNs4NB4vOeqqUC4Z2BMRqEqrJUA7hPcDH6Ly3qhizI/J4RDOpWG5p5zD/fOt2UjOfz+jFGWqqo7+s0CUxf9frPePTQYGS0EzzStd5Pm0ALbrcdsTXuT6R2VKj8KgZjkoQ7Qp+2/HA4Z0eyIwnZ0UzXvDG3QkDcE8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717477853; c=relaxed/simple;
	bh=1jVA1hbkuJFk2X1Wq2r6QErsU8Q1jsab7e/GaD/Uy9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u6eU6d/srp+MUTTnikiNGGfoDkv7FXUZ7/H4/IbWG8iWF431PTf7bO0MjF5FHKw2TOmUpAzKys9lUnTmTAE2WC3v6SePBjOf0QH+vK71tlSMdRUsxPD3bMyTSRtbGft2naVv+UjWcvrGYK05INV9t8He6uNdvNJt99xj0QNC7ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGuexhTD; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b970a97e8eso364474eaf.1;
        Mon, 03 Jun 2024 22:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717477850; x=1718082650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pVV6Kv0tGk5nmsV3DBWEtw/NPqCxYSXN7XTZ22q11dg=;
        b=kGuexhTDqFeWTDafOqg1qOhkm5DYBi+TIpnFpS9UgUyFz3jEt7tgd7RhDKpngD35+7
         B5OOqs7BsKkCgj24e4ZcwRLeaQPBbP8zvbJB53/mFirRvbYq5Ah05rNgAb7UlNAVC0h/
         cZbagt/2bcZ69K4ezI1b9vtQuwLewtfKoP5BA2JGKq4Bq4SXUbQb62w/ENAos3uUV3Cu
         Z7uh3egA0tokhelxHjEbgFfi9Vh1vtVlsVTJNkLw5xl6jOv9aF8d+XQ5cJVOXf/1LwEc
         dNMR3OxsX7TJXlj/GFGFR8b1U/zd+1ZVOYBfV7ZaxQwSjsXnJHzdETuNZIdmXyKNd3cZ
         Oo2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717477850; x=1718082650;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pVV6Kv0tGk5nmsV3DBWEtw/NPqCxYSXN7XTZ22q11dg=;
        b=jLd1sBne9UX1vW7mJeE5JWnraJPw2lVexNVC8GwnUiOiSraOkx3taz8qVxaKaxrFvz
         gVhFm7F7hCehOx1P5oHie4GRkNxRrwA7IfTkU1/FLiqqT3Jvx3oEPdDzHW3EhtnMi4E8
         sLaWPLPHlwErjT1Gb1kkF00U4Q5Z46XFeg0yHB0HmfoX1C9BGLstGwBHKJX3vs3eKnqc
         kZ2pRKIy02EOiwALvX1n6nbzUpFEmGlyPc9/E3B5eO02t+pawD29ys06yc1HThmHrd5w
         DkscbXQrPG19zSRS7WU6NlwkyQXN8ooRoa6ZZH0WXn/m5XvJwLdLXaNQygNkRiPoFzWr
         2ETw==
X-Forwarded-Encrypted: i=1; AJvYcCX3Wl+oyj1DD0852BwA32pLa/rMem68QB5xMnGVSRnkch+iu3hnNORjVI0WS0lDNwZXOghB2VDjRWLMepzmIBrZFPAu5c6TB3QdbYBmr0+3PqMMdWflO54LWJnwVWq0ID65xHEh2VPMnfTeyr7nexWP/+qUjRAMjvd5pJqdz+Lx6PYJdHfSAtPawF+r9Lbb0aH2MA6I4/TAREqsHRKab6xqOk63DtA7wyqTp3BGJUOPN2t5XLP1mA4rcNDHolQ=
X-Gm-Message-State: AOJu0YwrIUcKciZisCei0bTuYpBxDNJ0IdN/MZd/LTOt8lMd4i6kGq3N
	tkGGBNX10bqHO6RcjpkV0JsVS2zZ1u4VmAmtwcA0pUI7G8JBcIf2
X-Google-Smtp-Source: AGHT+IFF4pZiPOoszBF2RPe9oAaHaW1lz4eLkIWpJh01f0tjODzp1ogdUGgeuXzlAkHajFkd9k+xLA==
X-Received: by 2002:a05:6820:1c91:b0:5b5:1f77:9603 with SMTP id 006d021491bc7-5ba05dc205cmr11327808eaf.8.1717477850379;
        Mon, 03 Jun 2024 22:10:50 -0700 (PDT)
Received: from localhost.localdomain (c-67-161-114-176.hsd1.wa.comcast.net. [67.161.114.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242c270c7sm6298153b3a.220.2024.06.03.22.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 22:10:50 -0700 (PDT)
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
Subject: [RFC 11/12] Drivers: hv: vmbus: Wait for MODIFYCHANNEL to finish when offlining CPUs
Date: Mon,  3 Jun 2024 22:09:39 -0700
Message-Id: <20240604050940.859909-12-mhklinux@outlook.com>
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

vmbus_irq_set_affinity() may issue a MODIFYCHANNEL request to Hyper-V to
target a VMBus channel interrupt to a different CPU. While newer versions
of Hyper-V send a response to the guest when the change is complete,
vmbus_irq_set_affinity() does not wait for the response because it is
running with interrupts disabled. So Hyper-V may continue to direct
interrupts to the old CPU for a short window after vmbus_irq_set_affinity()
completes. This lag is not a problem during normal operation. But if
the old CPU is taken offline during that window, Hyper-V may drop
the interrupt because the synic in the target CPU is disabled. Dropping
the interrupt may cause the VMBus channel to hang.

To prevent this, wait for in-process MODIFYCHANNEL requests when taking
a CPU offline. On newer versions of Hyper-V, completion can be confirmed
by waiting for the response sent by Hyper-V. But on older versions of
Hyper-V that don't send a response, wait a fixed interval of time that
empirically should be "long enough", as that's the best that can be done.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/channel.c      |  3 ++
 drivers/hv/channel_mgmt.c | 32 ++++--------------
 drivers/hv/hv.c           | 70 +++++++++++++++++++++++++++++++++++----
 drivers/hv/hyperv_vmbus.h |  8 +++++
 4 files changed, 81 insertions(+), 32 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index b7920072e243..b7ee95373049 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -246,6 +246,9 @@ int vmbus_send_modifychannel(struct vmbus_channel *channel, u32 target_vp)
 	ret = vmbus_post_msg(&msg, sizeof(msg), false);
 	trace_vmbus_send_modifychannel(&msg, ret);
 
+	if (!ret)
+		vmbus_connection.modchan_sent++;
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(vmbus_send_modifychannel);
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index da42aaae994e..960a2f0367d8 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -1465,40 +1465,20 @@ static void vmbus_ongpadl_created(struct vmbus_channel_message_header *hdr)
  * vmbus_onmodifychannel_response - Modify Channel response handler.
  *
  * This is invoked when we received a response to our channel modify request.
- * Find the matching request, copy the response and signal the requesting thread.
+ * Increment the count of responses received. No locking is needed because
+ * responses are always received on the VMBUS_CONNECT_CPU.
  */
 static void vmbus_onmodifychannel_response(struct vmbus_channel_message_header *hdr)
 {
 	struct vmbus_channel_modifychannel_response *response;
-	struct vmbus_channel_msginfo *msginfo;
-	unsigned long flags;
 
 	response = (struct vmbus_channel_modifychannel_response *)hdr;
+	if (response->status)
+		pr_err("Error status %x in MODIFYCHANNEL response for relid %d\n",
+			response->status, response->child_relid);
+	vmbus_connection.modchan_completed++;
 
 	trace_vmbus_onmodifychannel_response(response);
-
-	/*
-	 * Find the modify msg, copy the response and signal/unblock the wait event.
-	 */
-	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
-
-	list_for_each_entry(msginfo, &vmbus_connection.chn_msg_list, msglistentry) {
-		struct vmbus_channel_message_header *responseheader =
-				(struct vmbus_channel_message_header *)msginfo->msg;
-
-		if (responseheader->msgtype == CHANNELMSG_MODIFYCHANNEL) {
-			struct vmbus_channel_modifychannel *modifymsg;
-
-			modifymsg = (struct vmbus_channel_modifychannel *)msginfo->msg;
-			if (modifymsg->child_relid == response->child_relid) {
-				memcpy(&msginfo->response.modify_response, response,
-				       sizeof(*response));
-				complete(&msginfo->waitevent);
-				break;
-			}
-		}
-	}
-	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
 }
 
 /*
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index a8ad728354cb..76658dfc5008 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -401,6 +401,56 @@ void hv_synic_disable_regs(unsigned int cpu)
 		disable_percpu_irq(vmbus_irq);
 }
 
+static void hv_synic_wait_for_modifychannel(int cpu)
+{
+	int i = 5;
+	u64 base;
+
+	/*
+	 * If we're on a VMBus version where MODIFYCHANNEL doesn't send acks,
+	 * just sleep for 20 milliseconds and hope that gives Hyper-V enough
+	 * time to process them. Empirical data on recent server-class CPUs
+	 * (both x86 and arm64) shows that the Hyper-V response is typically
+	 * received and processed in the guest within a few hundred
+	 * microseconds. The 20 millisecond wait is somewhat arbitrary and
+	 * intended to give plenty to time in case there are multiple
+	 * MODIFYCHANNEL requests in progress and the host is busy. It's
+	 * the best we can do.
+	 */
+	if (vmbus_proto_version < VERSION_WIN10_V5_3) {
+		usleep_range(20000, 25000);
+		return;
+	}
+
+	/*
+	 * Otherwise compare the current value of modchan_completed against
+	 * modchan_sent. If some MODIFYCHANNEL requests have been sent that
+	 * haven't completed, sleep 5 milliseconds and check again. If the
+	 * requests still haven't completed after 5 attempts, output a
+	 * message and proceed anyway.
+	 *
+	 * Hyper-V guarantees to process MODIFYCHANNEL requests in the order
+	 * they are received from the guest, so simply comparing the counts
+	 * is sufficient.
+	 *
+	 * Note that this check may encompass MODIFYCHANNEL requests that are
+	 * unrelated to the CPU that is going offline. But the only effect is
+	 * to potentially wait a little bit longer than necessary. CPUs going
+	 * offline and affinity changes that result in MODIFYCHANNEL are
+	 * relatively rare and it's not worth the complexity to track them more
+	 * precisely.
+	 */
+	base = READ_ONCE(vmbus_connection.modchan_sent);
+	while (READ_ONCE(vmbus_connection.modchan_completed) < base && i) {
+		usleep_range(5000, 10000);
+		i--;
+	}
+
+	if (i == 0)
+		pr_err("Timed out waiting for MODIFYCHANNEL. CPU %d sent %lld completed %lld\n",
+			cpu, base, vmbus_connection.modchan_completed);
+}
+
 #define HV_MAX_TRIES 3
 /*
  * Scan the event flags page of 'this' CPU looking for any bit that is set.  If we find one
@@ -485,13 +535,21 @@ int hv_synic_cleanup(unsigned int cpu)
 	/*
 	 * channel_found == false means that any channels that were previously
 	 * assigned to the CPU have been reassigned elsewhere with a call of
-	 * vmbus_send_modifychannel().  Scan the event flags page looking for
-	 * bits that are set and waiting with a timeout for vmbus_chan_sched()
-	 * to process such bits.  If bits are still set after this operation
-	 * and VMBus is connected, fail the CPU offlining operation.
+	 * vmbus_send_modifychannel(). First wait until any MODIFYCHANNEL
+	 * requests have been completed by Hyper-V, after which we know that
+	 * no new bits in the event flags will be set. Then scan the event flags
+	 * page looking for bits that are set and waiting with a timeout for
+	 * vmbus_chan_sched() to process such bits.  If bits are still set
+	 * after this operation, fail the CPU offlining operation.
 	 */
-	if (vmbus_proto_version >= VERSION_WIN10_V4_1 && hv_synic_event_pending())
-		return -EBUSY;
+	if (vmbus_proto_version >= VERSION_WIN10_V4_1) {
+		hv_synic_wait_for_modifychannel(cpu);
+		if (hv_synic_event_pending()) {
+			pr_err("Events pending when trying to offline CPU %d\n",
+					cpu);
+			return -EBUSY;
+		}
+	}
 
 always_cleanup:
 	hv_stimer_legacy_cleanup(cpu);
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index bf35bb40c55e..571b2955b38e 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -264,6 +264,14 @@ struct vmbus_connection {
 	struct irq_domain *vmbus_irq_domain;
 	struct irq_chip	vmbus_irq_chip;
 
+	/*
+	 * VM-wide counts of MODIFYCHANNEL messages sent and completed.
+	 * Used when taking a CPU offline to make sure the relevant
+	 * MODIFYCHANNEL messages have been completed.
+	 */
+	u64 modchan_sent;
+	u64 modchan_completed;
+
 	/*
 	 * An offer message is handled first on the work_queue, and then
 	 * is further handled on handle_primary_chan_wq or
-- 
2.25.1


