Return-Path: <linux-arch+bounces-7836-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45417994B44
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 14:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F562288430
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 12:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC69A1DF26E;
	Tue,  8 Oct 2024 12:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KdXyxdF2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F361DF266;
	Tue,  8 Oct 2024 12:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391262; cv=none; b=GcgGiVSXhVMa00IT2Hf/JqDNmaqrUpsUpYHXgV50jQDuU1w1QsXJFFZ0Tjbh25nrk8V1nO4jPjXY6OkpigDDwk1qML7IFffAvZegKxwXhUXggjztwGkJ/JvtWhNxMi5RSamJjB3F3x9x2F1Hmm9E7Hc2rmZ+X4NVz4Crnzidz+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391262; c=relaxed/simple;
	bh=wqO06g/GtvVUtLH7zraEwzq/4iiAtR8pVWTuUB3m7/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m4/dxspkCCLPWn0kG8xor2VEStNbr0gDdPObbUHYoHC8TtLR1Orc6OJT8eS1bVRl2iF3AU7UcomMeN2P16tY9vlo2Ll9M59zD4qS8nhTFGv3M+jOZ0062NdhWNAkazu4t68gj2bBIFK3PWkyW9YdpGjEbpLyEzA4HxijIhsxmSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KdXyxdF2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498AoUX8005483;
	Tue, 8 Oct 2024 12:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=pp1; bh=j9fG3aOC1t6/PBAkxf8zdYRFvf/4TjZl1WCaqe8Exhc=; b=K
	dXyxdF22ClUOJ2qf4f6EGhH+6HR6AT6+Sf015rzTWI0+wD0QTe8ly8wvxAIy5CMB
	6S6+ZRHT2ck17wDuF05Der7BGJje0onpy+J9gJH89riTkKz4pI1uM5lzT5h+TW1b
	lW//WaQCoAuPCWanbmuj3vujI3GmBhRzmtkCJYUH32GiwRuuOc+h5d+OdHPA7Ulp
	AAmTjNKorNSnuIeBSzKRGFcotlWk7B4OkYX8jHje6wT31kWSzW3GdA8RYwmvCqxm
	G2ijIbd3qylIoDnvq69BFuUdNjyAbUh7BCEuZ1qXXfnDZxANKBP33r2SFCW8qZhs
	Yx8N2YLx0ZAGiLZfPYG6g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4253axrk16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 12:40:43 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 498CegLV005541;
	Tue, 8 Oct 2024 12:40:42 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4253axrk0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 12:40:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 498C7AbQ011535;
	Tue, 8 Oct 2024 12:40:41 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423g5xmcep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 12:40:40 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 498Cedrg42926590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Oct 2024 12:40:39 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AB3B5805A;
	Tue,  8 Oct 2024 12:40:39 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81D9A5805F;
	Tue,  8 Oct 2024 12:40:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Oct 2024 12:40:34 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Tue, 08 Oct 2024 14:39:43 +0200
Subject: [PATCH v8 2/5] Bluetooth: add HAS_IOPORT dependencies
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-b4-has_ioport-v8-2-793e68aeadda@linux.ibm.com>
References: <20241008-b4-has_ioport-v8-0-793e68aeadda@linux.ibm.com>
In-Reply-To: <20241008-b4-has_ioport-v8-0-793e68aeadda@linux.ibm.com>
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
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGNJZNRSYL+5RfRhyp01/WbAmU8x0nvMisY7LHnxObNp7U
 bh94pbzHaUsDGJcDLJiiiyLupz91hVMMd0T1N8BM4eVCWQIAxenAEzkjxkjw+bd4lWHp54Wf3z0
 DFfNMWmR7bvq5jVFqz96qj637ZjcuQyG/1E9Sz+256s+TD5VaXi4SPxFyqGCbx+tXtaJGS+++OL
 kdkYA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 88jI6q6z60AXjQfgnWcG8wkgQ6Dfvp01
X-Proofpoint-GUID: mC7lufU3a6fSlFlSYSjkSr0lBHQ38bD4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_10,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxlogscore=909 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080078

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


