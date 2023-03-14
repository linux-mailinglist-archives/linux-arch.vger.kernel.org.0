Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07BC6B9327
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 13:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjCNMPK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Mar 2023 08:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjCNMN6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 08:13:58 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2964A101C;
        Tue, 14 Mar 2023 05:13:10 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32EC01Oi030125;
        Tue, 14 Mar 2023 12:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=1SRNPJFzhIow93CAQqVptkS+4M3eQneQeH47X7pGUzw=;
 b=Alwdz69Zk4IcTj67OaM8FMtje+9YMoQkosu7UKQ4z6okxfFtx37FCY4dhNFMW+LCeYN6
 SAFrs34SVGIU/bm+dhuNFbnwYLCRZ4S4vN+wzfWUJaMq9dV9pC8yb8fiXkLWn6qhMHdB
 Ur099nvNJcuXK2ETESmxm//JLw6sjzSfjBv3ZXUKShoq6GqLFQFRWZMMUfoORPDUfrIW
 ZEf3Obhnqf1TlBFbbaoXGJy0w/mtj2YLEc4n35/XIjujQ0QlK4/O+msybuB4gNZBUwiA
 rOz5Gpkek5MH+EEQcgK0SaoBcSzCNnv9i89tswyDM+Y/7gv94bIjiY+2CxSa0p+b9vJu 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pampuq6hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:45 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32EB7c20020724;
        Tue, 14 Mar 2023 12:12:44 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pampuq6gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:44 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32E7n3O0001030;
        Tue, 14 Mar 2023 12:12:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3p8h96mrw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:42 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ECCe4n13369802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Mar 2023 12:12:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67C4A2007B;
        Tue, 14 Mar 2023 12:12:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01E9D2007A;
        Tue, 14 Mar 2023 12:12:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Mar 2023 12:12:39 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
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
Subject: [PATCH v3 21/38] parport: PC style parport depends on HAS_IOPORT
Date:   Tue, 14 Mar 2023 13:11:59 +0100
Message-Id: <20230314121216.413434-22-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230314121216.413434-1-schnelle@linux.ibm.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cZDwY7A80dlURZVLhzvrXWsYQQQdAIaH
X-Proofpoint-GUID: 086U9OiT888_7KzYR-_C3VXKZZhRL7KR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_04,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 mlxlogscore=633 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303140103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
not being declared. As PC style parport uses these functions we need to
handle this dependency.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/parport/Kconfig | 4 ++--
 include/linux/parport.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/parport/Kconfig b/drivers/parport/Kconfig
index 5561362224e2..5c471c73629f 100644
--- a/drivers/parport/Kconfig
+++ b/drivers/parport/Kconfig
@@ -14,7 +14,6 @@ config ARCH_MIGHT_HAVE_PC_PARPORT
 
 menuconfig PARPORT
 	tristate "Parallel port support"
-	depends on HAS_IOMEM
 	help
 	  If you want to use devices connected to your machine's parallel port
 	  (the connector at the computer with 25 holes), e.g. printer, ZIP
@@ -42,7 +41,8 @@ if PARPORT
 
 config PARPORT_PC
 	tristate "PC-style hardware"
-	depends on ARCH_MIGHT_HAVE_PC_PARPORT || (PCI && !S390)
+	depends on ARCH_MIGHT_HAVE_PC_PARPORT
+	depends on HAS_IOPORT
 	help
 	  You should say Y here if you have a PC-style parallel port. All
 	  IBM PC compatible computers and some Alphas have PC-style
diff --git a/include/linux/parport.h b/include/linux/parport.h
index a0bc9e0267b7..fff39bc30629 100644
--- a/include/linux/parport.h
+++ b/include/linux/parport.h
@@ -514,7 +514,7 @@ extern int parport_device_proc_register(struct pardevice *device);
 extern int parport_device_proc_unregister(struct pardevice *device);
 
 /* If PC hardware is the only type supported, we can optimise a bit.  */
-#if !defined(CONFIG_PARPORT_NOT_PC)
+#if !defined(CONFIG_PARPORT_NOT_PC) && defined(CONFIG_PARPORT_PC)
 
 #include <linux/parport_pc.h>
 #define parport_write_data(p,x)            parport_pc_write_data(p,x)
-- 
2.37.2

