Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B9244B8FF
	for <lists+linux-arch@lfdr.de>; Tue,  9 Nov 2021 23:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241537AbhKIWy2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Nov 2021 17:54:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:40472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345607AbhKIWyF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 9 Nov 2021 17:54:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99AB661037;
        Tue,  9 Nov 2021 22:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636498276;
        bh=MkQelUtPGxTk7CP+eGXpJiNBb67EtzdkLMHSuc0qB9w=;
        h=From:Date:Subject:To:Cc:From;
        b=N/qMtQ9ZzLxmhQ7iDPj0rvDOFfH6gDK0kJL07c3E53WnJ/4GtkHUgBnmMypjf4hYn
         1AtglV02GzwTHeP4z3W0cAdaqsP62rm+TJYYg+l2PdccpNGNcorX9fDtI+61Nq3Qh2
         sdl3HaQvpLsppulRBbvJo7L58MqxU7qud9b6Eo/WDWNnNUA/6U81uhDw2/TP1pdQDY
         CEinaTcZ6+mt7iK9/onIzsa2bnPMkzzAj43ygPdn6DyqI8NCnvmzirDn/ubSujunjy
         Gjc+hwLbQmFhPHZo/lvQVaKYPiWtYjzYOi5/PBYn7ha5CPec52TFpQfvXEljIQiYn1
         c9jiZOprKt1Eg==
Received: by mail-wr1-f42.google.com with SMTP id c4so568230wrd.9;
        Tue, 09 Nov 2021 14:51:16 -0800 (PST)
X-Gm-Message-State: AOAM532AHwaGgLhrAoiLrXY2AVTFRAd6rnT58nQ65K/E1QRxQZf2F56j
        hzJZ2lZx0pDlKyVSnf7Y0IA69Bt/eQxl620YHQU=
X-Google-Smtp-Source: ABdhPJyVTDedbofxrUet8EqsY0J9JI7QrXutZ1HLIU0wRv24nwwbxfEXM8/oIdKm1IwJahjuQ+NS6kEK3vu3d1MB+cg=
X-Received: by 2002:a05:6000:18c7:: with SMTP id w7mr14052067wrq.411.1636498275112;
 Tue, 09 Nov 2021 14:51:15 -0800 (PST)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 9 Nov 2021 23:50:59 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0G2BoQ5fa29SASLcYbY9Znwq9wCp4vXbcsZCX+Tios4w@mail.gmail.com>
Message-ID: <CAK8P3a0G2BoQ5fa29SASLcYbY9Znwq9wCp4vXbcsZCX+Tios4w@mail.gmail.com>
Subject: [GIT PULL] asm-generic: asm/syscall.h cleanup
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
tags/asm-generic-5.16

for you to fetch changes up to 7962c2eddbfe7cce879acb06f9b4f205789e57b7:

  arch: remove unused function syscall_set_arguments() (2021-09-14
16:06:20 +0200)

----------------------------------------------------------------
asm-generic: asm/syscall.h cleanup

This is a single cleanup from Peter Collingbourne, removing
some dead code.

----------------------------------------------------------------
Peter Collingbourne (1):
      arch: remove unused function syscall_set_arguments()

 arch/arm/include/asm/syscall.h        | 10 ----------
 arch/arm64/include/asm/syscall.h      | 10 ----------
 arch/csky/include/asm/syscall.h       |  9 ---------
 arch/ia64/include/asm/syscall.h       | 17 ++---------------
 arch/ia64/kernel/ptrace.c             | 31 ++++++++++++-------------------
 arch/microblaze/include/asm/syscall.h | 33 ---------------------------------
 arch/nds32/include/asm/syscall.h      | 22 ----------------------
 arch/nios2/include/asm/syscall.h      | 11 -----------
 arch/openrisc/include/asm/syscall.h   |  7 -------
 arch/powerpc/include/asm/syscall.h    | 10 ----------
 arch/riscv/include/asm/syscall.h      |  9 ---------
 arch/s390/include/asm/syscall.h       | 12 ------------
 arch/sh/include/asm/syscall_32.h      | 12 ------------
 arch/sparc/include/asm/syscall.h      | 10 ----------
 arch/um/include/asm/syscall-generic.h | 14 --------------
 arch/x86/include/asm/syscall.h        | 33 ---------------------------------
 arch/xtensa/include/asm/syscall.h     | 11 -----------
 include/asm-generic/syscall.h         | 16 ----------------
 18 files changed, 14 insertions(+), 263 deletions(-)
