Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7693E310126
	for <lists+linux-arch@lfdr.de>; Fri,  5 Feb 2021 00:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhBDXzj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 18:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhBDXzg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 18:55:36 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BC5C0613D6;
        Thu,  4 Feb 2021 15:54:56 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id i71so4995937ybg.7;
        Thu, 04 Feb 2021 15:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0xnEJ/+ZJd9DS4gn/VKHMcY13sD+e64WV8SaUBqyM+Q=;
        b=NR+kNaW75Gc9+EK1uh9dftkfLDfV+YvqXgIvhoHZmGicuA9LK699TeDhfyes4kQ1Qr
         OCL9yl/snMTRVLLCWAS6IZ8cWecATlOW2cUPpQdFCZiULn1PtV9JNPp3syg1K1acyboi
         E2edy9MOO7y7dabVtyyO0VhlpSY6JdCXvTz+BwiaugDZPhcPoJgSv/PeOsGYF1Wi6y4l
         7u/ku0ucOaXLWlc6U6sxaoea5Nhk5LiAIGxL3RLzFyubUYBetwfAz34rPOvdGXP16Wso
         u27a8eZ1EGTXpoHeLpEikKGUO5ZON34tMQQqqbm4H1bFerJdgxgttOrZowO9y5L33oa5
         /8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0xnEJ/+ZJd9DS4gn/VKHMcY13sD+e64WV8SaUBqyM+Q=;
        b=HwzLFjH3ifhrAHNBU9Wyu8kltUirWeu03RLK5EBjjKsBOn/uy0rOdTD1JmTkEewv3J
         0XHKJpwnHZWhbIjV0/+dJaup+MRYWXLvn7ZkL3EtwhFt3SWqapPcfMSDEXrkmE98UaxD
         wv33YZ3M6XvgHBkJXNbxoWqoXzh7ftmIQlC2VM4HbbEt4GQ1D7D9hxLU3sbIrKU9eOCm
         V/VXgEZps7I0lhIalAZLZvgyU06OaE0IyDKEaj+wSnUH/Gcw1ce64giNqDyw0ovFAeB+
         lMHz1q3R8gB5xxoHx1W0RHdhIu6dGmGRt/5Qjp06Z8Jl1HWpQeue7t1YNohJCU62NIaL
         ebRw==
X-Gm-Message-State: AOAM531kBI5QfrR92mS0XA6kQ8RPC4J3rpttraaYS8B4Mz7w7t0cxUXD
        +sOu2dQzNPMla4P8kDMaeZfOzJmlXIey2CKx24c=
X-Google-Smtp-Source: ABdhPJwZkorXQciQmxG8kAGRnxd+dJyiZqSxfwFGy3+jHMtVM6kpqVVxCaP6GwQlyk9Fbn/dRLJkHEAzs/p0weyG4vg=
X-Received: by 2002:a25:9882:: with SMTP id l2mr2328044ybo.425.1612482895541;
 Thu, 04 Feb 2021 15:54:55 -0800 (PST)
MIME-Version: 1.0
References: <20210115210616.404156-1-ndesaulniers@google.com>
 <CA+icZUVp+JNq89uc_DyWC6zh5=kLtUr7eOxHizfFggnEVGJpqw@mail.gmail.com>
 <7354583d-de40-b6b9-6534-a4f4c038230f@fb.com> <CAKwvOd=5iR0JONwDb6ypD7dzzjOS3Uj0CjcyYqPF48eK4Pi90Q@mail.gmail.com>
 <12b6c2ca-4cf7-4edd-faf2-72e3cb59c00e@fb.com> <20210117201500.GO457607@kernel.org>
 <CAKwvOdmniAMZD0LiFdr5N8eOwHqNFED2Pd=pwOFF2Y8eSRXUHA@mail.gmail.com>
 <CAEf4Bzbn1app3LZ1oah5ARn81j5RMNxRRHPVAkeY3h_0q7+7fg@mail.gmail.com> <CAKwvOdmrVdxbEHdOFA8x+Q2yDWOfChZzBc6nR3rdaM8R3LsxfQ@mail.gmail.com>
