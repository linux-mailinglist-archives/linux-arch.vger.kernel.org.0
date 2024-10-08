Return-Path: <linux-arch+bounces-7826-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3429D994713
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 13:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669F61C25F16
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 11:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031F81D27B3;
	Tue,  8 Oct 2024 11:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PJjiRL7J"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BB1481D4;
	Tue,  8 Oct 2024 11:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728387190; cv=none; b=OGx0hbeKPkuhkhjMX9ux3c7nVfv4XZjrQPq4HtbBQ6AmZIZdYEPVCpsSlIzbmKwYHmz92AVivVn5sLIJtdYHpoatgAnsrJBG0O/j6DdA5E4N7+5CpE33m3Sp6UWhPKXDn6uD1VmdZEi7GJVORW/JARbmlFvTHIdkVvCelVSR16s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728387190; c=relaxed/simple;
	bh=Jxbgw/YBZzqIN9Ui044lI2C/Q459oyf0l31CYpqRevk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=au3cYHMYsWaXLhyFY49gTJOWwSekY2duIheho9qyii1JxzRBsKy8PVrNbf1jPObRZjFGU6Hma4otfXgKYz84YSHwUi7vdmcJV+874jHVdrNbpuoxydRWwg+ASe9JWt8TfPppSM+Y/ofw37ILA50gzRYEDUXc5rPZbRo4Rpg0r9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PJjiRL7J; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498BK9MM022840;
	Tue, 8 Oct 2024 11:32:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=pp1; bh=irEkUnfOCK26+7I9ZnbJEpSwf6oraa+74Fg4hq7TUGc=; b=P
	JjiRL7JuNPCwChLD3YxpPfIBILhUjNa6CDmfw+Z5NPyTfhBoO8gczu83NxKm0D0E
	+tCmlmbAhP3kAn+GpEW+e1SXqjoWOvBlXGbuQWZ5Tj1ynxv4cDo2TFLO2z3USKOJ
	obGmgv8wuEbBi50c3Zy/HBgry3nF7+mxDecmHLUxzcDp2VH0uUFMwzpXkqg6vBQK
	6hjuw2cOb+Hwcy+NLbnl0UMLWOL3VwB6g8lC0n3EAVRue/ZHxMdLSyYfPi4o/fpb
	hHaqyniRNVw2VS3/DVCcz3KfoPqUXvXJGk6DiJZVWJFmioRzxi/G+NikZhr1YY+9
	wCQnSN0/93D6dC7DLTxbA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4253axr6nm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 11:32:52 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 498BUfI4019925;
	Tue, 8 Oct 2024 11:32:51 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4253axr6nc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 11:32:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4989QhWp030174;
	Tue, 8 Oct 2024 11:32:50 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423gsmkxnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 11:32:50 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 498BWm1J48824772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Oct 2024 11:32:48 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7906D58059;
	Tue,  8 Oct 2024 11:32:48 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FA8D58053;
	Tue,  8 Oct 2024 11:32:43 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Oct 2024 11:32:43 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Tue, 08 Oct 2024 13:32:01 +0200
Subject: [PATCH v7 1/5] hexagon: Don't select GENERIC_IOMAP without
 HAS_IOPORT support
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-b4-has_ioport-v7-1-8624c09a4d77@linux.ibm.com>
References: <20241008-b4-has_ioport-v7-0-8624c09a4d77@linux.ibm.com>
In-Reply-To: <20241008-b4-has_ioport-v7-0-8624c09a4d77@linux.ibm.com>
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
 h=from:subject:message-id; bh=Jxbgw/YBZzqIN9Ui044lI2C/Q459oyf0l31CYpqRevk=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGNJZJawk/sg9DyiQrPhy/oL1qR3q7T3r/jCcu35ywy9uu
 dif3vNrO0pZGMS4GGTFFFkWdTn7rSuYYronqL8DZg4rE8gQBi5OAZhIQRwjw9+kQJvXIif2yM/q
 XPU6s+SSy7krToUP6xfnVRxkqu/8yM3IMLkkRUvuQePU6KtFMi9Vl0dI9dd0GxWeUXjLs0B8lcN
 cDgA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3INkOsrcEEm_VS2ceIqALSZI4xhm2bLu
X-Proofpoint-GUID: QWhRyO2_eVVaJHZkVI16-yY41nSUGX8j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_10,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxlogscore=735 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080072

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
2.43.0


