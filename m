Return-Path: <linux-arch+bounces-7214-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEF8975971
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 19:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD6F1C220D0
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 17:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC3D1B1D44;
	Wed, 11 Sep 2024 17:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6xM18AY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D2D19CC15;
	Wed, 11 Sep 2024 17:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726075957; cv=none; b=tp/Qze/QXwlD/8Y7hzX0xAn3rW7OnmWKo4NRJ1R5pS0LVzJ22TsvoMvzcPOWCHIPU7an/otJAlF+PgtexP9lhovGFrD/jBcEpfP73rGV5byyQJ71m5x/LCBvQ5Mhx07AqqrMLByxUm0wfqjQEVNAkTsx67vluF88KQg1CrMV6Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726075957; c=relaxed/simple;
	bh=AeymH7bKoVkE1jmGAzP5lh7i5xW8xjMn5ZzGFH3XoRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ia837cQvtPXy+PVr0xW4iqLLRgTJTJqeEqPXFyem+H5halI/6ETvw56kh0nZgRxR6ZvXu2C1C1Z7RtZri9vXbVfx84KQIr5e342umMUs57O8xJVVLDTX8jDlzPzSkis9Dc6O1yFWMAGs8C9vh6/vxwh5HOl6/Mfr0/uNjV21G4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6xM18AY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4F1C4CEC0;
	Wed, 11 Sep 2024 17:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726075956;
	bh=AeymH7bKoVkE1jmGAzP5lh7i5xW8xjMn5ZzGFH3XoRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q6xM18AYJsqIusmQ4//hH1DKwzNsNgN9j+z+iYQHr0yER/Wb3sWIaPZr6hn8XcfqJ
	 57/+avnS0r+WtcXmbgKJN4Im55SwLzvewVSqwWREC4FHngSS6pSBqxz2n1PYhJEjkP
	 RQGwD+jGHBv4pmlUQYk3Yukjsuque/beaEqH6zUVleujzJj4Z6IQ9Hn1SAAiNwsAcv
	 5Lpd5Bu0kBwNZ3IakBXnFqjaw642cc/5lKr5V2u2xawlRkWoWvsUbqeh/Lk4C8Yz2b
	 U1rSoSsI78Nf/0vcR02Iu8XVMjRHdsrRv90srnaDVONtlWnbv90qBDCXIFCP23SGbG
	 8Q6D2l6XEYOmQ==
Date: Wed, 11 Sep 2024 12:32:35 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] modpost: check section mismatch in reference to
 .dtb.init.rodata
Message-ID: <172607595481.1006814.4998124247259811209.robh@kernel.org>
References: <20240910094459.352572-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910094459.352572-1-masahiroy@kernel.org>


On Tue, 10 Sep 2024 18:44:52 +0900, Masahiro Yamada wrote:
> Built-in DTB files are discarded because KERNEL_DTB() is a part of
> INIT_DATA, as defined in include/asm-generic/vmlinux.lds.h.
> 
> Currently, modpost warns about mismatched section references to init
> data only when the destination section is prefixed with ".init.".
> However, ".dtb.init.rodata" is also discarded.
> 
> This commit has revealed some missing annotations.
> 
> overlays[] references builtin DTBs, which become dangling pointers
> after early boot.
> 
> testdrv_probe() is not an __init function, yet it holds a reference to
> overlays[]. The assumption is that this function is executed only at
> the boot time even though it remains in memory. I annotated it as __ref
> because otherwise I do not know how to suppress the modpost warning.
> 
> I marked the dtb_start as __initdata in the Xtensa boot code, although
> modpost does not warn about it because __dtb_start is not yet defined
> at the time of modpost.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> Changes in v2:
>   - New patch
> 
>  arch/xtensa/kernel/setup.c | 2 +-
>  drivers/of/unittest.c      | 5 +++--
>  scripts/mod/modpost.c      | 2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


