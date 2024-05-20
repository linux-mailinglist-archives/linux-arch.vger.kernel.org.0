Return-Path: <linux-arch+bounces-4473-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 589008CA3F7
	for <lists+linux-arch@lfdr.de>; Mon, 20 May 2024 23:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADDC3B22AEF
	for <lists+linux-arch@lfdr.de>; Mon, 20 May 2024 21:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C828028E7;
	Mon, 20 May 2024 21:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="cLB6SDwt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XstiVK2B"
X-Original-To: linux-arch@vger.kernel.org
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00563137C25;
	Mon, 20 May 2024 21:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716241827; cv=none; b=pIYiiXTWiNmDe7UlvHZuujFpSMHjmntK241XGyGtHtvoCE+yC/5C71k7DYowWTrhHS+K2yggNUUVe+xC95NIzIZmumT/ITqOrBmpjHvS4r0LgUHwYM4O4SSZrjUuW7zU5NigciS5HtxnQoEI2EQlvbxloCr45qjoDBmdXuIpQEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716241827; c=relaxed/simple;
	bh=/BzG2AXPi91Ybuwzyq5LPVmO885wC3Jcjp3w2pkDsr4=;
	h=MIME-Version:Message-Id:Date:From:To:Cc:Subject:Content-Type; b=u8yhEJ59539RgIb/XlqEm0VrY8RvnIBKcR+MymItazgq7jO7EM246cS0X4sKj7XtHu++m6gKOtyZBcr7vparSfyCSpc9Cn3pvNDJri10lbRSgpvM9DS3XONo6jrIn5V5v60KFq4tyh0jffNsxwx9S4d7aOIq7Nmq3y/xMVHlRuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=cLB6SDwt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XstiVK2B; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 070701C000F1;
	Mon, 20 May 2024 17:50:24 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 20 May 2024 17:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1716241824; x=1716328224; bh=tfXZqovi6taJSl11sMP24Yo5BKUNuK/p
	Jx4Vnb9SBmo=; b=cLB6SDwtwX8D1YXbRT2Z+tq57154T48R6icFfkzBqndC7NKs
	kJCNC/8XncR8UAp9JVUqv72BkRo39Yk8KdA2UimbAaW74PzWVF7UvsHVqZfu0yH9
	CpZQMDYJKx4Zk0fbeJ40YHYGMCF9/hp+ENKyfxG3n1cxHeruza0FI1N74V9TLnxE
	UN+Pvunc250FyPkXald8vkYt5kZIUCNTYtaTkx+KC/S/XsXEUSoxyztFcIiybxhV
	ZRItE0Y/tmLwdGZpNn/CafWvFSd++0d0AKo5Vv8DVYKwySVTBwaCGCbLhtbrYV+G
	igWutFMkNFYGgXJxeJo9IW772WAAcvrYQhLBcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1716241824; x=1716328224; bh=tfXZqovi6taJSl11sMP24Yo5BKUNuK/pJx4
	Vnb9SBmo=; b=XstiVK2BWLZ/yUhUPRkmEtDwOfRqYWIruNzAM5K6JiOH18iiZoR
	jpcktH7n4ZS6MYCet1OvhkiY3o4OjawLqaCmYmxofk/7EZDm0tl2M/+tJiuEoLha
	3rbAqFil38LXe41aeis6gpqZnbhB+gnJxrcoMP3pVDp39CWpQcKNJb6K5w/vDJBM
	8+tUpnAMd5u2IXlTlZkYmYypEjmdd8XclMqSMGVrnoH1+iZOIAC8k33eB58FQNGN
	qupvw+i9xDCfrFj1/QRT4F3E3XYA5QUfvWa0xvadw2yhYq+dK9E9Lzm8CVRDQ+E7
	dBLxXIvbi4v0LFNw0qNLMlHP2amPfejSOsA==
X-ME-Sender: <xms:oMVLZgP0VdQ0aumfSkPsr8gtgubS2jZ_pfyU85bKMZxywlJqfna3Cg>
    <xme:oMVLZm-zjXY3ALkqzf1t9PQU0Dud1ze8uW5k3xXhhoKqJMSPB4A4m0Kx4mU3h2aEo
    QnO2OPkWKUdq02nUAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiuddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfeefuefhkeejvedtvddtleeltddttdejgedvhfdtuddvhfeukeduiefhjeetgfei
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedune
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:oMVLZnR4P21fPigHQ9soQrUAj3qnGBivfuonvjU_su81wHDMBzbMnw>
    <xmx:oMVLZovtEXLtJyXbt726GE-RR9VDSNbdxZJ-0C02XvN7vSEduvSYjw>
    <xmx:oMVLZofKdG8AQxBWmapNqr2pb3E5MsZ5fUNJWqlxp0nsgpNQS5vo1g>
    <xmx:oMVLZs0hCqqOw4oZKnxjWQFBMeU5GuarQd-UeJt6CWgqve3ojXF1dg>
    <xmx:oMVLZn69Zgwt3qnDbtT0PS9NojcksovtKp1vVNZNVe-gLsFyWuALdMBz>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5A501B6008D; Mon, 20 May 2024 17:50:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-480-g515a2f54a-fm-20240515.001-g515a2f54
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <53adc3c6-9d79-405b-ae34-7a4c957a7bda@app.fastmail.com>
Date: Mon, 20 May 2024 21:50:04 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Thorsten Blum" <thorsten.blum@toblux.com>
Subject: [GIT PULL v2] asm-generic cleanups for 6.10
Content-Type: text/plain

