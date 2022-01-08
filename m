Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FB248838F
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 13:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiAHMRg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 07:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiAHMRg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 07:17:36 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A164C061574;
        Sat,  8 Jan 2022 04:17:35 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id o3so16407671wrh.10;
        Sat, 08 Jan 2022 04:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ohcfovccatjc30lDRcB2IuIrGBvRWfvjPU9QBrd0eXE=;
        b=V9c8dDmXSfsabiD2MId/xdQkhc1ypm2tNSgpNroSiTuvYZW7U0dsWTyMIa6VL4QJ1F
         O6GRDav6qCi+i8OSKsQ0jmxN5EbpY9uNnqR8f0IKwpU9uaLbxCYm4AJWVoT3hHa05fKk
         4nPOtZqigrHY1mYoB7dt143fFsnf86znEcxoDlmFc5UNocVCF+zAzp501U1sPVA5mmww
         Be6jNLeRq2aOjZ9zLEVtqLUN4Zc0jQlww+aFa/9Ds+HSwWp6mC5Dz1SwgqoIcVTjfYnK
         2ciGkMqXxnI4C/WJLSQs+zfnlRSP1N5gL9zzYbroiQqAOSIylcboQPyJ1rw16hQAYfHx
         7MPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Ohcfovccatjc30lDRcB2IuIrGBvRWfvjPU9QBrd0eXE=;
        b=T2Ikbhay9o8iFoSLg5HSg8c33C0s4Gg4IRw7EZ0ZNeQjppFgB5IWw8Y+3RqwCndM59
         LSF35/EUI23en8lvcccKEEFxVWgML529GjFRZt0bfdmPesvJedyFodCUMC7tEtjCMhoN
         sEMoj6I7nQ0EoTWuFhosml0WsY0XzjaPwQS+XtDFD92tYKHfAeeO2WAh0yu5/uhwDpuF
         J2/oyKynPw8t7nuZ8SHAPVyk7w46KInf6NanKI8cg7Qdo2EHfr5UQ6rbbynczloFjwHh
         fNQWeXZXiOzQHwAPPKD9gFGjUAZJqPdg4Ooe/RJoPI0gnQM6Vu4clZ4JA1ClW4uETzJo
         4Mqw==
X-Gm-Message-State: AOAM5324dhRGbeyE5mChDrNIZNdqSmyC4V/nU+Ejg6mCryYQbcgT1GGB
        g+JP7gCEPCKZwp7VhXaBqUuWLWNlcEU=
X-Google-Smtp-Source: ABdhPJwFDk2SLOyQmmgllC7CCS/eqLk9g3liE0EfOLpUi0/bBgkUryOYqauZ+Sh2FV7K6fL/YJREkQ==
X-Received: by 2002:a5d:424c:: with SMTP id s12mr56773031wrr.465.1641644254049;
        Sat, 08 Jan 2022 04:17:34 -0800 (PST)
Received: from gmail.com (84-236-113-171.pool.digikabel.hu. [84.236.113.171])
        by smtp.gmail.com with ESMTPSA id o8sm1637297wry.20.2022.01.08.04.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 04:17:33 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 8 Jan 2022 13:17:31 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>, llvm@lists.linux.dev
Subject: Re: [PATCH 0000/2297] [ANNOUNCE, RFC] "Fast Kernel Headers" Tree
 -v1: Eliminate the Linux kernel's "Dependency Hell"
Message-ID: <YdmA2/BJPK7m3d7d@gmail.com>
References: <YdIfz+LMewetSaEB@gmail.com>
 <YdM4Z5a+SWV53yol@archlinux-ax161>
 <YdQlwnDs2N9a5Reh@gmail.com>
 <YdSI9LmZE+FZAi1K@archlinux-ax161>
 <YdTpAJxgI+s9Wwgi@gmail.com>
 <YdTvXkKFzA0pOjFf@gmail.com>
 <YdYQu9YxNw0CxJRn@archlinux-ax161>
 <Ydl6MATrfA1GA0G+@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ydl6MATrfA1GA0G+@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> * Nathan Chancellor <nathan@kernel.org> wrote:
> 
> > 5. Build error in arch/arm64/kvm/hyp/nvhe with LTO
> > 
> > With arm64 + CONFIG_LTO_CLANG_THIN=y, I see:
> > 
> > $ make -skj"$(nproc)" ARCH=arm64 LLVM=1 defconfig
> > 
> > $ scripts/config -e LTO_CLANG_THIN
> > 
> > $ make -skj"$(nproc)" ARCH=arm64 LLVM=1 olddefconfig arch/arm64/kvm/hyp/nvhe/
> > ld.lld: error: arch/arm64/kvm/hyp/nvhe/hyp.lds:2: unknown directive: .macro
> > >>> .macro __put, val, name
> > >>> ^
> > make[5]: *** [arch/arm64/kvm/hyp/nvhe/Makefile:51: arch/arm64/kvm/hyp/nvhe/kvm_nvhe.tmp.o] Error 1
> > 
> > I was not able to figure out the exact include chain but CONFIG_LTO
> > causes asm/alternative-macros.h to be included in asm/rwonce.h, which
> > eventually gets included in either asm/cache.h or asm/memory.h.
> > 
> > I managed to solve this with the following diff but I am not sure if
> > there is a better or cleaner way to do that.
> > 
> > diff --git a/arch/arm64/include/asm/rwonce.h b/arch/arm64/include/asm/rwonce.h
> > index 1bce62fa908a..e19572a205d0 100644
> > --- a/arch/arm64/include/asm/rwonce.h
> > +++ b/arch/arm64/include/asm/rwonce.h
> > @@ -5,7 +5,7 @@
> >  #ifndef __ASM_RWONCE_H
> >  #define __ASM_RWONCE_H
> >  
> > -#ifdef CONFIG_LTO
> > +#if defined(CONFIG_LTO) && !defined(LINKER_SCRIPT)
> >  
> >  #include <linux/compiler_types.h>
> >  #include <asm/alternative-macros.h>
> > @@ -66,7 +66,7 @@
> >  })
> >  
> >  #endif	/* !BUILD_VDSO */
> > -#endif	/* CONFIG_LTO */
> > +#endif	/* CONFIG_LTO && !LINKER_SCRIPT */

In any case I've added your fix to the fast-headers tree, with a comment 
that this might just be a workaround.

Thanks,

	Ingo
