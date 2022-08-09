Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2834B58DAE6
	for <lists+linux-arch@lfdr.de>; Tue,  9 Aug 2022 17:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244810AbiHIPQe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Aug 2022 11:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244796AbiHIPQd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Aug 2022 11:16:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631189584;
        Tue,  9 Aug 2022 08:16:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2FE76123F;
        Tue,  9 Aug 2022 15:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6531FC43470;
        Tue,  9 Aug 2022 15:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660058191;
        bh=ZZmpyVI8I1kh68ShHGKxQCHeZ2REZdHoKN5fbFNYOdg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PQWHy2SPcL7dgEHL1Yz1o8922DtlC98S4FT1To6tnhTmgJcW5pnZeSvxWsMvFUWKa
         VFlLzsGD5okxtWhWZb5siF4e2Ntd6x+vJE0TorEosvTe+UeHpdQ9YQA45qfcSZ2H2c
         cTDUJbkZkMI5h4sDRTr6O6uXvd2ilWcxRdYMEZ6NJOz5qTJlif/xuJXq2QaO6lQZar
         ZbdWJ9FJz5CK31J+Rg2KsVliQv8GgymIucXTL41ML18mLikYj0rjMW/31IMAq/ptQz
         eZ5fS/DVJwVPyn0i5P0KOWerdHw9HbdmMREV42U0izpLf5azJdum+K4m8xG67oXNJu
         DhONLeT3LvBag==
Received: by mail-ua1-f51.google.com with SMTP id cd25so2286411uab.8;
        Tue, 09 Aug 2022 08:16:31 -0700 (PDT)
X-Gm-Message-State: ACgBeo1M1jz9ItpK8Bienao7WwLN2msTv3XUSg0NMyY9WF2JzA4V/8SF
        HxX5jqpE8fkGhoPbQoDuGrMKgCaUNKhUflcY968=
X-Google-Smtp-Source: AA6agR5tysY7A38f+hqoTwC2UgCpgcNByDx0vc3dIW3Es6en7Kl3+5Tq4HNOoek5iaHSVWLrX5nhfKrei66pqd5pvrw=
X-Received: by 2002:ab0:6716:0:b0:38c:cdcd:1556 with SMTP id
 q22-20020ab06716000000b0038ccdcd1556mr3422553uam.63.1660058190333; Tue, 09
 Aug 2022 08:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220809074522.2444672-1-chenhuacai@loongson.cn>
 <874jylx0ad.wl-maz@kernel.org> <CAAhV-H50HERxjrmfDkSaHAVY7Q_ufpZP-e+qdZWVd=qEuQVXBg@mail.gmail.com>
 <871qtpwwem.wl-maz@kernel.org> <CAAhV-H4ZCmenrPvzLCaZZn57NoiGpQfVGpXg42DE2JevF4Tf9w@mail.gmail.com>
 <87y1vxvari.wl-maz@kernel.org>
In-Reply-To: <87y1vxvari.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 9 Aug 2022 23:16:14 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5teVJTsYx7v68N+DStg-SM8Qvxqi75PXk=VQJyvak0XA@mail.gmail.com>
Message-ID: <CAAhV-H5teVJTsYx7v68N+DStg-SM8Qvxqi75PXk=VQJyvak0XA@mail.gmail.com>
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

