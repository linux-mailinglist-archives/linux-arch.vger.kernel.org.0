Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65AEB1034F4
	for <lists+linux-arch@lfdr.de>; Wed, 20 Nov 2019 08:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfKTHQm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Nov 2019 02:16:42 -0500
Received: from mail-eopbgr730138.outbound.protection.outlook.com ([40.107.73.138]:20640
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727374AbfKTHQm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Nov 2019 02:16:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWc8FvhjjLPzMcq46QeszTsXOyOVAzoI6wv5wcE6SQAXGD5pM0raSS/x/9scQXmdvIS7kI4Fs/zU4hiasfJhLnvxJmyyqp7+OvJwFWWpab+cc5c0Am5I+f5bqnnlj7SYjPEXWJ8+aYMEqeSVjSMfyFIhlveBmc0BvlzXLlpt5gdGKtIPDeXzwrZbwg3fShhAcRQJYiCzEVQ1G3ipc0YiB/6KN+ai9MCetHHXl8xOoIHYnfZ3v8hC1eF4Id1dG4FiYqZuuvn9g+B8vKxxpwGue76tUN403ipK0z6vh6Ad2vrJfeWOEyKZhL5dglVEO2waRbtGEuAK7wUzqmZHD/bR0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPM6Xk2cYl6pPb3CX7gd2aLrxzsUP0fBaRByzCgfhV4=;
 b=GMpzUHAKYdg5reOOzrdZoarwesXlnI0+0cfFpSa5zfMjNeTjMYXrIC+dviGxzim4hglkkSwLcRnewEp4iD0LTIpiID8ck/MDY1kJY6S0r7UEtY/wAL3YoGvwYT5u6UN83LkHhuRupeiF0zLpuB+rEtppCZgT6aLaXwWletAk727aYTibm9HCz4OtuCtcGrCSU30LZDqH/5uveKUz0fQ+Mk6DM9zJ8/73QZGmcfxfP0RVi5VrOWN3+rZJHiJ7alH+X43F7TIPVdv2gba9i+aZGo/4buIBsOx5wJpUif6tIUA3r82z7wtW1b1omEdZokfNv7ovnGq9GM4I7kzJ+hs8fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPM6Xk2cYl6pPb3CX7gd2aLrxzsUP0fBaRByzCgfhV4=;
 b=PlFBVbB0Mwx9t/REzeOBNm/suxWu3EmDAlRv3pi7eSDUpZh3CJNAG4HvSyxLsdRLUHkvGJl28o/6JbW5PcjV9S62kdikyVreu+gs9QwldKxr3h5F96Nk22yzsok43X5w8zq0/DjmfWhp1afn3NqkU6/zR5jeK/vGtpDOQoJoizg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BN8PR21MB1137.namprd21.prod.outlook.com (20.179.72.96) by
 BN8PR21MB1251.namprd21.prod.outlook.com (20.179.74.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.3; Wed, 20 Nov 2019 07:16:38 +0000
Received: from BN8PR21MB1137.namprd21.prod.outlook.com
 ([fe80::c596:ecf5:7a6:734d]) by BN8PR21MB1137.namprd21.prod.outlook.com
 ([fe80::c596:ecf5:7a6:734d%2]) with mapi id 15.20.2495.006; Wed, 20 Nov 2019
 07:16:38 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        david@redhat.com, arnd@arndb.de, bp@alien8.de,
        daniel.lezcano@linaro.org, hpa@zytor.com, mingo@redhat.com,
        tglx@linutronix.de, x86@kernel.org, Alexander.Levin@microsoft.com,
        vkuznets@redhat.com
Cc:     linux-arch@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2 2/2] hv_balloon: Add the support of hibernation
Date:   Tue, 19 Nov 2019 23:16:05 -0800
Message-Id: <1574234165-49066-3-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574234165-49066-1-git-send-email-decui@microsoft.com>
References: <1574234165-49066-1-git-send-email-decui@microsoft.com>
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR20CA0036.namprd20.prod.outlook.com
 (2603:10b6:300:ed::22) To BN8PR21MB1137.namprd21.prod.outlook.com
 (2603:10b6:408:71::32)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR20CA0036.namprd20.prod.outlook.com (2603:10b6:300:ed::22) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 20 Nov 2019 07:16:36 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f13c89eb-0754-4c37-528d-08d76d899584
X-MS-TrafficTypeDiagnostic: BN8PR21MB1251:|BN8PR21MB1251:|BN8PR21MB1251:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN8PR21MB1251159AA72CF6F8AEA4D5F6BF4F0@BN8PR21MB1251.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(10090500001)(36756003)(7416002)(8936002)(50226002)(81166006)(81156014)(8676002)(14444005)(6436002)(6486002)(1511001)(86362001)(7736002)(2906002)(5660300002)(478600001)(10290500003)(966005)(4720700003)(3846002)(6116002)(25786009)(3450700001)(66946007)(66556008)(66476007)(305945005)(316002)(386003)(6666004)(4326008)(6506007)(22452003)(26005)(16586007)(186003)(16526019)(107886003)(76176011)(51416003)(52116002)(66066001)(48376002)(47776003)(50466002)(446003)(11346002)(43066004)(956004)(2616005)(476003)(486006)(6512007)(6306002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1251;H:BN8PR21MB1137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: os3MNMMgbAPH18s4vu2X7W++NcKWVtQF6P58ZmGzVc9P5pTa0vFUvKazERjlrGwFdkS9UFh5j2VwTxAVBg2lex/x75Vw2uuKeLrfAaNbPqBGq0hyk/REVqGh9AbXxTAXqd4M+6Hx+2i4PuYxjASOa+DASoDMqMXTFBe2Pci6vSG+hcllicjoIbxIJns0CR969ApnFpEYuS1ZWffaxrrLBHbdX5znXNU5hn4fpTTWBfbzj7vrsoIjPXopUtPA+sJwRErba8G1QQM1b6ZkPd9feKkTk9QwuitmMvrao51tN7iR0tsp8fJxDw+0i7U2L1x6u6hiz0D0MMbT0MxYpDeZm5zPsAbdYdlR2B6RhmcSFebn6ZznI4QClSlusznBDd/vgIoM4UpYRd4KCEa/sk9qvm3Mk33/b9TiLzctOZxzsqC/0Pv7SiuRKBVMh+7Cyn8K5mpXtBDzi/LH8Zx3WmvTxmQ4TNsgGhltJg6CncrROdM=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f13c89eb-0754-4c37-528d-08d76d899584
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 07:16:38.5050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3/Zq4c6Kwe6OcZQI8VeXwqQnRrjR4zRdiK/vk6DmOtKAcYv9EczlYW6xCkEQ+kAGpWqKwE6RGzHDiDAw37SGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1251
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When hibernation is enabled, we must ignore the balloon up/down and
hot-add requests from the host, if any.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Acked-by: David Hildenbrand <david@redhat.com>
---

v2 is actually the same as v1. This is just a resend.

I suggest this patch should go through the Hyper-V tree:
https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=hyperv-next
together with 
[PATCH v2 1/2] x86/hyperv: Implement hv_is_hibernation_supported()

 drivers/hv/hv_balloon.c | 87 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 935904830d42..7f4cf4fc805e 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -25,6 +25,8 @@
 #include <linux/hyperv.h>
 #include <asm/hyperv-tlfs.h>
 
+#include <asm/mshyperv.h>
+
 #define CREATE_TRACE_POINTS
 #include "hv_trace_balloon.h"
 
@@ -456,6 +458,7 @@ struct hot_add_wrk {
 	struct work_struct wrk;
 };
 
+static bool allow_hibernation;
 static bool hot_add = true;
 static bool do_hot_add;
 /*
@@ -1052,8 +1055,12 @@ static void hot_add_req(struct work_struct *dummy)
 	else
 		resp.result = 0;
 
-	if (!do_hot_add || (resp.page_count == 0))
-		pr_err("Memory hot add failed\n");
+	if (!do_hot_add || resp.page_count == 0) {
+		if (!allow_hibernation)
+			pr_err("Memory hot add failed\n");
+		else
+			pr_info("Ignore hot-add request!\n");
+	}
 
 	dm->state = DM_INITIALIZED;
 	resp.hdr.trans_id = atomic_inc_return(&trans_id);
@@ -1508,6 +1515,11 @@ static void balloon_onchannelcallback(void *context)
 			break;
 
 		case DM_BALLOON_REQUEST:
+			if (allow_hibernation) {
+				pr_info("Ignore balloon-up request!\n");
+				break;
+			}
+
 			if (dm->state == DM_BALLOON_UP)
 				pr_warn("Currently ballooning\n");
 			bal_msg = (struct dm_balloon *)recv_buffer;
@@ -1517,6 +1529,11 @@ static void balloon_onchannelcallback(void *context)
 			break;
 
 		case DM_UNBALLOON_REQUEST:
+			if (allow_hibernation) {
+				pr_info("Ignore balloon-down request!\n");
+				break;
+			}
+
 			dm->state = DM_BALLOON_DOWN;
 			balloon_down(dm,
 				 (struct dm_unballoon_request *)recv_buffer);
@@ -1622,6 +1639,11 @@ static int balloon_connect_vsp(struct hv_device *dev)
 	cap_msg.hdr.size = sizeof(struct dm_capabilities);
 	cap_msg.hdr.trans_id = atomic_inc_return(&trans_id);
 
+	/*
+	 * When hibernation (i.e. virtual ACPI S4 state) is enabled, the host
+	 * currently still requires the bits to be set, so we have to add code
+	 * to fail the host's hot-add and balloon up/down requests, if any.
+	 */
 	cap_msg.caps.cap_bits.balloon = 1;
 	cap_msg.caps.cap_bits.hot_add = 1;
 
@@ -1671,6 +1693,10 @@ static int balloon_probe(struct hv_device *dev,
 {
 	int ret;
 
+	allow_hibernation = hv_is_hibernation_supported();
+	if (allow_hibernation)
+		hot_add = false;
+
 #ifdef CONFIG_MEMORY_HOTPLUG
 	do_hot_add = hot_add;
 #else
@@ -1710,6 +1736,8 @@ static int balloon_probe(struct hv_device *dev,
 	return 0;
 
 probe_error:
+	dm_device.state = DM_INIT_ERROR;
+	dm_device.thread  = NULL;
 	vmbus_close(dev->channel);
 #ifdef CONFIG_MEMORY_HOTPLUG
 	unregister_memory_notifier(&hv_memory_nb);
@@ -1751,6 +1779,59 @@ static int balloon_remove(struct hv_device *dev)
 	return 0;
 }
 
+static int balloon_suspend(struct hv_device *hv_dev)
+{
+	struct hv_dynmem_device *dm = hv_get_drvdata(hv_dev);
+
+	tasklet_disable(&hv_dev->channel->callback_event);
+
+	cancel_work_sync(&dm->balloon_wrk.wrk);
+	cancel_work_sync(&dm->ha_wrk.wrk);
+
+	if (dm->thread) {
+		kthread_stop(dm->thread);
+		dm->thread = NULL;
+		vmbus_close(hv_dev->channel);
+	}
+
+	tasklet_enable(&hv_dev->channel->callback_event);
+
+	return 0;
+
+}
+
+static int balloon_resume(struct hv_device *dev)
+{
+	int ret;
+
+	dm_device.state = DM_INITIALIZING;
+
+	ret = balloon_connect_vsp(dev);
+
+	if (ret != 0)
+		goto out;
+
+	dm_device.thread =
+		 kthread_run(dm_thread_func, &dm_device, "hv_balloon");
+	if (IS_ERR(dm_device.thread)) {
+		ret = PTR_ERR(dm_device.thread);
+		dm_device.thread = NULL;
+		goto close_channel;
+	}
+
+	dm_device.state = DM_INITIALIZED;
+	return 0;
+close_channel:
+	vmbus_close(dev->channel);
+out:
+	dm_device.state = DM_INIT_ERROR;
+#ifdef CONFIG_MEMORY_HOTPLUG
+	unregister_memory_notifier(&hv_memory_nb);
+	restore_online_page_callback(&hv_online_page);
+#endif
+	return ret;
+}
+
 static const struct hv_vmbus_device_id id_table[] = {
 	/* Dynamic Memory Class ID */
 	/* 525074DC-8985-46e2-8057-A307DC18A502 */
@@ -1765,6 +1846,8 @@ static  struct hv_driver balloon_drv = {
 	.id_table = id_table,
 	.probe =  balloon_probe,
 	.remove =  balloon_remove,
+	.suspend = balloon_suspend,
+	.resume = balloon_resume,
 	.driver = {
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
-- 
2.19.1

