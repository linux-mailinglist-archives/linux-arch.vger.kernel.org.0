Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891EB6F5D73
	for <lists+linux-arch@lfdr.de>; Wed,  3 May 2023 20:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjECSDp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 May 2023 14:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjECSDo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 May 2023 14:03:44 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E113C29
        for <linux-arch@vger.kernel.org>; Wed,  3 May 2023 11:03:42 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-55a8019379fso31406187b3.0
        for <linux-arch@vger.kernel.org>; Wed, 03 May 2023 11:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683137021; x=1685729021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9bphnAMm9U7G1bEITi+0ZLO/l3WQ/XqMzpkJeT7kyk=;
        b=L5MD7LDE53jR/3ptlXQOOTiI++wR1fxND5ifICgXfZ2hIWF0RB5i7Cbf3y8nlEohAG
         Clh+QMTpMVHznpV/HAd4dl/nTAteOJlo9pbsv1YpgR/WSnTsEaig6E+CihdksMC7+1jq
         6Z1XsGfjbwRGEha4Xholgwx49ZNbR3yyNtq3l6EeDu4stoYLEOoSm+lZCgitaF8qHB+G
         aMVYQbQoJuHDRRMDleBxwSfQuKLPGBerL3yL63wdl8g8U8bu8+X2Cp3t0DvaZ1xR1kyJ
         azu3inhuljuw1kRnH+qDgCm878e8KG06FyLYG9vQjwOhW5SbMlJY+LCsM4c30rFxv+Mb
         ZPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683137021; x=1685729021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9bphnAMm9U7G1bEITi+0ZLO/l3WQ/XqMzpkJeT7kyk=;
        b=hu/l05+3pbKVMb+EoPV79B9H+PoCvHe/aub0QxxsN2+50GFJ51CQhUFDucMBbd0Jlb
         6LUfnDXDDwYgQVNpdwNvBhZsbXK2sFjPXyQkLTILDtQhARr16AB4CnspEJ/1KxBfHK+g
         zjqX02H2hMNh0qqCro/xmRsck76Yd6ct5TnOhk24CR8oxMymPyFdxroaVZT80JDKt9Hx
         2U8SFElnj4rAn3Z/h0soKmloOhtvAm8oILj785sUYK7gizOGctyBpXtPkHiqCFiVv9qw
         ZbT2m55TGndFjPLYiXy45zjGSKF/RXyzlO2TLtEC4Oy7o6nuG78nc1K+U7EN7gPYreNE
         6ozw==
X-Gm-Message-State: AC+VfDwvKwgPe4p/o5WX6c2lCroNN5byaHHASrv+BQ3Xcn/VFBNAarIQ
        PY6NaLKq7YFQ72222gYNTvNsCmTb840DzrI7Mc1w7g==
X-Google-Smtp-Source: ACHHUZ4lvIgzIVoqBzi+ZqkC84PohxQDTMhCUsBRrb1hVuiEkZ49Yye5mAE/xSMdKBlLzt8OPesXOTpbgWw93u9GuoU=
X-Received: by 2002:a25:b18e:0:b0:b9d:b774:3aa2 with SMTP id
 h14-20020a25b18e000000b00b9db7743aa2mr16215719ybj.9.1683137021290; Wed, 03
 May 2023 11:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com> <20230501165450.15352-20-surenb@google.com>
 <20230503122529.44ef2d56@gandalf.local.home>
In-Reply-To: <20230503122529.44ef2d56@gandalf.local.home>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 3 May 2023 11:03:30 -0700
Message-ID: <CAJuCfpGPVWQ1RYVSZOiXe2xDVbgMFAxVf2x=2xbgor=YqpntzQ@mail.gmail.com>
Subject: Re: [PATCH 19/40] change alloc_pages name in dma_map_ops to avoid
 name conflicts
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     akpm@linux-foundation.org, kent.overstreet@linux.dev,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
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

On Wed, May 3, 2023 at 9:25=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Mon,  1 May 2023 09:54:29 -0700
> Suren Baghdasaryan <surenb@google.com> wrote:
>
> > After redefining alloc_pages, all uses of that name are being replaced.
> > Change the conflicting names to prevent preprocessor from replacing the=
m
> > when it's not intended.
>
> Note, every change log should have enough information in it to know why i=
t
> is being done. This says what the patch does, but does not fully explain
> "why". It should never be assumed that one must read other patches to get
> the context. A year from now, investigating git history, this may be the
> only thing someone sees for why this change occurred.
>
> The "why" above is simply "prevent preprocessor from replacing them
> when it's not intended". What does that mean?

Thanks for the feedback, Steve. I'll make appropriate modifications to
the description.

>
> -- Steve
>
>
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
