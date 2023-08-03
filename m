Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB62C76E5AC
	for <lists+linux-arch@lfdr.de>; Thu,  3 Aug 2023 12:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbjHCK3J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Aug 2023 06:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjHCK3H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Aug 2023 06:29:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D38026BA;
        Thu,  3 Aug 2023 03:29:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9A1461D2B;
        Thu,  3 Aug 2023 10:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4537DC433CB;
        Thu,  3 Aug 2023 10:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691058545;
        bh=v/DRRw+g9CsERIBoM2Rssf1Qef98vEpt0K/MhGk43Bk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=falbu8BQw/Bl6yKqCUl0WFg3jUhkIaDOaRu+gm0deORi0aGb1VuVfQnmpGH0AaiOo
         i2jmyy386gt8mG9sIRsczo9hofyz+xTirVaKai6LSDh5F8l8NygVXHqP4SR+XmjTAK
         gz3g77DlPr02au+xUrOyvO3DrdQQxZS+jquk3oit9cLhlZR38uf8I1yTPrvwx4NSxx
         jT25rCRasn201yRVCquB/5xsp0L+VF8/H+uPt3hjrZnTUHJ+T8fZDvUdrvNEJmmmD+
         s/IhbkUPTJ/eOS0ODB/RBur9dT19hWpgJXzj62DdFedB9arG/66hLIwywS9wEP0h7L
         b9qrXEMWgqeLw==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5221b90f763so1004180a12.0;
        Thu, 03 Aug 2023 03:29:05 -0700 (PDT)
X-Gm-Message-State: AOJu0YwzdFR8OxS0rSr7gXBdCF45iulrHwpO9bQTyEB6ErpMOQmGgQvG
        fOF3JQT7ddjFyO6EqHXZF6ISGdNc2dJNUq38C48=
X-Google-Smtp-Source: AGHT+IEWSvoQbFfB9EJsBjyXUwfdwgKeTo7ErdEGCsdslgSeoqDUZLBp+b1SCgQARY8/4/Jl89fU2lzr5OxgihGROBg=
X-Received: by 2002:aa7:de91:0:b0:523:f4c:afe7 with SMTP id
 j17-20020aa7de91000000b005230f4cafe7mr970056edv.38.1691058543442; Thu, 03 Aug
 2023 03:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210514200743.3026725-1-alex.kogan@oracle.com>
 <20210514200743.3026725-4-alex.kogan@oracle.com> <ZMrjPWdWhEhwpZDo@gmail.com> <20230803085004.GF212435@hirez.programming.kicks-ass.net>
In-Reply-To: <20230803085004.GF212435@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 3 Aug 2023 18:28:51 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQFZEpHK45hd9HXxHxJc4gaCuDQ4wZ2adDzHwGQjA6VFw@mail.gmail.com>
Message-ID: <CAJF2gTQFZEpHK45hd9HXxHxJc4gaCuDQ4wZ2adDzHwGQjA6VFw@mail.gmail.com>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 3, 2023 at 4:50=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Wed, Aug 02, 2023 at 07:14:05PM -0400, Guo Ren wrote:
>
> > The pv_ops is belongs to x86 custom frame work, and it prevent other
> > architectures connect to the CNA spinlock.
>
> static_call() exists as a arch neutral variant of this.
Emm... we have used static_call() in the riscv queued_spin_lock_:
https://lore.kernel.org/all/20230802164701.192791-20-guoren@kernel.org/

But we met a compile problem:

  GEN     .vmlinux.objs
  MODPOST Module.symvers
ERROR: modpost: "__SCK__pv_queued_spin_unlock" [arch/riscv/kvm/kvm.ko]
undefined!
ERROR: modpost: "__SCK__pv_queued_spin_unlock"
[kernel/locking/locktorture.ko] undefined!
ERROR: modpost: "__SCK__pv_queued_spin_unlock" [mm/z3fold.ko] undefined!
ERROR: modpost: "__SCK__pv_queued_spin_unlock"
[fs/nfs_common/grace.ko] undefined!
ERROR: modpost: "__SCK__pv_queued_spin_unlock" [fs/quota/quota_v1.ko] undef=
ined!
ERROR: modpost: "__SCK__pv_queued_spin_unlock" [fs/quota/quota_v2.ko] undef=
ined!
ERROR: modpost: "__SCK__pv_queued_spin_unlock"
[fs/quota/quota_tree.ko] undefined!
ERROR: modpost: "__SCK__pv_queued_spin_unlock" [fs/fuse/virtiofs.ko] undefi=
ned!
ERROR: modpost: "__SCK__pv_queued_spin_unlock" [fs/dlm/dlm.ko] undefined!
ERROR: modpost: "__SCK__pv_queued_spin_unlock" [fs/fscache/fscache.ko]
undefined!
WARNING: modpost: suppressed 839 unresolved symbol warnings because
there were too many)
/home/guoren/source/kernel/linux/scripts/Makefile.modpost:144: recipe
for target 'Module.symvers' failed

Our solution is:
EXPORT_SYMBOL(__SCK__pv_queued_spin_unlock);

What do you think about it?

>
> > I'm working on riscv qspinlock on sg2042 64 cores 2/4 NUMA nodes
> > platforms. Here are the patches about riscv CNA qspinlock:
> > https://lore.kernel.org/linux-riscv/20230802164701.192791-19-guoren@ker=
nel.org/
> >
> > What's the next plan for this patch series? I think the two-queue desig=
n
> > has satisfied most platforms with two NUMA nodes.
>
> What has been your reason for working on CNA? What lock has been so
> contended you need this?
I wrote the reason here:
https://lore.kernel.org/all/20230802164701.192791-1-guoren@kernel.org/

The target platform is: https://www.sophon.ai/

The two NUMA nodes platform has come out, so we want to measure the
benefit of CNA qspinlock.

Any feedbacks are welcome :)

--=20
Best Regards
 Guo Ren
