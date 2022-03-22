Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BB54E36E0
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 03:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbiCVCzD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Mar 2022 22:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235685AbiCVCzB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Mar 2022 22:55:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB75130C34;
        Mon, 21 Mar 2022 19:53:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31EB96111E;
        Tue, 22 Mar 2022 02:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93ED4C36AEA;
        Tue, 22 Mar 2022 02:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647917612;
        bh=vBcCiXwRGGbyM3jDSIY//Yb05Zqr3yL4wE0ITjd0Zkg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lFxvQ12/5InyCYCmdKIREud5ibVPRJkVULCo9iuAtGmFY/nz2fN8U7wnWQmC2A9ky
         LoKacK6y5G6ZePsB3JcCSZXUsIwEpx4gb/cYoa8W+hol0NxYwAe652+BuBmog8dp+E
         LqMvhFyJ+9InWg+09sUmjeWyM5qQ6cZf5DQ0XBD4vcyFzEXebsyYfUFO1ydr6RqUoM
         aq0X7jQ/vz806SmvSH38vHeHAaC1Z0fFUmJiirbsbK+sTZHvZRdR/OY8JFQfzXGchh
         4xNnfsxfVNpgPmGZSdMMDxw6hYRftQ1yCpgANFqxdoylymy7D5ZjxUsvVfMPlG/mvj
         k8E2P9TlhFi2A==
Received: by mail-vs1-f41.google.com with SMTP id a127so9504859vsa.3;
        Mon, 21 Mar 2022 19:53:32 -0700 (PDT)
X-Gm-Message-State: AOAM533+iRVwby8+tJtwm+0zzDcwHT/vwIeDcFQD31SY0ELjk/7Xf5yQ
        NLyteaIOaQWpEFvUaS4wzyuCk3UabFpBEstRMek=
X-Google-Smtp-Source: ABdhPJwl1toKmvF+Gk8R6UAzWG4eJC+We2oGMF+gqSvWETI5Ru0ckJ2Fn30jOEin3068r5f4+PBix9g1VBfLVWRCMu0=
X-Received: by 2002:a05:6102:5490:b0:325:2ca5:14f with SMTP id
 bk16-20020a056102549000b003252ca5014fmr1727074vsb.40.1647917611519; Mon, 21
 Mar 2022 19:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220319142759.1026237-1-chenhuacai@loongson.cn>
 <20220319143817.1026708-1-chenhuacai@loongson.cn> <20220319143817.1026708-3-chenhuacai@loongson.cn>
 <CAK8P3a2gKGuMTLawFSf1hd3LY7rCVUquTPVHMcxBTok6+y-Rag@mail.gmail.com>
 <CAAhV-H6eDSU20gjLgEKM318i1ksk23thv9cLJKmAo_cBzjtEkw@mail.gmail.com> <CAK8P3a0PXeEAvZeq0djqCFqPSkFe5z-bg81kcs69ZTcBSL=24Q@mail.gmail.com>
In-Reply-To: <CAK8P3a0PXeEAvZeq0djqCFqPSkFe5z-bg81kcs69ZTcBSL=24Q@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 22 Mar 2022 10:53:23 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6GZCD6Cwf1DE5pV5PpTWUfSOhT8dR5sfzU+Nrtdmw_nA@mail.gmail.com>
Message-ID: <CAAhV-H6GZCD6Cwf1DE5pV5PpTWUfSOhT8dR5sfzU+Nrtdmw_nA@mail.gmail.com>
Subject: Re: [PATCH V8 10/22] LoongArch: Add exception/interrupt handling
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Mon, Mar 21, 2022 at 6:48 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Mar 21, 2022 at 9:46 AM Huacai Chen <chenhuacai@kernel.org> wrote:
> > On Mon, Mar 21, 2022 at 4:38 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Sat, Mar 19, 2022 at 3:38 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> > >
> > > > +unsigned long eentry;
> > > > +EXPORT_SYMBOL_GPL(eentry);
> > > > +unsigned long tlbrentry;
> > > > +EXPORT_SYMBOL_GPL(tlbrentry);
> > >
> > > Why are these exported to modules? Maybe add a comment here, or remove
> > > the export if it's not actually needed.
> >
> > They are used by the kvm module in our internal repo.
>
> Ok, that is fine then. For the moment, please add a comment about it here,
> or remove the exports in the initial merge and add them back when you
> submit the kvm code.
OK, I will remove them.

Huacai
>
>        Arnd
