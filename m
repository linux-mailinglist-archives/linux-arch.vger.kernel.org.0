Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773754FF249
	for <lists+linux-arch@lfdr.de>; Wed, 13 Apr 2022 10:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbiDMIlj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Apr 2022 04:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbiDMIlB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Apr 2022 04:41:01 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C874EA27;
        Wed, 13 Apr 2022 01:38:33 -0700 (PDT)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 23D8cIC5004168;
        Wed, 13 Apr 2022 17:38:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 23D8cIC5004168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649839098;
        bh=tD5ScFHal8it/8NYvNokdNwdBCS6nYo2z9fLwt69gtM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V0cAa14iNtjtI2uwJtCAI3bNp0AhpEn0j8odLrA3XDqiGNjNRKBp/AOVncco+AT7A
         TwsALgATn3x786OXaDeqUvwb3By7zT20lVr70Kd+msoaqA0hkU4jLD4mm3rSpgZY2f
         HkzUkhldPJTudEUMvYxhsNwXSvyro4yEnYO7n9IXrV41m42rPgyK9I7ABuzY4XMCUZ
         JaxOHu9c98LYFPeLQ1CVg+iANFiddSpAouJoCqKMwiNnMiA47gbpd3kwOkeFJe5z0C
         rQlrTaplxNzISRbwgF/gUFCQNtQ3/TE2mD8bB+36O7eYCIOy+H685FVvmumGBI8pwO
         n3/rgaAg6inZw==
X-Nifty-SrcIP: [209.85.216.52]
Received: by mail-pj1-f52.google.com with SMTP id bg24so1306431pjb.1;
        Wed, 13 Apr 2022 01:38:18 -0700 (PDT)
X-Gm-Message-State: AOAM532Xpd2DVumc0r/WA5T+924fwG7/7gQJeLQ6n9GvFvPZVq6dnIBo
        +fBClcVFAvZAB9aYDfk9o9sA0sZqQWGhgLkjo3I=
X-Google-Smtp-Source: ABdhPJxHW6zTiVnXDm+dMerKl21YroSREGhl4mFnymHGRgnvYYSox/WDDG+/CKbn23ZwzvdMYvCb75NxDuCvPzB2pqE=
X-Received: by 2002:a17:902:7083:b0:158:41f2:3a83 with SMTP id
 z3-20020a170902708300b0015841f23a83mr19095045plk.99.1649839097492; Wed, 13
 Apr 2022 01:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220412231508.32629-1-libo.chen@oracle.com> <20220412231508.32629-2-libo.chen@oracle.com>
 <c7d26e9d-8c70-86a6-cdab-b180a365804f@infradead.org> <157cb46a-d134-2e72-4a65-14e378dd2b8e@oracle.com>
 <26855467-107d-4ba1-4f32-2afd5918d5b7@infradead.org> <cbb6b94e-3b9d-c7b6-a10e-6203a3a8b3f3@oracle.com>
 <4c6b3445-78b2-090f-c7c9-291d49c45019@infradead.org> <506db9a9-47ff-658a-a821-27315949e8c3@oracle.com>
In-Reply-To: <506db9a9-47ff-658a-a821-27315949e8c3@oracle.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 13 Apr 2022 17:37:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNATxMjMV2m+ycs6rVwEgHzL_7zUP+H4W_xr2xEZ1e3cFVg@mail.gmail.com>
Message-ID: <CAK7LNATxMjMV2m+ycs6rVwEgHzL_7zUP+H4W_xr2xEZ1e3cFVg@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/1] lib/Kconfig: remove DEBUG_PER_CPU_MAPS
 dependency for CPUMASK_OFFSTACK
