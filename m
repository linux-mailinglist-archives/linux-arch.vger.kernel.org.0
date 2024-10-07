Return-Path: <linux-arch+bounces-7774-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EB7993313
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 18:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A268D1C23324
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 16:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481E21DA63F;
	Mon,  7 Oct 2024 16:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJYICkUq"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EA01D9323;
	Mon,  7 Oct 2024 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318292; cv=none; b=OVyoHlAdnhQx75dXztu//CICkV8NyJ39vOnt/UuiCzMu8Ho2Y0voeGWZaKFTbXFnbuWGOT0Gnm+oBx7gPBdHlGtH3HSrHH0LqmPpDwXsynix6Ew6jXu+heipHRFD9teT99tR9WhMcr4dT967HXom9oerkmbh8x/wzBTk2CD9/4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318292; c=relaxed/simple;
	bh=t9gHw1zeHjhDEALyoXlqt+i//qaSO2UwX8WGzU42axg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijxsc9laexpxd5AR9PX944D7bsFMa8KY88LuB9ttoVCZFGHOsxWCncy6zvY8LTLmtuPWbtTmxIe0gIVa6eTyjQw23BTz8blAsvUfgIYayq2MSvWzhaEZVCSQwU3IH89kGwzCPt9TMWGggG1FsMgmu2R5acK6EZSbSQMoce0gbdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJYICkUq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00687C4CEC6;
	Mon,  7 Oct 2024 16:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728318291;
	bh=t9gHw1zeHjhDEALyoXlqt+i//qaSO2UwX8WGzU42axg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iJYICkUq/g4S3TigA3NqBkw4GdgCJmLhHl1KeLgLd2z90uAZNNNlQLWGqSsPIkQlV
	 fjcQOQaGR0hpZ4toL1ik2iN9cZoY9d5YWXwv48q0LdimVsdElFuJMBzIWKyNzifm8q
	 dCP6xr2c/+/ZEenMKs5PJiH5vTAm9jUtDbWuHuCKbj8m6lOLo7QJpZFMzzhC8m0S0o
	 OHi5Vw7YYJo5M7U3UsnNhIVLZT1uP06u7MKkgTRiuEUstK6M4k7FHDzoas5p4gw1rO
	 bij4+wxI2fTU9OsSR7dpm3FYNNXy6LxnxUGYd9DhcEdbWR9hZbaFpOI4Glpd+ayweW
	 SMZTIy+z2MmEw==
Date: Mon, 7 Oct 2024 16:24:49 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	iommu@lists.linux.dev, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	virtualization@lists.linux.dev, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	catalin.marinas@arm.com, will@kernel.org, luto@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	seanjc@google.com, pbonzini@redhat.com, peterz@infradead.org,
	daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, arnd@arndb.de,
	sgarzare@redhat.com, jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com, skinsburskii@linux.microsoft.com,
	mukeshrathor@microsoft.com
Subject: Re: [PATCH 2/5] hyperv: Remove unnecessary #includes
Message-ID: <ZwQLUf4aZ5x3Pnkn@liuwe-devbox-debian-v2>
References: <1727985064-18362-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1727985064-18362-3-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1727985064-18362-3-git-send-email-nunodasneves@linux.microsoft.com>

On Thu, Oct 03, 2024 at 12:51:01PM -0700, Nuno Das Neves wrote:
> asm/hyperv-tlfs.h is already included implicitly wherever mshyperv.h
> or linux/hyperv.h is included. Remove those redundancies.
> 
> Remove includes of linux/hyperv.h and mshyperv.h where they are not
> needed.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Acked-by: Wei Liu <wei.liu@kernel.org>

