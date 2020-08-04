Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAE523B9E6
	for <lists+linux-arch@lfdr.de>; Tue,  4 Aug 2020 13:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbgHDLst (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Aug 2020 07:48:49 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:21477 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730352AbgHDLrv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 4 Aug 2020 07:47:51 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BLY0M093zz9tyRk;
        Tue,  4 Aug 2020 13:47:47 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 8iY7O26Wbfpc; Tue,  4 Aug 2020 13:47:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BLY0L6FxBz9tyRh;
        Tue,  4 Aug 2020 13:47:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5AB588B767;
        Tue,  4 Aug 2020 13:47:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id mTZy4H7V6-x5; Tue,  4 Aug 2020 13:47:48 +0200 (CEST)
Received: from po16052vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EA19C8B7A5;
        Tue,  4 Aug 2020 13:47:47 +0200 (CEST)
Received: by po16052vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id A565B65BBB; Tue,  4 Aug 2020 11:47:47 +0000 (UTC)
Message-Id: <cover.1596541334.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v9 0/5] powerpc: switch VDSO to C implementation
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, nathanl@linux.ibm.com,
        anton@ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        arnd@arndb.de, tglx@linutronix.de, vincenzo.frascino@arm.com,
        luto@kernel.org, linux-arch@vger.kernel.org
Date:   Tue,  4 Aug 2020 11:47:47 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is the nineth version of a series to switch powerpc VDSO to
generic C implementation.

Main changes since v8 are:
- Dropped the patches which put the VDSO datapage in front of VDSO text in the mapping
- Adds a second stack frame because the caller doesn't set one, at least on PPC64
- Saving the TOC pointer on PPC64 (is that really needed ?)

This series applies on today's powerpc/merge branch.

See the last patches for details on changes and performance.

Christophe Leroy (5):
  powerpc/processor: Move cpu_relax() into asm/vdso/processor.h
  powerpc/vdso: Prepare for switching VDSO to generic C implementation.
  powerpc/vdso: Save and restore TOC pointer on PPC64
  powerpc/vdso: Switch VDSO to generic C implementation.
  powerpc/vdso: Provide __kernel_clock_gettime64() on vdso32

 arch/powerpc/Kconfig                         |   2 +
 arch/powerpc/include/asm/clocksource.h       |   7 +
 arch/powerpc/include/asm/processor.h         |  13 +-
 arch/powerpc/include/asm/vdso/clocksource.h  |   7 +
 arch/powerpc/include/asm/vdso/gettimeofday.h | 191 ++++++++++++
 arch/powerpc/include/asm/vdso/processor.h    |  23 ++
 arch/powerpc/include/asm/vdso/vsyscall.h     |  25 ++
 arch/powerpc/include/asm/vdso_datapage.h     |  40 +--
 arch/powerpc/kernel/asm-offsets.c            |  49 +--
 arch/powerpc/kernel/time.c                   |  91 +-----
 arch/powerpc/kernel/vdso.c                   |   5 +-
 arch/powerpc/kernel/vdso32/Makefile          |  32 +-
 arch/powerpc/kernel/vdso32/config-fake32.h   |  34 +++
 arch/powerpc/kernel/vdso32/gettimeofday.S    | 300 +------------------
 arch/powerpc/kernel/vdso32/vdso32.lds.S      |   1 +
 arch/powerpc/kernel/vdso32/vgettimeofday.c   |  35 +++
 arch/powerpc/kernel/vdso64/Makefile          |  23 +-
 arch/powerpc/kernel/vdso64/gettimeofday.S    | 242 +--------------
 arch/powerpc/kernel/vdso64/vgettimeofday.c   |  29 ++
 19 files changed, 447 insertions(+), 702 deletions(-)
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

