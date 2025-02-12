Return-Path: <linux-arch+bounces-10127-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E38CA31D45
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2025 05:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3FF0188A756
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2025 04:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B48E1DF27D;
	Wed, 12 Feb 2025 04:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoijgSAC"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED2C1DE4D5;
	Wed, 12 Feb 2025 04:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739333406; cv=none; b=ic67Mbe7d4Vwj5Ej2cL3s42BldNo/TlmAnIxaqKwelWMhKNjjoVSB7RoIKYfHlgXcZuMSW1sUbxaIpfTkL5t2nAAvbpOzIsxfmmq5dXM88eT91TZ2eizzFTO8iweMTOgDikMbsW/M4JLKArknT/DO2BXBQ0P62s1iikjqmn8EQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739333406; c=relaxed/simple;
	bh=LfTqYMNqbDCdif5LqgS5/zDpDtXkvNu0iQqDL0rZSm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Axuc36JyWNvfDOBXwhXgSXlgntXMNeOXnQB4YQfmKGUdHDSFQwHd+XMKEzu1h3EbgO0Q5mOedjs5fMRP7e745oTvTgY4IgW/j5D/TLsxEUFq0OnZcx+VaAU7oxzqrubk8qjVE7bOf4HYkSSSLFTjyC2T3CJceCSYuwQseRXYJ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoijgSAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D29CC4CEDF;
	Wed, 12 Feb 2025 04:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739333405;
	bh=LfTqYMNqbDCdif5LqgS5/zDpDtXkvNu0iQqDL0rZSm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XoijgSACpeHYNmrRqkpsja2L/mnGksF3YPY3mmltqefrFF0vhrkYuuIUYu2ay4+x3
	 Z2Mq1AjdX6kpP1Yk40Owq3AU0CVRB9idFQOJ/WV8uUouC0wwhQsIwhor1bjP0MlAa4
	 FJVnaJBdd7pC+a9aM41fOiQi4oFjlECLOtNxTdd3D9d9/zBVTFUMWoM1Ky48Vb6Bl1
	 U7E7LZH38fvax6FN5Ir1FvWN0Ct8poE51V78ev9G5P+lfxZUC3Iz+o+uz02u6wLsaO
	 Yp17Rev7jXMu9NXhoCAng59TtEB+XeIVAOs6BqUTkx1Q76qrVi5SayoRVg93th2LIu
	 yqDnvZhs7XfCQ==
Date: Wed, 12 Feb 2025 04:10:04 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	wei.liu@kernel.org, mhklinux@outlook.com, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com,
	catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
	jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
	skinsburskii@linux.microsoft.com, mukeshrathor@microsoft.com
Subject: Re: [PATCH v3 0/2] hyperv: Move some features to common code
Message-ID: <Z6wfHOPNUL2KcSG8@liuwe-devbox-debian-v2>
References: <1738955002-20821-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1738955002-20821-1-git-send-email-nunodasneves@linux.microsoft.com>

On Fri, Feb 07, 2025 at 11:03:20AM -0800, Nuno Das Neves wrote:
> There are several bits of Hyper-V-related code that today live in
> arch/x86 but are not really specific to x86_64 and will work on arm64
> too.
> 
> Some of these will be needed in the upcoming mshv driver code (for
> Linux as root partition on Hyper-V). So this is a good time to move
> them to drivers/hv.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
> Changes in v3:
> * Just use percpu input page for the hypercall [Michael Kelley]
> * Move the calls to hv_get_partition_id() back to arch code [Michael Kelley]
> * Rename struct hv_get_partition_id to hv_output_get_partition_id
>   [Michael Kelley]
> 
> Changes in v2:
> * Fix dependence on percpu output page by using a stack variable for the
>   hypercall output [Michael Kelley]
> * Remove unnecessary WARN()s [Michael Kelley]
> * Define hv_current_partition_id in hv_common.c [Michael Kelley]
> * Move entire hv_proc.c to drivers/hv [Michael Kelley]
> 
> Nuno Das Neves (2):
>   hyperv: Move hv_current_partition_id to arch-generic code
>   hyperv: Move arch/x86/hyperv/hv_proc.c to drivers/hv

Applied to hyperv-next. Thanks.

