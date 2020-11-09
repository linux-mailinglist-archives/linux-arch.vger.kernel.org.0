Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E512AC744
	for <lists+linux-arch@lfdr.de>; Mon,  9 Nov 2020 22:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgKIVaf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Nov 2020 16:30:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:42970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgKIVaf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 9 Nov 2020 16:30:35 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D11C206CB;
        Mon,  9 Nov 2020 21:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604957434;
        bh=njkWig57pWdajBWQKR4g8a47U32Y6t6JMAc4X5iWvMI=;
        h=From:To:Cc:Subject:Date:From;
        b=nZP+fmAowUfoPc+2sW5T5lTJ71YBKR923XOWqlnGYwNCK07gtlO1+D5/MEiXhiSAf
         sC0YPvwGzazCKsscLr39l2AEz3ylFx5h0wn/zmXaAGHlGDVZC7at3KpZUdivuTJc2/
         WQcMH9Bt32AlVwCoGWyPBJ4h49LZ4Sj6wmNQGEZU=
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, kernel-team@android.com
Subject: [PATCH v2 0/6] An alternative series for asymmetric AArch32 systems
Date:   Mon,  9 Nov 2020 21:30:16 +0000
Message-Id: <20201109213023.15092-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello again,

This is version two of the ravingly popular series I previously posted
here:

https://lore.kernel.org/r/20201021104611.2744565-1-qais.yousef@arm.com

Changes since v1 include:

  * Fix setting of compat hwcaps
  * Simplify sysfs code to use DEVICE_ATTR_RO()
  * Allow onlining of late CPUs in face of mismatch
  * Use a static key in the context-switch path
  * Avoid printing that we detected 32-bit EL0 support when we didn't

This has unfortunately introduced more complexity than I would've liked,
but it also seems to be free of any rough edges.

I haven't yet tackled the execve() problem raised by Suren. I've got some
local hacks, but nothing I'm happy with yet. They will come as follow-up
patches in any case.

As before, I don't think we should merge this stuff until we've figured
out what's going on in Android, but hopefully we can reach some agreement
on the basics before then.

Cheers,

Will

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Qais Yousef <qais.yousef@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Quentin Perret <qperret@google.com>
Cc: kernel-team@android.com

--->8

Will Deacon (6):
  arm64: cpuinfo: Split AArch32 registers out into a separate struct
  arm64: Allow mismatched 32-bit EL0 support
  KVM: arm64: Kill 32-bit vCPUs on systems with mismatched EL0 support
  arm64: Kill 32-bit applications scheduled on 64-bit-only CPUs
  arm64: Advertise CPUs capable of running 32-bit applications in sysfs
  arm64: Hook up cmdline parameter to allow mismatched 32-bit EL0

 .../ABI/testing/sysfs-devices-system-cpu      |   9 +
 .../admin-guide/kernel-parameters.txt         |   7 +
 arch/arm64/include/asm/cpu.h                  |  44 ++--
 arch/arm64/include/asm/cpucaps.h              |   2 +-
 arch/arm64/include/asm/cpufeature.h           |   8 +-
 arch/arm64/kernel/cpufeature.c                | 198 ++++++++++++++----
 arch/arm64/kernel/cpuinfo.c                   |  53 ++---
 arch/arm64/kernel/process.c                   |  19 +-
 arch/arm64/kernel/signal.c                    |  26 +++
 arch/arm64/kvm/arm.c                          |  11 +-
 10 files changed, 288 insertions(+), 89 deletions(-)

-- 
2.29.2.222.g5d2a92d10f8-goog

