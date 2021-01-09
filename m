Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4536F2F021B
	for <lists+linux-arch@lfdr.de>; Sat,  9 Jan 2021 18:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbhAIRMH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 9 Jan 2021 12:12:07 -0500
Received: from mail-40136.protonmail.ch ([185.70.40.136]:34808 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbhAIRMH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 9 Jan 2021 12:12:07 -0500
Date:   Sat, 09 Jan 2021 17:11:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1610212284; bh=rNDBsb/5jzCtXm4ccD8b7PVBPJte7jON6vMo9RPdX3M=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=nf+g7+lS8IzGv3c6ZvZrzY+ePPPHiMRzcP0qbyj6dCj3V0JZYtnbC/xU0F4qi8UA3
         lqr6JHYmAlMtG/c/yOOWutwTfhIvq+RLeCLNf2CfKb6I7ZTSfF5+Gq5ALZRC5lVIw8
         MJdoitNxqtpedH6rdzRbReTQnpkf0P7CrskZ8u3P/PwRqF+lL3SsBhi6rTir74RI2t
         CKB/4PKkDlNytTni8KsQ/4iOaJSCTb97NhW7NJHFxa0mlFXcGTAuUtg5rA54fc3nZ7
         VNmfI45t8El6PIDJ0J+WQ0ljEKvd3gUf+NET2t65Kv4Zzp3PcKuXdZWk9VoRznhGJH
         GFdlXN/qrO4ZQ==
To:     clang-built-linux@googlegroups.com, linux-mips@vger.kernel.org
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Alexander Lobakin <alobakin@pm.me>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: [BUG mips llvm] MIPS: malformed R_MIPS_{HI16,LO16} with LLVM
Message-ID: <20210109171058.497636-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Machine: MIPS32 R2 Big Endian (interAptiv (multi))

While testing MIPS with LLVM, I found a weird and very rare bug with
MIPS relocs that LLVM emits into kernel modules. It happens on both
11.0.0 and latest git snapshot and applies, as I can see, only to
references to static symbols.

When the kernel loads the module, it allocates a space for every
section and then manually apply the relocations relative to the
new address.

Let's say we have a function phy_probe() in drivers/net/phy/libphy.ko.
It's static and referenced only in phy_register_driver(), where it's
used to fill callback pointer in a structure.

The real function address after module loading is 0xc06c1444, that
is observed in its ELF st_value field.
There are two relocs related to this usage in phy_register_driver():

R_MIPS_HI16 refers to 0x3c010000
R_MIPS_LO16 refers to 0x24339444

The address of .text is 0xc06b8000. So the destination is calculated
as follows:

0x00000000 from hi16;
0xffff9444 from lo16 (sign extend as it's always treated as signed);
0xc06b8000 from base.

=3D 0xc06b1444. The value is lower than the real phy_probe() address
(0xc06c1444) by 0x10000 and is lower than the base address of
module's .text, so it's 100% incorrect.

This results in:

[    2.204022] CPU 3 Unable to handle kernel paging request at virtual
address c06b1444, epc =3D=3D c06b1444, ra =3D=3D 803f1090

The correct instructions should be:

R_MIPS_HI16 0x3c010001
R_MIPS_LO16 0x24339444

so there'll be 0x00010000 from hi16.

I tried to catch those bugs in arch/mips/kernel/module.c (by checking
if the destination is lower than the base address, which should never
happen), and seems like I have only 3 such places in libphy.ko (and
one in nf_tables.ko).
I don't think it should be handled somehow in mentioned source code
as it would look rather ugly and may break kernels build with GNU
stack, which seems to not produce such bad codes.

If I should report this to any other resources, please let me know.
I chose clang-built-linux and LKML as it may not happen with userland
(didn't tried to catch).

Thanks,
Al

