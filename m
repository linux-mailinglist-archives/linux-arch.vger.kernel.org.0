Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDF53EC8AF
	for <lists+linux-arch@lfdr.de>; Sun, 15 Aug 2021 13:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbhHOLKw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 15 Aug 2021 07:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhHOLKv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 15 Aug 2021 07:10:51 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226E7C061764;
        Sun, 15 Aug 2021 04:10:22 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id nt11so22180101pjb.2;
        Sun, 15 Aug 2021 04:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1hTo1UwRlyqp+pMdlXGYPhfq0rOnoJLrck7pYizHgPU=;
        b=ki4MbLSO6ktJBBmJWeAW9iXHb99ZK/NlJzMuyhU1WHgiB1izAuZcFaDxzfK8e5I4GN
         GNd6Ga0s6XH90h8kPCmLzUU1hnM+OEcwApME4miRVOxbrBhnYa4Phm5kgSW8z+yDtdBJ
         hYos1WTb8FiECvf6YO6Ie9c3VDtniCE7hS0VR6AbuIsXJx/aeU8NOKMNkVoR9Qz38BCg
         L42/kNp8yGfmgJwLWJ1n6XsD9Ccr6bDMoD/Qwua2omJgB+pJkyiJsC2qO2bAyKxPgh3S
         N9ykDctPuAiy0lQ/wzrmJIxRPmkVOtIU0B54EJ0s3R2ShftkFCbK/TEbvxqaM99en7C/
         Tvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1hTo1UwRlyqp+pMdlXGYPhfq0rOnoJLrck7pYizHgPU=;
        b=ZsJqVRkDQFisnC/Z5+FUGljpZ31HxTsSGhLYXTmKTsSGsPIocpgzUrTXzwz3Cgue0J
         klFyFrc9oyjrk9KUvQ3iLYjD/qc8thOzpGVHgy81BfHw2xc9k0dNDznYqMdL5FNlmF4j
         OGuPIb9T2+0ef9e/Um7EAkltERkBOoADWyKES1pq+Ctoqy07/zezwonHw1Cd/aqK7UEH
         rN1dweq+tbhfxAgAdfQH/bPhmmmVo50Wa8EorZE/0N9xvg8vO8FjK5hHzd/BAPgGV+DW
         oM4Jy+IRnm/To+Nx+KLL98fZxkyGmYfp+DhkQFkaZIBg7mlbmjqWYN4gNyPhnVygJOFc
         CeWA==
X-Gm-Message-State: AOAM532ihUlwUUnpzaU4hGtO/FaU4dPKbUPXHLFW1eiTr1dQVkzPu2mY
        C6J9a6OH735Rbx9qDTrUWyyXuZV43yYMIx19EUw=
X-Google-Smtp-Source: ABdhPJyX0puTwgDSKe17THJRks86nytntC1/Vm9fFgYZajAdikFyaOpXXy9Bg8UpfdHkE4M8OR1qUHu1CsaKoe3XyEw=
X-Received: by 2002:a17:902:ced0:b029:12d:4ce1:ce3a with SMTP id
 d16-20020a170902ced0b029012d4ce1ce3amr9073769plg.0.1629025821388; Sun, 15 Aug
 2021 04:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210814211713.180533-1-yury.norov@gmail.com> <20210814211713.180533-18-yury.norov@gmail.com>
In-Reply-To: <20210814211713.180533-18-yury.norov@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 15 Aug 2021 14:09:45 +0300
Message-ID: <CAHp75Vcjq-XmX-rikawj+wVwG+V+gXzZPishpanZ79-SGFb8rA@mail.gmail.com>
Subject: Re: [PATCH 17/17] vsprintf: rework bitmap_list_string
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        "open list:VFIO DRIVER" <kvm@vger.kernel.org>,
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
        Geert Uytterhoeven <geert@linux-m68k.org>,
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

On Sun, Aug 15, 2021 at 12:21 AM Yury Norov <yury.norov@gmail.com> wrote:
>
> bitmap_list_string() is very ineffective when printing bitmaps with long
> ranges of set bits because it calls find_next_bit for each bit in the
> bitmap.  We can do better by detecting ranges of set bits.
>
> In my environment, before/after is 943008/31008 ns.

I would add a couple of words, maybe in parentheses, to describe what
your environment is.

...

> +               buf = number(++buf, end, rtop - 1, default_dec_spec);

++buf is a bit confusing here. Since you will rewrite the buf value
anyway, I would write the parameter as buf + 1.

-- 
With Best Regards,
Andy Shevchenko
