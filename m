Return-Path: <linux-arch+bounces-7772-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCFA993306
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 18:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E4791C22A2A
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 16:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714911DB357;
	Mon,  7 Oct 2024 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bAljJiq/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T/w33dW1"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7EA1DACB8;
	Mon,  7 Oct 2024 16:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318207; cv=none; b=mSTlWq/wpUGJIbgSY2jMF/tv2G8Ya3gTHNS7MlnGYGQTimzZ4X9VqJBKLPlCFeNgQxsD68+1WaVNjcjDcQNzSmOYafxt6rPzgvRmvStHcoksZFlj9M06usXHQDjse3HPMGmLLbN9Gnp2RxhsW8B5g66dX3xwTo87+j39L+AbFOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318207; c=relaxed/simple;
	bh=V/wk71YSCOsTnCtjtFRhlhTXAerN+DojnzFJFUflydQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t5uDLHjUoLJkOx2lN7iMPaBVSXRlIDbKLKDO9u29juWRDouSSIex57gAEVwa44iftyMjiBO8nTyQh1MfaCSDg2VvOk0G1Gl6Z5apIW+YY9imTphFDmgU6ErdfGY0IEViS7zwaf08TT1dFgx3zSNmhvlzLo5R7ULi5FFJY33WP34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bAljJiq/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T/w33dW1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728318203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=08gpLZIQ7p4jdD4DEwn8TcM+sfVMrDVV+V/DOQfsZFo=;
	b=bAljJiq/QQ+6nLdhbbpFyk0eBF5tboP9vCt8om8W898N/K6eh3/ccTrYO9U//SYQIzXWgp
	9uuw8uGkhVpT12jgFWpANbErRAxedxwFkhP/atufIuOptgf240yNziy0p0TOc5regptLqH
	jVUh50SUeMP/gnUAYAWbGf5m+qlN2aeDQua1F/ovxdLhm1psfkqJ6XxrpSX0NEoHJsXmdJ
	kq40/tg45KsjXfXVWQE6OIEvWD5x6F1xXxoS1qK2yS1TegCiYaB5Cco/ktfmX+Uy6HCRMr
	uhsvlbY+PcG7dVfT2gXl1rwTMasvMRmiDYFGwJmQSTYPn73tddt6iz66PxpmRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728318203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=08gpLZIQ7p4jdD4DEwn8TcM+sfVMrDVV+V/DOQfsZFo=;
	b=T/w33dW173mBy1qkC8IOKCxMl3ipPYQnGNAGNZF5cJxJDUh29K++Eya288cyd3xG5KJteU
	Y7ynaEarCP6iR2CA==
To: Arnd Bergmann <arnd@arndb.de>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, linux-kernel@vger.kernel.org, Linux-Arch
 <linux-arch@vger.kernel.org>, linux-mm@kvack.org
Cc: Andy Lutomirski <luto@kernel.org>, "Jason A . Donenfeld"
 <Jason@zx2c4.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Naveen
 N Rao <naveen@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>, Andrew Morton
 <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v3 2/2] vdso: Introduce vdso/page.h
In-Reply-To: <423e571b-3ef6-4e80-ba81-bf42589a4ba8@app.fastmail.com>
References: <20241003152910.3287259-1-vincenzo.frascino@arm.com>
 <20241003152910.3287259-3-vincenzo.frascino@arm.com>
 <423e571b-3ef6-4e80-ba81-bf42589a4ba8@app.fastmail.com>
Date: Mon, 07 Oct 2024 18:23:23 +0200
Message-ID: <87ldyzubk4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 04 2024 at 13:13, Arnd Bergmann wrote:
> On Thu, Oct 3, 2024, at 15:29, Vincenzo Frascino wrote:
>> The VDSO implementation includes headers from outside of the
>> vdso/ namespace.
>>
>> Introduce vdso/page.h to make sure that the generic library
>> uses only the allowed namespace.
>>
>> Note: on a 32-bit architecture UL is an unsigned 32 bit long. Hence when
>> it supports 64-bit phys_addr_t we might end up in situation in which the
>> top 32 bit are cleared. To prevent this issue this patch provides
>> separate macros for PAGE_MASK.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>
> Looks good to me. I would apply this to the asm-generic
> tree for 6.13, but there is one small detail I'm unsure
> about:

Please don't. We have related changes upcoming for VDSO which would
heavily conflict. I rather take it through my tree.

Thanks,

        tglx

