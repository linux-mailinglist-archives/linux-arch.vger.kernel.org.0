Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5394811431E
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2019 15:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbfLEO42 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 5 Dec 2019 09:56:28 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:38688 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbfLEO41 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Dec 2019 09:56:27 -0500
Received: by mail-yb1-f193.google.com with SMTP id l129so1559679ybf.5;
        Thu, 05 Dec 2019 06:56:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cTlMueSMchAhnB5c9dF6u/KNgq8yI63KJZxYO4ZHEn8=;
        b=IytFm10AKV5KzmU+vFm+KIsFqj8iJPHI46ZQxbFP4VjpdHtxUGqcaV0VOU9yhtD0tl
         6ykFu3PvhcIFv9WaeY5KPlwwzR2G+ozdXbi+fSvm20mDD77y0F5j/zSHac+dAGBxrs60
         +pG0OVG0CC0mdtQoHbI1u9ZmQWemt1JECMfLW3kzx5HwTFvgqXJ5jst5FGKl/w9MzsWD
         SPNBTHsOZkneNyGvbhCC8Y+YYlofbVvoS+M+kRx5pNUuaU7v/JboUmJ8RATWTT8gV9RG
         mJRw/HHx+dqo0r+uuofLGxvx+wSxBA+shBI9Vyc2uGpumP2s17JK8DzGdOEIuYCL/grD
         SxKQ==
X-Gm-Message-State: APjAAAWiyzPta/EYk8/Zdb84ImffLvqb0ir8Jd6mNs7RHgziipncjF0N
        tpL+tESlZSTHzLQ7J5sXxoxnlia2rRPP7dBsknQ=
X-Google-Smtp-Source: APXvYqxJjhm3o1BQB3vkrGqzzaet9PSqTm3ZsGDjonVncS72IrzgX4OvU09qJdtZVweIfksp+ZDsbdXcT9x1M/F7SNQ=
X-Received: by 2002:a25:5555:: with SMTP id j82mr6920179ybb.376.1575557786280;
 Thu, 05 Dec 2019 06:56:26 -0800 (PST)
MIME-Version: 1.0
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <20190621095252.32307-17-vincenzo.frascino@arm.com> <20191204135159.GA7210@roeck-us.net>
 <6cdf4734-4065-09c1-8623-1bf523b38c1b@arm.com> <20191204161641.GA28130@roeck-us.net>
 <e35a7f71-2477-fa52-01e4-301199e99c2e@arm.com> <CAAdtpL71ED3zbkHMqtd1XFQwToOctWJpy2WPqahxHR81fKdTkg@mail.gmail.com>
 <a391048e-f57c-159e-7174-d9d38d8f3825@arm.com> <CAK8P3a1krE=nOi6Dy=QaWiE9VTgNpUVbrHUVm_3Cq+JGJyuwKQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1krE=nOi6Dy=QaWiE9VTgNpUVbrHUVm_3Cq+JGJyuwKQ@mail.gmail.com>
From:   =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date:   Thu, 5 Dec 2019 15:56:15 +0100
Message-ID: <CAAdtpL5cMZQPa-SdMdi3SZnO=3-FkTkDCZjgjyy5Gmcqo+-MXw@mail.gmail.com>
Subject: Re: [PATCH v7 16/25] arm: Add support for generic vDSO (causing crash)
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 5, 2019 at 12:02 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Dec 5, 2019 at 11:00 AM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
> >
> > Hi Philippe,
> >
> > On 05/12/2019 09:42, Philippe Mathieu-Daudé wrote:
> > > There are only 2 "Investigated-by" vs 7k+ "Suggested-by"... Is there a
> > > real difference?
> >
> > Not sure about that. My take is that Suggested-by is used when someone suggests
> > you how to possibly implement a feature and you go and do that. Investigated-by
> > is when there is a fix to make and someone comes to you with the exact solution
> > like in this case Arnd did.
>
> It's not a standard tag, but I suggested it because it does explain
> better what I did.
>
> You could also just explain in clear text that I did the analysis and then add
> the more normal Suggested-by tag, I don't care either way.

No problem, I was just wondering the subtle difference between both tags.
I don't mind which one you use, as long as this issue get fixed :)
Thanks for the patch BTW!

Regards,

Phil.

>       Arnd
