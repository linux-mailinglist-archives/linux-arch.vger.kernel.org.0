Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C827D8C69
	for <lists+linux-arch@lfdr.de>; Fri, 27 Oct 2023 02:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjJ0ACf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Oct 2023 20:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJ0ACe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Oct 2023 20:02:34 -0400
X-Greylist: delayed 464 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 Oct 2023 17:02:31 PDT
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63B41A5
        for <linux-arch@vger.kernel.org>; Thu, 26 Oct 2023 17:02:31 -0700 (PDT)
Date:   Thu, 26 Oct 2023 19:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698364483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fxBcC6WpG3KRFkLY2+tQDJJ4+RZgo+8n9ZWicropf8c=;
        b=wlXDU2r/5NnsFnSK4PA0DRbeQnz5idT7VKahwUmPIGnLuoPyox6xMFxCRq1Pws1EO9s3ve
        aIg3upr66EtS1MsZX/PbSPfqPxCaMEUcPviZb6meANiNZEhNmrQ2++x3KPz3NDd9hcGBJa
        757p2yOOJ0ABimOFGTUk16CjWjiwuWc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
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
Subject: Re: [PATCH v2 28/39] timekeeping: Fix a circular include dependency
Message-ID: <20231026235433.yuvxf7opxg74ncmd@moria.home.lan>
References: <20231024134637.3120277-1-surenb@google.com>
 <20231024134637.3120277-29-surenb@google.com>
 <87h6me620j.ffs@tglx>
 <CAJuCfpH1pG513-FUE_28MfJ7xbX=9O-auYUjkxKLmtve_6rRAw@mail.gmail.com>
 <87jzr93rxv.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jzr93rxv.ffs@tglx>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 27, 2023 at 01:05:48AM +0200, Thomas Gleixner wrote:
> On Thu, Oct 26 2023 at 18:33, Suren Baghdasaryan wrote:
> > On Wed, Oct 25, 2023 at 5:33 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> > This avoids a circular header dependency in an upcoming patch by only
> >> > making hrtimer.h depend on percpu-defs.h
> >>
> >> What's the actual dependency problem?
> >
> > Sorry for the delay.
> > When we instrument per-cpu allocations in [1] we need to include
> > sched.h in percpu.h to be able to use alloc_tag_save(). sched.h
> 
> Including sched.h in percpu.h is fundamentally wrong as sched.h is the
> initial place of all header recursions.
> 
> There is a reason why a lot of funtionalitiy has been split out of
> sched.h into seperate headers over time in order to avoid that.

Yeah, it's definitely unfortunate. The issue here is that
alloc_tag_save() needs task_struct - we have to pull that in for
alloc_tag_save() to be inline, which we really want.

What if we moved task_struct to its own dedicated header? That might be
good to do anyways...
