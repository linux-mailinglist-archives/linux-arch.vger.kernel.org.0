Return-Path: <linux-arch+bounces-10882-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B3AA62B5D
	for <lists+linux-arch@lfdr.de>; Sat, 15 Mar 2025 11:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D0117A8E2
	for <lists+linux-arch@lfdr.de>; Sat, 15 Mar 2025 10:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE3D1F582A;
	Sat, 15 Mar 2025 10:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeGm8n/1"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28741DFED;
	Sat, 15 Mar 2025 10:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742036357; cv=none; b=SESsnxwjAJOlmzeU4NfXWDTBdHeQYH3COzVzR5jiUCXSae4SV31679ipwre5nAeV+sMBA+CGzPZ/+eH5FPCXSdSdcmbHM3pEMfS7u1Qd2+M0aZx/Pob65JrnUPv4m4r5RAk5dgdD1jBUdIpUNQN/2efKtZbyGMt7LDdgO6PP8Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742036357; c=relaxed/simple;
	bh=iNj1uai8aBt7DaA8QRTxehgmfPjURYUtO7lvJ9FyPYE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UcK00CFtR3oOVNeUxY775/obo6TKN7fomsztc3W/KR268KIhKMMFG75U35lp2Af3l+FWBGYvqG7E31EVM/jKNXFYAdMOp5J0bC94ReUu4reERW/arrotRQUEwYVRgqi9WKqHUavwDtECxF6t+huqwWcw09+NCrG35XLgGeV7ieY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeGm8n/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7029DC4CEE5;
	Sat, 15 Mar 2025 10:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742036357;
	bh=iNj1uai8aBt7DaA8QRTxehgmfPjURYUtO7lvJ9FyPYE=;
	h=From:To:Cc:Subject:Date:From;
	b=QeGm8n/1yaBlknAiTM9PbcGBvfecLE14NaWyggw7irJxQ9ZUD4gwqWeD6R+76W8+o
	 5gZQY1kDfZgbS3U5Ra1LSv3PhQMXoT5G/0Dkekya8DP5aDGcA/Nui9Iw/HTHBij+GU
	 KaOwiwXausYMh5f+P2Dhq3ZRMVh0bV870WhMtPWKeMqxj3BUGb6y9gI31eLbZi6tpu
	 2yddEKW6LavqZ+2iOUFrf5fg3qxiiVYyA5TbVg5+qaqjOZDpQJzNk/oRrL9Stu5ouB
	 IwMueWvL5VGHzPMBsUALBkRyLFmjUPO0kQAnAqcZ0HX4E2/y0YbuJD6CcBwjOue+pl
	 IOVRtFaA0/coQ==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Julian Vetter <julian@outer-limits.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org
Subject: [PATCH 0/6] asm-generic: io.h cleanups
Date: Sat, 15 Mar 2025 11:59:01 +0100
Message-Id: <20250315105907.1275012-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

After the previous round of cleanups for asm-generic/io,h on the
ioread64 helpers, I had another look at the architecture specific
versions, especially those that caused build failures in the past.

These are some simplifications that I would like to merge at the same
time, please have a look. Hopefully these are all uncontroversial.

I have a few more patches for m68k that need a more thorough
review and testing, will post them after the merge window.

Arnd Bergmann (6):
  alpha: stop using asm-generic/iomap.h
  sh: remove duplicate ioread/iowrite helpers
  parisc: stop using asm-generic/iomap.h
  powerpc: asm/io.h: remove split ioread64/iowrite64 helpers
  mips: drop GENERIC_IOMAP wrapper
  m68k/nommu: stop using GENERIC_IOMAP

 arch/alpha/include/asm/io.h   |  31 ++++---
 arch/m68k/Kconfig             |   2 +-
 arch/m68k/include/asm/io_no.h |   4 -
 arch/mips/Kconfig             |   2 +-
 arch/mips/include/asm/io.h    |  21 ++---
 arch/mips/lib/iomap-pci.c     |   9 ++
 arch/parisc/include/asm/io.h  |  36 ++++++--
 arch/powerpc/include/asm/io.h |  48 ----------
 arch/sh/include/asm/io.h      |  30 ++-----
 arch/sh/kernel/Makefile       |   3 -
 arch/sh/kernel/iomap.c        | 162 ----------------------------------
 arch/sh/kernel/ioport.c       |   5 --
 arch/sh/lib/io.c              |   4 +-
 drivers/sh/clk/cpg.c          |  25 +++---
 14 files changed, 84 insertions(+), 298 deletions(-)
 delete mode 100644 arch/sh/kernel/iomap.c

-- 
2.39.5

Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Ungerer <gerg@linux-m68k.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Julian Vetter <julian@outer-limits.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-alpha@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-sh@vger.kernel.org

