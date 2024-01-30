Return-Path: <linux-arch+bounces-1853-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2179B8427F0
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 16:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C731C255DC
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 15:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6E3823C8;
	Tue, 30 Jan 2024 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="hp+idUU/"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035C612BEB4;
	Tue, 30 Jan 2024 15:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706628069; cv=none; b=FLmW6sTB1/LwQ5XQYrpVM/H7b0x2jGQj3PfVO0IH3Ovu889lNzLTGHTtwVqgwOYdNM33a6jilbzbRi2w9vzoEz36m0Z/w0hZLc7YmOOk0fXAjJ2IPYj75pIqgIPnBAr/DrMbf8UpfW8IVnnGSC6OzlQacW/zeDKn/KU4mOWq+wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706628069; c=relaxed/simple;
	bh=jPyAa9WfdA8ROQgMJjeMeeC8xbDVD5scgsQuDyPrR/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Svt9Z2mks3ung3WjVB6f/6U7FxZ7H/Je/CP3uyZ7ZofjHUOO3Y7wK5Wk+7pzP/c+sJK3lsArCsT10jqYi5bOMbp8+UNLkvIXT/gWulJf8lgnfK5Biwd9+cUa36FfqxVzhcyoF6nCplnF4pX9NEQRzPMRxiPjOa89gJPT/lWuOvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=hp+idUU/; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706628067;
	bh=jPyAa9WfdA8ROQgMJjeMeeC8xbDVD5scgsQuDyPrR/E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hp+idUU/OYb8BUfLwfi8e2vK6zsG2zyiPmbiWXGtiQ6yT7Xli/fB5x+A4aoacjxBX
	 AmOncQTD2Y1gQ4BUbfoikaPeKi1giCFmK9ayt/RSiDEfMcs2V5R9HFTcJ7EsqhrbD5
	 V4YXlfUxRNxqJRnmW3dcclwuwvmnlYYBpXrpVqfyJGKcN+LlAQdYmXgRXfC6g3kldo
	 yIJvyVfJ7XukuyD8Yf90+0fA9xWOjcRN2T3S8xZJsBgiAdL2ByWohNXlPa0baN1qlT
	 KA4N4kTrimhzvyJZd4HLzpTFFvQyLGnAPKcuGg9rmdsL62J0gCVlLNn+E6+1REUU+m
	 f1xyZbTxlMbfQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TPTQV5ylyzVj2;
	Tue, 30 Jan 2024 10:21:06 -0500 (EST)
Message-ID: <ec53d5ed-ac0f-4043-9df6-c37a03d1a73b@efficios.com>
Date: Tue, 30 Jan 2024 10:21:04 -0500
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/7] ext2: Use dax_is_supported()
Content-Language: en-US
To: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>,
 linux-ext4@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
References: <20240129210631.193493-1-mathieu.desnoyers@efficios.com>
 <20240129210631.193493-5-mathieu.desnoyers@efficios.com>
 <20240130113337.frem6a3y5n2iibnh@quack3>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240130113337.frem6a3y5n2iibnh@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-30 06:33, Jan Kara wrote:
> On Mon 29-01-24 16:06:28, Mathieu Desnoyers wrote:
>> Use dax_is_supported() to validate whether the architecture has
>> virtually aliased caches at mount time.
>>
>> This is relevant for architectures which require a dynamic check
>> to validate whether they have virtually aliased data caches
>> (ARCH_HAS_CACHE_ALIASING_DYNAMIC=y).
>>
>> Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Jan Kara <jack@suse.com>
>> Cc: linux-ext4@vger.kernel.org
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Cc: linux-mm@kvack.org
>> Cc: linux-arch@vger.kernel.org
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Vishal Verma <vishal.l.verma@intel.com>
>> Cc: Dave Jiang <dave.jiang@intel.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: nvdimm@lists.linux.dev
>> Cc: linux-cxl@vger.kernel.org
> 
> Looks good to me (although I share Dave's opinion it would be nice to CC
> the whole series to fsdevel - luckily we have lore these days so it is not
> that tedious to find the whole series :)). Feel free to add:
> 
> Acked-by: Jan Kara <jack@suse.cz>

Hi Jan,

Thanks for looking at it! I will do significant changes for v2, so
I will hold on before integrating your acked-by if it's OK with you.

Thanks!

Mathieu

> 
> 								Honza
> 
>> ---
>>   fs/ext2/super.c | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
>> index 01f9addc8b1f..0398e7a90eb6 100644
>> --- a/fs/ext2/super.c
>> +++ b/fs/ext2/super.c
>> @@ -585,13 +585,13 @@ static int parse_options(char *options, struct super_block *sb,
>>   			set_opt(opts->s_mount_opt, XIP);
>>   			fallthrough;
>>   		case Opt_dax:
>> -#ifdef CONFIG_FS_DAX
>> -			ext2_msg(sb, KERN_WARNING,
>> -		"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
>> -			set_opt(opts->s_mount_opt, DAX);
>> -#else
>> -			ext2_msg(sb, KERN_INFO, "dax option not supported");
>> -#endif
>> +			if (dax_is_supported()) {
>> +				ext2_msg(sb, KERN_WARNING,
>> +					 "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
>> +				set_opt(opts->s_mount_opt, DAX);
>> +			} else {
>> +				ext2_msg(sb, KERN_INFO, "dax option not supported");
>> +			}
>>   			break;
>>   
>>   #if defined(CONFIG_QUOTA)
>> -- 
>> 2.39.2
>>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


