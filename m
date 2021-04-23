Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F3A36989B
	for <lists+linux-arch@lfdr.de>; Fri, 23 Apr 2021 19:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhDWRnx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Apr 2021 13:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhDWRnx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Apr 2021 13:43:53 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD924C061574;
        Fri, 23 Apr 2021 10:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=D07Myy5xgLJyaySINjmTXcck3i4ZrKKFxHv5lMNfn/o=; b=fFdDv8CW5Q5VQidx3RhtqMzTyP
        HNBtGbWC7zjgBRUN9+xa2UcwtMaeChfa6p1gXVQyu8ST0iYNn3/FtApQJN+fHws87aPHm3nxALogR
        pQnxkVRvxv/Nm908rnmL/7pI7QQJkppzlUdYU65HUIi+T1/0ovu9kMQiEVyGfdGzLiL39ELsgodvR
        HjuyFT25bLTzyhzloR988b83SSyiLn3w55IMx4pblhctRrqF75eMWcIL2Adn9bdMqEcwCnVA8qDuM
        /pZpnHeJmUFRMVLNjrJlwEBfBOgSGe4QGuEAk6hjqRMsj7c58CsRc1D+qh+9ZBAr5RbE9ECow+phy
        kA0ClydA==;
Received: from [2601:1c0:6280:3f0::df68]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZzpi-0022YX-7X; Fri, 23 Apr 2021 17:43:14 +0000
Subject: Re: ARCH=hexagon unsupported?
To:     Arnd Bergmann <arnd@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Brian Cain <bcain@codeaurora.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <CAKwvOdngSxXGYAykAbC=GLE_uWGap220=k1zOSxe1ntuC=0wjA@mail.gmail.com>
 <CAK8P3a2DCCjOq+sB+9sRM7XrtnkromCs_+znv3dehqLiYFDQag@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fa0bed95-5ddf-ecad-0613-2f13837578c3@infradead.org>
Date:   Fri, 23 Apr 2021 10:43:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2DCCjOq+sB+9sRM7XrtnkromCs_+znv3dehqLiYFDQag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/23/21 2:36 AM, Arnd Bergmann wrote:
> On Fri, Apr 23, 2021 at 12:12 AM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
>>
>> Arnd,
>> No one can build ARCH=hexagon and
>> https://github.com/ClangBuiltLinux/linux/issues/759 has been open for
>> 2 years.
>>
>> Trying to build
>> $ ARCH=hexagon CROSS_COMPILE=hexagon-linux-gnu make LLVM=1 LLVM_IAS=1 -j71
>>
>> shows numerous issues, the latest of which
>> commit 8320514c91bea ("hexagon: switch to ->regset_get()")
>> has a very obvious typo which misspells the `struct` keyword and has
>> been in the tree for almost 1 year.
> 
> Thank you for looking into it.
> 
>> Why is arch/hexagon/ in the tree if no one can build it?
> 
> Removing it sounds reasonable to me, it's been broken for too long, and
> we did the same thing for unicore32 that was in the same situation
> where the gcc port was too old to build the kernel and the clang
> port never quite work in mainline.
> 
> Guenter also brought up the issue a year ago, and nothing happened.
> I see Brian still occasionally sends an Ack to a patch that gets merged
> through another tree, but he has not send any patches or pull requests
> himself after taking over maintainership from Richard Kuo in 2019,
> and the four hexagon pull requests after 2014 only contained build fixes
> from developers that don't have access to the hardware (Randy Dunlap,
> Viresh Kumar, Mike Frysinger and me).
> 
>        Arnd
> 
> [1] https://lore.kernel.org/lkml/04ca01d633a8$9abb8070$d0328150$@codeaurora.org/

There is no current gcc C compiler in the 3 locations that I know of to look.
The one I tried is v4.6 and it is too old to work with current makefiles.

-- 
~Randy

