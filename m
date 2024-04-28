Return-Path: <linux-arch+bounces-4034-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F8F8B4B83
	for <lists+linux-arch@lfdr.de>; Sun, 28 Apr 2024 13:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08B83B21075
	for <lists+linux-arch@lfdr.de>; Sun, 28 Apr 2024 11:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4064357303;
	Sun, 28 Apr 2024 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Btaefxo1"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FB042042;
	Sun, 28 Apr 2024 11:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714303690; cv=none; b=jCHu45UqSmYVQy1p7R1rEsgfmb64/oJ4CBLqjvGyFK5YDMxBwvWzkXFYFt7EWJdtuXRuNV0bBAxC4HwYgv9cxTecjZVSLF+E1VG82/1Pqr5QGX4xG5UKtjD1n5t2s5oAF4lkQdIk0G5mhBe4LuFgiwDgW2kAfS3SToKdqeT470k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714303690; c=relaxed/simple;
	bh=rJc04lQPGAte3sgRY0zpeVVbUDNqqGYs1de72FW6xAs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WL7DzwBEwdT/G5ln1GRke5Ktju4Ho3ChlskFC/dSYBux9v4CPAXAEN7kOkNgkCI3r5irlc+M/YsA4iUp+rcVyKjbsgUIDCPRWgly69AK7uYz3XNy0maF0ey3q+dqN6fzy7rjmxDfuInUMYmZJHXeGjQoCtfwBaViK+9MSm5IiH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Btaefxo1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E24C113CC;
	Sun, 28 Apr 2024 11:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714303689;
	bh=rJc04lQPGAte3sgRY0zpeVVbUDNqqGYs1de72FW6xAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Btaefxo10uErlTPoPMBzc3QSERSMGWTlDvMlrSz90PUhcYtUja0aJH4eJKGek6fJf
	 PtZQCrETOb541/H5bYGFFkda+JnADdkWOqXsCm5npThloYgFTJUCR0NNXroWbUx55M
	 xYx9CyZlRwd6ZlMEOMRjD6jIeyFYgDhru/uKNcBCUB3I0WawgBPWl/7MFE1Ozy6olY
	 AYHFd/1omU+ZP63jEkw2vtrxBrBNlvmrs5SLMZENl2ET1lAAQ1qtjk4hDgfKKMiXHD
	 qNc1cNAs8A2HJ0CDp2o+STw+a6kt21n3Z1Fru2vOYQJ+4lTtiSX48rT2itnTVkOF8h
	 CaJ539gHZWg4Q==
Received: from 82-132-246-56.dab.02.net ([82.132.246.56] helo=wait-a-minute.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1s12hS-008nyp-PJ;
	Sun, 28 Apr 2024 12:28:07 +0100
Date: Sun, 28 Apr 2024 12:28:03 +0100
Message-ID: <87frv5u3p8.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra
	<peterz@infradead.org>,
	<linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<kvmarm@lists.linux.dev>,
	<x86@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	"Rafael J . Wysocki"
	<rafael@kernel.org>,
	Miguel Luis <miguel.luis@oracle.com>,
	"James Morse"
	<james.morse@arm.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe
 Brucker <jean-philippe@linaro.org>,
	Catalin Marinas
	<catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Hanjun Guo
	<guohanjun@huawei.com>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov
	<bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	<linuxarm@huawei.com>,
	<justin.he@arm.com>,
	<jianyong.wu@arm.com>,
	"Lorenzo\
 Pieralisi" <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v8 11/16] irqchip/gic-v3: Add support for ACPI's disabled but 'online capable' CPUs
In-Reply-To: <20240426192858.000033d9@huawei.com>
References: <20240426135126.12802-1-Jonathan.Cameron@huawei.com>
	<20240426135126.12802-12-Jonathan.Cameron@huawei.com>
	<87il04t7j2.wl-maz@kernel.org>
	<20240426192858.000033d9@huawei.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/28.2
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 82.132.246.56
X-SA-Exim-Rcpt-To: Jonathan.Cameron@Huawei.com, tglx@linutronix.de, peterz@infradead.org, linux-pm@vger.kernel.org, loongarch@lists.linux.dev, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, linux@armlinux.org.uk, rafael@kernel.org, miguel.luis@oracle.com, james.morse@arm.com, salil.mehta@huawei.com, jean-philippe@linaro.org, catalin.marinas@arm.com, will@kernel.org, guohanjun@huawei.com, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, linuxarm@huawei.com, justin.he@arm.com, jianyong.wu@arm.com, lpieralisi@kernel.org, sudeep.holla@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Fri, 26 Apr 2024 19:28:58 +0100,
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> 
> I'll not send a formal v9 until early next week, so here is the current state
> if you have time to take another look before then.

Don't bother resending this on my account -- you only sent it on
Friday and there hasn't been much response to it yet. There is still a
problem (see below), but looks otherwise OK.

[...]

> @@ -2363,11 +2381,25 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_headers *header,
>  				(struct acpi_madt_generic_interrupt *)header;
>  	u32 reg = readl_relaxed(acpi_data.dist_base + GICD_PIDR2) & GIC_PIDR2_ARCH_MASK;
>  	u32 size = reg == GIC_PIDR2_ARCH_GICv4 ? SZ_64K * 4 : SZ_64K * 2;
> +	int cpu = get_cpu_for_acpi_id(gicc->uid);

I already commented that get_cpu_for_acpi_id() can...

>  	void __iomem *redist_base;
>  
> -	if (!acpi_gicc_is_usable(gicc))
> +	/* Neither enabled or online capable means it doesn't exist, skip it */
> +	if (!(gicc->flags & (ACPI_MADT_ENABLED | ACPI_MADT_GICC_ONLINE_CAPABLE)))
>  		return 0;
>  
> +	/*
> +	 * Capable but disabled CPUs can be brought online later. What about
> +	 * the redistributor? ACPI doesn't want to say!
> +	 * Virtual hotplug systems can use the MADT's "always-on" GICR entries.
> +	 * Otherwise, prevent such CPUs from being brought online.
> +	 */
> +	if (!(gicc->flags & ACPI_MADT_ENABLED)) {
> +		pr_warn("CPU %u's redistributor is inaccessible: this CPU can't be brought online\n", cpu);
> +		cpumask_set_cpu(cpu, &broken_rdists);

... return -EINVAL, and then be passed to cpumask_set_cpu(), with
interesting effects. It shouldn't happen, but I trust anything that
comes from firmware tables as much as I trust a campaigning
politician's promises. This should really result in the RD being
considered unusable, but without affecting any CPU (there is no valid
CPU the first place).

Another question is what get_cpu_for acpi_id() returns for a disabled
CPU. A valid CPU number? Or -EINVAL?

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.