In-Reply-To: <CAKwvOdmrVdxbEHdOFA8x+Q2yDWOfChZzBc6nR3rdaM8R3LsxfQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 4 Feb 2021 15:54:44 -0800
Message-ID: <CAEf4Bzbs5sDTB6w1D4LpKLGjY5sCCUnRUsU84Ccn8DoL352j1g@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Kbuild: DWARF v5 support
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 3, 2021 at 7:13 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Wed, Feb 3, 2021 at 6:58 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Feb 3, 2021 at 5:31 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> > >
> > > On Sun, Jan 17, 2021 at 12:14 PM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > Em Fri, Jan 15, 2021 at 03:43:06PM -0800, Yonghong Song escreveu:
> > > > >
> > > > >
> > > > > On 1/15/21 3:34 PM, Nick Desaulniers wrote:
> > > > > > On Fri, Jan 15, 2021 at 3:24 PM Yonghong Song <yhs@fb.com> wrote:
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > On 1/15/21 1:53 PM, Sedat Dilek wrote:
> > > > > > > > En plus, I encountered breakage with GCC v10.2.1 and LLVM=1 and
> > > > > > > > CONFIG_DEBUG_INFO_DWARF4.
> > > > > > > > So might be good to add a "depends on !DEBUG_INFO_BTF" in this combination.
> > > > > >
> > > > > > Can you privately send me your configs that repro? Maybe I can isolate
> > > > > > it to a set of configs?
> > > > > >
> > > > > > >
> > > > > > > I suggested not to add !DEBUG_INFO_BTF to CONFIG_DEBUG_INFO_DWARF4.
> > > > > > > It is not there before and adding this may suddenly break some users.
> > > > > > >
> > > > > > > If certain combination of gcc/llvm does not work for
> > > > > > > CONFIG_DEBUG_INFO_DWARF4 with pahole, this is a bug bpf community
> > > > > > > should fix.
> > > > > >
> > > > > > Is there a place I should report bugs?
> > > > >
> > > > > You can send bug report to Arnaldo Carvalho de Melo <acme@kernel.org>,
> > > > > dwarves@vger.kernel.org and bpf@vger.kernel.org.
> > > >
> > > > I'm coming back from vacation, will try to read the messages and see if
> > > > I can fix this.
> > >
> > > IDK about DWARF v4; that seems to work for me.  I was previously observing
> > > https://bugzilla.redhat.com/show_bug.cgi?id=1922698
> > > with DWARF v5.  I just re-pulled the latest pahole, rebuilt, and no
> > > longer see that warning.
> > >
> > > I now observe a different set.  I plan on attending "BPF office hours
> > > tomorrow morning," but if anyone wants a sneak peak of the errors and
> > > how to reproduce:
> > > https://gist.github.com/nickdesaulniers/ae8c9efbe4da69b1cf0dce138c1d2781
> > >
> >
> > Is there another (easy) way to get your patch set without the b4 tool?
> > Is your patch set present in some patchworks instance, so that I can
> > download it in mbox format, for example?
>
> $ wget https://lore.kernel.org/lkml/20210130004401.2528717-2-ndesaulniers@google.com/raw
> -O - | git am
> $ wget https://lore.kernel.org/lkml/20210130004401.2528717-3-ndesaulniers@google.com/raw
> -O - | git am
>
> If you haven't tried b4 yet, it's quite nice.  Hard to go back.  Lore
> also has mbox.gz links.  Not sure about patchwork.
>

Ok, I managed to apply that on linux-next, but I can't get past this:

ld.lld: error: undefined symbol: pa_trampoline_start
>>> referenced by arch/x86/realmode/rm/header.o:(real_mode_header)

ld.lld: error: undefined symbol: pa_trampoline_header
>>> referenced by arch/x86/realmode/rm/header.o:(real_mode_header)

ld.lld: error: undefined symbol: pa_trampoline_pgd
>>> referenced by arch/x86/realmode/rm/header.o:(real_mode_header)
>>> referenced by trampoline_64.S:142 (/data/users/andriin/linux/arch/x86/realmode/rm/trampoline_64.S:142)
>>>               arch/x86/realmode/rm/trampoline_64.o:(startup_32)

ld.lld: error: undefined symbol: pa_wakeup_start
>>> referenced by arch/x86/realmode/rm/header.o:(real_mode_header)

