Return-Path: <linux-arch+bounces-4970-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF5C90EA85
	for <lists+linux-arch@lfdr.de>; Wed, 19 Jun 2024 14:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C5171C23E89
	for <lists+linux-arch@lfdr.de>; Wed, 19 Jun 2024 12:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CF01422CE;
	Wed, 19 Jun 2024 12:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhWiNJ0+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509981419A6;
	Wed, 19 Jun 2024 12:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799040; cv=none; b=c6p9Cxknv23kI1T9+V/MZtjNcqdjoqzyab3n7E9yADJ6ezhmg3oO+VPqKsnSL3CJnGzoJYClYOfUrlTpBHrRd2TUBZmPe2cD6D6yqfyVuXfBM4sqkPGCP48kMzcyRtprehw9pRbKLfs8QGxkv6jr1s38SHZ+QwL8QeZCdfDC4/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799040; c=relaxed/simple;
	bh=ALeYzxeS3iOY2rx4/Kx+ydsSavqKfiI2lPUx7xtO4Lo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GfmPJG9SfFm7y9Os0iryauSWRjR7y3QFM9CcBHPVAehmMHX2gohYEKRYZtMjvIRV9VcJEFTNRoLzfBp8ekjMwXZjyeH3DoCy3D9J5jFvW/4YpzRVT3I+AbkWt4tV53gdfnxRor3hC8yff2nSgt1VwRtQCp1h/OIe+/I31q81qeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhWiNJ0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F498C2BBFC;
	Wed, 19 Jun 2024 12:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718799040;
	bh=ALeYzxeS3iOY2rx4/Kx+ydsSavqKfiI2lPUx7xtO4Lo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BhWiNJ0+B3Q4eHQ1K7y8i+X17whuMCJeFlKi9b8MGlUccFDRcokvvQb6YrbkjfgTa
	 cHVPfzP+fAWgVmJOujiYoRkbS5WAMR8WfGthqljGJsAP8CtGBeqKc0XZKG00yQLstP
	 qbO5Wn5qV47nujprFxnzPCSMS4r546QuEP6PdYfDbWMX/BVe9X6QnwIskwq8R5cphm
	 GzgQU60LmN52ts2ygjfjDKheMcc5LN95Tjj1vfumM80dJaqtrPovkDTOky1V+DwU2+
	 SyveyxTMRowvWN3OMX1KUNfx/cluUsknBPyuiWq/ML8tHU7RO56XhRTTkmhfVF/o1C
	 dGTsLLBemPaZg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sJu97-005RVc-6I;
	Wed, 19 Jun 2024 13:10:37 +0100
Date: Wed, 19 Jun 2024 13:10:36 +0100
Message-ID: <868qz1jfpf.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Will Deacon <will@kernel.org>,
	Catalin
 Marinas <catalin.marinas@arm.com>,
	<linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-pm@vger.kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	<loongarch@lists.linux.dev>,
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
	Hanjun Guo <guohanjun@huawei.com>,
	Gavin
 Shan <gshan@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov
	<bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	<linuxarm@huawei.com>,
	<justin.he@arm.com>,
	<jianyong.wu@arm.com>
Subject: Re: [PATCH v10 14/19] irqchip/gic-v3: Add support for ACPI's disabled but 'online capable' CPUs
In-Reply-To: <20240529133446.28446-15-Jonathan.Cameron@huawei.com>
References: <20240529133446.28446-1-Jonathan.Cameron@huawei.com>
	<20240529133446.28446-15-Jonathan.Cameron@huawei.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.2
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: Jonathan.Cameron@huawei.com, will@kernel.org, catalin.marinas@arm.com, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, mark.rutland@arm.com, tglx@linutronix.de, peterz@infradead.org, loongarch@lists.linux.dev, x86@kernel.org, linux@armlinux.org.uk, rafael@kernel.org, miguel.luis@oracle.com, james.morse@arm.com, salil.mehta@huawei.com, jean-philippe@linaro.org, guohanjun@huawei.com, gshan@redhat.com, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, linuxarm@huawei.com, justin.he@arm.com, jianyong.wu@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Wed, 29 May 2024 14:34:41 +0100,
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> From: James Morse <james.morse@arm.com>
> 
> To support virtual CPU hotplug, ACPI has added an 'online capable' bit
> to the MADT GICC entries. This indicates a disabled CPU entry may not
> be possible to online via PSCI until firmware has set enabled bit in
> _STA.
> 
> This means that a "usable" GIC redistributor is one that is marked as
> either enabled, or online capable. The meaning of the
> acpi_gicc_is_usable() would become less clear than just checking the
> pair of flags at call sites. As such, drop that helper function.
> The test in gic_acpi_match_gicc() remains as testing just the
> enabled bit so the count of enabled distributors is correct.
> 
> What about the redistributor in the GICC entry? ACPI doesn't want to say.
> Assume the worst: When a redistributor is described in the GICC entry,
> but the entry is marked as disabled at boot, assume the redistributor
> is inaccessible.
> 
> The GICv3 driver doesn't support late online of redistributors, so this
> means the corresponding CPU can't be brought online either.
> Rather than modifying cpu masks that may already have been used,
> register a new cpuhp callback to fail this case. This must run earlier
> than the main gic_starting_cpu() so that this case can be rejected
> before the section of cpuhp that runs on the CPU that is coming up as
> that is not allowed to fail. This solution keeps the handling of this
> broken firmware corner case local to the GIC driver. As precise ordering
> of this callback doesn't need to be controlled as long as it is
> in that initial prepare phase, use CPUHP_BP_PREPARE_DYN.
> 
> Systems that want CPU hotplug in a VM can ensure their redistributors
> are always-on, and describe them that way with a GICR entry in the MADT.
> 
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Acked-by: Marc Zyngier <maz@kernel.org>

	M.

-- 
Without deviation from the norm, progress is not possible.

