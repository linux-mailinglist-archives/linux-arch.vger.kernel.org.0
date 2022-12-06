Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD099644BF7
	for <lists+linux-arch@lfdr.de>; Tue,  6 Dec 2022 19:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiLFSlt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Dec 2022 13:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLFSls (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Dec 2022 13:41:48 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A0F303D9
        for <linux-arch@vger.kernel.org>; Tue,  6 Dec 2022 10:41:47 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id d13so11040712qvj.8
        for <linux-arch@vger.kernel.org>; Tue, 06 Dec 2022 10:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QGDPW0qn4xB9RA6D+u1gKg7b7l81anigG3dz/OOHF2g=;
        b=ggZvjEjKQi2R/wjjDPkKFioUFaKFXL1nm0gNlGGrjxzXjM3owIUwa2ij8Vhl9diYzx
         D7BAn7xwRq50qfTkx29PHUUGQf1gfyQr1++AUM8iGhQQlI7XzulOgG/4PccQmO2nm2nv
         TNyj+WUxy6Ol6xF7Ho6aULUaihzU2JaZdd+us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QGDPW0qn4xB9RA6D+u1gKg7b7l81anigG3dz/OOHF2g=;
        b=qfZY/Gmt5NYsIbxm1HRWPkgkGMX3ppju66faRjhFUYcm6xZzxSVPvtMDgHZXFJOsnA
         VvriTayct0H90NW6sePl9z/oEHNAp3ijNCO8Qu8LrDCb4Bmvp/nMyUCaykDhwTw35M1m
         4s844pIQ9MnRp6jPHqR4qhlxiztjM3L5jCFNShLw22TBHBwuhYjUm41KMCoqZ5pDCLHR
         MygIGehyKEDdMpXS2fTzS+Gtas0GYikXiOMw4DvhI47uhCqcbAdZMNuf8VThFVDClGgs
         S8ZdGHJ4iej4anfrjEPgYlMJM3leCVrHsLu5yx1yu/w+KhpSWU0elQWFm3RpUjl8nsK5
         tSyw==
X-Gm-Message-State: ANoB5pn10dr81+n7bJHMUAH6zhCD7gzZ14c3hKoKvMieyQyCwXzbraN4
        sOPAsC9F77v/qZGpvZC37S58e3RY6pHtpmMM
X-Google-Smtp-Source: AA0mqf5SWLoMZWc1qMOsams4qgeKKcwTXgRRk9eOh+kd0j5i/juOfN2jqNJ2yzF710ZByghpEoqvKA==
X-Received: by 2002:a0c:fe84:0:b0:4c7:2b85:9bd with SMTP id d4-20020a0cfe84000000b004c72b8509bdmr21737167qvs.107.1670352106442;
        Tue, 06 Dec 2022 10:41:46 -0800 (PST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com. [209.85.222.178])
        by smtp.gmail.com with ESMTPSA id f10-20020a05620a408a00b006f474e6a715sm1426141qko.131.2022.12.06.10.41.45
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 10:41:45 -0800 (PST)
Received: by mail-qk1-f178.google.com with SMTP id j26so8212220qki.10
        for <linux-arch@vger.kernel.org>; Tue, 06 Dec 2022 10:41:45 -0800 (PST)
X-Received: by 2002:ae9:e00c:0:b0:6f8:1e47:8422 with SMTP id
 m12-20020ae9e00c000000b006f81e478422mr78525658qkk.72.1670352104706; Tue, 06
 Dec 2022 10:41:44 -0800 (PST)
MIME-Version: 1.0
References: <202212051534.852804af-yujie.liu@intel.com> <CAHk-=wg330wAAxwSaJBPUtL5Rrn7PoQK3ksJw2OLvBxA0NGg+g@mail.gmail.com>
 <87ilipffws.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87ilipffws.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 6 Dec 2022 10:41:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjDzVL+r6NmnU--tyEfDYhUB-5m=PQBZTQ2Es8bx7Mz+w@mail.gmail.com>
Message-ID: <CAHk-=wjDzVL+r6NmnU--tyEfDYhUB-5m=PQBZTQ2Es8bx7Mz+w@mail.gmail.com>
Subject: Re: [linux-next:master] [mm] 5df397dec7: will-it-scale.per_thread_ops
 -53.3% regression
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     kernel test robot <yujie.liu@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch@vger.kernel.org, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 5, 2022 at 6:03 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> >
> > I assume that this test is doing a lot of mmap/munmap on dirty shared
> > memory regions (both because of the regression, and because of the
> > name of that test ;)
>
> I have checked the source code of will-it-scale/page_fault3.  Yes, it
> exactly does that.

Heh. I took a look at that test-case, and yeah, it's just doing a
128MB shared mapping, dirtying it one page at a time, and unmapping it
in a loop.

It doesn't even look like a very good benchmark for that, because the
_first_ time around the loop it does it is very different in that it
has to actually create the file extents.

So that benchmark starts out testing something different than what the
steady state is.

But yeah, that's pretty much the worst possible case for this all, and
yes, I suspect it's more about the TLB batching than anything else.

And I think I see the issue. We actually have a reasonably big batch
size most of the time, but this benchmark triggers that dirty shared
page logic on every page, and that in turn means that we stop batching
immediately - even when we only have the initial tiny on-stack batch.

So instead of batching MAX_GATHER_BATCH pages at a time (roughly 500
pages per go), we end up batching just eight pages (MMU_GATHER_BUNDLE)
at a time.

I didn't think of that degenerate case.

Let me think about this a while, but I think I'll have a patch for you
to test once I've dealt with a couple more pull requests.

                  Linus
