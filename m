Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B983FB9EF
	for <lists+linux-arch@lfdr.de>; Mon, 30 Aug 2021 18:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237785AbhH3QQC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Aug 2021 12:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237684AbhH3QQB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Aug 2021 12:16:01 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38C1C061575;
        Mon, 30 Aug 2021 09:15:07 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id y3so16671165ilm.6;
        Mon, 30 Aug 2021 09:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GhKUe4sY5cAgiX1Wxl3GBHv3n5YxRNpzvVmXtwnuGY4=;
        b=lZ5JIDAIvMH1bn0GyyIwGJzjkKJly2L1NnX7D03RF5pWTooEsBq35Rwz2vDXePVYxV
         ySrNPRN1A85RbqzGt2hnt9ebYCHdZ8dRFmITuOygDl0nR/FiHp9Osw8JXTHzSbWoiRvf
         mq/yeCc4uLU1N0KwCF87Zk0ABXOK82p4zfov8FzE8WiYgx3RcO1Wo4rY9oMQyoE2PejT
         kfu8hy0Jd4fcm3VPyrUIPuP7AUGeSnhN3C3mUd8+6ZfMYzLEYxDXMjc6QHc/Gbp087p+
         sm0ktT40qSU7fbxjZHqlC3UE3V44VhLnM5Aj3jMnyc4jRD6C4Z1xDAbJTemyB2iano1O
         QLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GhKUe4sY5cAgiX1Wxl3GBHv3n5YxRNpzvVmXtwnuGY4=;
        b=SlpTobIzprQ/7avnKA5EZp7hmeBQ6Qgv4F4qKXQAnh3VRmDx1sN9rCZ41cCd9/Sz7L
         Oc427/GW6c+w5ShGYa/3U+8MBwWJkyzOW5KKBoeS6JETNhagcrwNK9a/MVUj4+U4VczU
         eLJun5EGjgZt0kL9Vm8wGGDchILnG28nIpsPdVazuStJHvLW6ZjGe5G3GBb/AYKPd0C1
         KbhFE6Ndm/KTot3JxBd363TRyxM4wAfhLGPQ60e1O4PeC7ov3pxLCZYffXRgBgRzWbVn
         W8DsaDa7O0kWSHAfKB5krV3hwomRin5R7wQCVFkXG/y+Eubx91SQ6VTiSca36KbReYNY
         2bLg==
X-Gm-Message-State: AOAM530AWYfnl5kw7ZQpZO9JnL+kLUCfDPvSte1evM+bYFwPV7PQTIaC
        MaI+WNV3JfHa1Aql4RI7zwA=
X-Google-Smtp-Source: ABdhPJwxkbCyha7cYpvLZzKHL2Lfna1L4W4YWJVKcyWABsDUOERWY9jkBV1Blkt6UoLPnMuuz4Q21w==
X-Received: by 2002:a92:c8c4:: with SMTP id c4mr13278453ilq.137.1630340107235;
        Mon, 30 Aug 2021 09:15:07 -0700 (PDT)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id f17sm8267384ion.51.2021.08.30.09.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 09:15:06 -0700 (PDT)
Date:   Mon, 30 Aug 2021 09:15:05 -0700
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
Message-ID: <YS0ECS2Lb4rwqJ4b@yury-ThinkPad>
References: <20210814211713.180533-1-yury.norov@gmail.com>
 <20210814211713.180533-12-yury.norov@gmail.com>
 <YSeduU41Ef568xhS@alley>
 <YSgDI9NpC51GhB/2@yury-ThinkPad>
 <20210830121249.2fgyvf47py2tz5s5@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830121249.2fgyvf47py2tz5s5@pathway.suse.cz>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 30, 2021 at 02:12:49PM +0200, Petr Mladek wrote:
