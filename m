Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E83E6B92E8
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 13:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjCNMNt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Mar 2023 08:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjCNMNi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 08:13:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDF52364C;
        Tue, 14 Mar 2023 05:12:53 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32EC0hJG016904;
        Tue, 14 Mar 2023 12:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=NbAA/AV5vDEeMeVwnUyXbp30/o99unL0lo+Jih5uK6I=;
 b=jWTWBWbS6Zw9yjHKOtaquMz2STTIPn1j/KkdhVFd0dFBAa8L8JkPK/tqLEzV4ghj+Bg7
 R1IOPOZ04q+UMSAqgTew10XK4c8wSn2y7V6G6T2Laz6QSh+L3shYL6FLVp0XdP14oEh0
 AL04C49I45ozw7gYxaArpMVbCh/sURrNxwiuILrxmnrOLxYfER4MEvRy9Plm49IFUAqh
 jA+Toc2FLp0+yGfMecN+0zFs2EoRywnd4CjPdhzMMDj5qpAMOM2CS8MqClXrFAf5n3yV
 ffrTWho4y5IujJOj3nnlZaM1JIy/EYlCoRWN7yIQzDQIctGb//47dDgPP9ic/zIs7pk/ dA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3paph23u8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:35 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32EAAThR024824;
        Tue, 14 Mar 2023 12:12:34 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3paph23u7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:34 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32E8Ch8E029863;
        Tue, 14 Mar 2023 12:12:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3p8gwfct6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:32 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ECCT0c27329086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Mar 2023 12:12:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C63EE2007A;
        Tue, 14 Mar 2023 12:12:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6007C2007C;
        Tue, 14 Mar 2023 12:12:29 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Mar 2023 12:12:29 +0000 (GMT)
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
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-i2c@vger.kernel.org
Subject: [PATCH v3 11/38] i2c: add HAS_IOPORT dependencies
Date:   Tue, 14 Mar 2023 13:11:49 +0100
Message-Id: <20230314121216.413434-12-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230314121216.413434-1-schnelle@linux.ibm.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ax3L_lwBw0wOPQw2UqkOOoqKLy64Qdsx
X-Proofpoint-GUID: FIVWMvO5us2tfpHXa0ccDLiGgu9iRYX7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_06,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=935 spamscore=0 lowpriorityscore=0 priorityscore=1501
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
 drivers/i2c/busses/Kconfig | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 25eb4e8fd22f..6c0b9ca25e32 100644
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
 	select P2SB if X86
 	select CHECK_SIGNATURE if X86 && DMI
 	select I2C_SMBUS
@@ -164,7 +164,7 @@ config I2C_I801
 
 config I2C_ISCH
 	tristate "Intel SCH SMBus 1.0"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	select LPC_SCH
 	help
 	  Say Y here if you want to use SMBus controller on the Intel SCH
@@ -185,7 +185,7 @@ config I2C_ISMT
 
 config I2C_PIIX4
 	tristate "Intel PIIX4 and compatible (ATI/AMD/Serverworks/Broadcom/SMSC)"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  If you say yes to this option, support will be included for the Intel
 	  PIIX4 family of mainboard I2C interfaces.  Specifically, the following
@@ -231,7 +231,7 @@ config I2C_CHT_WC
 
 config I2C_NFORCE2
 	tristate "Nvidia nForce2, nForce3 and nForce4"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  If you say yes to this option, support will be included for the Nvidia
 	  nForce2, nForce3 and nForce4 families of mainboard I2C interfaces.
@@ -264,7 +264,7 @@ config I2C_NVIDIA_GPU
 
 config I2C_SIS5595
 	tristate "SiS 5595"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  If you say yes to this option, support will be included for the
 	  SiS5595 SMBus (a subset of I2C) interface.
@@ -274,7 +274,7 @@ config I2C_SIS5595
 
 config I2C_SIS630
 	tristate "SiS 630/730/964"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  If you say yes to this option, support will be included for the
 	  SiS630, SiS730 and SiS964 SMBus (a subset of I2C) interface.
@@ -284,7 +284,7 @@ config I2C_SIS630
 
 config I2C_SIS96X
 	tristate "SiS 96x"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  If you say yes to this option, support will be included for the SiS
 	  96x SMBus (a subset of I2C) interfaces.  Specifically, the following
@@ -302,7 +302,7 @@ config I2C_SIS96X
 
 config I2C_VIA
 	tristate "VIA VT82C586B"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	select I2C_ALGOBIT
 	help
 	  If you say yes to this option, support will be included for the VIA
@@ -313,7 +313,7 @@ config I2C_VIA
 
 config I2C_VIAPRO
 	tristate "VIA VT82C596/82C686/82xx and CX700/VX8xx/VX900"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  If you say yes to this option, support will be included for the VIA
 	  VT82C596 and later SMBus interface.  Specifically, the following
@@ -881,6 +881,7 @@ config I2C_NPCM
 
 config I2C_OCORES
 	tristate "OpenCores I2C Controller"
+	depends on HAS_IOPORT
 	help
 	  If you say yes to this option, support will be included for the
 	  OpenCores I2C controller. For details see
@@ -1274,6 +1275,7 @@ config I2C_CP2615
 config I2C_PARPORT
 	tristate "Parallel port adapter"
 	depends on PARPORT
+	depends on HAS_IOPORT
 	select I2C_ALGOBIT
 	select I2C_SMBUS
 	help
@@ -1382,6 +1384,7 @@ config I2C_ICY
 config I2C_MLXCPLD
 	tristate "Mellanox I2C driver"
 	depends on X86_64 || COMPILE_TEST
+	depends on HAS_IOPORT
 	help
 	  This exposes the Mellanox platform I2C busses to the linux I2C layer
 	  for X86 based systems.
-- 
2.37.2

