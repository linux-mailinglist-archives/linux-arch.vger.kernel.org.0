Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4ADC5A8272
	for <lists+linux-arch@lfdr.de>; Wed, 31 Aug 2022 17:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiHaP4E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Aug 2022 11:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiHaPzj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Aug 2022 11:55:39 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8482A951
        for <linux-arch@vger.kernel.org>; Wed, 31 Aug 2022 08:55:36 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3376851fe13so311599497b3.6
        for <linux-arch@vger.kernel.org>; Wed, 31 Aug 2022 08:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=sybFcqH1KKlLZJ30kAOhH4vwj7X3FRQlsLR8cFlMDYU=;
        b=ONehLJlMia7mkVvk2Zcl9HnY/oTkc+1EwkoR6Jx3DnNxre4Sp/FSdNv9mcbGgEmDyx
         hcwrMSJR7ZiQ1gQ0UYolLJ1KfSsEifqyTyCpB3HNLZA2KMDBC4nzkHtXo4jdW5MEBTL/
         oeY/VF0jamX2X6EV+5N0Xd7mZ1j4MlgintI5pKX6sIFdlOA1BP37vU/laD/NgNYsqPs7
         ry3YkegZ8oI5uWS54z5Ryp1YEZwXewCN8pUvCwKMKDNaZ0LFaWzFXYjHfSoj16inAquU
         wnZgCdGNLRRqt1agsDuWNICevBAb1Fc4Vo2v2Ob02GeQiQO1vTHDvn4tcp5ikcEVDh90
         MGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=sybFcqH1KKlLZJ30kAOhH4vwj7X3FRQlsLR8cFlMDYU=;
        b=hee3Ni1f6gQww3dWm3V9kHc/iNf16Ysv60FsGqHLD6k6i9vr0CRPcbsjWvno0v6Nu7
         SAKvtXH9Cs7SuO/aa/UF2qc7sQs+aNftReKIEEMPV74HHtLypHGBZAJvWkGXPIIhnxfT
         HuLM9E4sfmkvPNpuamq6D5Bwx4SFPJECLNvmX/IKL63MFxitYjz/ioFJTo0JsowPh5XX
         IRiF2aLmzzhRcCwRnasjlaiRqO53JDVuuhjZLAT0zl0LvfRWBwdvRSTTa9XBnamyO0vw
         Cbnn8uzUclMKbon+WRsHU0Wkosw4hoD1dXZc1+ZuuRlhaJmy0KDYwucX7RXMDf7NjBz2
         lhng==
X-Gm-Message-State: ACgBeo2WXQiAUS/lGhRPyHrdSaeaBFWfTnVRd8YEefsBzPhzEeVgrwk/
        efitYk6jDyEp4GUZBUf9LdaOuIr7mC80G4GfBOwvww==
X-Google-Smtp-Source: AA6agR4NChdz7hhi2/Bkod2bRWHC00+BPJkQJe+enovUPIqOU12s621gnom9CkqxdAsQy2M3vDnXK/nOmkkUrisgkSc=
X-Received: by 2002:a81:a186:0:b0:33d:bf97:5b14 with SMTP id
 y128-20020a81a186000000b0033dbf975b14mr18636737ywg.514.1661961335065; Wed, 31
 Aug 2022 08:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220830214919.53220-1-surenb@google.com> <20220830214919.53220-28-surenb@google.com>
 <241c05a3-52a2-d49f-6962-3af5a94bc3fc@infradead.org>
In-Reply-To: <241c05a3-52a2-d49f-6962-3af5a94bc3fc@infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 31 Aug 2022 08:55:24 -0700
Message-ID: <CAJuCfpE2qrN7uXqZjJz6o20Rh4cQgcUBzAxzP4s+u=6XtmBnbg@mail.gmail.com>
Subject: Re: [RFC PATCH 27/30] Code tagging based latency tracking
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
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
        Marco Elver <elver@google.com>, dvyukov@google.com,
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

On Tue, Aug 30, 2022 at 6:53 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 8/30/22 14:49, Suren Baghdasaryan wrote:
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index b7d03afbc808..b0f86643b8f0 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -1728,6 +1728,14 @@ config LATENCYTOP
> >         Enable this option if you want to use the LatencyTOP tool
> >         to find out which userspace is blocking on what kernel operations.
> >
> > +config CODETAG_TIME_STATS
> > +     bool "Code tagging based latency measuring"
> > +     depends on DEBUG_FS
> > +     select TIME_STATS
> > +     select CODE_TAGGING
> > +     help
> > +       Enabling this option makes latency statistics available in debugfs
>
> Missing period at the end of the sentence.

Ack.

>
> --
> ~Randy
