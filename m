Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFA23F8FFF
	for <lists+linux-arch@lfdr.de>; Thu, 26 Aug 2021 23:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243612AbhHZVKr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Aug 2021 17:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243577AbhHZVKq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Aug 2021 17:10:46 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97356C061757;
        Thu, 26 Aug 2021 14:09:58 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id 22so5027623qkg.2;
        Thu, 26 Aug 2021 14:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ndtmO1/QxMT8WfX0l7kvhRXiSBeQRVJld2PoPckI1O0=;
        b=rXkpoN+AxZC8JOkn4R8K9c+mS84OMQ1t83JbZhfjYcI75ANkLuquiypDrnp6s06y4I
         NPluMkYca+r77CJWNzrc6f9U4ud4kyXphYA+f1Z5i3sj5A67I2KVW7XMYbANrSrvNeug
         AXEO1RvjRD9vlxYBKA66P+G1lIN48rj840wiRhKemSqTzWsckMEASoZJXD1f/rAaSq+q
         4EwzIgRtp08+jezv5v4uFoI2T4EFS19SAExLi8M3OLwn0bNz8oPOwq/p73iAAEyEo2/9
         NFstchfvGDpACwhniUvMd14JxputDzfRaHh8vadNNfyRCFm09A2zMbDHXzY48P6KZLGQ
         euLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ndtmO1/QxMT8WfX0l7kvhRXiSBeQRVJld2PoPckI1O0=;
        b=HMbCouOVtu2xaoA5Zhl/F7PHiJjgy0S0Ut4CFVm+qVWZySI4o1OY4w2sj1oaWvcU9o
         VjjdDD5MaCB1Y+VDzw4JRgzp7DMi5bDP36ALVL1FBWRhBWMLy1EFw4/27UNlglEr15gB
         2z7K06LAGUDEB8z7wyna0HbAPRqDC3tvn54ylwJYTfFtHM/A0XkWgEsXZcwL6qULrdQB
         y2pHAa0Bew3JfLcqVMFJNep1ZAYZIiI0fxbT3b5yCt/Jv6eNgueyt4KUGKl+l1u/mGeG
         qMcRRGoEAU7GZ2WV1eoS2s2qlRhKrkqdTV1OPv1vfdUPUK8Q8ZAO6WzltvO4xkegmDQr
         9RBA==
X-Gm-Message-State: AOAM530Rpjl3s7ehPbdfR8LW+nhDcIIu0aiWxaaxEcfKRc6OTvX2GWMp
        YmOd5WngB+RdM+LzhI9ngmM=
X-Google-Smtp-Source: ABdhPJyNBmR/3pzA2dXFXq9JJ0G8eGCHjShTKLd/3ctVIJ403sMS9vArXoGYUj4XusUtSX1cbXxkww==
X-Received: by 2002:a37:de15:: with SMTP id h21mr5971229qkj.124.1630012197581;
        Thu, 26 Aug 2021 14:09:57 -0700 (PDT)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id r128sm3373281qke.98.2021.08.26.14.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 14:09:56 -0700 (PDT)
Date:   Thu, 26 Aug 2021 14:09:55 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kvm@vger.kernel.org,
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
Subject: Re: [PATCH 11/17] find: micro-optimize for_each_{set,clear}_bit()
Message-ID: <YSgDI9NpC51GhB/2@yury-ThinkPad>
References: <20210814211713.180533-1-yury.norov@gmail.com>
 <20210814211713.180533-12-yury.norov@gmail.com>
 <YSeduU41Ef568xhS@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSeduU41Ef568xhS@alley>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 26, 2021 at 03:57:13PM +0200, Petr Mladek wrote:
> On Sat 2021-08-14 14:17:07, Yury Norov wrote:
> > The macros iterate thru all set/clear bits in a bitmap. They search a
> > first bit using find_first_bit(), and the rest bits using find_next_bit().
> > 
> > Since find_next_bit() is called shortly after find_first_bit(), we can
> > save few lines of I-cache by not using find_first_bit().
> 
> Is this only a speculation or does it fix a real performance problem?
> 
> The macro is used like:
> 
> 	for_each_set_bit(bit, addr, size) {
> 		fn(bit);
> 	}
> 
> IMHO, the micro-opimization does not help when fn() is non-trivial.
 
The effect is measurable:

Start testing for_each_bit()
for_each_set_bit:                15296 ns,   1000 iterations
for_each_set_bit_from:           15225 ns,   1000 iterations

Start testing for_each_bit() with cash flushing
for_each_set_bit:               547626 ns,   1000 iterations
for_each_set_bit_from:          497899 ns,   1000 iterations

Refer this:

https://www.mail-archive.com/dri-devel@lists.freedesktop.org/msg356151.html

Thanks,
Yury
 
> > --- a/include/linux/find.h
> > +++ b/include/linux/find.h
> > @@ -280,7 +280,7 @@ unsigned long find_next_bit_le(const void *addr, unsigned
> >  #endif
> >  
> >  #define for_each_set_bit(bit, addr, size) \
> > -	for ((bit) = find_first_bit((addr), (size));		\
> > +	for ((bit) = find_next_bit((addr), (size), 0);		\
> >  	     (bit) < (size);					\
> >  	     (bit) = find_next_bit((addr), (size), (bit) + 1))
> >  
> 
> It is not a big deal. I just think that the original code is slightly
> more self-explaining.
> 
> Best Regards,
> Petr
