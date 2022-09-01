Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42925AA03B
	for <lists+linux-arch@lfdr.de>; Thu,  1 Sep 2022 21:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbiIATj1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Sep 2022 15:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbiIATjZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Sep 2022 15:39:25 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A089A992
        for <linux-arch@vger.kernel.org>; Thu,  1 Sep 2022 12:39:23 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-340f82c77baso231681707b3.1
        for <linux-arch@vger.kernel.org>; Thu, 01 Sep 2022 12:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=rw5PRlxl7tO0yi2f42RcudRuneYpC4HLzAgnvXZWG5E=;
        b=lG3CtwEra2JQqN/veO23yk3cgaTJHFCiebuuRZY/xNehRm+m0fM4bIsWwBppGA+dxf
         mGwrLGImeNf4NmD+qiiJAgJrRcvEAfMmmsjPutkxq2y7CzoFE7qGuyTBDkwrYwo0ghp+
         DIdTURnQpZf4mS51OcBm4/JauLAis6X1OUJhsFMZ1Eii1uGdRpU21Q08G5BpjTO5hJLN
         9L5Fsbu9o5yfqdUojSVuS9kjs1tQfCEVguOYiQkyDJxdrNwv3a8BIeLV7PQsB1938bTI
         TTsL41uELqXnesIe6dBtowmfUnvD7Y1/Zc9uEXdIILlsmZXFDiVnDH9hCWWOHKwToPd1
         MnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=rw5PRlxl7tO0yi2f42RcudRuneYpC4HLzAgnvXZWG5E=;
        b=XUI9Y8C73xXs7Hq3t8jwbm80blSJh8ll4NasBckVh0T2w/4K2nfkGsR6HRPhFEUloP
         1AXKZEzeflp8EaMAsDxSKCyQrIhCl0GZodLoF0K77CufuEVm3OGI5Otge1yDpVUZOZTC
         tdKSmjXVi0TVwOy3jGAVdnKYD0F9hJTsYSF4D/DL384DeRWr72T0/NF9zevWlapBlTl1
         8g9DMWTzhgDJ/390DAFUV3N8QhRuEmNu51tIqDqCMU3pAPWU5J5vNw9fn9hdel+e2/g8
         NujEqRjDfKuoryADRh2THYSTHx/lib0x5lZ9un0ypZR24O2luhye3vZhZVBfQTGuJHuc
         9iNA==
X-Gm-Message-State: ACgBeo366ult/I9oe09yRAr79u5wmKE/rLI+/W3w3STB5Dqmwl7Xbkkt
        Sket+ATMPLu7KU/xQ9esImq5JPHVRhp00ZwWU9rKRQ==
X-Google-Smtp-Source: AA6agR43mbcplTcd3Q6E6SWUR/a0QzgezQxqYw6L8vriq8koQ7chGwVsb4h58VmaT16qZLx9mcJbzjGRj/xFE0GH57Q=
X-Received: by 2002:a0d:d850:0:b0:340:d2c0:b022 with SMTP id
 a77-20020a0dd850000000b00340d2c0b022mr21758237ywe.469.1662061162404; Thu, 01
 Sep 2022 12:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220830214919.53220-1-surenb@google.com> <Yw8P8xZ4zqu121xL@hirez.programming.kicks-ass.net>
 <20220831084230.3ti3vitrzhzsu3fs@moria.home.lan> <20220831101948.f3etturccmp5ovkl@suse.de>
 <Yw88RFuBgc7yFYxA@dhcp22.suse.cz> <20220831190154.qdlsxfamans3ya5j@moria.home.lan>
 <YxBc1xuGbB36f8zC@dhcp22.suse.cz> <CAJuCfpGhwPFYdkOLjwwD4ra9JxPqq1T5d1jd41Jy3LJnVnhNdg@mail.gmail.com>
 <YxEE1vOwRPdzKxoq@dhcp22.suse.cz>
