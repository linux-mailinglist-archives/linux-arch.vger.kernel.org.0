Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D475076F706
	for <lists+linux-arch@lfdr.de>; Fri,  4 Aug 2023 03:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjHDBiW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Aug 2023 21:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjHDBiW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Aug 2023 21:38:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE29E7;
        Thu,  3 Aug 2023 18:38:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C10361EE6;
        Fri,  4 Aug 2023 01:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C0EC43397;
        Fri,  4 Aug 2023 01:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691113099;
        bh=6qeC0Iv1GFQRmaVD75/FwHHjugHHOsjLKJQ8l8kFABk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YtbWO8qkENQ77pza8i5wnqYNdqxush+O++/dtrsAcWmwys+eyokVowS0OBVxUEdKM
         uMc9TV10FTmVetkNUcnsB+GgO0WUeiuXLisKZvFVUCugQLzJuma5if6wQ9EK8CqgzY
         Sy0N5ngAy6nYdZuXLQeocvh7lL85ExtGBGDbkkV1+f8vD5jEr7xPl7NDtXXZO7xuo1
         O7Am2iPmdsFXXH90QM3GsI+kJbLoyAZawAPh/9hXWz2SeM/RypMMz9K3MsvJEpQIDB
         U+//Ae9gbozR+HKZeFY20aIa9z4zkakLIJ6TBoh7EFOh6AFPJfq1irxuLNHW4wCxvn
         GRrPx7xeO9jRg==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-52256241c66so3421029a12.1;
        Thu, 03 Aug 2023 18:38:19 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzb1HxY6ZNf3dH8b/0o5JM0H/biJ3q9/kFmsNy20ec+SIKf+dfP
        y4oockMjSK4w50GwuOWLB+538SPMnE+kRhlPTvU=
X-Google-Smtp-Source: AGHT+IHGdl+3u1eeNYAlAMvsAvH7XeSH+JF+iR2tAo8oIjL0sT4latMS64a1wdROFbb12sOLiIoRnUfSYMrCmA3xU/A=
X-Received: by 2002:aa7:c989:0:b0:522:18b6:c01f with SMTP id
 c9-20020aa7c989000000b0052218b6c01fmr443469edt.3.1691113097908; Thu, 03 Aug
 2023 18:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210514200743.3026725-1-alex.kogan@oracle.com>
 <20210514200743.3026725-4-alex.kogan@oracle.com> <ZMrjPWdWhEhwpZDo@gmail.com>
 <20230803085004.GF212435@hirez.programming.kicks-ass.net> <CAJF2gTQFZEpHK45hd9HXxHxJc4gaCuDQ4wZ2adDzHwGQjA6VFw@mail.gmail.com>
 <20230803115610.GC214207@hirez.programming.kicks-ass.net> <CAJF2gTQkZ_dVgrdyxRjb=HHgMkBxCkJy0cX_C-FF_ZSQ1ODj-g@mail.gmail.com>
In-Reply-To: <CAJF2gTQkZ_dVgrdyxRjb=HHgMkBxCkJy0cX_C-FF_ZSQ1ODj-g@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 4 Aug 2023 09:38:05 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSt8+NQwVPeR=78=s78AZM_o8+p8j2H25xg1yZR-2v5XA@mail.gmail.com>
Message-ID: <CAJF2gTSt8+NQwVPeR=78=s78AZM_o8+p8j2H25xg1yZR-2v5XA@mail.gmail.com>
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

On Fri, Aug 4, 2023 at 9:33=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Thu, Aug 3, 2023 at 7:57=E2=80=AFPM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
> >
> > On Thu, Aug 03, 2023 at 06:28:51PM +0800, Guo Ren wrote:
> > > On Thu, Aug 3, 2023 at 4:50=E2=80=AFPM Peter Zijlstra <peterz@infrade=
ad.org> wrote:
> > > >
> > > > On Wed, Aug 02, 2023 at 07:14:05PM -0400, Guo Ren wrote:
> > > >
> > > > > The pv_ops is belongs to x86 custom frame work, and it prevent ot=
her
> > > > > architectures connect to the CNA spinlock.
> > > >
> > > > static_call() exists as a arch neutral variant of this.
> > > Emm... we have used static_call() in the riscv queued_spin_lock_:
> > > https://lore.kernel.org/all/20230802164701.192791-20-guoren@kernel.or=
g/
> >
> > Yeah, I think I saw that land in the INBOX, just haven't had time to
> > look at it.
> >
> > > But we met a compile problem:
> > >
> > >   GEN     .vmlinux.objs
> > >   MODPOST Module.symvers
> > > ERROR: modpost: "__SCK__pv_queued_spin_unlock" [arch/riscv/kvm/kvm.ko=
]
> > > undefined!
> > > ERROR: modpost: "__SCK__pv_queued_spin_unlock"
> > > [kernel/locking/locktorture.ko] undefined!
> > > ERROR: modpost: "__SCK__pv_queued_spin_unlock" [mm/z3fold.ko] undefin=
ed!
> > > ERROR: modpost: "__SCK__pv_queued_spin_unlock"
> > > [fs/nfs_common/grace.ko] undefined!
> > > ERROR: modpost: "__SCK__pv_queued_spin_unlock" [fs/quota/quota_v1.ko]=
 undefined!
