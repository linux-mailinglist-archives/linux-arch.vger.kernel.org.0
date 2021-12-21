Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C9047BB53
	for <lists+linux-arch@lfdr.de>; Tue, 21 Dec 2021 08:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbhLUHxV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Dec 2021 02:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhLUHxV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Dec 2021 02:53:21 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40055C061574;
        Mon, 20 Dec 2021 23:53:21 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id u198so7663150vkb.13;
        Mon, 20 Dec 2021 23:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iD0P1FUK51gjfgE/PRbkmHx+9oD4XWvp5sVvgwjH7RA=;
        b=Tu6rxA1MT8f6/XGwU0+nrY1YA7h+fymGJGq68V9HY1U+p3qzfdNS3EudWhEpzLfsd3
         zeyWIhuKTpg8Ppz798QLwbbOE10bTRw2hFMigDIPdg3s7XU9Ahhl7/DacDnoEUHua7qo
         CWoJtkOqRyJ/uOvSUpEsSEfNFFgyRXN5zrK7B+gKp2PPFqDyCLAWJ6ivj5p/LumbT1qT
         0CzRfKVzHQVJI2ZTGOQp7zCXVLJqOeeRLDPkbpz+0gHzJz9x9VUZRKaBVU8zESfI5DZa
         LPZRYHSs+0xIet2SkvkAMtgYegtLOtrraN6QUm5qYOSme6i5aIZwhRKE4vajVRu2aBfC
         efEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iD0P1FUK51gjfgE/PRbkmHx+9oD4XWvp5sVvgwjH7RA=;
        b=RWH03rA4KTBn933Oe/Pa92Rw18MAPl1kM2LicSb4Rx0FngVJUeEUB/aTDc72b9q7+u
         I0UtaD+X/rFYZmHPmbD+h1e/MsBtSxvBpXCEu7m479TdWY91MJLGzLtLG96IeDrsIdvL
         sTJxBGdajLpJ7qAfzWgiffXJY5oZpIcucOAls/NIzKcwQnKJ2rtXBml2Qd2fJePsr60s
         3+dTaisEmvSWRElG4IKW7SLagFCvcSIAI7lNaHptG0RHTqeoO02SoK/a0a8kaBaiFGs0
         TVS0/qPw0FM6oaeiYUreIITGfVOscxJ5tJeLfgcCF7RxWTQZTGeU2RdKqWvzNLDp0CVE
         WtFg==
X-Gm-Message-State: AOAM532V7leHHHqjBHE+5t9slgi1rK6onrb0UI+oxdCpqojRjgITEkcA
        rqE4Tztn7JVT1lS5BPL/HyYSoPUZy2LD04u4qx8=
X-Google-Smtp-Source: ABdhPJxBojh90SsnXVP+t0GF+WpJ9K8jLYKP7fj1BrsHSqBbede9YL2AxBgydqI053eYJbgWKWpgBJfYD6xLLbZZYX0=
X-Received: by 2002:a05:6122:1684:: with SMTP id 4mr694042vkl.17.1640073200315;
 Mon, 20 Dec 2021 23:53:20 -0800 (PST)
MIME-Version: 1.0
References: <20211013063656.3084555-1-chenhuacai@loongson.cn> <722477bcc461238f96c3b038b2e3379ee49efdac.camel@mengyan1223.wang>
In-Reply-To: <722477bcc461238f96c3b038b2e3379ee49efdac.camel@mengyan1223.wang>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Tue, 21 Dec 2021 15:53:08 +0800
Message-ID: <CAAhV-H40oWqkD+tQ3=XA8ijQGukkeG5O1M1JL3v5i402dFLK+Q@mail.gmail.com>
Subject: Re: [PATCH V5 00/22] arch: Add basic LoongArch support
To:     Xi Ruoyao <xry111@mengyan1223.wang>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Ruoyao,

