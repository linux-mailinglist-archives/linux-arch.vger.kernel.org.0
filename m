Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168DC39C25A
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 23:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhFDV3o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 17:29:44 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:37389 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhFDV3n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 17:29:43 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MwPjf-1lYzUc1Gpp-00sMrk; Fri, 04 Jun 2021 23:27:55 +0200
Received: by mail-wr1-f49.google.com with SMTP id a20so10647656wrc.0;
        Fri, 04 Jun 2021 14:27:55 -0700 (PDT)
X-Gm-Message-State: AOAM532toOOamUc7sqH+fu+yqE26yo4uj+zQxZ5tga8EOyl6SRW/kJKo
        oHCULsQ7XODXj8pUo06G8q0C6nF1UCz538faP9M=
X-Google-Smtp-Source: ABdhPJzJDHuyMCqX6WOws3xbJdiVdgcELrwsCfZOh8KOJCGiTnqEKWWc8yDd/bMkdxBixLXUQF+S4GmeCWLLk2+jBEc=
X-Received: by 2002:adf:a28c:: with SMTP id s12mr5998470wra.105.1622842074948;
 Fri, 04 Jun 2021 14:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAJF2gTTpurWpPUcA2JkF0rOFztKQgFBhOF9zQyuyi_-sxszhRQ@mail.gmail.com>
 <mhng-423aeaad-9339-4695-9a85-f947dd6135ac@palmerdabbelt-glaptop>
In-Reply-To: <mhng-423aeaad-9339-4695-9a85-f947dd6135ac@palmerdabbelt-glaptop>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 4 Jun 2021 23:26:11 +0200
X-Gmail-Original-Message-ID: <CAK8P3a04C8HObpSHNYqQpe4V96MoSLs7sEpiPvp4OpvyAU1_fQ@mail.gmail.com>
Message-ID: <CAK8P3a04C8HObpSHNYqQpe4V96MoSLs7sEpiPvp4OpvyAU1_fQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Guo Ren <guoren@kernel.org>, Anup Patel <Anup.Patel@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Drew Fustini <drew@beagleboard.org>,
        Christoph Hellwig <hch@lst.de>, wefu@redhat.com,
        lazyparser@gmail.com,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:EpuZWdIFfG7WNr+iQh4pxv0sAjYwuDZ/R7XWGTxUhpl6EagL1JD
 BpfaS8HJ9rKBIy6ELbUxCdb1X4I36M+jWZxHYtBcNWgS/iOVkm+cNLPvKSMm4zojneL2RqG
 +qTFFsjcGleLdyKePOkUaJndmkyfzSeuq9ssdGVbJya5N1QWyps6ud8u4rOPPVzcMz2Wa/H
 NV1ntttd2LWAl81IUDwrA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WAO1nQ8spAk=:84NJh+NAtc6dXYyzGS982W
 HcW4LNX5IAgGaNIUZc5swlmrBsSCEoGi9M83mczR28gczbzEyHZ1cdLGRz+9v5IqtAFCfMPRv
 Y0eh7ha4TfMpG1/6o44r3Iea/sQp9WS8Z1w0m97dbSCSICpSQCakxDmICQuEQRSe/SSVBGJyE
 OHdZP3bz1+O1GdZ89jbwJnZXlbcq4MZfTyigbwi5emixKx016yQycenkVu9mEl3XNSRAKZZQl
 r3Oju05HveY6Ttof23H3bhQeRlUaoxgJ5L/jgpfD1uIfeZHPw5WJYTNil+1FIXmK1yfp4oyCr
 QI3SPkHc+1fpix902FDNKFmejr00FDjFvDGJwNElgq7xD2o3WPX4Fh9wdkTHFqAgFnTRdy7/0
 jgULKBicvqEgCqZgrXmoFnm5fZsR3eG/GFRKg84s110vwUl98AAnlczo3dznutvtU8xmejn4q
 NI2bQsC3mdUSMbzTiIZAy4Itn4FMaYfz//C3WYgRazHw0icoHRccGweHuoa3++ZWH+pi8XVMw
 Xl2hYr20TElfIiJNyp56aKNJqQaM7dLwVSDS4EN7wO5cv8iMXTvMK6aUebL5ePdKtX/4MfUcl
 0xPHeJi6sHqV9KWqTN5Qrn7r/PWQxvmx8BLmhMUBE7yVkfduYc2Ej+oaRzwqNkOwiPl5TNLc8
 x4yI=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 4, 2021 at 6:14 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:

> The hope here has always been that we'd have enough in the standards
> that we could avoid a proliferation of vendor-specific code.  We've
> always put a strong "things keep working forever" stake in the ground in
> RISC-V land, but that's largely been because we were counting on the
> standards existing that make support easy.  In practice we don't have
> those standards so we're ending up with a fairly large software base
> that is required to support everything.  We don't have all that much
> hardware right now so we'll have to see how it goes, but for now I'm in
> favor of keeping defconfig as a "boots on everything" sort of setup --
> both because it makes life easier for users, and because it makes issues
> like the non-portable Kconfigs that showed up here quite explicit.

It's obviously easy to take the hard line approach as long as there is
so little hardware available. I expect this to be a constant struggle,
but it's definitely worth trying as long as you can.

> >> To give some common examples that make it break down:
> >>
> >> - 32-bit vs 64-bit already violates that rule on risc-v (as it does on
> >>   most other architectures)
>
> Yes, and there's no way around that on RISC-V.  They're different base
> ISAs therefor re-define the same instructions, so we're essentially at
> two kernel binaries by that point.  The platform spec says rv64gc, so we
> can kind of punt on this one for now.  If rv32 hardware shows up
> we'll probably want a standard system there too, which is why we've
> avoided coupling kernel portability to XLEN.

I would actually put 32-bit into the same category as NOMMU, XIP
and the built-in DTB:
Since it seems unrealistic to expect an rv32 Debian or Fedora build,
there is very little to gain by enforcing compatibility between machines.
This is different from 32-bit Arm, which is widely used across multiple
distros and many SoCs.

> >> - architectures that support both big-endian and little-endian kernels
> >>   tend to have platforms that require one or the other (e.g. mips,
> >>   though not arm). Not an issue for you.
>
> It is now!  We've added big-endian to RISC-V.  There's no hardware yet
> and very little software support.  IMO the right answer is to ban that
> from the platform spec, but again it'll depnd on what vendors want to
> build (though anyone is listening, please don't make my life miserable
> ;)).

I don't see any big-endian support in linux-next. This one does seem
worth enforcing to be kept out, as it would double the number of user
space ABIs, not just kernel configurations. On arm64, I think the general
feeling is now that we would have been better off not merging big-endian
support into the kernel as an option, but it still seemed important at the
time. Not that there is anything really wrong with big-endian by itself,
just that there is no use case that is worth the added complexity of
supporting both.

Let me know if there are patches you want me to Nak in the future ;-)

> >> - SMP-enabled ARMv7 kernels can be configured to run on either
> >>   ARMv6 or ARMv8, but not both, in this case because of incompatible
> >>   barrier instructions.
>
> Our barriers aren't quite split the same way, but we do have two memory
> models (RVWMO and TSO).  IIUC we should be able to support both in the
> same kernels with some patching, but the resulting kernels would be
> biased towards one memory models over the other WRT performance.  Again,
> we'll have to see what the vendors do and I'm hoping we don't end up
> with too many headaches.

I wouldn't specifically expect the problem to be barriers in the rv64 case,
this was just an example of instruction sets slowly changing in incompatible
ways over a long time. There might be an important reason for version 3.0
of one of the specifications to drop compatibility with version 1.x.

          Arnd