> On Thu 2021-08-26 14:09:55, Yury Norov wrote:
> > On Thu, Aug 26, 2021 at 03:57:13PM +0200, Petr Mladek wrote:
> > > On Sat 2021-08-14 14:17:07, Yury Norov wrote:
> > > > The macros iterate thru all set/clear bits in a bitmap. They search a
> > > > first bit using find_first_bit(), and the rest bits using find_next_bit().
> > > > 
> > > > Since find_next_bit() is called shortly after find_first_bit(), we can
> > > > save few lines of I-cache by not using find_first_bit().
> > > 
> > > Is this only a speculation or does it fix a real performance problem?
> > > 
> > > The macro is used like:
> > > 
> > > 	for_each_set_bit(bit, addr, size) {
> > > 		fn(bit);
> > > 	}
> > > 
> > > IMHO, the micro-opimization does not help when fn() is non-trivial.
> >  
> > The effect is measurable:
> > 
> > Start testing for_each_bit()
> > for_each_set_bit:                15296 ns,   1000 iterations
> > for_each_set_bit_from:           15225 ns,   1000 iterations
> > 
> > Start testing for_each_bit() with cash flushing
> > for_each_set_bit:               547626 ns,   1000 iterations
> > for_each_set_bit_from:          497899 ns,   1000 iterations
> > 
> > Refer this:
> > 
> > https://www.mail-archive.com/dri-devel@lists.freedesktop.org/msg356151.html
> 
> I see. The results look convincing on the first look.
> 
> But I am still not sure. This patch is basically contradicting many
> other patches from this patchset:
> 
>   + 5th patch optimizes find_first_and_bit() and proves that it is
>     much faster:
> 
>     Before (#define find_first_and_bit(...) find_next_and_bit(..., 0):
>     Start testing find_bit() with random-filled bitmap
>     [  140.291468] find_first_and_bit:           46890919 ns,  32671 iterations
>     Start testing find_bit() with sparse bitmap
>     [  140.295028] find_first_and_bit:               7103 ns,      1 iterations
> 
>     After:
>     Start testing find_bit() with random-filled bitmap
>     [  162.574907] find_first_and_bit:           25045813 ns,  32846 iterations
>     Start testing find_bit() with sparse bitmap
>     [  162.578458] find_first_and_bit:               4900 ns,      1 iterations
> 
>        => saves 46% in random bitmap
> 	  saves 31% in sparse bitmap
> 
> 
>   + 6th, 7th, and 9th patch makes the code use find_first_bit()
>     because it is faster than find_next_bit(mask, size, 0);
> 
>   + Now, 11th (this) patch replaces find_first_bit() with
>     find_next_bit(mask, size, 0) because find_first_bit()
>     makes things slower. It is suspicious at minimum.
> 
> 
> By other words. The I-cache could safe 10% in one case.
> But find_first_bit() might safe 46% in random case.

Those are different cases. find_first_bit() is approximately twice
faster than find_next_bit, and much smaller. The conclusion is simple:
use 'first' version whenever possible if there's no other considerations.

In case of for_each_bit() macros, however, we have such a consideration.
In contrast to regular pattern, where user calls either first, or next
versions N times, here we call find_first_bit once, and then find_next_bit
N-1 times.

Because we know for sure that we'll call find_next_bit shortly, we can
benefit from locality under heavy pressure on I-cache, if replace 'first'
with 'next'. Consider it as a prefetch mechanism for the following calls
to find_next_bit().

> Does I-cache cost more than the faster code?
 
In this case cache miss is more expensive.

> Or was for_each_set_bit() tested only with a bitmap
> where find_first_bit() optimization did not help much?

I tried to ensure that the effect of I-cache is real and in this case
more important than code performance, so in the test I called 'first'
once and 'next' twice.

> How would for_each_set_bit() work with random bitmap?

It would work for all bitmaps.

> How does it work with larger bitmaps?

Percentage gain (but not absolute) will decrease proportionally to the
number of calls of find_next_bit() for big N.

Thanks,
Yury

> Best Regards,
> Petr
