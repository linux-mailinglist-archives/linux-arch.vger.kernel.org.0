Return-Path: <linux-arch+bounces-9178-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B811B9DB8FF
	for <lists+linux-arch@lfdr.de>; Thu, 28 Nov 2024 14:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CF68B20FF3
	for <lists+linux-arch@lfdr.de>; Thu, 28 Nov 2024 13:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A641A9B35;
	Thu, 28 Nov 2024 13:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvrYHMs4"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E311A29A;
	Thu, 28 Nov 2024 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732801304; cv=none; b=it4jNJipbsx62zJbvtxJq4bIyOfltHEPaSZvXt5+Zh1l+cQi/fN2OwCNOnL7Ocm8NpChwhP2scH7xp4d2mrxP3j1ivVXkBOpJjVve7VzyhNORRkVqVFPEf2q4oMBNrCnk8CDRNsx1azenUdw0iKVuVJYre/xgA9Sp/gaX/BXazw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732801304; c=relaxed/simple;
	bh=p96AQe+Xhw1n5/5NkrMy2qekMOxS7j8JyihhPQtfJds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ualkz/tfFWJCbfUY0Ze47FggLVYo73ldlV9enCj2CilTOPwkg5zeuw8TLiRvyuSf4uBjM0fxHM8xKVqJYklaF8JvK6HuWkj9jqOW9jHeQhZulEIORMhvLdvTJqRS2BO3ggAwwSPuJwOBPCqWUMiJmrOvVuU9VJF6EnHapmT9V04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvrYHMs4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8904EC4CECE;
	Thu, 28 Nov 2024 13:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732801303;
	bh=p96AQe+Xhw1n5/5NkrMy2qekMOxS7j8JyihhPQtfJds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DvrYHMs4qo/a/2no2Ds566OX/5t2baRXUWJogUEV887ngBAs+rlQot/G6epNCmBRZ
	 8IT6Gm9OXnzmLGX8wybDoGBF9KCv2iyK6TPMXif0Ym4pX9+7tH8ipiRLk8wmPe4g3a
	 jK+Lsw5j7U24lYR9xpesgz83wniRhqJWQ5COnuMKH9DFzm2PzA17NhDcN33D0Ike1u
	 md+yON0gmvGLXcVlO9dBlJv6AzOIoKiHW472KbAdzzr5ovAw+gPdJwETy0pxcNzCpl
	 8DMszSx7wT1I6/xJr/yBpD4D/Knt03/Km6j+/RojFv3YlBRTxeTD/FpukGdX0K6K6Z
	 7+soo81/ammLg==
Date: Thu, 28 Nov 2024 13:41:36 +0000
From: Will Deacon <will@kernel.org>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v6 13/13] riscv: Add qspinlock support
Message-ID: <20241128134135.GA3460@willie-the-truck>
References: <20241103145153.105097-1-alexghiti@rivosinc.com>
 <20241103145153.105097-14-alexghiti@rivosinc.com>
 <20241128-whoever-wildfire-2a3110c5fd46@wendy>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128-whoever-wildfire-2a3110c5fd46@wendy>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Nov 28, 2024 at 12:56:55PM +0000, Conor Dooley wrote:
> On Sun, Nov 03, 2024 at 03:51:53PM +0100, Alexandre Ghiti wrote:
> > In order to produce a generic kernel, a user can select
> > CONFIG_COMBO_SPINLOCKS which will fallback at runtime to the ticket
> > spinlock implementation if Zabha or Ziccrse are not present.
> > 
> > Note that we can't use alternatives here because the discovery of
> > extensions is done too late and we need to start with the qspinlock
> > implementation because the ticket spinlock implementation would pollute
> > the spinlock value, so let's use static keys.
> > 
> > This is largely based on Guo's work and Leonardo reviews at [1].
> > 
> > Link: https://lore.kernel.org/linux-riscv/20231225125847.2778638-1-guoren@kernel.org/ [1]
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> 
> This patch (now commit ab83647fadae2 ("riscv: Add qspinlock support"))
> breaks boot on polarfire soc. It dies before outputting anything to the
> console. My .config has:
> 
> # CONFIG_RISCV_TICKET_SPINLOCKS is not set
> # CONFIG_RISCV_QUEUED_SPINLOCKS is not set
> CONFIG_RISCV_COMBO_SPINLOCKS=y

I pointed out some of the fragility during review:

https://lore.kernel.org/all/20241111164259.GA20042@willie-the-truck/

so I'm kinda surprised it got merged tbh :/

Will

