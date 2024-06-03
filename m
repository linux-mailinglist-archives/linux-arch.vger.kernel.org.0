Return-Path: <linux-arch+bounces-4655-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC148D8613
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jun 2024 17:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CA9F1C21DD0
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jun 2024 15:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EA412FF73;
	Mon,  3 Jun 2024 15:31:49 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442B0126F1F;
	Mon,  3 Jun 2024 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717428709; cv=none; b=lbv85T0kl/zN0T30xH3rJehz9mgzHQtE1fGefB0JhEn5L6DAQOTilccUu5AVV4U2DZMYHWDEshHO7WA6AjQCjr7aA1SVdjntuR+yAz89KZIlE1ZoteX7geBj1yEE8U/YLOmQe4ty3hiiYCRkJnvbWCJc8AhZlXaCgMDkBN1t2vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717428709; c=relaxed/simple;
	bh=FGEu0jOGMounLvsZRMkDX/bZRfd7rOh4F+HLFoCmdYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQb0t66GQu5HANbs85IncgokFtwH4OvCk0RU2mWznz0rrGw9BiohBE3aVbi/ztyy/SXO8sfYNPdpT4RKc4J4+RNmAo3rTWRGUuH+se0OUtkr1Bg3IoXgT91ES7blvqEtMORvwp4YxuiZxNFGS1tu3JXW5dfOca/omGSy1mR6/a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9EA2820008;
	Mon,  3 Jun 2024 15:31:41 +0000 (UTC)
Message-ID: <f00b1928-3d91-4900-a588-c12c4933c870@ghiti.fr>
Date: Mon, 3 Jun 2024 17:31:41 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] riscv: Implement cmpxchg8/16() using Zabha
Content-Language: en-US
To: Nathan Chancellor <nathan@kernel.org>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Conor Dooley <conor.dooley@microchip.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
 Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, llvm@lists.linux.dev
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
 <20240528151052.313031-3-alexghiti@rivosinc.com>
 <20240528193110.GA2196855@thelio-3990X>
 <CAHVXubjYVjOH8RKaF1h=iogO3xBM6k+xrGwkPnc-md2oRxbxrQ@mail.gmail.com>
 <20240529155749.GA1339768@thelio-3990X>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240529155749.GA1339768@thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Conor, Nathan,

On 29/05/2024 17:57, Nathan Chancellor wrote:
> On Wed, May 29, 2024 at 02:49:58PM +0200, Alexandre Ghiti wrote:
>> Then I missed that, I should have checked the generated code. Is the
>> extension version "1p0" in '-march=' only required for experimental
>> extensions?
> I think so, if my understanding of the message is correct.
>
>> But from Conor comment here [1], we should not enable extensions that
>> are only experimental. In that case, we should be good with this.
>>
>> [1] https://lore.kernel.org/linux-riscv/20240528151052.313031-1-alexghiti@rivosinc.com/T/#mefb283477bce852f3713cbbb4ff002252281c9d5
> Yeah, I tend to agree with Conor on that front. I had not noticed that
> part of the message when I was looking at other parts of this thread. I
> could see an argument for allowing experimental extensions for
> qualification purposes but I think it does create a bit of a support
> nightmare, especially when there are breaking changes across revisions.
>
>>> config EXPERIMENTAL_EXTENSIONS
>>>      bool
>>>
>>> config TOOLCHAIN_HAS_ZABHA
>>>      def_bool y
>>>      select EXPERIMENTAL_EXETNSIONS if CC_IS_CLANG
>>>      ...
>>>
>>> config TOOLCHAIN_HAS_ZACAS
>>>      def_bool_y
>>>      # ZACAS was experimental until Clang 19: https://github.com/llvm/llvm-project/commit/95aab69c109adf29e183090c25dc95c773215746
>>>      select EXPERIMENTAL_EXETNSIONS if CC_IS_CLANG && CLANG_VERSION < 190000
>>>      ...
>>>
>>> Then in the Makefile:
>>>
>>> ifdef CONFIG_EXPERIMENTAL_EXTENSIONS
>>> KBUILD_AFLAGS += -menable-experimental-extensions
>>> KBUILD_CFLAGS += -menable-experimental-extensions
>>> endif
> Perhaps with that in mind, maybe EXPERIMENTAL_EXTENSIONS (or whatever)
> should be a user selectable option and the TOOLCHAIN values depend on it
> when the user has a clang version that does not support the ratified
> version.
>
>> That's a good idea to me, let's see what Conor thinks [2]
>>
>> [2] https://lore.kernel.org/linux-riscv/20240528151052.313031-1-alexghiti@rivosinc.com/T/#m1d798dfc4c27e5b6d9e14117d81b577ace123322
> FWIW, I think your plan of removing support for the experimental version
> of the extension and pushing to remove the experimental status in LLVM
> (especially since it seems like it is ratified like zacas?
> https://jira.riscv.org/browse/RVS-1685) is probably the best thing going
> forward. If the LLVM folks are made aware soon, it should be easy to get
> that change into clang-19, which is branching at the end of July I
> believe.


FYI, it was just merged https://github.com/llvm/llvm-project/pull/93831

Thanks again,

Alex


>
>> Thanks for your thorough review!
> Thanks for taking LLVM support into consideration :)
>
> Cheers,
> Nathan
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

