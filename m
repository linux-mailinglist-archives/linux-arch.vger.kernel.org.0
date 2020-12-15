Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE29A2DB05E
	for <lists+linux-arch@lfdr.de>; Tue, 15 Dec 2020 16:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbgLOPpa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Dec 2020 10:45:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:39284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729759AbgLOPpX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Dec 2020 10:45:23 -0500
X-Gm-Message-State: AOAM533SU483h9j5FaDvqFYdQU5R5wOqbWJ+ECkPcjoQb2AcdUp9ohjU
        W54xKigyA4IwZsFTuYJJYRZdlPnKFE3zYfwdubI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608047082;
        bh=Gq8LMLR91rFo8W9pr+dCd67kvCo8QVQOHrCljMBlRss=;
        h=From:Date:Subject:To:Cc:From;
        b=D2tUTNSLTCHoC4U1RqWO+LCwpiNvGRzfQrUwvB70hKU/yasG31tohQEworrGDKuhw
         YGjg0HtnEUiOWsFOC1c4poM5TXkZjzgldRr7LXF4mggA4FtZ0pcHuNx52TgZFqnaI2
         QjhSeAOEiDVSi13gxcMkr7YXFumaKJ99d6gocvqVmKxlwmqGspYIe8+K6Z3ehFvP8D
         kgWtpJYmrAVRx5bjsbtVj3jVYz0Df8iXOG5weDV6Oqs22JB8p5ulT9ZzvbwO33v9NF
         eP5dRaXjyeftMA+tF6E2I7WRPZnNgn4QDN96pp3JhxxxSHJF75tLeFaPOnIm+tztfn
         sAKtIkJokKKqw==
X-Google-Smtp-Source: ABdhPJysRJdqfZ+W7CVjHEypyQfXGhfHSev6k/D0M34euGUf3Yqmab+IYVu8E9QSMkGWOEyXnqYunuqSQ5Kp99wYiFM=
X-Received: by 2002:a05:6830:2413:: with SMTP id j19mr14952742ots.251.1608047081666;
 Tue, 15 Dec 2020 07:44:41 -0800 (PST)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 15 Dec 2020 16:44:25 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0b0u9NQ1unjQfwBJovahQYNgNj1ROLGR+TzZWKnzQgzQ@mail.gmail.com>
Message-ID: <CAK8P3a0b0u9NQ1unjQfwBJovahQYNgNj1ROLGR+TzZWKnzQgzQ@mail.gmail.com>
Subject: [GIT PULL 1/3] cleanups for v5.11
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
tags/asm-generic-cleanup-5.11

for you to fetch changes up to 8d0dd23c6c78d140ed2132f523592ddb4cea839f:

  syscalls: Fix file comments for syscalls implemented in kernel/sys.c
(2020-11-13 14:53:57 +0100)

----------------------------------------------------------------
asm-generic cleanups for v5.11

These are a couple of compiler warning fixes to make 'make W=2'
less noisy, as well as some fixes to code comments in asm-generic.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Arnd Bergmann (4):
      asm-generic: percpu: avoid Wshadow warning
      asm-generic: fix ffs -Wshadow warning
      qspinlock: use signed temporaries for cmpxchg
      ctype.h: remove duplicate isdigit() helper

Tal Zussman (1):
      syscalls: Fix file comments for syscalls implemented in kernel/sys.c

Viresh Kumar (1):
      asm-generic/sembuf: Update architecture related information in comment

 include/asm-generic/bitops/builtin-ffs.h |  5 +----
 include/asm-generic/percpu.h             | 18 +++++++++---------
 include/asm-generic/qrwlock.h            |  8 ++++----
 include/asm-generic/qspinlock.h          |  4 ++--
 include/linux/compiler_types.h           | 11 +++++++++++
 include/linux/ctype.h                    | 15 +++++++++++----
 include/linux/syscalls.h                 |  2 +-
 include/uapi/asm-generic/sembuf.h        |  6 +++---
 include/uapi/asm-generic/unistd.h        |  2 +-
 9 files changed, 43 insertions(+), 28 deletions(-)
