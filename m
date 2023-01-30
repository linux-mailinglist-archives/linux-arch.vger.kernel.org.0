Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D722680F43
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jan 2023 14:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbjA3NsX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Jan 2023 08:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbjA3NsW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Jan 2023 08:48:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517D12941D;
        Mon, 30 Jan 2023 05:48:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1105B81116;
        Mon, 30 Jan 2023 13:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E29C4339E;
        Mon, 30 Jan 2023 13:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675086497;
        bh=+iz7/0m+hEIPyBQg3I/82VjHc01NMeldbSQt2dqGcSg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R9sDP955tHpJ1QqsR0L3i+gv+cjOVpaU84PSIDDhw30Zfl75NL7qlIA2Ek9QCOvOs
         f+80E8rQ53TD2AN3Y/fjhXCl/P394lhf7L+pmSgNTulhP9LTLp6wF6rENXVPR99t4q
         P7PT9uexAhtg0aTWMcOYFA3CSWm9/gLd1V6rPdGhjNkwjeN/4nwM9wJRlxmuhyahod
         oB/uATlvf3mMQn1UmbUNCfzcUWCJKUY9gGnL/RqnIJP6gJ9vUwQcc9VGeaLhCHOMJe
         qUvl/iPosG3dy0T8Zw5/MXdW5+nM7hxAjDtIxxYz/Dkt76O6zY7CAxhzYf6xfll6wU
         3fXZBoZjE6a5g==
Received: by mail-vs1-f44.google.com with SMTP id s24so5118292vsi.12;
        Mon, 30 Jan 2023 05:48:17 -0800 (PST)
X-Gm-Message-State: AFqh2kr+v+o3ek47rwjxnLP3xhK7Lxq54kmW6KFPxT6FOBhAl32Qur7i
        FQndBs0XLHw5FxhNwniM85ZYZR829H23CPw2Bg==
X-Google-Smtp-Source: AMrXdXvWFxwf7o8XYdZZzxKLXqR1OblZ1Jf42fyF9cWbecmrBhoaNv2NX636Gi1FINWWYnmBotKarycuGbTuFd70diw=
X-Received: by 2002:a05:6102:5490:b0:3b5:1fe4:f1c2 with SMTP id
 bk16-20020a056102549000b003b51fe4f1c2mr6746365vsb.0.1675086496230; Mon, 30
 Jan 2023 05:48:16 -0800 (PST)
MIME-Version: 1.0
References: <20230123112803.817534-1-alexghiti@rivosinc.com>
 <20230123142554.f22ajf6upfk2ybxk@orel> <20230125104102.2thvourt3lx2p36a@orel> <CAHVXubjUCmk6xGTCPzMujYqKUwE0bhQBqd8A+=yq7ijQZtBObg@mail.gmail.com>
In-Reply-To: <CAHVXubjUCmk6xGTCPzMujYqKUwE0bhQBqd8A+=yq7ijQZtBObg@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 30 Jan 2023 07:48:04 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ8JtkOBLpdf3hU9JWcdRTFr3Ss1Hd+yFpMqs7ujUiyCQ@mail.gmail.com>
Message-ID: <CAL_JsqJ8JtkOBLpdf3hU9JWcdRTFr3Ss1Hd+yFpMqs7ujUiyCQ@mail.gmail.com>
Subject: Re: [PATCH v4] riscv: Use PUD/P4D/PGD pages for the linear mapping
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 25, 2023 at 6:13 AM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>
> On Wed, Jan 25, 2023 at 11:41 AM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Mon, Jan 23, 2023 at 03:25:54PM +0100, Andrew Jones wrote:
> > > On Mon, Jan 23, 2023 at 12:28:02PM +0100, Alexandre Ghiti wrote:
> > > > During the early page table creation, we used to set the mapping for
> > > > PAGE_OFFSET to the kernel load address: but the kernel load address is
> > > > always offseted by PMD_SIZE which makes it impossible to use PUD/P4D/PGD
> > > > pages as this physical address is not aligned on PUD/P4D/PGD size (whereas
> > > > PAGE_OFFSET is).

[...]

> > > > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > > > index f08b25195ae7..58107bd56f8f 100644
> > > > --- a/drivers/of/fdt.c
> > > > +++ b/drivers/of/fdt.c
> > > > @@ -891,12 +891,13 @@ const void * __init of_flat_dt_match_machine(const void *default_match,
> > > >  static void __early_init_dt_declare_initrd(unsigned long start,
> > > >                                        unsigned long end)
> > > >  {
> > > > -   /* ARM64 would cause a BUG to occur here when CONFIG_DEBUG_VM is
> > > > -    * enabled since __va() is called too early. ARM64 does make use
> > > > -    * of phys_initrd_start/phys_initrd_size so we can skip this
> > > > -    * conversion.
> > > > +   /*
> > > > +    * __va() is not yet available this early on some platforms. In that
> > > > +    * case, the platform uses phys_initrd_start/phys_initrd_size instead
> > > > +    * and does the VA conversion itself.
> > > >      */
> > > > -   if (!IS_ENABLED(CONFIG_ARM64)) {
> > > > +   if (!IS_ENABLED(CONFIG_ARM64) &&
> > > > +       !(IS_ENABLED(CONFIG_RISCV) && IS_ENABLED(CONFIG_64BIT))) {
> > >
> > > There are now two architectures, so maybe it's time for a new config
> > > symbol which would be selected by arm64 and riscv64 and then used here,
> > > e.g.
> > >
> > >   if (!IS_ENABLED(CONFIG_NO_EARLY_LINEAR_MAP)) {
> >
> > I see v5 left this as it was. Any comment on this suggestion?
>
> Introducing a config for this only use case sounds excessive to me,
> but I'll let Rob decide what he wants to see here.

Agreed. Can we just keep it as is here.

> > > >             initrd_start = (unsigned long)__va(start);
> > > >             initrd_end = (unsigned long)__va(end);

I think long term, we should just get rid of needing to do this part
in the DT code and let the initrd code do this.

Rob
