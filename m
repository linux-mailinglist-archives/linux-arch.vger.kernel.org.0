Return-Path: <linux-arch+bounces-420-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 271C07F5D3A
	for <lists+linux-arch@lfdr.de>; Thu, 23 Nov 2023 12:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC7B1C20DFD
	for <lists+linux-arch@lfdr.de>; Thu, 23 Nov 2023 11:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB0222EE2;
	Thu, 23 Nov 2023 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9YhBGVo"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EF8225AE;
	Thu, 23 Nov 2023 11:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C85C433C7;
	Thu, 23 Nov 2023 11:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700737521;
	bh=kmSnZk3RczC2wW7hFftznkdHr9ZkDg70PDOUA+ZVjaE=;
	h=From:To:Cc:Subject:Date:From;
	b=M9YhBGVoZhY2hbzM62ATfyVt/7tQ/oQ/qZpdbJ2qea36LpolKDbmowhX0AC5g7lLk
	 sieaJZf1+aJIe6RlnZFwpUWbe/PNidPyvX1032SN/Lwqzuba5orpijIZqVQRxHnO8W
	 LRftkoW7bXxIrXatQbuFQGzAdw2elNRJIxC3rIjn2qQVQcfC9JkzCiX6xGNFCITeE3
	 AOg4JIWtddSPTOo6FzQGoFztM6o4Hy4i/nts34VgnTPpGB8h4PDw8YDdN3d0w6RELS
	 lnxhloqHqGtyXUCmF3Imyl4OpgK7uvUX4NtIedFziLAPEYOAuGarmedGM1FejKTB+G
	 xC85zbozSZrPA==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	David Woodhouse <dwmw2@infradead.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Matt Turner <mattst88@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Peter Zijlstra <peterz@infradead.org>,
	Rich Felker <dalias@libc.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Richard Weinberger <richard@nod.at>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-sh@vger.kernel.org,
	linux-usb@vger.kernel.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v3 0/6] Treewide: enable -Wmissing-prototypes
Date: Thu, 23 Nov 2023 12:05:00 +0100
Message-Id: <20231123110506.707903-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Hi Andrew,

I think all other patches I have sent for -Wmissing-prototypes have made it
into linux-next by now, these ones either got an Ack from the respective
maintainers, or never got a reply. I just merged a few patches from my
previous series into the asm-generic tree, these are not in linux-next
today but should be for the next next. I also resent the powerpc patches
to make sure they get merged soon.

Can you pick these six up into -mm for v6.8?

Quoting from my description to patch 6/6:
  "At this point, there are five architectures with a number of known
   regressions: alpha, nios2, mips, sh and sparc. In the previous version
   of this patch, I had turned off the missing prototype warnings for the 15
   architectures that still had issues, but since there are only five left,
   I think we can leave the rest to the maintainers (Cc'd here) as well."

The series is also likely to cause occasional build regressions on linux-next
as developers add new code that misses prototypes. Hopefully this should
be resolved by the time the patches make it into a release and everyone
gets the warnings right away.

    Arnd

Arnd Bergmann (6):
  ida: make 'ida_dump' static
  jffs2: mark __jffs2_dbg_superblock_counts() static
  sched: fair: move unused stub functions to header
  x86: sta2x11: include header for sta2x11_get_instance() prototype
  usb: fsl-mph-dr-of: mark fsl_usb2_mpc5121_init() static
  Makefile.extrawarn: turn on missing-prototypes globally

 arch/x86/pci/sta2x11-fixup.c     |  1 +
 drivers/usb/host/fsl-mph-dr-of.c |  2 +-
 fs/jffs2/debug.c                 |  2 +-
 kernel/sched/fair.c              | 13 -------------
 kernel/sched/sched.h             | 11 +++++++++++
 lib/test_ida.c                   |  2 +-
 scripts/Makefile.extrawarn       |  4 ++--
 7 files changed, 17 insertions(+), 18 deletions(-)

-- 
2.39.2

Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rich Felker <dalias@libc.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-arch@vger.kernel.org
Cc: linux-alpha@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-mtd@lists.infradead.org
Cc: linux-sh@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: x86@kernel.org

