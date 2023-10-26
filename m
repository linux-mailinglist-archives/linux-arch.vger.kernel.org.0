Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618057D8C0B
	for <lists+linux-arch@lfdr.de>; Fri, 27 Oct 2023 01:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjJZXFz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Oct 2023 19:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjJZXFy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Oct 2023 19:05:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0CB1AB;
        Thu, 26 Oct 2023 16:05:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698361548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=301JXjESu5nnVpLjEelVyjL0FjP4Jn3OGJNIUK28IQU=;
        b=Eb1gIXVaXmAnj6Vz5I5vcFWzDPXOSmvemJ25H8m6l0iIfUCVbejjE5Y7/gMXNjhx38wFSY
        RJVefBKehaEbHZC0xz/csfH7mbPsNSfYiCauGm2dkY44hd+k+9U6KMD5ojDdWRkeQJsrx/
        OV5SFLjgRLZOJiENHih/gRvsbWHp/OChDTcIMU2L2YOCFQ+alGJLgavDwv76UXYnm4FUqt
        mexY2UyN7A2yUcVKqUOOjL5oBsfz83nAndyc/X3E1zmQtBIV0PTUFh30pySJK6spbDflP8
        y3bd6T8hJ4kPQd3jB2y/dX8ppdTvZDmpjnDFyPySE+c/jTPIO1DJJA2RSkx7MQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698361548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=301JXjESu5nnVpLjEelVyjL0FjP4Jn3OGJNIUK28IQU=;
        b=RqNiSkrnkwZTXyqqspVxXRlYFLHhxLB+hajtQnaflb0qL/La0rOh7/J5t3jx5IjGn+PrXi
        2bcUxpuqUgAyUpDA==
To:     Suren Baghdasaryan <surenb@google.com>
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
Subject: Re: [PATCH v2 28/39] timekeeping: Fix a circular include dependency
In-Reply-To: <CAJuCfpH1pG513-FUE_28MfJ7xbX=9O-auYUjkxKLmtve_6rRAw@mail.gmail.com>
References: <20231024134637.3120277-1-surenb@google.com>
 <20231024134637.3120277-29-surenb@google.com> <87h6me620j.ffs@tglx>
 <CAJuCfpH1pG513-FUE_28MfJ7xbX=9O-auYUjkxKLmtve_6rRAw@mail.gmail.com>
Date:   Fri, 27 Oct 2023 01:05:48 +0200
Message-ID: <87jzr93rxv.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 26 2023 at 18:33, Suren Baghdasaryan wrote:
> On Wed, Oct 25, 2023 at 5:33=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> > This avoids a circular header dependency in an upcoming patch by only
>> > making hrtimer.h depend on percpu-defs.h
>>
>> What's the actual dependency problem?
>
> Sorry for the delay.
> When we instrument per-cpu allocations in [1] we need to include
> sched.h in percpu.h to be able to use alloc_tag_save(). sched.h

Including sched.h in percpu.h is fundamentally wrong as sched.h is the
initial place of all header recursions.

There is a reason why a lot of funtionalitiy has been split out of
sched.h into seperate headers over time in order to avoid that.

Thanks,

        tglx
