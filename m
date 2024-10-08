Return-Path: <linux-arch+bounces-7834-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23019994B32
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 14:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8D91C24D87
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 12:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A3F1DE2CF;
	Tue,  8 Oct 2024 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mj1wSlLT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A0B1DE894;
	Tue,  8 Oct 2024 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391252; cv=none; b=JWUqh2lnT7dDeALdzGf5KlLchwyqLxROL0L3GMGf3dnFFBLj/QWZizP4x4fU7XnExYXJq6b1bhLUQtM9KmTGfXVQLfif93UPHUa0ZKkmR+UOf4kv/GTeyOijhVbNyCs07qlWC4Cy+yvGrROkEV/SW/asvcO2AdMOVY7s2EaQtLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391252; c=relaxed/simple;
	bh=6iXTfylcHiouPDPsYMMA7jBlfpR78tVFP+VwvM5uYoY=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=lPZ7ZSbmT3NxXvV/RBqBut3n/nUBYIfUTeA/BZso3gn/HYJcB7tegk5rhNBk0Pp5FKPnELwm6GWsbZHV/EdVUCmkQ73Q4WXAZ5fZNOyy6OQBk/IWpu9pAwZ+PfENJYz/wgSId1ENoyVgVEoWM1uFfmYOMAesJGbZA4Im/gGImbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mj1wSlLT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498BsMk5006181;
	Tue, 8 Oct 2024 12:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:subject:date:message-id:content-type:to:cc
	:content-transfer-encoding:mime-version; s=pp1; bh=pOl4ktgChjI1x
	ihRyfZf3GuH04LsHn6DYGpUG7dt7hA=; b=Mj1wSlLTzLFGjeC9FjwerlOHFa+zM
	DKEJgymPSia+4AoUadZhZAMwDj8BTkhZsNk+keJducR3JuupSbWIDCgAmGyWMfi7
	fKdoMxW1XKYopwBCxx0/Ni9O7Q6oKAZEjnfoh8hiTz1nK8WBXWkRTPviLZx4My/j
	7W9MMehDmYxifC9Nk8p8tmuHx7daSEsyNq0dsHQ0H0r1U5s50Xlbw3KmTTUHJ9bD
	6PSZebNxsp8OE/uCAjhh3VqQwA6kDKUIc64WO5rIsW2KS3fTIwFM/hPVwnfq8ZBb
	0op3/3nx6x6iPk+dlDtCMb0V0QnGiv0JiG56KCM4z1DmtYQZK6K8UKb7g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42549908jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 12:40:31 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 498Cd65c030660;
	Tue, 8 Oct 2024 12:40:31 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42549908jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 12:40:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 498CR5Ef011521;
	Tue, 8 Oct 2024 12:40:30 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423g5xmcdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 12:40:30 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 498CeTgG23659234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Oct 2024 12:40:29 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9B4A58062;
	Tue,  8 Oct 2024 12:40:28 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED9585805A;
	Tue,  8 Oct 2024 12:40:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Oct 2024 12:40:23 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v8 0/5] treewide: Remove I/O port accessors for
 HAS_IOPORT=n
Date: Tue, 08 Oct 2024 14:39:41 +0200
Message-Id: <20241008-b4-has_ioport-v8-0-793e68aeadda@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
X-B4-Tracking: v=1; b=H4sIAA0oBWcC/13M0QqCMBTG8VeRXTc5rrVZV71HRMx5zAPpZLNhi
 O/eFILw8v/B95tZQE8Y2CWbmcdIgVyfojxkzLamfyKnOjUTIGQBIHkleWvCg9zg/MgVGKssFjV
 WiqXP4LGhafNu99QthdH5z8ZHta4/Se+kqDhwODZaSKiNwtP1Rf17yqnqcus6tmpR/wvlXtBJK
 JWQFs5G1lrvhWVZvn32tpDwAAAA
X-Change-ID: 20241004-b4-has_ioport-60ac6ce1deb6
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3575;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=6iXTfylcHiouPDPsYMMA7jBlfpR78tVFP+VwvM5uYoY=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGNJZNQR1GfR3Oexh8l07SfSNMveB6KMvjBLeLDuY7Naol
 y/w/lleRykLgxgXg6yYIsuiLme/dQVTTPcE9XfAzGFlAhnCwMUpABOxFWZkeB7v8H3a5zoJq7ne
 bSt2R9i9beTdwt5+/p6dxLpwVQvfAIZ/tm+2tV282m/4Tu954GuOHw9fnD0+zYWH+fSkN9kV/Wt
 msQMA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jWlKYB-UbWEldWzuXtPPoAOoIOffl0Yg
