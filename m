Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03EA3BC91E
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 12:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhGFKOz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 06:14:55 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:48607 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhGFKOz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2021 06:14:55 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MwxNF-1lHYWK1VtL-00yMfF for <linux-arch@vger.kernel.org>; Tue, 06 Jul
 2021 12:12:15 +0200
Received: by mail-wm1-f45.google.com with SMTP id n33so5690702wms.1
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 03:12:15 -0700 (PDT)
X-Gm-Message-State: AOAM530iKQo9KpPgRBtDQusmrWG+qxs0sL9t/jSIJvfo30h6ptbr20cs
        o8SdRHuBvHn3HPz2Xp+ACwTLUCiu8iLDKzB2VT4=
X-Google-Smtp-Source: ABdhPJxPbcVsyGvIEDzhYN2hZ9chDR0lMcvwz+mnBPVSwvCmdGl555iHik64NVbgKc9ItEL398zTCoywJzMEo6OQfec=
X-Received: by 2002:a05:600c:4896:: with SMTP id j22mr991755wmp.43.1625566334958;
 Tue, 06 Jul 2021 03:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
In-Reply-To: <20210706041820.1536502-1-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 6 Jul 2021 12:11:59 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0o1bniPG+pocGtMGV-RVEGVJrQDLmz6SyZ-2NGcq2WnQ@mail.gmail.com>
Message-ID: <CAK8P3a0o1bniPG+pocGtMGV-RVEGVJrQDLmz6SyZ-2NGcq2WnQ@mail.gmail.com>
Subject: Re: [PATCH 00/19] arch: Add basic LoongArch support
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Chen Zhu <zhuchen@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:6y5UUvzWOQ10gxEWV/zaeGRibhlAGHTJo0CtZcnCE7VQisR8yPV
 Npq2ZPl5L045FbTMvPagKdWhr5kAfkxIGvW28+uYZRLIVq1aP8iO+3Itv0/Ch1ntJCW/UMk
 3H34W+ZqERqoMgfH0LWeO5cLRJUcnc4vyJGD1RL3V/MZrVFZq44ZOWcS53XXo5JcqclrmcG
 kYZon9kAPBwtUXlJLgGLQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MPCfqVLCvG4=:yvZLyikNjbBGFk+/DnKMMg
 r1oBknTLvViyqnZqdEsE2nGc0PETyTPaXP5hI5UbBviCYYLAA+T0w/pVDAGQ/u92Kgp5rnaCf
 stjtSuXXDwDKTIy9H7lhp+a1sWPf8FZMJhy/GoV1hyOtwQXCDvbTfqk6HMKz5mM1/hkEtmgDt
 QdPolUD8m+OX2NilB+k5phw5WpWakQbNLlLh9ZUow4evMqFObUojA+gMTVoMqtz6eeCQAo7b/
 lD6RXiCYevfSU+b0V6A7jzjcmhs8buM2iZRQ5oJxG2gnDf9L9eCjuiJI4MzPRGlmGYwTGKBEm
 8tdimvszXp+yswPXDscnwNDQX4QhiETv10D+lSzbjcmAbSLC0DwqIZQvdVSSvwmsqrcgTHTCx
 uu9E213P+ZkRcJON9qkPFIZy/UeXKBFGIuQYrNEr9cn1YxSLFfoXob846scXHgIMPPBRndTaY
 EwES0jbOgXLDzCPHedxD63ssF0O4+PsfecIN2zoWzp6jMaJYsfu/E/pokdMTC3fYh1IKU7QRU
 8uICb+SdLp1MmhYscAetRs0tYEgHPv4eDEbm7uvfnmlNkbh5cSOcOfDNHVnJudvJ/Ot+ZMPnu
 CLC9VkvbEXKmfF/Gyw+srcBAzWo620fzBrWSw7gEqCZ7cbep1tWvgJdTKTs03/MhIeExRMa/k
 3gH2Y/XaEqDo8IEQ2RJXVWhPol2J8KuEK9+e7ArO2fFWMQMLluQnJSvlwvV/SGDFUD9SFL+R+
 qlnhCjT4Pm7h7g6Qbyyf6uzS8PnN/PNVM0BHwuGByyHbgg+iTkzSPRSSpS4zVgJPnpvLhyZjj
 j+MXbIpZ9hbpPSCQswOEPqHWTt44NF+lrZsONzbkeZNkcJNIeF3L+EFAcvWtWBW+P6a5yMo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
> LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
> version (LA32S) and a 64-bit version (LA64). LoongArch use ACPI as its
> boot protocol LoongArch-specific interrupt controllers (similar to APIC)
> are already added in the next revision of ACPI Specification (current
> revision is 6.4).
>
> This patchset is adding basic LoongArch support in mainline kernel, we
> can see a complete snapshot here:
> https://github.com/loongson/linux/tree/loongarch-next
>
> Cross-compile tool chain to build kernel:
> https://github.com/loongson/build-tools/releases
>
> Loongson and LoongArch documentations:
> https://github.com/loongson/LoongArch-Documentation
>
> LoongArch-specific interrupt controllers:
> https://mantis.uefi.org/mantis/view.php?id=2203

Thanks a lot for your submission, I've been waiting for this, and have just
completed an initial quick review, will send out the individual replies in a
bit.

I have a few high-level comments about things that need to be improved
before merging:

1. Copyright statements: I can see that you copied a lot of code from arch/mips,
 and then a bit from arch/arm64 and possibly arch/riscv/, but every file just
 lists loongson as the copyright holder and one or more employees as authors.
 This clearly has to be resolved by listing the original authors as well.

2. Reducing the amount of copied code: my impression is that the bits you
   wrote yourself are generally of higher quality than the bits you copied from
   mips, usually because those have grown over a long time to accommodate
   cases you should not worry about. In cases where there was no generic
   implementation, we should try to come up with a version that can be shared
   instead of adding another copy.

3. 32-bit support: There are small bits of code for 32-bit support everywhere
   throughout the code base, but there is also code that does not look like
   it would work in that configuration. I would suggest you split out all 32-bit
   code into a separate patch, the way you have done for SMP and NUMA
   support. That way it can be reviewed separately, or deferred until when
   you actually add support for a 32-bit platform. Please also clarify which
   modes you plan to support: should every 64-bit kernel be able to run
   LA32R and LA32S user space binaries, or do you require running the same
   instruction set in both kernel and user space as RISC-V does?
   Do you plan to have MIPS N32 style user space on 64-bit kernels?

4. Toolchain sources: I see you only have binaries for an older gcc-8.3
    release and no sources so far. I assume you are already busy porting
    the internal patches to the latest gcc and will post that soon, but my
    feeling is that the kernel port should not get merged until we have a
    confirmation from the toolchain maintainers that they plan to merge
    support for their following release. We should however make sure that
    your kernel port is completely reviewed and can just get merged once
    we get there.

5. Platform support: You have copied the underlying logic from arch/mips,
    but that still uses a method where most platforms (not the new
    "generic" version) are mutually exclusive. Since you only support
    one platform right now, it would be best to just simplify it to the point
    where no platform specific code is needed in arch/loongarch/ and
    it just works. If you add 32-bit support later on, that obviously requires
    making a choice between two or three incompatible options.

        Arnd
