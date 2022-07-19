Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC3F579E3C
	for <lists+linux-arch@lfdr.de>; Tue, 19 Jul 2022 14:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242401AbiGSM7I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jul 2022 08:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242521AbiGSM6d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jul 2022 08:58:33 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC525F12B;
        Tue, 19 Jul 2022 05:23:38 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id b7-20020a17090a12c700b001f20eb82a08so597617pjg.3;
        Tue, 19 Jul 2022 05:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kIYV5VQPGWT9n+zj1ToFYouxX7n+Y2qnPZPLUj/fcdA=;
        b=NKy5nlv/FgYWq5UB602U/dYy8pXGBSA/jwkZtdtOKtDZ4vPJ/6EEjuzkkAzArMrwN3
         FuQlR0H4BF/mtLJNlyQaig3CLYvbQeeAqr2FGyTUh7s77maURmahcOE/pizZU1PMAPrA
         DA4prFvpVk+1ECNLWdiC8Ge3GseJM+xz8nqjXk4bk4wvfAlQQoVSmGSGdGVIbN4JBQfY
         Odz7jQVRqsxY9dfuWtS6ADjjOJb/iZq6d7B4oaw9B/tgdW55wluuTmosyHe/YrSBWxes
         hK5Dj19eLFoffro358zde7A0JTdg2Tk5Zg7ncOqlrsMEbldY48cHS5bO06Rd1EUyEx+5
         Ldhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kIYV5VQPGWT9n+zj1ToFYouxX7n+Y2qnPZPLUj/fcdA=;
        b=6CMAPZd/6SgeB6kwYCEZ5XoWXyM5ubDLTr1GLHBnf46fBcAnIcPqnuiuA/2Xg+k5fd
         yZTQ+F8YOrUOEdJdD7SCEniBZPcFtobiBYNDYuMTRhvbsVs6MCduLkaj04WMrahh611F
         0IWm9RIZ0CG56DSlZk9T2bDulDl+v6XmrXEfLoQ2nHpFtPBVkxEe46dualjRKP3xfqSj
         IQwa+KSwpVjD0NSzFKBCMYbzflgHIVyHJVXqFuE0NOg/N9RwsBEQ72+QPGw72lLuhss4
         dpnzoKkrYF1aKfHIGIK4TVdxpln18beUkQqVt3hw+fvTZHhW14GkfmFaEjywVCefG6AH
         v2Bw==
X-Gm-Message-State: AJIora95c0D3Juz3u7nV2xbPcQniVexC3zSDfx9GuaoqJ7ZPlo8oN60E
        j5BmtbmmvKVFGpv5/cpe8nU=
X-Google-Smtp-Source: AGRyM1tV/ZXqUclGzygmdbB9fkVeLqpHz5v6xGriFND4vNwQKgaV2SfSn2yac7l86GveLLylCjLTdw==
X-Received: by 2002:a17:903:18c:b0:16c:51c6:675d with SMTP id z12-20020a170903018c00b0016c51c6675dmr32808811plg.153.1658233418097;
        Tue, 19 Jul 2022 05:23:38 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id cp16-20020a170902e79000b0016397da033csm11416832plb.62.2022.07.19.05.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 05:23:37 -0700 (PDT)
Date:   Tue, 19 Jul 2022 21:23:36 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] asm-generic: Add new pci.h and use it
Message-ID: <YtaiSEAnMhVqR4HS@antec>
References: <20220717033453.2896843-1-shorne@gmail.com>
 <20220717033453.2896843-3-shorne@gmail.com>
 <YtTjeEnKr8f8z4JS@infradead.org>
 <CAK8P3a1KJe4K5g1z-Faoxc9NhXqjCUWxnvk2HPxsj2wzG_iDbg@mail.gmail.com>
 <CAAfxs740yz1vJmtFHOPTXT6fqi0+37SR_OhoGsONe4mx_21+_g@mail.gmail.com>
 <CAK8P3a1Mo9+-t21rkP8SDnPrmbj3-uuVPtmHbeUerAevxN3TNw@mail.gmail.com>
 <YtaNvpE7AA/4eV1I@antec>
 <CAK8P3a2UTND+F83k2uQ+f=o1GWV=oa5coshy8Hy+cKHUGuNzEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2UTND+F83k2uQ+f=o1GWV=oa5coshy8Hy+cKHUGuNzEg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 19, 2022 at 01:55:03PM +0200, Arnd Bergmann wrote:
> On Tue, Jul 19, 2022 at 12:55 PM Stafford Horne <shorne@gmail.com> wrote:
> 
> > diff --git a/drivers/comedi/drivers/comedi_isadma.c b/drivers/comedi/drivers/comedi_isadma.c
> > index 700982464c53..508421809128 100644
> > --- a/drivers/comedi/drivers/comedi_isadma.c
> > +++ b/drivers/comedi/drivers/comedi_isadma.c
> > @@ -104,8 +104,10 @@ unsigned int comedi_isadma_poll(struct comedi_isadma *dma)
> >
> >         flags = claim_dma_lock();
> >         clear_dma_ff(desc->chan);
> > +#ifdef CONFIG_X86_32
> >         if (!isa_dma_bridge_buggy)
> >                 disable_dma(desc->chan);
> > +#endif
> 
> There is a logic mistake here: if we are on something other than x86-32,
> this always needs to call the disable_dma()/enable_dma().

Oops, thats right.  Sorry, I should have noticed that.

> Not sure how to best express this in a readable way, something like this
> would work:

Option 1:

> #ifdef CONFIG_X86_32
>         if (!isa_dma_bridge_buggy)
> #endif
>                disable_dma(desc->chan);
> 
> 
> or possibly at the start of this file, a

Option 2:

> #ifndef CONFIG_X86_32
> #define isa_dma_bridge_buggy 0
> #endif

Option 3:

> Or we could try to keep the generic definition in a global header
> like linux/isa-dma.h.

Perhaps option 3 makes the whole patch the most clean.

-Stafford
