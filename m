Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9591EFB414
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2019 16:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfKMPtK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Nov 2019 10:49:10 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:63799 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfKMPtJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Nov 2019 10:49:09 -0500
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id xADFmwnb002467;
        Thu, 14 Nov 2019 00:48:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com xADFmwnb002467
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1573660139;
        bh=CcAfDSAaYzEWcA0ZdifDtl9WFUZGV+BlO+HnJ4m+CTo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KdarmmaqVcPRiM4rzpyYW/UCbDKEK1xV/Fu7S5zIq2tzQi5JFrINNOn05UNI9AHVk
         nCbw7JfAmIA+v38rMrAZVAvnHv7+cotGk9/JQhGKQmc5bC+FJ81/r7yziL1twfoFKt
         WPdfFxK8fKhqA6A4qGNPmBpSBRF1IPQqImSnlJU71grmsdhm6bDX1t12tTKTaKzXAY
         llm245s+35gxNMPEkLQosF4KpHe6TW+2YAzlMvg8zAu5Oveullu89Sjf1wM8tuFDdE
         1KIGp/1aysHIz4/Gqs21s9XqdQ5dtWnNvaB4aVgjq3UkBzs5BkBqUxo5FCJ9l7Nxj+
         6mta704fnRE8w==
X-Nifty-SrcIP: [209.85.221.173]
Received: by mail-vk1-f173.google.com with SMTP id k19so665184vke.10;
        Wed, 13 Nov 2019 07:48:59 -0800 (PST)
X-Gm-Message-State: APjAAAU+l1ivZ9LvLPeCyT+L0Bi986ElqHTQCsK2xU5x+N4zoRFzU2xi
        7iWGQCcN5PV1c39U27SWWY5ocdWmjm26OQA1Bew=
X-Google-Smtp-Source: APXvYqwYYDKd9djzyye5Jm5AqqD9t+0TNx8j9BxmVW1XcUt8qojsZGzIv9lhdsYGW3wi/7kP8ffMJLcX+hp9rK2M4CI=
X-Received: by 2002:a1f:4192:: with SMTP id o140mr1994739vka.26.1573660137863;
 Wed, 13 Nov 2019 07:48:57 -0800 (PST)
MIME-Version: 1.0
References: <1da2db04-da6a-cedb-e85a-6ded68dada82@163.com> <20191112123125.GD17835@willie-the-truck>
 <CAK7LNARA99UUTY2v6rS=Nb4Cg5pB4RsR0PogLqdT9uNLcH20ew@mail.gmail.com>
 <32a3b660-f4d2-268e-2206-d50073298c0c@iogearbox.net> <CAK7LNASR=R=gyuaMO=VzdXrY3gaQ_FVE4es60bzXf=9ASR2qUw@mail.gmail.com>
 <021e7b46-047e-d381-9dca-bd61db08e4f8@163.com> <CAK7LNARKh3-cAqsYgcxFwq9CGk-CgBfkiQgfNSULkxwO0xa2vw@mail.gmail.com>
 <ac4577d4-c0f2-9596-df6f-3fcc563bde3e@163.com> <CAK7LNATfK2pFnO2YV5zMLMxJGYyaj+f8w-k4K8xaoGbJ2Bd5eQ@mail.gmail.com>
 <50602386-68b1-be38-a022-0bcf9df6a54e@163.com> <CAK7LNAQ8h7zxhfndBqYRWXkaWVynH7GpBvDPLcVMZ1VEyUUX7A@mail.gmail.com>
 <bdbe9e04-4da0-64b2-ab0c-ae739d8fd7ac@163.com>
