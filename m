Return-Path: <linux-arch+bounces-9249-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1176A9E5680
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2024 14:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E58C7169740
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2024 13:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C85218EA1;
	Thu,  5 Dec 2024 13:20:59 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081E9218AA8
	for <linux-arch@vger.kernel.org>; Thu,  5 Dec 2024 13:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733404859; cv=none; b=TD3yfXBd3ehYuY+zjq+YLLyFWhZHbhaLTsWg9K/NqV1Q+Uckqb3oBZCetfC5Dni51/O3Y4eU/247u4HIWJLM+8pDtvlj7pxWJ8oFgovgUceWgn5S6dsdJ0tiLt6+/bw4evTEe/wFzinRDWxZncOa3PVz0nlQAE3CRayp0F19+7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733404859; c=relaxed/simple;
	bh=TwCVMEaIFCU/f0bq7GD0tlIQDJxi7Q9XSUB8F8uYgp0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fow/Ve9jML7HMFljAEso49WE4bIlta42s+gKCyTLF/877wSPl12eHt3Sr3F+MwzwC1iz4YUfP14QepSqJBHSXoMWeCKqvzhyrbDQHw5v1faThBzz9CYU4vVkP2ZhndAycmE2NrQDyFOwMwxByy9tdV1dUggv/W6W8iWMiLVRbHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:b16a:6561:fa1:2b32])
	by laurent.telenet-ops.be with cmsmtp
	id l1Lo2D00D3EEtj2011LoH3; Thu, 05 Dec 2024 14:20:54 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tJBmh-000LQl-Hr;
	Thu, 05 Dec 2024 14:20:48 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tJBmi-00EQdL-8s;
	Thu, 05 Dec 2024 14:20:48 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Oleg Nesterov <oleg@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-arch@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3] Update reference to include/asm-<arch>
Date: Thu,  5 Dec 2024 14:20:41 +0100
Message-Id: <cover.1733404444.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

Despite "include/asm-<arch>" having been replaced by
"arch/<arch>/include/asm" 15 years ago, there are still several
references left.

This patch series updates the most visible ones.

Thanks for your comments!

Geert Uytterhoeven (3):
  checkpatch: Update reference to include/asm-<arch>
  kbuild: Drop support for include/asm-<arch> in headers_check.pl
  include: Update references to include/asm-<arch>

 include/asm-generic/syscall.h | 2 +-
 include/linux/bitmap.h        | 2 +-
 include/linux/types.h         | 2 +-
 scripts/checkpatch.pl         | 2 +-
 usr/include/headers_check.pl  | 4 ----
 5 files changed, 4 insertions(+), 8 deletions(-)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

