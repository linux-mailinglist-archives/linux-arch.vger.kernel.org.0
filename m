Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBD032398C
	for <lists+linux-arch@lfdr.de>; Wed, 24 Feb 2021 10:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbhBXJf2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Feb 2021 04:35:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:43270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234612AbhBXJeb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Feb 2021 04:34:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98368614A5;
        Wed, 24 Feb 2021 09:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614159228;
        bh=/CF20OHQ7K0JhgmeOCBr7qeOZntk0MWyxxmZPAU4v98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qi1W+/eGUtnIWAUKAzopoH5TWZl7ik9XR7jKSMR1Rf6v1SNwG4lMWVIR2duhS7AuC
         fjbpTOWdiry0E4J2dUEHu6JgC+yfF348N1VJ/JWZ5OLn0zE8pK/sG2d7rb/eQEmBjw
         wzB0y7FzhJyXdDqh4F7HUvmXiLnWjSismhgru7TMyvRVI9wzjYgqzYSmH5soEQhSjY
         gSIu7pqC9jffD1vUwH5Uds2WX0sjMa5c46/uNXzcGZ/hxRuwcDOu1DggT+PERmTAGt
         m4WZGyVTry5AEtbD+s8r2xQ8NSHQhKe2SCwTdyiiP46LouNSOd5scwmUPYSwCjFl+I
         EPzhDr2Crt/eg==
Date:   Wed, 24 Feb 2021 09:33:44 +0000
From:   Will Deacon <will@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, Alexey Klimov <aklimov@redhat.com>
Subject: Re: [PATCH] arm64: enable GENERIC_FIND_FIRST_BIT
Message-ID: <20210224093343.GA11306@willie-the-truck>
References: <20201205165406.108990-1-yury.norov@gmail.com>
 <20201207112530.GB4379@willie-the-truck>
 <CAAH8bW-fb0wPwwvo8P8VW33zV=Wi_LPWxdJH8y2wdGGqPE+3nA@mail.gmail.com>
 <20201208103549.GA5887@willie-the-truck>
 <20210224052744.GA1168363@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224052744.GA1168363@yury-ThinkPad>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 23, 2021 at 09:27:44PM -0800, Yury Norov wrote:
> On Tue, Dec 08, 2020 at 10:35:50AM +0000, Will Deacon wrote:
> > On Mon, Dec 07, 2020 at 05:59:16PM -0800, Yury Norov wrote:
> > > (CC: Alexey Klimov)
> > > 
> > > On Mon, Dec 7, 2020 at 3:25 AM Will Deacon <will@kernel.org> wrote:
> > > >
> > > > On Sat, Dec 05, 2020 at 08:54:06AM -0800, Yury Norov wrote:
> > > > > ARM64 doesn't implement find_first_{zero}_bit in arch code and doesn't
> > > > > enable it in config. It leads to using find_next_bit() which is less
> > > > > efficient:
> > > >
> > > > [...]
> > > >
> > > > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > > > index 1515f6f153a0..2b90ef1f548e 100644
> > > > > --- a/arch/arm64/Kconfig
> > > > > +++ b/arch/arm64/Kconfig
> > > > > @@ -106,6 +106,7 @@ config ARM64
> > > > >       select GENERIC_CPU_AUTOPROBE
> > > > >       select GENERIC_CPU_VULNERABILITIES
> > > > >       select GENERIC_EARLY_IOREMAP
> > > > > +     select GENERIC_FIND_FIRST_BIT
> > > >
> > > > Does this actually make any measurable difference? The disassembly with
> > > > or without this is _very_ similar for me (clang 11).
> > > >
> > > > Will
> > > 
> > > On A-53 find_first_bit() is almost twice faster than find_next_bit(),
> > > according to
> > > lib/find_bit_benchmark. (Thanks to Alexey for testing.)
> > 
> > I guess it's more compiler dependent than anything else, and it's a pity
> > that find_next_bit() isn't implemented in terms of the generic
> > find_first_bit() tbh, but if the numbers are as you suggest then I don't
> > have a problem selecting this on arm64.
> 
> Ping?

Not sure what happened to this. Maybe resend at -rc1?

Will
