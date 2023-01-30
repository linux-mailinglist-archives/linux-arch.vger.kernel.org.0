Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAAE68127F
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jan 2023 15:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237539AbjA3OVk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Jan 2023 09:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237674AbjA3OVY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Jan 2023 09:21:24 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96B340BD8
        for <linux-arch@vger.kernel.org>; Mon, 30 Jan 2023 06:20:16 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg26so2269322wmb.0
        for <linux-arch@vger.kernel.org>; Mon, 30 Jan 2023 06:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QVfyUaMlKe2XgKvP+3UZFMNGgzOkxpuMQuoaVQh0BKc=;
        b=AU5OTDUQfdokXPeFU5yQryz/q9qCxaUN91+qIhqfKpwMtoooFYxLZ+jyVqOWOOnFcm
         R9juG1J/K6NASljEygwMQHYkM9UwC2lChPae8ue/Z2qbu4y3wh3U4CIHGVkE4G9yWZe3
         w8b+MFuKkD0IIxf3m1WUq4rMdbLFawaBlmb0DBBOQbsF4cZ+epAFbH8OTYKoJEt6FRIU
         hhMUwxrm1K0edMp/noTFix8XechTBHb2fKw6XJnYPbuhlpBUNZW1DWBSLzy/8CpWjDz4
         RtQ8I4CGdwRZ1nODOxCei15r1vrC/tWP/Bvae6aII0GLmVkACD41/kg0eHHRFqwd7Epi
         Y5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVfyUaMlKe2XgKvP+3UZFMNGgzOkxpuMQuoaVQh0BKc=;
        b=mgIFgWasrKbXX/GLyiW7FIuUKR8eH+00gxqXM+fpCPalySR9kDFXUIWpFtXgMvOEce
         RlvtFGX1+0jmAzSPkh2YZfRrmfeSH5E+3vV4KEXVewkjV7aXlDZC1pizW0emhlY5CZS2
         u5AbGNyEIWqcgS8g0l73NLnL5T4d223NJh0LPYS3X5icYUYInAL41dadTm0XLuzkugfY
         XPOCOrQ7aRxJGoNQSvZ+KbNkVeGaPfb0xvL/GEGUjVzOwTmNmoNYf4PNb0EOR3dnWEDI
         us2NizI05znK6U8VoUkD/jXHyvIwxJ/u655CN/IdwndAG4EsrK1JILUCbXTiS2d9Ypox
         t3Hg==
X-Gm-Message-State: AO0yUKWhTxJldpr/ifyChwgaCa1MXZXFvD0h5Lccn6XBkzOSzrnOy1Q2
        oy+h5t7QKu84JCmON0EdsaNlrQ==
X-Google-Smtp-Source: AK7set/pqvBd/T/fnKgqYnfdEL/4TEGOcLzq7bpTeWO1f5GtFkVADlDjXe6AYRSdPNLc0ue8bBGsTw==
X-Received: by 2002:a05:600c:54e5:b0:3dc:4f2c:c856 with SMTP id jb5-20020a05600c54e500b003dc4f2cc856mr7773946wmb.32.1675088374692;
        Mon, 30 Jan 2023 06:19:34 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id e5-20020a05600c254500b003dc47fb33dasm8355006wma.18.2023.01.30.06.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 06:19:34 -0800 (PST)
Date:   Mon, 30 Jan 2023 15:19:33 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v4] riscv: Use PUD/P4D/PGD pages for the linear mapping
Message-ID: <20230130141933.wuikrruh2svkcfv4@orel>
References: <20230123112803.817534-1-alexghiti@rivosinc.com>
 <20230123142554.f22ajf6upfk2ybxk@orel>
 <20230125104102.2thvourt3lx2p36a@orel>
 <CAHVXubjUCmk6xGTCPzMujYqKUwE0bhQBqd8A+=yq7ijQZtBObg@mail.gmail.com>
 <CAL_JsqJ8JtkOBLpdf3hU9JWcdRTFr3Ss1Hd+yFpMqs7ujUiyCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ8JtkOBLpdf3hU9JWcdRTFr3Ss1Hd+yFpMqs7ujUiyCQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 30, 2023 at 07:48:04AM -0600, Rob Herring wrote:
> On Wed, Jan 25, 2023 at 6:13 AM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
> >
> > On Wed, Jan 25, 2023 at 11:41 AM Andrew Jones <ajones@ventanamicro.com> wrote:
> > >
> > > On Mon, Jan 23, 2023 at 03:25:54PM +0100, Andrew Jones wrote:
> > > > On Mon, Jan 23, 2023 at 12:28:02PM +0100, Alexandre Ghiti wrote:
> > > > > During the early page table creation, we used to set the mapping for
> > > > > PAGE_OFFSET to the kernel load address: but the kernel load address is
> > > > > always offseted by PMD_SIZE which makes it impossible to use PUD/P4D/PGD
> > > > > pages as this physical address is not aligned on PUD/P4D/PGD size (whereas
> > > > > PAGE_OFFSET is).
> 
> [...]
> 
> > > > > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > > > > index f08b25195ae7..58107bd56f8f 100644
> > > > > --- a/drivers/of/fdt.c
> > > > > +++ b/drivers/of/fdt.c
> > > > > @@ -891,12 +891,13 @@ const void * __init of_flat_dt_match_machine(const void *default_match,
> > > > >  static void __early_init_dt_declare_initrd(unsigned long start,
> > > > >                                        unsigned long end)
> > > > >  {
> > > > > -   /* ARM64 would cause a BUG to occur here when CONFIG_DEBUG_VM is
> > > > > -    * enabled since __va() is called too early. ARM64 does make use
> > > > > -    * of phys_initrd_start/phys_initrd_size so we can skip this
> > > > > -    * conversion.
> > > > > +   /*
> > > > > +    * __va() is not yet available this early on some platforms. In that
> > > > > +    * case, the platform uses phys_initrd_start/phys_initrd_size instead
> > > > > +    * and does the VA conversion itself.
> > > > >      */
> > > > > -   if (!IS_ENABLED(CONFIG_ARM64)) {
> > > > > +   if (!IS_ENABLED(CONFIG_ARM64) &&
> > > > > +       !(IS_ENABLED(CONFIG_RISCV) && IS_ENABLED(CONFIG_64BIT))) {
> > > >
> > > > There are now two architectures, so maybe it's time for a new config
> > > > symbol which would be selected by arm64 and riscv64 and then used here,
> > > > e.g.
> > > >
> > > >   if (!IS_ENABLED(CONFIG_NO_EARLY_LINEAR_MAP)) {
> > >
> > > I see v5 left this as it was. Any comment on this suggestion?
> >
> > Introducing a config for this only use case sounds excessive to me,
> > but I'll let Rob decide what he wants to see here.
> 
> Agreed. Can we just keep it as is here.
> 
> > > > >             initrd_start = (unsigned long)__va(start);
> > > > >             initrd_end = (unsigned long)__va(end);
> 
> I think long term, we should just get rid of needing to do this part
> in the DT code and let the initrd code do this.

initrd code provides reserve_initrd_mem() for this and riscv calls
it later on. afaict, this early setting in OF code is a convenience
which architectures could be taught not to depend on, and then it
could be removed. But, until then, some architectures will need to
avoid it. As I commented downthread, I also don't want to go with
a config anymore, but it'd be nice to keep arch-specifics out of
here, so I've posted a patch changing __early_init_dt_declare_initrd
to be a weak function.

Thanks,
drew
