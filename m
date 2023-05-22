Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818C970BA6E
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 12:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjEVKvV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 06:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbjEVKvQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 06:51:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F4CDC;
        Mon, 22 May 2023 03:51:14 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MA6Hbj001212;
        Mon, 22 May 2023 10:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6CrHbRbZwmE695h1/9xPXBODIudaFq5zB4tBHplFMOU=;
 b=Zc0ZTnXqlOrsUbAx9iAFZXiLKqYQmS6D3onVlY0QzWj88uOAoNBE1x6g/LnF8evF2RJg
 1nmZdAL9K+sE3/cmT0PzQtGxgtKX8v7CP0zQJMr7++Qpq1gDN/YMZXlGSa6/44ami+0z
 IktbsxjTsrQOLm2bz2+WtfxDzKYadJzY9fgZWREK0qetDHiZoEFCEp9+Bn1ZsnZ6kC8K
 yrgLeeDiRGwJHXybpdJ6dS7Cq9XO0bV+JbI72GmR94jSon0xxln38SxUYS+xc8zON5o2
 70z8xV7wuTXq+mLsF8Kq2OCJF26n97hwsEDNT9ClIxlA/AXJRtDgqQnPZVxnJ2JaXoqa 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qqfak2psu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:51:00 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34MA8oV1010897;
        Mon, 22 May 2023 10:50:59 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qqfak2pru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:50:59 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34M3HmDa010277;
        Mon, 22 May 2023 10:50:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qppdk0w94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:50:56 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34MAosEG59310516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 10:50:54 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A7F22005A;
        Mon, 22 May 2023 10:50:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDDC520043;
        Mon, 22 May 2023 10:50:53 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 22 May 2023 10:50:53 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
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
        linux-integrity@vger.kernel.org
Subject: [PATCH v5 05/44] char: tpm: handle HAS_IOPORT dependencies
Date:   Mon, 22 May 2023 12:50:10 +0200
Message-Id: <20230522105049.1467313-6-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522105049.1467313-1-schnelle@linux.ibm.com>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kYOYTHdoIsP1ozXawvi0SoHi7nj3U6BM
X-Proofpoint-GUID: NYXc3KokLHm36QRqFuQJZOuIpCzWiHaX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_06,2023-05-22_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 mlxlogscore=930 spamscore=0 adultscore=0
 mlxscore=0 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0
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
not being declared. We thus need to add this dependency and ifdef
sections of code using inb()/outb() as alternative access methods.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/char/tpm/Kconfig        |  1 +
 drivers/char/tpm/tpm_infineon.c | 16 ++++++++++++----
 drivers/char/tpm/tpm_tis_core.c | 19 ++++++++-----------
 3 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 927088b2c3d3..418c9ed59ffd 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -149,6 +149,7 @@ config TCG_NSC
 config TCG_ATMEL
 	tristate "Atmel TPM Interface"
 	depends on PPC64 || HAS_IOPORT_MAP
+	depends on HAS_IOPORT
 	help
 	  If you have a TPM security chip from Atmel say Yes and it 
 	  will be accessible from within Linux.  To compile this driver 
diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
index 9c924a1440a9..99c6e565ec8d 100644
--- a/drivers/char/tpm/tpm_infineon.c
+++ b/drivers/char/tpm/tpm_infineon.c
@@ -26,7 +26,9 @@
 #define	TPM_MAX_TRIES		5000
 #define	TPM_INFINEON_DEV_VEN_VALUE	0x15D1
 
+#ifdef CONFIG_HAS_IOPORT
 #define TPM_INF_IO_PORT		0x0
+#endif
 #define TPM_INF_IO_MEM		0x1
 
 #define TPM_INF_ADDR		0x0
@@ -51,34 +53,40 @@ static struct tpm_inf_dev tpm_dev;
 
 static inline void tpm_data_out(unsigned char data, unsigned char offset)
 {
+#ifdef CONFIG_HAS_IOPORT
 	if (tpm_dev.iotype == TPM_INF_IO_PORT)
 		outb(data, tpm_dev.data_regs + offset);
 	else
+#endif
 		writeb(data, tpm_dev.mem_base + tpm_dev.data_regs + offset);
 }
 
 static inline unsigned char tpm_data_in(unsigned char offset)
 {
+#ifdef CONFIG_HAS_IOPORT
 	if (tpm_dev.iotype == TPM_INF_IO_PORT)
 		return inb(tpm_dev.data_regs + offset);
-	else
-		return readb(tpm_dev.mem_base + tpm_dev.data_regs + offset);
+#endif
+	return readb(tpm_dev.mem_base + tpm_dev.data_regs + offset);
 }
 
 static inline void tpm_config_out(unsigned char data, unsigned char offset)
 {
+#ifdef CONFIG_HAS_IOPORT
 	if (tpm_dev.iotype == TPM_INF_IO_PORT)
 		outb(data, tpm_dev.config_port + offset);
 	else
+#endif
 		writeb(data, tpm_dev.mem_base + tpm_dev.index_off + offset);
 }
 
 static inline unsigned char tpm_config_in(unsigned char offset)
 {
+#ifdef CONFIG_HAS_IOPORT
 	if (tpm_dev.iotype == TPM_INF_IO_PORT)
 		return inb(tpm_dev.config_port + offset);
-	else
-		return readb(tpm_dev.mem_base + tpm_dev.index_off + offset);
+#endif
+	return readb(tpm_dev.mem_base + tpm_dev.index_off + offset);
 }
 
 /* TPM header definitions */
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 558144fa707a..0ee5a83e35a8 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -954,11 +954,6 @@ static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value)
 		clkrun_val &= ~LPC_CLKRUN_EN;
 		iowrite32(clkrun_val, data->ilb_base_addr + LPC_CNTRL_OFFSET);
 
-		/*
-		 * Write any random value on port 0x80 which is on LPC, to make
-		 * sure LPC clock is running before sending any TPM command.
-		 */
-		outb(0xCC, 0x80);
 	} else {
 		data->clkrun_enabled--;
 		if (data->clkrun_enabled)
@@ -969,13 +964,15 @@ static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value)
 		/* Enable LPC CLKRUN# */
 		clkrun_val |= LPC_CLKRUN_EN;
 		iowrite32(clkrun_val, data->ilb_base_addr + LPC_CNTRL_OFFSET);
-
-		/*
-		 * Write any random value on port 0x80 which is on LPC, to make
-		 * sure LPC clock is running before sending any TPM command.
-		 */
-		outb(0xCC, 0x80);
 	}
+
+#ifdef CONFIG_HAS_IOPORT
+	/*
+	 * Write any random value on port 0x80 which is on LPC, to make
+	 * sure LPC clock is running before sending any TPM command.
+	 */
+	outb(0xCC, 0x80);
+#endif
 }
 
 static const struct tpm_class_ops tpm_tis = {
-- 
2.39.2

