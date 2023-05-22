Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365C870BA6D
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 12:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjEVKvU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 06:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjEVKvQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 06:51:16 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A71B3;
        Mon, 22 May 2023 03:51:14 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M9cQQe010213;
        Mon, 22 May 2023 10:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=OI6wF1zAmCtTgOoZ252lKahmHjBD6cG3jFZDrBmzfTU=;
 b=O6S7mybTB8sk5Iohs6m46NkxZOq+apwkSpMUhfNeiEziCv8DS5nYhQn6xed4YrwFmJKm
 Yvq1xfzRpBAa4AivibZEKX5dN/b/Xd/LNOr3fgB4lBxhZPTkFWFMBHlFPlacu6E9Mf6K
 sfiqWDXWqA+XBIOmw1TxBnKYG95hbvrVlOR5k5MGzf7UXWX8TMuSVaWOTI0JHvQhd3x3
 G1fYJtJZfz1rBmNSXOyCQDBiiAkBa289nIzF2Qmebu8gHwwPzaLEsCfyQMMzroDYPNoz
 Hh+5DbLxeSRq13s4/Xk+TfWR8J6WfVfNNGA9Xoif3koipdPcAGJfZKqV2h1GtPzImWsg iA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qqee6tdk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:51:04 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34MASa3O020599;
        Mon, 22 May 2023 10:51:03 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qqee6tdjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:51:03 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34M5xB5G007770;
        Mon, 22 May 2023 10:51:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3qppcu8wes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:51:01 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34MAowpn32834006
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 10:50:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FAF120040;
        Mon, 22 May 2023 10:50:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 002AE20043;
        Mon, 22 May 2023 10:50:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 22 May 2023 10:50:57 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH v5 10/44] firmware: dmi-sysfs: handle HAS_IOPORT=n
Date:   Mon, 22 May 2023 12:50:15 +0200
Message-Id: <20230522105049.1467313-11-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522105049.1467313-1-schnelle@linux.ibm.com>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: I_2Gg45WEEi3OLP1qik9T0oAgXW0txyO
X-Proofpoint-ORIG-GUID: MZA9tQJ53QoiaNqEKNPswhPP2GknA3vx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_06,2023-05-22_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220089
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
not being declared. We thus need to guard sections of code calling them
as alternative access methods.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/firmware/dmi-sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/dmi-sysfs.c b/drivers/firmware/dmi-sysfs.c
index 03708ab64e56..8d91997036e4 100644
--- a/drivers/firmware/dmi-sysfs.c
+++ b/drivers/firmware/dmi-sysfs.c
@@ -310,6 +310,7 @@ static const struct kobj_type dmi_system_event_log_ktype = {
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
2.39.2

