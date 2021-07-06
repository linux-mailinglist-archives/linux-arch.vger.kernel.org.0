Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8CB3BCA09
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 12:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbhGFKgv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 06:36:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231216AbhGFKgv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Jul 2021 06:36:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3294619B6
        for <linux-arch@vger.kernel.org>; Tue,  6 Jul 2021 10:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625567652;
        bh=Xq+2Q7faFG1FmDVhft9w4npiFKNUwoJGUSYLQceBZgg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OYjYcxAOyYVtiN92CgJ9xuvfv/OJRX3UDycI944qXzqiXzbEnX8a7eNNYj4+t9xF7
         yNuMklK1om7MdU64mnUHgl+mnkeN/Z8QogmMyoeT+/8fka9S+xnPRFzGSs5f9nLc6w
         xF8zEFJlmKdFO1GPsOI+zp053m2HGV9zY8RDKCODtwTkoIYh7P4CoL/gO7N7xAvqQV
         lltjJEwbsEZNX3HLqYgq0YDsYE0a3vhpCojaFmJCf6nu/haoY2Ule+2ebd/2Z5SoBX
         /7o81N1UALFKY1G3ngLHGsms6Z+76uFQVHhM4DmOdbL6hVyrA4i27wuNXBt/4367O/
         qGJqV6P7hn1LQ==
Received: by mail-wr1-f48.google.com with SMTP id d2so1847987wrn.0
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 03:34:12 -0700 (PDT)
X-Gm-Message-State: AOAM531j0HTsMlfcR+7Q6WlaQSpcPC3GWbejy7tKpohAr+bCgjkoSgqo
        7P9cw01SJquqhY7nmXsSzJuFsOBv8pRft8oUNs8=
X-Google-Smtp-Source: ABdhPJz0Vg8XCxb7nlGz7/JuhNN5WrUYcHYZeEeR7u77fnhZfEgdB+6XBrs91uu4tK5OLcnAjpx/2Q14mW1Ervxv+Kc=
X-Received: by 2002:adf:e107:: with SMTP id t7mr21011079wrz.165.1625567651364;
 Tue, 06 Jul 2021 03:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
In-Reply-To: <20210706041820.1536502-1-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 6 Jul 2021 12:33:55 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Qu_BUcGFpgktXOwsomuhN6aje6mB6EwTka0GBaoL4hw@mail.gmail.com>
Message-ID: <CAK8P3a2Qu_BUcGFpgktXOwsomuhN6aje6mB6EwTka0GBaoL4hw@mail.gmail.com>
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

(sorry for sending duplicate emails, it appears that the provide of my
arnd@arndb.de address gets spam-filtered once more, so sending all my
replies again from arnd@kernel.org)

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
