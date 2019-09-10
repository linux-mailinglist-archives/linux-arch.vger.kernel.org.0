Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36E64AE74B
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2019 11:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfIJJtR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Sep 2019 05:49:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41827 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbfIJJtR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Sep 2019 05:49:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id j10so19892965qtp.8;
        Tue, 10 Sep 2019 02:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=JSfsPm8OOMeroYM52zzFmiDbu7+5YUx10p0JkzA7dx8=;
        b=JopmYea3fE/w7QNA+xqWMpc03gAJFWEUUKvn1DjtHmErGCeCsyTXzPgui+vnKE2WM5
         KSGfybAPB5lgPMtCXRDMKbK5/yda9nSWcFDKqnMKUbbMnk7H7RGzKTiYVTKxiq18UWse
         8stNwCMEKtLzoR7m9iNfKgS4/+oXKFM5v+SMEWoWMBvjpl4+b8ivgprvvXEw/iy/Plxb
         iCTMKhYdyLIUCo6jFoAVvYoYN7DewMtWzvaT81D6eirmpc7pREPUFals3Ks7xSuXewhD
         YUByY5lheeCREozeWVg4KsehMPub3eNkV4Ij+kilW1K96O7IUX6QJs+ipfw8VV6u1IXL
         v1Ag==
X-Gm-Message-State: APjAAAXtazMCTXTfNg7u2xW/ScG1V92C8uOlkonS9DmXvKM4xyyNWZgW
        6cOp89pML1yjOz5XLcNK30Ir0CsH6yo5VqC/9uY=
X-Google-Smtp-Source: APXvYqwbr3u1y02e76/2W3wSR+GwWdg6PJL3TQGf0P0/L96UbtcPJGij9lMatNR5TFbo8oM/JpY3M7Bf7OBjM81fXAY=
X-Received: by 2002:ac8:5306:: with SMTP id t6mr27972543qtn.204.1568108956064;
 Tue, 10 Sep 2019 02:49:16 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 10 Sep 2019 11:49:00 +0200
Message-ID: <CAK8P3a1Q0ec50n2ueWDKHirpem+SQvsv3sYXzw9EFRqXiUqxUg@mail.gmail.com>
Subject: [GIT PULL] ipc: fix regressions from y2038 patches
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        sparclinux <sparclinux@vger.kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Anatoly Pugachev <matorola@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guo Ren <guoren@kernel.org>, Stafford Horne <shorne@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Manfred Spraul <manfred@colorfullife.com>,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit 089cf7f6ecb266b6a4164919a2e69bd2f938374a:

  Linux 5.3-rc7 (2019-09-02 09:57:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
tags/ipc-fixes

for you to fetch changes up to fb377eb80c80339b580831a3c0fcce34a4c9d1ad:

  ipc: fix sparc64 ipc() wrapper (2019-09-07 21:42:25 +0200)

----------------------------------------------------------------
ipc: fix regressions from y2038 patches

These are two regression fixes for bugs that got introduced
during the system call rework that went into linux-5.1
but only bisected and fixed now:

- One patch affects semtimedop() on many of the less
  common 32-bit architectures, this just needs a single-line
  bugfix.

- The other affects only sparc64 and has a slightly more
  invasive workaround to apply the same change to sparc64
  that was done to the generic code used everywhere else.

----------------------------------------------------------------
Arnd Bergmann (2):
      ipc: fix semtimedop for generic 32-bit architectures
      ipc: fix sparc64 ipc() wrapper

 arch/sparc/kernel/sys_sparc_64.c  | 33 ++++++++++++++++++---------------
 include/linux/syscalls.h          | 19 +++++++++++++++++++
 include/uapi/asm-generic/unistd.h |  2 +-
 ipc/util.h                        | 25 ++-----------------------
 4 files changed, 40 insertions(+), 39 deletions(-)
