Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60376514BA1
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 15:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376755AbiD2N4p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 09:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376638AbiD2Nzx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 09:55:53 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9E3986FD;
        Fri, 29 Apr 2022 06:51:45 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TDhXZr012223;
        Fri, 29 Apr 2022 13:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=CBUD9zEvWYDFaM5Uh2Jv4COW+ZWLsyjXhw9voFWaOFc=;
 b=YS2uAozxXl862v3hXQPyE5xzHt5lebRgPU8Dm4V+ALGC6tPRwIK41dn71FHUTzFkgt3l
 7vzoIvNFcAOnfAOdJ1h7QjHxfLQ2yJ66nOH5WXMLPePYRTbQ4BU5ptlrgRQP9aF/24a8
 hI3W5BeSIIIJZbii3SCB68IZJix2msrlJb+LbKMVig96BeXiLFUfCUA70aQvt8MWmUHG
 J9xVf0QERcTT2ZQruiTtsd9OcAU9OH4iOtD75v79BhRThNeze17jdZ0a+EaCQfIBOAor
 G5ZBKGeBItvxKCNdR36LVHi+x/AeofaZFnoAW39d4opKemw6uiH9hBNvF/KQ4v7GRPrm DQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3frh5eg47j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:26 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TDSeaD024602;
        Fri, 29 Apr 2022 13:51:23 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3fm938yabn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:23 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TDpLLk34210252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:51:21 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0656E4C058;
        Fri, 29 Apr 2022 13:51:21 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEA924C04E;
        Fri, 29 Apr 2022 13:51:20 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 13:51:20 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING)
Subject: [RFC v2 11/39] hwmon: add HAS_IOPORT dependencies
Date:   Fri, 29 Apr 2022 15:50:17 +0200
Message-Id: <20220429135108.2781579-20-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429135108.2781579-1-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: btp1ideK8IvhT7baXC-SDd3RD36n4Oej
X-Proofpoint-ORIG-GUID: btp1ideK8IvhT7baXC-SDd3RD36n4Oej
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_06,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=415 clxscore=1011 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
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
not being declared. We thus need to add HAS_IOPORT as dependency for
those drivers using them.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/hwmon/Kconfig | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 68a8a27ab3b7..67a4aa2e0235 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -563,6 +563,7 @@ config SENSORS_SPARX5
 
 config SENSORS_F71805F
 	tristate "Fintek F71805F/FG, F71806F/FG and F71872F/FG"
+	depends on HAS_IOPORT
 	depends on !PPC
 	help
 	  If you say yes here you get support for hardware monitoring
@@ -574,6 +575,7 @@ config SENSORS_F71805F
 
 config SENSORS_F71882FG
 	tristate "Fintek F71882FG and compatibles"
+	depends on HAS_IOPORT
 	depends on !PPC
 	help
 	  If you say yes here you get support for hardware monitoring
@@ -777,6 +779,7 @@ config SENSORS_CORETEMP
 
 config SENSORS_IT87
 	tristate "ITE IT87xx and compatibles"
+	depends on HAS_IOPORT
 	depends on !PPC
 	select HWMON_VID
 	help
@@ -1404,6 +1407,7 @@ config SENSORS_LM95245
 
 config SENSORS_PC87360
 	tristate "National Semiconductor PC87360 family"
+	depends on HAS_IOPORT
 	depends on !PPC
 	select HWMON_VID
 	help
@@ -1418,6 +1422,7 @@ config SENSORS_PC87360
 
 config SENSORS_PC87427
 	tristate "National Semiconductor PC87427"
+	depends on HAS_IOPORT
 	depends on !PPC
 	help
 	  If you say yes here you get access to the hardware monitoring
@@ -1449,6 +1454,7 @@ config SENSORS_NTC_THERMISTOR
 
 config SENSORS_NCT6683
 	tristate "Nuvoton NCT6683D"
+	depends on HAS_IOPORT
 	depends on !PPC
 	help
 	  If you say yes here you get support for the hardware monitoring
@@ -1459,6 +1465,7 @@ config SENSORS_NCT6683
 
 config SENSORS_NCT6775
 	tristate "Nuvoton NCT6775F and compatibles"
+	depends on HAS_IOPORT
 	depends on !PPC
 	depends on ACPI_WMI || ACPI_WMI=n
 	select HWMON_VID
@@ -1683,7 +1690,7 @@ config SENSORS_S3C_RAW
 
 config SENSORS_SIS5595
 	tristate "Silicon Integrated Systems Corp. SiS5595"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  If you say yes here you get support for the integrated sensors in
 	  SiS5595 South Bridges.
@@ -1702,6 +1709,7 @@ config SENSORS_SY7636A
 
 config SENSORS_DME1737
 	tristate "SMSC DME1737, SCH311x and compatibles"
+	depends on HAS_IOPORT
 	depends on I2C && !PPC
 	select HWMON_VID
 	help
@@ -1745,6 +1753,7 @@ config SENSORS_EMC6W201
 
 config SENSORS_SMSC47M1
 	tristate "SMSC LPC47M10x and compatibles"
+	depends on HAS_IOPORT
 	depends on !PPC
 	help
 	  If you say yes here you get support for the integrated fan
@@ -1779,6 +1788,7 @@ config SENSORS_SMSC47M192
 
 config SENSORS_SMSC47B397
 	tristate "SMSC LPC47B397-NC"
+	depends on HAS_IOPORT
 	depends on !PPC
 	help
 	  If you say yes here you get support for the SMSC LPC47B397-NC
@@ -1792,6 +1802,7 @@ config SENSORS_SCH56XX_COMMON
 
 config SENSORS_SCH5627
 	tristate "SMSC SCH5627"
+	depends on HAS_IOPORT
 	depends on !PPC && WATCHDOG
 	select SENSORS_SCH56XX_COMMON
 	select WATCHDOG_CORE
@@ -1805,6 +1816,7 @@ config SENSORS_SCH5627
 
 config SENSORS_SCH5636
 	tristate "SMSC SCH5636"
+	depends on HAS_IOPORT
 	depends on !PPC && WATCHDOG
 	select SENSORS_SCH56XX_COMMON
 	select WATCHDOG_CORE
@@ -2047,7 +2059,7 @@ config SENSORS_VIA_CPUTEMP
 
 config SENSORS_VIA686A
 	tristate "VIA686A"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  If you say yes here you get support for the integrated sensors in
 	  Via 686A/B South Bridges.
@@ -2057,6 +2069,7 @@ config SENSORS_VIA686A
 
 config SENSORS_VT1211
 	tristate "VIA VT1211"
+	depends on HAS_IOPORT
 	depends on !PPC
 	select HWMON_VID
 	help
@@ -2068,7 +2081,7 @@ config SENSORS_VT1211
 
 config SENSORS_VT8231
 	tristate "VIA VT8231"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	select HWMON_VID
 	help
 	  If you say yes here then you get support for the integrated sensors
@@ -2176,6 +2189,7 @@ config SENSORS_W83L786NG
 
 config SENSORS_W83627HF
 	tristate "Winbond W83627HF, W83627THF, W83637HF, W83687THF, W83697HF"
+	depends on HAS_IOPORT
 	depends on !PPC
 	select HWMON_VID
 	help
@@ -2188,6 +2202,7 @@ config SENSORS_W83627HF
 
 config SENSORS_W83627EHF
 	tristate "Winbond W83627EHF/EHG/DHG/UHG, W83667HG"
+	depends on HAS_IOPORT
 	depends on !PPC
 	select HWMON_VID
 	help
-- 
2.32.0

