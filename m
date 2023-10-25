Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4CA7D70F5
	for <lists+linux-arch@lfdr.de>; Wed, 25 Oct 2023 17:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbjJYPaB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Oct 2023 11:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbjJYP3u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Oct 2023 11:29:50 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9984E1A7
        for <linux-arch@vger.kernel.org>; Wed, 25 Oct 2023 08:28:48 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1e9baf16a86so3711177fac.1
        for <linux-arch@vger.kernel.org>; Wed, 25 Oct 2023 08:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698247727; x=1698852527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLJnARkfIBMUfgquTTGlj0tPN4MXFqJ8fdXtHqq+8bA=;
        b=rcMXqPXHNin4Ta1yJhxDfVFdFfBVu/1Psqp1m1hzNSxpkcJreMbeoZWgByX2gLmTkp
         TZL/GSUf6zuS/kdQL38fj9VC5SbO7ZZG0jnQUxrmy+8NcJ20p3MQQUBzU6Rj1kTDehgE
         aFV6SIFh9NRwlwE9MbZu08Y/bwSOdCMm0TtW3GbED7ah2K8DFW1NoAafGp8EfRhBRYJ9
         xj1i8wY4ceKQUy0fT2UMeIrjIcIMZRd/SzsCGB9OTUOgCMDOG7BhyC11g8kfavrehZjT
         2ewoH5y5aBjiT9+8UmxFrxcjDtIORiDfoTCiMDyUAf6/Kd4gxekOdEk1i2KDZgOXKPHx
         bC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698247728; x=1698852528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLJnARkfIBMUfgquTTGlj0tPN4MXFqJ8fdXtHqq+8bA=;
        b=o1b1+LD8hcn0E39NOsd9Hk2JANDTYJIR7IzkU9CPuzTL/1MtgrfBiWq9ZNLLn1JiWg
         oppIbQdL9Y2vm/bR4GH5XYTjxg4NWThZQVfVBiiZsO0pN9XL+qW7FXKEMfhn4rIHcbnC
         gIlKOHBtmi0PCrSBQUfVvH8XxmLklzsKMmlxXSSae7lHQfSEKk5I6PrlniWmkDn+vJ5R
         Y/1WrRwR2VkFM8yQ4GPNujK+MYqeDynFMj5T5H9hUMnYyReY7pm6A8M00kglIm7gkmHB
         rjMFsMB4H8JaG9VascEDROAMelWKzD68fVpBbJuSYCtTfRDb6SZ7jOOJRuSd6ytEOuyO
         ZRvA==
X-Gm-Message-State: AOJu0YyJMVlxxFce7jeMcZUIjUOWdFVfMhJ9aBIG+ouus45kM8Mpxzco
        KMYNtN19PrmXmDRvMNtVpF7qxcS42nyUofdsIrwG1A==
X-Google-Smtp-Source: AGHT+IHL6UT5V0z1/nV7C2aKZX3u20HQgpTlx8EY9sjj8g+GZ70q4xGtJEt1W/Cng5aHzKMeb5xqOwS2911dC7wfxYg=
X-Received: by 2002:a05:6870:1157:b0:1da:ed10:bcb with SMTP id
 23-20020a056870115700b001daed100bcbmr15750180oag.31.1698247727385; Wed, 25
 Oct 2023 08:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com> <20231024134637.3120277-7-surenb@google.com>
 <20231025074652.44bc0eb4@meshulam.tesarici.cz>
In-Reply-To: <20231025074652.44bc0eb4@meshulam.tesarici.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 25 Oct 2023 08:28:32 -0700
Message-ID: <CAJuCfpHS1JTRU69zFDAJjmMYR3K5TAS9+AsA3oYLs2LCs5aTBw@mail.gmail.com>
Subject: Re: [PATCH v2 06/39] mm: enumerate all gfp flags
To:     =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc:     Neil Brown <neilb@suse.de>, akpm@linux-foundation.org,
        kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        corbet@lwn.net, void@manifault.com, peterz@infradead.org,
        juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, vvvvvv@google.com,
        gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 24, 2023 at 10:47=E2=80=AFPM Petr Tesa=C5=99=C3=ADk <petr@tesar=
