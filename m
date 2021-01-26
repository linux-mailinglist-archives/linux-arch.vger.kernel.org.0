Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27F6304216
	for <lists+linux-arch@lfdr.de>; Tue, 26 Jan 2021 16:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405245AbhAZPRw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jan 2021 10:17:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:40524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406165AbhAZPRt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Jan 2021 10:17:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3452023125;
        Tue, 26 Jan 2021 15:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611674229;
        bh=jQUlNAmaG/JIlfb8wj1P0QU7PlzvHrMjBt0DjW3UBfQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bse7wsbZ4WVfRFS7M6zYsvz61/gsg2IADS3AYZUKCyQl67/RBZHesYz30LfB5DwgG
         U+P0lYcLi+mkaKFCcoYhq7wXMemGr2O+3NJuQnGEJqaOBpQr8pmqHAARSguolW8TW+
         RrKLJp9zyMMphbZg2qtcugYXTmXp405TmGnMM6ZMB+z51Y/vFWx79NTXJBfFPFn9ak
         ry+BSaAz4/K9SCfaoHYG07170FVnp4HvQ4tHvNjjtqkHip5psrx8gvAstS3PaQKbTO
         6PsSQzQo0KwVpaggBh1Y3dQkfWeTNUTqPpjbKYVGV7xbAmtvMVphH9HgTeYSPYjXut
         jKWqVZcxGodeg==
Received: by mail-oi1-f180.google.com with SMTP id i25so7387178oie.10;
        Tue, 26 Jan 2021 07:17:09 -0800 (PST)
X-Gm-Message-State: AOAM5333uZIMqhBhlYMD0VfjFJx9OBG8Mv7Dan7L/zVPvS/81Apdq14r
        R1LKVt1n18C2ZBErbDBAjGlb17slvpy1In2NA6U=
X-Google-Smtp-Source: ABdhPJwzZ3sReWOgVZhRx5LVbv2/3ZapJ6LqBiJgyYUw2cSJE/Ic21/PhdWhJsnpxVhszTtG/IuY5pouzNYsdV0bduk=
X-Received: by 2002:aca:eb0a:: with SMTP id j10mr121687oih.4.1611674228434;
 Tue, 26 Jan 2021 07:17:08 -0800 (PST)
MIME-Version: 1.0
References: <1610729929-188490-1-git-send-email-john.garry@huawei.com>
In-Reply-To: <1610729929-188490-1-git-send-email-john.garry@huawei.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 26 Jan 2021 16:16:51 +0100
X-Gmail-Original-Message-ID: <CAK8P3a38HsXrebiCdJXJdxdBvS7AUjs+rVEex-0JQ+ZsytTy8A@mail.gmail.com>
Message-ID: <CAK8P3a38HsXrebiCdJXJdxdBvS7AUjs+rVEex-0JQ+ZsytTy8A@mail.gmail.com>
Subject: Re: [PATCH RFC 0/4] Fix arm64 crash for accessing unmapped IO port
 regions (reboot)
To:     John Garry <john.garry@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>, linuxarm@openeuler.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 15, 2021 at 5:58 PM John Garry <john.garry@huawei.com> wrote:
>
> This is a reboot of my original series to address the problem of drivers
> for legacy ISA devices accessing unmapped IO port regions on arm64 systems
> and causing the system to crash.
>
> There was another recent report of such an issue [0], and some old ones
> [1] and [2] for reference.
>
> The background is that many systems do not include PCI host controllers,
> or they do and controller probe may have failed. For these cases, no IO
> ports are mapped. However, loading drivers for legacy ISA devices can
> crash the system as there is nothing to stop them accessing those IO
> ports (which have not been io remap'ed).
>
> My original solution tried to keep the kernel alive in these situations by
> rejecting logical PIO access to PCI IO regions until PCI IO port regions
> have been mapped.
>
> This series goes one step further, by just reserving the complete legacy
> IO port range in 0x0--0xffff for arm64. The motivation for doing this is
> to make the request_region() calls for those drivers fail, like this:
>
> root@ubuntu:/home/john# insmod mk712.ko
>  [ 3415.575800] mk712: unable to get IO region
> insmod: ERROR: could not insert module mk712.ko: No such device
>
> Otherwise, in theory, those drivers could initiate rogue accesses to
> mapped IO port regions for other devices and cause corruptions or
> side-effects. Indeed, those drivers should not be allowed to access
> IO ports at all in such a system.
>
> As a secondary defence, for broken drivers who do not call
> request_region(), IO port accesses in range 0--0xffff will be ignored,
> again preserving the system.
>
> I am sending as an RFC as I am not sure of any problem with reserving
> first 0x10000 of IO space like this. There is reserve= commandline
> argument, which does allow this already.
>
> For reference, here's how /proc/ioports looks on my arm64 system with
> this change:
>
> root@ubuntu:/home/john# more /proc/ioports
> 00010000-0001ffff : PCI Bus 0002:f8
>   00010000-00010fff : PCI Bus 0002:f9
>     00010000-00010007 : 0002:f9:00.0
>       00010000-00010007 : serial
>     00010008-0001000f : 0002:f9:00.1
>       00010008-0001000f : serial
>     00010010-00010017 : 0002:f9:00.2
>     00010018-0001001f : 0002:f9:00.2
> 00020000-0002ffff : PCI Bus 0004:88
> 00030000-0003ffff : PCI Bus 0005:78
> 00040000-0004ffff : PCI Bus 0006:c0
> 00050000-0005ffff : PCI Bus 0007:90
> 00060000-0006ffff : PCI Bus 000a:10
> 00070000-0007ffff : PCI Bus 000c:20
> 00080000-0008ffff : PCI Bus 000d:30

Doesn't this mean we lose the ability to access PCI devices
with legacy ISA compatibility? Most importantly, any GPU today
should in theory still support VGA frame buffer mode or text
console, but both of these stop working if the low I/O ports are
not mapped to the corresponding PCI bus. There is of course
already a problem if you have multiple PCI host bridges, and
each one gets its own PIO range, which means that only one
of them can have an ISA bridge with working PIO behind it.

Another such case would be a BMC that has legacy ISA devices
behind a (real or emulated) LPC bus, e.g. a 8250 UART, ps2
keyboard, RTC, or an ATA CDROM. Not sure if any of those are
ever used on Arm machines.

Regarding the size of the reservation, does this actually need
to cover the 0x0fff...0xffff range or just 0x0000...0x0fff? I don't
think there are any drivers that hardcode I/O ports beyond 0x0fff
because those would not work on ISA buses but require PCI
assigned BARs.

One more thought: There are two common ways in which PCI
host bridges map their PIO ports: either each host bridge has
its own 0x0...0xffff BAR range but gets remapped to an
arbitrary range of port numbers in the kernel, or each host bridge
uses a distinct range of port numbers, and the kernel can use
a 1:1 mapping between hardware and software port numbers,
i.e. the number in the BAR is the same as in the kernel.

If all numbers are shifted by 0x10000, that second case no
longer works, and there is always an offset.

        Arnd
