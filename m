Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BBF67F6F7
	for <lists+linux-arch@lfdr.de>; Sat, 28 Jan 2023 11:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbjA1KNZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 28 Jan 2023 05:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjA1KNX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 28 Jan 2023 05:13:23 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E83633478
        for <linux-arch@vger.kernel.org>; Sat, 28 Jan 2023 02:13:21 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id u21so6794444edv.3
        for <linux-arch@vger.kernel.org>; Sat, 28 Jan 2023 02:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sFlpJNoGBOazM9CU1KCnJW9Pwymj7pBp6JXDNmhBuT8=;
        b=m9tOjpSpKEb5QibVEue38Iap0SxF/gAOKE3vqNe4CJxeZhtNcrgxnvCjmkRVcanIn7
         JQyYFKW8n30551zAdA1noAvagUG9gVRT8vEI3Bzl/EdeTSiD9H88NrnAmDv42iE7Knfs
         cltndUPYkBZffCA+y+ZFekfjKGv0C9+HBH7491Xee9Uh6hgjWTv15jsjxAa3Ses9NnqS
         a3gU14supwACH3ccwf1zGunLSmMYcSVoQebCgjJsTv7dHHoTFOMVrLJGX5jxZB+yWA8d
         uBmsUEheDLNHH6IA1XSBYkAK9uhBvxI5Itr67YYu0wRbXDbhwD0cRTwAXqR/YSHvZrEU
         jA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFlpJNoGBOazM9CU1KCnJW9Pwymj7pBp6JXDNmhBuT8=;
        b=xsZRmlSBlHTXnfDDVYMB/n9iO0aXqgDSD4ye5YJp8qWg+GE2TcScIMLAploX3O1+sy
         C1YaFGOX0WQIUMxCxUTrElLtWhahVYo2NJu+jDbFQDuxVzLmP/boE8mIX2Fc1TO6xoCV
         8jfk8FhMlje2JRgla8brBzgBusv11jy4omdkSMGsSi9jB45r6A1UVHs+GfEdPocoSrwJ
         IVfrgGepflBkyJCiTCkobm66no86ts/5UjtGGE7utEPAbvR2o4sU0WJ+GBDgY5TtEVNt
         EkFX6fY26UKGhPWIZbPy7YCTLOFKYROJNrN7D/airOgnfsfgZ9NPIdD1F547z+BVavJy
         jhZw==
X-Gm-Message-State: AFqh2kpHCU3rQFKIUNZp6cFWSQ6T9VMEZucZ+olmtHb3M6WIHn5yilu/
        OJ1/VjxgWg8AJAL3mqAP8FiCcw==
X-Google-Smtp-Source: AMrXdXvvQykJl27DpI4dLKKbE4Gp6VgcIMfC9wpU5tWMTKXRTAjAQE6FyENclEpnl7Ei24HEknMf5Q==
X-Received: by 2002:a05:6402:1009:b0:479:8313:3008 with SMTP id c9-20020a056402100900b0047983133008mr42841481edu.0.1674900799926;
        Sat, 28 Jan 2023 02:13:19 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id y11-20020a50eb0b000000b00467481df198sm3689493edp.48.2023.01.28.02.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 02:13:19 -0800 (PST)
Date:   Sat, 28 Jan 2023 11:13:17 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4] riscv: Use PUD/P4D/PGD pages for the linear mapping
Message-ID: <20230128101317.6zc3r5eh7hqe5q6y@orel>
References: <20230123112803.817534-1-alexghiti@rivosinc.com>
 <20230123142554.f22ajf6upfk2ybxk@orel>
 <20230125104102.2thvourt3lx2p36a@orel>
 <CAHVXubjUCmk6xGTCPzMujYqKUwE0bhQBqd8A+=yq7ijQZtBObg@mail.gmail.com>
 <20230125151041.ijhjqswqiwmrzljd@orel>
 <CAHVXubjR8AsZhMz59goxfmf8LmA4bjePKUx=AkvmbqoF42tzmA@mail.gmail.com>
 <20230127085803.ruj624323wxeyllx@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127085803.ruj624323wxeyllx@orel>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 27, 2023 at 09:58:03AM +0100, Andrew Jones wrote:
> On Fri, Jan 27, 2023 at 09:45:21AM +0100, Alexandre Ghiti wrote:
> ...
> > > > > > > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > > > > > > index f08b25195ae7..58107bd56f8f 100644
> > > > > > > --- a/drivers/of/fdt.c
> > > > > > > +++ b/drivers/of/fdt.c
> > > > > > > @@ -891,12 +891,13 @@ const void * __init of_flat_dt_match_machine(const void *default_match,
> > > > > > >  static void __early_init_dt_declare_initrd(unsigned long start,
> > > > > > >                                        unsigned long end)
> > > > > > >  {
> > > > > > > -   /* ARM64 would cause a BUG to occur here when CONFIG_DEBUG_VM is
> > > > > > > -    * enabled since __va() is called too early. ARM64 does make use
> > > > > > > -    * of phys_initrd_start/phys_initrd_size so we can skip this
> > > > > > > -    * conversion.
> > > > > > > +   /*
> > > > > > > +    * __va() is not yet available this early on some platforms. In that
> > > > > > > +    * case, the platform uses phys_initrd_start/phys_initrd_size instead
> > > > > > > +    * and does the VA conversion itself.
> > > > > > >      */
> > > > > > > -   if (!IS_ENABLED(CONFIG_ARM64)) {
> > > > > > > +   if (!IS_ENABLED(CONFIG_ARM64) &&
> > > > > > > +       !(IS_ENABLED(CONFIG_RISCV) && IS_ENABLED(CONFIG_64BIT))) {
> > > > > >
> > > > > > There are now two architectures, so maybe it's time for a new config
> > > > > > symbol which would be selected by arm64 and riscv64 and then used here,
> > > > > > e.g.
> > > > > >
> > > > > >   if (!IS_ENABLED(CONFIG_NO_EARLY_LINEAR_MAP)) {
> > > > >
> > > > > I see v5 left this as it was. Any comment on this suggestion?
> > > >
> > > > Introducing a config for this only use case sounds excessive to me,
> > > > but I'll let Rob decide what he wants to see here.
> > >
> > > To me, the suggestion is less about trying to tidy up DT code and more
> > > about bringing this comment about arm64 and riscv64 not being able to
> > > use the linear map as early as other architectures up out of the
> > > depths of DT code. Seeing an architecture select something like
> > > NO_EARLY_LINEAR_MAP, which has a paragraph explaining what that
> > > means, may help avoid other early uses of __va() which may or may
> > > not fail quickly and cleanly with a BUG.
> > >
> > 
> > You're right, do you have some bandwidth for doing that?
> >
> 
> Sure, I'll post something today.
>

Hi Alex,

So on second thought, and after a bunch of grepping, I don't think we need
to try and give architectures a way to declare that they have incomplete
early linear maps. It would actually be difficult to determine when and
why it should be selected, and, afaict, this is currently the one and
only place it would be helpful. So, rather than pulling this comment about
early __va() all the way up to the Kconfig level, I think pulling it into
arch-specific code should be sufficient, and actually better.

The situation we have here is that OF code is providing a convenience
by doing early setup of initrd_start and initrd_end, which is nice for the
large majority of architectures, but, as we see, it can't be used by all.
My new suggestion is that we expose this initrd setup function as a weak
function which architectures may override if needed. If those
architectures want to prepare a mapping in their function, they can, or,
if they know it's safe to defer the setup until later, then they can just
provide a stub. I've drafted a patch where arm64 just provides a stub.
I'll post it soon.

Thanks,
drew