In-Reply-To: <bdbe9e04-4da0-64b2-ab0c-ae739d8fd7ac@163.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 14 Nov 2019 00:48:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNATpJDVG+mF9J7n9_WQ2rT0U1fh7pFeAJLkQjF=J8jCSrg@mail.gmail.com>
Message-ID: <CAK7LNATpJDVG+mF9J7n9_WQ2rT0U1fh7pFeAJLkQjF=J8jCSrg@mail.gmail.com>
Subject: Re: Question about "asm/rwonce.h: No such file or directory"
To:     Xiao Yang <ice_yangxiao@163.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Will Deacon <will@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 13, 2019 at 11:57 PM Xiao Yang <ice_yangxiao@163.com> wrote:
>
> On 11/13/19 4:54 PM, Masahiro Yamada wrote:
> > On Wed, Nov 13, 2019 at 5:36 PM Xiao Yang <ice_yangxiao@163.com> wrote:
> >> On 11/13/19 3:53 PM, Masahiro Yamada wrote:
> >>> On Wed, Nov 13, 2019 at 4:17 PM Xiao Yang <ice_yangxiao@163.com> wrote:
> >>>> On 11/13/19 2:57 PM, Masahiro Yamada wrote:
> >>>>> Sorry, I really do not understand what you are doing.
> >>>>>
> >>>>> include/linux/compiler.h is only for kernel-space.
> >>>>> Shrug if a user-land program includes it.
> >>>> Hi Masahiro,
> >>>>
> >>>> For building tools/bpf, it is good to fix the compiler error by Daniel's
> >>>> patch(i.e. use linux/filter from linux header).
> >>>>
> >>>> linux/compiler.h may be used by other code in kernel.  Is it possible to
> >>>> trigger the same error when the other code
> >>>>
> >>>> including linux/compiler.h is built? Is this kind of code able to find
> >>>> the location of <asm/rwonce.h>?
> >>> <asm/rwonce.h> is also kernel-only header.
> >>>
> >>> The kernel code can find <asm/rwonce.h>, but user-land code cannot.
> >> Hi Masahiro,
> >>
> >> Sorry, I am not familar with it.
> >>
> >> Thanks a lot for your explanation and I have seen the LINUXINCLUDE
> >> variable in Makefile.
> >>
> >> I will try to send a patch as Daniel suggested.
> >>
> >> Best Regards,
> >>
> >> Xiao Yang
> >>
> > Hmm, digging into the git history,
> > this include path was added by the following commit:
> >
> >
> > commit d7475de58575c904818efa369c82e88c6648ce2e
> > Author: Kamal Mostafa <kamal@canonical.com>
> > Date:   Wed Nov 11 14:24:27 2015 -0800
> >
> >      tools/net: Use include/uapi with __EXPORTED_HEADERS__
> >
> >      Use the local uapi headers to keep in sync with "recently" added #define's
> >      (e.g. SKF_AD_VLAN_TPID).  Refactored CFLAGS, and bpf_asm doesn't need -I.
> >
> >      Fixes: 3f356385e8a4 ("filter: bpf_asm: add minimal bpf asm tool")
> >      Signed-off-by: Kamal Mostafa <kamal@canonical.com>
> >      Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> >      Signed-off-by: David S. Miller <davem@davemloft.net>
> >
> >
> >
> > I am not sure how big a deal it is,
> > but it could be a problem on old distros??
> >
> Hi Daniel, Masahiro
>
>
> Could we include the linux/filter.h generated by "make headers_install"
> as a higher priority?
>
> (PS: According to above commit, just ensure that tools/bpf keeps in sync
> with new linux header as far as possible).
>
> and then use the linux/filter.h in system if kernel doesn't provide
> linux/filter.h by "make headers_install".
>
> --------------------------------------------------------------------------------------------------------------------
>
> diff --git a/tools/bpf/Makefile b/tools/bpf/Makefile
> index 5d1995fd369c..1e0c768132af 100644
> --- a/tools/bpf/Makefile
> +++ b/tools/bpf/Makefile
> @@ -10,7 +10,7 @@ MAKE = make
>   INSTALL ?= install
>
>   CFLAGS += -Wall -O2
> -CFLAGS += -D__EXPORTED_HEADERS__ -I$(srctree)/include/uapi
> -I$(srctree)/include
> +CFLAGS += -I$(srctree)/usr/include


Probably, this does not work for O= build.

And, you also need to run 'make headers' somewhere
because usr/include does not contain any header in a clean state.

Be careful, people always tend to break out-of-tree build.
I recommend to double, triple check it.

(I believe this is a horrible design mistake
of the tools build system.)




>   # This will work when bpf is built in tools env. where srctree
>   # isn't set and when invoked from selftests build, where srctree
>
> ---------------------------------------------------------------------------------------------------------------------
>
>
> Best Regards,
>
> Xiao Yang
>
> >
>


-- 
Best Regards
Masahiro Yamada
