Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5302F3B6766
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jun 2021 19:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbhF1RQz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Jun 2021 13:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbhF1RQy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jun 2021 13:16:54 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAD6C061574;
        Mon, 28 Jun 2021 10:14:27 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id x16so14653819pfa.13;
        Mon, 28 Jun 2021 10:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=8ssRK52MSevAKyQoJxF4jNVc366d3EchjdXo13/rUh0=;
        b=OTreY5lHoXNQ2THoqnz3iL4Rn8/qrdaoVrPCgJ8vwojjNX7ZbIGTNwLMegvtr3NEOx
         f4x1ieFMEEfPUc+TUB8eorPq6zNdNyAzIl04LigkNLL3eYJ5nryN8cPp+/c0l7T7gh4d
         dvS7oNd42R5Qco5BpF18DRN/tO3wBHjIcTLCCqfWMep5h3drVoEgJZgzx8BgTvWTjGv6
         iWoA3UG/Pe7zVTznLVgkz043hgsRJ5glZMvlCON65HheZ55cf5N6XebXtVxwPWm3mpJV
         MocqOsJokcMgzOQIIvEyDIafgzBURe9vogeNPnCUUsJDmqPGT9rr8UiKR3HW1MubaqDY
         cFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=8ssRK52MSevAKyQoJxF4jNVc366d3EchjdXo13/rUh0=;
        b=Gm/RNHr/4GNgBbwEjUssP4hhjYLHe2xVuQhRsz5TTXM8rJvbACJRD1jrD5YOxCPaph
         e6zm2wb+GB2XpoFkj7lP3U9ch0ekdEV9yXt1sL03gREuSCllWFij6TN7KKkeTfUe7bkl
         v1OJtxgUHBYfmxdNHNqTYtHP7UqIkl9DPaGijTd2cTu5JHTEpWgSwQ1bQ9KBYwrXQHMl
         xS8OU5xZgKaz0q4lPYGb/Fmc3BgVDz0ipqORmD91I12HyIWoTlw8QSkhcVDv5P32SIZm
         DRn1OFkUjM2K0oC13eSIEulRBBoNc33NppbVYgo/DDxPluh7S1GirHRepRe3KE5BcdU9
         SVVA==
X-Gm-Message-State: AOAM532hNQY7ZVFxzMKCYkuAYuoGkVzLNZp+bcoDXrZT+LT6DRHPgryF
        nXSKNuLKq8ejRtjEbqKWNvE=
X-Google-Smtp-Source: ABdhPJxqJ3swu4BK/xwqLBbP1EzrcjSmkBPGV9E35yiozTOuPnT7dVU6RjahTgXLPTyN8nqdYyzoUw==
X-Received: by 2002:a63:f556:: with SMTP id e22mr23969589pgk.189.1624900467165;
        Mon, 28 Jun 2021 10:14:27 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id u2sm3685754pfh.61.2021.06.28.10.14.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jun 2021 10:14:26 -0700 (PDT)
Subject: Re: [PATCH 0/9] Refactoring exit
To:     Geert Uytterhoeven <geert@linux-m68k.org>
References: <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
 <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
 <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
 <87a6njf0ia.fsf@disp2133>
 <CAHk-=wh4_iMRmWcao6a8kCvR0Hhdrz+M9L+q4Bfcwx9E9D0huw@mail.gmail.com>
 <87tulpbp19.fsf@disp2133>
 <CAHk-=wi_kQAff1yx2ufGRo2zApkvqU8VGn7kgPT-Kv71FTs=AA@mail.gmail.com>
 <87zgvgabw1.fsf@disp2133> <875yy3850g.fsf_-_@disp2133>
 <YNULA+Ff+eB66bcP@zeniv-ca.linux.org.uk>
 <YNj4DItToR8FphxC@zeniv-ca.linux.org.uk>
 <6e283d24-7121-ae7c-d5ad-558f85858a09@gmail.com>
 <CAMuHMdXSU6_98NbC1UWTT_kmwxD=6Ha5LJxFAtbSuD=y78nASg@mail.gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>, Tejun Heo <tj@kernel.org>,
        Kees Cook <keescook@chromium.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <7ad6c3a9-b983-46a5-fc95-f961b636d3fe@gmail.com>
Date:   Tue, 29 Jun 2021 05:14:16 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXSU6_98NbC1UWTT_kmwxD=6Ha5LJxFAtbSuD=y78nASg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Geert,

Am 28.06.2021 um 19:31 schrieb Geert Uytterhoeven:
>> Haven't found that warning in over 7 years' worth of console logs, and
>> I'm a good candidate for running the oldest userland in existence for m68k.
>>
>> Time to let it go.
>
> The warning is printed when using filesys-ELF-2.0.x-1400K-2.gz,
> which is a very old ramdisk from right after the m68k a.out to ELF
> transition:
>
>     warning: process `update' used the obsolete bdflush system call
>     Fix your initscripts?
>
> I still boot it, once in a while.

OK; you take the cake. That ramdisk came to mind when I thought about 
where I'd last seen bdflush, but I've not used it in ages (not sure 14 
MB are enough for that).

The question then is - will bdflush fail gracefully, or spin retrying 
the syscall?

Cheers,

	Michael

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
