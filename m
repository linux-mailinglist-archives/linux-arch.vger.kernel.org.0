Return-Path: <linux-arch+bounces-7754-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0BA992A20
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 13:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA24A1F22619
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 11:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBD61B85D1;
	Mon,  7 Oct 2024 11:20:30 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39732AD05;
	Mon,  7 Oct 2024 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728300030; cv=none; b=cK89TbJZZnBlfEXLbRL7T+tOkHUxnlLaeuI5ihNuYsrsL68nVL+OOuJZLUDIAclvfURpisK2SJIYx4FaJ8Udr6ZJX1n57a29Z4U9S56zMrK8uZbSnFARU7kHkl088KT0Ya3j+iEOuj31Fr3gKxo7TwlMNrZhJNXq8bauhdIjBPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728300030; c=relaxed/simple;
	bh=FMCXiC1Srhg1bB0cgpwSeqZNLhP8oeIzUvfacDYF2qI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3WG0WRllKi4Kh1CK+UHjFW5qadb4gEWessB+R3avXJyM4EVeyxJ3dVBXVZrROuECln5DYih+W6m/FOSapfhlZnmTsFKylUU1mUEvHEDN14SWoGGC9tFQHON2KCmsUU1JGnLzSpX+PnXa2PVbWaSyhG7WF9kg4X3u4QJE9bb+C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8279FEC;
	Mon,  7 Oct 2024 04:20:56 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 102613F640;
	Mon,  7 Oct 2024 04:20:24 -0700 (PDT)
Message-ID: <6d79c86d-601b-46b9-a06e-6ab78b6d3e8a@arm.com>
Date: Mon, 7 Oct 2024 12:20:23 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] vdso: Introduce vdso/page.h
To: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
 Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20241003152910.3287259-1-vincenzo.frascino@arm.com>
 <20241003152910.3287259-3-vincenzo.frascino@arm.com>
 <423e571b-3ef6-4e80-ba81-bf42589a4ba8@app.fastmail.com>
 <850cdc2a-a336-4dab-bc7a-d9bcae3fb3cf@arm.com>
 <140c4244-1bb2-404c-8372-1e68963eeea5@app.fastmail.com>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <140c4244-1bb2-404c-8372-1e68963eeea5@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 07/10/2024 12:06, Arnd Bergmann wrote:
> On Mon, Oct 7, 2024, at 11:01, Vincenzo Frascino wrote:
>> On 04/10/2024 14:13, Arnd Bergmann wrote:
> 
>>
>> It seemed harmless from the tests I did. But adding an '&&
>> defined(CONFIG_32BIT)' makes it logically correct. I will add a comment as well
>> in the next version.
> 
> To clarify: this has to be "!defined(CONFIG_64BIT)", as most
> 32-bit architectures don't define the CONFIG_32BIT symbol
> (but all 64-bit ones define CONFIG_64BIT).
> 

You are right, it seemed that every 32-bit architectures with a
64-bit phys_addr_t had CONFIG_32BIT but this is not the case.

>     Arnd

-- 
Regards,
Vincenzo

