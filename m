Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927EF529721
	for <lists+linux-arch@lfdr.de>; Tue, 17 May 2022 04:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiEQCIa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 May 2022 22:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiEQCI3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 May 2022 22:08:29 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C1744A0C;
        Mon, 16 May 2022 19:08:26 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id e7so8408194vkh.2;
        Mon, 16 May 2022 19:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YNIVHyUn80V86PKxp2T+1SDr/HwkAtaW1gqkh7u+Rw8=;
        b=YuGeokCVKMdqtN5SO4Fl2AQYzmNzAb7kLE1K4NoFiQ/ZrqzXdJn9lbiFBLL0Xafc+y
         D9fH1HB6olFgX9O6FcEbeFpm4WaHnckt4OH0tVg07rj7c8M5Q35ANEYVa3dpCP3qQe9/
         1ZfoCUm2UPdXcykKHjjNaBU26t5Znm3b4vLBlgAWp1NXVSOBga76hUML7Iygx3WOfRUf
         ToTPuW167m6vHBHB3q12cIoAOaDwYit8u8vhUV5YYa1NyIj6OZMZiGK5laweZ4FKC84y
         778rHm0pzSU0MiEUrM/ZXF4g0dssjKeRHwb4DTNq29xsXaNBRZlEnCNevH1nq9MdlV/A
         VRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YNIVHyUn80V86PKxp2T+1SDr/HwkAtaW1gqkh7u+Rw8=;
        b=vsSILfFX7//WAc9gUhy3EPyUPbwY0fXpL2S8RNNx6NZ5J1lj8OB5EuiX/Y/jORqgff
         gmjZCdlFfe8qBlGwmDKUNKsLUggugtbCBaT8rZpzNBbTduPM/2WduH6xN9SxBM5aCmVv
         q5eUoCqeN/Ea35Y8OL4fX3VrveVvi1rXkyXlsurkmK0FexPspPOLNde5aB9Ea3jRmWzL
         T74CjpZKMYCscrhc7AGkujkeCQbsaVNunXjYKnX2EAjOmHj6sPw66nu2C47SLKIcbg08
         xvw+rqTBiL8pPJhI4e/L/xMjLYx+H8DufR2fvQjZO5+xCqa1tr9Qi5HE9MTs+m+K4cUX
         h8Sg==
X-Gm-Message-State: AOAM531/4kKCRUP2X1p64mazYC4Zq3/KzxcGCCO0Jh6Bg6QTj4gtBS10
        kZgIiIrbaOXnLVhy4SjhLbQ0OcCDRoMrPu9xo2GwT6mu9i8MBg==
X-Google-Smtp-Source: ABdhPJzfFeRRqLLynezVgoDZ1gxVXAYywowXiF9oscS6RvP76ClWqSOk4LcUUkcFbXvhl1q/Xozg6Oi3scblxgJbPD4=
X-Received: by 2002:a1f:1609:0:b0:34d:ff24:30ef with SMTP id
 9-20020a1f1609000000b0034dff2430efmr7800818vkw.14.1652753305507; Mon, 16 May
 2022 19:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220514080402.2650181-1-chenhuacai@loongson.cn>
 <20220514080402.2650181-15-chenhuacai@loongson.cn> <ef37e578-d843-6a2f-2108-2a26dc54bece@xen0n.name>
 <CAAhV-H7UwLJLiMtjkW0xxfsBBaCPXqkQ-d+ZW4rm+=igvVP6ew@mail.gmail.com>
 <b30e5b28-2a3a-f3a6-1bb1-592323f6eadd@xen0n.name> <87bkvxd12b.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87bkvxd12b.fsf@email.froward.int.ebiederm.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Tue, 17 May 2022 10:08:18 +0800
Message-ID: <CAAhV-H7R4hioE-dHVxAnPmeJJ-eqiWkdmZWxNDfLesuvURCLcw@mail.gmail.com>
Subject: Re: [PATCH V10 14/22] LoongArch: Add signal handling support
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "<linux-arch@vger.kernel.org>" <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>
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

Hi, Eric,

