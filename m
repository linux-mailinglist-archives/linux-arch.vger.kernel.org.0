Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485EB5AA4D2
	for <lists+linux-arch@lfdr.de>; Fri,  2 Sep 2022 03:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbiIBBFM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Sep 2022 21:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiIBBFL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Sep 2022 21:05:11 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EA515FDE;
        Thu,  1 Sep 2022 18:04:59 -0700 (PDT)
Date:   Thu, 1 Sep 2022 18:04:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662080697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oRI44dmgZNXvCbxbx0ytBb5MNkpf1qBSJsTY6pAYXVg=;
        b=tb82WN7ukOq58edHhF7JOoDon3b2L1v/3IY97PsYRx6OPp66Trpvsx1rbRyhlh12fOiUwG
        EZmYoO3fSDUB2lu8gxsuWxZiVkHfm4qLeJxKDdrjL94MRoA3GDg6F5I9+Uj2cx14iFfbdO
        He+0U/hKqYLU04r4PhzKId0lgLZpOKY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Michal Hocko <mhocko@suse.com>, Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>, dave@stgolabs.net,
        Matthew Wilcox <willy@infradead.org>, liam.howlett@oracle.com,
        void@manifault.com, juri.lelli@redhat.com, ldufour@linux.ibm.com,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>, axboe@kernel.dk,
        mcgrof@kernel.org, masahiroy@kernel.org, nathan@kernel.org,
        changbin.du@intel.com, ytcoode@gmail.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        Steven Rostedt <rostedt@goodmis.org>, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>, arnd@arndb.de,
        jbaron@akamai.com, David Rientjes <rientjes@google.com>,
        minchan@google.com, kaleshsingh@google.com,
        kernel-team@android.com, Linux-MM <linux-mm@kvack.org>,
        iommu@lists.linux.dev, kasan-dev@googlegroups.com,
        io-uring@vger.kernel.org, linux-arch@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-modules@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/30] Code tagging framework and applications
Message-ID: <YxFWrka+Wx0FfLXU@P9FQF9L96D.lan>
References: <Yw8P8xZ4zqu121xL@hirez.programming.kicks-ass.net>
 <20220831084230.3ti3vitrzhzsu3fs@moria.home.lan>
 <20220831101948.f3etturccmp5ovkl@suse.de>
 <Yw88RFuBgc7yFYxA@dhcp22.suse.cz>
 <20220831190154.qdlsxfamans3ya5j@moria.home.lan>
 <CAJD7tkaev9B=UDYj2RL6pz-1454J8tv4gEr9y-2dnCksoLK0bw@mail.gmail.com>
 <YxExz+c1k3nbQMh4@P9FQF9L96D.corp.robot.car>
 <20220901223720.e4gudprscjtwltif@moria.home.lan>
 <YxE4BXw5i+BkxxD8@P9FQF9L96D.corp.robot.car>
 <20220902001747.qqsv2lzkuycffuqe@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902001747.qqsv2lzkuycffuqe@moria.home.lan>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 01, 2022 at 08:17:47PM -0400, Kent Overstreet wrote:
> On Thu, Sep 01, 2022 at 03:53:57PM -0700, Roman Gushchin wrote:
> > I'd suggest to run something like iperf on a fast hardware. And maybe some
> > io_uring stuff too. These are two places which were historically most sensitive
> > to the (kernel) memory accounting speed.
> 
> I'm getting wildly inconsistent results with iperf.
> 
> io_uring-echo-server and rust_echo_bench gets me:
> Benchmarking: 127.0.0.1:12345
> 50 clients, running 512 bytes, 60 sec.
> 
> Without alloc tagging:	120547 request/sec
> With:			116748 request/sec
> 
> https://github.com/frevib/io_uring-echo-server
> https://github.com/haraldh/rust_echo_bench
> 
> How's that look to you? Close enough? :)

Yes, this looks good (a bit too good).

I'm not that familiar with io_uring, Jens and Pavel should have a better idea
what and how to run (I know they've workarounded the kernel memory accounting
because of the performance in the past, this is why I suspect it might be an
issue here as well).

This is a recent optimization on the networking side:
https://lore.kernel.org/linux-mm/20220825000506.239406-1-shakeelb@google.com/

Maybe you can try to repeat this experiment.

Thanks!
