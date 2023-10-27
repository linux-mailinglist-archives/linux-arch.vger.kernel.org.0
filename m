Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054FD7D9CEB
	for <lists+linux-arch@lfdr.de>; Fri, 27 Oct 2023 17:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjJ0P2Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Oct 2023 11:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjJ0P2Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Oct 2023 11:28:24 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CA318A
        for <linux-arch@vger.kernel.org>; Fri, 27 Oct 2023 08:28:21 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c5056059e0so32911341fa.3
        for <linux-arch@vger.kernel.org>; Fri, 27 Oct 2023 08:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698420500; x=1699025300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNsl5MInPLJ8RSTN609h9x1G8bOqBML3/WHWrkX2PGU=;
        b=iRNlwOt/QoKpaCq6XxLrF0wXdv5Jy1DZzQLa+O9FPjAtqhZHpeAsOBBOnJUEpUoHkb
         jPBdwRVtq7uhfs1DnIMszqyK6ZuqHjlFPbYx6F8YhmKaa9d2zoGdydpWBd8gwTHkktic
         h+lkMhvRcnwrq1roygwA6d4kVZkWsM8uDzIi5CB1yiBEqlBb7pncDjXeH/gs9oCCyak3
         oc9GtNzTYGaLv+TTk8G3rKDwbJe+oiQw+X5kMmqLa+J3gvhrUMxO+Auy7P8vDQNE8qIj
         WNSgZwSxNbvGOF2bWDisnIHP2Yg9nYLvMAfQ6SjzR8dfplstJXuPBV34aoocJw3/k/hj
         YKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698420500; x=1699025300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNsl5MInPLJ8RSTN609h9x1G8bOqBML3/WHWrkX2PGU=;
        b=QCHblCNPDXPyh8rXo/ZA1bGEveOfJeH9DG4weQvZKoohTUqeApczJQkmBmnRUUyOmj
         vnr+Ryt9O8ScgwhgbMWCdWH4FIcf1NkhLDr9ZWZApw6LkDRXgVixXvY4DfdIDH5c4EgV
         JnapnXqyzNTIYbPUBUQEXOfz5ZpjO7ppPgFKdkH7vfzLR4SBL5juJOh/Kot+RsAAjuf8
         7PT0M5WbXW2Avvv4LICi6MIH9Yzk1SEpVJxLky0m5XqJcfp8MaLM77BQTtxRnzGfEEuz
         7xLBavjSFLoqZJq/u8E0c71uDtCkJFTqy9nBsmtQY/WRt1zYhsamgAxbRLQ7DKSDXQRH
         jrQA==
X-Gm-Message-State: AOJu0YxyowOQunlK2F3+2awXHrlHU/NMsTg94+/evDQvpKWSu5Yx3PvE
        9ojRAOrUBz6V9alsjDv2ZvWH++acUbFp6SbhdIhUTw==
X-Google-Smtp-Source: AGHT+IHhztclk1FNuTavfV09vRrRQcRnx6lXYSGYBX+I6vgMiVsYpEDbYR5+xRzUeW2IFeyne8V1kWZ8Fus2muopy04=
X-Received: by 2002:a05:651c:1070:b0:2c5:47f:8ff7 with SMTP id
 y16-20020a05651c107000b002c5047f8ff7mr2161033ljm.18.1698420499387; Fri, 27
 Oct 2023 08:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com> <20231024134637.3120277-29-surenb@google.com>
 <87h6me620j.ffs@tglx> <CAJuCfpH1pG513-FUE_28MfJ7xbX=9O-auYUjkxKLmtve_6rRAw@mail.gmail.com>
 <87jzr93rxv.ffs@tglx> <20231026235433.yuvxf7opxg74ncmd@moria.home.lan> <b20fe713-28c6-4ca8-b64a-df017f161524@app.fastmail.com>
In-Reply-To: <b20fe713-28c6-4ca8-b64a-df017f161524@app.fastmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 27 Oct 2023 08:28:08 -0700
Message-ID: <CAKwvOdnKwGnxZnnDW-miaUO+M5AN_Np1A0fmj18Mz1AV2aQPzg@mail.gmail.com>
Subject: Re: [PATCH v2 28/39] timekeeping: Fix a circular include dependency
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Thomas Gleixner <tglx@linutronix.de>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Mel Gorman <mgorman@suse.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>, void@manifault.com,
        Peter Zijlstra <peterz@infradead.org>, juri.lelli@redhat.com,
        ldufour@linux.ibm.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        peterx@redhat.com, David Hildenbrand <david@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, dennis@kernel.org,
        Tejun Heo <tj@kernel.org>, Muchun Song <muchun.song@linux.dev>,
        Mike Rapoport <rppt@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, pasha.tatashin@soleen.com,
        yosryahmed@google.com, Yu Zhao <yuzhao@google.com>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Kees Cook <keescook@chromium.org>, vvvvvv@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Biggers <ebiggers@google.com>, ytcoode@gmail.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        bsegall@google.com, bristot@redhat.com, vschneid@redhat.com,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Jason Baron <jbaron@akamai.com>,
        David Rientjes <rientjes@google.com>, minchan@google.com,
        kaleshsingh@google.com, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 26, 2023 at 11:35=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> On Fri, Oct 27, 2023, at 01:54, Kent Overstreet wrote:
> > On Fri, Oct 27, 2023 at 01:05:48AM +0200, Thomas Gleixner wrote:
> >> On Thu, Oct 26 2023 at 18:33, Suren Baghdasaryan wrote:
> >> > On Wed, Oct 25, 2023 at 5:33=E2=80=AFPM Thomas Gleixner <tglx@linutr=
onix.de> wrote:
> >> >> > This avoids a circular header dependency in an upcoming patch by =
only
> >> >> > making hrtimer.h depend on percpu-defs.h
> >> >>
> >> >> What's the actual dependency problem?
> >> >
> >> > Sorry for the delay.
> >> > When we instrument per-cpu allocations in [1] we need to include
> >> > sched.h in percpu.h to be able to use alloc_tag_save(). sched.h
> >>
> >> Including sched.h in percpu.h is fundamentally wrong as sched.h is the
> >> initial place of all header recursions.
> >>
> >> There is a reason why a lot of funtionalitiy has been split out of
> >> sched.h into seperate headers over time in order to avoid that.
> >
> > Yeah, it's definitely unfortunate. The issue here is that
> > alloc_tag_save() needs task_struct - we have to pull that in for
> > alloc_tag_save() to be inline, which we really want.
> >
> > What if we moved task_struct to its own dedicated header? That might be
> > good to do anyways...
>
> Yes, I agree that is the best way to handle it. I've prototyped
> a more thorough header cleanup with good results (much improved
> build speed) in the past, and most of the work to get there is
> to seperate out structures like task_struct, mm_struct, net_device,
> etc into headers that only depend on the embedded structure
> definitions without needing all the inline functions associated
> with them.

This is something I'll add to our automation todos which I plan to
talk about at plumbers; I feel like it should be possible to write a
script that given a header and identifier can split whatever
declaration out into a new header, update the old header, then add the
necessary includes for the newly created header to each dependent
(optional).
--=20
Thanks,
~Nick Desaulniers
