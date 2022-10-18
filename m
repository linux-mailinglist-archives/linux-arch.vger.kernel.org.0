Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D9A6020B4
	for <lists+linux-arch@lfdr.de>; Tue, 18 Oct 2022 03:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJRB7c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Oct 2022 21:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiJRB7b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Oct 2022 21:59:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145E1101B;
        Mon, 17 Oct 2022 18:59:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9CB8FB81BF0;
        Tue, 18 Oct 2022 01:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C48AC4347C;
        Tue, 18 Oct 2022 01:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666058364;
        bh=afqllA9B+pLQ3PQHZjpVZ98NziD/czmrfnB4F3JDvfY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nsfq06HSNWpqo/8lAVbttFBI+Ee1jSsAlYogNkalZXJHyDKO0GihPIbbo53psvYsH
         scSQSVKz6/hGQa2PMClA8DgVmvUKZphQ5idYXf+VaH3yRTBLlnJ7boXm2bnJnlqIsy
         iXdf/z39dDfx0MeKUWrOU1XZiyyzGhO4dM0B5JF7GKgAbPCQDAdg9JltHezdCQoOIu
         OcYgbdso+KWq5tgBoB+vDS6pOi87/Ovz/WJ7HwtYUeKxbPo3ygyRpC/epH8Bircfyk
         zcu8jD6rD0EpWUNoyEUPAVCzwN5dYLmHNO0wE6p1eo0htOTYN32zHKRnbEF8AsKbzn
         9sBPlJZMH1YHQ==
Received: by mail-ej1-f41.google.com with SMTP id w18so28919716ejq.11;
        Mon, 17 Oct 2022 18:59:24 -0700 (PDT)
X-Gm-Message-State: ACrzQf2rPQjQjAooV1mbne7IY4I/gOZXiLUNcOSLJJO3RqGuSWe8Zize
        twrE/r0NcMAECTb0DkaygMISdzJGCW08JE7ns+4=
X-Google-Smtp-Source: AMsMyM6RoqfZP7DPHNWQUxMV6MeJZVtdRdzC5IoZxellyAfNsD9ory7aqVzhQEuYMWglSXx6948ZfSD1sT5OhQmKr3g=
X-Received: by 2002:a17:907:7f05:b0:78d:e869:f2fe with SMTP id
 qf5-20020a1709077f0500b0078de869f2femr452896ejc.684.1666058362517; Mon, 17
 Oct 2022 18:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221017125209.2639531-1-chenhuacai@loongson.cn>
 <39ea2a6fee654b68974ef38237a61e80@AcuMS.aculab.com> <b31086df86febba62f76ff9ec775b7a6e16c1933.camel@xry111.site>
In-Reply-To: <b31086df86febba62f76ff9ec775b7a6e16c1933.camel@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 18 Oct 2022 09:59:09 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5XoJqbnh+DzX0Gsq_sDTLB7bK9H7-=fLTPuA4s7VY+Ug@mail.gmail.com>
Message-ID: <CAAhV-H5XoJqbnh+DzX0Gsq_sDTLB7bK9H7-=fLTPuA4s7VY+Ug@mail.gmail.com>
Subject: Re: [PATCH V3] LoongArch: Add unaligned access support
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     David Laight <David.Laight@aculab.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 17, 2022 at 10:20 PM Xi Ruoyao <xry111@xry111.site> wrote:
>
> On Mon, 2022-10-17 at 13:11 +0000, David Laight wrote:
> > From: Huacai Chen
> > > Sent: 17 October 2022 13:52
> > >
> > > Loongson-2 series (Loongson-2K500, Loongson-2K1000) don't support
> > > unaligned access in hardware, while Loongson-3 series (Loongson-3A5000,
> > > Loongson-3C5000) are configurable whether support unaligned access in
> > > hardware. This patch add unaligned access emulation for those LoongArch
> > > processors without hardware support.
> > >
> > .....
> > > +       } else if (insn.reg2i12_format.opcode == fstd_op ||
> > > +               insn.reg3_format.opcode == fstxd_op) {
> > > +               value = read_fpr(insn.reg2i12_format.rd);
> > > +               res = unaligned_write(addr, value, 8);
> > > +               if (res)
> > > +                       goto fault;
> > > +       } else if (insn.reg2i12_format.opcode == fsts_op ||
> > > +               insn.reg3_format.opcode == fstxs_op) {
> > > +               value = read_fpr(insn.reg2i12_format.rd);
> > > +               res = unaligned_write(addr, value, 4);
> > > +               if (res)
> > > +                       goto fault;
> >
> > Are those right?
> > Shouldn't something be converting from 'double' to
> > 'float' in there?
> > And generating SIGFPE (?) if the exponent is out of range.
>
> To me it looks right.
>
> The semantic of FST.S does not include conversion.  It just stores the
> lower 32 bits of a floating-point register into the memory.  If someone
> attempts to use FST.S to convert a double into a float, it's a
> programming error.
Agree.

>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
