Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE5A3A4644
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jun 2021 18:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhFKQRz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Jun 2021 12:17:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230026AbhFKQRz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Jun 2021 12:17:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8929860720;
        Fri, 11 Jun 2021 16:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623428157;
        bh=47KUDTDFZmEcC0m5FZ4g1b7cnY0AtXflqc5aNrX+qtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XgG7pFdCLWpl+tBQC9REWK300WzqnQMy43GirHyGOuwrNnmdY9wZy0fiLW4l5piEW
         KPrlLsu4+QawjxreGGP9+s8VXKXUNF9H8JjBmiBzU3CHMCXqo1k9MaN8PgrCoVYBxk
         c9neROxBRPKbO3t5zRkiPzdBYq0BNDVR3pAmz6u2h4azuOatBlGwbSUPJM9gEBHPia
         fe+DC2pPa9eGzcKBu/Lof8fpRRUX6Y1V70Sx/FBcHqgzDV3fvq5JNJHmV5oHNkJVmq
         2qydHB6xSJT6YQHspDWhiEaTuW06AeMPuV0UYUCd307TYO2G1n81LMi/heaTYh/YQ3
         hTBH6eRtv1zoA==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arch@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Tejun Heo <tj@kernel.org>, Quentin Perret <qperret@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v9 00/20] Add support for 32-bit tasks on asymmetric AArch32 systems
Date:   Fri, 11 Jun 2021 17:15:42 +0100
Message-Id: <162341030594.552758.8287199558365049066.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210608180313.11502-1-will@kernel.org>
References: <20210608180313.11502-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 8 Jun 2021 19:02:53 +0100, Will Deacon wrote:
> The sun is shining and its time for your weekly dose of asymmetric
> 32-bit support patches, previously seen at:
> 
>   v1: https://lore.kernel.org/r/20201027215118.27003-1-will@kernel.org
>   v2: https://lore.kernel.org/r/20201109213023.15092-1-will@kernel.org
>   v3: https://lore.kernel.org/r/20201113093720.21106-1-will@kernel.org
>   v4: https://lore.kernel.org/r/20201124155039.13804-1-will@kernel.org
>   v5: https://lore.kernel.org/r/20201208132835.6151-1-will@kernel.org
>   v6: https://lore.kernel.org/r/20210518094725.7701-1-will@kernel.org
>   v7: https://lore.kernel.org/r/20210525151432.16875-1-will@kernel.org
>   v8: https://lore.kernel.org/r/20210602164719.31777-1-will@kernel.org
> 
> [...]

Since patches 1-4 are all arm64, don't do any harm on their own and
conflict significantly with other arm64 changes queued for 5.14, I've
queued them in the arm64 tree on the stable for-next/cpufeature branch:

[01/20] arm64: cpuinfo: Split AArch32 registers out into a separate struct
        https://git.kernel.org/arm64/c/930a58b4093e
[02/20] arm64: Allow mismatched 32-bit EL0 support
        https://git.kernel.org/arm64/c/2122a833316f
[03/20] KVM: arm64: Kill 32-bit vCPUs on systems with mismatched EL0 support
        https://git.kernel.org/arm64/c/2f6a49bbc01d
[04/20] arm64: Kill 32-bit applications scheduled on 64-bit-only CPUs
        https://git.kernel.org/arm64/c/873c3e89777c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
