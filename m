Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8517A6B9329
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 13:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjCNMPM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Mar 2023 08:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjCNMOj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 08:14:39 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE4C9545C;
        Tue, 14 Mar 2023 05:13:16 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32EAl8UQ030667;
        Tue, 14 Mar 2023 12:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=XQzs/809zKHzqunm5o1eU+S1K4AIG8MdIMV24G0WrD0=;
 b=aPIV0Por64AeGRuCx4lJWKLOYHP7wUMvMZBx6e0qmaU5bKy4bwg98//0jQ74mC86OfIV
 PwhxUMsONy/iGGfYVfQ/ug1NDcxtpCJxTvKpTqgZAhiwjtJQPYugPrPYOLezhlir3yoH
 qM9HV8me2A76xsMarlXtFOE0OHoPbBTjJQ12h1ZsrT45UxKYJtglLb02yd8PwmRPKUpu
 CZyCwvQvVRWkdcbZrOAeaJdsbKQC51DjAQiuNwh+7b1g6qARfejYkdjniRTlCppcUWzg
 F2yH//lo/BblTznmVwTKuAMocth+rBlTxVQQPVK2muG4eak8sgyYP2lgaeLd2NpB8Isz gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3paqftj541-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:34 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32EC9435027099;
        Tue, 14 Mar 2023 12:12:33 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3paqftj52q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:33 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32E7i99M028619;
        Tue, 14 Mar 2023 12:12:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3p8h96msmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:31 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ECCTFd46268908
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Mar 2023 12:12:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 017252007C;
        Tue, 14 Mar 2023 12:12:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 852342007B;
        Tue, 14 Mar 2023 12:12:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Mar 2023 12:12:28 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>, Jean Delvare <jdelvare@suse.com>,
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
        linux-hwmon@vger.kernel.org
Subject: [PATCH v3 10/38] hwmon: add HAS_IOPORT dependencies
Date:   Tue, 14 Mar 2023 13:11:48 +0100
Message-Id: <20230314121216.413434-11-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230314121216.413434-1-schnelle@linux.ibm.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: b9Mgrpfz2nHGY7AyFAeW4h-wnj52RLiN
X-Proofpoint-GUID: NyhqrwJNe1jr6q2Lzuk7_R5S0iLonbqR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_04,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=682 spamscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303140103
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

Acked-by: Guenter Roeck <linux@roeck-us.net>
Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/hwmon/Kconfig | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 5b3b76477b0e..35afb070cae2 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -578,6 +578,7 @@ config SENSORS_SPARX5
 
 config SENSORS_F71805F
 	tristate "Fintek F71805F/FG, F71806F/FG and F71872F/FG"
+	depends on HAS_IOPORT
 	depends on !PPC
 	help
 	  If you say yes here you get support for hardware monitoring
@@ -589,6 +590,7 @@ config SENSORS_F71805F
 
 config SENSORS_F71882FG
 	tristate "Fintek F71882FG and compatibles"
+	depends on HAS_IOPORT
 	depends on !PPC
 	help
 	  If you say yes here you get support for hardware monitoring
@@ -801,6 +803,7 @@ config SENSORS_CORETEMP
 
 config SENSORS_IT87
 	tristate "ITE IT87xx and compatibles"
+	depends on HAS_IOPORT
 	depends on !PPC
 	select HWMON_VID
 	help
@@ -1465,6 +1468,7 @@ config SENSORS_LM95245
 
 config SENSORS_PC87360
 	tristate "National Semiconductor PC87360 family"
+	depends on HAS_IOPORT
 	depends on !PPC
 	select HWMON_VID
 	help
@@ -1479,6 +1483,7 @@ config SENSORS_PC87360
 
 config SENSORS_PC87427
 	tristate "National Semiconductor PC87427"
+	depends on HAS_IOPORT
 	depends on !PPC
 	help
 	  If you say yes here you get access to the hardware monitoring
