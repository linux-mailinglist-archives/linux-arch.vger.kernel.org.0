Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E5670BAAD
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 12:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjEVKxD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 06:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjEVKvz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 06:51:55 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F5EE47;
        Mon, 22 May 2023 03:51:29 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M9HabZ019105;
        Mon, 22 May 2023 10:51:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tVM/nXxyQIeKfrrEXWrdfYojpf/P6rGiY9cOBxUUp6Y=;
 b=aiOUNJ6b4PVcXeMvRAaUs+8owgXK3xKlcfctPwBITNeGn1EywcceXMmvPE7oTgIA3OO9
 uD9x+PP5qUrK7O1aLqnIuvylQHBX6fVlWx2RGU1Y2MX6kEBAW88Lo7kRWQ52s+peiaER
 Zz0D6aMQs1WZHYJ0k4iP50OLt3FtLkCkBZ4gEWXLOsE65+3VJzZwelT+/m0i1ncHNgRH
 qEXcry3EmMdUprpNW1+6BEpZqwWAZsJbFaTppSvU5DGeLOy9uNpYuk9d/rk1UoVoUYy+
 ZuMmbe4/t92fH4oQLzZxivicq5MpkVvvBGAMV2BiuKomWPzLk/wbg/P31wtWREF6JJ07 Og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qqgbq8t9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:51:05 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34MAlvLk003842;
        Mon, 22 May 2023 10:51:04 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qqgbq8t8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:51:04 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34M8tUbD032622;
        Mon, 22 May 2023 10:51:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qppc3gw82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:51:02 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34MAoxrg20578884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 10:50:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C934120040;
        Mon, 22 May 2023 10:50:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70A9A20043;
        Mon, 22 May 2023 10:50:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 22 May 2023 10:50:59 +0000 (GMT)
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
Subject: [PATCH v5 12/44] hwmon: add HAS_IOPORT dependencies
Date:   Mon, 22 May 2023 12:50:17 +0200
Message-Id: <20230522105049.1467313-13-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522105049.1467313-1-schnelle@linux.ibm.com>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tAdXp56NZZpfnUKwEmyNA2PG74x6ubWm
X-Proofpoint-ORIG-GUID: W3nTsMMf6GRFhHakL5YB9yrt1ycx93dc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_06,2023-05-22_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0 mlxlogscore=671
 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
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
not being declared. We thus need to add HAS_IOPORT as dependency for
those drivers using them.

Acked-by: Guenter Roeck <linux@roeck-us.net>
Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/hwmon/Kconfig | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index fc640201a2de..20bde0d888f9 100644
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
@@ -2155,7 +2167,7 @@ config SENSORS_VIA_CPUTEMP
 
 config SENSORS_VIA686A
 	tristate "VIA686A"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  If you say yes here you get support for the integrated sensors in
 	  Via 686A/B South Bridges.
@@ -2165,6 +2177,7 @@ config SENSORS_VIA686A
 
 config SENSORS_VT1211
 	tristate "VIA VT1211"
+	depends on HAS_IOPORT
 	depends on !PPC
 	select HWMON_VID
 	help
@@ -2176,7 +2189,7 @@ config SENSORS_VT1211
 
 config SENSORS_VT8231
 	tristate "VIA VT8231"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	select HWMON_VID
 	help
 	  If you say yes here then you get support for the integrated sensors
@@ -2284,6 +2297,7 @@ config SENSORS_W83L786NG
 
 config SENSORS_W83627HF
 	tristate "Winbond W83627HF, W83627THF, W83637HF, W83687THF, W83697HF"
+	depends on HAS_IOPORT
 	depends on !PPC
 	select HWMON_VID
 	help
@@ -2296,6 +2310,7 @@ config SENSORS_W83627HF
 
 config SENSORS_W83627EHF
 	tristate "Winbond W83627EHF/EHG/DHG/UHG, W83667HG"
+	depends on HAS_IOPORT
 	depends on !PPC
 	select HWMON_VID
 	help
-- 
2.39.2

