Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F7F5AE243
	for <lists+linux-arch@lfdr.de>; Tue,  6 Sep 2022 10:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238977AbiIFIQ1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Sep 2022 04:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiIFIQ1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Sep 2022 04:16:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3810A4DB5C;
        Tue,  6 Sep 2022 01:16:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C896361241;
        Tue,  6 Sep 2022 08:16:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B53C433C1;
        Tue,  6 Sep 2022 08:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662452185;
        bh=zHclWjaOaxn1bhfC0MDw0EiWuDztvxgmRJAiKKgCwZU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Dh84m+kx61qaVzxzWfgbmq8vfsEroZclWxVFyPTPUYnZoms5r9ge6YfQHvEaTBrB6
         KlV/LTM0rdLYWuCMb6DJrUj+1eXk/qoNAlK+W8LFSZuHMEsdv+0enw5FTtCw4ECqQN
         jqH7aHUTKhZBFsohesD4vrVL/tZ0PBIaVK5euomUwSKsXjWgBBBTtoLWjoAFiFav6s
         tHyTuZrutgu7W+0WjK5DEMobug0Ji7JUYcuoBBdlLdzjpAXx1sOwZtWUW49p84Omki
         ezhk5L5zdoh3IDP31ddCd60MH779aKle1K4eThp2wYwNO4RNrJFH0uSXqal1B03TsT
         8zuiYjqnvYQxg==
Received: by mail-lf1-f48.google.com with SMTP id k10so1578126lfm.4;
        Tue, 06 Sep 2022 01:16:25 -0700 (PDT)
X-Gm-Message-State: ACgBeo30t9v5LjzEIeKLF9Vyz5hcAHIvMPaUXTFN/kiWb9Lf/yVr60QI
        8B3O4bZT0VPQPkl3sL3Ub0IgopJPzXxjduUgm6c=
X-Google-Smtp-Source: AA6agR4URsfozrvQXsnfVJFa/DypnBWIxHu19vLLqIF5npkRWOaaVT6aVpIxxvtE1ghSe8HEY4NSGIKx7gDg+RWXjvM=
X-Received: by 2002:a05:6512:2294:b0:494:8dc5:10af with SMTP id
 f20-20020a056512229400b004948dc510afmr8629185lfu.426.1662452183217; Tue, 06
 Sep 2022 01:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220906061313.1445810-1-masahiroy@kernel.org>
 <20220906061313.1445810-9-masahiroy@kernel.org> <f76020e2-e8bd-4f75-a697-3d6ec6665969@www.fastmail.com>
In-Reply-To: <f76020e2-e8bd-4f75-a697-3d6ec6665969@www.fastmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 6 Sep 2022 10:16:11 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH77Ja8bSsq2Qj8Ck9iSZKw=1F8Uy-uAWGVDm4-CG=EuA@mail.gmail.com>
Message-ID: <CAMj1kXH77Ja8bSsq2Qj8Ck9iSZKw=1F8Uy-uAWGVDm4-CG=EuA@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] kbuild: remove head-y syntax
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 6 Sept 2022 at 10:06, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Sep 6, 2022, at 8:13 AM, Masahiro Yamada wrote:
> > Kbuild puts the objects listed in head-y at the head of vmlinux.
> > Conventionally, we do this for head*.S, which contains the kernel entry
> > point.
> >
> > A counter approach is to control the section order by the linker script.
> > Actually, the code marked as __HEAD goes into the ".head.text" section,
> > which is placed before the normal ".text" section.
> >
> > I do not know if both of them are needed. From the build system
> > perspective, head-y is not mandatory. If you can achieve the proper code
> > placement by the linker script only, it would be cleaner.
> >
> > I collected the current head-y objects into head-object-list.txt. It is
> > a whitelist. My hope is it will be reduced in the long run.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
>
> The scripts/head-object-list.txt approach feels a little awkward,
> so overall I'm not convinced that this is an improvement as long
> as there is no final decision for what should be done instead.
>

Agree with Arnd here - having an exhaustive list that spans all arch/*
subdirectories goes against the divide-and-conquer nature of arch/,
where each architecture manages such things themselves

> If the .head.text section approach works, maybe convert at
> a minimum the x86 and arm64 architectures to provide an example
> of what it should look like in the end, otherwise I doubt that
> any architecture maintainers are going to work on removing their
> architectures from the head-object-list.txt file.
>

For the arm64 case, I seriously doubt whether head.o needs any special
treatment - the layout is section based, and the only piece that must
appear right at the start of the binary image is the image header
(which is emitted into .head.text IIRC), everything else appearing in
head.S is placed in .text, .idmap.text or .init.text, and does not
require any special treatment.

> > +arch/alpha/kernel/head.o
> > +arch/arc/kernel/head.o
> > +arch/arm/kernel/head-nommu.o
> > +arch/arm/kernel/head.o
> > +arch/arm64/kernel/head.o
> > +arch/csky/kernel/head.o
> > +arch/hexagon/kernel/head.o
> > +arch/ia64/kernel/head.o
> > +arch/loongarch/kernel/head.o
> > +arch/m68k/68000/head.o
> > +arch/m68k/coldfire/head.o
> > +arch/m68k/kernel/head.o
> > +arch/m68k/kernel/sun3-head.o
> > +arch/microblaze/kernel/head.o
> > +arch/mips/kernel/head.o
> > +arch/nios2/kernel/head.o
> > +arch/openrisc/kernel/head.o
> > +arch/parisc/kernel/head.o
> > +arch/powerpc/kernel/head_40x.o
> > +arch/powerpc/kernel/head_44x.o
> > +arch/powerpc/kernel/head_64.o
> > +arch/powerpc/kernel/head_8xx.o
> > +arch/powerpc/kernel/head_book3s_32.o
> > +arch/powerpc/kernel/head_fsl_booke.o
> > +arch/powerpc/kernel/entry_64.o
> > +arch/powerpc/kernel/fpu.o
> > +arch/powerpc/kernel/vector.o
> > +arch/powerpc/kernel/prom_init.o
> > +arch/riscv/kernel/head.o
> > +arch/s390/kernel/head64.o
> > +arch/sh/kernel/head_32.o
> > +arch/sparc/kernel/head_32.o
> > +arch/sparc/kernel/head_64.o
> > +arch/x86/kernel/head_32.o
> > +arch/x86/kernel/head_64.o
> > +arch/x86/kernel/head32.o
> > +arch/x86/kernel/head64.o
> > +arch/x86/kernel/ebda.o
> > +arch/x86/kernel/platform-quirks.o
> > +arch/xtensa/kernel/head.o
>
> Seeing that almost all of these have the same naming
> convention, another alternative would be to have a
> special case exclusively for arch/*/kernel/head.S and
> make that either an assembly file that includes all
> the other files from your current list, or use
> an intermediate object to link head-*.o into head.o
> before putting that first.
>
>      Arnd
