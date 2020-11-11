Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813232AF55A
	for <lists+linux-arch@lfdr.de>; Wed, 11 Nov 2020 16:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgKKPr1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Nov 2020 10:47:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:42714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbgKKPrY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Nov 2020 10:47:24 -0500
Received: from linux-8ccs (p57a236d4.dip0.t-ipconnect.de [87.162.54.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8B4E20709;
        Wed, 11 Nov 2020 15:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605109643;
        bh=9YfkkQ9wkyZZeXSsWCszRktU6AOG71Q42S1YPmEDuW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yH0r3uT7ZVJ/rL/JLJzzPkKUzrrJfgOhruyaFU7b+LW4L6jPFinMWadlrS66zQmBi
         zxDYjCri6wVsNVwJcrHvbzjg3iMCLuUrhhTcmtScnN7I9MqWu2Kx3DRJ+vrt6Ip3iL
         TtxAITaYRnJ3F/ZNAdHzXE+3gnZPfu1GDZ4ZqaWc=
Date:   Wed, 11 Nov 2020 16:47:16 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jakub Jelinek <jakub@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH 0/8] linker-section array fix and clean ups
Message-ID: <20201111154716.GB5304@linux-8ccs>
References: <20201103175711.10731-1-johan@kernel.org>
 <20201106160344.GA12184@linux-8ccs.fritz.box>
 <20201106164537.GD4085@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201106164537.GD4085@localhost>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

+++ Johan Hovold [06/11/20 17:45 +0100]:
>On Fri, Nov 06, 2020 at 05:03:45PM +0100, Jessica Yu wrote:
>> +++ Johan Hovold [03/11/20 18:57 +0100]:
>> >We rely on the linker to create arrays for a number of things including
>> >kernel parameters and device-tree-match entries.
>> >
>> >The stride of these linker-section arrays obviously needs to match the
>> >expectations of the code accessing them or bad things will happen.
>> >
>> >One thing to watch out for is that gcc is known to increase the
>> >alignment of larger objects with static extent as an optimisation (on
>> >x86), but this can be suppressed by using the aligned attribute when
>> >declaring entries.
>> >
>> >We've been relying on this behaviour for 16 years for kernel parameters
>> >(and other structures) and it indeed hasn't changed since the
>> >introduction of the aligned attribute in gcc 3.1 (see align_variable()
>> >in [1]).
>> >
>> >Occasionally this gcc optimisation do cause problems which have instead
>> >been worked around in various creative ways including using indirection
>> >through an array of pointers. This was originally done for tracepoints
>> >[2] after a number of failed attempts to create properly aligned arrays,
>> >and the approach was later reused for module-version attributes [3] and
>> >earlycon entries.
>>
>> >[2] https://lore.kernel.org/lkml/20110126222622.GA10794@Krystal/
>
>> So unfortunately, I am not familiar enough with the semantics of gcc's
>> aligned attribute. AFAICT from the patch you linked in [2], the
>> original purpose of the pointer indirection workaround was to avoid
>> relying on (potentially inconsistent) compiler-specific behavior with
>> respect to the aligned attribute. The main concern was potential
>> up-alignment being done by gcc (or the linker) despite the desired
>> alignment being specified. Indeed, the gcc documentation also states
>> that the aligned attribute only specifies the *minimum* alignment,
>> although there's no guarantee that up-alignment wouldn't occur.
>>
>> So I guess my question is, is there some implicit guarantee that
>> specifying alignment by type via __alignof__ that's supposed to
>> prevent gcc from up-aligning? Or are we just assuming that gcc won't
>> increase the alignment? The gcc docs don't seem to clarify this
>> unfortunately.
>
>It's simply specifying alignment when declaring the variable that
>prevents this optimisation. The relevant code is in the function
>align_variable() in [1] where DATA_ALIGNMENT() is never called in case
>an alignment has been specified (!DECL_USER_ALIGN(decl)).
>
>There's no mention in the documentation of this that I'm aware of, but
>this is the way the aligned attribute has worked since its introduction
>judging from the commit history.
>
>As mentioned above, we've been relying on this for kernel parameters and
>other structures since 2003-2004 so if it ever were to change we'd find
>out soon enough.
>
>It's about to be used for scheduler classes as well. [2]
>
>Johan
>
>[1] https://github.com/gcc-mirror/gcc/blob/master/gcc/varasm.c
>[2] https://lore.kernel.org/r/160396870486.397.377616182428528939.tip-bot2@tip-bot2

Thanks for providing the links and references. Your explanation and
this reply from Jakub [1] clarified things for me. I was not aware of
the distinction gcc made between aligned attributes on types vs. on
variables. So from what I understand now, gcc suppresses the
optimization when the alignment is specified in the variable
declaration, but not necessarily when the aligned attribute is just on
the type.

Even though it's been in use for a long time, I think it would be
really helpful if this gcc quirk was explained just a bit more in the
patch changelogs, especially since this is undocumented behavior.
I found the explanation in [1] (as well as in your cover letter) to be
sufficient. Maybe something like "GCC suppresses any optimizations
increasing alignment when the alignment is specified in the variable
declaration, as opposed to just on the type definition. Therefore,
explicitly specify type alignment when declaring entries to prevent
gcc from increasing alignment."

In any case, I can take the module and moduleparam.h patches through
my tree, but I will wait a few days in case there are any objections.

Thanks,

Jessica

[1] https://lore.kernel.org/lkml/20201021131806.GA2176@tucnak/
