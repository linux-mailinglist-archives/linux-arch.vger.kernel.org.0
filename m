Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F167229D6B4
	for <lists+linux-arch@lfdr.de>; Wed, 28 Oct 2020 23:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbgJ1WRg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Oct 2020 18:17:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731605AbgJ1WRf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:35 -0400
Received: from gaia (unknown [95.145.162.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 762B8246EE;
        Wed, 28 Oct 2020 12:10:56 +0000 (UTC)
Date:   Wed, 28 Oct 2020 12:10:53 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>, kernel-team@android.com
Subject: Re: [PATCH 4/6] arm64: Kill 32-bit applications scheduled on
 64-bit-only CPUs
Message-ID: <20201028121052.GF13345@gaia>
References: <20201027215118.27003-1-will@kernel.org>
 <20201027215118.27003-5-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027215118.27003-5-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 27, 2020 at 09:51:16PM +0000, Will Deacon wrote:
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 4784011cecac..c45b5f9dd66b 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -542,6 +542,17 @@ static void erratum_1418040_thread_switch(struct task_struct *prev,
>  	write_sysreg(val, cntkctl_el1);
>  }
>  
> +static void compat_thread_switch(struct task_struct *next)
> +{
> +	if (!is_compat_thread(task_thread_info(next)))
> +		return;
> +
> +	if (!system_has_mismatched_32bit_el0())
> +		return;
> +
> +	set_tsk_thread_flag(next, TIF_NOTIFY_RESUME);
> +}

I wonder whether you could use set_notify_resume() for consistency.

-- 
Catalin
