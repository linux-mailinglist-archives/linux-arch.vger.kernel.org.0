Return-Path: <linux-arch+bounces-2556-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2543E85D603
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 11:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C4F283532
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 10:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADF73A1CB;
	Wed, 21 Feb 2024 10:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen0n.name header.i=@xen0n.name header.b="jxfwViVl"
X-Original-To: linux-arch@vger.kernel.org
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D3D3E49E;
	Wed, 21 Feb 2024 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.28.160.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708512563; cv=none; b=qSOMC1l21bM0IiGify+BnqfftokMYI9jtIOEUOQMIQh9omIEBQNlD97rR+RBjYUHmgp9K9nUX7j7f8odWVGMPuW334tgiaqSXeCcWDbMRgVfn9RUhwdBktNJStPoF9Xr4/xHAjG6jfW/Q74tzmmqZsweSbc5Tacrxbm+XdJKPO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708512563; c=relaxed/simple;
	bh=mxb+gMGUDBPnZJub2OxpXr5cGn1a7UGyvzYeTJOlnQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ufl9zoH84K+9BmDf9a0XnDA1H/oJFbvC3+Mh6mR1ZeznNP8aYGbWyw61LrjE0kJ5Xcbkd2NDLFLj7NIp045Kc6Qgpv8/CPEQ5h9bwJV/F6UCLfcguOHL7ePvM4CxjuPJRtE9bH7iOmKFbO9RDccBJz0JVFetVjc9M7QrPxe3iTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen0n.name; spf=pass smtp.mailfrom=xen0n.name; dkim=pass (1024-bit key) header.d=xen0n.name header.i=@xen0n.name header.b=jxfwViVl; arc=none smtp.client-ip=115.28.160.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen0n.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen0n.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
	t=1708512558; bh=mxb+gMGUDBPnZJub2OxpXr5cGn1a7UGyvzYeTJOlnQQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jxfwViVltVdU1XrVjxL2is6j6mZSDlh7cWd6cir0CWPkHl7p2jymVy/+9oUxCXArS
	 GnEw1NKQGBRsTgbJzfEnBwqTW7QPrzQbHgJ1mH5oCtPCuo94UU/Qfhe5VzlXxDltY8
	 qEjJkNmXM4BDIbSTQWnQZq3QTl/Zo2ZAOUpVUGcI=
Received: from [IPV6:240e:388:8d00:6500:8954:615d:4577:1f21] (unknown [IPv6:240e:388:8d00:6500:8954:615d:4577:1f21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 385B360094;
	Wed, 21 Feb 2024 18:49:18 +0800 (CST)
Message-ID: <f59d73fb-7d3e-4c55-821a-082032267978@xen0n.name>
Date: Wed, 21 Feb 2024 18:49:17 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Chromium sandbox on LoongArch and statx -- seccomp deep argument
 inspection again?
Content-Language: en-US
To: Xi Ruoyao <xry111@xry111.site>, linux-api@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
 Kees Cook <keescook@chromium.org>, Huacai Chen <chenhuacai@kernel.org>,
 Xuefeng Li <lixuefeng@loongson.cn>, Jianmin Lv <lvjianmin@loongson.cn>,
 Xiaotian Wu <wuxiaotian@loongson.cn>, WANG Rui <wangrui@loongson.cn>,
 Miao Wang <shankerwangmiao@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
 linux-arch <linux-arch@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <599df4a3-47a4-49be-9c81-8e21ea1f988a@xen0n.name>
 <f1a1bc708be543eb647df57b5eb0c0ef035baf8b.camel@xry111.site>
 <2d25e3bb829cbca51387eb84985db919f50ccd37.camel@xry111.site>
From: WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <2d25e3bb829cbca51387eb84985db919f50ccd37.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/21/24 18:31, Xi Ruoyao wrote:
> On Wed, 2024-02-21 at 14:31 +0800, Xi Ruoyao wrote:
>> On Wed, 2024-02-21 at 14:09 +0800, WANG Xuerui wrote:
>>
>>> - just restore fstat and be done with it;
>>> - add a flag to statx so we can do the equivalent of just fstat(fd,
>>> &out) with statx, and ensuring an error happens if path is not empty in
>>> that case;
>> It's worse than "just restore fstat" considering the performance.  Read
>> this thread:
>> https://sourceware.org/pipermail/libc-alpha/2023-September/151320.html
> Hmm, but it looks like statx already suffers the same performance issue.
> And in this libc-alpha discussion Linus said:
>
>     If the user asked for 'fstat()', just give the user 'fstat()'.
>     
> So to me we should just add fstat (and use it in Glibc for LoongArch, only
> falling back to statx if fstat returns -ENOSYS), or am I missing something?

Or we could add a AT_STATX_NULL_PATH flag and mandate that `path` must 
be NULL if this flag is present -- then with simple checks we could have 
statx(fd, NULL, AT_STATX_NULL_PATH, STATX_BASIC_STATS, &out) that's both 
fstat-like and fast.

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/


