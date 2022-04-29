Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF48514B3E
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 15:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376490AbiD2NzG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 09:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376428AbiD2Ny4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 09:54:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D7D5AA71;
        Fri, 29 Apr 2022 06:51:28 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TDZBYk017235;
        Fri, 29 Apr 2022 13:51:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VtjPCAEJBXs1gxsqkuVy+3yvJKxteb9KMjaZfFc7UHc=;
 b=qIUJlJAzSHFHWPsa/GFHm5eQAR/bBmQR1kuAXIoHOnMeKvggZdSHu8qCVu7PNMhGHBs6
 7Efqj7IojpHM+yHDp7Q7t9MN6WKHeu5T+7wQsxmvA3t4svfkg653iA7ZwL3Xo4kKDreB
 ScalXYM9D5sMdVpjcZivLNnYL2sPz1cBPG312siPu2ldwo/nGLlqtw4qtIFWTPThWd92
 OjEBWVFQVKHDNjjudoi7POydJ0RRKk1BdhQZQjKWgmGFzYM+ubvsql1OkIKhos+v77+7
 xJIfrxXD1muQhSRxx/Zj6RX759brzoupjO5JqAvMXFWJK6oV3CL+N0x7HF3Fsh/JOF+O Ag== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqnke41nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:24 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TDQppQ021548;
        Fri, 29 Apr 2022 13:51:22 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3fm93917qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:22 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TDpKed51904790
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:51:20 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3DE64C046;
        Fri, 29 Apr 2022 13:51:19 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9F0C4C040;
        Fri, 29 Apr 2022 13:51:19 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 13:51:19 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>
Subject: [RFC v2 09/39] firmware: dmi-sysfs: handle HAS_IOPORT=n
Date:   Fri, 29 Apr 2022 15:50:15 +0200
Message-Id: <20220429135108.2781579-18-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429135108.2781579-1-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YvPHdw0jkaZ13-ssKjmhc17Rf1Hg1dE-
X-Proofpoint-GUID: YvPHdw0jkaZ13-ssKjmhc17Rf1Hg1dE-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_06,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=956 bulkscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204290078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
not being declared. We thus need to guard sections of code calling them
as alternative access methods.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/firmware/dmi-sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/dmi-sysfs.c b/drivers/firmware/dmi-sysfs.c
index 3a353776bd34..384988a10d09 100644
--- a/drivers/firmware/dmi-sysfs.c
+++ b/drivers/firmware/dmi-sysfs.c
@@ -310,6 +310,7 @@ static struct kobj_type dmi_system_event_log_ktype = {
 	.default_groups = dmi_sysfs_sel_groups,
 };
 
+#ifdef CONFIG_HAS_IOPORT
 typedef u8 (*sel_io_reader)(const struct dmi_system_event_log *sel,
 			    loff_t offset);
 
@@ -374,6 +375,7 @@ static ssize_t dmi_sel_raw_read_io(struct dmi_sysfs_entry *entry,
 
 	return wrote;
 }
+#endif
 
 static ssize_t dmi_sel_raw_read_phys32(struct dmi_sysfs_entry *entry,
 				       const struct dmi_system_event_log *sel,
@@ -409,11 +411,13 @@ static ssize_t dmi_sel_raw_read_helper(struct dmi_sysfs_entry *entry,
 	memcpy(&sel, dh, sizeof(sel));
 
 	switch (sel.access_method) {
+#ifdef CONFIG_HAS_IOPORT
 	case DMI_SEL_ACCESS_METHOD_IO8:
 	case DMI_SEL_ACCESS_METHOD_IO2x8:
 	case DMI_SEL_ACCESS_METHOD_IO16:
 		return dmi_sel_raw_read_io(entry, &sel, state->buf,
 					   state->pos, state->count);
+#endif
 	case DMI_SEL_ACCESS_METHOD_PHYS32:
 		return dmi_sel_raw_read_phys32(entry, &sel, state->buf,
 					       state->pos, state->count);
-- 
2.32.0

