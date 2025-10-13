Return-Path: <linux-arch+bounces-14057-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 841FFBD5D4B
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 21:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 421074EDF23
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 19:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43CB264614;
	Mon, 13 Oct 2025 19:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZWkdTCD"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DD11EDA02;
	Mon, 13 Oct 2025 19:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760382104; cv=none; b=p8PHyHmXZbEAym0gIzfSjdpFj9ywNOlZCmo5W6AO+Xq59ArY0IGP/43DTWNdEQ2vX3KONmHzHy6jOJ5i0kIgywhGm87YManFReB+6ZdTlU2SWyIK75ZPcg/+AnYdEkr42Slh08TiPbNRPW24ICjOb3gyM63Xv1hRE8AIHawvF3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760382104; c=relaxed/simple;
	bh=+CxRU6U03dEdDulYL+z4R714ymbWoLNPP82BVX+Tfvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVljfhHVld9FjrT/zoAoRaAUbJy6MhwMHEI/AzMZOjac9ZCm6CbBg3almNBGlUkV1pG61vLmsrwuaxxqqR13oa59Kk9du+s19KFvtloS1YdKe2qON907oHhlEwz6Xq/Ld5b+4UOQ94AvFhPVte8QEK5Ntu/dwvkSqSlDcHHAhEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZWkdTCD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3060C4CEE7;
	Mon, 13 Oct 2025 19:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760382104;
	bh=+CxRU6U03dEdDulYL+z4R714ymbWoLNPP82BVX+Tfvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NZWkdTCDgyWKBgOE6e03He+XHuLVo1ncetCCzvD0rGiz6ZBTre9WlVoAz0sEERqR0
	 mP4CGIzzFTIDAn0Dg4fZiSrloNqgbqV6NYuuh/3HjhQzDQ16Pt8Xg7j2lbLYCHj4WG
	 UrTODAuJiLpMOXkMHg7d+bjbfhtKvvgYz0MJ4c6FRb6LqgPkSN7lgN1UwtYCjbSY64
	 sOSv97a/NY8LnQ2y0fQO5XA4R/mWTgr6ufYEVOlBe3lwO3acyd2fOBFNjjmCYLDLMf
	 QUGeW/qffpOGsVb9x8VkSDai/4dSXPi/SK4/xfHJAQy0FQbLAciL0Fo/zdxCMAWwFC
	 RZCd0uj5oLnVg==
Date: Mon, 13 Oct 2025 19:01:42 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: arnd@arndb.de, bp@alien8.de, bagasdotme@gmail.com, corbet@lwn.net,
	dave.hansen@linux.intel.com, decui@microsoft.com,
	haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com,
	mikelley@microsoft.com, mingo@redhat.com, tglx@linutronix.de,
	Tianyu.Lan@microsoft.com, wei.liu@kernel.org, x86@kernel.org,
	linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	benhill@microsoft.com, bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next v7 00/17] Confidential VMBus
Message-ID: <20251013190142.GB3862989@liuwe-devbox-debian-v2.local>
References: <20251008233419.20372-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008233419.20372-1-romank@linux.microsoft.com>

On Wed, Oct 08, 2025 at 04:34:02PM -0700, Roman Kisel wrote:
[...]
> 
> Roman Kisel (17):
>   Documentation: hyperv: Confidential VMBus
>   Drivers: hv: VMBus protocol version 6.0
>   arch/x86: mshyperv: Discover Confidential VMBus availability
>   arch: hyperv: Get/set SynIC synth.registers via paravisor
>   arch/x86: mshyperv: Trap on access for some synthetic MSRs
>   Drivers: hv: Rename fields for SynIC message and event pages
>   Drivers: hv: Allocate the paravisor SynIC pages when required
>   Drivers: hv: Post messages through the confidential VMBus if available
>   Drivers: hv: remove stale comment
>   Drivers: hv: Check message and event pages for non-NULL before
>     iounmap()
>   Drivers: hv: Rename the SynIC enable and disable routines
>   Drivers: hv: Functions for setting up and tearing down the paravisor
>     SynIC
>   Drivers: hv: Allocate encrypted buffers when requested
>   Drivers: hv: Free msginfo when the buffer fails to decrypt
>   Drivers: hv: Support confidential VMBus channels
>   Drivers: hv: Set the default VMBus version to 6.0
>   Drivers: hv: Support establishing the confidential VMBus connection

Applied to hyperv-next. Thanks.

I needed to fix up a few minor things due to changes made by Tianyu's
patches. Dexuan, please verify that everything is still OK.

Wei

