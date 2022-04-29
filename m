Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797BD514BC8
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 15:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376497AbiD2N52 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 09:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376524AbiD2N4o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 09:56:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAD9CE48A;
        Fri, 29 Apr 2022 06:51:52 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TCc4e6016905;
        Fri, 29 Apr 2022 13:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bsnoYaCxcP6yUiJWmu0WIZU/5X+rJ9IzWoxXls9WFFs=;
 b=pflSrtABJWUVIxNMnch6wQF9To4KyKo7kIIY40+gcZ3dHVU5J+lc3mWVU5awVGNqS3nS
 19xLh8indDER4en+P/nSwOxIBlDzDZxqjGNiv2+JuyEA5aPSxnk4XUlXqhss8dbmcXlo
 /3cQeSuKIdsQhspwM6dIqErRlAfiBsqdZZhPLY7s5rIT4S+mHVxuK97XEPcB464sf6Zc
 wMPcqOtuIEIafSPckeClSfN1mkV/p+uXBvQtcrhdEdRB5tI0cRYg9+XJvbFlTv0awEuY
 blQgU7XQcCDbY3LsnTKE7B+vjht6n5q3zPTFAvdzMXoN8JnSqQJMglfZTt8tlxjcOMls Qw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqqtnsuq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:40 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TDS1BU025967;
        Fri, 29 Apr 2022 13:51:38 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3fm938yag9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:38 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TDpZ9X15008044
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:51:35 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B90BC4C040;
        Fri, 29 Apr 2022 13:51:35 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72E6F4C04A;
        Fri, 29 Apr 2022 13:51:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 13:51:35 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        chrome-platform@lists.linux.dev (open list:CHROME HARDWARE PLATFORM
        SUPPORT)
Subject: [RFC v2 26/39] platform: add HAS_IOPORT dependencies
Date:   Fri, 29 Apr 2022 15:50:43 +0200
Message-Id: <20220429135108.2781579-46-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429135108.2781579-1-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EA4jbLDcCsqf0lwrM3l98xAtoxb0RX3a
X-Proofpoint-GUID: EA4jbLDcCsqf0lwrM3l98xAtoxb0RX3a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_06,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 mlxlogscore=706
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
not being declared. We thus need to add HAS_IOPORT as dependency for
those drivers using them.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/platform/chrome/Kconfig          | 1 +
 drivers/platform/chrome/wilco_ec/Kconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 75e93efd669f..51f895663e95 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -111,6 +111,7 @@ config CROS_EC_SPI
 config CROS_EC_LPC
 	tristate "ChromeOS Embedded Controller (LPC)"
 	depends on CROS_EC && ACPI && (X86 || COMPILE_TEST)
+	depends on HAS_IOPORT
 	help
 	  If you say Y here, you get support for talking to the ChromeOS EC
 	  over an LPC bus, including the LPC Microchip EC (MEC) variant.
diff --git a/drivers/platform/chrome/wilco_ec/Kconfig b/drivers/platform/chrome/wilco_ec/Kconfig
index 49e8530ca0ac..d1648fb099ac 100644
--- a/drivers/platform/chrome/wilco_ec/Kconfig
+++ b/drivers/platform/chrome/wilco_ec/Kconfig
@@ -3,6 +3,7 @@ config WILCO_EC
 	tristate "ChromeOS Wilco Embedded Controller"
 	depends on X86 || COMPILE_TEST
 	depends on ACPI && CROS_EC_LPC && LEDS_CLASS
+	depends on HAS_IOPORT
 	help
 	  If you say Y here, you get support for talking to the ChromeOS
 	  Wilco EC over an eSPI bus. This uses a simple byte-level protocol
-- 
2.32.0

