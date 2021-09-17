Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1323940F570
	for <lists+linux-arch@lfdr.de>; Fri, 17 Sep 2021 12:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241646AbhIQKB1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Sep 2021 06:01:27 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:42605 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhIQKB0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Sep 2021 06:01:26 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M9WiK-1mUU3L2KaS-005Yc6; Fri, 17 Sep 2021 12:00:03 +0200
Received: by mail-wr1-f52.google.com with SMTP id i23so14260117wrb.2;
        Fri, 17 Sep 2021 03:00:03 -0700 (PDT)
X-Gm-Message-State: AOAM533ABkHQ9znRVJRWCpoMYS69xHnyGryVcPT3RofVAM/Imw4Gna4m
        bp17krXeKV5pQ+wUXymYcTil3iC+SH92s1uO7Lk=
X-Google-Smtp-Source: ABdhPJyvhDrqYzXphcVkK1FBrHhhk/pUL3mymqcJFEcLsVXHNrmMksOOvVhdhgKpF+HOpZzFT0cmgKV+rF7YHvlSJ+I=
X-Received: by 2002:adf:c10b:: with SMTP id r11mr11167163wre.336.1631872803099;
 Fri, 17 Sep 2021 03:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210917035736.3934017-1-chenhuacai@loongson.cn>
In-Reply-To: <20210917035736.3934017-1-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Sep 2021 11:59:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0jdGhdoc4SHXDrtK2sOFkdWMX+6O2-WgcB1h=yNTqdgQ@mail.gmail.com>
Message-ID: <CAK8P3a0jdGhdoc4SHXDrtK2sOFkdWMX+6O2-WgcB1h=yNTqdgQ@mail.gmail.com>
Subject: Re: [PATCH V3 00/22] arch: Add basic LoongArch support
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
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
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:qo30ntLUtt/uyLMOKOdSoOgpeBVG4SuyO6zNx0ur5ytVr+qF3N/
 g+hbNYKbrj/sxa4R9xKAdRE6RspOsaXCY2tkFrQwq5MffNH6WzrWVxsnC8BsIBuiSMpLLAA
 0mWBSii/5ws3kld0J35VCQQXpvpuovB+eMzpAzccE1dzwwbgxWvMGIduhas1B1QWZ/Lc21h
 xPnjee0l6aR8b9GgXoXDA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wzPYElE+Npg=:tRWDM98sSp0FvXG8LZqP+V
 JplA+AjM1gkws6vAPpypGAA5WmIpJg8k3sUm+I5dlHq7F2Vm7c/1JoksAO8GXwcvmFUNIbg3W
 GbLU1q1fSxMKvYltUUDJ2PN0YyGWFlt0ClXVW207vtIuS2fbZEq3paDZc4TxCzKNkdkp9DUVR
 pdaG6zBZEU5wX2qMb76LzRdTzbTMFih8B2cxrZHRAQU0X41RUT0nnQ+M2xKjjyzoFlAyUDTip
 B+L4eo7mLHFv4Cl0avREMqVo2aSWebJtHZJS5/Q+8R11beSSqSJtqliYis9ZwiCmuHUw7w4fZ
 qmRNcjC4dNxFNrq7EbdkPkt2Vp4qZh8+3hnNHNmhktxtd2My5LxudgXEwpKdeSXHLY2yV4Iiq
 xz7RZ+BNAVNlFRzSMu1O8jqmMouFYGB1fxX6TqjOzF9bgvVZFJZDcaS3M1i6dpDpfw/+cKcXi
 3HQYt/wfI8dz/hR7S7rLrQgrwLTTKm+uK0efzp/tG5DYkt7/WslzJM9BEFL29BlX2+vypAzL0
 nlX8UzHXuOL+Gih5ZSpJGVOR4jeXOxEf1UjHvRn9d4oJo9bSb1Tmhet+nXygyWrE6CXZLTfdE
 qfxANNXh4ZhLuHtr9wgwDN3yjedJYWTeHH1628cX9ltKhf9052R920Es+dScE4D2kANtZ3071
 hwGBsje6xkLVDF9rd7nJhePenwPLO5LJtqMz6/wwDXlt4x1pw8qxJ4NeSUMsGA7Q4TH7zd1Ob
 pIkUB/+Izp7YARrH8nfvUll1vYHRVyfmQAD1jhMhZo942d3w1UM2lCX1i9T0utnzuQkUP/dzp
 sOxhsiO4s7cLrGZ+9os0MjVL8ss/tZK67J6IVP1G1tiR0Zk5danh46fO1hgY0z+1oTyboP7xi
 8obHruLvFqvKaAhyx0HQ==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 17, 2021 at 5:57 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
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
> https://github.com/loongson/build-tools/releases/latest/download/loongarch64-clfs-20210812-cross-tools.tar.xz
>
> A CLFS-based Linux distro:
> https://github.com/loongson/build-tools/releases/latest/download/loongarch64-clfs-system-2021-08-22.tar.bz2
>
> Open-source tool chain which is under review:
> https://github.com/loongson/binutils-gdb/tree/loongarch-2_37
> https://github.com/loongson/gcc/tree/loongarch-12
> https://github.com/loongson/glibc/tree/loongarch_2_34_dev
>
> Loongson and LoongArch documentations:
> https://github.com/loongson/LoongArch-Documentation
>
> LoongArch-specific interrupt controllers:
> https://mantis.uefi.org/mantis/view.php?id=2203
>
> V1 -> V2:
> 1, Add documentation patches;
> 2, Restore copyright statements;
> 3, Split the big header patch;
> 4, Cleanup signal-related headers;
> 5, Cleanup incomplete 32-bit support;
> 6, Move the major PCI work to drivers/pci;
> 7, Rework Loongson64 platform support;
> 8, Rework lpj and __udelay()/__ndelay();
> 9, Rework page table layout config options;
> 10, Rework syscall/exception/interrupt with generic entry framework;
> 11, Simplify the VDSO/VSYSCALL implementation;
> 12, Use generic I/O access macros and functions;
> 13, Remove unaligned access emulation at present;
> 14, Keep clocksource code in arch since it is the "native clocksource";
> 15, Some other minor fixes and improvements.
>
> V2 -> V3:
> 1, Rebased on 5.15-rc1;
> 2, Cleanup PCI code on V2;
> 3, Support multiple msi domain;
> 4, Support cacheable ioremap();
> 5, Use irq stack for interrupt handling;
> 6, Adjust struct ucontext and rt_sigframe;
> 7, Some other minor fixes and improvements.

I see you have made a lot of progress, that looks nice. I commented on the PCI
stuff already, I think that needs more work and should be split out so it does
not hold up the architecture merge. Also as I commented, the series needs more
review from the EFI/ACPI, signal, and module maintainers among others.

It would be good if you could add more information in the patch descriptions
for each patch to summarize the discussions that have led to changes or
whenever you got comments but argued that the current version is necessary.

        Arnd
