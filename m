Return-Path: <linux-arch+bounces-8524-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEBF9AEED6
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2024 19:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90315B247B2
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2024 17:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EB32003C3;
	Thu, 24 Oct 2024 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G7kC7L4e"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5116D200135;
	Thu, 24 Oct 2024 17:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792590; cv=none; b=cPviF6tnea53Xa+JYlMEMlmtJR+Cp1F+Q20QUvx67Mzlmd0rmy9gDoOxvRQHp/zwOV7b/sduW5SeQRpED/j96WdaI5uxI5fTDOaqZI/u3Col6ib/ty7MIjDubx6nRDAC1frmW1umgqmtdUdcCeI+8CaY4PS8oopiotkztoXGUMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792590; c=relaxed/simple;
	bh=6gPJQBOX8gUfd/kyQYxT0sWYXDYMvHcm306ILpFlmrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Klz9yy5zoiuyoi3riD7X+3ELfCwWbkIt3bfOE2tEnujZcFndnwY5P0lrhETjSnRPEpPSFapwet4D5FVbw7GDTbeXjVY9rHBaQvtn3HgGWW3zVWIUCbR7+pNr4PCGV2z1B7cv47sR4bvfCkJ/hxaIADZuFEqv8gWdbm5+Q7fA1Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G7kC7L4e; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OAQHDf020092;
	Thu, 24 Oct 2024 17:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2x+iY0
	QvreUGblwiOpyRRL1u0S7Fwoc98iefRoVWqGU=; b=G7kC7L4eJMXTE6K3a420aY
	9frbU1vBJYXvaxL4ymPhl2JaR7FqwSCkQsaTF4CyyOKCyRMWwB6BnQir6Kak5q5y
	+duahUeuadbbfOr6hZh05gTXbFDTM9hPeSCiwsZ4+/RdF3pq/bw0aLOWvnGTbNw9
	+lxTmGW5/GFoJdlHQTHCI81QBqRKdR15iDEmN3Jn4/dd+R/z8Vdavb9n+SaV2vwp
	XvcTzOj3dvbG+q5c5IjV5bLyHn8mfyL0xWHrf0kSXcF3DWwOfQmwT56koaJOgsls
	Tw4OqfDcyDmZhktV2ObSOh+R+nQrm+RZGYpM+94071xyrD2I8ChSXtSMkN+8lkNw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emajt2jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 17:56:01 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49OHrFRZ028350;
	Thu, 24 Oct 2024 17:56:01 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emajt2jj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 17:56:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49OEiRUf001521;
	Thu, 24 Oct 2024 17:56:00 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emk9hnyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 17:56:00 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49OHtwbC28836576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 17:55:58 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94F165805D;
	Thu, 24 Oct 2024 17:55:58 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8F865805A;
	Thu, 24 Oct 2024 17:55:53 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Oct 2024 17:55:53 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Thu, 24 Oct 2024 19:54:40 +0200
Subject: [PATCH v9 1/5] hexagon: Don't select GENERIC_IOMAP without
 HAS_IOPORT support
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-b4-has_ioport-v9-1-6a6668593f71@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=986; i=schnelle@linux.ibm.com;
 h=from:subject:message-id; bh=6gPJQBOX8gUfd/kyQYxT0sWYXDYMvHcm306ILpFlmrE=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGNKluhgNWZXd3+Wnvy2p2ypUdffXv1jxfVe4jZWK525TU
 J+QetO2o5SFQYyLQVZMkWVRl7PfuoIppnuC+jtg5rAygQxh4OIUgImUSjP8s12z0fjjV5eA/e6P
 hb67pSfMf1pQ6VVdF6JvHrg3fm7oaYb/Gde8AiJKl2+Zc9qZWXq5k9120+ucK4OiStKEpJWn3Cl
 jAwA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: S1g5VV7IzCFZNb7y01DDFNiZN-y0Boe1
X-Proofpoint-GUID: 5LtD42hQkn0iwZIGcB9uHk_jIpEBB-FM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxscore=0 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=754 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410240145

In a future patch HAS_IOPORT=n will disable inb()/outb() and friends at
compile time. As hexagon does not support I/O port access it also
the GENERIC_IOMAP mechanism of dynamically choosing between I/O port and
MMIO access doesn't work so don't select it.

Reviewed-by: Brian Cain <bcain@quicinc.com>
Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/hexagon/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index e233b5efa2761e35c416cbc147f6b6422a7c5b8f..5ea1bf4b7d4f5471a9c39ee9fb5c701455d21342 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -31,7 +31,6 @@ config HEXAGON
 	select HAVE_ARCH_TRACEHOOK
 	select NEED_SG_DMA_LENGTH
 	select NO_IOPORT_MAP
-	select GENERIC_IOMAP
 	select GENERIC_IOREMAP
 	select GENERIC_SMP_IDLE_THREAD
 	select STACKTRACE_SUPPORT

-- 
2.45.2


