Return-Path: <linux-arch+bounces-7757-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66440992A76
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 13:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB9CCB22BCC
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 11:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749431D2B02;
	Mon,  7 Oct 2024 11:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Cvsd4E5x"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043FC1D279B;
	Mon,  7 Oct 2024 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728301326; cv=none; b=nbKbyEgyy5E3kaHQFVfEZDxqc3+9G9fRRF3TftT+8o5SaBO0TkXaKZL1mgEuZz5Ixjf9lHDP/Ny0JfNG9r1ZtfLGAP1GsgLisrEFIkCzvaOeDsPrqXFYc+ngFgbtUnlHLIJ0ArKoj6Ka+H8zBXJLc5bPaQOu9o/uEdEs7a3Ce+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728301326; c=relaxed/simple;
	bh=wqO06g/GtvVUtLH7zraEwzq/4iiAtR8pVWTuUB3m7/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pirh82nOn6dOJn0w9OzBvquV4aC9CoPYKV75m7cJkxwZBK5SR2d3EGFJaw5xF7pUenJilRrWONmPnkhlh4FvIMRlcy06/BGFqA+FyxzVOTzQeQTwH/rPuoaN14k+JNvWVhhO6EcNfzF/qRd9tJvDtdenbNFitzXObw2ZHJ891/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Cvsd4E5x; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497AIuwJ008978;
	Mon, 7 Oct 2024 11:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=pp1; bh=j9fG3aOC1t6/PBAkxf8zdYRFvf/4TjZl1WCaqe8Exhc=; b=C
	vsd4E5xyTVKvhWIvS07F7DzoqIAhpHgEupJRmDT65TWYw+3k3nXEaYoBUwkJ8hvI
	vRBR1CpU1E7r90MsBJ6XEVV2IBioKv1b4/NdWBGYBbZFX2hkIScrT3Zv3zJCannA
	LeKY1uVZeqJxcHiyzRZdmJS5Yaf9S0pA5RuSHZtQLNJMxE2bQpcdYDVsfd925V91
	v4KaiJiAniYdeB2Dy/TMiLzaqaY1Ug+xOIy4sqNeYpHC34+HhQ4fsSdNCEHBd+P6
	fVzvVXhqOukc0Yw8JCCukj3U31FhdWp56QaZAbqq+emaXgbwIWV9yd7JVoci42cK
	n7ud/waw+hDQlIFZwpRIA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424ds7gg08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 11:41:47 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 497BfkJI013336;
	Mon, 7 Oct 2024 11:41:46 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424ds7gg01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 11:41:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 497ATTs4013798;
	Mon, 7 Oct 2024 11:41:45 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 423fsrxgt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 11:41:45 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 497BfiHw44302660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Oct 2024 11:41:44 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 975BD58050;
	Mon,  7 Oct 2024 11:41:44 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B4B258052;
	Mon,  7 Oct 2024 11:41:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Oct 2024 11:41:39 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Mon, 07 Oct 2024 13:40:20 +0200
Subject: [PATCH v6 2/5] Bluetooth: add HAS_IOPORT dependencies
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-b4-has_ioport-v6-2-03f7240da6e5@linux.ibm.com>
References: <20241007-b4-has_ioport-v6-0-03f7240da6e5@linux.ibm.com>
In-Reply-To: <20241007-b4-has_ioport-v6-0-03f7240da6e5@linux.ibm.com>
To: Brian Cain <bcain@quicinc.com>, Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Heiko Carstens <hca@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
        intel-xe@lists.freedesktop.org, linux-serial@vger.kernel.org,
        linux-arch@vger.kernel.org, Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1456;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=wqO06g/GtvVUtLH7zraEwzq/4iiAtR8pVWTuUB3m7/k=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGNKZT1yUNvzXf/78AuUzl8x1FM9JXecuLDivKn684tTLh
 8x9y/03d5SyMIhxMciKKbIs6nL2W1cwxXRPUH8HzBxWJpAhDFycAjCR316MDCeV6pdeObX8o8Wf
 Z2o3KqUTzT1ifuxZK5H8z8Ur1P72SnZGhl32WlzP3hSahBeKzVW79LHsxySR4hXXF283KhYWWuy
 XxQoA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lD4C2Ccq1OBy58UgT-ufV_U_V5PBxHTE
X-Proofpoint-GUID: zxC-iIT4r62lfZ0m_ineS7fJN_vfR_es
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_02,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=909 malwarescore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410070081

In a future patch HAS_IOPORT=n will disable inb()/outb() and friends at
compile time. We thus need to add HAS_IOPORT as dependency for those
drivers using them.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/bluetooth/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 18767b54df352e929692850dc789d9377839e094..4ab32abf0f48644715d4c27ec0d2fdaccef62b76 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -336,7 +336,7 @@ config BT_HCIBFUSB
 
 config BT_HCIDTL1
 	tristate "HCI DTL1 (PC Card) driver"
-	depends on PCMCIA
+	depends on PCMCIA && HAS_IOPORT
 	help
 	  Bluetooth HCI DTL1 (PC Card) driver.
 	  This driver provides support for Bluetooth PCMCIA devices with
@@ -349,7 +349,7 @@ config BT_HCIDTL1
 
 config BT_HCIBT3C
 	tristate "HCI BT3C (PC Card) driver"
-	depends on PCMCIA
+	depends on PCMCIA && HAS_IOPORT
 	select FW_LOADER
 	help
 	  Bluetooth HCI BT3C (PC Card) driver.
@@ -363,7 +363,7 @@ config BT_HCIBT3C
 
 config BT_HCIBLUECARD
 	tristate "HCI BlueCard (PC Card) driver"
-	depends on PCMCIA
+	depends on PCMCIA && HAS_IOPORT
 	help
 	  Bluetooth HCI BlueCard (PC Card) driver.
 	  This driver provides support for Bluetooth PCMCIA devices with

-- 
2.43.0


