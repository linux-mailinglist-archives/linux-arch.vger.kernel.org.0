Return-Path: <linux-arch+bounces-7756-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC9E992A6E
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 13:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E32283F3C
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 11:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0581D2223;
	Mon,  7 Oct 2024 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Cu1jyPSZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258C01D26F1;
	Mon,  7 Oct 2024 11:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728301323; cv=none; b=lqJ44K2AMpqpBSOztxD+uj5pWTKZxSo2MUBFk6NDlEks/0gAmQ51mnv8vZ1oACT18l9QGL4GPNZy1ULNgbIh1ih5T92RoGQ0OwTJgUnRsi/bu5k4CXY6+f/CDfC5QKgcihEIhnCBS2MfMlEsTqVcekiEC2TmNtdPOXqZHvgC1ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728301323; c=relaxed/simple;
	bh=Jxbgw/YBZzqIN9Ui044lI2C/Q459oyf0l31CYpqRevk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k3eywVdr0mgN2v2HKUeaKPBhDl/H5Y9t8o8hC5qui3rI8HLNwrzPwJq8aZdJco5ARIJi/d08XH2WWxGfplmg1OKjXvpXnJwy72xrOEAeqOap0aaRS3HzxNerrT0tieFA0v/kLNCmD522tQJceYy6/FXoyWwcXSQ/9aKYVHlCdfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Cu1jyPSZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4978uWgq014928;
	Mon, 7 Oct 2024 11:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=pp1; bh=irEkUnfOCK26+7I9ZnbJEpSwf6oraa+74Fg4hq7TUGc=; b=C
	u1jyPSZKlgI0FQgZd6kwUDxaAsCAoG5GqiwYM7QkPJHb3FuJT0y5FGAXURvrtr/w
	loGXQi2gItY2/4IWBfznhHhAFYfHTWfwx033QoqPrO4n0HO9AJWJh7uCkW+WuNy5
	Y8PzTKT4wXN31/n6tHp1RtMHztUzhtthmmZlDS+7g82KCaT080eSvmjs17tNxtoz
	kka+6gxr4IKaTRkuJbKAP7RtyABYazjz6Q1m35AKAQdrtKCzaUWZJPZeRl68WcAH
	XwFfoso7guiWeu5pp+hszZE4wNndQ3U9KwDxBOSIeQ3EE4URxWrFEwiVRYwl//p4
	uvnDCo45Ayfs04o+oBH2Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424cjm0wv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 11:41:42 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 497Bfgcf023967;
	Mon, 7 Oct 2024 11:41:42 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424cjm0wur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 11:41:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 497B7wli030168;
	Mon, 7 Oct 2024 11:41:40 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423gsmeajt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 11:41:40 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 497BfdPP41550118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Oct 2024 11:41:39 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23B9C58050;
	Mon,  7 Oct 2024 11:41:39 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 009D358052;
	Mon,  7 Oct 2024 11:41:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Oct 2024 11:41:33 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Mon, 07 Oct 2024 13:40:19 +0200
Subject: [PATCH v6 1/5] hexagon: Don't select GENERIC_IOMAP without
 HAS_IOPORT support
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-b4-has_ioport-v6-1-03f7240da6e5@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=986; i=schnelle@linux.ibm.com;
 h=from:subject:message-id; bh=Jxbgw/YBZzqIN9Ui044lI2C/Q459oyf0l31CYpqRevk=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGNKZT5x2+5Xr+baC74Wefv/RrtMLxWbuZjF/5/aeu/Skn
 hGf4vtpHaUsDGJcDLJiiiyLupz91hVMMd0T1N8BM4eVCWQIAxenAExE+BrDH45dE/iu1Dzu0v+u
 f+ytwpojvZfLbNwPXOnWWBPIpjd3ByMjw4w9jfP6cp0vzVexdvVf/1b8YaLLf7NNQjNlmVNENvB
 VcwIA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uthQ54pCT6XK0EqUE99rUJW5v7a_XU7-
X-Proofpoint-ORIG-GUID: o9YTUIycrHNmkHRdyWMUMapPV75nu8ex
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_02,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=735 spamscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410070081

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


