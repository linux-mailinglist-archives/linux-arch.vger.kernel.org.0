Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F6B2B92C5
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 13:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgKSMrj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 07:47:39 -0500
Received: from foss.arm.com ([217.140.110.172]:56420 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbgKSMrj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Nov 2020 07:47:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7FD21396;
        Thu, 19 Nov 2020 04:47:38 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C0093F718;
        Thu, 19 Nov 2020 04:47:36 -0800 (PST)
References: <20201113093720.21106-1-will@kernel.org> <20201113093720.21106-8-will@kernel.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v3 07/14] sched: Introduce restrict_cpus_allowed_ptr() to limit task CPU affinity
In-reply-to: <20201113093720.21106-8-will@kernel.org>
Date:   Thu, 19 Nov 2020 12:47:34 +0000
Message-ID: <jhj8saxwm1l.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 13/11/20 09:37, Will Deacon wrote:
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
> entered on a compatible CPU.

> From userspace's point of view, this looks the same as if the
> incompatible CPUs have been hotplugged off in its affinity mask.

{pedantic reading warning}

Hotplugged CPUs *can* be set in a task's affinity mask, though interact
weirdly with cpusets [1]. Having it be the same as hotplug would mean
keeping incompatible CPUs allowed in the affinity mask, but preventing them
from being picked via e.g. is_cpu_allowed().

I was actually hoping this could be a feasible approach, i.e. have an
extra CPU active mask filter for any task:

  cpu_active_mask & arch_cpu_allowed_mask(p)

rather than fiddle with task affinity. Sadly this would also require fixing
up pretty much any place that uses cpu_active_mask(), and probably places
that use p->cpus_ptr as well. RT / DL balancing comes to mind, because that
uses either a task's affinity or a CPU's root domain (which reflects the
cpu_active_mask) to figure out where to push a task.

So while I'm wary of hacking up affinity, I fear it might be the lesser
evil :(

[1]: https://lore.kernel.org/lkml/1251528473.590671.1579196495905.JavaMail.zimbra@efficios.com/

> In preparation for restricting the affinity mask for compat tasks on
> arm64 systems without uniform support for 32-bit applications, introduce
> a restrict_cpus_allowed_ptr(), which allows the current affinity mask
> for a task to be shrunk to the intersection of a parameter mask.
>
> Signed-off-by: Will Deacon <will@kernel.org>