To:     Libo Chen <libo.chen@oracle.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 13, 2022 at 3:56 PM Libo Chen <libo.chen@oracle.com> wrote:
>
> Hi Randy
>
> On 4/12/22 22:54, Randy Dunlap wrote:
> > Hi Libo,
> >
> > On 4/12/22 19:34, Libo Chen wrote:
> >>
> >> On 4/12/22 19:13, Randy Dunlap wrote:
> >>> Hi,
> >>>
> >>> On 4/12/22 18:35, Libo Chen wrote:
> >>>> Hi Randy,
> >>>>
> >>>> On 4/12/22 17:18, Randy Dunlap wrote:
> >>>>> Hi--
> >>>>>
> >>>>> On 4/12/22 16:15, Libo Chen wrote:
> >>>>>> Forcing CPUMASK_OFFSTACK to be conditoned on DEBUG_PER_CPU_MAPS doesn't
> >>>>>> make a lot of sense nowaday. Even the original patch dating back to 2008,
> >>>>>> aab46da0520a ("cpumask: Add CONFIG_CPUMASK_OFFSTACK") didn't give any
> >>>>>> rationale for such dependency.
> >>>>>>
> >>>>>> Nowhere in the code supports the presumption that DEBUG_PER_CPU_MAPS is
> >>>>>> necessary for CONFIG_CPUMASK_OFFSTACK. Make no mistake, it's good to
> >>>>>> have DEBUG_PER_CPU_MAPS for debugging purpose or precaution, but it's
> >>>>>> simply not a hard requirement for CPUMASK_OFFSTACK. Moreover, x86 Kconfig
> >>>>>> already can set CPUMASK_OFFSTACK=y without DEBUG_PER_CPU_MAPS=y.
> >>>>>> There is no reason other architectures cannot given the fact that they
> >>>>>> have even fewer, if any, arch-specific CONFIG_DEBUG_PER_CPU_MAPS code than
> >>>>>> x86.
> >>>>>>
> >>>>>> Signed-off-by: Libo Chen <libo.chen@oracle.com>
> >>>>>> ---
> >>>>>>     lib/Kconfig | 2 +-
> >>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/lib/Kconfig b/lib/Kconfig
> >>>>>> index 087e06b4cdfd..7209039dfb59 100644
> >>>>>> --- a/lib/Kconfig
> >>>>>> +++ b/lib/Kconfig
> >>>>>> @@ -511,7 +511,7 @@ config CHECK_SIGNATURE
> >>>>>>         bool
> >>>>>>       config CPUMASK_OFFSTACK
> >>>>>> -    bool "Force CPU masks off stack" if DEBUG_PER_CPU_MAPS
> >>>>> This "if" dependency only controls whether the Kconfig symbol's prompt is
> >>>>> displayed (presented) in kconfig tools. Removing it makes the prompt always
> >>>>> be displayed.
> >>>>>
> >>>>> Any architecture could select (should be able to) CPUMASK_OFFSTACK independently
> >>>>> of DEBUG_PER_CPU_MAPS.
> >>>> Do you mean changing arch/xxxx/Kconfig to select CPUMASK_OFFSTACK under some config xxx? That will work but it requires code changes for each architecture.
> >>>> But if you are talking about setting CONFIG_CPUMASK_OFFSTACK=y without CONFIG_DEBUG_PER_CPU_MAPS directly in config file, I have tried, it doesn't work.
> >>> I'm just talking about the Kconfig change below.  Not talking about whatever else
> >>> it might require per architecture.
> >>>
> >>> But you say you have tried that and it doesn't work. What part of it doesn't work?
> >>> The Kconfig part or some code execution?
> >> oh the Kconfig part. For example, make olddefconfig on a config file with CPUMASK_OFFSTACK=y only turns off CPUMASK_OFFSTACK unless I explicitly set DEBUG_PER_CPU_MAPS=y
> > I can enable CPUMASK_OFFSTACK for arm64 without having DEBUG_PER_CPU_MAPS enabled.
> > (with a patch, of course.)
> > It builds OK. I don't know if it will run OK.
>
> I am a little confused, did you succeed with your patch (replacing "if"
> with "depends on") or my patch (removing "if")? Because I definitely
> cannot enable CPUMASK_OFFSTACK for arm64 without DEBUG_PER_CPUMAPS
> enabled using your change.
> > I think that you are arguing for a patch like this:
>
> I am actually arguing for the opposite, I don't think CPUMASK_OFFSTACK
> should require DEBUG_PER_CPU_MAPS. They should be separate and
> independent to each other. So removing "if ..." should be enough in my
> opinion.
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -511,7 +511,8 @@ config CHECK_SIGNATURE
> >       bool
> >
> >   config CPUMASK_OFFSTACK
> > -     bool "Force CPU masks off stack" if DEBUG_PER_CPU_MAPS
> > +     bool "Force CPU masks off stack"
> > +     depends on DEBUG_PER_CPU_MAPS
>
> This forces every arch to enable DEBUG_PER_CPU_MAPS if they want to
> enable CPUMASK_OFFSTACK, it's even stronger than "if". My whole argument
> is CPUMASK_OFFSTACK should be enable/disabled independent of
> DEBUG_PER_CPU_MASK
> >       help
> >         Use dynamic allocation for cpumask_var_t, instead of putting
> >         them on the stack.  This is a bit more expensive, but avoids
> >
> >
> > As I said earlier, the "if" on the "bool" line just controls the prompt message.
> > This patch make CPUMASK_OFFSTACK require DEBUG_PER_CPU_MAPS -- which might be overkill.
> >
>
> Okay I understand now "if" on the "boot" is not a dependency and it only
> controls the prompt message, then the question is why we cannot enable
> CPUMASK_OFFSTACK without DEBUG_PER_CPU_MAPS if it only controls prompt
> message? Is it not the behavior we expect?
>


    config CPUMASK_OFFSTACK
            bool "Force CPU masks off stack" if DEBUG_PER_CPU_MAPS

... is equivalent to this:

    config CPUMASK_OFFSTACK
            bool
            prompt "Force CPU masks off stack" if DEBUG_PER_CPU_MAPS



When DEBUG_PER_CPU_MAPS is disabled, the prompt line is ignored,
and CPUMASK_OFFSTACK becomes a user-unconfigurable option.


Other options still can select it,
but users cannot enable it directly from the prompt.

I see x86 and powerpc do this.

$ kgrep 'select CPUMASK_OFFSTACK'
./arch/x86/Kconfig:946: select CPUMASK_OFFSTACK
./arch/powerpc/Kconfig:164: select CPUMASK_OFFSTACK if NR_CPUS >= 8192







> Libo
>
> >> Libo
> >>> I'll test the Kconfig part of it later (in a few hours).
> >>>
> >>>> Libo
> >>>>> Is there another problem here?
> >>>>>
> >>>>>> +    bool "Force CPU masks off stack"
> >>>>>>         help
> >>>>>>           Use dynamic allocation for cpumask_var_t, instead of putting
> >>>>>>           them on the stack.  This is a bit more expensive, but avoids
>


-- 
Best Regards
Masahiro Yamada
