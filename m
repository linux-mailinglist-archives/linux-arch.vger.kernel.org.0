Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8814A3490
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jan 2022 06:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242894AbiA3Frb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Jan 2022 00:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbiA3Fr3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 30 Jan 2022 00:47:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F765C061714;
        Sat, 29 Jan 2022 21:47:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F4A760FE7;
        Sun, 30 Jan 2022 05:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FF4C340EF;
        Sun, 30 Jan 2022 05:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643521648;
        bh=CFf7eYVsi2vfAFWFWWepRognCnx0qrq4RXbGFOfmx9c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NPAxCNaLTo4erRllOLayMfPUYfUOW9vn8x0aWJepTSfSmFE6cR2eBffVk6qUyvNdZ
         v3wz8lOjDUgZTz25phHKEAzLGLT1NkVJp8AuWL2ej8PZnZfdv3FX2p4yUbOsNvaLc7
         ad40OrZwitXivHc3LwQ2Z7IEwtIIa8viQ4z7g/2YsK4NgOLtEh5wOFyP+H7XH8E0bH
         pTnTrhCsz05K8/+IBl0hK4EOqoejHMaIgxXuF2bpco6R1FaW174GiCmOEtCUbSh1QD
         /vc0+bphJ+UVCMo6QbiAw+ofwI5iAXuGl0/v6S7yyySZLfYvKOlRd2M4ToNLzAH7hS
         zlTbUHM35vSDw==
Received: by mail-vk1-f181.google.com with SMTP id o15so6363423vki.2;
        Sat, 29 Jan 2022 21:47:28 -0800 (PST)
X-Gm-Message-State: AOAM532MGjO3TuDTHU5ruU1O+zAGAA0ZZO1mCbx/Nwm6stmtlSrN2yI8
        82ymSTNg9Za86ll3PXG0t0eEhz+wj6xCQimhG7w=
X-Google-Smtp-Source: ABdhPJxLWGk5CQ+MBw+7fcsDq1E1+v+xghtxN0mZV6UTIH/aZ2JMAd2qn/Emr/MxaYw7Fbc8Rg4biBjIlqvQekFa+1Q=
X-Received: by 2002:a05:6122:1306:: with SMTP id e6mr6299952vkp.28.1643521647659;
 Sat, 29 Jan 2022 21:47:27 -0800 (PST)
MIME-Version: 1.0
References: <20220129121728.1079364-1-guoren@kernel.org> <20220129121728.1079364-7-guoren@kernel.org>
 <CAK8P3a3_kVB78-26sxdsEjb3MMcco6U55tc7siCBFZbJjyH6Sw@mail.gmail.com>
In-Reply-To: <CAK8P3a3_kVB78-26sxdsEjb3MMcco6U55tc7siCBFZbJjyH6Sw@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 30 Jan 2022 13:47:16 +0800
X-Gmail-Original-Message-ID: <CAJF2gTThb8_-T0iOFVZoJrvZqeFvjfWB+AdFyOwtGhN9aG-MQQ@mail.gmail.com>
Message-ID: <CAJF2gTThb8_-T0iOFVZoJrvZqeFvjfWB+AdFyOwtGhN9aG-MQQ@mail.gmail.com>
Subject: Re: [PATCH V4 06/17] riscv: compat: Add basic compat date type implementation
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jan 30, 2022 at 5:56 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Jan 29, 2022 at 1:17 PM <guoren@kernel.org> wrote:
> > +
> > +#define COMPAT_RLIM_INFINITY   0x7fffffff
> >
> > +#define F_GETLK64      12
> > +#define F_SETLK64      13
> > +#define F_SETLKW64     14
>
> These now come from the generic definitions I think. The flock definitions
> are just the normal ones,
Yes, it could be removed after Christoph Hellwig's patch merged.

> and AFAICT the RLIM_INIFINITY definition here
> is actually wrong and should be the default 0xffffffffu to match the
> native (~0UL) definition.
Yes, native rv32 used ~0UL, although its task_size is only 2.4GB.

I would remove #define COMPAT_RLIM_INFINITY   0x7fffffff

>
>             Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
