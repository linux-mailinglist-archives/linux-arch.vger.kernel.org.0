Return-Path: <linux-arch+bounces-15489-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2189CC965A
	for <lists+linux-arch@lfdr.de>; Wed, 17 Dec 2025 20:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66A1A3037538
	for <lists+linux-arch@lfdr.de>; Wed, 17 Dec 2025 19:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DF42D8768;
	Wed, 17 Dec 2025 19:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kuPBRqFv"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A422D3737;
	Wed, 17 Dec 2025 19:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765999091; cv=none; b=TIY6E3L6UGv4BmbnjM8TwGYHNe9pL4vAYB+gZvYQJhDUqSfuIqQhnWhzGwkjlA663oHjcoIf3ewK+xkWr+NNxZnLNdpfvrk6cr3+zVeMjsGJSI+Y3fttzC5suBbARAQx5NEwYS+EAAqOP5G5SO2jHTpVTG4HxfRREHG93ILlJZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765999091; c=relaxed/simple;
	bh=RVjwUWjfM0l8CgpGVO1vImP3gzSCiQwDwiVgcKpxHbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLNZKdZc2ybfrtjskboUSGzm4dT3fDbjE0Ctpko+80N8t2YE3cvrJ4fO00iA1cj6OKn5xsWVOZD98rT7UgvtzpziAbizBlsQ0ZImf2R56l3H+fDMN8VHI9QIGnxGWBCrxxxq2ZhdBwuiCGndw3qkOVsMYAZr3ecJHeCZepIksQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kuPBRqFv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=c2Iph/Ra0CUXoq1po7KdfFuGORJ13IZYm9gWA0fuui8=; b=kuPBRqFvCK+OW5T/2nS/Ef4D3z
	xn3oCljDGhxO+5Tl7Lcf0sf/BnzHlDEjGtd84YSLqO+jO+Ap1dN5BIR/iFQRJoJ2MGJOjxzeOXS8v
	NWfhmT9D4TEzTDJwSIpCXXNYVfU8T1Yj6zxmy5cEKbCwdvDMElhEJJPPmIC+w2o6exn33m3bmLJ9f
	+ozbkxripqf/LJVfuj71+Zu5nuxnd1mWCoywGaJo9g841iJRdfG1687Ckpuu3nUB9isOwwew19Eul
	blBBMsISomM2QxfoAkKTxVKhs/Tz9OBKcg0630tPMvk+Dbb57z4IF4na3T8/xqQ4CGFNTlwPh7txi
	3Gw7s8fw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVx2C-00000007JfK-3hZ7;
	Wed, 17 Dec 2025 19:18:04 +0000
Message-ID: <091d2447-6817-46ed-96f4-360a747bfc90@infradead.org>
Date: Wed, 17 Dec 2025 11:18:04 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-v3 2/3] genirq: Adaptive Global Software Interrupt
 Moderation (GSIM)
To: Luigi Rizzo <lrizzo@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Marc Zyngier <maz@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Sean Christopherson <seanjc@google.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>
References: <20251217112128.1401896-1-lrizzo@google.com>
 <20251217112128.1401896-3-lrizzo@google.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251217112128.1401896-3-lrizzo@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 12/17/25 3:21 AM, Luigi Rizzo wrote:
> Make GSIM adaptive by measuring total and per-CPU interrupt rates, as
> well as time spent in hardirq on each CPU. The metrics are compared to
> configurable targets, and each CPU adjusts the moderation delay up
> or down depending on the result, using multiplicative increase/decrease.
> 
> Configuration is done at boot time via module parameters
> 
>     irq_moderation.${NAME}=${VALUE}
> 
> or at runtime via /proc/irq/soft_moderation
> 
>     echo ${NAME}=${VALUE} > /proc/irq/soft_moderation
> 
> Parameters are:
> 
>   delay_us (0 off, range 0-500)
>       Maximum moderation delay in microseconds.
> 
>   target_intr_rate (0 off, range 0-50000000)
>       Total rate above which moderation should trigger.
> 
>   hardirq_percent (0 off,range 0-100)
>       Percentage of time spent in hardirq above which moderation should
>       trigger.
> 
>   update_ms (range 1-100)
>       How often the metrics should be computed and moderation delay
>       updated.

This could use some userspace documentation, e.g., in Documentation/admin-guide/,
or in Documentation/admin-guide/kernel-parameters.txt.
or in Documentation/core-api/irq/...

> When target_intr_rate and hardirq_percent are both 0, GSIM uses a fixed
> moderation delay equal to delay_us. Otherwise, the delay is dynamically
> adjusted up or down, independently on each CPU, based on how the total
> and per-CPU metrics compare with the targets.
> 
> Provided that delay_us suffices to bring the metrics within the target,
> the control loop will dynamically converge to the minimum actual
> moderation delay to stay within the target.
> 
> Change-Id: I19b15d98e214a90fadee1c6e5bce6c8aac7a709a

checkpatch says that we don't take Change-Id: lines in a patch.
OTOH, the git tree currently has 415 of them.
I wonder if we have given up on that.

> Signed-off-by: Luigi Rizzo <lrizzo@google.com>
> ---
>  kernel/irq/Makefile              |   2 +-
>  kernel/irq/irq_moderation.c      |  94 ++++++++++++++++--
>  kernel/irq/irq_moderation.h      |  46 ++++++++-
>  kernel/irq/irq_moderation_hook.c | 157 +++++++++++++++++++++++++++++++
>  kernel/irq/irq_moderation_hook.h |  12 +--
>  5 files changed, 291 insertions(+), 20 deletions(-)
>  create mode 100644 kernel/irq/irq_moderation_hook.c


-- 
~Randy


