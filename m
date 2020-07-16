Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A088222C2C
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jul 2020 21:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbgGPTuo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jul 2020 15:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728907AbgGPTuo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 15:50:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B59C061755;
        Thu, 16 Jul 2020 12:50:43 -0700 (PDT)
Message-Id: <20200716182208.180916541@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594929042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
        bh=Bjj7oiuRW+Sn6djHD3J8UrXi90X+AdJC+ynLaAISnUE=;
        b=Gp0vrB0KO5JHo1WpPfLS4VlBjitnSx1+8FCvtPTxhCeJISgPK2egD963B4xmSCKJN6O5DY
        ZoLrDfFzyU/kvIxQZ+UUBWQSuCGhxLA1vWOjRDNDBJtyC3Pz4W3S7XLe5cgF5zg1fISWoh
        ISz6rBYpw+ZD2TYtS5Ulla0ykiGjli1tCwJXVEn9hHji7SitwrZwsU3ywBSkBcNL8C+0Ox
        g+V1IMYmNYqbtHtR2iqCR3/Tp2quLDij5FxOZ+yQe97Neh46bCZhs3xLrU5j+XDDSo3iBr
        w59+dRh0JsAeyUkJyLXfVszU5a7VOtAMouS3qgQKjpR1bEeKZsXrQ+OenRZM5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594929042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
        bh=Bjj7oiuRW+Sn6djHD3J8UrXi90X+AdJC+ynLaAISnUE=;
        b=jaxV93x6mgTMuZbylYxYwP8YAvSed8CXqXGojSoBxO64T7KbIky1sorctWMQAZEwZ3DgNy
        PYVdNiCSRZhrqoAA==
Date:   Thu, 16 Jul 2020 20:22:08 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [patch V3 00/13] entry, x86, kvm: Generic entry/exit functionality
 for host and guest
Content-transfer-encoding: 8-bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is the 3rd version of preparing KVM to handle TIF_NOTIFY_RESUME before
exiting to guest mode.

The first attempt is available here:

    https://lore.kernel.org/r/20190801143250.370326052@linutronix.de

The second version which tried to provide generic infrastructure for KVM
can be found here:

    https://lore.kernel.org/r/20191023122705.198339581@linutronix.de

This started the whole discussion about entry code correctness which led to
the complete overhaul of the x86 entry code, non-instrumentable sections
and the other goodies which are in 5.8.

The remaining bits are rather straight forward:

  1) Move the entry/exit handling from x86 into generic code so other
     architectures can reuse the already proven to be correct code instead
     of duplicating the whole maze and creating slightly different beasts
     again.

     This utilizes the noinstr sections. The correctness of the confinement
     of non-instrumentable code can be verified with objtool on
     architectures which support it. The code code itself is clean.

  2) Provide generic work handling functionality for KVM
  
  3) Convert x86 over to use the generic entry/exit code

  4) Convert x86/KVM to use the generic work handling functionality.

#4 finally paves the way to move POSIX CPU timer heavy lifting out of
interrupt context into task work. Several hundred patches after the initial
attempt which was small and simple :)

The patches depend on:

    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/entry

The lot is also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/entry

The posix timer patches will be posted seperately as they are mostly
independent (except for the KVM task work detail).

The stub functions for the architecture specific parts which need to be
provided by architectures utilizing this are completely documented in the
corresponding header file which explains the diffstat.

Thanks,

	tglx

----
 arch/Kconfig                        |    3 
 arch/x86/Kconfig                    |    1 
 arch/x86/entry/common.c             |  632 ++----------------------------------
 arch/x86/entry/entry_32.S           |    2 
 arch/x86/entry/entry_64.S           |    2 
 arch/x86/include/asm/entry-common.h |  135 +++++++
 arch/x86/include/asm/idtentry.h     |   39 --
 arch/x86/include/asm/ptrace.h       |   15 
 arch/x86/include/asm/signal.h       |    1 
 arch/x86/include/asm/thread_info.h  |    5 
 arch/x86/kernel/cpu/mce/core.c      |    4 
 arch/x86/kernel/kvm.c               |    6 
 arch/x86/kernel/signal.c            |    2 
 arch/x86/kernel/traps.c             |   24 -
 arch/x86/kvm/Kconfig                |    1 
 arch/x86/kvm/vmx/vmx.c              |   11 
 arch/x86/kvm/x86.c                  |   15 
 arch/x86/mm/fault.c                 |    6 
 include/linux/entry-common.h        |  398 ++++++++++++++++++++++
 include/linux/entry-kvm.h           |   80 ++++
 include/linux/kvm_host.h            |    8 
 kernel/Makefile                     |    1 
 kernel/entry/Makefile               |    4 
 kernel/entry/common.c               |  364 ++++++++++++++++++++
 kernel/entry/kvm.c                  |   51 ++
 virt/kvm/Kconfig                    |    3 
 26 files changed, 1150 insertions(+), 663 deletions(-)
