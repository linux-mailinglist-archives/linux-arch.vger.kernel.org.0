Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3198D76F700
	for <lists+linux-arch@lfdr.de>; Fri,  4 Aug 2023 03:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjHDBeG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Aug 2023 21:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjHDBeF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Aug 2023 21:34:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DA6423E;
        Thu,  3 Aug 2023 18:34:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6341A61E6F;
        Fri,  4 Aug 2023 01:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5543C433CD;
        Fri,  4 Aug 2023 01:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691112842;
        bh=1SwYgmcz/V5Q6y+G1h8awfAW/klFKCRtK/XqoMFZvug=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GxEH1cw6+ctR0156enB7JXCNRkchk9kZC1gkuD4bA4vEnKqQS4ccLZ1YMd7D1p5EG
         2ImZwHTc6kSyAAjB6w/NPfzTQc79NOMGDuyxEqxlclQnRYo+4e2Cvjy8aGCCj7L1HH
         qry1skhyfR1ALyXmaknb2WE10o8Db2IWfQNpW3WcyjuCxmDcOfiC5NsUhTCDTXBMQm
         BwVhJF7jo80bRBQlVes1v+7zoisfEoQvgX7ZhlvVn8zLorP9dZG5f009IynqactQcA
         1zsdwshaml/IWUtL0EeQQ9Pak6iOAiD1DD6iNQqsV69o8HPHQC+TaO8H0bxIC1rNLR
         0bbHG/HZuKFhw==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-52256241c66so3416488a12.1;
        Thu, 03 Aug 2023 18:34:02 -0700 (PDT)
X-Gm-Message-State: AOJu0YxQ12ftR389yZv8CMTxWNQkUHzkn9CAWZT+VhyzLd2FUYA6Ny0G
        fnQKvLEmjEh4hzLvtYG3L2HteD/iRzukV1Sbkq4=
X-Google-Smtp-Source: AGHT+IHljYyOh8BVbVHLwghUBVKH/dGvZjYtQlDLeqXmhB4C42aKxfeiLiwn9XffenLKPupGWw5K+WsLtpVRT/UuebA=
X-Received: by 2002:a05:6402:3507:b0:522:ddeb:cdcb with SMTP id
 b7-20020a056402350700b00522ddebcdcbmr419084edd.18.1691112840973; Thu, 03 Aug
 2023 18:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210514200743.3026725-1-alex.kogan@oracle.com>
 <20210514200743.3026725-4-alex.kogan@oracle.com> <ZMrjPWdWhEhwpZDo@gmail.com>
 <20230803085004.GF212435@hirez.programming.kicks-ass.net> <CAJF2gTQFZEpHK45hd9HXxHxJc4gaCuDQ4wZ2adDzHwGQjA6VFw@mail.gmail.com>
 <20230803115610.GC214207@hirez.programming.kicks-ass.net>
