Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FCE42FFA2
	for <lists+linux-arch@lfdr.de>; Sat, 16 Oct 2021 03:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239522AbhJPBXN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Oct 2021 21:23:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233157AbhJPBXN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 Oct 2021 21:23:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69CE96109E;
        Sat, 16 Oct 2021 01:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634347266;
        bh=kfmLpi/q+nIQBcUYMuONZzS9ikpiXBqPHhOBUbImCD8=;
        h=From:To:Cc:Subject:Date:From;
        b=O8hjmnh64xj9iRd303Qns/Ruxp80ja4H+mw0Gqi56kV0nE/fmS+R4iO1VSnnz1DoX
         sz3zWSP+xGDAzPRymzSC+dDp8EzMtk4ZTY12TD2lohG2tv+4G5u1xcNe9Ono5Yr6OK
         oTBkXA+xSMlo+Q+HuCTzIOYLvpzxRYS+1BYn2MCosXCiG9YSuhcR8afQKmy66c/BqK
         TcqhANte28iM6451XDjEL1NfSCCSdPQI/eLI13+U3KrEMLgKafAkBAEQGIaVq/+n3F
         NA8Q5D6FSfpnWB7GcP+uitaXaDomxLCr63zakcLS6l0/vgSxE0MnZx51GL5pKzMWJ9
         3XG7lYgr0ucXg==
From:   guoren@kernel.org
To:     torvalds@linux-foundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
        guoren@kernel.org
Subject: [GIT PULL] csky fixes for v5.15-rc6
Date:   Sat, 16 Oct 2021 09:21:01 +0800
Message-Id: <20211016012101.2862669-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Linus:

The following changes since commit 64570fbc14f8d7cb3fe3995f20e26bc25ce4b2cc:

  Linux 5.15-rc5 (2021-10-10 17:01:59 -0700)

are available in the Git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.15-rc6

for you to fetch changes up to e21e52ad1e0126e2a5e2013084ac3f47cf1e887a:

  csky: Make HAVE_TCM depend on !COMPILE_TEST (2021-10-16 07:20:12 +0800)

----------------------------------------------------------------
csky updates for 5.15-rc6

Only 5 fixups:
 - Make HAVE_TCM depend on !COMPILE_TEST
 - bitops: Remove duplicate __clear_bit define
 - Select ARCH_WANT_FRAME_POINTERS only if compiler supports it
 - Fixup regs.sr broken in ptrace
 - don't let sigreturn play with priveleged bits of status register

----------------------------------------------------------------
Al Viro (1):
      csky: don't let sigreturn play with priveleged bits of status register

Guenter Roeck (3):
      csky: Select ARCH_WANT_FRAME_POINTERS only if compiler supports it
      csky: bitops: Remove duplicate __clear_bit define
      csky: Make HAVE_TCM depend on !COMPILE_TEST

Guo Ren (1):
      csky: Fixup regs.sr broken in ptrace

 arch/csky/Kconfig              | 3 ++-
 arch/csky/include/asm/bitops.h | 1 -
 arch/csky/kernel/ptrace.c      | 3 ++-
 arch/csky/kernel/signal.c      | 4 ++++
 4 files changed, 8 insertions(+), 3 deletions(-)