> > > ERROR: modpost: "__SCK__pv_queued_spin_unlock" [fs/quota/quota_v2.ko]=
 undefined!
> > > ERROR: modpost: "__SCK__pv_queued_spin_unlock"
> > > [fs/quota/quota_tree.ko] undefined!
> > > ERROR: modpost: "__SCK__pv_queued_spin_unlock" [fs/fuse/virtiofs.ko] =
undefined!
> > > ERROR: modpost: "__SCK__pv_queued_spin_unlock" [fs/dlm/dlm.ko] undefi=
ned!
> > > ERROR: modpost: "__SCK__pv_queued_spin_unlock" [fs/fscache/fscache.ko=
]
> > > undefined!
> > > WARNING: modpost: suppressed 839 unresolved symbol warnings because
> > > there were too many)
> > > /home/guoren/source/kernel/linux/scripts/Makefile.modpost:144: recipe
> > > for target 'Module.symvers' failed
> > >
> > > Our solution is:
> > > EXPORT_SYMBOL(__SCK__pv_queued_spin_unlock);
> > >
> > > What do you think about it?
> >
> > Could be you're not using static_call_mod() to go with
> > EXPORT_STATIC_CALL_TRAMP()
> Thx, that's what I want.
>
> >
> > > > > I'm working on riscv qspinlock on sg2042 64 cores 2/4 NUMA nodes
> > > > > platforms. Here are the patches about riscv CNA qspinlock:
> > > > > https://lore.kernel.org/linux-riscv/20230802164701.192791-19-guor=
en@kernel.org/
> > > > >
> > > > > What's the next plan for this patch series? I think the two-queue=
 design
> > > > > has satisfied most platforms with two NUMA nodes.
> > > >
> > > > What has been your reason for working on CNA? What lock has been so
> > > > contended you need this?
> > > I wrote the reason here:
> > > https://lore.kernel.org/all/20230802164701.192791-1-guoren@kernel.org=
/
> > >
> > > The target platform is: https://www.sophon.ai/
> > >
> > > The two NUMA nodes platform has come out, so we want to measure the
> > > benefit of CNA qspinlock.
> >
> > CNA should only show a benefit when there is strong inter-node
> > contention, and in that case it is typically best to fix the kernel sid=
e
> > locking.
> >
> > Hence the question as to what lock prompted you to look at this.
> I met the long lock queue situation when the hardware gave an overly
> aggressive store queue merge buffer delay mechanism. See:
> https://lore.kernel.org/linux-riscv/20230802164701.192791-8-guoren@kernel=
.org/
>
> This also let me consider improving the efficiency of the long lock
> queue release. For example, if the queue is like this:
>
> (Node0 cpu0) -> (Node1 cpu64) -> (Node0 cpu1) -> (Node1 cpu65) ->
> (Node0 cpu2) -> (Node1 cpu66) -> ...
>
> Then every mcs_unlock would cause a cross-NUMA transaction. But if we
> could make the queue like this:
>
> (Node0 cpu0) -> (Node0 cpu1) -> (Node0 cpu2) -> (Node1 cpu65) ->
> (Node1 cpu66) -> (Node1 cpu64) -> ...
>
> Only one cross-NUMA transaction is needed. Although it would cause
> starvation problems, qspinlock.numa_spinlock_threshold_ns could give a
> basic guarantee.
I thought it was a tradeoff for the balance between fairness and efficiency=
.

>
> --
> Best Regards
>  Guo Ren



--=20
Best Regards
 Guo Ren
