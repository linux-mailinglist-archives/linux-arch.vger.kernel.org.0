Return-Path: <linux-arch+bounces-8523-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF8E9AEECC
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2024 19:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06B0286C64
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2024 17:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9966B1FF05F;
	Thu, 24 Oct 2024 17:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D5Lv+pQ7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695B41FC7F6;
	Thu, 24 Oct 2024 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792587; cv=none; b=gF+cZ5YlGtY/rqXb0mlC8BP1lrZlF1uAoEPrNkGJ0YLcAEX4dnTd9TTOivZu9R1sWApdvQTp0BSfg9f/hwRY1cV+B+l6PVoQBGVSl/gtT8fNkzWeo83NkHdl62CjHdMCcmqRNhVRnfmNf8spTlk7wKoy2S07kreHx9unXiI0dg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792587; c=relaxed/simple;
	bh=dwa97Zv3mMxp89DjOwcC74hl8WXFjK0hXQS5Qkk1N/M=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=hzFcrNdPY9S0zswUr4s7/XduTW3PkpULFWwXvVFPY3MbgAnMNKpiwv8GdJnCC8MXCxzWS+7wHZJ6UvFgY+40a9dDJvmcuVMKoGAyEmSlrxseL0c/uX+rw00nPCa1Ds0ECabuqLFt+OUDVj7B+bTaluA12H+LPcKQ4c/dz7Bv1ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D5Lv+pQ7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OEUgn4025218;
	Thu, 24 Oct 2024 17:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=xnEGdyTnpg4xM+QjkDVMi2R9voLU
	vQJVrDKuSvjiRtc=; b=D5Lv+pQ7rewYUy72gB3EE0/NM8xN1S8kqgsBD2M8c31t
	X4AoKRl21BtN5j3SlHYHcpT7CtZwlwaiOJOuLr4XTp3jrsNnqH7Ail+31H2LWEpz
	OggWto5gr21gA6ajFGQzOWurjCsQOB/vdhdl8wn6OOoCiOc5lVhc+kFTxVhjBSrz
	LKJdnDSZDw2DV8YtrTMWhVrdJTXnQvZyf18YGkwWvPmf2VWSmQhKdlI9Dfy54X8E
	xC5GryC4OijXnJprAGkdQThVUXQoQjcm+17uoT8ZyAI0caUfbYru5XNUTA6P4g1r
	40jG/xK1b/56EbWF6KcC+P6rvSchWr6eQOKL60mt+Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emaf21r2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 17:55:56 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49OHttc3019270;
	Thu, 24 Oct 2024 17:55:55 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emaf21qw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 17:55:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49OHsDxE014565;
	Thu, 24 Oct 2024 17:55:55 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42emk81pbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 17:55:55 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49OHtrAN49021382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 17:55:53 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A12885805D;
	Thu, 24 Oct 2024 17:55:53 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECE5A5805C;
	Thu, 24 Oct 2024 17:55:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Oct 2024 17:55:48 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v9 0/5] treewide: Remove I/O port accessors for
 HAS_IOPORT=n
Date: Thu, 24 Oct 2024 19:54:39 +0200
Message-Id: <20241024-b4-has_ioport-v9-0-6a6668593f71@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
X-B4-Tracking: v=1; b=H4sIAN+JGmcC/33M0QqCMBiG4VuRHTeZurbZUfcREXP7zR/SyWZii
 PfeFIKQ6PD94HtmEsAjBHJKZuJhxICui1EeEmIa3d2Boo1NcpbzjDFOK04bHW7oeucHKpg2wkB
 moRIkfnoPNU6bd7nGbjAMzr82fhTr+pHkThoFZZQVtcw5s1rA8fzA7jmlWLWpcS1ZtVF+C2ovy
 CgokXPDSs2tlL8E9VdQUZBlAUJp0NbqvbAsyxuhkJDsMgEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3956;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=dwa97Zv3mMxp89DjOwcC74hl8WXFjK0hXQS5Qkk1N/M=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGNKlOn/9Tc23s9+Ytnn2beaQUpMX53o17DdMPuE2uUGgZ
 bHY3IvNHaUsDGJcDLJiiiyLupz91hVMMd0T1N8BM4eVCWQIAxenAEzEXIThf/Zd8bd1jy8tTfGt
 P9MY+cfvW5DanO1/VpzuKCkyE/JMSWJkmKYevFJimtD5l0cvW2x349jvJy1859+vPwUzL3xxElx
 1hAsA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZzK5_Bh6ZhzA52n2zOUZDhguzOYUudTo
X-Proofpoint-ORIG-GUID: oNqOtwFfRbanHLYgT_LLYcqw484r7CU5
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
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 clxscore=1011 impostorscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410240145

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
Changes in v9:
- In drm patch sort includes and reformat if (Thomas). Use IS_ENABELD()
  and add a helper instead of #ifdef (Arnd, Thomas)
- Rebased on v6.12-rc4
- Compile tested applied to next. There are a few conflicts with drm
  next but they're all just context changes
- Link to v8: https://lore.kernel.org/r/20241008-b4-has_ioport-v8-0-793e68aeadda@linux.ibm.com

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
 drivers/gpu/drm/qxl/Kconfig           |  2 +-
 drivers/gpu/drm/tiny/bochs.c          | 19 ++++++++---
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
 17 files changed, 171 insertions(+), 22 deletions(-)
---
base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
change-id: 20241004-b4-has_ioport-60ac6ce1deb6

Best regards,
-- 
Niklas Schnelle


