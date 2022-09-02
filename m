Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FED5AA453
	for <lists+linux-arch@lfdr.de>; Fri,  2 Sep 2022 02:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbiIBAY6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Sep 2022 20:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbiIBAYz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Sep 2022 20:24:55 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630849FF6
        for <linux-arch@vger.kernel.org>; Thu,  1 Sep 2022 17:24:52 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id f18so1098257yba.1
        for <linux-arch@vger.kernel.org>; Thu, 01 Sep 2022 17:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=/pPOPbPw8AnpH29BUzSqTrm5ZvDmaEgEyFxuBQlNiEg=;
        b=JFydOg9QoPX5QvCMFfTX+qzkxy7dX+yug3qLsycd8X5fIiKliNhG2sOdd7n2FZxg0x
         wlIQ0PSe2w+jF1eYJALDSn9VwIQg7e+fojjEXzmIOWtowrPcZ8vVaDgvGlc5viuLzbLq
         BuWwUYh3dJTjnuDVzKYwlUlnzQN1dlqhuf8e4UUJj0Gz3yVOw7ZhtZlACThcN+JogWbQ
         XLiaLX50zBOT8vT4sikyfQhvA5G9n7Ys1zkULvj3Bu6V7OPgO3m2SYNlgkEGLVgRXA6S
         YaT8WKnNiPs7HVTvCKPZfxYMJ9fk0eCfVfQjSQqADIJwkH1wr6+8aSYndPr9n1G1vqpS
         RvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/pPOPbPw8AnpH29BUzSqTrm5ZvDmaEgEyFxuBQlNiEg=;
        b=jDd9yvU8M2VfbOSysMtlnQQGlfxn5mjfq+0dpvgr61vxj+iOpVz+Ec9kZ+Cf0s0BHO
         jj+EZT7gOXPe4cBygA3NBaeaGVxKWTPockX0RxVhz1vVzSrZCykfAlDy6Pj/9P6OvfAi
         yjW2SEm2YTFwzDm9/XT/H5xHiHRFcCizGM7Va/PO8kSNWSA9qKHnfcXQKUwH5iVyO0m/
         8kMdI7dUKuldWnzSHHmMcrzW6DB+cvyvqQarhBTdWfkAgPor9zjQaih6pTCeZL5WyeKp
         YXwsduc/pSKDVFBPrUxPGOQzfiMXOswwzYa7tfUop7wh6uZzNvtl0dyF0W+ZowflMpb8
         yptQ==
X-Gm-Message-State: ACgBeo34sRdlmNRN3wFps3EItdnCG9LMj9G+babL6KLr2oZFL7aArmVK
        PzRcctDmhN+XoPmDHiAXFKyS76W9Z/YBGqLOGkLlcQ==
X-Google-Smtp-Source: AA6agR5/Ulv2F+QXTz0x1dcq0Ynnhj3rjvCeoD8VrxwV966KDu/pwW+2XwncQnNg3JY46QNFp+MHM1SP5XYuAvh7JKU=
X-Received: by 2002:a05:6902:705:b0:695:b3b9:41bc with SMTP id
 k5-20020a056902070500b00695b3b941bcmr21283555ybt.426.1662078291363; Thu, 01
 Sep 2022 17:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220830214919.53220-1-surenb@google.com> <20220830214919.53220-15-surenb@google.com>
 <YxFC9NSQ7OADTEwp@P9FQF9L96D.corp.robot.car>
In-Reply-To: <YxFC9NSQ7OADTEwp@P9FQF9L96D.corp.robot.car>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 1 Sep 2022 17:24:40 -0700
Message-ID: <CAJuCfpGRL72qghDf9bNsp_K0kabvLBs5ags2hHXn-5_Ar8RX5A@mail.gmail.com>
Subject: Re: [RFC PATCH 14/30] mm: prevent slabobj_ext allocations for
 slabobj_ext and kmem_cache objects
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        David Vernet <void@manifault.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 1, 2022 at 4:41 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> On Tue, Aug 30, 2022 at 02:49:03PM -0700, Suren Baghdasaryan wrote:
> > Use __GFP_NO_OBJ_EXT to prevent recursions when allocating slabobj_ext
> > objects. Also prevent slabobj_ext allocations for kmem_cache objects.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Patches 12-14 look good to me.
> It's probably to early to ack anything, but otherwise I'd ack them.

Thank you for reviewing!

>
> Thanks!