@@ -1510,6 +1515,7 @@ config SENSORS_NTC_THERMISTOR
 
 config SENSORS_NCT6683
 	tristate "Nuvoton NCT6683D"
+	depends on HAS_IOPORT
 	depends on !PPC
 	help
 	  If you say yes here you get support for the hardware monitoring
@@ -1531,6 +1537,7 @@ config SENSORS_NCT6775_CORE
 
 config SENSORS_NCT6775
 	tristate "Platform driver for Nuvoton NCT6775F and compatibles"
+	depends on HAS_IOPORT
 	depends on !PPC
 	depends on ACPI || ACPI=n
 	select HWMON_VID
@@ -1767,7 +1774,7 @@ config SENSORS_SHTC1
 
 config SENSORS_SIS5595
 	tristate "Silicon Integrated Systems Corp. SiS5595"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  If you say yes here you get support for the integrated sensors in
 	  SiS5595 South Bridges.
@@ -1787,6 +1794,7 @@ config SENSORS_SY7636A
 
 config SENSORS_DME1737
 	tristate "SMSC DME1737, SCH311x and compatibles"
+	depends on HAS_IOPORT
 	depends on I2C && !PPC
 	select HWMON_VID
 	help
@@ -1843,6 +1851,7 @@ config SENSORS_EMC6W201
 
 config SENSORS_SMSC47M1
 	tristate "SMSC LPC47M10x and compatibles"
+	depends on HAS_IOPORT
 	depends on !PPC
 	help
 	  If you say yes here you get support for the integrated fan
@@ -1877,6 +1886,7 @@ config SENSORS_SMSC47M192
 
 config SENSORS_SMSC47B397
 	tristate "SMSC LPC47B397-NC"
+	depends on HAS_IOPORT
 	depends on !PPC
 	help
 	  If you say yes here you get support for the SMSC LPC47B397-NC
@@ -1890,6 +1900,7 @@ config SENSORS_SCH56XX_COMMON
 
 config SENSORS_SCH5627
 	tristate "SMSC SCH5627"
+	depends on HAS_IOPORT
 	depends on !PPC && WATCHDOG
 	select SENSORS_SCH56XX_COMMON
 	select WATCHDOG_CORE
@@ -1903,6 +1914,7 @@ config SENSORS_SCH5627
 
 config SENSORS_SCH5636
 	tristate "SMSC SCH5636"
+	depends on HAS_IOPORT
 	depends on !PPC && WATCHDOG
 	select SENSORS_SCH56XX_COMMON
 	select WATCHDOG_CORE
@@ -2145,7 +2157,7 @@ config SENSORS_VIA_CPUTEMP
 
 config SENSORS_VIA686A
 	tristate "VIA686A"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  If you say yes here you get support for the integrated sensors in
 	  Via 686A/B South Bridges.
@@ -2155,6 +2167,7 @@ config SENSORS_VIA686A
 
 config SENSORS_VT1211
 	tristate "VIA VT1211"
+	depends on HAS_IOPORT
 	depends on !PPC
 	select HWMON_VID
 	help
@@ -2166,7 +2179,7 @@ config SENSORS_VT1211
 
 config SENSORS_VT8231
 	tristate "VIA VT8231"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	select HWMON_VID
 	help
 	  If you say yes here then you get support for the integrated sensors
@@ -2274,6 +2287,7 @@ config SENSORS_W83L786NG
 
 config SENSORS_W83627HF
 	tristate "Winbond W83627HF, W83627THF, W83637HF, W83687THF, W83697HF"
+	depends on HAS_IOPORT
 	depends on !PPC
 	select HWMON_VID
 	help
@@ -2286,6 +2300,7 @@ config SENSORS_W83627HF
 
 config SENSORS_W83627EHF
 	tristate "Winbond W83627EHF/EHG/DHG/UHG, W83667HG"
+	depends on HAS_IOPORT
 	depends on !PPC
 	select HWMON_VID
 	help
-- 
2.37.2

