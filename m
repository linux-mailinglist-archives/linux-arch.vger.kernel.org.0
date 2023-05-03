Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9956F5D21
	for <lists+linux-arch@lfdr.de>; Wed,  3 May 2023 19:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjECRk7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 May 2023 13:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjECRk5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 May 2023 13:40:57 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373C410F3
        for <linux-arch@vger.kernel.org>; Wed,  3 May 2023 10:40:55 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-555e853d3c5so51879007b3.2
        for <linux-arch@vger.kernel.org>; Wed, 03 May 2023 10:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683135654; x=1685727654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnWJwoqbKS+XkHViPIVupavn1s9FL+9QLrnitzrqP5g=;
        b=eK3o90MKtG0sAxJkQzBjjPPdgC8Naf0DW8LSnzzFyGy7r2iplN6tx8LRS+K1pesqQ/
         +dlPpm9XhI5MpmbmybPkhrAEcSQe8jXQWxke9zLF0oWZbujbmGNiLr16iUXkN33UUHSx
         XBXGIEWcktzdHazuLFLqwBuOkd1R9zqRh1rR05EQP6mEIW+Y870cMvkQ+YZdkTbO3EXe
         JnQPUyB6BIyM6BqPoFJBWX+ubIIjmGY6Y6TRZTV6HlKG9bq6FA2QoEZiVTg495moZLJm
         8j7J7Vy9fMLWKuo3JHmpkQUMBoO2kqt3hu+UuR0WJjg5iixGZu5y4Lvke1eQTwl5WZQa
         NpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683135654; x=1685727654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VnWJwoqbKS+XkHViPIVupavn1s9FL+9QLrnitzrqP5g=;
        b=iYiaRn2iduRhoRe2PHxK4Ley6Nu3fT8eFM0AEsD7FpuUUBbACZX4gi0og9CZ5l1KyY
         MSv24WYZvck7imhiU7kvccG9RpQ34oK3oicQ9ibSSHW29TxZRmrBTy+K02tWQIPbqyvE
         1a9YxRU7g4HPeY9CyhNKE78vw9ahGU+Gd+c7jbG1Wjt3EfqYeIs+YqZZKMZj/XKT4GRg
         KMVs/gSRdYwUk+96UpJACCowcmFTDaPen9nWdyK21RlxAzHO3O4I1R3orsKA91ttUcJr
         /Ki2PGoeo7aKuc6M+kY2iNba9hvMx1QsgA64fiuX237e+Q9P37ce5YSEFcc386OLddcb
         oeQQ==
X-Gm-Message-State: AC+VfDy8dkQCCWeOCU75ZmvH+R2ggLTQx7Ysp7ExfTA1BQ9tgPj5ARKa
        m6O7C+PdhASiL8ASk7SY+a+VXhR5OaB21f3Hrtt2+Q==
X-Google-Smtp-Source: ACHHUZ5+xgmBEFDJhkEbV6hOZk2BeNhUs5riMMl8CEWVIZEPl5lRwY7k05WxOPH80Nz6y5uKgnKRw8/1iWaKnQTfG2Y=
X-Received: by 2002:a25:1885:0:b0:b92:3f59:26e with SMTP id
 127-20020a251885000000b00b923f59026emr18942712yby.41.1683135654167; Wed, 03
 May 2023 10:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com> <ZFIMaflxeHS3uR/A@dhcp22.suse.cz>
 <CAJuCfpHxbYFxDENYFfnggh1D8ot4s493PQX0C7kD-JLvixC-Vg@mail.gmail.com> <20230503122839.0d9934c5@gandalf.local.home>
In-Reply-To: <20230503122839.0d9934c5@gandalf.local.home>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 3 May 2023 10:40:42 -0700
Message-ID: <CAJuCfpFYq7CZS4y2ZiF+AJHRKwnyhmZCk_uuTwFse26DxGh-qQ@mail.gmail.com>
Subject: Re: [PATCH 00/40] Memory allocation profiling
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        kent.overstreet@linux.dev, vbabka@suse.cz, hannes@cmpxchg.org,
        roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net,
        void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
        ldufour@linux.ibm.com, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
        david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org,
        tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
        paulmck@kernel.org, pasha.tatashin@soleen.com,
        yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
        hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, bristot@redhat.com,
        vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
        elver@google.com, dvyukov@google.com, shakeelb@google.com,
        songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
        minchan@google.com, kaleshsingh@google.com,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, May 3, 2023 at 9:28=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Wed, 3 May 2023 08:09:28 -0700
> Suren Baghdasaryan <surenb@google.com> wrote:
>
> > There is another issue, which I think can be solved in a smart way but
> > will either affect performance or would require more memory. With the
> > tracing approach we don't know beforehand how many individual
> > allocation sites exist, so we have to allocate code tags (or similar
> > structures for counting) at runtime vs compile time. We can be smart
> > about it and allocate in batches or even preallocate more than we need
> > beforehand but, as I said, it will require some kind of compromise.
>
> This approach is actually quite common, especially since tagging every
> instance is usually overkill, as if you trace function calls in a running
> kernel, you will find that only a small percentage of the kernel ever
> executes. It's possible that you will be allocating a lot of tags that wi=
ll
> never be used. If run time allocation is possible, that is usually the
> better approach.

True but the memory overhead should not be prohibitive here. As a
ballpark number, on my machine I see there are 4838 individual
allocation locations and each codetag structure is 32 bytes, so that's
152KB.

>
> -- Steve