On Mon, May 16, 2022 at 10:07 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> WANG Xuerui <kernel@xen0n.name> writes:
>
> > Hi,
> >
> > On 5/15/22 21:48, Huacai Chen wrote:
> >> diff --git a/arch/loongarch/include/uapi/asm/sigcontext.h b/arch/loongarch/include/uapi/asm/sigcontext.h
> >> new file mode 100644
> >> index 000000000000..efeb8b3f8236
> >> --- /dev/null
> >> +++ b/arch/loongarch/include/uapi/asm/sigcontext.h
> >> @@ -0,0 +1,63 @@
> >> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> >> +/*
> >> + * Author: Hanlu Li <lihanlu@loongson.cn>
> >> + *         Huacai Chen <chenhuacai@loongson.cn>
> >> + *
> >> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> >> + */
> >> +#ifndef _UAPI_ASM_SIGCONTEXT_H
> >> +#define _UAPI_ASM_SIGCONTEXT_H
> >> +
> >> +#include <linux/types.h>
> >> +#include <linux/posix_types.h>
> >> +
> >> +/* FP context was used */
> >> +#define USED_FP                      (1 << 0)
> >> +/* Load/Store access flags for address error */
> >> +#define ADRERR_RD            (1 << 30)
> >> +#define ADRERR_WR            (1 << 31)
> >>> I've searched GitHub globally, and my local glibc checkout, for usages
> >>> of these 3 constants, and there seems to be none; please consider
> >>> removing these if doable. We don't want cruft in uapi right from the
> >>> beginning.
> >> They will be used in our glibc, I promise.
> > Okay then. Seems simple enough, and from my quick grepping these appear to be
> > original creations -- not carried over from somewhere else, so it's already
> > highly likely that some of the userland tools need these anyway, just not
> > released yet.
>
> I can understand exporting these values but the names aren't very
> well namespaced at all.  Which means they could accidentially
> conflict with things.
>
> It would probably be better to do:
> SC_USED_FP
> SC_ADDRERR_RD
> SC_ADDRERR_WR
SC_ prefix is good, but ADRERR_RD/ADRERR_WR is used together with
SIGSEGV/SIGBUS, so I want to keep the same as BUS_ADRERR (a single D)
if possible.

>
> And with two D's please.  It breaks my fingers to have to
> make a typo like that on purpose.
>
> This is very much a bikeshed comment, but I think the
> bikeshed should be painted.
>
> >>>> +
> >>>> +struct sigcontext {
> >>>> +     __u64   sc_pc;
> >>>> +     __u64   sc_regs[32];
> >>>> +     __u32   sc_flags;
> >>>> +     __u64   sc_extcontext[0] __attribute__((__aligned__(16)));
> >>>> +};
> >>>> +
> >>>> +#define CONTEXT_INFO_ALIGN   16
> >>>> +struct _ctxinfo {
> >>>> +     __u32   magic;
> >>>> +     __u32   size;
> >>>> +     __u64   padding;        /* padding to 16 bytes */
> >>>> +};
> >>>> +
> >>>> +/* FPU context */
> >>>> +#define FPU_CTX_MAGIC                0x46505501
> >>>> +#define FPU_CTX_ALIGN                8
> >>>> +struct fpu_context {
> >>>> +     __u64   regs[32];
> >>>> +     __u64   fcc;
> >>>> +     __u32   fcsr;
> >>>> +};
> >>> The 3 structs above should already see usage downstream (glibc and other
> >>> low-level friends), so they probably shouldn't be touched by now. At
> >>> least I can't see problems.
> >>>> +
> >>>> +/* LSX context */
> >>>> +#define LSX_CTX_MAGIC                0x53580001
> >>>> +#define LSX_CTX_ALIGN                16
> >>>> +struct lsx_context {
> >>>> +     __u64   regs[2*32];
> >>>> +     __u64   fcc;
> >>>> +     __u32   fcsr;
> >>>> +     __u32   vcsr;
> >>>> +};
> >>>> +
> >>>> +/* LASX context */
> >>>> +#define LASX_CTX_MAGIC               0x41535801
> >>>> +#define LASX_CTX_ALIGN               32
> >>>> +struct lasx_context {
> >>>> +     __u64   regs[4*32];
> >>>> +     __u64   fcc;
> >>>> +     __u32   fcsr;
> >>>> +     __u32   vcsr;
> >>>> +};
> >>> Do we want to freeze the LSX/LASX layout this early, before any detail
> >>> of said extension are published? We'll need to update kernel later
> >>> anyway, so I'd recommend leaving them out for the initial bring-up.
> >> Yes, they are freezed.
> > Okay too, I remember these are the same values as in the old world, so it should
> > be easy to support both worlds at least in this regard.
>
> You know.  I really don't like this including code for hardware that may
> be frozen but is not publicly documented yet.  Especially when the plan
> is to publicly document the hardware.  It has the real problem that no
> one else can review the code.
>
> In ever design I have worked with there have been places where the
> people putting it together have had blind spots.  The only way I know to
> get past blind spots is to get as many people as possible looking,
> and to listen to the feedback.
>
> Given that neither lsx_context nor lasx_context are used in the kernel
> code yet I would very much prefer that their inclusion wait until there
> is actual code that needs them.
>
> If nothing else that will put the definitions in context so people can
> more easily see the big picture and understand how the pieces fit.
OK, I will remove lsx_context/lasx_context in the next version.

Huacai
>
> Eric
