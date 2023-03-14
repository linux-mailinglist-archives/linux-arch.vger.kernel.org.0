Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B606B9313
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 13:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCNMPF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Mar 2023 08:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjCNMN5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 08:13:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAFA87D95;
        Tue, 14 Mar 2023 05:13:07 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32EBC0CS012219;
        Tue, 14 Mar 2023 12:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9IuY8XH/DMcYZHQa6zTDSbK2O0y13eq63tBf5zQaR5c=;
 b=mQSepm5SWZLbJqocyroksQQ0V2WKRvWZjPIniAnwgqJo1gtXWkojP6jg8VlVgv3zyZZc
 YBZ7yIgUBE4Kgj281APpaRRGItfBzGMYXVsR87VD80CLTAjOU4Dw2UlUOr76qV4RJWJ+
 Z/EcF+zA9VZHr1Aonm7dysfXgrT2P2E6A8YuXfN+Yalf0iRTh5CRwl/FPV8YXJBwtkRb
 tRCNwaXrpQqt+ahMrMqIsgFLTkEy4GGYGNKeVAfi2r/U0WFULU8m6ZqJ/iocik5w1Nok
 ipmu0oZ24TcZ48jQI/lrW3NSaTww1B5kl8oB0guHuttXjyaoRQ+i/iHu2VxxjHVMPsqN Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3paqu91kyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:40 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32EBCfcg014439;
        Tue, 14 Mar 2023 12:12:40 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3paqu91kxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:39 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32DMMrjb010864;
        Tue, 14 Mar 2023 12:12:37 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3p8h96bsgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:37 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ECCZa142533334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Mar 2023 12:12:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F23042007B;
        Tue, 14 Mar 2023 12:12:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91CD42007A;
        Tue, 14 Mar 2023 12:12:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Mar 2023 12:12:34 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
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
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH v3 17/38] misc: add HAS_IOPORT dependencies
Date:   Tue, 14 Mar 2023 13:11:55 +0100
Message-Id: <20230314121216.413434-18-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230314121216.413434-1-schnelle@linux.ibm.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PDBzqAcFUm2YBCxY-03nSL0S2eNy3DCK
X-Proofpoint-GUID: 3DRBgKX5UdRHxFKwNA4Mxsq-2NKITJVc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_04,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
 drivers/misc/altera-stapl/Makefile | 3 ++-
 drivers/misc/altera-stapl/altera.c | 6 +++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/altera-stapl/Makefile b/drivers/misc/altera-stapl/Makefile
index dd0f8189666b..90f18e7bf9b0 100644
--- a/drivers/misc/altera-stapl/Makefile
+++ b/drivers/misc/altera-stapl/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-altera-stapl-objs = altera-lpt.o altera-jtag.o altera-comp.o altera.o
+altera-stapl-y = altera-jtag.o altera-comp.o altera.o
+altera-stapl-$(CONFIG_HAS_IOPORT) += altera-lpt.o
 
 obj-$(CONFIG_ALTERA_STAPL) += altera-stapl.o
diff --git a/drivers/misc/altera-stapl/altera.c b/drivers/misc/altera-stapl/altera.c
index a58b7cb81d98..587427b73914 100644
--- a/drivers/misc/altera-stapl/altera.c
+++ b/drivers/misc/altera-stapl/altera.c
@@ -2407,6 +2407,10 @@ int altera_init(struct altera_config *config, const struct firmware *fw)
 
 	astate->config = config;
 	if (!astate->config->jtag_io) {
+		if (!IS_ENABLED(CONFIG_HAS_IOPORT)) {
+			retval = -ENODEV;
+			goto free_state;
+		}
 		dprintk("%s: using byteblaster!\n", __func__);
 		astate->config->jtag_io = netup_jtag_io_lpt;
 	}
@@ -2481,7 +2485,7 @@ int altera_init(struct altera_config *config, const struct firmware *fw)
 
 	} else if (exec_result)
 		printk(KERN_ERR "%s: error %d\n", __func__, exec_result);
-
+free_state:
 	kfree(astate);
 free_value:
 	kfree(value);
-- 
2.37.2

