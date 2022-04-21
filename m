Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D815098E8
	for <lists+linux-arch@lfdr.de>; Thu, 21 Apr 2022 09:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385640AbiDUHPZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Apr 2022 03:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385621AbiDUHPX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Apr 2022 03:15:23 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3E717A81
        for <linux-arch@vger.kernel.org>; Thu, 21 Apr 2022 00:12:34 -0700 (PDT)
Received: from mail-wm1-f41.google.com ([209.85.128.41]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MbRXj-1oIhYG11dR-00bpCW; Thu, 21 Apr 2022 09:12:33 +0200
Received: by mail-wm1-f41.google.com with SMTP id ay11-20020a05600c1e0b00b0038eb92fa965so5216104wmb.4;
        Thu, 21 Apr 2022 00:12:33 -0700 (PDT)
X-Gm-Message-State: AOAM530Ybh2YrZwIJarfVWgYYu3pRDL5LBGSk/ZXfGBoOlqUGJ5BHY0D
        Qdc8aKnK0mxOYn40muHQ0I9A06pxIopB5dl05ZA=
X-Google-Smtp-Source: ABdhPJyiDq8vDuHIbY6D8eienOMlm5JvlAwo2YuDKmIos2MBFwy3hSQ+D3GAoUjwkE1kjA32vI2wLWEQWYui85aMEb4=
X-Received: by 2002:a1c:f219:0:b0:38c:782c:3bb with SMTP id
 s25-20020a1cf219000000b0038c782c03bbmr6996684wmc.94.1650525152760; Thu, 21
 Apr 2022 00:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220414091018.896737-1-niklas.cassel@wdc.com>
 <f379cb56-6ff5-f256-d5f2-3718a47e976d@opensource.wdc.com> <Yli8voX7hw3EZ7E/@x1-carbon>
 <81788b56-5b15-7308-38c7-c7f2502c4e15@linux-m68k.org> <87levzzts4.fsf_-_@email.froward.int.ebiederm.org>
 <01b063d7-d5c2-8af0-ad90-ed6c069252c5@linux-m68k.org> <CAMuHMdXd94L=766usN4WG-hK2MpQLy50mJZ=9G9NGv03kx8V8Q@mail.gmail.com>
In-Reply-To: <CAMuHMdXd94L=766usN4WG-hK2MpQLy50mJZ=9G9NGv03kx8V8Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Apr 2022 09:12:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Cjna7H_YxFvg6UEOqQf9ZqLp9EVOCFFewzWBHVT4nWg@mail.gmail.com>
Message-ID: <CAK8P3a3Cjna7H_YxFvg6UEOqQf9ZqLp9EVOCFFewzWBHVT4nWg@mail.gmail.com>
Subject: Re: [PATCH] binfmt_flat: Remove shared library support
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mike Frysinger <vapier@gentoo.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Jesse Taube <Mr.Bossman075@gmail.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:AnKS55OURsqF0k+WfRdXuD9BM8buN8Mbwoc8FI9tXjJLFGTbe3y
 PcqrpQ9h898pPNrInIbRk2ml2JcjSVTnepfYr1B3MLdgEDa7+TCAZXw/UgPtthe68aOsKQ0
 qGnx98dccBSfWikOAK7utp183m3T7Q8iOGPiVAPCdM20UqcGDpW+T8VEfSYrnsGRW5mLmqn
 385GSQ5/7sSnyM6aNVbRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/JMMmNE2Oic=:BirHcXuMGJCFrC6RSL7/5o
 1VjRILjb7n4eFtZEheoeOoxF2woHNdWCkWmYOxLnpUfip81LCLCEgsKFgXvug/ON4h8kc+7Ta
 eJYfaorU4tsFOAdByTEkmQSXk2wEzU+vW749+CrEG7GQ8qRMn4Oym26IzVIJ4SP0aJSt3E8b9
 GLAb7veGQN2C0OP2+9GkUVfiVvDp/Kgv3PlT8eOio0CdYOUla1/eEfoIK/tuWQv4KwXvE69Bs
 iCqt7609gLCu7mZ6vQqLzOc/nHwlS97fLA85NT4wduU5aYjRCuWrCxKqMUBiJImwqupq91wHY
 7eusNJlToo4mlBtBrCDMz5x8KbtyFGg38h0NG43oTGPAPvHYUzSBSoDR9cZrZrPin/5Cpf1vA
 t6Rr8VRzjJMLW6Arb3uKn7iMLqMK/M67WU+yYDErDGC1ms9Ny04LQ0wiQQOl7GcctAyvQpOHP
 eWrFRZL7k6F0054+aIB+/XaQWukOLFRZJ2R4fWQcqEUSHXh8+o6P4J/Jftx6eQsA1T7V7MyHc
 /U8H/vsoFrSbyMMW8JdQAMvRzzITGN5l6NnCaNw3r2jHsHO2e6kUetEwWeRiFCq6XWv7fmJEz
 PoXLQIxr1rMVJeK6S0En1ishKX6+BWssbsSdkzmRUUmItNYejbwWsh87BXX9rsxK3BMG+H9nC
 JWDFyy88upCmWM1e6bCuKbouXFFSh83nUVZs9N/cAYKf1n/V1r8/Qu+IYDGMp3vRQBXQbS0CE
 eKGShbPDc6TUGMT3f9EpE2PvwcALKfUa8+QlQYSMg+sLY1Glf/SOoUheuPHanKFiKoTR1gxzQ
 CcWT63fI9R5ooXXW370XX0eqQ0DmlEmCiPHtt9DYxI0vm/fXSo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 21, 2022 at 8:52 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Apr 21, 2022 at 1:53 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
> > On 21/4/22 00:58, Eric W. Biederman wrote:
> > > In a recent discussion[1] it was reported that the binfmt_flat library
> > > support was only ever used on m68k and even on m68k has not been used
> > > in a very long time.
> > >
> > > The structure of binfmt_flat is different from all of the other binfmt
> > > implementations becasue of this shared library support and it made
> > > life and code review more effort when I refactored the code in fs/exec.c.
> > >
> > > Since in practice the code is dead remove the binfmt_flat shared libarary
> > > support and make maintenance of the code easier.
> > >
> > > [1] https://lkml.kernel.org/r/81788b56-5b15-7308-38c7-c7f2502c4e15@linux-m68k.org
> > > Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> > > ---
> > >
> > > Can the binfmt_flat folks please verify that the shared library support
> > > really isn't used?
> >
> > I can definitely confirm I don't use it on m68k. And I don't know of
> > anyone that has used it in many years.
> >
> >
> > > Was binfmt_flat being enabled on arm and sh the mistake it looks like?
>
> I think the question was intended to be
>
>     Was *binfmt_flat_shared_flat* being enabled on arm and sh the
>     mistake it looks like?
>
> > >
> > >   arch/arm/configs/lpc18xx_defconfig |   1 -
> > >   arch/arm/configs/mps2_defconfig    |   1 -
> > >   arch/arm/configs/stm32_defconfig   |   1 -
> > >   arch/arm/configs/vf610m4_defconfig |   1 -

Adding stm32, mps2 and imxrt maintainers to Cc, they are the most active
armv7-m users and should know if the shared library support is used anywhere.

     Arnd