ici.cz> wrote:
>
> On Tue, 24 Oct 2023 06:46:03 -0700
> Suren Baghdasaryan <surenb@google.com> wrote:
>
> > Introduce GFP bits enumeration to let compiler track the number of used
> > bits (which depends on the config options) instead of hardcoding them.
> > That simplifies __GFP_BITS_SHIFT calculation.
> > Suggested-by: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  include/linux/gfp_types.h | 90 +++++++++++++++++++++++++++------------
> >  1 file changed, 62 insertions(+), 28 deletions(-)
> >
> > diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
> > index 6583a58670c5..3fbe624763d9 100644
> > --- a/include/linux/gfp_types.h
> > +++ b/include/linux/gfp_types.h
> > @@ -21,44 +21,78 @@ typedef unsigned int __bitwise gfp_t;
> >   * include/trace/events/mmflags.h and tools/perf/builtin-kmem.c
> >   */
> >
> > +enum {
> > +     ___GFP_DMA_BIT,
> > +     ___GFP_HIGHMEM_BIT,
> > +     ___GFP_DMA32_BIT,
> > +     ___GFP_MOVABLE_BIT,
> > +     ___GFP_RECLAIMABLE_BIT,
> > +     ___GFP_HIGH_BIT,
> > +     ___GFP_IO_BIT,
> > +     ___GFP_FS_BIT,
> > +     ___GFP_ZERO_BIT,
> > +     ___GFP_UNUSED_BIT,      /* 0x200u unused */
> > +     ___GFP_DIRECT_RECLAIM_BIT,
> > +     ___GFP_KSWAPD_RECLAIM_BIT,
> > +     ___GFP_WRITE_BIT,
> > +     ___GFP_NOWARN_BIT,
> > +     ___GFP_RETRY_MAYFAIL_BIT,
> > +     ___GFP_NOFAIL_BIT,
> > +     ___GFP_NORETRY_BIT,
> > +     ___GFP_MEMALLOC_BIT,
> > +     ___GFP_COMP_BIT,
> > +     ___GFP_NOMEMALLOC_BIT,
> > +     ___GFP_HARDWALL_BIT,
> > +     ___GFP_THISNODE_BIT,
> > +     ___GFP_ACCOUNT_BIT,
> > +     ___GFP_ZEROTAGS_BIT,
> > +#ifdef CONFIG_KASAN_HW_TAGS
> > +     ___GFP_SKIP_ZERO_BIT,
> > +     ___GFP_SKIP_KASAN_BIT,
> > +#endif
> > +#ifdef CONFIG_LOCKDEP
> > +     ___GFP_NOLOCKDEP_BIT,
> > +#endif
> > +     ___GFP_LAST_BIT
> > +};
> > +
> >  /* Plain integer GFP bitmasks. Do not use this directly. */
> > -#define ___GFP_DMA           0x01u
> > -#define ___GFP_HIGHMEM               0x02u
> > -#define ___GFP_DMA32         0x04u
> > -#define ___GFP_MOVABLE               0x08u
> > -#define ___GFP_RECLAIMABLE   0x10u
> > -#define ___GFP_HIGH          0x20u
> > -#define ___GFP_IO            0x40u
> > -#define ___GFP_FS            0x80u
> > -#define ___GFP_ZERO          0x100u
> > +#define ___GFP_DMA           BIT(___GFP_DMA_BIT)
> > +#define ___GFP_HIGHMEM               BIT(___GFP_HIGHMEM_BIT)
> > +#define ___GFP_DMA32         BIT(___GFP_DMA32_BIT)
> > +#define ___GFP_MOVABLE               BIT(___GFP_MOVABLE_BIT)
> > +#define ___GFP_RECLAIMABLE   BIT(___GFP_RECLAIMABLE_BIT)
> > +#define ___GFP_HIGH          BIT(___GFP_HIGH_BIT)
> > +#define ___GFP_IO            BIT(___GFP_IO_BIT)
> > +#define ___GFP_FS            BIT(___GFP_FS_BIT)
> > +#define ___GFP_ZERO          BIT(___GFP_ZERO_BIT)
> >  /* 0x200u unused */
>
> This comment can be also removed here, because it is already stated
> above with the definition of ___GFP_UNUSED_BIT.

Ack.

>
> Then again, I think that the GFP bits have never been compacted after
> Neil Brown removed __GFP_ATOMIC with commit 2973d8229b78 simply because
> that would mean changing definitions of all subsequent GFP flags. FWIW
> I am not aware of any code that would depend on the numeric value of
> ___GFP_* macros, so this patch seems like a good opportunity to change
> the numbering and get rid of this unused 0x200u altogether.
>
> @Neil: I have added you to the conversation in case you want to correct
> my understanding of the unused bit.

