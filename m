Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F278F514B25
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 15:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376422AbiD2Nyp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 09:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376341AbiD2Nym (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 09:54:42 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF8D56C0D;
        Fri, 29 Apr 2022 06:51:23 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TDgrdB008243;
        Fri, 29 Apr 2022 13:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=srAUM4IMyMsDpW0kX1ewsEZOtyjhGc3DKwV8lhC8b4s=;
 b=D8sZXQuQTKTyU4ZB4SIcFzclPQKI0izvqblcjjLkM38F2T+XvKiCOhe6iE/gdj26h1VQ
 KnMlmJ4Ck8VQCn8iqpfEuU4I29WfsOMlapK7nbm5QTevSqbKHIUYBnQIMnGZxKvxC1id
 q2pTSb2UvpA2/qDdN+PQQeiB+aAyJ6lVqnfDHz3Dn7eIC2LeaKDvgyw1PI2vCVdQaG3c
 m6zdEO5FRVCteSQoOt9SoWNxAlqDpJHSDGd64VN87TO2PFlfjnwAaB9X8gXqG24qE8V7
 f24frBJrZNQ/6UaKaDWhT3IFr62i/StmwmmXdHGVcGOvSF+hX2WSyKDH2Z5rP/HsefDJ fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3frh55r5hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:19 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23TDjaRA020112;
        Fri, 29 Apr 2022 13:51:18 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3frh55r5gs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:18 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TDQvPR014336;
        Fri, 29 Apr 2022 13:51:17 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3fm93916w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:16 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TDpEC834013464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:51:14 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82ECA4C046;
        Fri, 29 Apr 2022 13:51:14 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4342F4C044;
        Fri, 29 Apr 2022 13:51:14 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 13:51:14 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 04/37] parport: PC style parport depends on HAS_IOPORT
Date:   Fri, 29 Apr 2022 15:50:05 +0200
Message-Id: <20220429135108.2781579-8-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429135108.2781579-1-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DIgQF38wFtndsq1AQ4RfP7mPhGRYgD0y
X-Proofpoint-GUID: c2bRC37DuAtwdkm5R75FBYvlGfooTy1Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_06,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0
 clxscore=1015 mlxlogscore=604 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

