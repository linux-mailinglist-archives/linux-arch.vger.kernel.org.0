Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886FB227E58
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 13:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbgGULIg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 07:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgGULIg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 07:08:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6652CC061794;
        Tue, 21 Jul 2020 04:08:36 -0700 (PDT)
Message-Id: <20200721105706.030914876@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595329714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
        bh=53zegY7mPEwf7yBdREoLaX8m4OIEIYVRvPFk/Ji8ifI=;
        b=oAtueUlx7L5mcMuTzK9Fyk01+ONyRlDDzaKEZMKXpTGihVqmHte1vgKJzN/yuPijPVDCVw
        qBBgJNDyfupd1tZRc/UlBpJr9QawbI55gUfu/h1dIzajsr7kT/iGbSdhtejBvuzKwfG2VS
        wUjq01pUDaHX/2rHpryrIybzygLWcadU2JuGgDsfkTZFz4bcB6NeOeSYS3DjFTxh0pHlpC
        Oqes7nJpC5BQCBVWmim0Bsb1rO2CAsXXAqp+zbzAp+uBG0UoKP1QZioyuOoOnPjtQlcSCG
        kXVGHPPqQGwEnpr/hec9QqGvYKuoEjc0068mh9sNSOCYuQcWYRMs1K4EM+TLRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595329714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
        bh=53zegY7mPEwf7yBdREoLaX8m4OIEIYVRvPFk/Ji8ifI=;
        b=aN0PaId2u7QHeZPGnNEBzgCrSZbPEA/HKpmS04VML9CmSi9B9/tnTIu4LdOYuWDT3CdpyQ
        hQfrjZWYOpf8nxCw==
Date:   Tue, 21 Jul 2020 12:57:06 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [patch V4 00/15] entry, x86, kvm: Generic entry/exit functionality
 for host and guest
Content-transfer-encoding: 8-bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is the 4rd version of generic entry/exit functionality for host and
guest.

The 3rd version is available here:

    https://lore.kernel.org/r/20200716182208.180916541@linutronix.de

Changes vs. V3:

  - Drop the architecture wrappers for seccomp and audit (Kees)
  - Move the user return notifier out of the loop
  - Bring I/O bitmap handling back
  - Use the existing helpers to get syscall number and return value
  - Drop dummy defines for SYSCALL_TRACE and NOTIFY_RESUME as all
    architectures define them
  - Fix TIF_SYSCALL_AUDIT dummy define
  - Adjust comments

The patches depend on:

    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/entry

The lot is also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/entry

Thanks,

	tglx
---
 arch/Kconfig                        |    3 
 arch/x86/Kconfig                    |    1 
 arch/x86/entry/common.c             |  632 ++----------------------------------
 arch/x86/entry/entry_32.S           |    2 
 arch/x86/entry/entry_64.S           |    2 
 arch/x86/include/asm/entry-common.h |   76 ++++
 arch/x86/include/asm/idtentry.h     |   39 --
 arch/x86/include/asm/ptrace.h       |    5 
 arch/x86/include/asm/signal.h       |    1 
 arch/x86/include/asm/thread_info.h  |    5 
 arch/x86/kernel/cpu/mce/core.c      |    4 
 arch/x86/kernel/kvm.c               |    6 
 arch/x86/kernel/signal.c            |    3 
 arch/x86/kernel/traps.c             |   24 -
 arch/x86/kvm/Kconfig                |    1 
 arch/x86/kvm/vmx/vmx.c              |   11 
 arch/x86/kvm/x86.c                  |   15 
 arch/x86/mm/fault.c                 |    6 
 include/linux/entry-common.h        |  372 +++++++++++++++++++++
 include/linux/entry-kvm.h           |   80 ++++
 include/linux/kvm_host.h            |    8 
 include/linux/seccomp.h             |    1 
 kernel/Makefile                     |    1 
 kernel/entry/Makefile               |    4 
 kernel/entry/common.c               |  374 +++++++++++++++++++++
 kernel/entry/kvm.c                  |   51 ++
 virt/kvm/Kconfig                    |    3 
 27 files changed, 1067 insertions(+), 663 deletions(-)
