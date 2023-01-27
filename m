Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021D467DF93
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jan 2023 09:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjA0I6I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Jan 2023 03:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjA0I6H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Jan 2023 03:58:07 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB6829422
        for <linux-arch@vger.kernel.org>; Fri, 27 Jan 2023 00:58:05 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso5293593wmb.0
        for <linux-arch@vger.kernel.org>; Fri, 27 Jan 2023 00:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PYMteubS+4lwOGc2I7JiDeXqE7nT4Xb62g6ujdBjlpE=;
        b=gly/Ah19V9gpzED0uxuLEtUd8b2f3KZf9Z3F5llZ7GPh2M2DQsUzBwNWErueqqKwOK
         2IAcgKEbiNGtg++g45thG+xXmIA4Tto8tPfjISHiN5h/kUVp0xZnk9tn7XQwdrlWnZkY
         tn1OOjDuwMXRVnLhLwkJ20zWcnheaHrd95IgmLye+uFgvmHWG9apsp9IubCtRHBI2MzC
         oIJfLmqRPKMAtFdTD6OUc0pl8hwNl0ALmQnKK8GS6pYz6+ErcmE2MDOlXhSl3sntDOO6
         Wo4TU7LR0Ttl99QFAGCq/czH+h4HdB9ejMDMIXBY9mzkXgHaEm4g6jh3Y9R9dVpkCj+9
         07Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYMteubS+4lwOGc2I7JiDeXqE7nT4Xb62g6ujdBjlpE=;
        b=DSXQ08Afgt5OpgpZJobC9QhDgjaAv8k7MOSnAVZeHS88TU4NnrypmtOjVsGFhJqMpB
         54ifvlWnovJKk2u8LBx5QcQ6Uwd/+YCkYwhZGX5Je58IwqQLBfJU66dPSZpiDVm6BCKF
         qpYEQbsNDrjmE3yAXTClwQwHgZ2oDjpAt617aKe2YD1c3SSV4bRm8BIpdbBy6EcKCNN/
         KyR71pRbZVW1aY+6aUA1s22RYhC+U5K4U6cpY4Xbf4ruPkFKzpjhS12BSSihYE3YQSI5
         8iP+YfyeQO4F1c3ild6UIQF1KiQsdUSCSQZL7gPuHtG6wH0P5v8chEBoBC1RBBrm8e4c
         Fakw==
X-Gm-Message-State: AFqh2kr/I7XGW8X0tXw7YZK1DwIXQsdUZh+sYqKV5vGS6ZoTF9h/Omov
        hbyncpxX15drnanrVyvqlZ2ZHg==
X-Google-Smtp-Source: AMrXdXtav/oM3qM10MujDBkbMkvfbbVRSYWQH3g8HyfDNMvHTIctgxxkkiyCrXTT8buQVGYHDEyK7Q==
X-Received: by 2002:a1c:f317:0:b0:3d0:480b:ac53 with SMTP id q23-20020a1cf317000000b003d0480bac53mr38981050wmq.12.1674809884477;
        Fri, 27 Jan 2023 00:58:04 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a19-20020a05600c349300b003cfa622a18asm7342751wmq.3.2023.01.27.00.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 00:58:04 -0800 (PST)
Date:   Fri, 27 Jan 2023 09:58:03 +0100
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
Message-ID: <20230127085803.ruj624323wxeyllx@orel>
References: <20230123112803.817534-1-alexghiti@rivosinc.com>
 <20230123142554.f22ajf6upfk2ybxk@orel>
 <20230125104102.2thvourt3lx2p36a@orel>
 <CAHVXubjUCmk6xGTCPzMujYqKUwE0bhQBqd8A+=yq7ijQZtBObg@mail.gmail.com>
 <20230125151041.ijhjqswqiwmrzljd@orel>
 <CAHVXubjR8AsZhMz59goxfmf8LmA4bjePKUx=AkvmbqoF42tzmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHVXubjR8AsZhMz59goxfmf8LmA4bjePKUx=AkvmbqoF42tzmA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 27, 2023 at 09:45:21AM +0100, Alexandre Ghiti wrote:
...
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
> > To me, the suggestion is less about trying to tidy up DT code and more
> > about bringing this comment about arm64 and riscv64 not being able to
> > use the linear map as early as other architectures up out of the
> > depths of DT code. Seeing an architecture select something like
> > NO_EARLY_LINEAR_MAP, which has a paragraph explaining what that
> > means, may help avoid other early uses of __va() which may or may
> > not fail quickly and cleanly with a BUG.
> >
> 
> You're right, do you have some bandwidth for doing that?
>

Sure, I'll post something today.

Thanks,
drew
