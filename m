Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E8D5A87E8
	for <lists+linux-arch@lfdr.de>; Wed, 31 Aug 2022 23:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiHaVIE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Aug 2022 17:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiHaVID (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Aug 2022 17:08:03 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D732FF32C2;
        Wed, 31 Aug 2022 14:08:02 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id cb8so12038674qtb.0;
        Wed, 31 Aug 2022 14:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Vo1R8xrzalzVOud5svkuQP83U7J146b1RS62ApyG/Fo=;
        b=U1fhx7lv3G5YbJZxBuQWCPlvguTm/AFt44YIpAX+OZeO+mSXMl43RfQ3iYAazBNwnO
         8ejs7pxeq4lAGsuxxZpI4BWrfL5kj9A9UqlgXoaGvCmFaXCLmVWwdmOTfIuY76X+gJ+3
         RpBTiA1Q/8oPxYDNKFJHDt1bKFdD10bHoQ2nsVGqJViamJk+rdIswUZTlkjuh6YcFF4u
         4E/V4sp8VW+o0r9+O8ODra1UAVS/4E/WyCPi0kJfokl61gihx++lD4oLgj6VgW0aEnHM
         5AaynjubFcmtCGnRw9VQNw6KsKHzAWRSHUlS8q9QSN67qf+sBXuSONIUM+F51KKmxLtf
         AnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Vo1R8xrzalzVOud5svkuQP83U7J146b1RS62ApyG/Fo=;
        b=bGgo9IMQmGZU5pxE7nm+agusogAFEz7oEV3tiyvdMaKeQCkZ24TndHtBLzq7U18L0o
         MwYJsin37PcHdqvu9Shwa+yZyuDMpO24XrkwMo/ueiweX+KVb2uL/9YruxjievC6Rf/L
         CHsM5M1bR4wXdSwxiPeuxXjUYI/mTHF/TossHR1aWqw9BO6ieJuObVT6uV+GnjHQnz+k
         rt9MnFT8MJgFKC7i0TGDZ7hJpzkgpsc/3x9QKPa+TmsLxyz9jWs7hoG/sRaxR5BGASNK
         E3YOzESU3ks9oLf/1OEkqFFzCc9tVln93fwnFLBMVtfSuONY3Y+4lFBySRLFNdrhY/su
         2bnA==
X-Gm-Message-State: ACgBeo0Wg35+w3fTGdrY519f13judlfnFyN4XdSlf3g8awM5Z+9Hgk+4
        ogOP/T5koM6B82Z+/GKQjf2cM67Ha7oa27pSzd8=
X-Google-Smtp-Source: AA6agR76c6w2rRme8Rj45ddQoUkKquUlwBPKxJ2AJCe4a6H4/HJoy5tLVXVe0sC85Yh9ty9y1YmBfQ0P0i8nZkcErsk=
X-Received: by 2002:a05:622a:40a:b0:343:77ba:727f with SMTP id
 n10-20020a05622a040a00b0034377ba727fmr21128499qtx.481.1661980081927; Wed, 31
 Aug 2022 14:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a0uuJ_z8wmNmQTW_qPNqzz7XoxZdHgqbzmK+ydtjraeHg@mail.gmail.com>
 <CACRpkdb5ow4hD3td6agCuKWvuxptm5AV4rsCrcxNStNdXnBzrA@mail.gmail.com>
 <87f2ff4c-3426-201c-df86-2d06d3587a20@csgroup.eu> <CACRpkdYizQhiJXzXNHg7TXUVHzhkwXHFN5+e58kH4udGm1ziEA@mail.gmail.com>
 <f76dbc49-526f-6dc7-2ef1-558baea5848b@csgroup.eu> <CACRpkdZpwdP+1VitohznqRfhFGcLT2f+sQnmsRWwMBB3bobwAw@mail.gmail.com>
 <515364a9-33a1-fafa-fdce-dc7dbd5bb7fb@csgroup.eu> <CAK8P3a36qbRW8hd+1Uhi88kh+-KTjDMT-Zr8Jq9h_G3zQLfzgw@mail.gmail.com>
 <Yw3DKCuDoPkCaqxE@arcana.i.gnudd.com> <CACRpkdZeAAZYqV3ccd-X=ZwdnfSwRUdXchGETB-WTkgSZQL=Pw@mail.gmail.com>
 <Yw9sVCNtaLUjZH/F@arcana.i.gnudd.com>
In-Reply-To: <Yw9sVCNtaLUjZH/F@arcana.i.gnudd.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Sep 2022 00:07:26 +0300
Message-ID: <CAHp75Vff0GUQXD8zstEFwXNcnbxKEc7Gqahoo_kZp69MyKWskg@mail.gmail.com>
Subject: Re: [PATCH] gpio: Allow user to customise maximum number of GPIOs
To:     Davide Ciminaghi <ciminaghi@gnudd.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alexandre Courbot <gnurou@gmail.com>,
        Alexandre Courbot <acourbot@nvidia.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>, Alessandro Rubini <rubini@gnudd.com>
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

On Wed, Aug 31, 2022 at 5:14 PM Davide Ciminaghi <ciminaghi@gnudd.com> wrote:
> On Wed, Aug 31, 2022 at 03:32:25PM +0200, Linus Walleij wrote:
> > On Tue, Aug 30, 2022 at 9:58 AM Davide Ciminaghi <ciminaghi@gnudd.com> wrote:
> >
> > > the sta2x11 was a chip containing AMBA peripherals and a PCIe to AMBA bridge
> > > (it is still in production as far as I know, but deprecated for new designs).
> > > It would typically be installed on x86 machines, so you needed to build and
> > > run AMBA drivers in an x86 environment. The original drivers we started from
> > > had platform data, but then we were told to switch to DTS.
> >
> > For the record I think that was bad advice, I hope it wasn't me.
> > But the world was different back then I suppose.
> > Adding DTS to x86 which is inherently ACPI is not a good idea.
> > Especially if you look at how SBSA ACPI UARTS were done
> > in drivers/tty/serial/amba-pl011.c.
> >
> now that I think of it, ACPI was also listed as a possible choice, but the
> problem was that we didn't know much about ACPI, and took the DTS way.
> So there was no bad advice, just fear of the unknown :-)

Feel free to ask, we have experts in the mailing list(s).

-- 
With Best Regards,
Andy Shevchenko
