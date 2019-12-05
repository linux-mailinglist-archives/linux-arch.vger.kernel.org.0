Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51CA3113FDB
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2019 12:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbfLELCd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 5 Dec 2019 06:02:33 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:50379 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfLELCc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Dec 2019 06:02:32 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MPXta-1iQ7JE2e7G-00MgIi; Thu, 05 Dec 2019 12:02:30 +0100
Received: by mail-lj1-f174.google.com with SMTP id u17so3056978lja.4;
        Thu, 05 Dec 2019 03:02:30 -0800 (PST)
X-Gm-Message-State: APjAAAUWH4PIwe+QeMJCxB97OoyKVGYHnrc7jhjqo7gUJsTeALTl8qvy
        /3Y06Y0EmlLC9Eql0rTMdMA2Ac5Wh2bPQkPBjjU=
X-Google-Smtp-Source: APXvYqzDYON/MBaEaa/M6IrL+iOGcm4xJQW0wdjdRvYG7K2lgdB2YeKajZPfIsCsDNe/lygpM40sVli0MtDQSfWZsds=
X-Received: by 2002:a2e:2e14:: with SMTP id u20mr5178646lju.120.1575543750059;
 Thu, 05 Dec 2019 03:02:30 -0800 (PST)
MIME-Version: 1.0
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <20190621095252.32307-17-vincenzo.frascino@arm.com> <20191204135159.GA7210@roeck-us.net>
 <6cdf4734-4065-09c1-8623-1bf523b38c1b@arm.com> <20191204161641.GA28130@roeck-us.net>
 <e35a7f71-2477-fa52-01e4-301199e99c2e@arm.com> <CAAdtpL71ED3zbkHMqtd1XFQwToOctWJpy2WPqahxHR81fKdTkg@mail.gmail.com>
 <a391048e-f57c-159e-7174-d9d38d8f3825@arm.com>
In-Reply-To: <a391048e-f57c-159e-7174-d9d38d8f3825@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 5 Dec 2019 12:02:13 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1krE=nOi6Dy=QaWiE9VTgNpUVbrHUVm_3Cq+JGJyuwKQ@mail.gmail.com>
Message-ID: <CAK8P3a1krE=nOi6Dy=QaWiE9VTgNpUVbrHUVm_3Cq+JGJyuwKQ@mail.gmail.com>
Subject: Re: [PATCH v7 16/25] arm: Add support for generic vDSO (causing crash)
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
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
X-Provags-ID: V03:K1:Zn6CTbUEtRHLVAE3XDUBZa9tw1grzZNZ4Bh11aTqhSKPcCdLqF2
 duGWHTlB04bQu3q15eEAeoZP4GhzUriW8J1D+AdQ+zOqS5UyBx1bqTZGaKzHPEPgkXjbAyU
 CTy8fiZ/m/k7n/7nEgL2jt968G+3lPSL53Jy/CjBY8T4aiqPyk7HfSJDhMWJJ8LnEWlqvJV
 +xtzv92vRjVv/6dYh2K4Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jh9jVCiv6Mk=:6IeZP/z8O/nZnV8dRQ5XQB
 jzHZggG1fhaUDD154kEgWcyZdMUcQ026S7t+wTqree211w/ALcwlOIk3gI67xPWilkIuMjzns
 VLy7os+VYu6ZlNAonP8g5iZDtHHgKCfVpyETZMV6WIinRz79HdC+qFXus5JtBSE5m9JoV33Ho
 ErSeXTRLs6x5lYkhconpSUA41dKMqwFuj952axq7FcyTV3AxS++nlK9A4F7RiMHnFzNsU0OXO
 MRuQ/YIbxZtzLdRPb91dK1M42Xa47JkYYgXcXsLK6N7Db5IcKqwy/GUhuwK/Fjt/o43wa/LEa
 dwx+5SunGarp1fqwLJYS85PCkTYfc97MG8yGmVxFqKkS+eBo4yy1NcT2Bjohyjzyp51R8ZoPt
 CAsFbSDnEpFhzWKUQecbiQWsCRo8Zyr6nCbvoJlcH4YEL/imaSmx+Q5D9Alu/DNbDFU5dsQgc
 4ZV75Sx3OpZGy3O9Bj7BVsvFUeS8VUi7FfdwnP5K7FoHD4xK0DH99eA/3ZZ5tvQCsHI6zmuLf
 z+L2wZmRyTqzGXvX0z/wHcwYdCfk8Gvy2HFIsPeUMpXdouGF8zDryxHa0qg9QiATuNBMYNpG1
 Srg6IcRe+1eoF7WJK9MEHWWNXdeuj+X4WqTMyxMdniCS7/aodfZ0ajNIN2CvcTTRK9iRRbGP/
 qpqOCx6RgIucC4g1o2YuSqshk0PpppB96RtzVIa/+YOosWzOuddzcl+kjH2AaG0W+L0wYnr8R
 SEYa+S5jlVo47BiTkWB2rpbftH4i8DmSYwK3AfPntheqYfjizi5WWqTQth0B7VRoYI+DeteyF
 hW7puGorAICBgp17bRl30A9HLYD1wU8Z7xiW52UsvmM3E4bYyyWgVnkcUzgkXHw0ElfUQonNR
 Enscj6COPtJvinEeGS2g==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 5, 2019 at 11:00 AM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Hi Philippe,
>
> On 05/12/2019 09:42, Philippe Mathieu-Daudé wrote:
> > There are only 2 "Investigated-by" vs 7k+ "Suggested-by"... Is there a
> > real difference?
>
> Not sure about that. My take is that Suggested-by is used when someone suggests
> you how to possibly implement a feature and you go and do that. Investigated-by
> is when there is a fix to make and someone comes to you with the exact solution
> like in this case Arnd did.

It's not a standard tag, but I suggested it because it does explain
better what I did.

You could also just explain in clear text that I did the analysis and then add
the more normal Suggested-by tag, I don't care either way.

      Arnd
