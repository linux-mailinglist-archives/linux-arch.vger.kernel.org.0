Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605765A3D1C
	for <lists+linux-arch@lfdr.de>; Sun, 28 Aug 2022 12:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiH1KEv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Sun, 28 Aug 2022 06:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiH1KEu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 28 Aug 2022 06:04:50 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6205F38B8;
        Sun, 28 Aug 2022 03:04:48 -0700 (PDT)
Received: from mail-ed1-f52.google.com ([209.85.208.52]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MBV2f-1oZ4VN2IWt-00D109; Sun, 28 Aug 2022 12:04:46 +0200
Received: by mail-ed1-f52.google.com with SMTP id s11so6906814edd.13;
        Sun, 28 Aug 2022 03:04:46 -0700 (PDT)
X-Gm-Message-State: ACgBeo2ch44KgL2Jb6PS39Vp5lXpwWeCEj95onF7+tkB/sw6F2G0fqEc
        qggrG40up4ejvDwinpdmael92xQo2No+ZAUHR6A=
X-Google-Smtp-Source: AA6agR7m5MrvDDJkIHH7Ehnt8y+ynOosCvPpdzVXCkVpgNk88mWnLMxzom1m7IDvmVq74u4+tqxm9mjiuAXVA48sEmU=
X-Received: by 2002:a05:6402:5190:b0:448:5bdb:b27d with SMTP id
 q16-20020a056402519000b004485bdbb27dmr1665421edd.49.1661681086136; Sun, 28
 Aug 2022 03:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <f31b818cf8d682de61c74b133beffcc8a8202478.1660041358.git.christophe.leroy@csgroup.eu>
 <CACRpkdY53c0qXx24Am1TMivXr-MV+fQ8B0CDjtGi6=+2tn4-7A@mail.gmail.com>
 <CAK8P3a1Vh1Uehuin-u5QrTO5qh+t0aK_hA-QZwqc00Db_+MKcw@mail.gmail.com>
 <CACRpkdbhbwBe=jU5prifXCYUXPqULhst0se3ZRH+sWOh9XeoLQ@mail.gmail.com>
 <CAK8P3a0j-54_OkXC7x3NSNaHhwJ+9umNgbpsrPxUB4dwewK63A@mail.gmail.com>
 <CACRpkda0+iy8H0YmyowSDn8RbYgnVbC1k+o5F67inXg4Qb934Q@mail.gmail.com>
 <CAK8P3a0uuJ_z8wmNmQTW_qPNqzz7XoxZdHgqbzmK+ydtjraeHg@mail.gmail.com>
 <CACRpkdb5ow4hD3td6agCuKWvuxptm5AV4rsCrcxNStNdXnBzrA@mail.gmail.com>
 <87f2ff4c-3426-201c-df86-2d06d3587a20@csgroup.eu> <CACRpkdYizQhiJXzXNHg7TXUVHzhkwXHFN5+e58kH4udGm1ziEA@mail.gmail.com>
 <f76dbc49-526f-6dc7-2ef1-558baea5848b@csgroup.eu> <CACRpkdZpwdP+1VitohznqRfhFGcLT2f+sQnmsRWwMBB3bobwAw@mail.gmail.com>
 <515364a9-33a1-fafa-fdce-dc7dbd5bb7fb@csgroup.eu>
In-Reply-To: <515364a9-33a1-fafa-fdce-dc7dbd5bb7fb@csgroup.eu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 28 Aug 2022 12:04:29 +0200
X-Gmail-Original-Message-ID: <CAK8P3a36qbRW8hd+1Uhi88kh+-KTjDMT-Zr8Jq9h_G3zQLfzgw@mail.gmail.com>
Message-ID: <CAK8P3a36qbRW8hd+1Uhi88kh+-KTjDMT-Zr8Jq9h_G3zQLfzgw@mail.gmail.com>
Subject: Re: [PATCH] gpio: Allow user to customise maximum number of GPIOs
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
        <linux-arch@vger.kernel.org>,
        Davide Ciminaghi <ciminaghi@gnudd.com>,
        Alessandro Rubini <rubini@gnudd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:q7AU2884sD9a1G/Wzgl7haFBCm2tktWi+C9nFAcCOtfszTS0hvk
 NIg2klUjvMnQB1+DqRwaIfPTRPQtBA2OhykVvoe6NjqcCoF/gMOBliUtodlCCfocdFDssL5
 NfVg9wSHtRGjz1bXrY5Eh6XEbGBzbZfXbVizl/w34JoLYTQ7/QeDRl7GF8BT+0RbCyBAw5g
 4VzDnQMbRsnH4xjX3fXlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MlFDtVOvLfE=:Xe0ivX8BrMffWwzQzmP2DB
 o3m12LgKZ+9xUu7xFBcy5qw1E1b6BW0HFvCWXwSBrRWzGRbfbRb+NxjCG4A4H12EfvZmuUHyu
 AmXrinaowvZ9mQjd51DUKaibsjB+kDw8aRccN+BPzVF5zBFOLvaqBq/QWWgKvCKmXHlnGY565
 wzO1bblBqO1ctbB3R/EkJLY/UVj6lGgKdnIqBg4mtZGdw5iisj0nIvy1uytVoh4DOI2orEbWB
 HPM0QRsOTtxl2c0ZLMaTCT5Jmhnf+SMc0hhYSgx/pB2aieQKOezyjwFdpdg4n5drrLQYoE7bY
 j/d49451Eo4yTiTp+i5Ld10JjTQM3T08pejdsgoq/8MgTKO0IwtiLUAmoh8qsAwaY+2FRlEkd
 WNMIqpmgA9zQ7wdbRJVRSI8GSHG8bZ3lplhOKE+84UbC0ZgapmBFWHhpMSn1q5TqOrg9y50WV
 UwY24Yn6Km8ZZjR3nSTCAG3vP3tJmQaqy6w2F31IoGdkS9FCyVhd10OcaYE+tMO12qGcvY1u/
 7AbPzN7RV8jviRfRHH/kMI5R8V0a98Obp6fS8oTQ4JKDPVNCcLoyGFt+CjPYrQsENpf+fEOQF
 SDxxV+zD+BuhiHm/CQgrXby5peZ/k9quOYDbrPd2W9olFT9P7VQBQSJcPAAz++eiHJONpt26L
 N3wxaFrCI9qUmRdGnIIcpriF+BZaFTdWxya3p8wfgKL9qL0HtO4Edwv9mol5pBHdp/sTQ6Ni8
 +Kta1UNTFeeHs3OnfLDftUBctYVH6JTxlVHBipO56q8Bgkdhu0MX0zXxNyNBdyeTt6WRSzy6t
 nqe2PwpxZzBOGAyBmQ/N0ZR0C3DhM4WSqV6igHch6QSByLuI2n/2RIXd8GBiHPPUPuYcnD9w7
 TDmasLgWlU+SOZCq1JFw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Aug 28, 2022 at 11:06 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Le 26/08/2022 à 23:54, Linus Walleij a écrit :
> >> But what do I do with:
> >>
> >> drivers/gpio/gpio-aggregator.c: bitmap = bitmap_alloc(ARCH_NR_GPIOS,
> >> GFP_KERNEL);
> >
> > That's just used locally in that driver to loop over the arguments to the
> > aggregator (from the file in sysfs). I would set some arbitrary root
> > like
> > #define AGGREGATOR_MAX_GPIOS 512
> > and just search/replace with that.
> >
>
> And what about gsta_gpio_setup() that requests base 0 with the following
> comment:
>
>         /*
>          * ARCH_NR_GPIOS is currently 256 and dynamic allocation starts
>          * from the end. However, for compatibility, we need the first
>          * ConneXt device to start from gpio 0: it's the main chipset
>          * on most boards so documents and drivers assume gpio0..gpio127
>          */
>
>
> And I guess there might be other drivers like that (I found that one
> because of its comment mentioning ARCH_NR_GPIOS.

This driver is clearly incomplete: there is an mfd portion in
drivers/mfd/sta2x11-mfd.c, the gpio provider in
drivers/gpio/gpio-sta2x11.c, one gpio consumer in
drivers/media/pci/sta2x11/, and some glue logic in
arch/x86/pci/sta2x11-fixup.c, but nothing that seems to set up
the platform data that these need to communicate with one another.

I think that just means the code that one would have to modify
is in vendor kernels of devices using this chip, but there is no
way to fix those if they are not in mainline. The last meaningful
patches on this SoC support were in 2012 by  Davide Ciminaghi
and Alessandro Rubini, though they still Acked patches after that.

I wonder if I was missing the interesting bit about it, if the driver
is just obsolete and can be removed, or if there is something
that is still worth fixing here.

        Arnd
