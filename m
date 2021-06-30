Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C4A3B8623
	for <lists+linux-arch@lfdr.de>; Wed, 30 Jun 2021 17:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbhF3PSt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Jun 2021 11:18:49 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:33255 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbhF3PSt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Jun 2021 11:18:49 -0400
Received: from [192.168.1.155] ([95.114.41.241]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MF3U0-1m0qzA3KX2-00FX24; Wed, 30 Jun 2021 17:16:08 +0200
Subject: Re: x86 CPU features detection for applications (and AMX)
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Thiago Macieira <thiago.macieira@intel.com>, hjl.tools@gmail.com,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org
References: <22261946.eFiGugXE7Z@tjmaciei-mobl1>
 <3c5c29e2-1b52-3576-eda2-018fb1e58ff9@metux.net>
 <2379132.fg5cGID6mU@tjmaciei-mobl1>
 <e07294c9-b02a-e1c5-3620-7fae7269fdf1@metux.net>
 <87pmw3ifpv.fsf@oldenburg.str.redhat.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <030f1462-2bf9-39bc-d620-6d9fbe454a27@metux.net>
Date:   Wed, 30 Jun 2021 17:16:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87pmw3ifpv.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AyD6IunEr2ZVbQ6oYBfRq8AhWfgUWlhID3kd5E74rmHmA6gPuN5
 dPH2ajDyy3WEuUhOqy4OxS0TnAB7ONXUkzL1+52QpwrNAeZ6SdI0L8Xjl0iuQU1TuMGNYBs
 AzosIDWcQpHDUV8h9CLLFCFsEnR1yY1ZXBq2qUHfBvRZ7Sk3q6vkiUdtQ7Eke+eDA5RpWVD
 b+QCcwftECYMwOuGCGMfA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0quIKKXfv5c=:RRMbdvs69LyU0undJQsfFH
 z8mpAzkS1bPOkelKHRmRn+WYvyx2xBimmmQ2GSjKc8IUFsNBM5A/5x1pdBcsFbotjNFWgLde7
 ciU3sD5qI1ijjf7cn4Uy7bYNB3EXohhqFeQ0WZ4JrwZXY5W6HEwJl29KYNZQYtHLCtwj7smdI
 IGyCOBSnDLZQb28ZWK4DsmGILWvpS/WMnYu7SrhoNxTE9P0tj4xu73mCn5JmSJ2hpzYhDvshw
 9Zn9Oco7aW0zxng4DeEkY2BxVmkbqIgA6ZWv21Mx2W0EWmiYHcWDtuNDoGuhK/tPjBc5pdVYc
 kYXYIfxYWZ3Kq7GgNC3QBvKQjAzbpLfX6i1d+OD0rEA55dcqTcX2Rp9iZAUYy7vaSAvoSlbgV
 m3gYk8+2ylgXyujmXVf0uWA9IJX9LfJe30orQV82xv1mxNbUzDuUE87tSfo7f2EpcFuLqIj6A
 PIfp6KxYqq5+A2IicovUgNqOwDM0l0z25EyIGeSTPnFZ2qx+ArFsFZy1r7lkIRsaZT59neVAj
 Gjac5Ki4g09Rl7jX2WhVEqUiWK49d3S14ksHwxY2fMqXpjuQC6K1Ej771S4lhbq5QS17mOqVk
 b1q6JlfZe7nZlNRtxTqNFGFW7FWR3PX2Vj124JtkfV9LvSg7dj1boYgNDXSe69gSgAqLZScaS
 4YH08yhysCT+Z2WBvfHF1AN55nF2MObyq0xjtfjwZ/tAvnAFmP5EfpaW9gBzj43m0orKzw7j+
 neqaKXTJ2QRVk+TaqnpzbjpRK0m7YxZg1bH4AUVUcqJwRrDdcb65XUq81TFI+D+rOHt0vCUR6
 ioaTfpP3eapxF3s6Ec6tgt1qpWJB5zrYEmxLBkOGCmBS7WR/G7tHv9cNpDplzatEKL/1jz++X
 HqNw0YDo8YMqeaVi3bAZ/cUGEoU+GvmN+aMA0DFYw=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 30.06.21 16:34, Florian Weimer wrote:

> It breaks integration with system-wide settings, such as user/group
> databases, host name lookup, and cryptographic policies.  In many
> environments, that is not really an option.

Not necessarily, these can still be applied (and fairly simple).
You actually have to twist more extra knobs if to wanted those weird
things to happen.

The only thing that won't work easily is when the operator forces some
custom libraries to be loaded arbitrarily into all processes. Yes,
somebody could write his own nss plugins, but that's exactly the kind
of audience that does NOT just use those (especially old) binary-only
distros. In over 20 years, being inside dozens of corporations, I've
only seen that exactly once. And it was me doing that.

I actually wonder which kind of binary only application that shall be
that's actually affected by that problem and actually used in the
field that way.

Do you have some actual practical (not theoretical) example ?

By the way: today's method of choice for delivering binary only
software is containers. (and I'd even count things like Steam into
that category).


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
