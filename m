Return-Path: <linux-arch+bounces-3849-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABC08AC5DB
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 09:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA6C92831B8
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 07:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537DB4F890;
	Mon, 22 Apr 2024 07:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hat8fmfN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD76B4AEDA;
	Mon, 22 Apr 2024 07:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713771888; cv=none; b=eSOYpXHX/l12zLuSrxqgOwt5INzTtFnN67BPm1gyTgx+bCctPbmcVPms8C+FLQEDPEhHGJVODKY3oKX/NiUZeba/EWMNQQyoViyg2l1vf5kBVD0enZ70VQ2aRAQ1Uw7CVZ8OA2pKiwmPCKDczFUpJXVnr6OI5Ah8q/kuRr1SpW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713771888; c=relaxed/simple;
	bh=DJBrn7TxHiTduPF1HXr+JJpm5dsFnOdnOeFDvVQw2tE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9hiyXZwc7r/JLHjXZpDst0GOFB018Zr2jDtABaqS9eSY2hFpVxdizGEls4nSwtLplgGod8m+WGG1DHoYhl7vfNpcXdUzhO5Y7WjuBYXze48/LjDdAwIrlh5gt1GPrDrRrEBkZFdFUQ0dMberntfMSNoND+oAipTGKF6+Wl6jFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hat8fmfN; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713771887; x=1745307887;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DJBrn7TxHiTduPF1HXr+JJpm5dsFnOdnOeFDvVQw2tE=;
  b=hat8fmfNh0y92N/22PVTSy+xVtkrlDfjw+wvzlaso8sp1KaMoxWTQKvC
   72jywUSoBX8kvcr4xIB+RFFUlwOt9z3IyNJt0Z6D94PQyl0ialdhKiiJF
   j26XtkVwDHhTn5aIBwd4P6r2KM1kFTa+zvkk2IEfh2gZbU8CEcvAfDJgR
   GtqOABXJGM+5VNYe6zfSn+2c7yADpO64t05PHO9jab7rHtHI/r7OWEf5n
   Cwn5I3tOhFgIuka3hMqzrbdFjeLUDm4CA1RchxsbqakoRL36KUbkgIWi3
   8jcYbh1r2Ztxqw+VpChL9EpdjnlTdWwQS2VFYferh22NDcqZlJHv2bIhK
   A==;
X-CSE-ConnectionGUID: ARl9/nURSQi2QzLBZA00EA==
X-CSE-MsgGUID: E4iARbZZRwKVGWRKWDjUug==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="13132548"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="13132548"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 00:44:46 -0700
X-CSE-ConnectionGUID: vCbpEgAXTp6FHliHTka3Sw==
X-CSE-MsgGUID: DgEm0hL5THmtu2dfTPXBGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="23959026"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.8.107]) ([10.94.8.107])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 00:44:43 -0700
Message-ID: <42e6a510-9000-44a4-b6bf-2bca9cf74d5e@linux.intel.com>
Date: Mon, 22 Apr 2024 09:44:40 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bitops: Change function return types from long to int
Content-Language: en-US
To: Thorsten Blum <thorsten.blum@toblux.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Xiao Wang <xiao.w.wang@intel.com>, Palmer Dabbelt <palmer@rivosinc.com>,
 Charlie Jenkins <charlie@rivosinc.com>, Namhyung Kim <namhyung@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, Youling Tang <tangyouling@loongson.cn>,
 Tiezhu Yang <yangtiezhu@loongson.cn>, Jinyang He <hejinyang@loongson.cn>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240420223836.241472-1-thorsten.blum@toblux.com>
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20240420223836.241472-1-thorsten.blum@toblux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/21/2024 12:38 AM, Thorsten Blum wrote:
> Change the return types of bitops functions (ffs, fls, and fns) from
> long to int. The expected return values are in the range [0, 64], for
> which int is sufficient.
> 
> Additionally, int aligns well with the return types of the corresponding
> __builtin_* functions, potentially reducing overall type conversions.
> 
> Many of the existing bitops functions already return an int and don't
> need to be changed. The bitops functions in arch/ should be considered
> separately.
> 
> Adjust some return variables to match the function return types.
> 
> With GCC 13 and defconfig, these changes reduced the size of a test
> kernel image by 5,432 bytes on arm64 and by 248 bytes on riscv; there
> were no changes in size on x86_64, powerpc, or m68k.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>   include/asm-generic/bitops/__ffs.h         | 4 ++--
>   include/asm-generic/bitops/__fls.h         | 4 ++--
>   include/asm-generic/bitops/builtin-__ffs.h | 2 +-
>   include/asm-generic/bitops/builtin-__fls.h | 2 +-
>   include/linux/bitops.h                     | 6 +++---
>   tools/include/asm-generic/bitops/__ffs.h   | 4 ++--
>   tools/include/asm-generic/bitops/__fls.h   | 4 ++--
>   tools/include/linux/bitops.h               | 2 +-
>   8 files changed, 14 insertions(+), 14 deletions(-)

I don't mind the idea, but in the past I've send some patches trying to 
align some arch specific implementations with asm-generic ones. Now you 
are changing only asm-generic implementation and leaving arch specific 
ones untouched (that's probably why you see no size change on some of them).

For example on x86, there is:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/include/asm/bitops.h?id=ed30a4a51bb196781c8058073ea720133a65596f#n293
and you probably need to check all architectures for those implementations.

Thanks,
Amadeusz

