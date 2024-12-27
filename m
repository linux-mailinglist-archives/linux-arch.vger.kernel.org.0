Return-Path: <linux-arch+bounces-9522-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199479FD6FC
	for <lists+linux-arch@lfdr.de>; Fri, 27 Dec 2024 19:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1ED161F3E
	for <lists+linux-arch@lfdr.de>; Fri, 27 Dec 2024 18:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1D31F8662;
	Fri, 27 Dec 2024 18:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R7Vq1aTy"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB1F1F8AD8;
	Fri, 27 Dec 2024 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735324378; cv=none; b=pLjrfecbkF3TjkP42LfSk5nkd0o86mrxt1vmkaytrhpUh71BFfUxqo19UWde2JXBb4OrvEmadmd5xku1cTUTJZY8aITlbNa7aJsZPnafC6vpY2BXIo9mplgGrw9ORxBE9rTmPzjwBLMWfGmN89K2DMjd1f7SUkEZPwKa04LOv5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735324378; c=relaxed/simple;
	bh=NSZIUSiglpCKRqhfQhFi3iBEqtu2z94/4sZiolz/UXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ow0IgibJEC6U+Ctk+D4enQjklCIf6KxMSsCGgB41kfn7gCjJfm3EuH356fKu27SS0ufIk+uANu2B7yE4dS9eTUWG7eIitRDCbwSddEt9p//bBa+NFtPeM/HI9KVrciZBzwkPOmC6rg9C/QSoncby2hUrDy86rTxYfNuIOC1eSag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R7Vq1aTy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=6LR+awtt9zeZB6QJo8zcf5x6gxrGRTrnc0cmu8uZ0+U=; b=R7Vq1aTy+ewUoHvs2KEL4J36J1
	7bL/3PUwe6hE11McHHiU2sj3TE8HgVW7DJS5mWCFGEw4wPLLxYse1QL0FHNCpUgEfii96ESEv6mZz
	zHuQELy4qLO5U8BklqEc7YXVCyELujpLfCG4nGcc3oYpy8zFV0J/7dlqV/iYQJHU6Pj2W76a9X2pZ
	SHYHFKh0jYRS6VW72kHy3fRMAnim81c2PA2RogJpbPgxvJlSF/ODsQuAGD2sf2X/3NXMPv52OrHFa
	rq+dZsMHoxKkdPW4wtIsx9myoVmCkLibGyKJMhtSxEF+zWoS4VNa90IUkvmfQQ/vMGx1a5tU6oYc0
	clwReaPA==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tRF7z-00000002Pfu-0PsW;
	Fri, 27 Dec 2024 18:32:20 +0000
Message-ID: <478f669f-5441-4bc5-93ad-ef6e5a4b1b9a@infradead.org>
Date: Fri, 27 Dec 2024 10:31:57 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sh: exports for delay.h
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 linux-arch@vger.kernel.org
References: <20241222222259.GF1977892@ZenIV>
 <CAMuHMdVpTtcT9LVGNvFLm4cvrNF=fe1dVsi2zo73Yee3oYrJYQ@mail.gmail.com>
 <20241227162222.GX1977892@ZenIV>
 <CAMuHMdULCsM_ab-Wx8emtiW9_9zFmQ4KtGeNf0-QVWjjxX8SRA@mail.gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAMuHMdULCsM_ab-Wx8emtiW9_9zFmQ4KtGeNf0-QVWjjxX8SRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/27/24 10:20 AM, Geert Uytterhoeven wrote:
> Hi Al,
> 
> On Fri, Dec 27, 2024 at 5:22 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>> On Fri, Dec 27, 2024 at 04:58:58PM +0100, Geert Uytterhoeven wrote:
>>> Please do not export __delay, as it is an internal implementation detail.
>>> Drivers should not call __delay() directly, as it has non-standardized
>>> semantics, or may not even exist.
>>
>> As the matter of fact, it *does* exist and is either exported or a static
>> inline with everything used by it exported - on every architecture except sh.
> 
> OK, it does exist, because init/calibrate.c needs it. But that should
> be the sole user outside architecture-specific code.
> 
> Unlike some other architectures, SH does not emit calls to __delay()
> from various (static inline) *delay() functions.  Hence there is no
> need to export it to modules. Heck, the only reason it cannot be made
> static is because init/calibrate.c needs it.
> 
> Unfortunately there are still a few drivers that call __delay()
> directly (usually with hardcoded constants, how portable, and
> cpufreq-unfriendly), which causes people to try once in a while to
> "fix the build" by re-adding the export on SH :-(

Yeah, I did that in 2021 because of:

ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko] undefined!

mdio-cavium still uses __delay() so I guess it still breaks an SH build.

-- 
~Randy


