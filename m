Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F1C7702CC
	for <lists+linux-arch@lfdr.de>; Fri,  4 Aug 2023 16:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjHDOSD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Aug 2023 10:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjHDORv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Aug 2023 10:17:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B601BF0;
        Fri,  4 Aug 2023 07:17:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A27A6204D;
        Fri,  4 Aug 2023 14:17:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF80C433CA;
        Fri,  4 Aug 2023 14:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691158668;
        bh=XOMEnaMMSL3CqE/LSd5NwPaO6bkV1p4efai/On8GWMU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YJ9ZVKFXuMvU9jN8cGYFFCbVsijtcNPQvE3nAPEh1zXFyEs31ENciokcj9op5KPM1
         2GIxDQLdftxl8UP+sLhUPFeDFNHjE5KjSV+NdH09uPIpgvNQ1lhYA9Lr+rZ8KlLQEt
         Pu8T61HsCbJS0hqdjKIzJ3la83CdAO25xdAgV4OoiHbu+oFL+ZKX+Aon7UyuTnzqUT
         tk8m68sPAtV+L6gcV/k9Fg+TdCRI8Okhiwlx2ZbSt1/TTagnRVilD0iCGr6mBSYZB3
         1ToGAKogWmdItexiDMDRRgcz1aGRSsNAEej744AtiAPVq0s4WOIWcLbnaOj8J8c5so
         A2izOHzaDn8TQ==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so2733383a12.1;
        Fri, 04 Aug 2023 07:17:48 -0700 (PDT)
X-Gm-Message-State: AOJu0YxNxekksW5cb202c2spGPjJG9vtZcimVrNzaH8KnXoeOrb7A0rR
        X/MLRWux/UiQODdwdAj+A55crLeBBh+Tamm5hcQ=
X-Google-Smtp-Source: AGHT+IEtpb590jscikeglR8mRq02iSDzeZOKMQDtqS4cBTFF5hOCoQ1z1y96QzEByLl9kNQ4Xnq7A1Qf3CMHCFh9taw=
X-Received: by 2002:aa7:cd51:0:b0:51f:f1a4:edc6 with SMTP id
 v17-20020aa7cd51000000b0051ff1a4edc6mr1628091edw.37.1691158667132; Fri, 04
 Aug 2023 07:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210514200743.3026725-1-alex.kogan@oracle.com>
 <20210514200743.3026725-4-alex.kogan@oracle.com> <ZMrjPWdWhEhwpZDo@gmail.com>
 <20230803085004.GF212435@hirez.programming.kicks-ass.net> <CAJF2gTQFZEpHK45hd9HXxHxJc4gaCuDQ4wZ2adDzHwGQjA6VFw@mail.gmail.com>
 <20230803115610.GC214207@hirez.programming.kicks-ass.net> <CAJF2gTQkZ_dVgrdyxRjb=HHgMkBxCkJy0cX_C-FF_ZSQ1ODj-g@mail.gmail.com>
 <20230804082531.GL212435@hirez.programming.kicks-ass.net>
In-Reply-To: <20230804082531.GL212435@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 4 Aug 2023 10:17:35 -0400
X-Gmail-Original-Message-ID: <CAJF2gTQ77R1embGm4kR5THcYnzk0zOJ9LOn1z=z2g7FuFN239g@mail.gmail.com>
Message-ID: <CAJF2gTQ77R1embGm4kR5THcYnzk0zOJ9LOn1z=z2g7FuFN239g@mail.gmail.com>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 4, 2023 at 4:26=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Fri, Aug 04, 2023 at 09:33:48AM +0800, Guo Ren wrote:
> > On Thu, Aug 3, 2023 at 7:57=E2=80=AFPM Peter Zijlstra <peterz@infradead=
.org> wrote:
>
> > > CNA should only show a benefit when there is strong inter-node
> > > contention, and in that case it is typically best to fix the kernel s=
ide
> > > locking.
> > >
> > > Hence the question as to what lock prompted you to look at this.
> > I met the long lock queue situation when the hardware gave an overly
> > aggressive store queue merge buffer delay mechanism. See:
> > https://lore.kernel.org/linux-riscv/20230802164701.192791-8-guoren@kern=
el.org/
>
> *groan*, so you're using it to work around 'broken' hardware :-(
Yes, the hardware needs to be improved, and it couldn't depend on
WRITE_ONCE() hack. But from another view, if we tell the hardware this
is a WRITE_ONCE(), this store instruction should be observed by
sibling cores immediately, then the hardware could optimize the
behavior in the store queue. (All modern processors have a store queue
beyond the cache, and there is latency between the store queue and the
cache.) So:

How about adding an instruction of "st.aqrl" for WRITE_ONCE()? Which
makes the WRITE_ONCE() become the RCsc synchronization point.

>
> Wouldn't that hardware have horrifically bad lock throughput anyway?
> Everybody would end up waiting on that store buffer delay.
This problem is only found in the lock torture case, and only one
entry left in the store buffer would cause the problem. We are now
widely stress testing userspace parallel applications to find a second
case. Yes, we must be careful to treat this.

>
> > This also let me consider improving the efficiency of the long lock
> > queue release. For example, if the queue is like this:
> >
> > c -> c -> (Node0 cpu1) -> (Node1 cpu65) ->
> > (Node0 cpu2) -> (Node1 cpu66) -> ...
> >
> > Then every mcs_unlock would cause a cross-NUMA c. But if we
> > could make the queue like this:
>
> See, this is where the ARM64 WFE would come in handy; I don't suppose
> RISC-V has anything like that?
Em... arm64 smp_cond_load only could save power consumption or release
the pipeline resources of an SMT processor. When (Node1 cpu64) is in
the WFE state, it still needs (Node0 cpu1) to write the value to give
a cross-NUMA signal. So I didn't see what WFE related to reducing
cross-Numa transactions, or I missed something. Sorry

>
> Also, by the time you have 6 waiters, I'd say the lock is terribly
> contended and you should look at improving the lockinh scheme.
--
Best Regards
 Guo Ren
