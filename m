Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FA06435F0
	for <lists+linux-arch@lfdr.de>; Mon,  5 Dec 2022 21:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbiLEUoJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Dec 2022 15:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbiLEUn7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Dec 2022 15:43:59 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E111114B
        for <linux-arch@vger.kernel.org>; Mon,  5 Dec 2022 12:43:59 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id o12so9059615qvn.3
        for <linux-arch@vger.kernel.org>; Mon, 05 Dec 2022 12:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBWIRVS47RUmDEcOvPdmfWIVH4IaWi6W1xGhZ6HUIpg=;
        b=VlITxXm5biYw6uI6PPXe3docWzenLdY3/Q/s8bcI84Qeqr5ssGWJZkQFxotM28q3kG
         jidIiH1cGwtjd9ELQ0YAZHqHlktIkQiMXrrnKeMpoCut3nnXF18SB3FqANyHMxvQJoZ2
         pp/50ejXAqt+zzjVTkW2LcaWDW6j/KCOcQPT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBWIRVS47RUmDEcOvPdmfWIVH4IaWi6W1xGhZ6HUIpg=;
        b=PA8aKWrwuPgUnIYjE1pnx/DcGghI4wDI8kHBHDhN/V3nU33Bc7z95F8R7ek/GPvXZG
         xpP8JVP47tvpBT5SXdOgbH9KIKiWXrmb0j+4y7SaejqlQjXMyP1zvY8JhLSX2qMfpCFv
         NcOSZGATK0ONQPAmxAFl+TpRPHDiEb/Y482bTqCTz/FOo2SsPCvSTcQZuiQVks9yedLz
         A/vTiHiGCclScMf2dqgavDfT3rJdnGV8DWk7iXeOLZYBIfEcL5+EwX7Yek6ctZnE3vSM
         0NQPGmzNdsvRwefAjifu71A5QDOzKtQu4KZUNnDOEGSgluHxHSmRjs9pQwg7POPdk5bW
         AMXw==
X-Gm-Message-State: ANoB5pm/93JpddGsmwguVKsCBPPTKc8t+o2/aW/0zLvZ++vLr4sKm+Yn
        tOr7p0FW4DAR7s1R8a26Otcon3jr5cYeYfHE
X-Google-Smtp-Source: AA0mqf7gAYYhWXAq1HDpJPEiqH1WYdtu/O06LOgwi9w5yhhdOvMcQQ8dBWgvncVUM9igO1jnPhRj6g==
X-Received: by 2002:ad4:40c4:0:b0:4c7:5035:41f with SMTP id x4-20020ad440c4000000b004c75035041fmr12286093qvp.95.1670273037892;
        Mon, 05 Dec 2022 12:43:57 -0800 (PST)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id m19-20020a05620a291300b006fa12a74c53sm13373421qkp.61.2022.12.05.12.43.53
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 12:43:54 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id h24so12310422qta.9
        for <linux-arch@vger.kernel.org>; Mon, 05 Dec 2022 12:43:53 -0800 (PST)
X-Received: by 2002:ac8:688:0:b0:3a5:122:fb79 with SMTP id f8-20020ac80688000000b003a50122fb79mr67106155qth.452.1670273033472;
 Mon, 05 Dec 2022 12:43:53 -0800 (PST)
MIME-Version: 1.0
References: <202212051534.852804af-yujie.liu@intel.com>
In-Reply-To: <202212051534.852804af-yujie.liu@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 5 Dec 2022 12:43:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg330wAAxwSaJBPUtL5Rrn7PoQK3ksJw2OLvBxA0NGg+g@mail.gmail.com>
Message-ID: <CAHk-=wg330wAAxwSaJBPUtL5Rrn7PoQK3ksJw2OLvBxA0NGg+g@mail.gmail.com>
Subject: Re: [linux-next:master] [mm] 5df397dec7: will-it-scale.per_thread_ops
 -53.3% regression
To:     kernel test robot <yujie.liu@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 5, 2022 at 1:02 AM kernel test robot <yujie.liu@intel.com> wrot=
e:
>
> FYI, we noticed a -53.3% regression of will-it-scale.per_thread_ops due t=
o commit:
> 5df397dec7c4 ("mm: delay page_remove_rmap() until after the TLB has been =
flushed")

Sadly, I think this may be at least partially expected.

The code fundamentally moves one "loop over pages" and splits it up
(with the TLB flush in between).

Which can't be great for locality, but it's kind of fundamental for
the fix - but some of it might be due to the batch limit logic.

I wouldn't have expected it to actually show up in any real loads, but:

> in testcase: will-it-scale
>         test: page_fault3

I assume that this test is doing a lot of mmap/munmap on dirty shared
memory regions (both because of the regression, and because of the
name of that test ;)

So this is hopefully an extreme case.

Now, it's likely that this particular case probably also triggers that

        /* No more batching if we have delayed rmaps pending */

which means that the loops in between the TLB flushes will be smaller,
since we don't batch up as many pages as we used to before we force a
TLB (and rmap) flush and free them.

If it's due to that batching issue it may be fixable - I'll think
about this some more, but

> Details are as below:

The bug it fixes ends up meaning that we run that rmap removal code
_after_ the TLB flush, and it looks like this (probably combined with
the batching limit) then causes some nasty iTLB load issues:

>    2291312 =C4=85  2%   +1452.8%   35580378 =C4=85  4%  perf-stat.i.iTLB-=
loads

although it also does look like it's at least partly due to some irq
timing issue (and/or bad NUMA/CPU migration luck):

>    388169          +267.4%    1426305 =C4=85  6%  vmstat.system.in
>     161.37           +84.9%     298.43 =C4=85  6%  perf-stat.ps.cpu-migra=
tions
>    172442 =C4=85  4%     +26.9%     218745 =C4=85  8%  perf-stat.ps.node-=
load-misses

so it might be that some of the regression comes down to "bad luck" -
it happened to run really nicely on that particular machine, and then
the timing changes caused some random "phase change" to the load.

The profile doesn't actually seem to show all that much more IPI
overhead, so maybe these incidental issues are what then causes that
big regression.

It would be lovely to hear if you see this on other machines and/or loads.

Because if it's a one-off, it's probably best ignored. If it shows up
elsewhere, I think that batching logic might need looking at.

               Linus
