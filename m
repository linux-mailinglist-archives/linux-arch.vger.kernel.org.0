Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541DE3BACB4
	for <lists+linux-arch@lfdr.de>; Sun,  4 Jul 2021 12:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhGDKOA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 4 Jul 2021 06:14:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhGDKOA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 4 Jul 2021 06:14:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2391613F7;
        Sun,  4 Jul 2021 10:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625393485;
        bh=Z+/9jj6fSBcVHfl30yREhfjROWMcG0Qwh5mocBBC6aQ=;
        h=From:To:Cc:Subject:Date:From;
        b=oecyY/fy4ZdQg5L+WF9XIcFwplcgd6mBMqD7PJ58eIwyZB7jktGHx/ZWEw1G00SfB
         F7NHme/nTusjeZOsxYN0iE4fOfVPARFdR7eJFUPhx9pHEaxvLjNzlWinKeuUs3Xh5w
         k/Fsb8atKfsN/B7aFKMbJ+TOsPzkKISAMJTd72xy+Ot8prAjyd1c2jaPludefO+SjF
         Z4hZHYB92/b6KHttlosIvUhiatItdKfpXD/M7rmnf2p/+D5bI1NYdaQeITbMRTdABT
         iTaCKm2nQF8ScTPTSCYrz8oLQGAsf4mDaa6XWh9mCXG6Nv0BgWLDxLBo6u2LtjJKD3
         3bjFu/Sg75TnQ==
From:   guoren@kernel.org
To:     torvalds@linux-foundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-csky@vger.kernel.org
Subject: [GIT PULL] csky changes for v5.14-rc1
Date:   Sun,  4 Jul 2021 18:11:20 +0800
Message-Id: <20210704101120.104842-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Linus,

The following changes since commit 13311e74253fe64329390df80bed3f07314ddd61:

  Linux 5.13-rc7 (2021-06-20 15:03:15 -0700)

are available in the Git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.14-rc1

for you to fetch changes up to 90dc8c0e664efcb14e2f133309d84bfdcb0b3d24:

  csky: Kconfig: Remove unused selects (2021-07-04 17:39:54 +0800)

----------------------------------------------------------------
arch/csky patches for 5.14-rc1

Two small cleanup & fixup.

----------------------------------------------------------------
Guo Ren (2):
      csky: syscache: Fixup duplicate cache flush
      csky: Kconfig: Remove unused selects

 arch/csky/Kconfig       |  3 ---
 arch/csky/mm/syscache.c | 12 +++++++-----
 2 files changed, 7 insertions(+), 8 deletions(-)
