Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1062B90FE
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 12:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgKSL1u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 06:27:50 -0500
Received: from foss.arm.com ([217.140.110.172]:53904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgKSL1t (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Nov 2020 06:27:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66A571396;
        Thu, 19 Nov 2020 03:27:49 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12E593F718;
        Thu, 19 Nov 2020 03:27:46 -0800 (PST)
References: <20201113093720.21106-1-will@kernel.org> <20201113093720.21106-3-will@kernel.org>
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
Subject: Re: [PATCH v3 02/14] arm64: Allow mismatched 32-bit EL0 support
In-reply-to: <20201113093720.21106-3-will@kernel.org>
Date:   Thu, 19 Nov 2020 11:27:41 +0000
Message-ID: <jhjblftwpqq.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 13/11/20 09:37, Will Deacon wrote:
> +const struct cpumask *system_32bit_el0_cpumask(void)
> +{
> +	if (!system_supports_32bit_el0())
> +		return cpu_none_mask;
> +
> +	if (static_branch_unlikely(&arm64_mismatched_32bit_el0))
> +		return cpu_32bit_el0_mask;
> +
> +	return cpu_present_mask;
> +}

Nit: this is used in patch 13 to implement arch_cpu_allowed_mask(). Since
that latter defaults to cpu_possible_mask, this probably should too.
