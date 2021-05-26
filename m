Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB3F391B0D
	for <lists+linux-arch@lfdr.de>; Wed, 26 May 2021 17:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbhEZPEP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 May 2021 11:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbhEZPEP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 May 2021 11:04:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6A0C061574;
        Wed, 26 May 2021 08:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EzQNpucbZRhOS6VlKl4EW+/nNhgUz3SdWpD1Xj7cd80=; b=axGXUB0m7TjyPDI5WGPN9TcpCB
        zsGBpK64dDZcj69e9wqfhe30Acmr+x/5LnNB9oxaeIdSCHj77dwxc3oCr632D8hKQqp0gCy3Il9sL
        DPsyMsrhFpOkDnTNiXAu+axxTKcOm9JoeF0xPQJ1IAKzm5UScHjBKpDojD5Oou4SCVo4Bik/6D1bV
        4VsnHPQQWJciqrE5rc6J5bMZFz2IO1bOvloALOtrUFcrReiCddf98AgL5UxK9vltxqDT94Ew1UcN8
        8VW7kS5GUiC2BfsWgUhRWKB+DstRhsAlRbKiD3OJ3Ovq7mJwPhkhXZS3UmISIURKXFto9T4shbNhc
        iZLrrCgQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1llv31-000g9F-1s; Wed, 26 May 2021 15:02:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E27C9300242;
        Wed, 26 May 2021 17:02:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C4714200D3A72; Wed, 26 May 2021 17:02:20 +0200 (CEST)
Date:   Wed, 26 May 2021 17:02:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        kernel-team@android.com, Li Zefan <lizefan@huawei.com>
Subject: Re: [PATCH v7 08/22] cpuset: Don't use the cpu_possible_mask as a
 last resort for cgroup v1
Message-ID: <YK5i/GQ/30hSsYBU@hirez.programming.kicks-ass.net>
References: <20210525151432.16875-1-will@kernel.org>
 <20210525151432.16875-9-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525151432.16875-9-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 25, 2021 at 04:14:18PM +0100, Will Deacon wrote:
>  void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
>  {
> +	const struct cpumask *cs_mask;
> +	const struct cpumask *possible_mask = task_cpu_possible_mask(tsk);
> +
>  	rcu_read_lock();
> +	cs_mask = task_cs(tsk)->cpus_allowed;
> +
> +	if (!is_in_v2_mode() || !cpumask_subset(cs_mask, possible_mask))
> +		goto unlock; /* select_fallback_rq will try harder */
> +
> +	do_set_cpus_allowed(tsk, cs_mask);
> +unlock:

	if (is_in_v2_mode() && cpumask_subset(cs_mask, possible_mask))
		do_set_cpus_allowed(tsk, cs_mask);

perhaps?

