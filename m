Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FF52800FA
	for <lists+linux-arch@lfdr.de>; Thu,  1 Oct 2020 16:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732463AbgJAONK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Oct 2020 10:13:10 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:46561 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732421AbgJAONH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Oct 2020 10:13:07 -0400
Received: from threadripper.lan ([46.223.126.90]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MDQmW-1kEben1bZW-00ASUI; Thu, 01 Oct 2020 16:12:51 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 00/10] ARM: remove set_fs callers and implementation
Date:   Thu,  1 Oct 2020 16:12:23 +0200
Message-Id: <20201001141233.119343-1-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:uvT0YYMCSl5yaLC0/r8RyA+xGdKVT1cAiXxy5fc6u04+Z7n9ImA
 J6uOW5QZ/LsnTiydt7y11fk9jnUMLq1J2fKNQj/BVedh2XfzFisuEDQrKA4ybpaUNFEUtnz
 IuuxJCH7VyCbIARbJox82g2ljhI7S52bXKBbaIFCrjE4UgS6vcwwQxXrAkf1Cv9E4YEMpgW
 geXoKOZ1Dl3DAgMusEkNQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:upTsn8YWAJw=:bCdYpMIkHwcotA5EW6TSXq
 iIuZdlAHh5fZnmzQj7wOUNsBOJbqbmCGyhYbaO6GS6UOUxI9ePnw49zQct8RaEDRTRf8KKiGk
 03Sf2fIJcCnG4gpMu7KeYxOPHH0Vriqz27KTWuMNHDZ6OF0iTbtEhAn96dMHTJD97mHBTu6Jq
 uoTgZi6ElWW2sEOnp2jrrHq0Kk20CSwAnLlPWC7dlLIijzc+Id82FNXfaU55LPfJ014kOOrDi
 m7wnkLf87f33csKJEcUu6HtABRlMRwVtNOu7Roi6Cze7Zc/hmLyTca4zSNoFCA+f1Jg6SIMax
 f2YLED/AMOF/6xtWOihOzizHtGll7SaSeIMJs887u/RFXBr41sztwh1PbmOx4y2F5QBY2ETYg
 AmZcE2pwFlcJe5tPZkyxzddnXgUog0VxyqFm1VDm18d7TpCZy7dXZjxXSJNjZ6dxtDboz4kE1
 DfkuwdL1lHKaIU3mYQneWnDU+1yutpqBZ17EvdfJ46lnb5V6mDvfJ6l34f9GrrrLDt65+6lAP
 J0oMVZ9cZxHTvw1tZgGRytaTxN9nT0a4j5QEU8PGZ8s/3XIIrH7EQSjc4/MnX0ALshbVpAr+J
 1z736Q3pLNDRpkGP5+aoBg2Y34ox0wyvlyHyb1fddP6bS3nw9cEnl74x+XdHQQ0utT4fQFcSL
 Wm3H8Nb/Wzhy33xYSSY9F+Jae2cCHLzKbFr/TPGg6ua5OCHTrFYkDYXR+e/jnfnB/SqlebcML
 rk0C0eo5hAtplfQogMhE4zIzh65DH0MOoLsNW9w8O7ZYx5TPJf5CotTsnl6Uf+Y6oqv1aG7La
 J7dnKMtRyjA1fFUJw4BAFHowogyZNrte4cp0yzvlVrdQeajzPF2AlWSQWdEGnX1h07a8OGQ
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Christoph, Russell,

This is the updated version of my ARM set_fs patches, hopefully
I managed to address your previous concerns.

I have tested the oabi-compat changes using the LTP tests for the three
modified syscalls using an Armv7 kernel and a Debian 5 OABI user space.

I also tested the syscall_get_nr() in all combinations of OABI/EABI
kernel user space and fixed the bugs I found after Russell pointed
out one of those issues.

The series is now based on
https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/log/?h=base.set_fs
with no extra patches, after I included a patch to define a
private TASK_SIZE_MAX.

Russell, if you would still consider this seris for the next merge
window and there are no further review comments, you can pull it
from

  https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git \
	arm-kill-set_fs-7

At this point I'd probably just defer it another release and
rebase once -rc1 is out, dropping the TASK_SIZE_MAX patch.

     Arnd


Arnd Bergmann (10):
  mm/maccess: fix unaligned copy_{from,to}_kernel_nofault
  ARM: traps: use get_kernel_nofault instead of set_fs()
  ARM: oabi-compat: add epoll_pwait handler
  ARM: syscall: always store thread_info->syscall
  ARM: oabi-compat: rework epoll_wait/epoll_pwait emulation
  ARM: oabi-compat: rework sys_semtimedop emulation
  ARM: oabi-compat: rework fcntl64() emulation
  ARM: uaccess: add __{get,put}_kernel_nofault
  ARM: provide a TASK_SIZE_MAX definition
  ARM: uaccess: remove set_fs() implementation

 arch/arm/Kconfig                   |   1 -
 arch/arm/include/asm/memory.h      |   2 +
 arch/arm/include/asm/ptrace.h      |   1 -
 arch/arm/include/asm/syscall.h     |  16 ++-
 arch/arm/include/asm/thread_info.h |   4 -
 arch/arm/include/asm/uaccess-asm.h |   6 -
 arch/arm/include/asm/uaccess.h     | 169 ++++++++++++++-------------
 arch/arm/kernel/asm-offsets.c      |   3 +-
 arch/arm/kernel/entry-common.S     |  17 +--
 arch/arm/kernel/process.c          |   7 +-
 arch/arm/kernel/ptrace.c           |   9 +-
 arch/arm/kernel/signal.c           |   8 --
 arch/arm/kernel/sys_oabi-compat.c  | 181 ++++++++++++++++-------------
 arch/arm/kernel/traps.c            |  47 +++-----
 arch/arm/lib/copy_from_user.S      |   3 +-
 arch/arm/lib/copy_to_user.S        |   3 +-
 arch/arm/tools/syscall.tbl         |   2 +-
 fs/eventpoll.c                     |   5 +-
 include/linux/eventpoll.h          |  18 +++
 include/linux/syscalls.h           |   3 +
 ipc/sem.c                          |  84 ++++++++-----
 mm/maccess.c                       |  28 ++++-
 22 files changed, 334 insertions(+), 283 deletions(-)

-- 
2.27.0

