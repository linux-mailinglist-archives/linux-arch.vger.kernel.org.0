Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5998D45DDF5
	for <lists+linux-arch@lfdr.de>; Thu, 25 Nov 2021 16:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbhKYPxF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Nov 2021 10:53:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:60420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356149AbhKYPve (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Nov 2021 10:51:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85A06610E8;
        Thu, 25 Nov 2021 15:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637855303;
        bh=U7MnU5/31mywm76pdPoiwNd1pEooMskUeZ3nm7n/GBE=;
        h=From:Date:Subject:To:Cc:From;
        b=HbEF+WgTNYB3xPn4IM34ql3drUawHVQYUXgKN8gPbOUU9TArGoYNNmH09EPLFBw8B
         F4S18r/ti+4uUNSgXWwgpTv0UxREd8lPzajhj0hwfK1N3c6XNb0HgqyVBflMjl+SCf
         24g/ZKONqVk11QaqIncwuYMr4H0DoIIXo6tjiAM56obPTFTqBVjpcgbGgLfd3/Sc5v
         tFVWcNgNbp4r3XXswKUOOIKNYNz3SkC1UU6ka9d8/FiYywRmbjrsX8E7jH+J1JCJoS
         ei8QcReE5rE8Y75kCY1eWvE5/HagT/g437QIP0eHMsvlhBU9eXh/Hb434zrtjGaK4J
         xvrXsPKNJOa9A==
Received: by mail-wm1-f51.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so4964842wms.3;
        Thu, 25 Nov 2021 07:48:23 -0800 (PST)
X-Gm-Message-State: AOAM530pw0A7Qjn6VMtmyMOJc/Ec/YVzKMUmFlMXNkBCPVLgpdx/dJeQ
        ud7Zcnip4ao1LSHkbwYfKTJGepgGjjZ+iv62lpk=
X-Google-Smtp-Source: ABdhPJxbqqGkf5AOVj86Ru2m9pY6KCLxo9YD5MjcXG82yvgpiF9EdnoAXupJRtGrvNIRhAhII9KPjTwE1tLzjXEtikg=
X-Received: by 2002:a05:600c:6d2:: with SMTP id b18mr8588376wmn.98.1637855302022;
 Thu, 25 Nov 2021 07:48:22 -0800 (PST)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 25 Nov 2021 16:48:06 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1JPS=3Zz3H9ptaAnqonnPUo546BP0rAAWT5KOcZEj55g@mail.gmail.com>
Message-ID: <CAK8P3a1JPS=3Zz3H9ptaAnqonnPUo546BP0rAAWT5KOcZEj55g@mail.gmail.com>
Subject: [GIT PULL] asm-generic: syscall table updates
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf=
:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
tags/asm-generic-5.16-2

for you to fetch changes up to a0eb2da92b715d0c97b96b09979689ea09faefe6:

  futex: Wireup futex_waitv syscall (2021-11-25 14:26:12 +0100)

----------------------------------------------------------------
asm-generic: syscall table updates

Andr=C3=A9 Almeida sends an update for the newly added futex_waitv
syscall that was initially only added to a few architectures.

Some additional ones have since made it through architecture
maintainer trees, this finishes the remaining ones.

----------------------------------------------------------------
Andr=C3=A9 Almeida (1):
      futex: Wireup futex_waitv syscall

 arch/alpha/kernel/syscalls/syscall.tbl      | 1 +
 arch/ia64/kernel/syscalls/syscall.tbl       | 1 +
 arch/m68k/kernel/syscalls/syscall.tbl       | 1 +
 arch/microblaze/kernel/syscalls/syscall.tbl | 1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    | 1 +
 arch/sh/kernel/syscalls/syscall.tbl         | 1 +
 arch/sparc/kernel/syscalls/syscall.tbl      | 1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     | 1 +
 8 files changed, 8 insertions(+)
