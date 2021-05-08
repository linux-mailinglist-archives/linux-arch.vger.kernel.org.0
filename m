Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEC03770E5
	for <lists+linux-arch@lfdr.de>; Sat,  8 May 2021 11:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhEHJaS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 May 2021 05:30:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhEHJaQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 8 May 2021 05:30:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B101461430;
        Sat,  8 May 2021 09:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620466155;
        bh=R6RMIUYi3bq0SpvGcfXGDP9cDJfCB+cyfouoJdnFiRI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sHJQs0+GeEQ9GsxbId71DGEqb8J/IkMWOCo5LDI4s1VlhJJRyHRVPvLaRSiqzF+zs
         uevx6s4CiFMC7l3+NIsJA0p2L46mjHZNqfmMmpQI4XiFuIkRpXumoH4sX7YrNixoRe
         54el9y7wUj/q9N+vWhdgmCRpOUKiG+qwdmipfSTpAFxxK1qY+zgBi6STJ4VUKTfPr2
         VodIeRiiVRg2FsI3I9sX3elIkIbsaTVonmschSZhrWg72a/+3g1SV/ijXgXhW8iire
         Hs2JVNwnBT7BYkk9vvXYWenCaFuvP32WhORaro73FcuFVo6Jg/cwdBUkYhf09vRCFs
         5+Y95P0irCz4g==
Received: by mail-ot1-f48.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso10102599ote.1;
        Sat, 08 May 2021 02:29:15 -0700 (PDT)
X-Gm-Message-State: AOAM533yMIwIEUQldB/Bk2Eo0sLH/6uK1DA3F3dxpXsmpHgL2WeWqHQ0
        Hv3ZitNlK07i4m4NZvs6us1D+l+DXGy/ro1IFo8=
X-Google-Smtp-Source: ABdhPJzzxX8ZeyeaB2I42nvNj8llnJjhTpj8VT5r7VdzqSAU7R4/NDjXSro8yRZtlbdoR2DGmjy2Rh3zyAWVFMJx7lo=
X-Received: by 2002:a9d:30b:: with SMTP id 11mr11493944otv.298.1620466155082;
 Sat, 08 May 2021 02:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210507220813.365382-1-arnd@kernel.org> <20210507220813.365382-13-arnd@kernel.org>
 <CAHk-=wiqLPZbiWFZ3rDNCY0fm=dFR3SSDONvrVNVbkOQmQS1vw@mail.gmail.com>
In-Reply-To: <CAHk-=wiqLPZbiWFZ3rDNCY0fm=dFR3SSDONvrVNVbkOQmQS1vw@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 8 May 2021 11:28:26 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3sxfYG4WReXPe6fg33K7tQaP4K-F53yBcTfyEXv0W22A@mail.gmail.com>
Message-ID: <CAK8P3a3sxfYG4WReXPe6fg33K7tQaP4K-F53yBcTfyEXv0W22A@mail.gmail.com>
Subject: Re: [RFC 12/12] asm-generic: simplify asm/unaligned.h
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 8, 2021 at 1:54 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, May 7, 2021 at 3:12 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The get_unaligned()/put_unaligned() implementations are much more complex
> > than necessary, now that all architectures use the same code.
>
> Thanks for doing this, it looks good to me.
>
> I suspect it's still slightly unnecessarily complicated - why is that
> get_unaligned() not just
>
>   #define get_unaligned(ptr) \
>         __get_unaligned_t(typeof(*__ptr), __ptr)
>
> Because I'm not seeing the reason for doing that "__auto_type __ptr"
> thing - the argument to a "typeof()" isn't actually evaluated.

Both versions are equally correct, I picked the __auto_type version
because this tends to produce smaller preprocessor output when you have
multiple layers of nested macros with 'ptr' expanding to something
complicated, and the get_unaligned() itself being expanded multiple
times again.

When I recently experimented with possible changes to cmpxchg() and
get_user(), it had a measurable impact on compile time with clang on
those macros.

get_unaligned() doesn't appear to be used much in nested macros
at all, so it probably won't actually help here, and I can just do the
simpler version instead.

I forgot to mention in the changelog that this version does not actually
require the argument to be a scalar, not sure if this is something
we want or not. It does allow developers to write something like

__be32 get_ip_saddr(struct sk_buff *skb)
{
      struct iphdr *iph = ip_hdr(skb);
      return get_unaligned(iph).saddr;
}

and get the expected result. While this seems handy, it also makes it
harder to change the macro back to one that only works on scalars
after such usage becomes widespread.

        Arnd
