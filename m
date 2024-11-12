Return-Path: <linux-arch+bounces-9034-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1779C52B5
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2024 11:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FBFC1F21FB6
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2024 10:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B300B2123FB;
	Tue, 12 Nov 2024 10:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b="A0QTFl3R"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out.freemail.hu (fmfe06.freemail.hu [46.107.16.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FCB1F26E3;
	Tue, 12 Nov 2024 10:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.107.16.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731405978; cv=none; b=doLdB27A+bdDK+XWZgpoOnSWsOMrMQw37Jx9WbUlaC5o0dpWFIFYL+yRydVqtnVxF7aSFnaerb+StMxrFQv6U+pZS6Q+OFfwRloZvuc6NJL/u4iAH6/p/7AaxBdjI9NMDfTmeY1G6FGBCvOlQOGmEjXOQNGTxcIScdU8dVIXYx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731405978; c=relaxed/simple;
	bh=oErtQKVCupMz+bfteO33B3eFn6gN0aJ9XhnkeXcflOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=idS2QW6mlXEvU2zAyB493aXW3YeS4tQZ1eIHKT9+RAYSnQPakX6VMP7IMFMee2Pazcv3lgNYGrbHCvTk9LPpj74Cqcxum+0p1dG2mz+npsN1JETMMF95PB0NeFBnWVVQATepEX9RUpDpX3ppNrYf5bUTc5Gbtoe3Ca6ShAiYo1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu; spf=pass smtp.mailfrom=freemail.hu; dkim=fail (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b=A0QTFl3R reason="signature verification failed"; arc=none smtp.client-ip=46.107.16.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freemail.hu
Received: from [192.168.0.16] (catv-178-48-208-49.catv.fixed.vodafone.hu [178.48.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4Xnhrg5jGHzH4S;
	Tue, 12 Nov 2024 11:06:11 +0100 (CET)
Message-ID: <9ecdbe98-666b-4467-85f5-7f9bc01788c2@freemail.hu>
Date: Tue, 12 Nov 2024 11:06:05 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/memory-model: Fix litmus-tests's file names for
 case-insensitive filesystem.
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, paulmck@kernel.org,
 stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
 peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com,
 j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
 dlustig@nvidia.com, joel@joelfernandes.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, lkmm@lists.linux.dev
References: <20241111164248.1060-1-egyszeregy@freemail.hu>
 <69be42c9-331f-4fb5-a6ae-c2932ada0a47@paulmck-laptop>
 <8925322d-1983-4e35-82f9-d8b86d32e6a6@freemail.hu>
 <1a6342c9-e316-4c78-9a07-84f45cbebb54@paulmck-laptop>
 <ec6e297b-02fb-4f57-9fc1-47751106a7d2@freemail.hu>
 <5acaaaa0-7c17-4991-aff6-8ea293667654@paulmck-laptop>
 <a42da186-195c-40af-b4ee-0eaf6672cf2c@freemail.hu>
 <CAHk-=wiEuh613GjBefTRe-_Eha1X1GoU=1nLt65uccSBC8Ne=A@mail.gmail.com>
 <705daf58-dd30-4935-9864-6489b9b90a35@freemail.hu>
 <ZzKpK_9nxh4Qg6mW@tardis.local>
Content-Language: hu
From: =?UTF-8?Q?Sz=C5=91ke_Benjamin?= <egyszeregy@freemail.hu>
In-Reply-To: <ZzKpK_9nxh4Qg6mW@tardis.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1731405972;
	s=20181004; d=freemail.hu;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	l=4889; bh=ZZtgnOp/FICuvzimecGx+gYv0LEqLmAJkTRBu94dDNw=;
	b=A0QTFl3ReDv0fKmt9l1674cUmXJfZwVCvdveD6T0H2obDSBcsLZIetGZbWxOIRh0
	5EehLZe7BPZF+YQAZQANC4E94ZkqcgsIBYwebbFp13AeKuHwVF5cEOqY1jpGzV7LAs1
	hcXyYNH3yr5JR1mFHgKmxR04rFhsc1V0Ao+6XdW27riD4Ou5NcZ+xMHQf8JDWeK9zjJ
	0F3iGl/VCjfSWMWgTA2+S1PdSLD1Tcjz+NFzUDr9Wfr50C0/pYlKsT2yueeORcjO3PS
	zRvKekQ7sKOjGm7ARtzqO53ixso927hWPts/CA51yKyH26SHJEdJ7bt0XW8RjvE0cUY
	SVCv+LAwtA==

2024. 11. 12. 2:02 keltezéssel, Boqun Feng írta:
> On Tue, Nov 12, 2024 at 12:21:51AM +0100, Sz"oke Benjamin wrote:
>> 2024. 11. 11. 23:00 keltezéssel, Linus Torvalds írta:
>>> On Mon, 11 Nov 2024 at 13:15, Sz"oke Benjamin <egyszeregy@freemail.hu> wrote:
>>>>
>>>> There is a technical issue in the Linux kernel source tree's file naming/styles
>>>> in git clone command on case-insensitive filesystem.
>>>
>>> No.
>>>
>>> This is entirely your problem.
>>>
>>> The kernel build does not work, and is not intended to work on broken setups.
>>>
>>> If you have a case-insensitive filesystem, you get to keep both broken parts.
>>>
>>> I actively hate case-insensitive filesystems. It's a broken model in
>>> so many ways. I will not lift a finger to try to help that
>>> braindamaged setup.
>>>
>>> "Here's a nickel, Kid. Go buy yourself a real computer"
>>>
>>>                Linus
>>
>>
>> In this patch my goal is to improve Linux kernel codebase to able to
>> edit/coding in any platform, in an IDE which has a modern GUI.
>>
>> Chillout, i am not so stupid to compile kernel on this "braindamaged setup",
>> I just like to edit the code and manage it by git commands.
>>
> 
> Then you just need to create a case-sensitive partition, no? What's the
> *technical* issue of doing that? And that cannot be more challenging
> than testing your kernel changes, right? So it won't raise the bar of a
> potential serious kernel contributer.
> 

It is easy to say just need a case-sensitive partition, and sure it can be 
configurable but for example on Windows, admin rights needed for it, which is 
not available in 90% for a workstation machine in an universitiy or a general 
company.


>> So, this is a tipical Braindamaged setup in 2024 for Generation of a half of
>> Y (like me), Z and Alpha developers.
>>
>> Windows or MacOS system
>> - Visual Studio Code for coding
>>      - Git for manage kernel source
>>      - IntelliSense in coding
>>      - Live coding with other developers
>>
>> Linux remote server
>> - Visual Studio Code remote SSH extension/connection for Linux server
>>      - Sync kernel workdir with remote Ubuntu/Debian/RHEL Linux server
>>      - Remote SSH compile for X86_64, ARM64 etc ...
>>      - Download the build result
>>
> 
> How do you know it's "typical"? I just googled it and confirmed I'm a
> Gen Y ;-) and I'm not using vscode or any IDE, a lot of Gen Y, Z and
> Alpha developers I know either use Linux on their desktop/laptop or they
> don't use IDEs. May my experience suffice to say it's not typical? Or is
> it the case where I thought me and my friends are the whole world? ;-)
> 
>> Instead of Visual Studio Code it can be possible to use JetBrains, Eclipse
>> and so on any other modern IDE. The actual limitation is only, that there is
>> a filename issue in the Linux kernel source with
>> "Z6.0+pooncelock+poonceLock+pombonce.litmus", why git clone is failed to
>> work well in this case-insensitive OSs.
> 
> They are not "case-insensitive" OSes, they support case-sensitive
> filesystems, and they support them for a reason, so just use them. With
> your changes, it may be OK at clone time, but as soon as you do some
> serious development involving `git bisect`, you might be very frustated
> that your setup doesn't work.
> 
> So your solution is incompleted (not handling the git history), and your
> goal is a bit personalized: it's only useful to people who want to
> read/edit Linux code without running it and don't want to use a
> case-sensitive filesystem, and that's not very persuasive. I don't think
> we can accept the solution or commit to that goal.
> 

I know the superhero operation may not possible but, i like to edit the code, i 
like to browse the code by mouse clicking easily, how possible in a limited way 
in https://elixir.bootlin.com/linux/v6.11.7/source. I like to get a well work 
IntelliSense and later Copilot AI feature.

In my use-case i do it for ARM64 embedded boards to make patches and 
modifications for my Yocto projects, it means i will run and test my kernel 
build on my target board only, which was downloaded from the remote compiler 
machine after my remote build.

As i saw that in some Youtube coding persons and cahnnels and see colleagues and 
friends, young developers more like to use IDE/GUI in Windows or MacOS for just 
coding/editing and do the basics via git, then use any SSH connection/solution 
to compile the things in remotely then test it in Qemu or a real remote 
machine/board.

In 2024 trend is for multiplatform IDEs like Eclipse, VScode and so on ... SW 
Projects also need to support the minimum possibilities to able to edit and 
manage them in multiplatform mode, otherwise this techs improvments makes no 
sense and they never take adventage of their new IDEs benefits for these 
projects in the future.

> Regards,
> Boqun


