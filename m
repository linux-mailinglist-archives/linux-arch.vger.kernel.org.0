Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029CB3079E2
	for <lists+linux-arch@lfdr.de>; Thu, 28 Jan 2021 16:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhA1Pgz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 Jan 2021 10:36:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:60138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231734AbhA1Pgx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 28 Jan 2021 10:36:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58AC664DF6;
        Thu, 28 Jan 2021 15:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611848172;
        bh=SZe1atd52ul7NwgAh5nbYAq/K9Mgj2qkqmtovGsXEB0=;
        h=From:Date:Subject:To:Cc:From;
        b=Pncw16Rptx1XmV6fDUdRkHJP6iYOcH7SmWiKM1Y9ZfwL5sXx0OEzggxLCh39IJmw4
         YGLst5VK7W6IRC8hlfxBYdMVqt5LaqR/Y6zFvFNKCt1rJbPwtWBGUmbbsbwItFwmZL
         FmUmZee3sd1MM1OCWAOLO2w4KD38UfHWYcgwit+PKaOW+G2bbG1rfpGYY8wd98KsNw
         8ZH3wWkEAkUdj7rtbIZLBjFjI0EZoWtspempTyerZArujuQNVr/ddcyE7kHimDX8sT
         195TFLPcV26cKAvD999gSwPcPvl1YubJLehwcdx+DIlroIwwzKE8zw3o3XlOTBchjO
         0lyOhaXtPS1Kg==
Received: by mail-oi1-f177.google.com with SMTP id a77so6425375oii.4;
        Thu, 28 Jan 2021 07:36:12 -0800 (PST)
X-Gm-Message-State: AOAM5302q1v2hZrxn4PtZi9mNtYWMBaRrjXkTbloTsynu7aTIlALJ44K
        z7lekvXwYxYec+UFLmpmoeFZOt75fg5E5XeuIQE=
X-Google-Smtp-Source: ABdhPJy4cjus9by7PS47ZyvwLRq6mjFpIaaoXwZUHmSJbfTAFRgYBQFeSLPAKm0DMaxkZj2g1sZivzTgQLrgr6VXzeg=
X-Received: by 2002:aca:eb0a:: with SMTP id j10mr6960946oih.4.1611848171666;
 Thu, 28 Jan 2021 07:36:11 -0800 (PST)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 28 Jan 2021 16:35:55 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2+tvr6O7LxF8M6sJ-e-NmbijAmXt13FPEvOXtY_PSgPQ@mail.gmail.com>
Message-ID: <CAK8P3a2+tvr6O7LxF8M6sJ-e-NmbijAmXt13FPEvOXtY_PSgPQ@mail.gmail.com>
Subject: [GIT PULL] asm-generic/ia64 fixes, mark as orphaned
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
tags/asm-generic-fixes-v5.11

for you to fetch changes up to 96ec72a3425d1515b69b7f9dc34a4a6ce5862a37:

  ia64: Mark architecture as orphaned (2021-01-12 17:03:04 +0100)

----------------------------------------------------------------
asm-generic/ia64 fixes, mark as orphaned

Commit 2b49ddcef297 ("ia64: convert to legacy_timer_tick") from my timer
series I merged through the asm-generic tree caused a regression on all
ia64 machines, as bisected by Adrian Glaubitz.

Tony Luck is no longer really working on ia64, so instead of merging the
fix through his tree, we ended up deciding that I'd merge the fix myself
along a patch to mark the architecture as Orphaned and a compile time
warning fix I made while working on the regression.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Arnd Bergmann (3):
      ia64: fix timer cleanup regression
      ia64: fix xchg() warning
      ia64: Mark architecture as orphaned

 MAINTAINERS                          |  5 +----
 arch/ia64/include/uapi/asm/cmpxchg.h |  2 +-
 arch/ia64/kernel/time.c              | 31 ++++++++++++++++++-------------
 3 files changed, 20 insertions(+), 18 deletions(-)
