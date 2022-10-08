Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50535F8229
	for <lists+linux-arch@lfdr.de>; Sat,  8 Oct 2022 03:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiJHBy6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Oct 2022 21:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiJHBy5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Oct 2022 21:54:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C28D2DABD;
        Fri,  7 Oct 2022 18:54:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDC68B82492;
        Sat,  8 Oct 2022 01:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605E0C433D7;
        Sat,  8 Oct 2022 01:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665194092;
        bh=CUFZ0z9l02FjN7ckdvPKRJnglR9lkpusJd0PBOvZrXw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UwmSc3NZxGMd/IffLapEC4zORlO4d2fKC0VPre2BFLkKg82RddEb58HYXVKKLO1Zp
         rOpyQvBEeySf2tgLZaBFbbPFpNd+j9GYxso3DhCPl9QfMQPMJK7XekrA9w2gHvF5zx
         dKIKiuU5/vabr5bfzKRIFcd1agVlAbF4qS10WDo5j/XDWXMddW3JslXbDnxD3sFCFS
         5MtotAtn8VH0Dh0WUA4rHVI+YwCxCZ2EII5uRwWc3hGMb4zP2Q8PHwtVDZA9zePxyY
         XNJtSnian5BM43olELRjw3XaVPtzFRV2GRT1WWNG4Day8WSvyygIqHur00KaD0VsIU
         mWci9KdWLcoLQ==
Received: by mail-oi1-f180.google.com with SMTP id m81so7445797oia.1;
        Fri, 07 Oct 2022 18:54:52 -0700 (PDT)
X-Gm-Message-State: ACrzQf0awnOB4jv8RSXqeFeDbB7qxLH558N/bydom7HUQyVAkBagR/xL
        7SmgzgVUvNzKfmbDloP4U0S/Qy/cOP6HAyox89E=
X-Google-Smtp-Source: AMsMyM7kq/NhJ1B79s0Ic1kmxt3FaB/EzoK+GdAW6e28SaoGktxTmS+UFtRa1hykS+rP26AkrxbJw7IpgMiSojsLnqs=
X-Received: by 2002:a05:6808:151f:b0:350:1b5e:2380 with SMTP id
 u31-20020a056808151f00b003501b5e2380mr9157319oiw.112.1665194091481; Fri, 07
 Oct 2022 18:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221002012451.2351127-1-guoren@kernel.org> <20221002012451.2351127-5-guoren@kernel.org>
 <YzrJ0wQxWfjWCxhQ@FVFF77S0Q05N>
In-Reply-To: <YzrJ0wQxWfjWCxhQ@FVFF77S0Q05N>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 8 Oct 2022 09:54:39 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRBEGx3qncpk_C8rCsFN+kqxjgeAcPvZU5m7kDnpwytoA@mail.gmail.com>
Message-ID: <CAJF2gTRBEGx3qncpk_C8rCsFN+kqxjgeAcPvZU5m7kDnpwytoA@mail.gmail.com>
Subject: Re: [PATCH V6 04/11] compiler_types.h: Add __noinstr_section() for noinstr
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, zouyipeng@huawei.com,
        bigeasy@linutronix.de, David.Laight@aculab.com,
        chenzhongjin@huawei.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Borislav Petkov <bp@alien8.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 3, 2022 at 7:39 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Sat, Oct 01, 2022 at 09:24:44PM -0400, guoren@kernel.org wrote:
> > From: Lai Jiangshan <laijs@linux.alibaba.com>
> >
> > And it will be extended for C entry code.
> >
> > Cc: Borislav Petkov <bp@alien8.de>
> > Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> > ---
> >  include/linux/compiler_types.h | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> > index 4f2a819fd60a..e9ce11ea4d8b 100644
> > --- a/include/linux/compiler_types.h
> > +++ b/include/linux/compiler_types.h
> > @@ -227,9 +227,11 @@ struct ftrace_likely_data {
> >  #endif
> >
> >  /* Section for code which can't be instrumented at all */
> > -#define noinstr                                                              \
> > -     noinline notrace __attribute((__section__(".noinstr.text")))    \
> > -     __no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
> > +#define __noinstr_section(section)                           \
> > +     noinline notrace __section(section) __no_profile        \
> > +     __no_kcsan __no_sanitize_address __no_sanitize_coverage
> > +
> > +#define noinstr __noinstr_section(".noinstr.text")
>
> One thing proably worth noting here is that while KPROBES will avoid
> instrumenting `.noinstr.text`, that won't happen automatically for other
> __noinstr_section() sections, and that will need to be inhibited through other
> means (e.g. the kprobes blacklist, explicit NOKPROBE_SYMBOL() annotation, or
> otherwise).

In riscv, "we select HAVE_KPROBES if !XIP_KERNEL", so don't worry
about that. I don't think we could enable kprobe for XIP_KERNEL in the
future.

>
> Thanks,
> Mark.



--
Best Regards
 Guo Ren
