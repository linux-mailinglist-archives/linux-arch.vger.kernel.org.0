Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A588D1BBEC5
	for <lists+linux-arch@lfdr.de>; Tue, 28 Apr 2020 15:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgD1NQs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Apr 2020 09:16:48 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:16939 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbgD1NQs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Apr 2020 09:16:48 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49BMcF42Gcz9tyZy;
        Tue, 28 Apr 2020 15:16:45 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=dy+skcaG; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id moQddnqFTmZz; Tue, 28 Apr 2020 15:16:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49BMcF2YPZz9tyb5;
        Tue, 28 Apr 2020 15:16:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1588079805; bh=j2evlJVbC4DblvaOZbL9aC5MHHjN3Brop8EHn8xM2LY=;
        h=From:Subject:To:Cc:Date:From;
        b=dy+skcaG+aamFAjpi4FX0JOVppUyIIwwj4QjmWk8xaqvtue5byUWNU4fUZaRcw3zQ
         9NdNwgEcOW91kbzO5WaxmbFeZDEbmpXIVcocAAq1GNlCR6QEsCy0J9c+VTzfSb2C/X
         hVStv4eOviZLqxyo7RDFU6QkipVdjR0HQQ1GokQo=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DE5228B82C;
        Tue, 28 Apr 2020 15:16:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id yvysETkW__7X; Tue, 28 Apr 2020 15:16:46 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 938688B82D;
        Tue, 28 Apr 2020 15:16:46 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2666F658AD; Tue, 28 Apr 2020 13:16:46 +0000 (UTC)
Message-Id: <cover.1588079622.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v8 0/8] powerpc: switch VDSO to C implementation
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, nathanl@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        arnd@arndb.de, tglx@linutronix.de, vincenzo.frascino@arm.com,
        luto@kernel.org, linux-arch@vger.kernel.org
Date:   Tue, 28 Apr 2020 13:16:46 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is the seventh version of a series to switch powerpc VDSO to
generic C implementation.

Main changes since v7 are:
- Added gettime64 on PPC32

This series applies on today's powerpc/merge branch.

See the last patches for details on changes and performance.

Christophe Leroy (8):
  powerpc/vdso64: Switch from __get_datapage() to get_datapage inline
    macro
  powerpc/vdso: Remove __kernel_datapage_offset and simplify
    __get_datapage()
  powerpc/vdso: Remove unused \tmp param in __get_datapage()
  powerpc/processor: Move cpu_relax() into asm/vdso/processor.h
  powerpc/vdso: Prepare for switching VDSO to generic C implementation.
  powerpc/vdso: Switch VDSO to generic C implementation.
  lib/vdso: force inlining of __cvdso_clock_gettime_common()
  powerpc/vdso: Provide __kernel_clock_gettime64() on vdso32

 arch/powerpc/Kconfig                         |   2 +
 arch/powerpc/include/asm/clocksource.h       |   7 +
 arch/powerpc/include/asm/processor.h         |  10 +-
 arch/powerpc/include/asm/vdso/clocksource.h  |   7 +
 arch/powerpc/include/asm/vdso/gettimeofday.h | 175 +++++++++++
 arch/powerpc/include/asm/vdso/processor.h    |  23 ++
 arch/powerpc/include/asm/vdso/vsyscall.h     |  25 ++
 arch/powerpc/include/asm/vdso_datapage.h     |  50 ++--
 arch/powerpc/kernel/asm-offsets.c            |  49 +--
 arch/powerpc/kernel/time.c                   |  91 +-----
 arch/powerpc/kernel/vdso.c                   |  58 +---
 arch/powerpc/kernel/vdso32/Makefile          |  32 +-
 arch/powerpc/kernel/vdso32/cacheflush.S      |   2 +-
 arch/powerpc/kernel/vdso32/config-fake32.h   |  34 +++
 arch/powerpc/kernel/vdso32/datapage.S        |   7 +-
 arch/powerpc/kernel/vdso32/gettimeofday.S    | 300 +------------------
 arch/powerpc/kernel/vdso32/vdso32.lds.S      |   8 +-
 arch/powerpc/kernel/vdso32/vgettimeofday.c   |  35 +++
 arch/powerpc/kernel/vdso64/Makefile          |  23 +-
 arch/powerpc/kernel/vdso64/cacheflush.S      |   9 +-
 arch/powerpc/kernel/vdso64/datapage.S        |  31 +-
 arch/powerpc/kernel/vdso64/gettimeofday.S    | 243 +--------------
 arch/powerpc/kernel/vdso64/vdso64.lds.S      |   7 +-
 arch/powerpc/kernel/vdso64/vgettimeofday.c   |  29 ++
 lib/vdso/gettimeofday.c                      |   2 +-
 25 files changed, 460 insertions(+), 799 deletions(-)
 create mode 100644 arch/powerpc/include/asm/clocksource.h
 create mode 100644 arch/powerpc/include/asm/vdso/clocksource.h
 create mode 100644 arch/powerpc/include/asm/vdso/gettimeofday.h
 create mode 100644 arch/powerpc/include/asm/vdso/processor.h
 create mode 100644 arch/powerpc/include/asm/vdso/vsyscall.h
 create mode 100644 arch/powerpc/kernel/vdso32/config-fake32.h
 create mode 100644 arch/powerpc/kernel/vdso32/vgettimeofday.c
 create mode 100644 arch/powerpc/kernel/vdso64/vgettimeofday.c

-- 
2.25.0

