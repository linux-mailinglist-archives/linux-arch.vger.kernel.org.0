Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E0229CB81
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 22:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506025AbgJ0VvZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Oct 2020 17:51:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505991AbgJ0VvY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Oct 2020 17:51:24 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 500D4207E8;
        Tue, 27 Oct 2020 21:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603835484;
        bh=O5D4goy0vhumRnvIluG5lcRDisgHq+OWV12M5HePYx4=;
        h=From:To:Cc:Subject:Date:From;
        b=Gso25ailQocviYmbXrC14bnc56r2ElzaO1xHi3uSlPtTpocOBtrqkLfZ/VSQFGRXs
         fuVK0S8kL5jsKNwOOtNKEaqv12tqcxg74fpbTPGkHlQ/7Uxg8BAtrtPd7rIXuqiM/z
         KHulAmPCNlwCX3BgBjgi9UmtLPaU+nhMj7CeNry0=
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>, kernel-team@android.com
Subject: [PATCH 0/6] An alternative series for asymmetric AArch32 systems
Date:   Tue, 27 Oct 2020 21:51:12 +0000
Message-Id: <20201027215118.27003-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

I was playing around with the asymmetric AArch32 RFCv2 from Qais:

https://lore.kernel.org/r/20201021104611.2744565-1-qais.yousef@arm.com

and ended up writing my own implementation this afternoon. I think it's
smaller, simpler and easier to work with. In particular:

  * I got rid of the sysctl in favour of a plain cmdline parameter
  * I don't have a new CPU capability
  * I don't have a new thread flag
  * I expose a cpumask to userspace via sysfs to identify the 32-bit CPUs

Anyway, I don't think we should merge this stuff (other than the first patch)
until we've figured out what's going on in Android, but I wanted to get
this out as something which we might be able to build on.

Cheers,

Will

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Qais Yousef <qais.yousef@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: kernel-team@android.com

--->8

Qais Yousef (1):
  KVM: arm64: Handle Asymmetric AArch32 systems

Will Deacon (5):
  arm64: Allow mismatched 32-bit EL0 support
  KVM: arm64: Kill 32-bit vCPUs on systems with mismatched EL0 support
  arm64: Kill 32-bit applications scheduled on 64-bit-only CPUs
  arm64: Advertise CPUs capable of running 32-bit applcations in sysfs
  arm64: Hook up cmdline parameter to allow mismatched 32-bit EL0

 .../ABI/testing/sysfs-devices-system-cpu      |  8 ++
 .../admin-guide/kernel-parameters.txt         |  7 ++
 arch/arm64/include/asm/cpufeature.h           |  3 +
 arch/arm64/kernel/cpufeature.c                | 80 ++++++++++++++++++-
 arch/arm64/kernel/process.c                   | 21 ++++-
 arch/arm64/kernel/signal.c                    | 26 ++++++
 arch/arm64/kvm/arm.c                          | 27 +++++++
 7 files changed, 168 insertions(+), 4 deletions(-)

-- 
2.29.0.rc2.309.g374f81d7ae-goog

