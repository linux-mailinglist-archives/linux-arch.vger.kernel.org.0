Return-Path: <linux-arch+bounces-5622-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1517193BB09
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2024 05:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4726A1C21A0F
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2024 03:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E9A63C7;
	Thu, 25 Jul 2024 03:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t0bnRmik"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329B6134DE
	for <linux-arch@vger.kernel.org>; Thu, 25 Jul 2024 03:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721876514; cv=none; b=f9T67ZfL9rjsQ9UCJ15wosQmisVgM3C7Sl58UEb0ygFbvfu5sgU++JjEwkYzrP1kyHvT8b9EjyKLhGrlIHHJjhUedwvT9eTzWk3xrqJ395GSE6bUy0Y+NxynM5ukdYIsJa2Y4tlEdd151AkYUPv4ghNSVS2Jt5J1XI08EfwW5Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721876514; c=relaxed/simple;
	bh=49jcBefj5FcT3M9x20xUQPUdsQZFD9U6hguK29l+JiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lYvtY33wxtv6EVNOvoBGshF8mujfQQyLr1If5mm9Q79qVczpKmNBVyhqXKBouP5k49JTXDQhsUhmNhtr4r7njv2keb036ZUp5f+mRZ9Lu+rslO3Bsyb/zCBVoVfekD4BLDKElG8JUZ+8m7E8NSN91lxbavWYrulxbOhtQcN2F/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t0bnRmik; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <895360e3-97bb-4188-a91d-eaca3302bd43@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721876510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dinahWWNWKVgxUr2QQ8r5vtDMN47K5jpbrU4x04fZmQ=;
	b=t0bnRmiksgMcuV2n4/X74UTpJITvS5MrnJV4M93S6NWIOs2XsMr+6Kz8W7etk9BqNLgiLm
	WyW+SnXPb9G/KKg4743QNI4cw/8+OwX72AkIF3GAqZwoNi6QNrEMZbnhD9k/VEF+m8nY7q
	VR/2e2/7phjKq6pM1GTTV0CvBfSEfNI=
Date: Thu, 25 Jul 2024 11:01:33 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] module: Add module_subinit{_noexit} and
 module_subeixt helper macros
To: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, tytso@mit.edu,
 Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Youling Tang <tangyouling@kylinos.cn>
References: <20240723083239.41533-1-youling.tang@linux.dev>
 <20240723083239.41533-2-youling.tang@linux.dev>
 <Zp-_RDk5n5431yyh@infradead.org>
 <0a63dfd1-ead3-4db3-a38c-2bc1db65f354@linux.dev>
 <ZqEhMCjdFwC3wF4u@infradead.org>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <ZqEhMCjdFwC3wF4u@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 24/07/2024 23:43, Christoph Hellwig wrote:
> On Wed, Jul 24, 2024 at 09:57:05AM +0800, Youling Tang wrote:
>> module_init(initfn)/module_exit(exitfn) has two definitions (via MODULE):
>> - buindin: uses do_initcalls() to iterate over the contents of the specified
>>    section and executes all initfn functions in the section in the order in
>>    which they are stored (exitfn is not required).
>>
>> - ko: run do_init_module(mod)->do_one_initcall(mod->init) to execute initfn
>>    of the specified module.
>>
>> If we change module_subinit to something like this, not called in
>> module_init,
>> Not only do we want to ensure that exit is executed in reverse order of
>> init, but we also want to ensure the order of init.
> Yes.
>
>> This does not guarantee the order in which init will be executed (although
>> the init/exit order will remain the same)
> Hmm, so the normal built-in initcalls depend on the link order, but when
> they are in the same file, the compiler can reorder them before we even
> get to the linker.
>
> I wonder what a good syntax would be to still avoid the boilerplate
> code.  We'd probably need one macro to actually define the init/exit
> table in a single statement so that it can't be reordered, but that
> would lose the ability to actually declare the module subinit/exit
> handlers in multiple files, which really is the biggest win of this
> scheme as it allows to keep the functions static instead of exposing
> them to other compilation units.
>
> And in fact even in your three converted file systems, most
> subinit/exit handler are in separate files, so maybe instead
> enforcing that there is just one per file and slightly refactoring
> the code so that this is the case might be the best option?
- It doesn't feel good to have only one subinit/exit in a file.
   Assuming that there is only one file in each file, how do we
   ensure that the files are linked in order?(Is it sorted by *.o
   in the Makefile?)

- Even if the order of each init is linked correctly, then the
   runtime will be iterated through the .subinitcall.init section,
   which executes each initfn in sequence (similar to do_initcalls),
   which means that no other code can be inserted between each subinit.


If module_subinit is called in module_init, other code can be inserted
between subinit, similar to the following:

```
static int __init init_example(void)
{
     module_subinit(inita, exita);

     otherthing...

     module_subinit(initb, exitb);

     return 0;
}

module_init(init_example);
```

IMHO, module_subinit() might be better called in module_init().

Thanks,
Youling.

