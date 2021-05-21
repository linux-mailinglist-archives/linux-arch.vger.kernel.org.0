Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA78038C499
	for <lists+linux-arch@lfdr.de>; Fri, 21 May 2021 12:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhEUK1D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 06:27:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233336AbhEUK0v (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 May 2021 06:26:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 427FE613CB;
        Fri, 21 May 2021 10:25:26 +0000 (UTC)
Date:   Fri, 21 May 2021 11:25:23 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
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
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com
Subject: Re: [PATCH v6 02/21] arm64: Allow mismatched 32-bit EL0 support
Message-ID: <20210521102523.GB6675@arm.com>
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-3-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518094725.7701-3-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 18, 2021 at 10:47:06AM +0100, Will Deacon wrote:
> +static bool has_32bit_el0(const struct arm64_cpu_capabilities *entry, int scope)
> +{
> +	if (!has_cpuid_feature(entry, scope))
> +		return allow_mismatched_32bit_el0;
> +
> +	if (scope == SCOPE_SYSTEM)
> +		pr_info("detected: 32-bit EL0 Support\n");
> +
> +	return true;
> +}

We may have discussed this before: AFAICT this will print 32-bit EL0
detected even if there's no 32-bit EL0 on any CPU. Should we instead
print 32-bit EL0 detected on CPU X when allow_mismatched_32bit_el0 is
passed? It would also give us an indication of the system configuration
when people start reporting bugs.

-- 
Catalin
