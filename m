Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A99514B3C
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 15:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376480AbiD2NzT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 09:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376468AbiD2Ny5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 09:54:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765055BE76;
        Fri, 29 Apr 2022 06:51:31 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TBZSqY029789;
        Fri, 29 Apr 2022 13:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0YZGzId6ewK9csYggsw+WYYFHpmL7P8ZiGT1L6Q4FQ8=;
 b=XF5hMqjcp6gG3yWzqOpB4ZzbVA0EfDOTaipeqXb2pdrJe633p9X9gpWFgODWLrcQHmOv
 yH/S8RDQXGBnkzKSgVH1hvu82FhbDVdSgL+xujKc30JKFoW97InYQPuqltGd7s0BBNfl
 D44E8+tTgYD/GBIGUxOIsCNFx75k0Jyy7fAc5R4rnMV1by2HUNwZDLBrz8U8EycznXFQ
 OUHT/wuq2npwrn85+MLexlizHvNf3tCDGy/HXOPbwIBEty5dctCF8a5jOBYRMWR6L5c/
 hTdfRia3KLhwf0VPdGh/ohnLzYIRHZMhRGfQOVG+ma6lIQrR5LGyKlCWUHqw0dQV7zU3 MQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqv5rjk2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:26 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TDQmHf014253;
        Fri, 29 Apr 2022 13:51:24 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3fm93916wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:24 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TDpMTR48169240
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:51:22 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 153D44C044;
        Fri, 29 Apr 2022 13:51:22 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9F544C040;
        Fri, 29 Apr 2022 13:51:21 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 13:51:21 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-i2c@vger.kernel.org (open list:I2C SUBSYSTEM HOST DRIVERS)
Subject: [RFC v2 12/39] i2c: add HAS_IOPORT dependencies
Date:   Fri, 29 Apr 2022 15:50:19 +0200
Message-Id: <20220429135108.2781579-22-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429135108.2781579-1-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HkJYotdJgbUNqVRdMHjYEmWTr-xVYKOD
X-Proofpoint-ORIG-GUID: HkJYotdJgbUNqVRdMHjYEmWTr-xVYKOD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_06,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1011 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=824 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204290078
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
 drivers/i2c/busses/Kconfig | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index a1bae59208e3..d1d97420cf10 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -18,7 +18,7 @@ config I2C_CCGX_UCSI
 
 config I2C_ALI1535
 	tristate "ALI 1535"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  If you say yes to this option, support will be included for the SMB
 	  Host controller on Acer Labs Inc. (ALI) M1535 South Bridges.  The SMB
@@ -30,7 +30,7 @@ config I2C_ALI1535
 
 config I2C_ALI1563
 	tristate "ALI 1563"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  If you say yes to this option, support will be included for the SMB
 	  Host controller on Acer Labs Inc. (ALI) M1563 South Bridges.  The SMB
@@ -42,7 +42,7 @@ config I2C_ALI1563
 
 config I2C_ALI15X3
 	tristate "ALI 15x3"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  If you say yes to this option, support will be included for the
 	  Acer Labs Inc. (ALI) M1514 and M1543 motherboard I2C interfaces.
@@ -52,7 +52,7 @@ config I2C_ALI15X3
 
 config I2C_AMD756
 	tristate "AMD 756/766/768/8111 and nVidia nForce"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  If you say yes to this option, support will be included for the AMD
 	  756/766/768 mainboard I2C interfaces.  The driver also includes
@@ -77,7 +77,7 @@ config I2C_AMD756_S4882
 
 config I2C_AMD8111
 	tristate "AMD 8111"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  If you say yes to this option, support will be included for the
 	  second (SMBus 2.0) AMD 8111 mainboard I2C interface.
@@ -107,7 +107,7 @@ config I2C_HIX5HD2
 
 config I2C_I801
 	tristate "Intel 82801 (ICH/PCH)"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	select CHECK_SIGNATURE if X86 && DMI
 	select I2C_SMBUS
 	help
@@ -162,7 +162,7 @@ config I2C_I801
 
 config I2C_ISCH
 	tristate "Intel SCH SMBus 1.0"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	select LPC_SCH
 	help
 	  Say Y here if you want to use SMBus controller on the Intel SCH
@@ -183,7 +183,7 @@ config I2C_ISMT
 
 config I2C_PIIX4
 	tristate "Intel PIIX4 and compatible (ATI/AMD/Serverworks/Broadcom/SMSC)"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  If you say yes to this option, support will be included for the Intel
 	  PIIX4 family of mainboard I2C interfaces.  Specifically, the following
@@ -229,7 +229,7 @@ config I2C_CHT_WC
 
 config I2C_NFORCE2
 	tristate "Nvidia nForce2, nForce3 and nForce4"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  If you say yes to this option, support will be included for the Nvidia
 	  nForce2, nForce3 and nForce4 families of mainboard I2C interfaces.
@@ -262,7 +262,7 @@ config I2C_NVIDIA_GPU
 
 config I2C_SIS5595
 	tristate "SiS 5595"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  If you say yes to this option, support will be included for the
 	  SiS5595 SMBus (a subset of I2C) interface.
@@ -272,7 +272,7 @@ config I2C_SIS5595
 
 config I2C_SIS630
 	tristate "SiS 630/730/964"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  If you say yes to this option, support will be included for the
 	  SiS630, SiS730 and SiS964 SMBus (a subset of I2C) interface.
@@ -282,7 +282,7 @@ config I2C_SIS630
 
 config I2C_SIS96X
 	tristate "SiS 96x"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  If you say yes to this option, support will be included for the SiS
 	  96x SMBus (a subset of I2C) interfaces.  Specifically, the following
@@ -300,7 +300,7 @@ config I2C_SIS96X
 
 config I2C_VIA
 	tristate "VIA VT82C586B"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	select I2C_ALGOBIT
 	help
 	  If you say yes to this option, support will be included for the VIA
@@ -311,7 +311,7 @@ config I2C_VIA
 
 config I2C_VIAPRO
 	tristate "VIA VT82C596/82C686/82xx and CX700/VX8xx/VX900"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  If you say yes to this option, support will be included for the VIA
 	  VT82C596 and later SMBus interface.  Specifically, the following
@@ -849,6 +849,7 @@ config I2C_NPCM7XX
 
 config I2C_OCORES
 	tristate "OpenCores I2C Controller"
+	depends on HAS_IOPORT
 	help
 	  If you say yes to this option, support will be included for the
 	  OpenCores I2C controller. For details see
@@ -1232,6 +1233,7 @@ config I2C_CP2615
 config I2C_PARPORT
 	tristate "Parallel port adapter"
 	depends on PARPORT
+	depends on HAS_IOPORT
 	select I2C_ALGOBIT
 	select I2C_SMBUS
 	help
@@ -1330,6 +1332,7 @@ config I2C_ICY
 config I2C_MLXCPLD
 	tristate "Mellanox I2C driver"
 	depends on X86_64 || COMPILE_TEST
+	depends on HAS_IOPORT
 	help
 	  This exposes the Mellanox platform I2C busses to the linux I2C layer
 	  for X86 based systems.
-- 
2.32.0

