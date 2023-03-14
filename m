Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4776B92D1
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 13:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjCNMNX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Mar 2023 08:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjCNMNS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 08:13:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2C685376;
        Tue, 14 Mar 2023 05:12:46 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32EAWXjf010453;
        Tue, 14 Mar 2023 12:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=PWOdpu7huu3x6L9OitOqCOlr3p7FNjAIQDP7DCrE7uo=;
 b=PSOIXDRkQ24agpUZMWZ+56b0xC8BSV7Zs1ugV5P7F+GIEf1rXv1a1qHIR2tnvgY7srAP
 ulU/PlGT+3YiSxvEy5KelrKZwSTBVAfvNQlVDLnkXmRqYvU2rL2cNi7d9vcCA7qDyhCo
 46O18KmySduR6Fo30pLjaSeuo3Xgyq8XI1/F+5aIXI/BKq6n0Z1TOP2mde4DmRUb1eLp
 SC8+/ahRVXhebYRoDhDK5u4z3Cr1Mzpjt6NWTJj4MMAVXlTH2rb6FC8e/rCk81rdZckI
 /TTa8doU/TWqvWtw5BL5rBtIHd/f5AtxDuXQMlH7iDcnIDpDYyAlzugrT9nX404k00cy Zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3paq8yaerh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:36 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32EAWoEb011300;
        Tue, 14 Mar 2023 12:12:36 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3paq8yaeqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:35 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32E8uLJc006456;
        Tue, 14 Mar 2023 12:12:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3p8h96krsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:33 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ECCVUl25363180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Mar 2023 12:12:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 781142007A;
        Tue, 14 Mar 2023 12:12:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C8382007D;
        Tue, 14 Mar 2023 12:12:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Mar 2023 12:12:30 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
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
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH v3 13/38] Input: add HAS_IOPORT dependencies
Date:   Tue, 14 Mar 2023 13:11:51 +0100
Message-Id: <20230314121216.413434-14-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230314121216.413434-1-schnelle@linux.ibm.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yQAlx44sEPm9Fz6Gzh6ckX9YwOiZK3VY
X-Proofpoint-ORIG-GUID: nlZfI-7xcWOZRlTxLqFLtPAU-8PxsvJX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_04,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=869 clxscore=1011 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 mlxscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303140103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
not being declared. We thus need to add HAS_IOPORT as dependency for
those drivers using them.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/input/serio/Kconfig       | 2 ++
 drivers/input/touchscreen/Kconfig | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index f39b7b3f7942..5d125627c595 100644
--- a/drivers/input/serio/Kconfig
+++ b/drivers/input/serio/Kconfig
@@ -75,6 +75,7 @@ config SERIO_Q40KBD
 config SERIO_PARKBD
 	tristate "Parallel port keyboard adapter"
 	depends on PARPORT
+	depends on HAS_IOPORT
 	help
 	  Say Y here if you built a simple parallel port adapter to attach
 	  an additional AT keyboard, XT keyboard or PS/2 mouse.
@@ -148,6 +149,7 @@ config HIL_MLC
 config SERIO_PCIPS2
 	tristate "PCI PS/2 keyboard and PS/2 mouse controller"
 	depends on PCI
+	depends on HAS_IOPORT
 	help
 	  Say Y here if you have a Mobility Docking station with PS/2
 	  keyboard and mice ports.
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 1a2049b336a6..6c268b8f0d19 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -690,6 +690,7 @@ config TOUCHSCREEN_INEXIO
 
 config TOUCHSCREEN_MK712
 	tristate "ICS MicroClock MK712 touchscreen"
+	depends on ISA
 	help
 	  Say Y here if you have the ICS MicroClock MK712 touchscreen
 	  controller chip in your system.
-- 
2.37.2

