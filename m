Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9263B9166
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jul 2021 13:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbhGAMCO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Jul 2021 08:02:14 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:41773 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbhGAMCO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jul 2021 08:02:14 -0400
Received: from [192.168.1.155] ([95.117.176.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M9Frj-1lti9x12jn-006R94; Thu, 01 Jul 2021 13:59:34 +0200
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
 <4ba30cb7-6854-0691-fad6-4ca9ce674ac2@metux.net>
 <878s2qh2bb.fsf@oldenburg.str.redhat.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <034dcf9b-1f8c-23ee-86a6-791122bc0f8c@metux.net>
Date:   Thu, 1 Jul 2021 13:59:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <878s2qh2bb.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yrIhHVBkyeQUmrUAbNBdH57c14ndQpRwW0g3SJYcM7nPaEhvs+9
 wKa0zGh20qrmugmIuA4P9vJCeA2XSW5HhAI2sxloXcThdYd6ltSBt1yK0JIzhqIBOZL4Xf3
 FSLB3gDXr5JMyEWsoswFTvjniNKBDDtah0wicV6K09Wixg1E4GDwD6H/R6ZsXLWTQRDcOw8
 L02pRUeImwD7gOD+9kTaQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GOa+F/xu6gc=:kTj0e2FFcmC0xavUgUvh9D
 08y2L85aPpsUvlhoa+PeCQUt/olDwNbhroJWHyVnRsQy2hff+paqpfMMX3xlXU4a+3w3vPQdu
 9RLs9GVVxuSXwZVya+da2bYnEocHQGoeGCqQoIWuuTRZfL9AG68BGPTf6L6riM6IIe7+1iX1W
 cSYH3LJu7pv4yw9WgNiOyEQD+Tmgp6UIEVMLahuEFnx3mUCu4TAXvb7Yku2nTE8Pnjix+YbYb
 GfHD0fQgijzyYkN7MDefH/Q1Z/e0UaxQK9+d7yjeUZr2OwWF605OAxGeyT4RrpSm05LF/e7Gb
 ZblmAR8RkEWP/B2khU9shfCwyH3legBzSwo8r1BW4GDxHFYSyrpWvHBD5jmTjkrPzJ4flmeD/
 CSS0AujMi9Sd/EHpV+dDJM6s+4oJxEJfous0tcqJTLPVShadnhqpoJ3iP8RqcMQhOzlFfs6NB
 VgeczPBa0h7DPc6iX7YuQuoGjTPj9xetpGGfswaRl1cik+CHoBVSQFPYVdVVXPXmb81xsbc/n
 q2g+pmghpQxsfP9K5BnQBJqqjmGxy3kq5U+7FZQS6Irp/QyQPZv4eUOBPEalNWZYteNQXaLuv
 jvlRRM6+1XY9gmaP1DZEC0VnLCm3yh8t40JN0sbJbeMM+nVUXDHjmxk27yOC9CygmmMVTP48k
 QYwG0WM1zsjPqnFpB+QxRAlFg3pg39y5dQ2RXqL5MRiAyzgVFd1dW68HhBCMjR3PyOs2AZD+I
 ab2G2tho4ZISseNFDkt2OnpEwaKyshamDoJnVYNKoc8qPZrI0c5qzo9cKKRtFvDUV4RSHu9MU
 lIDOHOV1OvMsFTfZazr2Wg1tQzMPZLKeEk7wBZEa22FNv7MVRRfdPNteObO5W1zVhNmF3BJ
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 01.07.21 10:21, Florian Weimer wrote:
> * Enrico Weigelt:
> 
>> And I'm repeating my previous questions: can you name some actual real
>> world (not hypothetical or academical) scenarios where:
>>
>> somebody really needs some binary-only application &&
>> needs those extra modules *into that* application &&
>> cannot recompile these modules into the applications's prefix &&
>> needs AMX in that application &&
>> cannot just use chroot &&
>> cannot put it into container ?
> 
> There are no real-world scenarios yet which involve AMX, so I'm not sure
> what you are after with this question.

Okay, let's take AMX out of the equation (until it actually arrives
in the field). How does it look like then ?


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
