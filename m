Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABE6491088
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jan 2022 20:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbiAQTCC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Jan 2022 14:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbiAQTCC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Jan 2022 14:02:02 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BF7C061574
        for <linux-arch@vger.kernel.org>; Mon, 17 Jan 2022 11:02:02 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id q25so5245738pfl.8
        for <linux-arch@vger.kernel.org>; Mon, 17 Jan 2022 11:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lo/AvfHyW3iFZTGH4cnw2d9o9fuu0exnrNpQyWlKhSU=;
        b=FrUN47heV+GXLfQKjEAyNEGhY9Gl50ZAWRBpNLkqZyoxM+pjT59AXA1HbyZ1LGGjBF
         v8RV0lPQUrgtTO2n4VUX0r5ef4Rw9Kxco0C7XE9Da5LptXauzW8IVP5sIcNKrUGzmOxi
         O9DaT0pzRNxWLKPJXFuAt7tmdwOKTdqt0h3QiIVhjShfMH853dBxfuw8JEUoaKZN21lh
         yj+4e4i45G1LNvYGLVIVaRb9U4QZkL4JvOOZyc2yXvVbJDELz4E+BZpcA+WWCfCDLb7S
         p6PiEbZkWCZ6pVC+/Ri/1ebra9qOWXKr/yKwZal3Rxv1Usf755ECGMhcdCD3QJdj8IN0
         HstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lo/AvfHyW3iFZTGH4cnw2d9o9fuu0exnrNpQyWlKhSU=;
        b=teGEW9tfu2xEKPmb87H4pGDBtU5Fz7YUgeMiG698j423khXgMiVQTPXjzGLbUa7QPy
         vft5wgBzm07BUSyDSZeSaaAnd1zRchdJ1RbiBZwSjXYyMrlNu7GzeIXn7lvOUtYnbxcp
         i2Yks6V/l6NLvsj0XOwIFz4zRVZBgbI55/yf6ALsIBqDatjy8dbNetuqzXtrYuUpBn64
         kwa4GRPQ130lsaMONvYCHmvvnXGhSjqnJ2JZVyaP/VXLWOqqo0kyQ9cVvfY3mJG+M1dc
         1WazOSSvUrFPS7gsTLBSfJ2ILITWpDHnQMXjqE/dDJMAVF9ejfAu21chgLv651kJsqci
         P40w==
X-Gm-Message-State: AOAM533KoTetiOs82KKfCJeO8bppf0swi5d3vFL3Gd3c1vQvQYvNaX/y
        c7UMSrxiLt046SstjOiukzHK2vccFK+OGte9jxEjQEm0FCU=
X-Google-Smtp-Source: ABdhPJx963povf1oBbLiouBrgDZPahhoz9NMlMXMiTqKRQbULZi90/3jtr9+XylXI7dRSweX1QjCgKEVD/yOKKi+d5U=
X-Received: by 2002:a05:6a00:124c:b0:4ba:1288:67dc with SMTP id
 u12-20020a056a00124c00b004ba128867dcmr10797519pfi.43.1642446121518; Mon, 17
 Jan 2022 11:02:01 -0800 (PST)
MIME-Version: 1.0
References: <20211115152714.3205552-1-broonie@kernel.org> <YbD4LKiaxG2R0XxN@arm.com>
 <20211209111048.GM3294453@arm.com> <YdSEkt72V1oeVx5E@sirena.org.uk>
 <101d8e84-7429-bbf1-0271-5436eca0eea2@arm.com> <YdbL5kIzi0xqVTVd@arm.com>
 <8550afd2-268d-a25f-88fd-0dd0b184ca23@arm.com> <YdcxUZ06f60UQMKM@arm.com>
 <Ydc+AuagOD9GSooP@sirena.org.uk> <YdgrjWVxRGRtnf5b@arm.com>
 <YeWtRk0H30q38eM8@arm.com> <20ae043b-a013-068d-2d83-16e63f5b4989@linaro.org>
In-Reply-To: <20ae043b-a013-068d-2d83-16e63f5b4989@linaro.org>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Mon, 17 Jan 2022 11:01:25 -0800
Message-ID: <CAMe9rOo5zWO1BwZGhqGdWuCjsq86YUo4ptqXkFVNSwXbU+ZS-Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] arm64: Enable BTI for the executable as well as
 the interpreter
To:     Adhemerval Zanella <adhemerval.zanella@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 17, 2022 at 10:17 AM Adhemerval Zanella via Libc-alpha
<libc-alpha@sourceware.org> wrote:
>
>
>
> On 17/01/2022 14:54, Catalin Marinas via Libc-alpha wrote:
> > On Fri, Jan 07, 2022 at 12:01:17PM +0000, Catalin Marinas wrote:
> >> I think we can look at this from two angles:
> >>
> >> 1. Ignoring MDWE, should whoever does the original mmap() also honour
> >>    PROT_BTI? We do this for static binaries but, for consistency, should
> >>    we extend it to dynamic executable?
> >>
> >> 2. A 'simple' fix to allow MDWE together with BTI.
> >
> > Thinking about it, (1) is not that different from the kernel setting
> > PROT_EXEC on the main executable when the dynamic loader could've done
> > it as well. There is a case for making this more consistent: whoever
> > does the mmap() should use the full attributes.
> >
> > Question for the toolchain people: would the compiler ever generate
> > relocations in the main executable that the linker needs to resolve via
> > an mprotect(READ|WRITE) followed by mprotect(READ|EXEC)? If yes, we'd
> > better go for a proper MDWE implementation in the kernel.
> >
>
> Yes, text relocations.  However these are deprecated (some libcs even do
> not support it) and have a lot of drawbacks.

We are taking a different approach for CET enabling.   CET will be
changed to be enabled from user space:

https://gitlab.com/x86-glibc/glibc/-/tree/users/hjl/cet/enable

and the CET kernel no longer enables CET automatically:

https://github.com/hjl-tools/linux/tree/hjl/cet%2F5.16.0-v4

-- 
H.J.
