Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D008C4801CD
	for <lists+linux-arch@lfdr.de>; Mon, 27 Dec 2021 17:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhL0QoL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Dec 2021 11:44:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16688 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229913AbhL0QoE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Dec 2021 11:44:04 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BRGC13V009562;
        Mon, 27 Dec 2021 16:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Z3/8hqv5BMhxb2ibtEPGMHxuZYW05s1+Gk1GmR1PS9Q=;
 b=JqL3UCfFi1IPAB+v3rFVofST7KhLH0PFqJ5iD9e3naPHuG9p4w+fBEbuvILkJ2i53bmH
 8GH1qNrIZapF2fNulAidLvBZzKGJBlv+HyibKwnaBV3i5xLbaP6MOFt1RoZjM4bJedNu
 WfWmarwgcFNuilm425QCQHPbKZ5lOsuSef7RqiGZXLy5hTmF8t/7NM0dYHWUwv6LI8ni
 VzH9OLBe54NBqgssJkAprLGT8aZOHyEIpfFOUWrjDvcmE1IKmSd/GmJ11/ruy1R06alj
 ghygVi2jwwcQ/dBDNQUfBzrHAeB9R+TbFdwCXLXKanZnxFV7NKZwqY47qP3bI5kqeELE WQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d7gsx8fwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:35 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BRGWolZ023763;
        Mon, 27 Dec 2021 16:43:34 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d7gsx8fw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:34 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BRGbw5A008367;
        Mon, 27 Dec 2021 16:43:32 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3d5txakf88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:31 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BRGZ2eh43712798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Dec 2021 16:35:02 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FE84A405C;
        Mon, 27 Dec 2021 16:43:29 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0355A4060;
        Mon, 27 Dec 2021 16:43:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Dec 2021 16:43:28 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org
Subject: [RFC 04/32] parport: PC style parport depends on HAS_IOPORT
Date:   Mon, 27 Dec 2021 17:42:49 +0100
Message-Id: <20211227164317.4146918-5-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227164317.4146918-1-schnelle@linux.ibm.com>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: b6qPpoMQJa6M-0_Wi2s762zDmMvMUct2
X-Proofpoint-GUID: o0AOx4CujWBwnH_pmx3I7J1IstMPO0H9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-27_08,2021-12-24_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=896 mlxscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112270080
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
not being declared. As PC style parport uses these functions we need to
handle this dependency for HAS_IOPORT.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/parport/Kconfig | 2 +-
 include/linux/parport.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/parport/Kconfig b/drivers/parport/Kconfig
index e78a9f0302c7..d824f3069302 100644
--- a/drivers/parport/Kconfig
+++ b/drivers/parport/Kconfig
@@ -14,7 +14,6 @@ config ARCH_MIGHT_HAVE_PC_PARPORT
 
 menuconfig PARPORT
 	tristate "Parallel port support"
-	depends on HAS_IOMEM
 	help
 	  If you want to use devices connected to your machine's parallel port
 	  (the connector at the computer with 25 holes), e.g. printer, ZIP
@@ -43,6 +42,7 @@ if PARPORT
 config PARPORT_PC
 	tristate "PC-style hardware"
 	depends on ARCH_MIGHT_HAVE_PC_PARPORT
+	depends on HAS_IOPORT
 	help
 	  You should say Y here if you have a PC-style parallel port. All
 	  IBM PC compatible computers and some Alphas have PC-style
diff --git a/include/linux/parport.h b/include/linux/parport.h
index 1c16ffb8b908..04ca5dc597a1 100644
--- a/include/linux/parport.h
+++ b/include/linux/parport.h
@@ -519,7 +519,7 @@ extern int parport_device_proc_register(struct pardevice *device);
 extern int parport_device_proc_unregister(struct pardevice *device);
 
 /* If PC hardware is the only type supported, we can optimise a bit.  */
-#if !defined(CONFIG_PARPORT_NOT_PC)
+#if !defined(CONFIG_PARPORT_NOT_PC) && defined(CONFIG_PARPORT_PC)
 
 #include <linux/parport_pc.h>
 #define parport_write_data(p,x)            parport_pc_write_data(p,x)
-- 
2.32.0

