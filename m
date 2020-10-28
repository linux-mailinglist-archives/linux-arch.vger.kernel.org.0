Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3183D29DEED
	for <lists+linux-arch@lfdr.de>; Thu, 29 Oct 2020 01:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgJ2A54 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Oct 2020 20:57:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731584AbgJ1WRd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:33 -0400
Received: from gaia (unknown [95.145.162.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDEF4246F2;
        Wed, 28 Oct 2020 12:15:09 +0000 (UTC)
Date:   Wed, 28 Oct 2020 12:15:07 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>, kernel-team@android.com
Subject: Re: [PATCH 5/6] arm64: Advertise CPUs capable of running 32-bit
 applcations in sysfs
Message-ID: <20201028121506.GG13345@gaia>
References: <20201027215118.27003-1-will@kernel.org>
 <20201027215118.27003-6-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027215118.27003-6-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 27, 2020 at 09:51:17PM +0000, Will Deacon wrote:
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index b555df825447..19893fb8e870 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -472,6 +472,14 @@ Description:	AArch64 CPU registers
>  		'identification' directory exposes the CPU ID registers for
>  		 identifying model and revision of the CPU.
>  
> +What:		/sys/devices/system/cpu/aarch32_el0

Nitpick: should we call this aarch32_el0_present? It's not exactly
present as we populate it as CPUs come online but it's closer to this
mask than to the online one.

> +Date:		October 2020
> +Contact:	Linux ARM Kernel Mailing list <linux-arm-kernel@lists.infradead.org>
> +Description:	Identifies the subset of CPUs in the system that can execute
> +		AArch32 (32-bit ARM) applications. If absent, then all or none
> +		of the CPUs can execute AArch32 applications and execve() will
> +		behave accordingly.

What does "accordingly" mean? Normally, we'd get ENOEXEC but here the
execve() "succeeds" followed by a SIGKILL if it ends up on the wrong
CPU.

-- 
Catalin
