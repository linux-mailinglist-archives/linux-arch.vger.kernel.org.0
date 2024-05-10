Return-Path: <linux-arch+bounces-4299-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5533D8C2BA1
	for <lists+linux-arch@lfdr.de>; Fri, 10 May 2024 23:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABAEFB20FB0
	for <lists+linux-arch@lfdr.de>; Fri, 10 May 2024 21:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC5713B59A;
	Fri, 10 May 2024 21:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="YXuAbqT9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OixIMjMA"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F00F524DC;
	Fri, 10 May 2024 21:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715375844; cv=none; b=n31wW6X2RUcVgEyr8zH0Ir8zeey0lhyMhuXBb4Ujkcl6MpkHO7yFEtiFCfGzg6fAtv2rcneSD7wdZziaKLaOZvdle9qHUVEsu3XxU2unIdwTm3ZSatXZF4s+fW4ZQd+6QOJZMPAZuWg0pFfSrce9WnvbYn4C56DvoFfulxw2NVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715375844; c=relaxed/simple;
	bh=bWQC6lV3mqoeD87LJGVSqVODNca3khuMuUy0rf87F6U=;
	h=MIME-Version:Message-Id:Date:From:To:Cc:Subject:Content-Type; b=cauKENsxQk5TR9RNlGJkZGzAIkVlBFp4BZEIxl+SzpjT93Kmo4LMk/wMo9PBXdB3aMpKFXVpnCDsSuf2aYnUi3Alz09jC6rXp9K8VSA14eIYxDCT0BFq9ZSG7f+RRTndFHvmYk6GfBFV3dFjQ/4C4cmA1eWIt/RzKDEz+AxfqxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=YXuAbqT9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OixIMjMA; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4E95D1380198;
	Fri, 10 May 2024 17:17:22 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 10 May 2024 17:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1715375842; x=1715462242; bh=v3H+7HXF8T+kySUKuBhyYMuYXxAB8OA6
	iDwne/b21KE=; b=YXuAbqT9odp4Wd11GgM9g5Q29Culb08siw95U5RYJ5XOCLw4
	GWjq00oV91SD7t1gKvHBgOvkVawee4wIdjvIEVpv1SJ/Znd73OOAzFfYYBQMqgPd
	bXMPMAtfRuH70Vp2eIH5kVHZliFnlTi4NCnvcVSYp7kO1iNxmWwrUQjABq+TBlr0
	sHMz+CNnRHdeRfQOKJP2253DS2Nxk1XDrWJ4ml2fXLmUf296pCI7Yv+0J8ULLJqS
	jmYWlgrb/N+Rrm6zCCdd1UV/bIRWf5Kckvg1C9C0+AK+5hw6xLSbnO3dkpNUHPZM
	S1xpXI6GdgTfd5fdNDINXQoePvTP3qouGGeb5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1715375842; x=1715462242; bh=v3H+7HXF8T+kySUKuBhyYMuYXxAB8OA6iDw
	ne/b21KE=; b=OixIMjMADNdAFad7PnzhrJCIvXXSi5TJ3SbdOaPIRI7DM04aYxR
	GrFbkVYSfZp/rg9xtMFn0KDFHdxj0jmixwaxYlxO5tcaO+uU2Mr5e8r/AqIQXSJv
	7GDJtRxtvYepJHi5Angb3LlVo1krhd8jqGjysXMrQLPDvaKjryXA/RA0l7w8BE/e
	uZVYHklG3IqVXRy7IugbOM2810/c5WaMZnhmu/nsE20G8G0Ac0TSiBlOqQIsPLlx
	AHfWRTI43nx7hZKGi9ncJbHsd3t7H9oy5D8BGMW/+uGes1YuhzjoZv2lRquGL7TD
	b/lEVIwuNh+see4f130gOybftFpSt88Wh9g==
X-ME-Sender: <xms:4o4-ZnFiQrWvmwNxrCLRIq2JDKXDuI61W-SarcHcX3uRjIyr68nlSw>
    <xme:4o4-ZkWM19fFY18XkOFvP--4p06qohk6SA-MFjNJS2CfKiayte9ciJyfixBOjyj-3
    2goUhYrPhpZVPfyaUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeeffeeuhfekjeevtddvtdelledttddtjeegvdfhtdduvdfhueekudeihfejtefg
    ieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:4o4-ZpIPyauUECv2dvZbW-fXrJDQlMxENdbbVTRBG4jkMhBixm6eOQ>
    <xmx:4o4-ZlE5FAT5SJ-eNGW3lFkv4qjH860E4rcl9VbsDRWazVWoICOY3g>
    <xmx:4o4-ZtXxCjlteTo5h93zkAATKZQKkpRI-9EdzCFCaz-a2wbZM3pYaQ>
    <xmx:4o4-ZgPyMEZQ_ZSqfvbzeO0jO9AUOSBC_-AiAaGqZblxPLLsRe8lRQ>
    <xmx:4o4-ZjwKFW4XhBOwH2DrpdqN8uKgRMjYNYE73BSe2B4ZokFb-B1UT9CZ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id EE73CB6008D; Fri, 10 May 2024 17:17:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-443-g0dc955c2a-fm-20240507.001-g0dc955c2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <71feb004-82ef-4c7b-9e21-0264607e4b20@app.fastmail.com>
Date: Fri, 10 May 2024 23:17:01 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Thorsten Blum" <thorsten.blum@toblux.com>
Subject: [GIT PULL] asm-generic cleanups for 6.10
Content-Type: text/plain

The following changes since commit e67572cd2204894179d89bd7b984072f19313b03:

  Linux 6.9-rc6 (2024-04-28 13:47:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic-6.10

for you to fetch changes up to e7cda7fe37ff1ece39bd2bf35ea68b1175395d95:

  bug: Improve comment (2024-05-07 14:20:48 +0200)

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

----------------------------------------------------------------
Arnd Bergmann (1):
      asm-generic: remove unused asm-generic/page.h

Thomas Zimmermann (3):
      arch: Select fbdev helpers with CONFIG_VIDEO
      arch: Remove struct fb_info from video helpers
      arch: Rename fbdev header and source files

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
 arch/sparc/video/video.c                     |  25 +++++++
 arch/um/include/asm/Kbuild                   |   2 +-
 arch/x86/Makefile                            |   2 +-
 arch/x86/include/asm/fb.h                    |  19 -----
 arch/x86/include/asm/video.h                 |  21 ++++++
 arch/x86/video/Makefile                      |   3 +-
 arch/x86/video/{fbdev.c => video.c}          |  21 +++---
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
 create mode 100644 arch/sparc/video/video.c
 delete mode 100644 arch/x86/include/asm/fb.h
 create mode 100644 arch/x86/include/asm/video.h
 rename arch/x86/video/{fbdev.c => video.c} (66%)
 delete mode 100644 include/asm-generic/page.h
 rename include/asm-generic/{fb.h => video.h} (89%)

