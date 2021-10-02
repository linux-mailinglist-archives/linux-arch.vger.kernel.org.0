Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E1141FA9A
	for <lists+linux-arch@lfdr.de>; Sat,  2 Oct 2021 11:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbhJBJ1G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 2 Oct 2021 05:27:06 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:35694 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbhJBJZX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Oct 2021 05:25:23 -0400
Received: by mail-vs1-f54.google.com with SMTP id f18so14116319vsp.2;
        Sat, 02 Oct 2021 02:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lj27fX+w/X1fzAaixWVl+EMSmBzqib+t1AvqNPW0Qfo=;
        b=eQ7Xi9BjwHarBUNbWz9NkWr+Fq1PS//jsakctwN1H55+6xYfn/5LXwsCHrYFZTnUcN
         mwY9NJ2FfvWu3wmzbKuXrU4cXn5mqLsTR+efLwMLgNDEMAWvHqEkC1Ik1WFbgAvIz2Gx
         JuEmKDTYxqlB2l312wzigYfwJemW5sYFhCM0NfF9vpNfGv0hzOSF9UNhjuEdtnXfk9yU
         +JV7vk5s/EldK0mGmu9saoMP1nnYXQ8OPZdp5na8Mvyp8T5XCGp8apmtWP8pJ3+9C2/p
         Oz2qn2Q2SE80s6k8HBIQ6iGYUF6tBC1YlRtYk+B5o1q8F2GiFLEMTWrTF/w9WIiGgS8A
         0qxw==
X-Gm-Message-State: AOAM532FJKaFkA2ueioqhCgwtr7GJs9sIsBrPlBln+xYP93w8czVziVJ
        p4hIiGc02j1P9w0wLDl2qshMRPZ42IoTmnUuAeg=
X-Google-Smtp-Source: ABdhPJyIkTe18axoKGGfe6/riaB8UL54KfoHPvrebxDva0p8GQNYtsCXNMqktxYUF4cWRNiUDZV6LfcDHAZk9sL3kO8=
X-Received: by 2002:a67:c295:: with SMTP id k21mr5066492vsj.37.1633166617532;
 Sat, 02 Oct 2021 02:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211001181245.228419-1-yury.norov@gmail.com> <20211001181245.228419-4-yury.norov@gmail.com>
In-Reply-To: <20211001181245.228419-4-yury.norov@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 2 Oct 2021 11:23:26 +0200
Message-ID: <CAMuHMdUbzBBpCvw+44BAEVWtLfXLH_75JUcsUkedyxZYmdwL7w@mail.gmail.com>
Subject: Re: [PATCH 03/16] include: move find.h from asm_generic to linux
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, KVM list <kvm@vger.kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Ben Gardon <bgardon@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brian Cain <bcain@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Dennis Zhou <dennis@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Joe Perches <joe@perches.com>, Jonas Bonn <jonas@southpole.se>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rich Felker <dalias@libc.org>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Sean Christopherson <seanjc@google.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Yuri,

Thanks for your patch!

On Fri, Oct 1, 2021 at 8:12 PM Yury Norov <yury.norov@gmail.com> wrote:
> find_bit API and bitmap API are closely related, but inclusion paths
> are different - include/asm-generic and include/linux, correspondingly.
> In the past it made a lot of troubles due to circular dependencies
> and/or undefined symbols. Fix this by moving find.h under include/linux.

.. and including it from include/linux/bitmap.h, like the other helper includes?

> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

>  arch/m68k/include/asm/bitops.h               |  2 --

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -6,6 +6,7 @@
>
>  #include <linux/align.h>
>  #include <linux/bitops.h>
> +#include <linux/find.h>
>  #include <linux/limits.h>
>  #include <linux/string.h>
>  #include <linux/types.h>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
