Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0A541FD62
	for <lists+linux-arch@lfdr.de>; Sat,  2 Oct 2021 19:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbhJBR1f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 2 Oct 2021 13:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbhJBR0R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Oct 2021 13:26:17 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF939C0613EC;
        Sat,  2 Oct 2021 10:24:31 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id h1so126296pfv.12;
        Sat, 02 Oct 2021 10:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D1bXkBk9YxmebFeA6E0BW5aK15Kg0BQ6ZYq9gHvLf8I=;
        b=bD7c6t/HirAEIz+/PxtC8eGDtvg1LK+3UlvnvIzjRphISe/ujCdscLeEaYSqGdB2cj
         JceH5o9k+buUK9BNbOFXYeSR6DHP8ur+gBgb3eBAUsRAu2yqdnuBuRC/DMXAkD3ty/RE
         BKJFJIER/2X0fKhIho35yK3irtEi8Cr1Ru59ywzHmKOD6NQHYnBqMsP3yYZi6nVszfMo
         yxXeTDn2azo9UfL+g1crhi6VQX939ULcMfw+t4q8pLQ+UwAB9cCtQp0MiV/yoQL4nr1H
         Q17zkMpwJTeP2iFQKAU9BbhXTjeExEr8SMlR20wT94Rx1kUGfpINHmZLFEM6wdRtfFRp
         kbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D1bXkBk9YxmebFeA6E0BW5aK15Kg0BQ6ZYq9gHvLf8I=;
        b=0UNITr5eyIip/TO9bOJ/g/xAAccRGaRr8rjXSU0Ri/IMT0ohCu1F4v73HyVPS8Qhar
         /wbYTbjn5wjS5TcbFzAKf91E+F01plNewRwhw0NHl9DQeq/o3pnNBEgACk93VBLweV0G
         UOmaHVv5gs7WVEqqkg6hO8zD9khevZBIn0/MkWySBEkTb7PPenkBdtTHglwQF91skboq
         v+e+qY3BBn3HwiRkknDTyAKYwIadrSZBoPKVaD6lqeNPIVb0JK499EgLscJaEOHDWCmG
         goWtNgRac2oZoWi7xPgFMnhUpkCwZituc8HXDEuC25p/1whNqf0o4HsK6ZlV+DVj5Lfu
         0iRg==
X-Gm-Message-State: AOAM533ifFVAhrlepNY97KbdqQgdtmk2/NWf5hl4b4XkH7JhpKnVzakH
        s1MoJ51bBrwd6XnxlRmOVuA=
X-Google-Smtp-Source: ABdhPJx5joTF1gNiWd6ZXwTh3t1fPMuPaA4tteEBIL9LThUASubI0TivX6vd9CDwEQL/39E2/PqcBw==
X-Received: by 2002:a63:131f:: with SMTP id i31mr3665877pgl.207.1633195470271;
        Sat, 02 Oct 2021 10:24:30 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id ch7sm10714708pjb.44.2021.10.02.10.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 10:24:29 -0700 (PDT)
Date:   Sat, 2 Oct 2021 10:24:31 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
Subject: Re: [PATCH 03/16] include: move find.h from asm_generic to linux
Message-ID: <YViVz/28pNaGs+Rv@yury-ThinkPad>
References: <20211001181245.228419-1-yury.norov@gmail.com>
 <20211001181245.228419-4-yury.norov@gmail.com>
 <CAMuHMdUbzBBpCvw+44BAEVWtLfXLH_75JUcsUkedyxZYmdwL7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUbzBBpCvw+44BAEVWtLfXLH_75JUcsUkedyxZYmdwL7w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Oct 02, 2021 at 11:23:26AM +0200, Geert Uytterhoeven wrote:
> Hi Yuri,
> 
> Thanks for your patch!
> 
> On Fri, Oct 1, 2021 at 8:12 PM Yury Norov <yury.norov@gmail.com> wrote:
> > find_bit API and bitmap API are closely related, but inclusion paths
> > are different - include/asm-generic and include/linux, correspondingly.
> > In the past it made a lot of troubles due to circular dependencies
> > and/or undefined symbols. Fix this by moving find.h under include/linux.
> 
> .. and including it from include/linux/bitmap.h, like the other helper includes?

yes.

> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> >  arch/m68k/include/asm/bitops.h               |  2 --
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> > --- a/include/linux/bitmap.h
> > +++ b/include/linux/bitmap.h
> > @@ -6,6 +6,7 @@
> >
> >  #include <linux/align.h>
> >  #include <linux/bitops.h>
> > +#include <linux/find.h>
> >  #include <linux/limits.h>
> >  #include <linux/string.h>
> >  #include <linux/types.h>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
