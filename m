Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8B948025B
	for <lists+linux-arch@lfdr.de>; Mon, 27 Dec 2021 17:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbhL0QrE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Dec 2021 11:47:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25988 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231831AbhL0QpC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Dec 2021 11:45:02 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BREBfR0012485;
        Mon, 27 Dec 2021 16:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=72gq8KqtPufaLlGJy3p5Ui8DPnidqN8imumjA88XMwg=;
 b=rzXtc12Ni+vG+qNqNjxlDfpPdH3s6LFEFCkSKYdTwCCGXuWofXdf1le+tmzliq8g3tfl
 ADyuMa/wnyeCUe4lCHlLV4d8MUgYPXP81uoA+q8Rwug350UVa/3gZTPaHwaDEQWw3Xye
 gBql1a57ahluf+BgRBvpEfPFss/MDsEmHBbBFt/gMvS4b++3avT/57fg8ifvAs9Z/c/l
 HkKipfGuoZlP9cmB6L/xmdGfplLgGpyLa5/f5L8/cNRX8/hjI2WPqxdJmXI99bwNEfwz
 qNKQ91YbxB61T77aA7Vv+EC40qH4bFmX+079IjuQxXbacaKw80sXqu4U0Iy5tuB8FrA1 Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d7f1nar8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:37 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BRGha5q012722;
        Mon, 27 Dec 2021 16:43:36 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d7f1nar7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:36 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BRGbgCx001684;
        Mon, 27 Dec 2021 16:43:34 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3d5tx9as2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:34 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BRGhVpX31064372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Dec 2021 16:43:31 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C828A4054;
        Mon, 27 Dec 2021 16:43:31 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 095FBA4066;
        Mon, 27 Dec 2021 16:43:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Dec 2021 16:43:30 +0000 (GMT)
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
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org, speakup@linux-speakup.org
Subject: [RFC 06/32] speakup: Kconfig: add HAS_IOPORT dependencies
Date:   Mon, 27 Dec 2021 17:42:51 +0100
Message-Id: <20211227164317.4146918-7-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227164317.4146918-1-schnelle@linux.ibm.com>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TvS-qMbCiX1L0hwUDx_FvbF-GszlXFZJ
X-Proofpoint-ORIG-GUID: rBoBzUI_D22ceTGazxZUcmgEczWjlo5z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-27_08,2021-12-24_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1011 bulkscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112270080
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
not being declared. SPEAKUP_SERIALIO thus needs to depend on HAS_IOPORT.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/accessibility/speakup/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accessibility/speakup/Kconfig b/drivers/accessibility/speakup/Kconfig
index 07ecbbde0384..e84fb617acc4 100644
--- a/drivers/accessibility/speakup/Kconfig
+++ b/drivers/accessibility/speakup/Kconfig
@@ -46,6 +46,7 @@ if SPEAKUP
 config SPEAKUP_SERIALIO
 	def_bool y
 	depends on ISA || COMPILE_TEST
+	depends on HAS_IOPORT
 
 config SPEAKUP_SYNTH_ACNTSA
 	tristate "Accent SA synthesizer support"
-- 
2.32.0

