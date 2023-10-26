Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769947D885B
	for <lists+linux-arch@lfdr.de>; Thu, 26 Oct 2023 20:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjJZSdd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Oct 2023 14:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjJZSdd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Oct 2023 14:33:33 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BF6D62
        for <linux-arch@vger.kernel.org>; Thu, 26 Oct 2023 11:33:24 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a7c08b7744so9583107b3.3
        for <linux-arch@vger.kernel.org>; Thu, 26 Oct 2023 11:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698345203; x=1698950003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rsh3dPt2/r73NgmaoP1t7gGhxASdUa0L8chPdmn23Qo=;
        b=rTZGeXNSv39V7CDwWwbTtJTASQ2rK2BoAdrQCuFlLhh8yuAl3n4qHKdjNVN2ZqoB62
         bEv3SsybLlla5R9YmiMvyzniT1p77RmjoumAu+mZA80D1jsWVuRyL9lby6Oko5k2Brje
         /B4qDoaVO116OOmgyjlvXUtygLddZRd4pdsIoJpVkuPd2dhnI1sK9hABTLhRYwP90vN9
         vvo/3fPIqeT7SoYTZjJaaaM9/3Wo9l6c2G+lbJbOfEydg2aB37+ZlEth+zEZEMW5M0Wj
         iw2AaL5p+eEgxjCqadkYQ7jEbdBumr2S3Tm3OqgexNucK/zd9LFHXauLjpelg8RPBrFk
         uhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698345203; x=1698950003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rsh3dPt2/r73NgmaoP1t7gGhxASdUa0L8chPdmn23Qo=;
        b=rMEnRJ+jUhs2AEy9TwyyAKqjLAU3rQO224SlgyrzpxYuYZDTURlqanRIiWDQuvJD2D
         K7efJ8eMcjEW6i/DOUChtUw2jFEcS3blXnQrnAu6Yz0Xb0r693Z7onPA+tcAwFLScWj6
         xK8xo8jlM94E2gSYPp1dZOY9fXSMi8K3SxY5QAKkI6J7JxG5FS8GfEaoxDA3E6Cidpkk
         cSYygOjMCWQSRdUGTi0u2mY/KYVN8FurVo7kMqOZ4WZrTxxHCbPRxG6kk5pwZ8r/GuYI
         ZYm2l46PC5MexpKQb/Oyj+eF+Zq/eA85Oj+h47TB9XnpdvhSZK/Mm++WS984n+HZ5pFR
         nSxQ==
X-Gm-Message-State: AOJu0YwSuyS0P46agEs8iyEKwLtsu5e7cEmGsYddyFCe/m6vLL2sLhpJ
        vY7dEdv3PaAalItBrS8val+DWRZbl7OGk4wLsZwg+g==
X-Google-Smtp-Source: AGHT+IHBtVGuULaTsqSbWWfK0JktN//Yobr+i2oSyvtEqBPvfhvTvIyFXXQYxmpnW+pXruM/MrOawuspY0l3Z4zpy28=
X-Received: by 2002:a25:74c5:0:b0:da0:46ad:fb46 with SMTP id
 p188-20020a2574c5000000b00da046adfb46mr114458ybc.41.1698345202763; Thu, 26
 Oct 2023 11:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com> <20231024134637.3120277-29-surenb@google.com>
 <87h6me620j.ffs@tglx>
In-Reply-To: <87h6me620j.ffs@tglx>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 26 Oct 2023 18:33:09 +0000
Message-ID: <CAJuCfpH1pG513-FUE_28MfJ7xbX=9O-auYUjkxKLmtve_6rRAw@mail.gmail.com>
Subject: Re: [PATCH v2 28/39] timekeeping: Fix a circular include dependency
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     akpm@linux-foundation.org, kent.overstreet@linux.dev,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
        roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net,
        void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
        ldufour@linux.ibm.com, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, mingo@redhat.com, dave.hansen@linux.intel.com,
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

On Wed, Oct 25, 2023 at 5:33=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Tue, Oct 24 2023 at 06:46, Suren Baghdasaryan wrote:
> > From: Kent Overstreet <kent.overstreet@linux.dev>
> >
> > This avoids a circular header dependency in an upcoming patch by only
> > making hrtimer.h depend on percpu-defs.h
>
> What's the actual dependency problem?

Sorry for the delay.
When we instrument per-cpu allocations in [1] we need to include
sched.h in percpu.h to be able to use alloc_tag_save(). sched.h
includes hrtimer.h. So, without this change we end up with a circular
inclusion: percpu.h->sched.h->hrtimer.h->percpu.h

[1] https://lore.kernel.org/all/20231024134637.3120277-32-surenb@google.com=
/

>