On Tue, Aug 9, 2022 at 8:53 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 09 Aug 2022 11:39:15 +0100,
> Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > Hi, Marc,
> >
> > On Tue, Aug 9, 2022 at 6:20 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Tue, 09 Aug 2022 10:19:31 +0100,
> > > Huacai Chen <chenhuacai@kernel.org> wrote:
> > > >
> > > > Hi, Marc,
> > > >
> > > > On Tue, Aug 9, 2022 at 4:56 PM Marc Zyngier <maz@kernel.org> wrote:
> > > > >
> > > > > On Tue, 09 Aug 2022 08:45:22 +0100,
> > > > > Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > > > >
> > > > > > This patch fix a CPU hotplug issue. The EIOINTC master core (the first
> > > > > > core of an EIOINTC node) should not be disabled at runtime, since it has
> > > > > > the responsibility of dispatching I/O interrupts.
> > > > > >
> > > > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > > > ---
> > > > > >  arch/loongarch/kernel/smp.c            | 9 +++++++++
> > > > > >  drivers/irqchip/irq-loongson-eiointc.c | 5 +++++
> > > > > >  2 files changed, 14 insertions(+)
> > > > > >
> > > > > > diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> > > > > > index 09743103d9b3..54901716f8de 100644
> > > > > > --- a/arch/loongarch/kernel/smp.c
> > > > > > +++ b/arch/loongarch/kernel/smp.c
> > > > > > @@ -242,9 +242,18 @@ void loongson3_smp_finish(void)
> > > > > >
> > > > > >  static bool io_master(int cpu)
> > > > > >  {
> > > > > > +     int i, node, master;
> > > > > > +
> > > > > >       if (cpu == 0)
> > > > > >               return true;
> > > > > >
> > > > > > +     for (i = 1; i < loongson_sysconf.nr_io_pics; i++) {
> > > > > > +             node = eiointc_get_node(i);
> > > > > > +             master = cpu_number_map(node * CORES_PER_EIO_NODE);
> > > > > > +             if (cpu == master)
> > > > > > +                     return true;
> > > > > > +     }
> > > > > > +
> > > > > >       return false;
> > > > > >  }
> > > > > >
> > > > > > diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
> > > > > > index 170dbc96c7d3..6c99a2ff95f5 100644
> > > > > > --- a/drivers/irqchip/irq-loongson-eiointc.c
> > > > > > +++ b/drivers/irqchip/irq-loongson-eiointc.c
> > > > > > @@ -56,6 +56,11 @@ static void eiointc_enable(void)
> > > > > >       iocsr_write64(misc, LOONGARCH_IOCSR_MISC_FUNC);
> > > > > >  }
> > > > > >
> > > > > > +int eiointc_get_node(int id)
> > > > > > +{
> > > > > > +     return eiointc_priv[id]->node;
> > > > > > +}
> > > > > > +
> > > > > >  static int cpu_to_eio_node(int cpu)
> > > > > >  {
> > > > > >       return cpu_logical_map(cpu) / CORES_PER_EIO_NODE;
> > > > >
> > > > >
> > > > > I don't understand why it has to be this complex and make any use of
> > > > > the node number.
> > > > >
> > > > > As I understand it, CPU-0 in any EIOINTC block is a master. So all you
> > > > > need to find out is whether the CPU number is a multiple of
> > > > > CORES_PER_EIO_NODE.
> > > > CPU-0 in any EIOINTC block may be a master, but not absolutely be a
> > > > master to dispatch I/O interrupts. If there is no bridge under a
> > > > EIOINTC, then this EIOINTC doesn't handle I/O interrupts, and it can
> > > > be disabled at runtime.
> > >
> > > But that's not what your code is checking, is it? You're only
> > > reporting the node number, irrespective of whether there is anything
> > > behind the EIOINTC.
> > The return value of eiointc_get_node() means "this eio-node has a
> > downstream bridge, so the master core of this eio-node cannot be
> > disabled". :)
>
> So what is exactly the meaning of this node? All the EIOINTCs do have
> one (it is coming from ACPI, and taken at face value), so the node
> really is only a proxy for the CPU numbers that are attached to it,
> isn't it? Can you have cores without an EIOINTC?
>
> Now, if this is relevant to the arch code, I'd rather you keep track
> of this directly in the arch code, because it looks really odd to peek
> at an irqchip data structure for something that the core code should
> have the first place.
Emm, yes, you are right, this problem seems can be solved by only
touching the arch code. Thanks.

Huacai
>
> It also strikes me that this patch has *zero* effect, as nothing ever
> sets loongson_sysconf.nr_io_pics. Try this:
>
> diff --git a/arch/loongarch/include/asm/bootinfo.h b/arch/loongarch/include/asm/bootinfo.h
> index 9b8d49d9e61b..13e5e5e21ffd 100644
> --- a/arch/loongarch/include/asm/bootinfo.h
> +++ b/arch/loongarch/include/asm/bootinfo.h
> @@ -28,7 +28,7 @@ struct loongson_board_info {
>  struct loongson_system_configuration {
>         int nr_cpus;
>         int nr_nodes;
> -       int nr_io_pics;
> +//     int nr_io_pics;
>         int boot_cpu_id;
>         int cores_per_node;
>         int cores_per_package;
>
> and see that the kernel still compiles.
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