X-Proofpoint-ORIG-GUID: -wc3D3PcYgnXknBTnJB55CoCv5dzwH-2
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_10,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080078

Hi All,

This is a follow up in my long running effort of making inb()/outb() and
similar I/O port accessors compile-time optional. After initially
sending this as a treewide series with the latest revision at[0]
we switched to per subsystem series. Now though as we're left with only
5 patches left I'm going back to a single series with Arnd planning
to take this via the the asm-generic tree.

This series may also be viewed for your convenience on my git.kernel.org
tree[1] under the b4/has_ioport branch. As for compile-time vs runtime
see Linus' reply to my first attempt[2].

Thanks,
Niklas

[0] https://lore.kernel.org/all/20230522105049.1467313-1-schnelle@linux.ibm.com/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git
[2] https://lore.kernel.org/lkml/CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com/

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Changes in v8:
- Don't remove "depends on !S390" for SERIAL_8250
- Link to v7: https://lore.kernel.org/r/20241008-b4-has_ioport-v7-0-8624c09a4d77@linux.ibm.com

Changes in v7:
- Renamed serial_8250_need_ioport() helper to
  serial_8250_warn_need_ioport() and move it to 8250_pcilib.c so it can
  be used in serial8250_pci_setup_port()
- Flattened if in serial8250_pci_setup_port() (Maciej)
- Removed gratuituous changes (Maciej)
- Removed is_upf_fourport() helper in favor of zeroing UPF_FOURPORT
  if CONFIG_HAS_IOPORT is not set (Maciej)
- Link to v6: https://lore.kernel.org/r/20241007-b4-has_ioport-v6-0-03f7240da6e5@linux.ibm.com

Changes since v5 / per subsystem patches:

drm:
- Add HAS_IOPORT dependency for GMA500
tty: serial:
- Make 8250 PCI driver emit an error message when trying to use devices
  which require I/O ports without CONFIG_HAS_IOPORT (Maciej)
- Use early returns + dead code elimination to skip inb()/outb() uses
  in quirks (Arnd)
- In 8250 PCI driver also handle fintek and moxi quirks
- In 8250 ports code handle um's defined(__i385__) &&
  defined(CONFIG_HAS_IOPORT) case
- Use IS_ENABLED() early return also in is_upf_fourport()
  __always_inline to force constant folding

---
Niklas Schnelle (5):
      hexagon: Don't select GENERIC_IOMAP without HAS_IOPORT support
      Bluetooth: add HAS_IOPORT dependencies
      drm: handle HAS_IOPORT dependencies
      tty: serial: handle HAS_IOPORT dependencies
      asm-generic/io.h: Remove I/O port accessors for HAS_IOPORT=n

 arch/hexagon/Kconfig                  |  1 -
 drivers/bluetooth/Kconfig             |  6 ++--
 drivers/gpu/drm/gma500/Kconfig        |  2 +-
 drivers/gpu/drm/qxl/Kconfig           |  1 +
 drivers/gpu/drm/tiny/bochs.c          | 17 ++++++++++
 drivers/gpu/drm/tiny/cirrus.c         |  2 ++
 drivers/gpu/drm/xe/Kconfig            |  2 +-
 drivers/tty/Kconfig                   |  4 +--
 drivers/tty/serial/8250/8250_early.c  |  4 +++
 drivers/tty/serial/8250/8250_pci.c    | 40 +++++++++++++++++++++++
 drivers/tty/serial/8250/8250_pcilib.c | 12 ++++++-
 drivers/tty/serial/8250/8250_pcilib.h |  2 ++
 drivers/tty/serial/8250/8250_port.c   | 27 +++++++++++++---
 drivers/tty/serial/8250/Kconfig       |  4 +--
 drivers/tty/serial/Kconfig            |  2 +-
 include/asm-generic/io.h              | 60 +++++++++++++++++++++++++++++++++++
 include/linux/serial_core.h           |  4 +++
 17 files changed, 174 insertions(+), 16 deletions(-)
---
base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
change-id: 20241004-b4-has_ioport-60ac6ce1deb6

Best regards,
-- 
Niklas Schnelle


