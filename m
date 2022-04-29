Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7653E514B5E
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 15:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376628AbiD2Nzv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 09:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376515AbiD2NzQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 09:55:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A770C5DA04;
        Fri, 29 Apr 2022 06:51:33 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TCc4dv016905;
        Fri, 29 Apr 2022 13:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0Xc8cWyJ2NjLttXNIONLG4ddbwBws1F37EFqTTA4s0k=;
 b=eWZic8B6/s9qeZKdySJQhfQ7gkYU2G1oBfSW7a0s9YiUKNApT8VrgD99NL8lj0yZDerf
 e7rPahImlv4oclMHSVcCaDmj3Gr9d3Q7fKBfFYHvj3h+kI6ps9ZnG/qXx083q+gb+caL
 Vi6adne4/VgjSulB+5h2sypOe1T12jDVNq/IzoPNwfSHYIv03CWouYJDpRHU0dOHXywb
 1/9ks1Qy9Ttb3ZWk6Oi4OoQMd7H+jg0ZffQo8yBkNeuDQQgfz/OOh0l7Nnq5xlvTyRem
 No0At5X2MadI5GU867KlC0/wt5V+MIrvJPs5w1s+EluUKLBWc4wZhQacm7ye9TnLEeDA cQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqqtnsudk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:18 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23TDgAv5023460;
        Fri, 29 Apr 2022 13:51:18 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqqtnsucv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:18 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TDQknd021533;
        Fri, 29 Apr 2022 13:51:16 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3fm93917qq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:16 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TDpEet34013462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:51:14 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EB9E4C044;
        Fri, 29 Apr 2022 13:51:14 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB0A74C04A;
        Fri, 29 Apr 2022 13:51:13 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 13:51:13 +0000 (GMT)
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
Subject: [RFC v2 04/39] char: impi, tpm: depend on HAS_IOPORT
Date:   Fri, 29 Apr 2022 15:50:04 +0200
Message-Id: <20220429135108.2781579-7-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429135108.2781579-1-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AZRYnlRzTQKDSjgjO_HSkX3FwzSks3wM
X-Proofpoint-GUID: iGMO7oNA9IIubfBNxVJGwmk2j693ADIn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_06,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 clxscore=1011 mlxlogscore=898
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204290078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

