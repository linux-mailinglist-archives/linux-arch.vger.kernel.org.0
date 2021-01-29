Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43E03085FA
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 07:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhA2GnJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 01:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhA2Gm5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 01:42:57 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87597C061574;
        Thu, 28 Jan 2021 22:41:57 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id p72so8197130iod.12;
        Thu, 28 Jan 2021 22:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iVAMGV92J/f/CkteAMcDz3wL9cSpiXqRvqsJUAbs4+w=;
        b=pdaI6T09b4/35M8LZtfd5am6EJAi2hkvXoRBPVsi32LE8VBjR2dU2H7w8K9Ql8iAgf
         VrbhUdwoVGL2ljic5eUiSCFsmaiCNtoueptBpiOAX8TLmIpI5z6pB8qdLSczv34d+Nv8
         ZJSHqxyJgDo/rpNrzFxWaOCty38aakVFP7Gg6NzCpVwtv2hvrjgjoprP8QmvdZ1CRALU
         xoi4Vdjt7+GltZVxJ8M5qAFeboZsNzHSZtxopPNx0cHM2nEGvt9LKCdEkZSm1R12TMPt
         /OgMU7DX0mEN8j+431T3Mddp5jaf+1bIjJ8a/hYU8wjo8+OOE9ho17+xgpFYiKAeldfy
         lk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iVAMGV92J/f/CkteAMcDz3wL9cSpiXqRvqsJUAbs4+w=;
        b=DEz8nersf7WcMfA/jQJREYVeDRZBIH1Pk3+Nov5rEVjyG2sIKSRJD4u7NYwn41R2PE
         uxM7OycgimJjmAd85cTKHUXeRVMmu7bEo9uNg0E6Awq1xsHOEviPBG0R7oIHyJPhhjIF
         rtMqVcaeReaPOv6APYqqf0FiC9aZWRFlnTCPK8h3qjKt1gpPAWZQaRXj4D2UxJKq49WH
         O2Zp2ne6JwvJo5HUp0dIV1UzwWsMI6jOU27sDG8/MMVqL99hp//WPCM6E1Cj/1VzRT9M
         FaiBMvLzOPMQOS6+Z4BfhH4f1E08z5aMFFmMVVA2xGRwbfyqcUiiqNuaMhdILHEaquIg
         gqLg==
X-Gm-Message-State: AOAM530Gg6ej69XmeCtgsgsolyXQviLY8RHXw+uflt3BxsbUQ57EL8Vm
        dFIYVVmVaDIV2moJPG0VLERq3FmZUVWeZ8HGmqM=
X-Google-Smtp-Source: ABdhPJxBYeN3I1wdA2fWrBSBowJmYe8hGPdJD45A7zJciUI858z9CrZbB7j0UfSZvdn/5JVuocI+7v+FXFR9WB/DEtw=
X-Received: by 2002:a6b:8f58:: with SMTP id r85mr2296622iod.132.1611902516781;
 Thu, 28 Jan 2021 22:41:56 -0800 (PST)
MIME-Version: 1.0
References: <20210121000630.371883-1-yury.norov@gmail.com> <20210121000630.371883-5-yury.norov@gmail.com>
 <YAlXMj7sIoPjZP3W@smile.fi.intel.com>
In-Reply-To: <YAlXMj7sIoPjZP3W@smile.fi.intel.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Thu, 28 Jan 2021 22:41:45 -0800
Message-ID: <CAAH8bW8LSk4Jr_T0TZqfmzgXPQ4MMGJoN6OF664F+SGLYJG+Eg@mail.gmail.com>
Subject: Re: [PATCH 4/6] lib: inline _find_next_bit() wrappers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-m68k@lists.linux-m68k.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sh@vger.kernel.org, linux-arch@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        David Sterba <dsterba@suse.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 21, 2021 at 2:27 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jan 20, 2021 at 04:06:28PM -0800, Yury Norov wrote:
> > lib/find_bit.c declares five single-line wrappers for _find_next_bit().
> > We may turn those wrappers to inline functions. It eliminates
> > unneeded function calls and opens room for compile-time optimizations.
>
> ...
>
> > --- a/include/asm-generic/bitops/le.h
> > +++ b/include/asm-generic/bitops/le.h
> > @@ -4,6 +4,7 @@
> >
> >  #include <asm/types.h>
> >  #include <asm/byteorder.h>
> > +#include <asm-generic/bitops/find.h>
>
> I'm wondering if generic header inclusion should go before arch-dependent ones.
>
> ...
>
> > -#ifndef find_next_bit
>
> > -#ifndef find_next_zero_bit
>
> > -#if !defined(find_next_and_bit)
>
> > -#ifndef find_next_zero_bit_le
>
> > -#ifndef find_next_bit_le
>
> Shouldn't you leave these in new wrappers as well?
>
> --
> With Best Regards,
> Andy Shevchenko

Could you please elaborate? Wrappers in find.h are protected, functions
in lib/find_bit.c too. Maybe I misunderstood you?..
