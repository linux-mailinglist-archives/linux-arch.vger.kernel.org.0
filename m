Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B3B3EF03E
	for <lists+linux-arch@lfdr.de>; Tue, 17 Aug 2021 18:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhHQQgE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Aug 2021 12:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhHQQgE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 Aug 2021 12:36:04 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18002C061764;
        Tue, 17 Aug 2021 09:35:31 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 14so23742356qkc.4;
        Tue, 17 Aug 2021 09:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X66JXd8TkYUtNgpL3dedMaEApQt+UVVwJJYfA0n1YPg=;
        b=g4zglayFs+OL2K1Tv5FWDo95NGXXY+tGDfEDov2cEemXLUcWHxppV7kaJhjKlxcOrQ
         oHuvXm/1NLEueeijcc4k/pdxM6Mcwr6Rl3B3D7wFZy2ccLhUt4vZeoQJfZfhrPomyELx
         GW+C0UiShHbqj3n/zGjS26Xwp4uQ61Z7LoZVhXIKdcRcj7Sdhe8A3DrLEAc6nInsJUvl
         dp18hI9oI9+JlQYtUPxQqvz7toBSYsOVPi7y9JftNaV8NSLYZ/DiplGaFcbmP3J6IdzX
         /fxmtbTG72QjQmjUz5DePLa7WUGZoqPqI4I9C2Rmp2XHKrgJhxvGhIuRvnmdts6lZMbP
         wyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X66JXd8TkYUtNgpL3dedMaEApQt+UVVwJJYfA0n1YPg=;
        b=ORjTzeyqPQaBh0uyn/NC4C11EiCihBNYaSnvbWaI3sZQyf9ShRgJVwEjVds14wz3V6
         bjLG59W9LjVl7sUP2IKiBvfWNyIHGm3/gpLjPOHLUc+qDCIFFxAnsWMJdB++PmU0biqd
         LKP0CPophlzLhDJQr/NRlmbEkSjU3WqkBxvOD0KmLZy8DsB2edlqEKWIosv86ABN4oKI
         /C7mH3XPmxATKG3TQFjs7uByl9RaZQMmUVaZHsCIUYspcYq3CN0kOCmxofE6mQKrLeZJ
         0Cbeows5P4GXGtStvw1AiyaADxyLdDAErZcc1Tvd/f1c7iYpOJwVF+mu8Pvozh1vcw9E
         jd/w==
X-Gm-Message-State: AOAM531rb4r/Ekcks2FQRMUOyDUsxUn+jJ+bcvVZ6cFP3WszGxkusO2d
        w371uGSeD4bH5SavYYwAsHY=
X-Google-Smtp-Source: ABdhPJy2J9eIa9r5vu8RSDOAqKg1RDnXqD3PiG96WXh1xZ4GPhHRSNuK2PyNoYNfQalFqu4qZofQxQ==
X-Received: by 2002:a37:d54:: with SMTP id 81mr4580109qkn.103.1629218130100;
        Tue, 17 Aug 2021 09:35:30 -0700 (PDT)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id k8sm1584346qkk.96.2021.08.17.09.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 09:35:29 -0700 (PDT)
Date:   Tue, 17 Aug 2021 09:35:28 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
Subject: Re: [PATCH 17/17] vsprintf: rework bitmap_list_string
Message-ID: <YRvlUO87e7czAico@yury-ThinkPad>
References: <20210814211713.180533-1-yury.norov@gmail.com>
 <20210814211713.180533-18-yury.norov@gmail.com>
 <CAHp75Vcjq-XmX-rikawj+wVwG+V+gXzZPishpanZ79-SGFb8rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vcjq-XmX-rikawj+wVwG+V+gXzZPishpanZ79-SGFb8rA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Aug 15, 2021 at 02:09:45PM +0300, Andy Shevchenko wrote:
> On Sun, Aug 15, 2021 at 12:21 AM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > bitmap_list_string() is very ineffective when printing bitmaps with long
> > ranges of set bits because it calls find_next_bit for each bit in the
> > bitmap.  We can do better by detecting ranges of set bits.
> >
> > In my environment, before/after is 943008/31008 ns.
> 
> I would add a couple of words, maybe in parentheses, to describe what
> your environment is.
> 
> ...
> 
> > +               buf = number(++buf, end, rtop - 1, default_dec_spec);
> 
> ++buf is a bit confusing here. Since you will rewrite the buf value
> anyway, I would write the parameter as buf + 1.

Agree, it's sloppy. I'll  send the patch by tomorrow.
