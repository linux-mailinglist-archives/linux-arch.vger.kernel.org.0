Return-Path: <linux-arch+bounces-13199-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA5CB2CA92
	for <lists+linux-arch@lfdr.de>; Tue, 19 Aug 2025 19:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A0791C25F4C
	for <lists+linux-arch@lfdr.de>; Tue, 19 Aug 2025 17:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2EA307487;
	Tue, 19 Aug 2025 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="N1QWxTlQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534803043CD;
	Tue, 19 Aug 2025 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755624570; cv=none; b=m2HcxOwAcFBx7uL5leZ9b2Q57uiF/U/WOhxwHa12YYPqAIDyBoKJi4VGD8gfQSQQzpKEsHeDNvKjetaC8Bf0WXrANcAfTwDyGJvY8Mn1LsevLGPXahaCNiPymSyiXhL4Xw3yliWr+W6UuinUv15LbrOypmIi/BDZl9/PuOEV/+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755624570; c=relaxed/simple;
	bh=qziGA+ugfGc+7LXbQ4tcMlip/O07GrI96PTRCxZE08I=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KooFPrwJoJ6RG0KsFb9qwk6GN7mkN0Kk8XjfGL/yzp56e/WQj/PrQ6YaLSAw6zRqNrvja7FgNX0DEkrr6EOQV+4Wo5Y4wMawdhKUe1yJAyhThkYfDZWhkSTI20K4RpFZxYKQgOxteoM5woV5KRU0PxNxfSzB66uuNJ4pTxpgnBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=N1QWxTlQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.160.36] (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0CE852113360;
	Tue, 19 Aug 2025 10:29:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0CE852113360
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755624568;
	bh=3R5kfK8zeGmj5Y5IsXbMy2XEiqggVqW9GNG514PyNPY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=N1QWxTlQsaLrW2k6gnm06/cAkOfXJAfZD9TiSPbLBdBJz63pC1RGqa6wCqPQfGfNF
	 1DIXcH21eJ76555TC0UASfLWv5/CnkhPDdYPsorrq0kP6WDptXRVZlOL+DDhrpJPG7
	 /vuFFZw0y7nf9fO1DGaqKH+OJdAeY+r1EHL8EuaA=
Message-ID: <2393d3f9-3d13-4e62-ad3d-b9158665af12@linux.microsoft.com>
Date: Tue, 19 Aug 2025 10:29:33 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: easwar.hariharan@linux.microsoft.com,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 mhklinux@outlook.com, decui@microsoft.com, arnd@arndb.de
Subject: Re: [PATCH] mshv: Add support for a new parent partition
 configuration
To: Wei Liu <wei.liu@kernel.org>
References: <1755588559-29629-1-git-send-email-nunodasneves@linux.microsoft.com>
 <0a0c8921-9236-45fb-b047-742a34379e63@linux.microsoft.com>
 <aKSyzopAGQhM61B0@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <aKSyzopAGQhM61B0@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/2025 10:22 AM, Wei Liu wrote:
> On Tue, Aug 19, 2025 at 09:17:27AM -0700, Easwar Hariharan wrote:
>> On 8/19/2025 12:29 AM, Nuno Das Neves wrote:
>>> Detect booting as an "L1VH" partition. This is a new scenario very
>>> similar to root partition where the mshv_root driver can be used to
>>> create and manage guest partitions.
>>>
>>> It mostly works the same as root partition, but there are some
>>> differences in how various features are handled. hv_l1vh_partition()
>>> is introduced to handle these cases. Add hv_parent_partition()
>>> which returns true for either case, replacing some hv_root_partition()
>>> checks.
>>>
>>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>>
>> Seems the plurality of subject prefixes for drivers/hv files has been "Drivers: hv"
>> so far, including the 2 commits for drivers/hv/mshv*. Are you planning to change
>> the standard for mshv driver going forward?
> 
> IMO it is okay to have a different prefix to call out the commits that
> are relevant to the mshv driver. This eases the burden for anyone
> porting the changes to a different kernel tree. We may also touch many
> different parts of the codebase (though not in this particular patch).
> 
> Wei

It's fine either way for me, I was trying to understand if it was an oversight or
intentional.

- Easwar (he/him)

