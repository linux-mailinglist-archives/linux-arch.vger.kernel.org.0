Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE4F3A2C49
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jun 2021 15:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhFJNCH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Jun 2021 09:02:07 -0400
Received: from foss.arm.com ([217.140.110.172]:59454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230312AbhFJNCF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Jun 2021 09:02:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86B22106F;
        Thu, 10 Jun 2021 06:00:08 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C09813F73D;
        Thu, 10 Jun 2021 06:00:05 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>, kernel-team@android.com
Subject: Re: [PATCH v9 12/20] sched: Allow task CPU affinity to be restricted on asymmetric systems
In-Reply-To: <20210608180313.11502-13-will@kernel.org>
References: <20210608180313.11502-1-will@kernel.org> <20210608180313.11502-13-will@kernel.org>
Date:   Thu, 10 Jun 2021 14:00:03 +0100
Message-ID: <875yyldgdo.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 08/06/21 19:03, Will Deacon wrote:
> Asymmetric systems may not offer the same level of userspace ISA support
> across all CPUs, meaning that some applications cannot be executed by
> some CPUs. As a concrete example, upcoming arm64 big.LITTLE designs do
> not feature support for 32-bit applications on both clusters.
>
> Although userspace can carefully manage the affinity masks for such
> tasks, one place where it is particularly problematic is execve()
> because the CPU on which the execve() is occurring may be incompatible
> with the new application image. In such a situation, it is desirable to
> restrict the affinity mask of the task and ensure that the new image is
> entered on a compatible CPU. From userspace's point of view, this looks
> the same as if the incompatible CPUs have been hotplugged off in the
> task's affinity mask. Similarly, if a subsequent execve() reverts to
> a compatible image, then the old affinity is restored if it is still
> valid.
>
> In preparation for restricting the affinity mask for compat tasks on
> arm64 systems without uniform support for 32-bit applications, introduce
> {force,relax}_compatible_cpus_allowed_ptr(), which respectively restrict
> and restore the affinity mask for a task based on the compatible CPUs.
>
> Reviewed-by: Quentin Perret <qperret@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