On Mon, Dec 20, 2021 at 5:04 PM Xi Ruoyao <xry111@mengyan1223.wang> wrote:
>
> On Wed, 2021-10-13 at 14:36 +0800, Huacai Chen wrote:
> > LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
> > LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
> > version (LA32S) and a 64-bit version (LA64). LoongArch use ACPI as its
> > boot protocol LoongArch-specific interrupt controllers (similar to
> > APIC)
> > are already added in the next revision of ACPI Specification (current
> > revision is 6.4).
> >
> > This patchset is adding basic LoongArch support in mainline kernel, we
> > can see a complete snapshot here:
> > https://github.com/loongson/linux/tree/loongarch-next
>
> Hi Huacai,
>
> The snapshot panics on my system under high pressure (building and
> testing GCC).  The panic message is pasted, but it's kind of broken up
> likely because multiple CPU cores were outputing to the serial console
> simutaniously.
>
> The config is attached.  I'm not sure the reason of the panic (bug in
> the patches or bug in mainline kernel?) Do you have some pointers to
> diagnostic and fix the issue?
>
> [ 5391.004745] CPU 1 Unable to handle kernel paging request at virtual ad=
dress 000000000040007e, era =3D=3D 90000000003aa07c, ra =3D=3D 90000000003a=
a84c
> [ 5391.017392] Oops[#1]:
> [ 5391.019657] CPU: 1 PID: 629589 Comm: as Not tainted 5.16.0-rc5 #1
> [ 5391.025712] Hardware name: Loongson LM-LS3A5000-7A1000-1w-V01-pc_A2101=
/LM-LS3A5000-7A1000-1w-V01-pc_A2101, BIOS KL.4.1H.LM.D.017.210611.R 06/11/2=
021
> [ 5391.032696] ------------[ cut here ]------------
> [ 5391.038939] $ 0   : 0000000000000000 90000000003aa84c 900000011c62c000=
 900000011c62fa90
> [ 5391.043524] WARNING: CPU: 2 PID: 629596 at mm/slub.c:2111 get_partial_=
node.part.0+0x2cc/0x328
> [ 5391.051483] $ 4   :
> [ 5391.059953] Modules linked in:
> [ 5391.059953]  9000000100070700 0000000000000dc0
> [ 5391.062031]  nls_cp936
> [ 5391.065056]  ffffffffffffffff
> [ 5391.069465]  vfat
> [ 5391.071799]  90000000003d24cc
> [ 5391.074738]  fat
> [ 5391.076641]
> [ 5391.079580]  amdgpu
> [ 5391.081396] $ 8   :
> [ 5391.082867]  snd_hda_codec_generic
> [ 5391.084942]  900000000680a6b0
> [ 5391.087018]  ledtrig_audio
> [ 5391.090390]  0000000000000000
> [ 5391.093329]  led_class
> [ 5391.096010]  0000000000000001
> [ 5391.098949]  snd_hda_intel
> [ 5391.101283]  0000000000000038
> [ 5391.104222]  snd_intel_dspcfg
> [ 5391.106902]
> [ 5391.109841]  snd_hda_codec
> [ 5391.112781] $12   :
> [ 5391.114252]  uas
> [ 5391.116931]  0000000000000070
> [ 5391.119006]  snd_hda_core
> [ 5391.120822]  000000003b724c81
> [ 5391.123763]  drm_ttm_helper
> [ 5391.126355]  0000000000000000
> [ 5391.129295]  ttm
> [ 5391.132061]  000000000040000e
> [ 5391.135001]  snd_pcm
> [ 5391.136817]
> [ 5391.139756]  r8169
> [ 5391.141918] $16   :
> [ 5391.143388]  gpu_sched
> [ 5391.145378]  90000001000051d1
> [ 5391.147453]  snd_timer
> [ 5391.149788]  0000000000000001
> [ 5391.152727]  usb_storage
> [ 5391.155062]  00000001ffff7fff
> [ 5391.158002]  drm_kms_helper
> [ 5391.160509]  ffffffff80808000
> [ 5391.163448]  snd
> [ 5391.166215]
> [ 5391.169155]  realtek
> [ 5391.170971] $20   :
> [ 5391.172442]  syscopyarea
> [ 5391.174603]  fffffffffefef000
> [ 5391.176679]  mdio_devres
> [ 5391.179186]  0000000000000020
> [ 5391.182125]  sysfillrect
> [ 5391.184632]  00000000000000b4
> [ 5391.187572]  soundcore
> [ 5391.190079]  900000047c7ed748
> [ 5391.193019]  sysimgblt
> [ 5391.195352]
> [ 5391.198291]  fb_sys_fops
> [ 5391.200626] $24   :
> [ 5391.202097]  libphy
> [ 5391.204604]  0000000000000001
> [ 5391.206680]  drm
> [ 5391.208756]  9000000100070700
> [ 5391.211696]  efivarfs
> [ 5391.213512]  900000000680a6b0
> [ 5391.216452]
> [ 5391.218701]  9000000000c6c880
> [ 5391.221641] CPU: 2 PID: 629596 Comm: cc1plus Not tainted 5.16.0-rc5 #1
> [ 5391.223110]
> [ 5391.226050] Hardware name: Loongson LM-LS3A5000-7A1000-1w-V01-pc_A2101=
/LM-LS3A5000-7A1000-1w-V01-pc_A2101, BIOS KL.4.1H.LM.D.017.210611.R 06/11/2=
021
> [ 5391.232532] $28   :
> [ 5391.234003] Stack :
> [ 5391.247223]  0000000000000dc0
> [ 5391.249299]
> [ 5391.251375]  ffffffffffffffff
> [ 5391.254315] Call Trace:
> [ 5391.255785]  0000000000000001
> [ 5391.258725]
> [ 5391.261146]  fffffffffffffffe
> [ 5391.264085]
> [ 5391.265555]
> [ 5391.268494] ---[ end trace e773af33d156dcec ]---
> [ 5391.269965] era   : 90000000003aa07c ___slab_alloc+0x3a0/0x6dc
> [ 5391.281807] ra    : 90000000003aa84c __slab_alloc.constprop.0+0x20/0x6=
4
> [ 5391.288387] CSR crmd: 000000b0
> [ 5391.288399] CSR prmd: 00000000
> [ 5391.291520] CSR euen: 00000001
> [ 5391.294641] CSR ecfg: 00071c1c
> [ 5391.297766] CSR estat: 00010000
> [ 5391.304107] ExcCode : 1 (SubCode 0)
> [ 5391.307577] BadVA : 000000000040007e
> [ 5391.311134] PrId  : 0014c011 (Loongson-64bit)
> [ 5391.315469] Modules linked in: nls_cp936 vfat fat amdgpu snd_hda_codec=
_generic ledtrig_audio led_class snd_hda_intel snd_intel_dspcfg snd_hda_cod=
ec uas snd_hda_core drm_ttm_helper ttm snd_pcm r8169 gpu_sched snd_timer us=
b_storage drm_kms_helper snd realtek syscopyarea mdio_devres sysfillrect so=
undcore sysimgblt fb_sys_fops libphy drm efivarfs
> [ 5391.345683] Process as (pid: 629589, threadinfo=3D00000000eb5d984e, ta=
sk=3D0000000056698aa5)
> [ 5391.353779] Stack : 00000000000000b4 0000000000000000 90000000003d24cc=
 900000011e993fc8
> [ 5391.361740]         00007ffff0cb0000 900000047fffc000 00007ffff0caffff=
 900000047c7ed748
> [ 5391.369697]         0000000000000dc0 0000000000000000 000000000000002f=
 000000000000000b
> [ 5391.377656]         900000011c62fd00 00000001ffff7fff 900000010c3dd920=
 9000000102ef6880
> [ 5391.385619]         900000011c62fb88 00007ffffbbbaef8 0000000000000dc0=
 90000000003d24cc
> [ 5391.393582]         9000000000af318c 9000000100070700 0000000000000dc0=
 900000010cf86ec0
> [ 5391.401544]         0000000000000000 9000000000cf0ff8 00007ffffbbbaca0=
 90000000003aa84c
> [ 5391.409508]         900000010cf86ec0 0000000000000000 9000000000cf0ff8=
 90000000003ac72c
> [ 5391.417469]         9000000102f3e418 00007ffff0ce1200 900000011c62fd00=
 00007ffff0cdf3a8
> [ 5391.425430]         00007ffffbbbaee7 fffffffffffff000 0000000000008000=
 90000001226c6dc0
> [ 5391.433390]         ...
> [ 5391.435816] Call Trace:
> [ 5391.435818]
> [ 5391.439714] [<90000000003d24cc>] __alloc_file+0x30/0xcc
> [ 5391.444913] [<90000000003d24cc>] __alloc_file+0x30/0xcc
> [ 5391.450109] [<90000000003aa84c>] __slab_alloc.constprop.0+0x20/0x64
> [ 5391.456346] [<90000000003ac72c>] kmem_cache_alloc+0x124/0x59c
> [ 5391.462063] [<90000000003d24cc>] __alloc_file+0x30/0xcc
> [ 5391.467264] [<90000000003d29f4>] alloc_empty_file+0x58/0x104
> [ 5391.472891] [<90000000003e2594>] path_openat+0x50/0xda0
> [ 5391.478090] [<9000000000326270>] filemap_map_pages+0x324/0x460
> [ 5391.483896] [<90000000003e4124>] do_filp_open+0xf4/0x134
> [ 5391.489182] [<90000000003f4d40>] alloc_fd+0x60/0x220
> [ 5391.494122] [<90000000003ce368>] do_sys_openat2+0xb8/0x184
> [ 5391.499582] [<90000000003ce798>] sys_openat+0x38/0x94
> [ 5391.504611] [<90000000008e2b50>] do_syscall+0x88/0xdc
> [ 5391.509640] [<90000000002015e4>] handle_syscall+0xc4/0x15c
> [ 5391.515108]
> [ 5391.516590] Code: ec28c023  31ec28c0  0c31ec28 <380c31ec> ad380c31  01=
ad380c  c101ad38  02c101ad  4d02c101
> [ 5391.526294]
> [ 5391.527830] ---[ end trace e773af33d156dced ]---
> [ 5391.532431] note: as[629589] exited with preempt_count 1
> [ 5391.537751] CPU 1 Unable to handle kernel paging request at virtual ad=
dress 0000000000000122, era =3D=3D 90000000003a967c, ra =3D=3D 90000000003a=
96b4
> [ 5391.550374] Oops[#2]:
> [ 5391.552628] CPU: 1 PID: 17 Comm: ksoftirqd/1 Tainted: G      D W      =
   5.16.0-rc5 #1
> [ 5391.560496] Hardware name: Loongson LM-LS3A5000-7A1000-1w-V01-pc_A2101=
/LM-LS3A5000-7A1000-1w-V01-pc_A2101, BIOS KL.4.1H.LM.D.017.210611.R 06/11/2=
021
> [ 5391.573719] $ 0   : 0000000000000000 90000000003a96b4 90000001001d8000=
 90000001001dbbf0
> [ 5391.581678] $ 4   : 00000000000000b4 0000000000000000 0000000000000001=
 900000011c6f3d00
> [ 5391.589635] $ 8   : 0000000000000001 900000000027d7a8 0000000000000000=
 90000000008f4864
> [ 5391.597591] $12   : 90000001000051d0 90000001000051d0 900000047c6c5990=
 000000017fffffff
> [ 5391.605548] $16   : 0000000000000002 0000000000400040 0000000000000001=
 00000000000000b0
> [ 5391.613504] $20   : 000000008040003f 9000000006805dc0 0000000080400040=
 900000047c6c5988
> [ 5391.621461] $24   : 0000000000000000 00000000000000b4 9000000100070700=
 000000000000ffff
> [ 5391.629417] $28   : 0000000000000001 fffffffffffffffe 90000001000051c0=
 0000000000000122
> [ 5391.637374] era   : 90000000003a967c __unfreeze_partials+0x50/0x250
> [ 5391.643605] ra    : 90000000003a96b4 __unfreeze_partials+0x88/0x250
> [ 5391.649830] CSR crmd: 000000b0
> [ 5391.649831] CSR prmd: 00000000
> [ 5391.652944] CSR euen: 00000000
> [ 5391.656057] CSR ecfg: 00071c1c
> [ 5391.659171] CSR estat: 00010000
> [ 5391.665483] ExcCode : 1 (SubCode 0)
> [ 5391.668942] BadVA : 0000000000000122
> [ 5391.672487] PrId  : 0014c011 (Loongson-64bit)
> [ 5391.676810] Modules linked in: nls_cp936 vfat fat amdgpu snd_hda_codec=
_generic ledtrig_audio led_class snd_hda_intel snd_intel_dspcfg snd_hda_cod=
ec uas snd_hda_core drm_ttm_helper ttm snd_pcm r8169 gpu_sched snd_timer us=
b_storage drm_kms_helper snd realtek syscopyarea mdio_devres sysfillrect so=
undcore sysimgblt fb_sys_fops libphy drm efivarfs
> [ 5391.707003] Process ksoftirqd/1 (pid: 17, threadinfo=3D00000000b978539=
1, task=3D0000000076f73243)
> [ 5391.715475] Stack : 90000001001dbca8 900000047c7c6f00 900000010cf86ec0=
 9000000000000000
> [ 5391.723433]         fffffffffffffffc 9000000000ceddf8 90000001001dbcb0=
 000000017fffffff
> [ 5391.731390]         9000000100070700 90000000003a5ef8 0000000000000000=
 900000000027d7d8
> [ 5391.739346]         9000000000be5640 9000000000ceddf8 0000000000000008=
 00000000011c6f00
> [ 5391.747302]         900000000027d7a8 900000047c7c6f00 9000000100070700=
 900000011c6f3d00
> [ 5391.755259]         0000000000000001 90000000003ada0c 9000000006806a38=
 900000011c6f3d00
> [ 5391.763216]         00000000000000b4 9000000000be5640 0000000000000000=
 9000000006806a38
> [ 5391.771172]         0000000000000006 90000001001dbd08 000000000000000a=
 0000000000000007
> [ 5391.779128]         90000000068069c0 900000000027d7a8 90000001187d2310=
 900000011c6f1500
> [ 5391.787085]         900000010d355b00 000000000000005d 90000001000b1e80=
 9000000000aec0c8
> [ 5391.795042]         ...
> [ 5391.797465] Call Trace:
> [ 5391.797467]
> [ 5391.801360] [<90000000003a5ef8>] memcg_slab_free_hook.part.0+0x144/0x2=
88
> [ 5391.808019] [<900000000027d7d8>] rcu_core+0x290/0x6d8
> [ 5391.813038] [<900000000027d7a8>] rcu_core+0x260/0x6d8
> [ 5391.818055] [<90000000003ada0c>] kmem_cache_free+0x168/0x368
> [ 5391.823676] [<900000000027d7a8>] rcu_core+0x260/0x6d8
> [ 5391.828693] [<90000000008ef2bc>] __do_softirq+0x11c/0x2e8
> [ 5391.834057] [<90000000002132ac>] run_ksoftirqd+0x44/0x58
> [ 5391.839335] [<9000000000235ec4>] smpboot_thread_fn+0x190/0x270
> [ 5391.845130] [<9000000000235d34>] smpboot_thread_fn+0x0/0x270
> [ 5391.850749] [<90000000002315f4>] kthread+0x180/0x1a0
> [ 5391.855680] [<9000000000231474>] kthread+0x0/0x1a0
> [ 5391.860436] [<9000000000201708>] ret_from_kernel_thread+0xc/0xa4
> [ 5391.866403]
> [ 5391.867875] Code: ec02bff8  03ec02bf  0003ec02 <260003ec> c4260003  03=
c42600  1503c426  001503c4  f7001503
> [ 5391.877565]
> [ 5391.879046] ---[ end trace e773af33d156dcee ]---
> [ 5391.883632] Kernel panic - not syncing: Fatal exception in interrupt
> [ 5391.889942] ------------[ cut here ]------------
> [ 5391.894525] WARNING: CPU: 1 PID: 17 at kernel/smp.c:894 smp_call_funct=
ion_many_cond+0x3b0/0x3c0
> [ 5391.903173] Modules linked in: nls_cp936 vfat fat amdgpu snd_hda_codec=
_generic ledtrig_audio led_class snd_hda_intel snd_intel_dspcfg snd_hda_cod=
ec uas snd_hda_core drm_ttm_helper ttm snd_pcm r8169 gpu_sched snd_timer us=
b_storage drm_kms_helper snd realtek syscopyarea mdio_devres sysfillrect so=
undcore sysimgblt fb_sys_fops libphy drm efivarfs
> [ 5391.933362] CPU: 1 PID: 17 Comm: ksoftirqd/1 Tainted: G      D W      =
   5.16.0-rc5 #1
> [ 5391.941228] Hardware name: Loongson LM-LS3A5000-7A1000-1w-V01-pc_A2101=
/LM-LS3A5000-7A1000-1w-V01-pc_A2101, BIOS KL.4.1H.LM.D.017.210611.R 06/11/2=
021
> [ 5391.954451] Stack :
> [ 5391.956528] Call Trace:
> [ 5391.956529]
> [ 5391.960422]
> [ 5391.961893] ---[ end trace e773af33d156dcef ]---
> [ 5391.966480] ---[ end Kernel panic - not syncing: Fatal exception in in=
terrupt ]---
We also found that the latest github kernel has some stable issues,
and we are investigating.

Huacai
>
> --
> Xi Ruoyao <xry111@mengyan1223.wang>
> School of Aerospace Science and Technology, Xidian University
