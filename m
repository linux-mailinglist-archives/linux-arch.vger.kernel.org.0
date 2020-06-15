Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC7B1F9AD8
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jun 2020 16:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbgFOOvU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Jun 2020 10:51:20 -0400
Received: from foss.arm.com ([217.140.110.172]:49770 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728304AbgFOOvU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 15 Jun 2020 10:51:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11A7E31B;
        Mon, 15 Jun 2020 07:51:19 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11A833F6CF;
        Mon, 15 Jun 2020 07:51:17 -0700 (PDT)
Date:   Mon, 15 Jun 2020 15:51:16 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [RFC PATCH v2 6/6] prctl.2: Add tagged address ABI control
 prctls (arm64)
Message-ID: <20200615145115.GL25945@arm.com>
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
 <1590614258-24728-7-git-send-email-Dave.Martin@arm.com>
 <20200609172232.GA63286@C02TF0J2HF1T.local>
 <20200610100641.GF25945@arm.com>
 <20200610152634.GJ26099@gaia>
 <20200610164209.GH25945@arm.com>
 <20200610174205.GL26099@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610174205.GL26099@gaia>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 10, 2020 at 06:42:05PM +0100, Catalin Marinas wrote:
> On Wed, Jun 10, 2020 at 05:42:09PM +0100, Dave P Martin wrote:
> > On Wed, Jun 10, 2020 at 04:26:34PM +0100, Catalin Marinas wrote:
> > > On Wed, Jun 10, 2020 at 11:06:42AM +0100, Dave P Martin wrote:
> > > > On Tue, Jun 09, 2020 at 06:22:32PM +0100, Catalin Marinas wrote:
> > > > > On Wed, May 27, 2020 at 10:17:38PM +0100, Dave P Martin wrote:
> > > > > > +.IP
> > > > > > +The level of support is selected by
> > > > > > +.IR "(unsigned int) arg2" ,
> > > > > 
> > > > > We use (unsigned long) for arg2.
> > > > 
> > > > Hmmm, not quite sure how I came up with unsigned int here.  I'll just
> > > > drop this: the type in the prctl() prototype is unsigned long anyway.
> > > > 
> > > > The type is actually moot in this case, since the valid values all fit
> > > > in an unsigned int.
> > > 
> > > Passing an int doesn't require that the top 32-bit of the long are
> > > zeroed (in case anyone writes the low-level SVC by hand).
> > 
> > Fair point, I was forgetting that wrinkle.  Anyway, the convention in
> > this page seems to be that if the type is unsigned long, we don't
> > mention it, because the prctl() prototype says that already.
> > 
> > Question: the glibc prototype for prctl is variadic, so surely any
> > calls that don't explicitly cast the args to unsigned long are already
> > theoretically broken?  The #defines (and 0) are all implicitly int.
> > This probably affects lots of prctls.
> > 
> > We may get away with it because the compiler is almost certainly going
> > to favour a mov over a ldr for getting small integers into regs, and mov
> > <Wd> fortunately zeroes the top bits for us anyway.
> 
> So does LDR Wd.
> 
> Anyway, I think glibc (or my reading of it) has something like like:
> 
>   register long _x1 asm ("x1") = _x1tmp;
> 
> before invoking the SVC. I assume this would do the right conversion to
> long. I can't tell about other libraries but I'd say it's their
> responsibility to convert the args to long before calling the kernel's
> prctl().

Ignore me.  I was worrying that glibc would propagate junk in the high
bits of int arguments, due to treating them as longs.  Actually, it
will, but it doesn't matter where we explicitly cast the argument to int
inside the kernel (thanks as usual to -fno-strict-overflow).

Cheers
---Dave
