Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA66514B8D
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 15:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376620AbiD2N4b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 09:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376626AbiD2Nzv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 09:55:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19DA6E565;
        Fri, 29 Apr 2022 06:51:43 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TDAab1015911;
        Fri, 29 Apr 2022 13:51:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bsnoYaCxcP6yUiJWmu0WIZU/5X+rJ9IzWoxXls9WFFs=;
 b=rU2YH484KzyNdxXrJITxrxFIe8kLx00bN0BSIT0ob6FnkOtbblTTeUcGQD2I/E3RvoCZ
 fTWNLwG7saqr61RKTKAmbwnXgU0NI2Q+Lwy5bzCOyfFN2MrbH1y/R2cPPB9ThlPqbVkb
 H5nQ5AJ8YFgBpSzEywgZW/qAcpZ4Yvr2gQ/VM2EEQTUsnTAP6j+I8JuJJ95irtSy9nRd
 HF1feOkNig9XWEa0UUQGqLUCC4vf0TAAr6dO9DQ7iap6lEcSd1fVIpfO9Ab/AnbRH2tK
 3+uXLfGGb4rKMyQjaz425vypO39TvSJJy4Uq5Pjav6X5BsLmggvWRa/UafgobsaYyJM9 kw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqtdnd8ay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:36 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TDQlvn014243;
        Fri, 29 Apr 2022 13:51:34 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3fm93916wp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:34 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TDcNU149938796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:38:23 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50C6B4C044;
        Fri, 29 Apr 2022 13:51:32 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AFC64C040;
        Fri, 29 Apr 2022 13:51:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 13:51:31 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        chrome-platform@lists.linux.dev (open list:CHROME HARDWARE PLATFORM
        SUPPORT)
Subject: [PATCH 22/37] platform: add HAS_IOPORT dependencies
Date:   Fri, 29 Apr 2022 15:50:36 +0200
Message-Id: <20220429135108.2781579-39-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429135108.2781579-1-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: o8WtM_XB3PH4AGoTEbS1VXLb64fLX7Ku
X-Proofpoint-ORIG-GUID: o8WtM_XB3PH4AGoTEbS1VXLb64fLX7Ku
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_06,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 phishscore=0 suspectscore=0
 mlxlogscore=793 clxscore=1011 impostorscore=0 malwarescore=0 adultscore=0
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

