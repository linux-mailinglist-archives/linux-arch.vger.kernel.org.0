Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B106B936A
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 13:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjCNMPj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Mar 2023 08:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjCNMPK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 08:15:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8C2A188C;
        Tue, 14 Mar 2023 05:14:15 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32EAj6gl027432;
        Tue, 14 Mar 2023 12:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=O2TuigoThC85MUm+xrTBf7ysRHIcd+HyV6A5mkUeIME=;
 b=LeDAZaQluRlxyTCw2mZ4Pm7GPA7+0VMWVDRGXyt8MnMVECOTujJa4HS2iJHAMRtxxpZU
 ekEqf/ycS4n6r8rMugihqhVDyctXF5c/jZFGYtKjStvg/ALegZuegSI/ucjakCRHdZmp
 k2u8jCKvZJuw5ho/dQdmgiB9kPUKWH0URzYsMNgrJZ811oh9iv7Bp3+AM+WxU/0iEvlW
 LqSH+gORh6VNaRc8B5qJouLI8JSsdvnArahMc3Qbzdx3LYl9RwoXmUWexGSUi8w9dX4e
 xX1lKbwySWTEV7aY6oGU2Q/LZbSsrrymTk6Yu6xsg4Kew05yYzDF7umolJ/C1ZFZfRN8 Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3panssw8x4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:13:02 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32EBU5l4001811;
        Tue, 14 Mar 2023 12:13:01 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3panssw8vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:13:01 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32E7kqS2028633;
        Tue, 14 Mar 2023 12:12:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3p8h96msn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:57 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ECCtca62259526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Mar 2023 12:12:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89ECF2007D;
        Tue, 14 Mar 2023 12:12:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A6B12007B;
        Tue, 14 Mar 2023 12:12:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Mar 2023 12:12:55 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
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
        linux-watchdog@vger.kernel.org
Subject: [PATCH v3 36/38] watchdog: add HAS_IOPORT dependencies
Date:   Tue, 14 Mar 2023 13:12:14 +0100
Message-Id: <20230314121216.413434-37-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230314121216.413434-1-schnelle@linux.ibm.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4O6iP_YBCAM4s6g7olLFIbnJC6tUU4A-
X-Proofpoint-ORIG-GUID: JkZNKnr4AI9zvWdhgJsUOZTfwlhbdCyR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_06,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 malwarescore=0 suspectscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303140103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/watchdog/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index f0872970daf9..e5d6f886e25d 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -453,6 +453,7 @@ config 21285_WATCHDOG
 config 977_WATCHDOG
 	tristate "NetWinder WB83C977 watchdog"
 	depends on (FOOTBRIDGE && ARCH_NETWINDER) || (ARM && COMPILE_TEST)
+	depends on HAS_IOPORT
 	help
 	  Say Y here to include support for the WB977 watchdog included in
 	  NetWinder machines. Alternatively say M to compile the driver as
@@ -1271,6 +1272,7 @@ config ITCO_WDT
 	select WATCHDOG_CORE
 	depends on I2C || I2C=n
 	depends on MFD_INTEL_PMC_BXT || !MFD_INTEL_PMC_BXT
+	depends on HAS_IOPORT # for I2C_I801
 	select LPC_ICH if !EXPERT
 	select I2C_I801 if !EXPERT && I2C
 	help
@@ -2148,7 +2150,7 @@ comment "PCI-based Watchdog Cards"
 
 config PCIPCWATCHDOG
 	tristate "Berkshire Products PCI-PC Watchdog"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  This is the driver for the Berkshire Products PCI-PC Watchdog card.
 	  This card simply watches your kernel to make sure it doesn't freeze,
@@ -2163,7 +2165,7 @@ config PCIPCWATCHDOG
 
 config WDTPCI
 	tristate "PCI-WDT500/501 Watchdog timer"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  If you have a PCI-WDT500/501 watchdog board, say Y here, otherwise N.
 
-- 
2.37.2

