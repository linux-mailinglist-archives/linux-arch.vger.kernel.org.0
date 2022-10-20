Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF262606031
	for <lists+linux-arch@lfdr.de>; Thu, 20 Oct 2022 14:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiJTM3s (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Oct 2022 08:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiJTM3q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Oct 2022 08:29:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D844357E3;
        Thu, 20 Oct 2022 05:29:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F52C61B4C;
        Thu, 20 Oct 2022 12:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A5DC4315E;
        Thu, 20 Oct 2022 12:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666268982;
        bh=UmMmPdClNg1iQDMWEWV9haE2T0LxMvQ9tZrDoXCBYo0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MEfjHFy9IjCP7buSekEgL1dlGnUtqlTjnGc/q1dTIIDKQv0uf0qjS7CxNd3l8EB6J
         2GNzCTHJIHOS8VN187wDQDCMY2iqEjLgjGx1qCtlusqm6jpodnpS3t3oWP7zr6AYNq
         UEzhL5dWMhhdVKCFkmkfLcfRjIPJrFoQdp6J00szZ/2HtTnIdH1fHRXi298ggf93mp
         22oa5u+mRMglmJ1n+asHS7yqiYMY5/K+VEURZQXecucwx6LEFR6n8XMh0aVAzyJgR6
         6iMMRZzKUnyGZkdB8JE+Eg6ZvcSoNvNWQhtURvaQOsdqV/y+d1nrYLMvKa7N6ZWJAS
         JjIZYABcXGdmA==
Received: by mail-ot1-f48.google.com with SMTP id a14-20020a9d470e000000b00661b66a5393so11286572otf.11;
        Thu, 20 Oct 2022 05:29:42 -0700 (PDT)
X-Gm-Message-State: ACrzQf16auEbOb+Jdv8o3wMI6DvbQ3WChwfqBW5fM5+9SJ0TptRZioZ9
        aF4mDHeFDf5jArsoDKvUZCBNR8F5oatkOK60MkQ=
X-Google-Smtp-Source: AMsMyM5gCGTTh54jnxdirFtIVTdFINnQG/9tf0drJtT/lwsLNSHciyP4H6XwE+c8o6/CC6J8KKKz8XrQWvspHXqgvHo=
X-Received: by 2002:a9d:3634:0:b0:661:a991:7c57 with SMTP id
 w49-20020a9d3634000000b00661a9917c57mr6495888otb.308.1666268981727; Thu, 20
 Oct 2022 05:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20221002012451.2351127-1-guoren@kernel.org> <20221002012451.2351127-5-guoren@kernel.org>
 <YzrJ0wQxWfjWCxhQ@FVFF77S0Q05N> <CAJF2gTRBEGx3qncpk_C8rCsFN+kqxjgeAcPvZU5m7kDnpwytoA@mail.gmail.com>
 <Y1ERsP0YYVNulWnw@FVFF77S0Q05N>
In-Reply-To: <Y1ERsP0YYVNulWnw@FVFF77S0Q05N>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 20 Oct 2022 20:29:28 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTurEaFjbKvj1tUptq_TLpXeBAE1UstNYxriC-7r5MHpQ@mail.gmail.com>
Message-ID: <CAJF2gTTurEaFjbKvj1tUptq_TLpXeBAE1UstNYxriC-7r5MHpQ@mail.gmail.com>
Subject: Re: [PATCH V6 04/11] compiler_types.h: Add __noinstr_section() for noinstr
To:     Mark Rutland <mark.rutland@arm.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, zouyipeng@huawei.com,
        bigeasy@linutronix.de, David.Laight@aculab.com,
        chenzhongjin@huawei.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Borislav Petkov <bp@alien8.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Mark and Lai,

On Thu, Oct 20, 2022 at 5:15 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Sat, Oct 08, 2022 at 09:54:39AM +0800, Guo Ren wrote:
> > On Mon, Oct 3, 2022 at 7:39 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > On Sat, Oct 01, 2022 at 09:24:44PM -0400, guoren@kernel.org wrote:
> > > > From: Lai Jiangshan <laijs@linux.alibaba.com>
> > > >
> > > > And it will be extended for C entry code.
> > > >
> > > > Cc: Borislav Petkov <bp@alien8.de>
> > > > Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> > > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > > > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > > Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> > > > ---
> > > >  include/linux/compiler_types.h | 8 +++++---
> > > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> > > > index 4f2a819fd60a..e9ce11ea4d8b 100644
> > > > --- a/include/linux/compiler_types.h
> > > > +++ b/include/linux/compiler_types.h
> > > > @@ -227,9 +227,11 @@ struct ftrace_likely_data {
> > > >  #endif
> > > >
> > > >  /* Section for code which can't be instrumented at all */
> > > > -#define noinstr                                                              \
> > > > -     noinline notrace __attribute((__section__(".noinstr.text")))    \
> > > > -     __no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
> > > > +#define __noinstr_section(section)                           \
> > > > +     noinline notrace __section(section) __no_profile        \
> > > > +     __no_kcsan __no_sanitize_address __no_sanitize_coverage
> > > > +
> > > > +#define noinstr __noinstr_section(".noinstr.text")
> > >
> > > One thing proably worth noting here is that while KPROBES will avoid
> > > instrumenting `.noinstr.text`, that won't happen automatically for other
> > > __noinstr_section() sections, and that will need to be inhibited through other
> > > means (e.g. the kprobes blacklist, explicit NOKPROBE_SYMBOL() annotation, or
> > > otherwise).
> >
> > In riscv, "we select HAVE_KPROBES if !XIP_KERNEL", so don't worry
> > about that. I don't think we could enable kprobe for XIP_KERNEL in the
> > future.
>
> Sure; but someone else might use __noinstr_section() elsewhere where this could
> matter, and I was suggesting that we could add a comment as above.
Okay, how about:

/* Be care KPROBES will avoid instrumenting .noinstr.text, not
__noinstr_section(). */
#define __noinstr_section(section)                             \
       noinline notrace __section(section) __no_profile        \
       __no_kcsan __no_sanitize_address __no_sanitize_coverage

/* Section for code which can't be instrumented at all */
#define noinstr __noinstr_section(".noinstr.text")

>
> Thanks,
> Mark.



-- 
Best Regards
 Guo Ren
