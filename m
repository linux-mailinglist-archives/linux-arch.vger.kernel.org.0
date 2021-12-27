Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059984801D0
	for <lists+linux-arch@lfdr.de>; Mon, 27 Dec 2021 17:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhL0QoM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Dec 2021 11:44:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41762 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229967AbhL0QoE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Dec 2021 11:44:04 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BRFfQA8021756;
        Mon, 27 Dec 2021 16:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=l8mKszTsk7HmD0sKamZFoRlnXMuFzugZKY8/iUH88Q8=;
 b=cMrrlmKjkofsNLg5ogvKqdodQoezDsEgwBHZlTs46nZWR9oWzFnN0OaANtQ7eq/bC5oi
 ZstOzgzXoz7Hf9u6/tL5ivIKMm3mef4vwT1Ynx7eH1fNJUlrJifpTzXPkmVsWrNdgQA/
 g7Px1Ybf5hun66i6ho764LI1ahIsGJlr2CY3xLawfu5irk54CRiCM23+oXDpqyXVoYbM
 q99CShu67pJT+usAfZ83r3iUfERyjufJBAoY89HntSmQ9UIS5s1XJdkmWKZS8eqxAUJd
 MLtGh6UeLjORJACAuzJ1GFbf3+uZuOiNwcte0XamuPfhfzFL7lEQU+fK0JuDgmFYJmT8 Hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d7gbns176-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:38 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BRGeYf1006547;
        Mon, 27 Dec 2021 16:43:37 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d7gbns16k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:37 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BRGc4m8005226;
        Mon, 27 Dec 2021 16:43:35 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3d5tjjbhjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:34 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BRGhW3P44761354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Dec 2021 16:43:32 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F36CA4060;
        Mon, 27 Dec 2021 16:43:32 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0607FA405F;
        Mon, 27 Dec 2021 16:43:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Dec 2021 16:43:31 +0000 (GMT)
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
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-input@vger.kernel.org
Subject: [RFC 07/32] Input: gameport: add ISA and HAS_IOPORT dependencies
Date:   Mon, 27 Dec 2021 17:42:52 +0100
Message-Id: <20211227164317.4146918-8-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227164317.4146918-1-schnelle@linux.ibm.com>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0NBAEMHOy9sP5vWXiDigEQRn9FkWRPjz
X-Proofpoint-GUID: mvw6Psa3Rs08dzdnOjxq9_dFXgALA-8Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-27_08,2021-12-24_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112270080
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
not being declared. As ISA already implies HAS_IOPORT we can simply add
this dependency and guard sections of code using inb()/outb() as
alternative access methods.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/input/gameport/Kconfig | 2 ++
 include/linux/gameport.h       | 9 +++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/input/gameport/Kconfig b/drivers/input/gameport/Kconfig
index 082280f95333..366a2723e9a0 100644
--- a/drivers/input/gameport/Kconfig
+++ b/drivers/input/gameport/Kconfig
@@ -25,6 +25,7 @@ if GAMEPORT
 
 config GAMEPORT_NS558
 	tristate "Classic ISA and PnP gameport support"
+	depends on ISA
 	help
 	  Say Y here if you have an ISA or PnP gameport.
 
@@ -35,6 +36,7 @@ config GAMEPORT_NS558
 
 config GAMEPORT_L4
 	tristate "PDPI Lightning 4 gamecard support"
+	depends on ISA
 	help
 	  Say Y here if you have a PDPI Lightning 4 gamecard.
 
diff --git a/include/linux/gameport.h b/include/linux/gameport.h
index 69081d899492..9e55ac748a86 100644
--- a/include/linux/gameport.h
+++ b/include/linux/gameport.h
@@ -167,16 +167,21 @@ static inline void gameport_trigger(struct gameport *gameport)
 {
 	if (gameport->trigger)
 		gameport->trigger(gameport);
+#ifdef CONFIG_HAS_IOPORT
 	else
 		outb(0xff, gameport->io);
+#endif
 }
 
 static inline unsigned char gameport_read(struct gameport *gameport)
 {
 	if (gameport->read)
 		return gameport->read(gameport);
-	else
-		return inb(gameport->io);
+#ifdef CONFIG_HAS_IOPORT
+	return inb(gameport->io);
+#else
+	return 0xff;
+#endif
 }
 
 static inline int gameport_cooked_read(struct gameport *gameport, int *axes, int *buttons)
-- 
2.32.0