In-Reply-To: <20230803115610.GC214207@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 4 Aug 2023 09:33:48 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQkZ_dVgrdyxRjb=HHgMkBxCkJy0cX_C-FF_ZSQ1ODj-g@mail.gmail.com>
Message-ID: <CAJF2gTQkZ_dVgrdyxRjb=HHgMkBxCkJy0cX_C-FF_ZSQ1ODj-g@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 3, 2023 at 7:57=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Thu, Aug 03, 2023 at 06:28:51PM +0800, Guo Ren wrote:
> > On Thu, Aug 3, 2023 at 4:50=E2=80=AFPM Peter Zijlstra <peterz@infradead=
.org> wrote:
> > >
> > > On Wed, Aug 02, 2023 at 07:14:05PM -0400, Guo Ren wrote:
> > >
> > > > The pv_ops is belongs to x86 custom frame work, and it prevent othe=
r
> > > > architectures connect to the CNA spinlock.
> > >
> > > static_call() exists as a arch neutral variant of this.
> > Emm... we have used static_call() in the riscv queued_spin_lock_:
> > https://lore.kernel.org/all/20230802164701.192791-20-guoren@kernel.org/
>
> Yeah, I think I saw that land in the INBOX, just haven't had time to
> look at it.
>
> > But we met a compile problem:
> >
> >   GEN     .vmlinux.objs
> >   MODPOST Module.symvers
> > ERROR: modpost: "__SCK__pv_queued_spin_unlock" [arch/riscv/kvm/kvm.ko]
> > undefined!
> > ERROR: modpost: "__SCK__pv_queued_spin_unlock"
> > [kernel/locking/locktorture.ko] undefined!
> > ERROR: modpost: "__SCK__pv_queued_spin_unlock" [mm/z3fold.ko] undefined=
!
> > ERROR: modpost: "__SCK__pv_queued_spin_unlock"
> > [fs/nfs_common/grace.ko] undefined!
> > ERROR: modpost: "__SCK__pv_queued_spin_unlock" [fs/quota/quota_v1.ko] u=
ndefined!
> > ERROR: modpost: "__SCK__pv_queued_spin_unlock" [fs/quota/quota_v2.ko] u=
ndefined!
> > ERROR: modpost: "__SCK__pv_queued_spin_unlock"
> > [fs/quota/quota_tree.ko] undefined!
> > ERROR: modpost: "__SCK__pv_queued_spin_unlock" [fs/fuse/virtiofs.ko] un=
defined!
> > ERROR: modpost: "__SCK__pv_queued_spin_unlock" [fs/dlm/dlm.ko] undefine=
d!
> > ERROR: modpost: "__SCK__pv_queued_spin_unlock" [fs/fscache/fscache.ko]
> > undefined!
> > WARNING: modpost: suppressed 839 unresolved symbol warnings because
> > there were too many)
> > /home/guoren/source/kernel/linux/scripts/Makefile.modpost:144: recipe
> > for target 'Module.symvers' failed
> >
> > Our solution is:
> > EXPORT_SYMBOL(__SCK__pv_queued_spin_unlock);
> >
> > What do you think about it?
>
> Could be you're not using static_call_mod() to go with
> EXPORT_STATIC_CALL_TRAMP()
Thx, that's what I want.

>
> > > > I'm working on riscv qspinlock on sg2042 64 cores 2/4 NUMA nodes
> > > > platforms. Here are the patches about riscv CNA qspinlock:
> > > > https://lore.kernel.org/linux-riscv/20230802164701.192791-19-guoren=
@kernel.org/
> > > >
> > > > What's the next plan for this patch series? I think the two-queue d=
esign
> > > > has satisfied most platforms with two NUMA nodes.
> > >
> > > What has been your reason for working on CNA? What lock has been so
> > > contended you need this?
> > I wrote the reason here:
> > https://lore.kernel.org/all/20230802164701.192791-1-guoren@kernel.org/
> >
> > The target platform is: https://www.sophon.ai/
> >
> > The two NUMA nodes platform has come out, so we want to measure the
> > benefit of CNA qspinlock.
>
> CNA should only show a benefit when there is strong inter-node
> contention, and in that case it is typically best to fix the kernel side
> locking.
>
> Hence the question as to what lock prompted you to look at this.
I met the long lock queue situation when the hardware gave an overly
aggressive store queue merge buffer delay mechanism. See:
https://lore.kernel.org/linux-riscv/20230802164701.192791-8-guoren@kernel.o=
rg/

This also let me consider improving the efficiency of the long lock
queue release. For example, if the queue is like this:

(Node0 cpu0) -> (Node1 cpu64) -> (Node0 cpu1) -> (Node1 cpu65) ->
(Node0 cpu2) -> (Node1 cpu66) -> ...

Then every mcs_unlock would cause a cross-NUMA transaction. But if we
could make the queue like this:

(Node0 cpu0) -> (Node0 cpu1) -> (Node0 cpu2) -> (Node1 cpu65) ->
(Node1 cpu66) -> (Node1 cpu64) -> ...

Only one cross-NUMA transaction is needed. Although it would cause
starvation problems, qspinlock.numa_spinlock_threshold_ns could give a
basic guarantee.

--=20
Best Regards
 Guo Ren
