Return-Path: <linux-arch+bounces-5598-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F3E93AAD1
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 03:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60DC01F2346F
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 01:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB2DC156;
	Wed, 24 Jul 2024 01:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lUesQsIH"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1B211CAB
	for <linux-arch@vger.kernel.org>; Wed, 24 Jul 2024 01:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721786244; cv=none; b=U8xMdC1biHyLp7PhNolc9oR2enQ95OD/4ITDyGm9yrKim/D+CJsbErLscAVwEE8u+Z4hnyS+5e4lNwYUcUOSze5scYdcY8e/sx4vAmuHD8fOQbjS3LeNBr+13du222OY00uo2wuvUuKaZO2Genkaj772i7EUxznueA+MbXKhWFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721786244; c=relaxed/simple;
	bh=7C93h2zHCsF3+6kcIKN1lwhv8qIcWHU+c3YseH4YRN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMBQAOy9I4aVdzIrPuMpjOwrpAs1slgxRInBicyQtiIDeaK0uijHFv1e4GqTerU3GvL4nArc3RAIYDk8asevRYxFUHBeq+7MF94uvbU5p8iusd+j4sYNDQf6o6xjJB7O0zF889iYA+fylqIC65Yp6KjxTmpsJPqlGlIoLpK1rNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lUesQsIH; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0a63dfd1-ead3-4db3-a38c-2bc1db65f354@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721786241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VT5Ew9eZUkwsQ1KVPNkgUu/jPA+/4qD7R3UMmIpNcFg=;
	b=lUesQsIHexBh+jWlqoVfPoQhT8csj+XUHOANqoY2BmuGuj0w3JXl7qjEn8fKlhmWIu4MyB
	m6+1FVE7jgrSZPIA/6Vt66AejEXBEHYoH28b5QiZDgA0zvxNBykvKWvQ4zuqHjle45conT
	zkXWV1SOK+8igIhqo00D5A9WQNklJm4=
Date: Wed, 24 Jul 2024 09:57:05 +0800
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
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <Zp-_RDk5n5431yyh@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi, Christoph

On 23/07/2024 22:33, Christoph Hellwig wrote:
> On Tue, Jul 23, 2024 at 04:32:36PM +0800, Youling Tang wrote:
>> Providing module_subinit{_noexit} and module_subeixt helps macros ensure
>> that modules init/exit match their order, while also simplifying the code.
>>
>> The three macros are defined as follows:
>> - module_subinit(initfn, exitfn,rollback)
>> - module_subinit_noexit(initfn, rollback)
>> - module_subexit(rollback)
>>
>> `initfn` is the initialization function and `exitfn` is the corresponding
>> exit function.
> I find the interface a little confusing.  What I would have expected
> is to:
>
>   - have the module_subinit call at file scope instead of in the
>     module_init helper, similar to module_init/module_exit
>   - thus keep the rollback state explicitly in the module structure or
>     similar so that the driver itself doesn't need to care about at
>     all, and thus remove the need for the module_subexit call.
module_init(initfn)/module_exit(exitfn) has two definitions (via MODULE):
- buindin: uses do_initcalls() to iterate over the contents of the specified
   section and executes all initfn functions in the section in the order in
   which they are stored (exitfn is not required).

- ko: run do_init_module(mod)->do_one_initcall(mod->init) to execute initfn
   of the specified module.

If we change module_subinit to something like this, not called in
module_init,
```
static int init_a(void)
{
     ...
     return 0;
}
static void exit_a(void)
{
     ...
}
subinitcall(init_a, exit_a);

static int init_b(void)
{
     ...
     return 0;
}
static void exit_b(void)
{
     ...
}
subinitcall(init_b, exit_b);
```

Not only do we want to ensure that exit is executed in reverse order of
init, but we also want to ensure the order of init.

This does not guarantee the order in which init will be executed (although
the init/exit order will remain the same)

Tanks,
Youling.

