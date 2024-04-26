Return-Path: <linux-arch+bounces-4013-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB1B8B3B06
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 17:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF39A1C21C86
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 15:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588FB14C5BF;
	Fri, 26 Apr 2024 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="km+b6tIq"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED9C14BFA2;
	Fri, 26 Apr 2024 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144481; cv=none; b=ksja+Ouc/0Tp9iH0hwPfIM5ZFXI7RuChDwwTy3Oo6O0jDiKff7cMBn5U9wG1frWVxExyM35JAJZNHDEnE+QEbLXgFyka2rSlBmgDn/6/RHou4DAf0XODFC4XwviiEadCMizi8ICcS6jjit8/W4i4pYM1oCJrZ2NavegELnmGCKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144481; c=relaxed/simple;
	bh=//WzziHnNqcmkxi03bLLdDyX60lkCsTbOIScyFVBsNY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Byj8KMK/PIO2p8eN1Ec7Qiup4yaHEhLzknSyWD9J6ugpxS/GnAtvm3WQEzRY/nmUNokUZaAtvNUnwWseTGufKUGYTLw0t0yIZj4nD5jvNYaQl96SNi0uweKbuXRUMdY7Vk1MQ3KrYCTaS/13b82I3epBuol7MGllAlC6CyGExSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=km+b6tIq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B91C113CD;
	Fri, 26 Apr 2024 15:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714144480;
	bh=//WzziHnNqcmkxi03bLLdDyX60lkCsTbOIScyFVBsNY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=km+b6tIq0ulf9lIhA6+EpCgzdNOG8OhZWIPXLRWXb4dyy1CY15QA+tqTPrjCXhSPF
	 s3A/t2V7K/EXXL55ObKMuTe0KeQkcvL8lHAf4NkYwny/pjKljWKTh8C7w2v3gMCeAP
	 +WswzMTPVGeA7UyA9Y6xzfLtqAdVD5dHXj95Yw1BdQE7wKSGSeurUWCA1j6ew+Bzgb
	 Ad+ynfMADgf0ZNJFskgCwWtJAi9oDLJJ8Fuv9eB/08pm+CVJzzdUJtKPAEXyI2Jjjk
	 rlGFYqo2oE9HD3bFX+O6oE5XSdFmk7VWk5ycyKdK0T7r2s1EZEBRN/cSiVH6vgN6uc
	 2nZV2F0z/zDMg==
Received: from 82-132-222-182.dab.02.net ([82.132.222.182] helo=wait-a-minute.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1s0NHX-008GN9-HC;
	Fri, 26 Apr 2024 16:14:37 +0100
Date: Fri, 26 Apr 2024 16:14:29 +0100
Message-ID: <87jzkktaui.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
	James Morse
	<james.morse@arm.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe
 Brucker <jean-philippe@linaro.org>,
	Catalin Marinas
	<catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave
 Hansen <dave.hansen@linux.intel.com>,
	<linuxarm@huawei.com>,
	<justin.he@arm.com>,
	<jianyong.wu@arm.com>,
	Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v8 10/16] irqchip/gic-v3: Don't return errors from gic_acpi_match_gicc()
In-Reply-To: <20240426135126.12802-11-Jonathan.Cameron@huawei.com>
References: <20240426135126.12802-1-Jonathan.Cameron@huawei.com>
	<20240426135126.12802-11-Jonathan.Cameron@huawei.com>
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
X-SA-Exim-Connect-IP: 82.132.222.182
X-SA-Exim-Rcpt-To: Jonathan.Cameron@huawei.com, tglx@linutronix.de, peterz@infradead.org, linux-pm@vger.kernel.org, loongarch@lists.linux.dev, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, linux@armlinux.org.uk, rafael@kernel.org, miguel.luis@oracle.com, james.morse@arm.com, salil.mehta@huawei.com, jean-philippe@linaro.org, catalin.marinas@arm.com, will@kernel.org, guohanjun@huawei.com, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, linuxarm@huawei.com, justin.he@arm.com, jianyong.wu@arm.com, lpieralisi@kernel.org, sudeep.holla@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Fri, 26 Apr 2024 14:51:20 +0100,
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> From: James Morse <james.morse@arm.com>
> 
> gic_acpi_match_gicc() is only called via gic_acpi_count_gicr_regions().
> It should only count the number of enabled redistributors, but it
> also tries to sanity check the GICC entry, currently returning an
> error if the Enabled bit is set, but the gicr_base_address is zero.
> 
> Adding support for the online-capable bit to the sanity check will
> complicate it, for no benefit. The existing check implicitly depends on
> gic_acpi_count_gicr_regions() previous failing to find any GICR regions
> (as it is valid to have gicr_base_address of zero if the redistributors
> are described via a GICR entry).
> 
> Instead of complicating the check, remove it. Failures that happen at
> this point cause the irqchip not to register, meaning no irqs can be
> requested. The kernel grinds to a panic() pretty quickly.
>
> Without the check, MADT tables that exhibit this problem are still
> caught by gic_populate_rdist(), which helpfully also prints what went
> wrong:
> | CPU4: mpidr 100 has no re-distributor!
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Marc Zyngier <maz@kernel.org>

	M.

-- 
Without deviation from the norm, progress is not possible.

