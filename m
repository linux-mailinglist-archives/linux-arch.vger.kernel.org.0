Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EDA53C3F5
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jun 2022 07:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239654AbiFCFFJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jun 2022 01:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236793AbiFCFFH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jun 2022 01:05:07 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1663917E;
        Thu,  2 Jun 2022 22:05:06 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id v7so4975835ilo.3;
        Thu, 02 Jun 2022 22:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V69MdHZeArGR1p037iUfHw/ib1Y8p6jjj2w/lS/WKCY=;
        b=O4+rsuFI4q2IP6f0kZluT+02DEU246uyHHow4FVb0J3mZ+w6QZ+L7adWYcZDUgcl5h
         ZgrPzh0NN0iMHRsEC2ODXobnG7acV3TpCPOYVhV4E3iXgCHyHO8Puarr70+u0JVBSyuU
         5SICaERPcmUqM6txeFYpwKgbZ1yvAxCmKUane++nAtjUEmuJzH1kdiICFhgJNWnulMh/
         qZG2hcyJLrI/ewZXcjabuyZ81SjHoCpWfExTG+TuSKpF4E/84130KgexiwgtXMxb2H2I
         GsG9qinfM6Mq25TgGzrzD6fEJBtFqoq67uWejWJuQntFiY3TqYjPqwr9WOIjuzAcErAI
         dWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V69MdHZeArGR1p037iUfHw/ib1Y8p6jjj2w/lS/WKCY=;
        b=Y1Ce6HyFfwm5cxdHczRxM+Ief9Wh+ucykyNduhgMVSirvmcX2NegqHEDXwHicQgzU2
         uXsYOZusCvENmHE35T9cdbFlk94+9fD+mA8HC8+aMLcUAwImfMsJINi3JZcjQmSLgW0Q
         VV4QY3WBm0luxWc21skUYKS/HTVKbLQvZnnqjhv0hRXHYXVbFu47qrW3nF1CiOwsUdia
         PoSNS/T60hKKYcmJuGUx+Lo2RNz3zEuTAPicXOP1mtHXKTQcQKAwogqhF4kZDja5trRa
         V2/Kk4/tJGt7sg4z7i1TQibWqHPstFx8YryubikNIzF334EQGV3foZ0m/4Q2j0zmm+6k
         wAqA==
X-Gm-Message-State: AOAM532Vgct46uLL5rmNVo16vzUsOQs2bWRCilAEJf2wmpCR/26x6Veb
        4ews4AE6hOabUd21tsS5OWNjWlteea8fLXPrEnY=
X-Google-Smtp-Source: ABdhPJx1Q2URPgzhZwqCBR98Ngqy/AKTQqxQ6EdjLoGuIhPccdjI8x/MzaUCZEQPUAIOTsazaOTNjHjF1YNkqi5X4ww=
X-Received: by 2002:a02:6014:0:b0:331:57b2:8a3a with SMTP id
 i20-20020a026014000000b0033157b28a3amr4683275jac.169.1654232705473; Thu, 02
 Jun 2022 22:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220602115141.3962749-1-chenhuacai@loongson.cn>
 <20220602115141.3962749-2-chenhuacai@loongson.cn> <e68000bf-a271-d1f2-56a5-a9ddce2bbb7c@infradead.org>
In-Reply-To: <e68000bf-a271-d1f2-56a5-a9ddce2bbb7c@infradead.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 3 Jun 2022 13:04:55 +0800
Message-ID: <CAAhV-H4MhHvXMTXN==z2xonfWEtcW8CiBrwnOEznKGira8Yw=g@mail.gmail.com>
Subject: Re: [PATCH V14 01/24] irqchip: Adjust Kconfig for Loongson
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Marc Zyngier <maz@kernel.org>, WANG Xuerui <git@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Randy,

On Fri, Jun 3, 2022 at 12:34 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi,
>
> On 6/2/22 04:51, Huacai Chen wrote:
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index 44fb8843e80e..1cb3967fe798 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -557,7 +557,7 @@ config LOONGSON_LIOINTC
> >
> >  config LOONGSON_HTPIC
> >       bool "Loongson3 HyperTransport PIC Controller"
> > -     depends on MACH_LOONGSON64
> > +     depends on (MACH_LOONGSON64 && MIPS)
>
> If you ever have another patch version, please drop the unnecessary left and
> right parentheses above.
OK, thanks, I will do that.

Huacai
>
>         depends on MACH_LOONGSON64 && MIPS
>
> >       default y
> >       select IRQ_DOMAIN
> >       select GENERIC_IRQ_CHIP
>
> thanks.
> --
> ~Randy
