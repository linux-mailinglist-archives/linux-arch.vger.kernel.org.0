Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FF06813E8
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jan 2023 15:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjA3O6O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Jan 2023 09:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjA3O6N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Jan 2023 09:58:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E744D10409;
        Mon, 30 Jan 2023 06:58:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A82B6108D;
        Mon, 30 Jan 2023 14:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3774C4339B;
        Mon, 30 Jan 2023 14:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675090691;
        bh=Dy66gCGzyPJcLshQJwfc5AQ29gXjKkXX0fJ1HpNtqwk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gYqf0JfKAi2YFZvsQKEL8rfw9E+3lUBZ8U+ovluM5yP0y4/2CFeGC0dvsrc6zn/I2
         Z1301CJFV09w/xcFhLBEUsY8oTIbDfVHSakHdpEsPet7yTcztpc3Z8xx6vnw4KtRZA
         g2CgMl/0BLDVWXLA1qvBkPBvZaVyfbH1HUmCWP0V6Vh27xMFFMpGrszh7JW8KHuOvW
         YiZTBWMIhxUoOAwfQpitjqXC1Od8m2KhVek31DeUnT9TAo/k58HBORyLR3VBywLkqN
         HE1oUX9hcbDWGbPdZg/3xeo/ABOFuEjg8mxy0btEE9mbxQTg1ayWF4rQ+pGqXz6t85
         /qSYKvDC4/l/A==
Received: by mail-vk1-f171.google.com with SMTP id bs10so5854893vkb.3;
        Mon, 30 Jan 2023 06:58:11 -0800 (PST)
X-Gm-Message-State: AO0yUKVFuQ6nE68B1sz/ABscFhQQFjONWLWAbvBM58+/m3l4XM6J6HoI
        /wa6n3p9Kd/ej81hdqW7Sgwfm6Pq8xRFfnp2UQ==
X-Google-Smtp-Source: AK7set9svEjsdOnCKyk10Z9orQXpAu0MQ19gFzSd4yUat7bVea/0tlPfgDkyR8ht9EtvCpLlVMcChGgiQFZ47mwWGzg=
X-Received: by 2002:a1f:eec2:0:b0:3ea:1a72:aad6 with SMTP id
 m185-20020a1feec2000000b003ea1a72aad6mr899057vkh.15.1675090690804; Mon, 30
 Jan 2023 06:58:10 -0800 (PST)
MIME-Version: 1.0
References: <20230123112803.817534-1-alexghiti@rivosinc.com>
 <20230123142554.f22ajf6upfk2ybxk@orel> <20230125104102.2thvourt3lx2p36a@orel>
 <CAHVXubjUCmk6xGTCPzMujYqKUwE0bhQBqd8A+=yq7ijQZtBObg@mail.gmail.com>
 <CAL_JsqJ8JtkOBLpdf3hU9JWcdRTFr3Ss1Hd+yFpMqs7ujUiyCQ@mail.gmail.com> <20230130141933.wuikrruh2svkcfv4@orel>
In-Reply-To: <20230130141933.wuikrruh2svkcfv4@orel>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 30 Jan 2023 08:57:58 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJdBGAOELLTQbfi6Q3r-AnS5Wf8VNf94BP6Y9TNvPHS-w@mail.gmail.com>
Message-ID: <CAL_JsqJdBGAOELLTQbfi6Q3r-AnS5Wf8VNf94BP6Y9TNvPHS-w@mail.gmail.com>
Subject: Re: [PATCH v4] riscv: Use PUD/P4D/PGD pages for the linear mapping
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 30, 2023 at 8:19 AM Andrew Jones <ajones@ventanamicro.com> wrote:
>
> On Mon, Jan 30, 2023 at 07:48:04AM -0600, Rob Herring wrote:
> > On Wed, Jan 25, 2023 at 6:13 AM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
> > >
> > > On Wed, Jan 25, 2023 at 11:41 AM Andrew Jones <ajones@ventanamicro.com> wrote:
> > > >
> > > > On Mon, Jan 23, 2023 at 03:25:54PM +0100, Andrew Jones wrote:
> > > > > On Mon, Jan 23, 2023 at 12:28:02PM +0100, Alexandre Ghiti wrote:
> > > > > > During the early page table creation, we used to set the mapping for
> > > > > > PAGE_OFFSET to the kernel load address: but the kernel load address is
> > > > > > always offseted by PMD_SIZE which makes it impossible to use PUD/P4D/PGD
> > > > > > pages as this physical address is not aligned on PUD/P4D/PGD size (whereas
> > > > > > PAGE_OFFSET is).
> >
> > [...]
> >
> > > > > > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > > > > > index f08b25195ae7..58107bd56f8f 100644
> > > > > > --- a/drivers/of/fdt.c
> > > > > > +++ b/drivers/of/fdt.c
> > > > > > @@ -891,12 +891,13 @@ const void * __init of_flat_dt_match_machine(const void *default_match,
> > > > > >  static void __early_init_dt_declare_initrd(unsigned long start,
> > > > > >                                        unsigned long end)
> > > > > >  {
> > > > > > -   /* ARM64 would cause a BUG to occur here when CONFIG_DEBUG_VM is
> > > > > > -    * enabled since __va() is called too early. ARM64 does make use
> > > > > > -    * of phys_initrd_start/phys_initrd_size so we can skip this
> > > > > > -    * conversion.
> > > > > > +   /*
> > > > > > +    * __va() is not yet available this early on some platforms. In that
> > > > > > +    * case, the platform uses phys_initrd_start/phys_initrd_size instead
> > > > > > +    * and does the VA conversion itself.
> > > > > >      */
> > > > > > -   if (!IS_ENABLED(CONFIG_ARM64)) {
> > > > > > +   if (!IS_ENABLED(CONFIG_ARM64) &&
> > > > > > +       !(IS_ENABLED(CONFIG_RISCV) && IS_ENABLED(CONFIG_64BIT))) {
> > > > >
> > > > > There are now two architectures, so maybe it's time for a new config
> > > > > symbol which would be selected by arm64 and riscv64 and then used here,
> > > > > e.g.
> > > > >
> > > > >   if (!IS_ENABLED(CONFIG_NO_EARLY_LINEAR_MAP)) {
> > > >
> > > > I see v5 left this as it was. Any comment on this suggestion?
> > >
> > > Introducing a config for this only use case sounds excessive to me,
> > > but I'll let Rob decide what he wants to see here.
> >
> > Agreed. Can we just keep it as is here.
> >
> > > > > >             initrd_start = (unsigned long)__va(start);
> > > > > >             initrd_end = (unsigned long)__va(end);
> >
> > I think long term, we should just get rid of needing to do this part
> > in the DT code and let the initrd code do this.
>
> initrd code provides reserve_initrd_mem() for this and riscv calls
> it later on. afaict, this early setting in OF code is a convenience
> which architectures could be taught not to depend on, and then it
> could be removed. But, until then, some architectures will need to
> avoid it. As I commented downthread, I also don't want to go with
> a config anymore, but it'd be nice to keep arch-specifics out of
> here, so I've posted a patch changing __early_init_dt_declare_initrd
> to be a weak function.

If this was *always* going to be architecture specific, then I'd
agree. But I think there are better paths to refactor this. I don't
want to go back to a weak function and encourage more implementations
of __early_init_dt_declare_initrd().

Rob
