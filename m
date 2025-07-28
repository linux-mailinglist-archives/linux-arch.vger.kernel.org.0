Return-Path: <linux-arch+bounces-12969-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0223CB13932
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jul 2025 12:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E6953B8EE9
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jul 2025 10:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D078202983;
	Mon, 28 Jul 2025 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jstPWDA0"
X-Original-To: linux-arch@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B1010A1E
	for <linux-arch@vger.kernel.org>; Mon, 28 Jul 2025 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753699647; cv=none; b=rExJ8iu8at++wga0Y1TF+hjGxDssDNxAwYPrlygpFN1csweGeF42axEIaxufqgI/OuzPpBKETzEsH4LpYxfHoVwshg28aUMCs0Kc4J9yZGX/GXvX5m/SI/d9MsP0+moo+WVakypwRyWtdyUJaBaznjAQgRgdYLFloDFVrGFeb3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753699647; c=relaxed/simple;
	bh=0jakwL5B2hBwM+xMjS2ZNHlPEiJ9kLDxkxVhoXtJktM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jOXYHak2iO3p2fYvbBO21tsLdcVAW66JKUVxaPtiArAVq/GTPtQacdk+UXAYVGq+m6qjWaOfEDjly9NlqByC8OUg9t4PxXoriaxWMNtX4bWbR+Cpj7kfmAEpatFmt4AZYxCn6Avd53bDgiRShH6iOZ4cegwwZFWzqJ0FSdxSgL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jstPWDA0; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=P78DUA8gdUh/DnTSJLNoinyom7BKeyDXzzR0VnFVu0I=;
	t=1753699645; x=1754909245; b=jstPWDA0K2otfMDtmSNgZmJl/CaGSHzbQktFZZ5/8OHqxzy
	t8VnkmvlIeyzIx5XCBhSKxY+7CWMHPIRrhF60ac+4m3LpjXs6f5ujy4w0Pbm/CUIjBswfqjrzAwl+
	yecP2172ObfQzSf4rSeeZwLo4GGCtTvzJf6VW5Cv/DAokXM8rRkFVBLGfuMbyWTbY6WlmZIwjfkFV
	5ei6QpLglXG29mjYe9oFJOkfNIV9txrOupS55Pz/wUUNeNNNVUdIO2rv2E73BP8+6iRYebCe9NwB4
	SspqCXEklEe2oo3Ahn15TuthLPtTkO3VQGMBIOYcTLw/QfDz0V3G12WCPJu3DU/Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ugLNt-0000000Cfcm-21ak;
	Mon, 28 Jul 2025 12:47:09 +0200
Message-ID: <233c916a5c598ca246b3138d13aaad44fdde68b2.camel@sipsolutions.net>
Subject: Re: [PATCH 9/9] um: Add initial SMP support
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.bie@linux.dev>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, tiwei.btw@antgroup.com, 
	linux-arch@vger.kernel.org
Date: Mon, 28 Jul 2025 12:47:08 +0200
In-Reply-To: <20250727062937.1369050-10-tiwei.bie@linux.dev> (sfid-20250727_083200_844163_0A31491B)
References: <20250727062937.1369050-1-tiwei.bie@linux.dev>
	 <20250727062937.1369050-10-tiwei.bie@linux.dev>
	 (sfid-20250727_083200_844163_0A31491B)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sun, 2025-07-27 at 14:29 +0800, Tiwei Bie wrote:
>=20
> +++ b/arch/um/include/asm/smp.h
> @@ -2,6 +2,27 @@
>  #ifndef __UM_SMP_H
>  #define __UM_SMP_H
> =20
> -#define hard_smp_processor_id()		0
> +#if IS_ENABLED(CONFIG_SMP)
> +
> +#include <linux/bitops.h>
> +#include <asm/current.h>
> +#include <linux/cpumask.h>
> +#include <shared/smp.h>
> +
> +#define raw_smp_processor_id() uml_curr_cpu()
> +
> +void arch_smp_send_reschedule(int cpu);
> +
> +void arch_send_call_function_single_ipi(int cpu);
> +
> +void arch_send_call_function_ipi_mask(const struct cpumask *mask);
> +
> +static inline void smp_cpus_done(unsigned int maxcpus) { }
> +
> +#else /* !CONFIG_SMP */
> +
> +#define raw_smp_processor_id() 0

This seems a bit odd to me, linux/smp.h also defines
raw_smp_processor_id() to 0 the same way, unconditionally.

It almost seems to me we should define raw_smp_processor_id() only for
SMP? But then also __smp_processor_id()? Maybe not?

linux-arch folks, do you have any comments?

> --- /dev/null
> +++ b/arch/um/include/asm/spinlock.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_UM_SPINLOCK_H
> +#define __ASM_UM_SPINLOCK_H
> +
> +#include <asm/processor.h>
> +#include <asm-generic/spinlock.h>
> +
> +#endif /* __ASM_UM_SPINLOCK_H */

Do we need this file? Maybe asm-generic should be including the right
things it needs?

> +void enter_turnstile(struct mm_id *mm_id);
> +void exit_turnstile(struct mm_id *mm_id);

We could add __acquires(turnstile) and __releases(turnstile) or
something, to have sparse check that it's locked/unlocked correctly, but
not sure it's worth it.

> +int disable_kmalloc[NR_CPUS] =3D { 0 };

nit: you can remove the "0".

> +int smp_sigio_handler(struct uml_pt_regs *regs)
> +{
> +	int cpu =3D raw_smp_processor_id();
> +
> +	IPI_handler(cpu, regs);
> +	if (cpu !=3D 0)
> +		return 1;
> +	return 0;

nit: "return cpu !=3D 0;" perhaps

> +__uml_setup("ncpus=3D", uml_ncpus_setup,
> +"ncpus=3D<# of desired CPUs>\n"
> +"    This tells UML how many virtual processors to start. The maximum\n"
> +"    number of supported virtual processors can be obtained by querying\=
n"
> +"    the CONFIG_NR_CPUS option using --showconfig.\n\n"


I feel like probably this should at least for now be mutually exclusive
with time-travel=3D parameters, at least if it's not 1? Or perhaps only
with time-travel=3Dext?

The timer code is in another patch, will look at that also. I guess
until then it's more of a gut feeling on "how would this work" :)

johannes

