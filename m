Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618FB3B8EA9
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jul 2021 10:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbhGAIKr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Jul 2021 04:10:47 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:58875 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbhGAIKr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jul 2021 04:10:47 -0400
Received: from [192.168.1.155] ([95.117.176.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MmyzH-1lXjmb2UHX-00k89R; Thu, 01 Jul 2021 10:08:06 +0200
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
 <030f1462-2bf9-39bc-d620-6d9fbe454a27@metux.net>
 <87lf6ricqg.fsf@oldenburg.str.redhat.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <4ba30cb7-6854-0691-fad6-4ca9ce674ac2@metux.net>
Date:   Thu, 1 Jul 2021 10:08:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87lf6ricqg.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xRL8EtW66gVNsVPCPhLaskmfT4lbMWeTBpf58sxeY+ti2yqnk8t
 pyaAT2lmntD9kAaqvuPNUTWYvE9rBE81Cn+2bTmmEaW8TPOeZvGwwO7vB9imOpXzsmE9rfz
 BGIZhE3HSB/A0rYll/55KtuTDh5PCOmtmTLzU0hgadVn5aG7JJ7HoetlnOeffUxS2LGajdM
 mVJvCVJR/nbbh5f3ZBLvw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eGql4OMbOEU=:mu5UrpikitKXpLSNSqShzn
 4XNvsAubeTkfo8UVrUD8E1ZG1+lqV0QXLr+H9cbiiAhTwOieTMTsw7TDJ3Y5W+Je6qUDAiONw
 BesrUPrX+GT+sBfsne4Dkk2XX31MJHpWSlp0BU/4M5OPDBirq2RaCA4BHdYdX1a8eS4g4+eKV
 LdRCOmaH4amYzTeYGDsjPY+7fq55nvT6cV1GuhIJ76EVBAHqLToUrv7aXU7GJt/uv9UIGx5zk
 r1lrmgqwHT7awvBfQGIsja7+TS6zO4IyNZ0ZOSObU+832wGTeRzcqgcVzdk8P7dS5ewimiX40
 bjSGuRbYT4VT665pYNKPTXjHPyzfMO7neLvQSuLrmfp/bzsiEY1ENz5v+UEaVmjXD4L1xrASn
 x00vo7qSPJyqpRFtY5lHcOkqCLrg3y+j6hTck6BuVf/qsOzXseXLkwHqkmL45/77ZowiodmtL
 LNB5fj7LBvpTYqU8z6iNh5+NmjXXL9bLom0BY6gOGPEdWfs7hKkGUzi7X8THSfdW/lDto2DC7
 M8rxHF34CSE8zx2Onc4CAtaLfW3yAWqvI9ZOCX5YC6KO0liG7hSeRmXGJHYfIidL6gIKaBTtV
 hqSvDIs/hUtvBKXTzRU9LJ3+gU9qc2KMbnAqVvii1G69Y0i8ho6cOQgjUOYi0yFil1bkYMRMz
 ZyptdLfjH1o++QbNEapAg/XkWz6fpY+je4cXm+GPK1Pj2KKqkq2G9z/nouSmCnJDNtWvChQ/c
 KyATON8q9TJ2qXnVY0AIkijj07wYMlYBEwan6lhlPz3OwDNDABP2k5OsaYU5CoxTHEx9297az
 SzDAOu0d526oX7v6koP90G0jonNSI/nlzh+UihjD62SEfRi00gaTMk1bFGzOIYJOja0oIeI
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 30.06.21 17:38, Florian Weimer wrote:

>> Not necessarily, these can still be applied (and fairly simple).
>> You actually have to twist more extra knobs if to wanted those weird
>> things to happen.
> 
> Sorry, this is just not true.  You cannot load system libraries such as
> NSS modules or cryptographic libraries with a custom glibc because the
> system glibc could be newer, and glibc does not provide that kind of
> compatibility (only the other way round).

Yes, such glibc "plugins" specifically need to be built for the same
glibc version.

I've already mentioned that in 25yrs I've had such scenario, where some
operator actually wants to load *3rdparty* nss modules (that are *not*
included in upstream glibc), just *once* - and this time myself doing
that funny stuff (and also written that module).

And I'm repeating my previous questions: can you name some actual real
world (not hypothetical or academical) scenarios where:

somebody really needs some binary-only application &&
needs those extra modules *into that* application &&
cannot recompile these modules into the applications's prefix &&
needs AMX in that application &&
cannot just use chroot &&
cannot put it into container ?

I happen to be one exacly those folks whose better part of the daily
business is dealing with really crazy scenarios, most people don't
even dare thinking about (also dealing with horrible stuff like having
link in binary-only objects into embedded applications which had been
compiled for different ABIs, etc) - and I can only conclude that the
above kind of scenario is really, really rare, usually caused by
completely non-technical factors (e.g. beaurocrazy) and there're always
other options.


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
