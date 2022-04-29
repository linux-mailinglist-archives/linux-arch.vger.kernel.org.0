Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B58514B7E
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 15:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376721AbiD2N4W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 09:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376606AbiD2Nzu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 09:55:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5566D4C6;
        Fri, 29 Apr 2022 06:51:41 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TBJmhc006372;
        Fri, 29 Apr 2022 13:51:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=srAUM4IMyMsDpW0kX1ewsEZOtyjhGc3DKwV8lhC8b4s=;
 b=NIn2+HQqeyB2QMnD1on47wW8YnTEKgMPCmrYSYQ1QWWZ426vdQS906CsOW2hyDjOtpYP
 7M5yvCgvH3n0tcIaEeGfp2oma6Ib15vAMU9+R0PtMM0NXrKPBhDkv7+i+FyqbCQ8U/Ws
 cSWN+EJKC5zpZsC4Up052ZAeYASdK4oOm5HAewdR4th522oI02RrFhyxshbUJ0MGgdrO
 Kz3LKODkRguyI1QjDw1URtrm5tjZCHIBDEv0vAkrRPTqgxPLKKBEdjgBB8E+bVKt62lI
 Uq7jaIU+OQVgbzx9fcpvhTAjYG2APbh9YO8HraKnPb7drh0cyzXGBB0BossXIe5LaVYq Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqvaq277d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:37 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23TDobWR021787;
        Fri, 29 Apr 2022 13:51:36 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqvaq275u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:36 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TDRpRZ027483;
        Fri, 29 Apr 2022 13:51:34 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3fm938yan5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:34 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TDpehM25035160
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:51:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB6604C044;
        Fri, 29 Apr 2022 13:51:31 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C22B4C040;
        Fri, 29 Apr 2022 13:51:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 13:51:31 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [RFC v2 22/39] parport: PC style parport depends on HAS_IOPORT
Date:   Fri, 29 Apr 2022 15:50:35 +0200
Message-Id: <20220429135108.2781579-38-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429135108.2781579-1-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: h06ejO1rK6o3xC1aC3t94dNwv-Cqumh9
X-Proofpoint-GUID: FCQwacvr7tfYOSvxeiFSb8hRPGoPSz9c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_06,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 mlxlogscore=516 clxscore=1015
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
not being declared. As PC style parport uses these functions we need to
handle this dependency.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/parport/Kconfig | 4 ++--
 include/linux/parport.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/parport/Kconfig b/drivers/parport/Kconfig
index 68a4fe4cd60b..31c8ec2df449 100644
--- a/drivers/parport/Kconfig
+++ b/drivers/parport/Kconfig
@@ -14,7 +14,6 @@ config ARCH_MIGHT_HAVE_PC_PARPORT
 
 menuconfig PARPORT
 	tristate "Parallel port support"
-	depends on HAS_IOMEM
 	help
 	  If you want to use devices connected to your machine's parallel port
 	  (the connector at the computer with 25 holes), e.g. printer, ZIP
@@ -42,7 +41,8 @@ if PARPORT
 
 config PARPORT_PC
 	tristate "PC-style hardware"
-	depends on ARCH_MIGHT_HAVE_PC_PARPORT || (PCI && !S390)
+	depends on ARCH_MIGHT_HAVE_PC_PARPORT
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