Hmm. I would prefer to do that in a separate patch even though it
would be a one-line change. Seems safer to me in case something goes
wrong and we have to bisect and revert it. If that sounds ok I'll post
that in the next version.

>
> Other than that LGTM.

Thanks for the review!
Suren.

>
> Petr T
>
> > -#define ___GFP_DIRECT_RECLAIM        0x400u
> > -#define ___GFP_KSWAPD_RECLAIM        0x800u
> > -#define ___GFP_WRITE         0x1000u
> > -#define ___GFP_NOWARN                0x2000u
> > -#define ___GFP_RETRY_MAYFAIL 0x4000u
> > -#define ___GFP_NOFAIL                0x8000u
> > -#define ___GFP_NORETRY               0x10000u
> > -#define ___GFP_MEMALLOC              0x20000u
> > -#define ___GFP_COMP          0x40000u
> > -#define ___GFP_NOMEMALLOC    0x80000u
> > -#define ___GFP_HARDWALL              0x100000u
> > -#define ___GFP_THISNODE              0x200000u
> > -#define ___GFP_ACCOUNT               0x400000u
> > -#define ___GFP_ZEROTAGS              0x800000u
> > +#define ___GFP_DIRECT_RECLAIM        BIT(___GFP_DIRECT_RECLAIM_BIT)
> > +#define ___GFP_KSWAPD_RECLAIM        BIT(___GFP_KSWAPD_RECLAIM_BIT)
> > +#define ___GFP_WRITE         BIT(___GFP_WRITE_BIT)
> > +#define ___GFP_NOWARN                BIT(___GFP_NOWARN_BIT)
> > +#define ___GFP_RETRY_MAYFAIL BIT(___GFP_RETRY_MAYFAIL_BIT)
> > +#define ___GFP_NOFAIL                BIT(___GFP_NOFAIL_BIT)
> > +#define ___GFP_NORETRY               BIT(___GFP_NORETRY_BIT)
> > +#define ___GFP_MEMALLOC              BIT(___GFP_MEMALLOC_BIT)
> > +#define ___GFP_COMP          BIT(___GFP_COMP_BIT)
> > +#define ___GFP_NOMEMALLOC    BIT(___GFP_NOMEMALLOC_BIT)
> > +#define ___GFP_HARDWALL              BIT(___GFP_HARDWALL_BIT)
> > +#define ___GFP_THISNODE              BIT(___GFP_THISNODE_BIT)
> > +#define ___GFP_ACCOUNT               BIT(___GFP_ACCOUNT_BIT)
> > +#define ___GFP_ZEROTAGS              BIT(___GFP_ZEROTAGS_BIT)
> >  #ifdef CONFIG_KASAN_HW_TAGS
> > -#define ___GFP_SKIP_ZERO     0x1000000u
> > -#define ___GFP_SKIP_KASAN    0x2000000u
> > +#define ___GFP_SKIP_ZERO     BIT(___GFP_SKIP_ZERO_BIT)
> > +#define ___GFP_SKIP_KASAN    BIT(___GFP_SKIP_KASAN_BIT)
> >  #else
> >  #define ___GFP_SKIP_ZERO     0
> >  #define ___GFP_SKIP_KASAN    0
> >  #endif
> >  #ifdef CONFIG_LOCKDEP
> > -#define ___GFP_NOLOCKDEP     0x4000000u
> > +#define ___GFP_NOLOCKDEP     BIT(___GFP_NOLOCKDEP_BIT)
> >  #else
> >  #define ___GFP_NOLOCKDEP     0
> >  #endif
> > -/* If the above are modified, __GFP_BITS_SHIFT may need updating */
> >
> >  /*
> >   * Physical address zone modifiers (see linux/mmzone.h - low four bits=
)
> > @@ -249,7 +283,7 @@ typedef unsigned int __bitwise gfp_t;
> >  #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
> >
> >  /* Room for N __GFP_FOO bits */
> > -#define __GFP_BITS_SHIFT (26 + IS_ENABLED(CONFIG_LOCKDEP))
> > +#define __GFP_BITS_SHIFT ___GFP_LAST_BIT
> >  #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
> >
> >  /**
>
>
