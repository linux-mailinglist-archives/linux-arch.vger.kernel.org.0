Return-Path: <linux-arch+bounces-8522-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC3D9AEEC8
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2024 19:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F9BB1F22C61
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2024 17:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB7F1FF023;
	Thu, 24 Oct 2024 17:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IKA64ztA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695661FC7EA;
	Thu, 24 Oct 2024 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792587; cv=none; b=KrUkGSRk6Wu2HWSP1Zzeiqt6Pwaa7caHwi3/dTwQEmnuRb0zubtZ2K+9b6fYTNsy6mfzN06tmTU7BNofVyvqAfrEYP/0My9/h+UxnkbiKWSZ+VtlXNRN4Lso31mKwyskN2JtGwFcSUWAQm14tGhnBslqtMl3JkElpg3Q2XsnQzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792587; c=relaxed/simple;
	bh=pJfEvcklGNmMrN2u9QI22EkwnjUVJjMUQzN4oenrdnE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZBfoywhXZVpACz+BfcF8zihlwfbZa/IUxrix6Dk85Sbg9a2e7rtXOa+WZ4qjYmZ7bhqZHYjA6QP/gOBXOmP/MCwLanMj/glcqYiuM+0rqCPMDs1p+Ee99hS+WI5zdimMCgxttr4EyKXDCX/qib0q0PTjXn99VbY9ys5NQuGWMgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IKA64ztA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OGXrvJ016758;
	Thu, 24 Oct 2024 17:56:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3LyFLj
	L8Yyakboki3xOWjFqUv3Ts5bBdNjMbUaQozo0=; b=IKA64ztAENOpVCqvn2BM4k
	eBgbFd+u56QDHFQv3ekONODYNM+7Ogi/7RXgsqefSHbAHfXnQyAX1S5XSZYU57Oz
	us7zB9rFluBG3qwXxwggZn0m6Mko0YP8r95du6ki05qPgAZGygiTk+A1f/ATG2vf
	4h6qb9kjWTHjqJTdZpvS+MOqjx+GR8M8j2Nlzxl3HZW1pBO++1XF8fsXASy/HY+F
	pQkLHolyhzgThdTqmgtluLo1IFK6BqV3MQ/k2JbsO8CwjGKqYYnt+s1oAY8uL2Cn
	CZNZqqsSCbIuXjoM3Rz7BpaXRIGbHsOeV6PaklABZTr43w/ZCkrzLY/g3p17PW0w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emajt2k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 17:56:06 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49OHrFRb028350;
	Thu, 24 Oct 2024 17:56:05 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emajt2k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 17:56:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49OEWT7C008796;
	Thu, 24 Oct 2024 17:56:04 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emkasq7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 17:56:04 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49OHu37837945732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 17:56:03 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8469258054;
	Thu, 24 Oct 2024 17:56:03 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD32A5805C;
	Thu, 24 Oct 2024 17:55:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Oct 2024 17:55:58 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Thu, 24 Oct 2024 19:54:41 +0200
Subject: [PATCH v9 2/5] Bluetooth: add HAS_IOPORT dependencies
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-b4-has_ioport-v9-2-6a6668593f71@linux.ibm.com>
References: <20241024-b4-has_ioport-v9-0-6a6668593f71@linux.ibm.com>
In-Reply-To: <20241024-b4-has_ioport-v9-0-6a6668593f71@linux.ibm.com>
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
 bh=pJfEvcklGNmMrN2u9QI22EkwnjUVJjMUQzN4oenrdnE=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGNKlutgTrxtUX+lZbH1wZx+T9QTzgKp/ls9P7Fy6476zd
 9XWvXNNOkpZGMS4GGTFFFkWdTn7rSuYYronqL8DZg4rE8gQBi5OAZjI63MMf6XLtcNtt/aeZElI
 bL7tf12zsV3y7A+WCRU7qqaX7l1a4srwT5tjp3uhqLGgQN6912btWprT70ekiXLxCcYf232LTfw
 1GwA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IIbcPKs_O30yPQ3Dbh1Y1ZKVphvQuY4m
X-Proofpoint-GUID: QcsaUtEx0xSI6N2I4-IXLJ-TWCkGmNgg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxscore=0 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=929 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410240145

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
2.45.2


