Return-Path: <linux-arch+bounces-13196-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C776FB2C951
	for <lists+linux-arch@lfdr.de>; Tue, 19 Aug 2025 18:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B625F5C105D
	for <lists+linux-arch@lfdr.de>; Tue, 19 Aug 2025 16:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395F1211A11;
	Tue, 19 Aug 2025 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="N1L+7JjX"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88101448E0;
	Tue, 19 Aug 2025 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755620252; cv=none; b=qLWYSi8rtA5Dj4yF5r1mp18bqx06xW7yL+Rn6VECHRVXWokIvuOfuh7m8xqfKtcMv4jY7pJ5zIWDU09puIQge+eMtvjoYHzHleGhemoMQZonK+AMFRzBilrmgM1Fcyn8kkE0lSGvaDbJ/ijM9ZxLdWQ+mOPfcwTl9c0BOEwfWx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755620252; c=relaxed/simple;
	bh=cBAf66/ecC3KCAWVPNJ0mEfLod6jzDCzAlx19ze5M0E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rTsNNgDd8d2wWWkZvFY+S1HZKPY8EtsD4IDdTQlW09WGRDuMTWL++DlOzroE6hDpOk/wBDaXVkrbu/BL43F6Ahi98lnTxZuiMIXRsgdSorsUqp/loZ3E6mvfGCjXt1lFpPaiduIG0NAVMhBG/ro6lsCAsSOAqifgQ3dD6/Ox108=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=N1L+7JjX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.160.36] (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id BDEC22015BAB;
	Tue, 19 Aug 2025 09:17:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BDEC22015BAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755620250;
	bh=UK2us52F74pzoMRfapfu4Rp2ypnjpe2h7wtZmQTFVCg=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=N1L+7JjX6y8w/ZP7VUshCcip8y+O09W05cXUKI09ngHqlwUZXPAmrbNAJx3tQnrzq
	 +a0Hb5cGkkQwMy3figAfhIb01yZEYgYFujwovjw2PJXcHUCQ/ScKgDjaFBWEooQVIE
	 yJ+TGHkr1Lxe1oI+CNvCGdg57x+0EP1uikxYxeVo=
Message-ID: <0a0c8921-9236-45fb-b047-742a34379e63@linux.microsoft.com>
Date: Tue, 19 Aug 2025 09:17:27 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Subject: Re: [PATCH] mshv: Add support for a new parent partition
 configuration
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: easwar.hariharan@linux.microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, mhklinux@outlook.com,
 decui@microsoft.com, arnd@arndb.de
References: <1755588559-29629-1-git-send-email-nunodasneves@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <1755588559-29629-1-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/2025 12:29 AM, Nuno Das Neves wrote:
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

Seems the plurality of subject prefixes for drivers/hv files has been "Drivers: hv"
so far, including the 2 commits for drivers/hv/mshv*. Are you planning to change
the standard for mshv driver going forward?

It'd be good to have a small blurb about what an L1VH partition is in the commit
message, as well as what guides which hv_root_partition() call gets replaced with
hv_parent_partition().

<snip>

Thanks,
Easwar (he/him)

