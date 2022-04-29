Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3372D514BBB
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 15:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344906AbiD2N5W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 09:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376526AbiD2N4o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 09:56:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80F5CE64E;
        Fri, 29 Apr 2022 06:51:54 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TDAZGF015538;
        Fri, 29 Apr 2022 13:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6NbFTexOl7ClvTrw4pFG4DH0FFcmFlvp6OHedfDP5DE=;
 b=cOt+MFtij8pRo5PvCWdE4rYK+I33frC5aRZz+czVbmOZAIfjeFU7DYkYEsy8rITuBF/e
 nemcWbfJIirElGfiORBeRbcqKUYhRjAhtN8OPayRpFOhxhv4HIZAWKPrL6SL+5x9QADZ
 /IINpbXom/WS/fGnZ1LJ32EtfaidGU6MqWBAmlDPgtnyV7CjqrlmJdtIvizsbziU+BAE
 CWZSd+ZXNemwY8kzCkagTzhkeJVxOlMea7/kjrHz7O3WOVgiXIwT84nY87Pm27tfnuTK
 dqLI44z4Te8ytgZnZavfl78+YlKfiVM7Fj0ujrQh1CzLxtPC78vFHzqB6QJt5fg8QhC4 SQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqtdnd8gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:50 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TDQpFp021544;
        Fri, 29 Apr 2022 13:51:47 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3fm93917rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:47 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TDpsgO25035186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:51:54 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8E554C046;
        Fri, 29 Apr 2022 13:51:45 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 639BB4C044;
        Fri, 29 Apr 2022 13:51:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 13:51:45 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS)
Subject: [RFC v2 34/39] tty: serial: add HAS_IOPORT dependencies
Date:   Fri, 29 Apr 2022 15:51:00 +0200
Message-Id: <20220429135108.2781579-63-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429135108.2781579-1-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rARuvNBnrNaES-dqktazY81HpsuTRU8l
X-Proofpoint-ORIG-GUID: rARuvNBnrNaES-dqktazY81HpsuTRU8l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_06,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 phishscore=0 suspectscore=0
 mlxlogscore=983 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
 drivers/tty/Kconfig             | 2 +-
 drivers/tty/serial/8250/Kconfig | 2 +-
 drivers/tty/serial/Kconfig      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index cc30ff93e2e4..e31cbd88f5a0 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -203,7 +203,7 @@ config MOXA_INTELLIO
 
 config MOXA_SMARTIO
 	tristate "Moxa SmartIO support v. 2.0"
-	depends on SERIAL_NONSTANDARD && PCI
+	depends on SERIAL_NONSTANDARD && PCI && HAS_IOPORT
 	help
 	  Say Y here if you have a Moxa SmartIO multiport serial card and/or
 	  want to help develop a new version of this driver.
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index cd93ea6eed65..e216bf745e78 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -6,7 +6,7 @@
 
 config SERIAL_8250
 	tristate "8250/16550 and compatible serial support"
-	depends on !S390
+	depends on HAS_IOPORT
 	select SERIAL_CORE
 	select SERIAL_MCTRL_GPIO if GPIOLIB
 	help
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 6949e883ffab..32c946adb023 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -909,7 +909,7 @@ config SERIAL_VR41XX_CONSOLE
 
 config SERIAL_JSM
 	tristate "Digi International NEO and Classic PCI Support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	select SERIAL_CORE
 	help
 	  This is a driver for Digi International's Neo and Classic series
-- 
2.32.0

