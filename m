Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64AE614C52C
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jan 2020 05:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgA2EY4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jan 2020 23:24:56 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46369 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgA2EY4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jan 2020 23:24:56 -0500
Received: by mail-qt1-f195.google.com with SMTP id e25so12228451qtr.13;
        Tue, 28 Jan 2020 20:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eakBGQ1EfxNPQBSaXqT9vlsaKAmpZ5+kMa3s4kT1JN8=;
        b=K0eBBXdiKRQKb2Um1UxPIn+uPENTwBO73Ct4S7khM/WqZxfdTcHnuNaxp53t1tMVBo
         l9d3d7PL0LO9ZjFmSgfo3XDYniGhORhLXPrTildO5+2rqDwAWILhln/UqIRSkQdIHgS6
         RFERqWwekSHDpn6YcYxkPLeqfXLrfSFMKTbb14n94rOk/DKkDXyqH6sXX/GIiOeK8Bee
         y7ZoOGVarjuJnAOVKQOr8Wu1rR9ZN759TG+xWJ0OpkZN0fiN1P/gAOqp0sajV1klhTCK
         2SUTfP2c8RI4aVoMDN6KnBHnLgfxjgP7I8e0urSZ0UsF8pDDnSlFUjo8JTeFIBx3bJ7k
         sW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eakBGQ1EfxNPQBSaXqT9vlsaKAmpZ5+kMa3s4kT1JN8=;
        b=lSIiJzWKTZwdiot5la8f8on9X8szk3VtWuhRkTfD70MQBgtSglyQ/sbSe0LWwoMDro
         MQIypy5Ifr7YTrRilMoyNZBuBfBEq0QqRQ2y8VLe/Xk8Ih1OgxnPtSPhSawt/gzWuhl2
         K5oKlLE91UAxT80Eb1LXUdVEgMIVjNc0TzdNJaJ6hCuEv3Xe3ZdOIiAgwux27C1bF5j+
         KsS4yrQHrGPvoweEfH/QRk1C7EPIM2y+6Kx3VoHBX6rvWoCA0wjtw6H0SiOnrPNBW0tr
         Hlbhsl/OeSu1rH1+DDJhBMQX9XBcmv7Jk0hg79wnflGvjaOaBZMkntQIAmvgSbK9NzJR
         49ig==
X-Gm-Message-State: APjAAAVVCupBiROmzddKrjchBTzOHVdA2C/6x/OZEPf7QQE9ONWRsJzO
        rB5gsFgu5WZFVvysizS3AQM=
X-Google-Smtp-Source: APXvYqznV+gAHKK6MsOz+wnZrl/QqDx4om8+h40F66lxU7UeeC31wlbnLgo/pifdnYfPWmWnjBdfHQ==
X-Received: by 2002:ac8:6f27:: with SMTP id i7mr5201797qtv.253.1580271895195;
        Tue, 28 Jan 2020 20:24:55 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id o187sm405516qkf.26.2020.01.28.20.24.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jan 2020 20:24:54 -0800 (PST)
Subject: Re: [RFC v1 0/6] kunit: create a centralized executor to dispatch all
 KUnit tests
To:     Brendan Higgins <brendanhiggins@google.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Knut Omang <knut.omang@oracle.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20191216220555.245089-1-brendanhiggins@google.com>
 <20200106224022.GX11244@42.do-not-panic.com>
 <CAFd5g456c2Zs7rCvRPgio83G=SrtPGi25zbqAUyTBHspHwtu4w@mail.gmail.com>
 <594b7815-0611-34ea-beb5-0642114b5d82@gmail.com>
 <CAFd5g469TWzrLKmQNR2i0HACJ3FEu-=4-Rk005g9szB5UsZAcw@mail.gmail.com>
 <e801e4ac-b7c2-3d0a-71e7-f8153a3dfbc8@gmail.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF982C9840@USCULXMSG17.am.sony.com>
 <CAFd5g46Ut9Suptmp_bBspkp=KKt2GP+=1C5zLu0FXJY9dGJbFQ@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <dcf2d008-c044-f2d4-63b9-47151157eeb4@gmail.com>
Date:   Tue, 28 Jan 2020 22:24:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g46Ut9Suptmp_bBspkp=KKt2GP+=1C5zLu0FXJY9dGJbFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/28/20 1:53 PM, Brendan Higgins wrote:
> On Tue, Jan 28, 2020 at 11:35 AM <Tim.Bird@sony.com> wrote:
>>
>>> -----Original Message-----
>>> From:  Frank Rowand on January 28, 2020 11:37 AM
>>>
>>> On 1/28/20 1:19 AM, Brendan Higgins wrote:
>>>> On Mon, Jan 27, 2020 at 9:40 AM Frank Rowand <frowand.list@gmail.com> wrote:
>> ...
>>>> we could add Kconfigs to control this, but the compiler nevertheless
>>>> complains because it doesn't know what phase KUnit runs in.
>>>>
>>>> Is there any way to tell the compiler that it is okay for non __init
>>>> code to call __init code? I would prefer not to have a duplicate
>>>> version of all the KUnit libraries with all the symbols marked __init.
>>>
>>> I'm not sure.  The build messages have always been useful and valid in
>>> my context, so I never thought to consider that possibility.
>>>
>>>> Thoughts?
>>
>> I'm not sure there's a restriction on non __init code calling __init
>> code.  In init/main.c arch_call_reset_init() is in __init, and it calls
>> rest_init which is non __init, without any special handling.
>>
>> Is the compiler complaint mentioned above related to  calling
>> into __init code, or with some other issue?
> 
> I distinctly remember having the compiler complain at me when I was
> messing around with the device tree unit tests because of KUnit
> calling code marked as __init. Maybe it's time to start converting
> those to KUnit to force the issue? Frank, does that work for you?

I have agreed to try converting the devicetree unittest to KUnit.

Now that KUnit is in 5.5, I think there is a solid foundation for
me to proceed.

-Frank
