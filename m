Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4200371DA8
	for <lists+linux-arch@lfdr.de>; Mon,  3 May 2021 19:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbhECRB7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 May 2021 13:01:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234046AbhECQ5P (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 3 May 2021 12:57:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D242E613B4;
        Mon,  3 May 2021 16:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620060323;
        bh=oi5bO6bb5cIPiSpAoSC0MOSDVY4cx8DHHmwOqrU9XFU=;
        h=From:To:Cc:Subject:Date:From;
        b=Gkq//34Fs6e1bFfdn+8/2CwcamY8poDJrX80lHCL1DWMBDPaHRJ8zRFwJj+41wTSw
         tFDYryJOjROvP68unYv8j23WlG+CsqjskAZ4Y8LoUkkJ5gz5ZKP4G2Y8ykctJxCS1I
         Il++JQxsBOU9uOTjgAnl+AOHiXT9QMhmZMUTUclzQhOc/BJqc2BQG8vnIawyvqql1O
         yn/Ft7ZXQj2hQ5GwtsGae08dAI4dEDxHPuRCJhCqBpNaTQ/fVxeNukhCdj8eoAW9el
         /lc5ejYv0skCz75O+jLksr3lKGi7o/IugScNiE04EHdaBUTLTEhnHCZ09ZMplU7icV
         +kQrXXCWrQiNg==
From:   guoren@kernel.org
To:     torvalds@linux-foundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-csky@vger.kernel.org
Subject: [GIT PULL] csky changes for v5.13-rc1
Date:   Tue,  4 May 2021 00:45:18 +0800
Message-Id: <20210503164518.33972-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Linus,

The following changes since commit bf05bf16c76bb44ab5156223e1e58e26dfe30a88:

  Linux 5.12-rc8 (2021-04-18 14:45:32 -0700)

are available in the Git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.13-rc1

for you to fetch changes up to e58a41c2226847fb1446f3942dc1b55af8acfe02:

  csky: uaccess.h: Coding convention with asm generic (2021-04-28 23:02:23 +0800)

----------------------------------------------------------------
arch/csky patches for 5.13-rc1

Just 1 feature and 3 fixups.

----------------------------------------------------------------
Guo Ren (1):
      csky: uaccess.h: Coding convention with asm generic

Junlin Yang (1):
      csky: Fixup typos

Randy Dunlap (1):
      csky: fix syscache.c fallthrough warning

Zhang Yunkai (1):
      csky: Remove duplicate include in arch/csky/kernel/entry.S

 arch/csky/include/asm/Kbuild    |   1 +
 arch/csky/include/asm/asid.h    |   2 +-
 arch/csky/include/asm/barrier.h |   2 +-
 arch/csky/include/asm/segment.h |   7 -
 arch/csky/include/asm/uaccess.h | 452 ++++++++++++----------------------------
 arch/csky/include/asm/vdso.h    |   2 +-
 arch/csky/kernel/entry.S        |   1 -
 arch/csky/lib/usercopy.c        | 364 ++++++++++++++++++--------------
 arch/csky/mm/fault.c            |   2 +-
 arch/csky/mm/syscache.c         |   1 +
 10 files changed, 349 insertions(+), 485 deletions(-)
