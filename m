Return-Path: <linux-arch+bounces-5668-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FAC93EBBC
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2024 05:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34C961C2152E
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2024 03:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D99B80617;
	Mon, 29 Jul 2024 03:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xJ/0a1P0"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5508342AAF
	for <linux-arch@vger.kernel.org>; Mon, 29 Jul 2024 03:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722222124; cv=none; b=YbKYzCbczWpk9oT5jDtu2K7A7Q0Txo60hvaeDbwFw5wq31rc89M91/jebeNx35ttMr14GLT7sacGgR5TklgUG7kweoaBTKkz4LFaxQ0JHUuukYrpRuEEzhzLDDIz7NJF/wQYtgoItPGO3VxO2iIiaIAMeVlBhlMrshGTOPEtpIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722222124; c=relaxed/simple;
	bh=ejK+JLHw98fyL4yw9lBzd9vdjVs1PyEJPzes0fN3DzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYSJG6nOCktWBvNmQzkr1S0d622Pw8PYjYzZ3Lkq0dwivcP6wSKDRB+Eve/yXEdSvuPwDHXCj9jW2RfWMV3OR3FhvQVUTiPJ44KHPyvkuTiXI8Ivv9wa2VVvrJiXElH8IQzoZoWuh3tYIdCuMp1abp4Odd2PWft02/BVJy85DvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xJ/0a1P0; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ca823522-fe78-4eb7-ae1d-b017d16e39fe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722222119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z9wqau/zSknzCnsohqqshMiTMDATCIJu7G0AysZkCDg=;
	b=xJ/0a1P0NwUNNMLY6DohbukOFlCjl5lRE89SJL1joXlE8aGAxS5D9t45QWPahYN2fzjZfv
	p8Q5R/c1tXLpuC7784AJnVdCdqfTi74D920vJy8uLEGQYmqMsB+FwSqUaG9paPfQKJO6Pl
	aJbeS7+79P91ANxNHHLtZgO+JAF2WtE=
Date: Mon, 29 Jul 2024 11:01:29 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] module: Add module_subinit{_noexit} and
 module_subeixt helper macros
To: Theodore Ts'o <tytso@mit.edu>
Cc: Christoph Hellwig <hch@infradead.org>, David Sterba <dsterba@suse.cz>,
 Arnd Bergmann <arnd@arndb.de>, kreijack@inwind.it,
 Luis Chamberlain <mcgrof@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Youling Tang <tangyouling@kylinos.cn>
References: <ZqJwa2-SsIf0aA_l@infradead.org>
 <68584887-3dec-4ce5-8892-86af50651c41@libero.it>
 <ZqKreStOD-eRkKZU@infradead.org>
 <91bfea9b-ad7e-4f35-a2c1-8cd41499b0c0@linux.dev>
 <ZqOs84hdYkSV_YWd@infradead.org> <20240726152237.GH17473@twin.jikos.cz>
 <20240726175800.GC131596@mit.edu> <ZqPmPufwqbGOTyGI@infradead.org>
 <20240727145232.GA377174@mit.edu>
 <23862652-a702-4a5d-b804-db9ee9f6f539@linux.dev>
 <20240729024412.GD377174@mit.edu>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <20240729024412.GD377174@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 29/07/2024 10:44, Theodore Ts'o wrote:
> On Mon, Jul 29, 2024 at 09:46:17AM +0800, Youling Tang wrote:
>> 1. Previous version implementation: array mode (see link 1) :
>>     Advantages:
>>     - Few changes, simple principle, easy to understand code.
>>     Disadvantages:
>>     - Each modified module needs to maintain an array, more code.
>>
>> 2. Current implementation: explicit call subinit in initcall (see link 2) :
>>     Advantages:
>>     - Direct use of helpes macros, the subinit call sequence is
>>       intuitive, and the implementation is relatively simple.
>>     Disadvantages:
>>     - helper macros need to be implemented compared to array mode.
>>
>> 3. Only one module_subinit per file (not implemented, see link 3) :
>>     Advantage:
>>     - No need to display to call subinit.
>>     Disadvantages:
>>     - Magic order based on Makefile makes code more fragile,
>>     - Make sure that each file has only one module_subinit,
>>     - It is not intuitive to know which subinits the module needs
>>       and in what order (grep and Makefile are required),
>>     - With multiple subinits per module, it would be difficult to
>>       define module_{subinit, subexit} by MODULE, and difficult to
>>       rollback when initialization fails (I haven't found a good way
>>       to do this yet).
>>
>>
>> Personally, I prefer the implementation of method two.
> But there's also method zero --- keep things the way they are, and
> don't try to add a new astraction.
>
> Advantage:
>
>   -- Code has worked for decades, so it is very well tested
>   -- Very easy to understand and maintain
>
> Disadvantage
>
>   --- A few extra lines of C code.
The number of lines of code is not important, the main point is to
better ensure that subexit runs in the reverse order of subinit when
init fails.

Thanks,
Youling.

>
> which we need to weigh against the other choices.
>
>        	      	       	       	   - Ted


