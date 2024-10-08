Return-Path: <linux-arch+bounces-7825-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0633399470F
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 13:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3941C261AC
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 11:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD9E1D0BB1;
	Tue,  8 Oct 2024 11:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PE6VVQal"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECD93A1CD;
	Tue,  8 Oct 2024 11:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728387190; cv=none; b=tdZwcBTHPpakuQwc4OiUGWcphSSnBDMkwjfHSa0N+9roHq8VjRfS0a/U2VLM6Z3zd+TwFUm62nz4shiufYLnR63v+mDngw15stmR8UKPeY1R4YfVaEnGZy52/KiYIOq3l9sDUndOJiM4GkTKqmurqn888q+FP6aOBcX0Dfrv/Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728387190; c=relaxed/simple;
	bh=cIyZ889sLGrW/Wuw16j9L5VqBMtjCuL2Oox4D9dTRk4=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Wa/r7JzreZ9EjtYlarKbfHtSXFKHnm8/yFtNbcPkJe56SrhqLnRBcAR5jiVsWwB218JjT3E1d+YkLnk5tJoV/pIYS4bUiTWIwRHxzbyXOqhXlohXI7rmvr5o+LzPA4WXkAtG150d5TnjabhmzK0pd/e0YTE9tzd6zNhLqS2/cmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PE6VVQal; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498Anb2B003567;
	Tue, 8 Oct 2024 11:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:subject:date:message-id:content-type:to:cc
	:content-transfer-encoding:mime-version; s=pp1; bh=q+Jvx74PNMMWk
	6uZoF48k4ng2W3kYHsf5kmfDTSiPrk=; b=PE6VVQalDRIHTGI4TX672sLHHNUmO
	tw4m6Ziu40tMjiadzfHhgGONHfJdQTR7ANGEQe3rp5Un1ysIo9KqXybPaffXFox+
	S88cLhML+bj68oJgZpsnq0WRFcIMqEOP27/6OSEBc5Unz6JLz0wAoAFUGiPG3JdK
	RzZMNg5xDD7l1eITFT7WkdLC6Ltww69GU6lZ16NG3suX9CqfkY/Q5h56f8c+wLEv
	LEt9C5WhDHMgy/VwUtTpsUa2950CH4p6mgxzUggq6NnR0SXbPoLFxPNlMbNpI+FF
	ptix8wUbleswA6PWjc12ryt8DGY9UUDNQyy/5LJOkLr8M4w821CyMROcQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4253axr6n1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 11:32:46 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 498BWjSU023984;
	Tue, 8 Oct 2024 11:32:46 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4253axr6mx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 11:32:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 498ASfS0010718;
	Tue, 8 Oct 2024 11:32:44 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 423j0jbqdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 11:32:44 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 498BWhFY22479474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Oct 2024 11:32:43 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1DF558043;
	Tue,  8 Oct 2024 11:32:42 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6C9D58053;
	Tue,  8 Oct 2024 11:32:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Oct 2024 11:32:37 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v7 0/5] treewide: Remove I/O port accessors for
 HAS_IOPORT=n
Date: Tue, 08 Oct 2024 13:32:00 +0200
Message-Id: <20241008-b4-has_ioport-v7-0-8624c09a4d77@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
X-B4-Tracking: v=1; b=H4sIADAYBWcC/13MQQqDMBCF4avIrBsZ0zRCV72HSInJ2AxUI4kVi
 3j3pkI3Xf4P3rdBosiU4FpsEGnhxGHMUZ8KsN6MDxLscoNEqSpEJTolvEl3DlOIs9BorLZUOeo
 05M8Uqef18Jo2t+c0h/g++EV/159U/0mLFijw3NdSoTOaLrcnj6+15G4obRig3ff9A71rWIOuA
 AAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3410;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=cIyZ889sLGrW/Wuw16j9L5VqBMtjCuL2Oox4D9dTRk4=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGNJZJUzd+z6/0HHZNnPivTx31s+O3xZW/1X4Hh5+SCFo0
 8IV+zdc6ShlYRDjYpAVU2RZ1OXst65giumeoP4OmDmsTCBDGLg4BWAi754x/Pc5F3FdeVZYvFfD
 m62Zq93/fl37MfFR0kGjaVPOnfsrE/GTkeGJUUuW++FzbRlnrhUu238zuOfinaUF+ys6trXPvs3
 i9ZkdAA==
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eU2vCxO04Y81JSOSHXcevqRtUp0Ha1_Z
X-Proofpoint-GUID: fUKuuKOidhaZJLewDzILyqdlwk_eKTrk
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080072

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
 drivers/tty/serial/8250/Kconfig       |  5 ++-
 drivers/tty/serial/Kconfig            |  2 +-
 include/asm-generic/io.h              | 60 +++++++++++++++++++++++++++++++++++
 include/linux/serial_core.h           |  4 +++
 17 files changed, 174 insertions(+), 17 deletions(-)
---
base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
change-id: 20241004-b4-has_ioport-60ac6ce1deb6

Best regards,
-- 
Niklas Schnelle


