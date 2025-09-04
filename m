Return-Path: <linux-arch+bounces-13388-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0629BB44A37
	for <lists+linux-arch@lfdr.de>; Fri,  5 Sep 2025 01:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8481CC0758
	for <lists+linux-arch@lfdr.de>; Thu,  4 Sep 2025 23:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E052F6194;
	Thu,  4 Sep 2025 23:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbbyixI+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854DA2F618B;
	Thu,  4 Sep 2025 23:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757027261; cv=none; b=prEyOjVU9PEqmDzQAY2XyOxcFncYCopvcNueYr0OrSrjAPijk7xbFm18jUsauBOGYNWOO1D7lPMs2J3V0tR78V9zq4EEd2jZuH+QdzguU52YrmHtcDf/nxSx9cfLe+CfWxhBSgJGKPZSstRQl12GpC6pShr0C6BQKb+/rD6AkfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757027261; c=relaxed/simple;
	bh=LR6zSRKwmOi0Hv5iWv4nArSStWbqTqWY9wN/FULwM6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kf76rKCAlIJGswlq3ozkHS+HhgBAvHxhO64k5kGpj2uDH47GUJ8SWcSOJqF/orm3CvHYkHr7b25jJNJX+oVnZOz4C2PPrmh4kywkO2k92Kbw4SnWpmXpXDhrZp3SmxLWQXjIza5Hs6NnyhYZUNzFVOABPZfD4x33M+YxMMynHjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbbyixI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF957C4CEF4;
	Thu,  4 Sep 2025 23:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757027261;
	bh=LR6zSRKwmOi0Hv5iWv4nArSStWbqTqWY9wN/FULwM6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UbbyixI+05dv42fhI5/fTyZxnqhC+PhzDHUR+MqJDn/6lnTC242nMlCKdtgJoKh81
	 MUxwilCLQsSH35aCggscwkR3q3oV6wvk2xd1hvaw2W1XNAy/UzU7m01gGbkWYG+DSo
	 XdzBN4wuOZsMjKg0/Vp6jtURRwUGSBJOfR2Ec/YiHG+LQ86OSbvI2CMvv6LzlA0cdx
	 cmeU9PvRP8JACF6Mv2c0NKKIkB13X/hmIG034CyXvLC/UwoRYc//CJmXpM/pZORVpn
	 9xMHOKYrLIsyAPUXGyfsOO77Q7iz1OyCpjXLWiNABSQ7dffVW+izctZKsZXm1W1Pyj
	 c6+4ZcddSqrlg==
Date: Thu, 4 Sep 2025 23:07:39 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, wei.liu@kernel.org,
	mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
	decui@microsoft.com, arnd@arndb.de
Subject: Re: [PATCH v2] mshv: Add support for a new parent partition
 configuration
Message-ID: <aLobu5hRjN-FxVCe@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <1756856913-27197-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1756856913-27197-1-git-send-email-nunodasneves@linux.microsoft.com>

On Tue, Sep 02, 2025 at 04:48:33PM -0700, Nuno Das Neves wrote:
> Detect booting as an "L1VH" partition. This is a new scenario very
> similar to root partition where the mshv_root driver can be used to
> create and manage guest partitions.
> 
> It mostly works the same as root partition, but there are some
> differences in how various features are handled. hv_l1vh_partition()
> is introduced to handle these cases. Add hv_parent_partition()
> which returns true for either case, replacing some hv_root_partition()
> checks.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Acked-by: Wei Liu <wei.liu@kernel.org>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

Applied. Thanks.