The following changes since commit e67572cd2204894179d89bd7b984072f19313b03:

  Linux 6.9-rc6 (2024-04-28 13:47:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.10

for you to fetch changes up to 34cda5ab89d4f30bc8d8f8d28980a7b8c68db6ec:

  arch: Fix name collision with ACPI's video.o (2024-05-20 21:17:06 +0000)

----------------------------------------------------------------
asm-generic cleanups for 6.10

These are a few cross-architecture cleanup patches:

 - Thomas Zimmermann works on separating fbdev support from the asm/video.h
   contents that may be used by either the old fbdev drivers or the
   newer drm display code.

 - Thorsten Blum contributes cleanups for the generic bitops code
   and asm-generic/bug.h

 - I remove the orphaned include/asm-generic/page.h header that used to
   included by long-removed mmu-less architectures.

------------
I finally managed to resend this pull request after
merging another regression fix for the original
contents that were missing the tag on git.kernel.org
during my travels.

----------------------------------------------------------------
Arnd Bergmann (1):
      asm-generic: remove unused asm-generic/page.h

Thomas Zimmermann (4):
      arch: Select fbdev helpers with CONFIG_VIDEO
      arch: Remove struct fb_info from video helpers
      arch: Rename fbdev header and source files
      arch: Fix name collision with ACPI's video.o

Thorsten Blum (2):
      bitops: Change function return types from long to int
      bug: Improve comment

 arch/arc/include/asm/fb.h                    |   8 ---
 arch/arm/include/asm/fb.h                    |   6 --
 arch/arm64/include/asm/fb.h                  |  10 ---
 arch/loongarch/include/asm/{fb.h => video.h} |   8 +--
 arch/m68k/include/asm/{fb.h => video.h}      |   8 +--
 arch/mips/include/asm/{fb.h => video.h}      |  12 ++--
 arch/parisc/Makefile                         |   2 +-
 arch/parisc/include/asm/fb.h                 |  14 ----
 arch/parisc/include/asm/video.h              |  16 +++++
 arch/parisc/video/Makefile                   |   2 +-
 arch/parisc/video/{fbdev.c => video-sti.c}   |   9 +--
 arch/powerpc/include/asm/{fb.h => video.h}   |   8 +--
 arch/powerpc/kernel/pci-common.c             |   2 +-
 arch/sh/include/asm/fb.h                     |   7 --
 arch/sparc/Makefile                          |   4 +-
 arch/sparc/include/asm/{fb.h => video.h}     |  15 ++--
 arch/sparc/video/Makefile                    |   2 +-
 arch/sparc/video/fbdev.c                     |  26 -------
 arch/sparc/video/video-common.c              |  25 +++++++
 arch/um/include/asm/Kbuild                   |   2 +-
 arch/x86/Makefile                            |   2 +-
 arch/x86/include/asm/fb.h                    |  19 -----
 arch/x86/include/asm/video.h                 |  21 ++++++
 arch/x86/video/Makefile                      |   3 +-
 arch/x86/video/{fbdev.c => video-common.c}   |  21 +++---
 drivers/video/fbdev/core/fbcon.c             |   2 +-
 include/asm-generic/Kbuild                   |   2 +-
 include/asm-generic/bitops/__ffs.h           |   4 +-
 include/asm-generic/bitops/__fls.h           |   4 +-
 include/asm-generic/bitops/builtin-__ffs.h   |   2 +-
 include/asm-generic/bitops/builtin-__fls.h   |   2 +-
 include/asm-generic/bug.h                    |   2 +-
 include/asm-generic/page.h                   | 103 ---------------------------
 include/asm-generic/{fb.h => video.h}        |  17 ++---
 include/linux/bitops.h                       |   6 +-
 include/linux/fb.h                           |   2 +-
 tools/include/asm-generic/bitops/__ffs.h     |   4 +-
 tools/include/asm-generic/bitops/__fls.h     |   4 +-
 tools/include/linux/bitops.h                 |   2 +-
 39 files changed, 139 insertions(+), 269 deletions(-)
 delete mode 100644 arch/arc/include/asm/fb.h
 delete mode 100644 arch/arm/include/asm/fb.h
 delete mode 100644 arch/arm64/include/asm/fb.h
 rename arch/loongarch/include/asm/{fb.h => video.h} (86%)
 rename arch/m68k/include/asm/{fb.h => video.h} (86%)
 rename arch/mips/include/asm/{fb.h => video.h} (76%)
 delete mode 100644 arch/parisc/include/asm/fb.h
 create mode 100644 arch/parisc/include/asm/video.h
 rename arch/parisc/video/{fbdev.c => video-sti.c} (78%)
 rename arch/powerpc/include/asm/{fb.h => video.h} (76%)
 delete mode 100644 arch/sh/include/asm/fb.h
 rename arch/sparc/include/asm/{fb.h => video.h} (75%)
 delete mode 100644 arch/sparc/video/fbdev.c
 create mode 100644 arch/sparc/video/video-common.c
 delete mode 100644 arch/x86/include/asm/fb.h
 create mode 100644 arch/x86/include/asm/video.h
 rename arch/x86/video/{fbdev.c => video-common.c} (66%)
 delete mode 100644 include/asm-generic/page.h
 rename include/asm-generic/{fb.h => video.h} (89%)

