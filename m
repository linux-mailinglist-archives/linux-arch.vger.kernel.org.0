Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87ACC58D646
	for <lists+linux-arch@lfdr.de>; Tue,  9 Aug 2022 11:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbiHIJTu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Aug 2022 05:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238223AbiHIJTr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Aug 2022 05:19:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8311C920;
        Tue,  9 Aug 2022 02:19:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D544CB81142;
        Tue,  9 Aug 2022 09:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B69CC433D7;
        Tue,  9 Aug 2022 09:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660036783;
        bh=PMJRh8e7OTeWipNklYA2zTpVEwkTtbxLgQSwPCaNZtk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NM1+GjZqg1wZjZaHB+SmPZUK482J8AnSqOgq4oQARPbk7ANjrarejPsYu4wXxkhuF
         jnBAel3UtjLHBMFIsFIKKITrVQy3gKCwUeq74/LCC+Y8Ryp+q6eEO5lX/3nwj1tW3q
         R+JnBjTMWUYWrbeqmL8G4NDlBw2wvdByf0M52y5Faqu9qSUqtIU76hG0a/Z62zC7zK
         feO3EI/LAMrlF98F6yKBogBHmvq+WIfpFXy0oIWAHx543E/o53z3Wvng9JPmk8sdst
         YcFu8WMjZ1GbuZDVXh5ofirCNsKyDyGfJeVVszdBElSnBrtnnMbVdHcgRLdtbcsnQp
         Gi7la4irkfrtA==
Received: by mail-vs1-f51.google.com with SMTP id 66so11277356vse.4;
        Tue, 09 Aug 2022 02:19:43 -0700 (PDT)
X-Gm-Message-State: ACgBeo3PERJOf4ttSxOV77lrGSCc85FR+mRHnA4mDBRwmJ4PsaL4DTvC
        99cSp0Gin+pABSt3N8YmlqP29oFJkLQTlkAsPxw=
X-Google-Smtp-Source: AA6agR42meX/+NjsOFnbbcXcwzuiceqHqFCKiIpIThdmXaacoYQmvjm7Esmbp23WQf4csYAOhMgD3XZBcgi9kxCdw/s=
X-Received: by 2002:a67:d487:0:b0:385:1a6b:6f33 with SMTP id
 g7-20020a67d487000000b003851a6b6f33mr9044184vsj.59.1660036782585; Tue, 09 Aug
 2022 02:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220809074522.2444672-1-chenhuacai@loongson.cn> <874jylx0ad.wl-maz@kernel.org>
In-Reply-To: <874jylx0ad.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 9 Aug 2022 17:19:31 +0800
X-Gmail-Original-Message-ID: <CAAhV-H50HERxjrmfDkSaHAVY7Q_ufpZP-e+qdZWVd=qEuQVXBg@mail.gmail.com>
Message-ID: <CAAhV-H50HERxjrmfDkSaHAVY7Q_ufpZP-e+qdZWVd=qEuQVXBg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Don't disable EIOINTC master core
To:     Marc Zyngier <maz@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Marc,

On Tue, Aug 9, 2022 at 4:56 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 09 Aug 2022 08:45:22 +0100,
> Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > This patch fix a CPU hotplug issue. The EIOINTC master core (the first
> > core of an EIOINTC node) should not be disabled at runtime, since it has
> > the responsibility of dispatching I/O interrupts.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  arch/loongarch/kernel/smp.c            | 9 +++++++++
> >  drivers/irqchip/irq-loongson-eiointc.c | 5 +++++
> >  2 files changed, 14 insertions(+)
> >
> > diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> > index 09743103d9b3..54901716f8de 100644
> > --- a/arch/loongarch/kernel/smp.c
> > +++ b/arch/loongarch/kernel/smp.c
> > @@ -242,9 +242,18 @@ void loongson3_smp_finish(void)
> >
> >  static bool io_master(int cpu)
> >  {
> > +     int i, node, master;
> > +
> >       if (cpu == 0)
> >               return true;
> >
> > +     for (i = 1; i < loongson_sysconf.nr_io_pics; i++) {
> > +             node = eiointc_get_node(i);
> > +             master = cpu_number_map(node * CORES_PER_EIO_NODE);
> > +             if (cpu == master)
> > +                     return true;
> > +     }
> > +
> >       return false;
> >  }
> >
> > diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
> > index 170dbc96c7d3..6c99a2ff95f5 100644
> > --- a/drivers/irqchip/irq-loongson-eiointc.c
> > +++ b/drivers/irqchip/irq-loongson-eiointc.c
> > @@ -56,6 +56,11 @@ static void eiointc_enable(void)
> >       iocsr_write64(misc, LOONGARCH_IOCSR_MISC_FUNC);
> >  }
> >
> > +int eiointc_get_node(int id)
> > +{
> > +     return eiointc_priv[id]->node;
> > +}
> > +
> >  static int cpu_to_eio_node(int cpu)
> >  {
> >       return cpu_logical_map(cpu) / CORES_PER_EIO_NODE;
>
>
> I don't understand why it has to be this complex and make any use of
> the node number.
>
> As I understand it, CPU-0 in any EIOINTC block is a master. So all you
> need to find out is whether the CPU number is a multiple of
> CORES_PER_EIO_NODE.
CPU-0 in any EIOINTC block may be a master, but not absolutely be a
master to dispatch I/O interrupts. If there is no bridge under a
EIOINTC, then this EIOINTC doesn't handle I/O interrupts, and it can
be disabled at runtime.

Huacai
>
> Something like:
>
>         return (cpu_logical_map(cpu) % CORES_PER_EIO_NODE) == 0;
>
> which doesn't require exporting anything from anywhere?
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
