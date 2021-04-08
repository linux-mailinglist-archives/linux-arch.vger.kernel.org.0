Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88485358E17
	for <lists+linux-arch@lfdr.de>; Thu,  8 Apr 2021 22:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhDHUIZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Apr 2021 16:08:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231451AbhDHUIY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Apr 2021 16:08:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E98DF61132;
        Thu,  8 Apr 2021 20:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617912493;
        bh=lJBvFSudiDrxZs+SnGh4YtxaarzP38H043H9PsxfbKw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tBubWWY3+neAkzvUwVEoCp09FqswXCDaRx0c5tqpOKjvcYtVCmFe8JHZ54TSymAUN
         LcUpHK9kiXHWgsLiDmBkRkBjUyBdxgg10Kg/vhYMlvwhM6Td33Bu/fEAPoZH7Rwzg3
         y/02Yh1kIkod5A/25l6gmVy/uGkdg25wTAzvSArNYFnlkxuDzKdqut3U9ckR8RDs9P
         vDjyKsx0P5LjQjJsrua6oISbMFMHmtnTHx3DuSW049FdIe7WaniCJJy7rcIwUJrymm
         s/dYmx64TzuZ1Bdy4C5SW9baPR3AZmbYAPa+qWcEfy3HARHgLptgEEwfQza7x3mWiq
         CQZwA4HwhhFsA==
Received: by mail-ed1-f41.google.com with SMTP id e7so3875940edu.10;
        Thu, 08 Apr 2021 13:08:12 -0700 (PDT)
X-Gm-Message-State: AOAM532MiIY6kAZq95BJu9tubGyyd7/DL4oJw+thkRKSDYMiwaxoJhQV
        gQ4jjRQ5aOfzJxMQjGXOu1ZN4nPcKxa0JK0RbQ==
X-Google-Smtp-Source: ABdhPJyQM3sGNyB4lBHJyB/vMz0AuBm9hT4GnsJ9rwYhPZ4h1PIVlO3IzyI5ADQSr6ra6UOvePCEFavpVtRgMZ1GG6I=
X-Received: by 2002:a05:6402:212:: with SMTP id t18mr13947421edv.165.1617912491462;
 Thu, 08 Apr 2021 13:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <34d20d1dbb88f26d418b33985557b0475374a1a5.1617556785.git.christophe.leroy@csgroup.eu>
In-Reply-To: <34d20d1dbb88f26d418b33985557b0475374a1a5.1617556785.git.christophe.leroy@csgroup.eu>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 8 Apr 2021 15:08:00 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ=UNfptbNHR5XAS9BQRv3C5+YonW9rwypA5gGt2N7bGQ@mail.gmail.com>
Message-ID: <CAL_JsqJ=UNfptbNHR5XAS9BQRv3C5+YonW9rwypA5gGt2N7bGQ@mail.gmail.com>
Subject: Re: [RFC PATCH v6 1/1] cmdline: Add capability to both append and
 prepend at the same time
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Will Deacon <will@kernel.org>, Daniel Walker <danielwa@cisco.com>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>, devicetree@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        microblaze <monstr@monstr.eu>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        nios2 <ley.foon.tan@intel.com>,
        Openrisc <openrisc@lists.librecores.org>,
        linux-hexagon@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        X86 ML <x86@kernel.org>, linux-xtensa@linux-xtensa.org,
        SH-Linux <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Apr 4, 2021 at 12:20 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> One user has expressed the need to both append and prepend some
> built-in parameters to the command line provided by the bootloader.
>
> Allthough it is a corner case, it is easy to implement so let's do it.
>
> When the user chooses to prepend the bootloader provided command line
> with the built-in command line, he is offered the possibility to enter
> an additionnal built-in command line to be appended after the
> bootloader provided command line.
>
> It is a complementary feature which has no impact on the already
> existing ones and/or the existing defconfig.
>
> Suggested-by: Daniel Walker <danielwa@cisco.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> Sending this out as an RFC, applies on top of the series
> ("Implement GENERIC_CMDLINE"). I will add it to the series next spin
> unless someone is against it.

Well, it works, but you are working around the existing kconfig and
the result is not great. You'd never design it this way.

Rob