ld.lld: error: undefined symbol: pa_wakeup_header
>>> referenced by arch/x86/realmode/rm/header.o:(real_mode_header)

ld.lld: error: undefined symbol: pa_machine_real_restart_asm
>>> referenced by arch/x86/realmode/rm/header.o:(real_mode_header)

ld.lld: error: undefined symbol: pa_startup_32
>>> referenced by trampoline_64.S:77 (/data/users/andriin/linux/arch/x86/realmode/rm/trampoline_64.S:77)
>>>               arch/x86/realmode/rm/trampoline_64.o:(trampoline_start)

ld.lld: error: undefined symbol: pa_tr_flags
>>> referenced by trampoline_64.S:124 (/data/users/andriin/linux/arch/x86/realmode/rm/trampoline_64.S:124)
>>>               arch/x86/realmode/rm/trampoline_64.o:(startup_32)

ld.lld: error: undefined symbol: pa_tr_cr4
>>> referenced by trampoline_64.S:138 (/data/users/andriin/linux/arch/x86/realmode/rm/trampoline_64.S:138)
>>>               arch/x86/realmode/rm/trampoline_64.o:(startup_32)

ld.lld: error: undefined symbol: pa_tr_efer
>>> referenced by trampoline_64.S:146 (/data/users/andriin/linux/arch/x86/realmode/rm/trampoline_64.S:146)
>>>               arch/x86/realmode/rm/trampoline_64.o:(startup_32)
>>> referenced by trampoline_64.S:147 (/data/users/andriin/linux/arch/x86/realmode/rm/trampoline_64.S:147)
>>>               arch/x86/realmode/rm/trampoline_64.o:(startup_32)

ld.lld: error: undefined symbol: pa_startup_64
>>> referenced by trampoline_64.S:161 (/data/users/andriin/linux/arch/x86/realmode/rm/trampoline_64.S:161)
>>>               arch/x86/realmode/rm/trampoline_64.o:(startup_32)

ld.lld: error: undefined symbol: pa_tr_gdt
>>> referenced by arch/x86/realmode/rm/trampoline_64.o:(tr_gdt)
>>> referenced by reboot.S:28 (/data/users/andriin/linux/arch/x86/realmode/rm/reboot.S:28)
>>>               arch/x86/realmode/rm/reboot.o:(machine_real_restart_asm)

ld.lld: error: undefined symbol: pa_machine_real_restart_paging_off
>>> referenced by reboot.S:34 (/data/users/andriin/linux/arch/x86/realmode/rm/reboot.S:34)
>>>               arch/x86/realmode/rm/reboot.o:(machine_real_restart_asm)

ld.lld: error: undefined symbol: pa_machine_real_restart_idt
>>> referenced by reboot.S:47 (/data/users/andriin/linux/arch/x86/realmode/rm/reboot.S:47)
>>>               arch/x86/realmode/rm/reboot.o:(machine_real_restart_asm)

ld.lld: error: undefined symbol: pa_machine_real_restart_gdt
>>> referenced by reboot.S:54 (/data/users/andriin/linux/arch/x86/realmode/rm/reboot.S:54)
>>>               arch/x86/realmode/rm/reboot.o:(machine_real_restart_asm)
>>> referenced by arch/x86/realmode/rm/reboot.o:(machine_real_restart_gdt)

ld.lld: error: undefined symbol: pa_wakeup_gdt
>>> referenced by arch/x86/realmode/rm/wakeup_asm.o:(wakeup_gdt)
  CC      arch/x86/mm/numa_64.o
  CC      arch/x86/mm/amdtopology.o
  HOSTCC  arch/x86/entry/vdso/vdso2c
make[4]: *** [arch/x86/realmode/rm/realmode.elf] Error 1
make[3]: *** [arch/x86/realmode/rm/realmode.bin] Error 2
make[2]: *** [arch/x86/realmode] Error 2
make[2]: *** Waiting for unfinished jobs....


Hopefully Arnaldo will have better luck.



> >
> > >
> > > (FWIW: some other folks are hitting issues now with kernel's lack of
> > > DWARF v5 support: https://bugzilla.redhat.com/show_bug.cgi?id=1922707)
>
>
> --
> Thanks,
> ~Nick Desaulniers
