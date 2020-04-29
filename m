Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1487A1BDF94
	for <lists+linux-arch@lfdr.de>; Wed, 29 Apr 2020 15:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgD2Nwa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Apr 2020 09:52:30 -0400
Received: from foss.arm.com ([217.140.110.172]:39594 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgD2Nwa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Apr 2020 09:52:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 699A61045;
        Wed, 29 Apr 2020 06:52:29 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2B563F68F;
        Wed, 29 Apr 2020 06:52:27 -0700 (PDT)
Date:   Wed, 29 Apr 2020 14:52:25 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 20/23] fs: Allow copy_mount_options() to access
 user-space in a single pass
Message-ID: <20200429135224.GB10651@gaia>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
 <20200421142603.3894-21-catalin.marinas@arm.com>
 <20200429102650.GC30377@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429102650.GC30377@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 29, 2020 at 11:26:51AM +0100, Dave P Martin wrote:
> On Tue, Apr 21, 2020 at 03:26:00PM +0100, Catalin Marinas wrote:
> > diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> > index 32fc8061aa76..566da441eba2 100644
> > --- a/arch/arm64/include/asm/uaccess.h
> > +++ b/arch/arm64/include/asm/uaccess.h
> > @@ -416,6 +416,17 @@ extern unsigned long __must_check __arch_copy_in_user(void __user *to, const voi
> >  #define INLINE_COPY_TO_USER
> >  #define INLINE_COPY_FROM_USER
> >  
> > +static inline bool arch_has_exact_copy_from_user(unsigned long n)
> > +{
> > +	/*
> > +	 * copy_from_user() aligns the source pointer if the size is greater
> > +	 * than 15. Since all the loads are naturally aligned, they can only
> > +	 * fail on the first byte.
> > +	 */
> > +	return n > 15;
> > +}
> > +#define arch_has_exact_copy_from_user
> 
> Did you mean:
> 
> #define arch_has_exact_copy_from_user arch_has_exact_copy_from_user

Yes (and I shouldn't write patches late in the day).

> Mind you, if this expands to 1 I'd have expected copy_mount_options()
> not to compile, so I may be missing something.

I think arch_has_exact_copy_from_user() (with the braces) is looked up
in the function namespace, so the macro isn't expanded. So arguably the
patch is correct but pretty dodgy ;).

I scrapped this in my second attempt in reply to Kevin.

> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index a28e4db075ed..8febc50dfc5d 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -3025,13 +3025,16 @@ void *copy_mount_options(const void __user * data)
> 
> [ Is this applying a band-aid to duct tape?
> 
> The fs presumably knows ahead of time whether it's expecting a string or
> a fixed-size blob for data, so I'd hope we could just DTRT rather than
> playing SEGV roulette here.
> 
> This might require more refactoring than makes sense for this series
> though. ]

That's possible but it means moving the copy from sys_mount() to the
specific places where it has additional information (the filesystems).
I'm not even sure it's guaranteed to be strings. If it is, we could just
replace all this with a strncpy_from_user().

-- 
Catalin
