Return-Path: <linux-arch+bounces-9181-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A70CC9DB9E0
	for <lists+linux-arch@lfdr.de>; Thu, 28 Nov 2024 15:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11D10B2128A
	for <lists+linux-arch@lfdr.de>; Thu, 28 Nov 2024 14:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D8F156661;
	Thu, 28 Nov 2024 14:50:29 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D7E2233A;
	Thu, 28 Nov 2024 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732805429; cv=none; b=GD8fnON80mJFS0TYCpkkj92r/5MfVlqYVhwfrBD3VhShbWqYJUM06tosaLntHpXC44bsbBwTUXxcdFFjhpiw4GcYEXGNaOojkwVaKzInm2i9GDShD0BXeGhKW+kAiFlMX5riynKu9Xf/z+8fHC4ONeol9K/7+8iH7VJW00sJc3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732805429; c=relaxed/simple;
	bh=QlkrmAfWSgg9jN8h+ddj5jlrPRNfI9eofCH/kWoC9Vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fM6YZq66ufNZy8mW1ghZoR24haIFuT7HnfOgIRaYbp8q/Cd0cxCS4lFf2q4fvIzlE1TPIWaC8C598TIsPJPUzHi4N8dOT+NdukFHCwkYpYirE4jqEN4V5emN+68GbWuniLjgzITU4M/jol8MI4Neb2T7fepdeeB1wrzqH69dxJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id A1F062000F;
	Thu, 28 Nov 2024 14:50:10 +0000 (UTC)
Message-ID: <90533aa9-186a-4f75-b3c5-d93d6682056b@ghiti.fr>
Date: Thu, 28 Nov 2024 15:50:09 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/13] riscv: Add qspinlock support
Content-Language: en-US
To: Conor Dooley <conor.dooley@microchip.com>, Will Deacon <will@kernel.org>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>, Jonathan Corbet
 <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Andrea Parri <parri.andrea@gmail.com>, Nathan Chancellor
 <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org
References: <20241103145153.105097-1-alexghiti@rivosinc.com>
 <20241103145153.105097-14-alexghiti@rivosinc.com>
 <20241128-whoever-wildfire-2a3110c5fd46@wendy>
 <20241128134135.GA3460@willie-the-truck>
 <20241128-uncivil-removed-4e105d1397c9@wendy>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20241128-uncivil-removed-4e105d1397c9@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

On 28/11/2024 15:14, Conor Dooley wrote:
> On Thu, Nov 28, 2024 at 01:41:36PM +0000, Will Deacon wrote:
>> On Thu, Nov 28, 2024 at 12:56:55PM +0000, Conor Dooley wrote:
>>> On Sun, Nov 03, 2024 at 03:51:53PM +0100, Alexandre Ghiti wrote:
>>>> In order to produce a generic kernel, a user can select
>>>> CONFIG_COMBO_SPINLOCKS which will fallback at runtime to the ticket
>>>> spinlock implementation if Zabha or Ziccrse are not present.
>>>>
>>>> Note that we can't use alternatives here because the discovery of
>>>> extensions is done too late and we need to start with the qspinlock
>>>> implementation because the ticket spinlock implementation would pollute
>>>> the spinlock value, so let's use static keys.
>>>>
>>>> This is largely based on Guo's work and Leonardo reviews at [1].
>>>>
>>>> Link: https://lore.kernel.org/linux-riscv/20231225125847.2778638-1-guoren@kernel.org/ [1]
>>>> Signed-off-by: Guo Ren <guoren@kernel.org>
>>>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>>> This patch (now commit ab83647fadae2 ("riscv: Add qspinlock support"))
>>> breaks boot on polarfire soc. It dies before outputting anything to the
>>> console. My .config has:
>>>
>>> # CONFIG_RISCV_TICKET_SPINLOCKS is not set
>>> # CONFIG_RISCV_QUEUED_SPINLOCKS is not set
>>> CONFIG_RISCV_COMBO_SPINLOCKS=y
>> I pointed out some of the fragility during review:
>>
>> https://lore.kernel.org/all/20241111164259.GA20042@willie-the-truck/
>>
>> so I'm kinda surprised it got merged tbh :/
> Maybe it could be reverted rather than having a broken boot with the
> default settings in -rc1.


No need to rush before we know what's happening,I guess you bisected to 
this commit right?

I don't have this soc, so can you provide $stval/$sepc/$scause, a 
config, a kernel, anything?

Does the polarfire soc provide Ziccrse?


>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