In-Reply-To: <YxEE1vOwRPdzKxoq@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 1 Sep 2022 12:39:11 -0700
Message-ID: <CAJuCfpHuzJGTA_-m0Jfawc7LgJLt4GztUUY4K9N9-7bFqJuXnw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/30] Code tagging framework and applications
To:     Michal Hocko <mhocko@suse.com>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        David Vernet <void@manifault.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, mcgrof@kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, changbin.du@intel.com,
        ytcoode@gmail.com, Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Christopher Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, 42.hyeyoo@gmail.com,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>, arnd@arndb.de,
        jbaron@akamai.com, David Rientjes <rientjes@google.com>,
        Minchan Kim <minchan@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        kernel-team <kernel-team@android.com>,
        linux-mm <linux-mm@kvack.org>, iommu@lists.linux.dev,
        kasan-dev@googlegroups.com, io-uring@vger.kernel.org,
        linux-arch@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-bcache@vger.kernel.org, linux-modules@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 1, 2022 at 12:15 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 01-09-22 08:33:19, Suren Baghdasaryan wrote:
> > On Thu, Sep 1, 2022 at 12:18 AM Michal Hocko <mhocko@suse.com> wrote:
> [...]
> > > So I find Peter's question completely appropriate while your response to
> > > that not so much! Maybe ftrace is not the right tool for the intented
> > > job. Maybe there are other ways and it would be really great to show
> > > that those have been evaluated and they are not suitable for a), b) and
> > > c) reasons.
> >
> > That's fair.
> > For memory tracking I looked into using kmemleak and page_owner which
> > can't match the required functionality at an overhead acceptable for
> > production and pre-production testing environments.
>
> Being more specific would be really helpful. Especially when your cover
> letter suggests that you rely on page_owner/memcg metadata as well to
> match allocation and their freeing parts.

kmemleak is known to be slow and it's even documented [1], so I hope I
can skip that part. For page_owner to provide the comparable
information we would have to capture the call stacks for all page
allocations unlike our proposal which allows to do that selectively
for specific call sites. I'll post the overhead numbers of call stack
capturing once I'm finished with profiling the latest code, hopefully
sometime tomorrow, in the worst case after the long weekend.

>
> > traces + BPF I
> > haven't evaluated myself but heard from other members of my team who
> > tried using that in production environment with poor results. I'll try
> > to get more specific information on that.
>
> That would be helpful as well.

Ack.

>
> > > E.g. Oscar has been working on extending page_ext to track number of
> > > allocations for specific calltrace[1]. Is this 1:1 replacement? No! But
> > > it can help in environments where page_ext can be enabled and it is
> > > completely non-intrusive to the MM code.
> >
> > Thanks for pointing out this work. I'll need to review and maybe
> > profile it before making any claims.
> >
> > >
> > > If the page_ext overhead is not desirable/acceptable then I am sure
> > > there are other options. E.g. kprobes/LivePatching framework can hook
> > > into functions and alter their behavior. So why not use that for data
> > > collection? Has this been evaluated at all?
> >
> > I'm not sure how I can hook into say alloc_pages() to find out where
> > it was called from without capturing the call stack (which would
> > introduce an overhead at every allocation). Would love to discuss this
> > or other alternatives if they can be done with low enough overhead.
>
> Yes, tracking back the call trace would be really needed. The question
> is whether this is really prohibitively expensive. How much overhead are
> we talking about? There is no free lunch here, really.  You either have
> the overhead during runtime when the feature is used or on the source
> code level for all the future development (with a maze of macros and
> wrappers).

Will post the overhead numbers soon.
What I hear loud and clear is that we need a kernel command-line kill
switch that mitigates the overhead for having this feature. That seems
to be the main concern.
Thanks,
Suren.

[1] https://docs.kernel.org/dev-tools/kmemleak.html#limitations-and-drawbacks

>
> Thanks!
> --
> Michal Hocko
> SUSE Labs
