Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F19514B7A
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 15:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376701AbiD2N4Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 09:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376601AbiD2Nzu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 09:55:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A66658E79;
        Fri, 29 Apr 2022 06:51:39 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TDGutd024356;
        Fri, 29 Apr 2022 13:51:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0Xc8cWyJ2NjLttXNIONLG4ddbwBws1F37EFqTTA4s0k=;
 b=Ki4wbaZfZDA9S2+r/SRui8LKfaa4pjodqtUoo3CWQhvBMZQjss2biX4xHryjRzummDRR
 jHWqI5o9Pu6SQ2JVHeiyAyq3AriDh6xfTyAT92idop4575ml6x/vIwkY+05/3qKMyYr2
 uUPLa6EHLm32VmVjAibMdH7awJ+HGQTGDZjaTM5TR5PDywMI0Nqf1nTgtT5D12p3mSZD
 3GunwTi8rkO38cKhSzlpYwDbfz3GxoDPpT08/S4qq1FTLX1v11IBlf4AWf6fqhHS6jBr
 DqNGcFjW4nJf6UzlWmMoZZ18R9QUBgC9J1M08wax3iVIL7x6gVvY7fx/YSGI+F3IXbGm 1w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqnke41mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:20 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23TDaAQ2006576;
        Fri, 29 Apr 2022 13:51:20 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqnke41kx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:20 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TDQr84014269;
        Fri, 29 Apr 2022 13:51:17 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3fm93916w2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:17 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TDpFYu56230218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:51:15 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 584124C044;
        Fri, 29 Apr 2022 13:51:15 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00C344C040;
        Fri, 29 Apr 2022 13:51:15 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 13:51:14 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Corey Minyard <minyard@acm.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        openipmi-developer@lists.sourceforge.net (moderated list:IPMI SUBSYSTEM),
        linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER)
Subject: [PATCH 05/37] char: impi, tpm: depend on HAS_IOPORT
Date:   Fri, 29 Apr 2022 15:50:06 +0200
Message-Id: <20220429135108.2781579-9-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429135108.2781579-1-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: E8Wf-DC7p0NcyjT1ESvacYVeQy2LZdVR
X-Proofpoint-GUID: X0AekNANuUUm7_m-vq8k2Q84Qdz9EvRc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_06,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=986 bulkscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
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
not being declared. We thus need to add this dependency and ifdef
sections of code using inb()/outb() as alternative access methods.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/char/Kconfig             |  3 ++-
 drivers/char/ipmi/Makefile       | 11 ++++-------
 drivers/char/ipmi/ipmi_si_intf.c |  3 ++-
 drivers/char/ipmi/ipmi_si_pci.c  |  3 +++
 drivers/char/tpm/Kconfig         |  1 +
 drivers/char/tpm/tpm_infineon.c  | 14 ++++++++++----
 drivers/char/tpm/tpm_tis_core.c  | 19 ++++++++-----------
 7 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 55f48375e3fe..463b82935e78 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -33,6 +33,7 @@ config TTY_PRINTK_LEVEL
 config PRINTER
 	tristate "Parallel printer support"
 	depends on PARPORT
+	depends on HAS_IOPORT
 	help
 	  If you intend to attach a printer to the parallel port of your Linux
 	  box (as opposed to using a serial printer; if the connector at the
@@ -346,7 +347,7 @@ config NVRAM
 
 config DEVPORT
 	bool "/dev/port character device"
-	depends on ISA || PCI
+	depends on HAS_IOPORT
 	default y
 	help
 	  Say Y here if you want to support the /dev/port device. The /dev/port
diff --git a/drivers/char/ipmi/Makefile b/drivers/char/ipmi/Makefile
index 7ce790efad92..439bed4feb3a 100644
--- a/drivers/char/ipmi/Makefile
+++ b/drivers/char/ipmi/Makefile
@@ -5,13 +5,10 @@
 
 ipmi_si-y := ipmi_si_intf.o ipmi_kcs_sm.o ipmi_smic_sm.o ipmi_bt_sm.o \
 	ipmi_si_hotmod.o ipmi_si_hardcode.o ipmi_si_platform.o \
-	ipmi_si_port_io.o ipmi_si_mem_io.o
-ifdef CONFIG_PCI
-ipmi_si-y += ipmi_si_pci.o
-endif
-ifdef CONFIG_PARISC
-ipmi_si-y += ipmi_si_parisc.o
-endif
+	ipmi_si_mem_io.o
+ipmi_si-$(CONFIG_HAS_IOPORT) += ipmi_si_port_io.o
+ipmi_si-$(CONFIG_PCI) += ipmi_si_pci.o
+ipmi_si-$(CONFIG_PARISC) += ipmi_si_parisc.o
 
 obj-$(CONFIG_IPMI_HANDLER) += ipmi_msghandler.o
 obj-$(CONFIG_IPMI_DEVICE_INTERFACE) += ipmi_devintf.o
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 64dedb3ef8ec..e8094b4007de 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -1881,7 +1881,8 @@ int ipmi_si_add_smi(struct si_sm_io *io)
 	}
 
 	if (!io->io_setup) {
-		if (io->addr_space == IPMI_IO_ADDR_SPACE) {
+		if (IS_ENABLED(CONFIG_HAS_IOPORT) &&
+		    io->addr_space == IPMI_IO_ADDR_SPACE) {
 			io->io_setup = ipmi_si_port_setup;
 		} else if (io->addr_space == IPMI_MEM_ADDR_SPACE) {
 			io->io_setup = ipmi_si_mem_setup;
diff --git a/drivers/char/ipmi/ipmi_si_pci.c b/drivers/char/ipmi/ipmi_si_pci.c
index 74fa2055868b..b83d55685b22 100644
--- a/drivers/char/ipmi/ipmi_si_pci.c
+++ b/drivers/char/ipmi/ipmi_si_pci.c
@@ -97,6 +97,9 @@ static int ipmi_pci_probe(struct pci_dev *pdev,
 	}
 
 	if (pci_resource_flags(pdev, 0) & IORESOURCE_IO) {
+		if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+			return -ENXIO;
+
 		io.addr_space = IPMI_IO_ADDR_SPACE;
 		io.io_setup = ipmi_si_port_setup;
 	} else {
diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 4a5516406c22..4bc52ed08015 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -137,6 +137,7 @@ config TCG_NSC
 config TCG_ATMEL
 	tristate "Atmel TPM Interface"
 	depends on PPC64 || HAS_IOPORT_MAP
+	depends on HAS_IOPORT
 	help
 	  If you have a TPM security chip from Atmel say Yes and it 
 	  will be accessible from within Linux.  To compile this driver 
diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
index 9c924a1440a9..2d2ae37153ba 100644
--- a/drivers/char/tpm/tpm_infineon.c
+++ b/drivers/char/tpm/tpm_infineon.c
@@ -51,34 +51,40 @@ static struct tpm_inf_dev tpm_dev;
 
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
index dc56b976d816..1efb58dc1b41 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -879,11 +879,6 @@ static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value)
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
@@ -894,13 +889,15 @@ static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value)
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
2.32.0

