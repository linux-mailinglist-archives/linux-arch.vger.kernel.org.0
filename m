Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAF53206B0
	for <lists+linux-arch@lfdr.de>; Thu, 16 May 2019 14:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfEPMJ0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 May 2019 08:09:26 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33554 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfEPMJ0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 May 2019 08:09:26 -0400
Received: by mail-qt1-f194.google.com with SMTP id m32so3577305qtf.0;
        Thu, 16 May 2019 05:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=sbCp/GCfPLOrsqUDUZupXIkiqQehtjofpHZjd/C2f6o=;
        b=phelwJK8avCLBE9VXGx5pnGXWN+omtK2q31jJBTwyrHn6SIWbRzgZWNUmQsg7/Wh4M
         UPT6h5jDQjL23AW88V5OUxw22yZ9AIi2/e7wbEMdK5F4dGzzJYDBpkE4yVpis5H2mM8f
         Yf6Q3soyczKNloj/9CP7uWUcsaunrZGwqr/nl7druhIps1+mtGN/dG5AxJfsVsnqbyi8
         Tk5A/LVPO/c5QB7WDMld5ZaxXxJo+jnrCJtESfnLOGfBg8bIzuKSWC7T7lbzQo1HLah8
         BmiACIkEf6Y1NJCTmTPP3g8HfBBiuAxgymFuD48Du0VpeZ99rIOkE//lB/yN/yIXXtUm
         9Ttg==
X-Gm-Message-State: APjAAAUbO+TkT6LE8GgO7P14eEHD1eA4tko693Xr4fWkEKco47qyqnnW
        vZv9ifVaM55YUScaZnl9wU3o0Lzs6NiaWdhl6vp2uDFMXjkCxg==
X-Google-Smtp-Source: APXvYqzpzoVn5D71fCLV7vftzgJjrpvGFK62g44SGJIS0A8jQiFvVPdcRTVpTxMHZpVzhMI2xYLwhWxRYcibR4GNA+Q=
X-Received: by 2002:ac8:1c53:: with SMTP id j19mr41777461qtk.152.1558008564993;
 Thu, 16 May 2019 05:09:24 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 May 2019 14:09:08 +0200
Message-ID: <CAK8P3a2+RHAReOZdo8nEvqDeC1EPj83L2Ug4JuVRiUh943AuNw@mail.gmail.com>
Subject: [GIT PULL] asm-generic: kill <asm/segment.h> and improve nommu
 generic uaccess helpers
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[back from vacation now, sorry for the late pull request for this merge window]

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
tags/asm-generic-nommu

for you to fetch changes up to 6edd1dbace0e8529ed167e8a5f9da63c0cc763cc:

  asm-generic: optimize generic uaccess for 8-byte loads and stores
(2019-04-23 21:51:41 +0200)

----------------------------------------------------------------
asm-generic: kill <asm/segment.h> and improve nommu generic uaccess helpers

Christoph Hellwig writes:

  This is a series doing two somewhat interwinded things.  It improves
  the asm-generic nommu uaccess helper to optionally be entirely generic
  and not require any arch helpers for the actual uaccess.  For the
  generic uaccess.h to actually be generically useful I also had to kill
  off the mess we made of <asm/segment.h>, which really shouldn't exist
  on most architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Christoph Hellwig (4):
      asm-generic: don't include <asm/segment.h> from <asm/uaccess.h>
      arch: mostly remove <asm/segment.h>
      asm-generic: provide entirely generic nommu uaccess
      asm-generic: optimize generic uaccess for 8-byte loads and stores

 arch/alpha/include/asm/segment.h   |  6 ----
 arch/alpha/kernel/smc37c669.c      |  1 -
 arch/alpha/kernel/smc37c93x.c      |  1 -
 arch/arc/include/asm/uaccess.h     |  1 +
 arch/arm/include/asm/Kbuild        |  1 -
 arch/arm64/include/asm/Kbuild      |  1 -
 arch/c6x/include/asm/Kbuild        |  1 -
 arch/h8300/Kconfig                 |  1 +
 arch/h8300/include/asm/Kbuild      |  1 +
 arch/h8300/include/asm/uaccess.h   | 55 ------------------------------------
 arch/hexagon/include/asm/Kbuild    |  1 -
 arch/hexagon/include/asm/uaccess.h |  1 -
 arch/ia64/include/asm/segment.h    |  6 ----
 arch/mips/include/asm/Kbuild       |  1 -
 arch/nds32/include/asm/Kbuild      |  1 -
 arch/nios2/include/asm/Kbuild      |  1 -
 arch/openrisc/include/asm/Kbuild   |  1 -
 arch/openrisc/kernel/ptrace.c      |  1 -
 arch/openrisc/kernel/setup.c       |  1 -
 arch/openrisc/kernel/traps.c       |  1 -
 arch/openrisc/mm/init.c            |  1 -
 arch/openrisc/mm/tlb.c             |  1 -
 arch/parisc/include/asm/Kbuild     |  1 -
 arch/s390/include/asm/segment.h    |  5 ----
 arch/s390/kernel/ptrace.c          |  1 -
 arch/unicore32/include/asm/Kbuild  |  1 -
 arch/xtensa/include/asm/segment.h  | 16 -----------
 include/asm-generic/segment.h      |  9 ------
 include/asm-generic/uaccess.h      | 58 +++++++++++++++++++++++++++++++++++++-
 lib/Kconfig                        |  4 +++
 30 files changed, 64 insertions(+), 117 deletions(-)
 delete mode 100644 arch/alpha/include/asm/segment.h
 delete mode 100644 arch/h8300/include/asm/uaccess.h
 delete mode 100644 arch/ia64/include/asm/segment.h
 delete mode 100644 arch/s390/include/asm/segment.h
 delete mode 100644 arch/xtensa/include/asm/segment.h
 delete mode 100644 include/asm-generic/segment.h
