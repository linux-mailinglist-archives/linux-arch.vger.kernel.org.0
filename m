Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6E9770C9F
	for <lists+linux-arch@lfdr.de>; Sat,  5 Aug 2023 02:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjHEATm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Aug 2023 20:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjHEATl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Aug 2023 20:19:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCC04694;
        Fri,  4 Aug 2023 17:19:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8541862185;
        Sat,  5 Aug 2023 00:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B2DC433C9;
        Sat,  5 Aug 2023 00:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691194779;
        bh=ZT1E4tYRXqbQsqihOH2CWjK8qBcGifYeeRSfKM5zIZ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eNB9CSV0rl8s9kc4RnWMGHEx+Gk3/Bm1SXIVOLNAUcT03f2n418gs9Y3TFk3126Z6
         Ksvij8javjbpZ8IFRzwkxSD7jopKWO9wVE14HT5Cx/xGB2kUn2CaJ/GcRSuK19PI9z
         IMH8Yqzsl2LeyfYL5rMvJKrO93tvzubKjsbTElYaUQ7p3EjsOEG9G7he/4zzL0cr4b
         wfTcabeFlhI2NE7N/DAFWd6e10YZjh2UEU74B6PL2kLd4F1rcZkkSPHn+jPV384Akc
         yN3CZi2mRKgVB5XCMngODjCEza1RyV55w5r2WK2oNsP4qw3Er6VAKEWLwKblkLKU6O
         lYO2j2bet51iw==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so3352247a12.1;
        Fri, 04 Aug 2023 17:19:39 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx3s8L3bBOUMzvDrxd5XlAWJ9W8ghJidK5D1Dcm6SGSzJOkHYwd
        dF3jPvgR892IiVTkbObWcbT8VpU3Mhz2dKVnGBY=
X-Google-Smtp-Source: AGHT+IEAmBRV778+9HRRu7cirwjztkUnM6/dZPsTbQSkHH9lz59F/kxxLBqF21ZKkF44osjd3hP1F1Sg5EeoVzMEA0k=
X-Received: by 2002:a05:6402:1b05:b0:523:f4c:afe7 with SMTP id
 by5-20020a0564021b0500b005230f4cafe7mr2660325edb.38.1691194777750; Fri, 04
 Aug 2023 17:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210514200743.3026725-1-alex.kogan@oracle.com>
 <20210514200743.3026725-4-alex.kogan@oracle.com> <ZMrjPWdWhEhwpZDo@gmail.com>
 <20230803085004.GF212435@hirez.programming.kicks-ass.net> <CAJF2gTQFZEpHK45hd9HXxHxJc4gaCuDQ4wZ2adDzHwGQjA6VFw@mail.gmail.com>
 <20230803115610.GC214207@hirez.programming.kicks-ass.net> <CAJF2gTQkZ_dVgrdyxRjb=HHgMkBxCkJy0cX_C-FF_ZSQ1ODj-g@mail.gmail.com>
 <20230804082531.GL212435@hirez.programming.kicks-ass.net> <CAJF2gTQ77R1embGm4kR5THcYnzk0zOJ9LOn1z=z2g7FuFN239g@mail.gmail.com>
 <20230804182312.GO212435@hirez.programming.kicks-ass.net>
In-Reply-To: <20230804182312.GO212435@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 4 Aug 2023 20:19:25 -0400
X-Gmail-Original-Message-ID: <CAJF2gTQB7pvLYCkZ+9Xmdtmv4ZVynC2embAza-sgPwL8c-D-sw@mail.gmail.com>
Message-ID: <CAJF2gTQB7pvLYCkZ+9Xmdtmv4ZVynC2embAza-sgPwL8c-D-sw@mail.gmail.com>
Subject: Re: [PATCH v15 3/6] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de,
        longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 4, 2023 at 2:24=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Fri, Aug 04, 2023 at 10:17:35AM -0400, Guo Ren wrote:
>
> > > See, this is where the ARM64 WFE would come in handy; I don't suppose
> > > RISC-V has anything like that?
> > Em... arm64 smp_cond_load only could save power consumption or release
> > the pipeline resources of an SMT processor. When (Node1 cpu64) is in
> > the WFE state, it still needs (Node0 cpu1) to write the value to give
> > a cross-NUMA signal. So I didn't see what WFE related to reducing
> > cross-Numa transactions, or I missed something. Sorry
>
> The benefit is that WFE significantly reduces the memory traffic. Since
> it 'suspends' the core and waits for a write-notification instead of
> busy polling the memory location you get a ton less loads.
Em... I had a different observation: When a long lock queue appeared
by a store buffer delay problem in the lock torture test, we observed
all interconnects get into a quiet state, and there was no more memory
traffic. All the cores are loop-loading "different" cacheline from
their L1 cache, caused by queued_spinlock. So I don't see any memory
traffics on the bus.

For the LL + WFE, AFAIK, LL is a load instruction that would grab the
cacheline from the bus into the L1-cache and set the reservation set
(arm may call it exclusive-monitor). If any cacheline invalidation
requests (readunique/cleanunique/...) come in, WFE would retire, and
the reservation set would be cleared. So from a cacheline perspective,
there is no difference between "LL+WFE" and "looping loads."

Let's see two scenarios of LL+WFE, multi-cores, and muti-threadings of one =
core:
 - In the multi-cores case, WFE didn't give any more benefits than the
loop loading from my perspective. Because the only thing WFE could do
is to "suspend core" (I borrowed your word here), but it can't be deep
sleep because the response from WFE is the most prior thing. As you
said, we should prevent "terribly contended" situations, so WFE must
keep fast reactions in the pipeline, not deep sleep. That's WFI stuff.
And loop loading also could reduce power consumption through the
proper micro-arch design: When the pipeline gets into a loop loading
state, the loop buffer mechanism start, no instructions fetch happens,
the frontend component can suspend for a while, and the only working
components are "loop buffer" and "LSU load path." Other components
could suspend for a while. So loop loading is not as terrible as you
thought.

 - In the multi-threading of one core case, introducing an ISA
instruction (WFE) to solve the loop loading problem is worthwhile
because the thread could release the resource of the processor's pipe
line.


>


--
Best Regards
 Guo Ren
