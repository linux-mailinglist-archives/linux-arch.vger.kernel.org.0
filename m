Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87C6514B9A
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 15:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350390AbiD2N4y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 09:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376649AbiD2Nzx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 09:55:53 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D591FCC534;
        Fri, 29 Apr 2022 06:51:47 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TCS9eb024351;
        Fri, 29 Apr 2022 13:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0FxTHP9zTza2G3yX6aUW2VY/cOrwQLSuVkMgsjWT5IA=;
 b=TNuM1cMmzaVL7AwsoyUN5SL1wVZsj1WSFib976rSDwOKEN4GjUN+kW0AW0PDZTmFnz1j
 qsPNOY+wwWEbHjC5aabBDsA+Bjb0vPQXoWYEMR+tlDuKXxUpn+gbjCx5cvkNA7fl2KlQ
 iDu+fGstMHB5hhJAB+N2+ApIVfP4pKF5r+oSnttxbalsxGBGjdg1Pcw3sG9EKkkzHbmU
 VAtNjsgR3BHtXXUuFeWqzUFO+tJSYrxohJv+BGV7KEULa2LJiCJah5oDl/QT3bDo+dd0
 E/HmtOm7849zN25KI0TJIrxp49IajEJRceefkgBPDXdxvK8vou2EDJmpJR8s+qwOsq5d OQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqnke41v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:39 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TDQr87014269;
        Fri, 29 Apr 2022 13:51:37 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3fm93916wq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:36 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TDpYXE49414586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:51:34 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC1644C044;
        Fri, 29 Apr 2022 13:51:34 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6305C4C040;
        Fri, 29 Apr 2022 13:51:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 13:51:34 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Arnd Bergmann <arnd@kernel.org>
Subject: [RFC v2 25/39] pcmcia: add HAS_IOPORT dependencies
Date:   Fri, 29 Apr 2022 15:50:41 +0200
Message-Id: <20220429135108.2781579-44-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429135108.2781579-1-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HNveZLpqJHOon5PKrP71zI-OgP6oGWLL
X-Proofpoint-GUID: HNveZLpqJHOon5PKrP71zI-OgP6oGWLL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_06,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=544 bulkscore=0
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
not being declared. PCMCIA devices are either LEGACY_PCI devices
which implies HAS_IOPORT or require HAS_IOPORT.

Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>
Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/pcmcia/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index 2ce261cfff8e..32b5cd324c58 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -5,7 +5,7 @@
 
 menuconfig PCCARD
 	tristate "PCCard (PCMCIA/CardBus) support"
-	depends on !UML
+	depends on HAS_IOPORT
 	help
 	  Say Y here if you want to attach PCMCIA- or PC-cards to your Linux
 	  computer.  These are credit-card size devices such as network cards,
-- 
2.32.0

