Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87DF81898AD
	for <lists+linux-arch@lfdr.de>; Wed, 18 Mar 2020 10:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgCRJ6J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Mar 2020 05:58:09 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:56601 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgCRJ6J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Mar 2020 05:58:09 -0400
Received: from mail-qv1-f54.google.com ([209.85.219.54]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MY60J-1imcwF2MoP-00YNi6; Wed, 18 Mar 2020 10:58:06 +0100
Received: by mail-qv1-f54.google.com with SMTP id q73so3088316qvq.2;
        Wed, 18 Mar 2020 02:58:06 -0700 (PDT)
X-Gm-Message-State: ANhLgQ18pB8WZ5jOIZgt+F7nFIVpXhT6/bBPJtRbaKXIeQiaD3U7Albs
        jvupJ2P5bBWzF7BJS8+QJHdCwqDZQeRrfFtuieo=
X-Google-Smtp-Source: ADFU+vsfP2+3J5IZG3GDZ8ki/QoOQxahTKkoibR7gSo+/zPormy/eHru0l6V82QxX1qv4IP7pL+fYEgyv9VIhLsC7RA=
X-Received: by 2002:ad4:52eb:: with SMTP id p11mr3061487qvu.211.1584525485127;
 Wed, 18 Mar 2020 02:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-5-git-send-email-mikelley@microsoft.com>
 <CAK8P3a2Hnm74aUMNFHbjMr4HwHGZn1+xa4ERsxAJY6hMzhEOhQ@mail.gmail.com>
 <632eb459dbe53a9b69df2a4f030a755b@kernel.org> <CAK8P3a3aihZeriUWAhWJMsOtdiY4Lo29syrRbB4Po3v4dsLhvA@mail.gmail.com>
 <MW2PR2101MB1052D91D3A9CEEBD7E2EA82FD7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB1052D91D3A9CEEBD7E2EA82FD7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 18 Mar 2020 10:57:49 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2AO4k3vJ7WuJQz7ick+XPgGY3Jfk8-ROqtwyNs0nWkDA@mail.gmail.com>
Message-ID: <CAK8P3a2AO4k3vJ7WuJQz7ick+XPgGY3Jfk8-ROqtwyNs0nWkDA@mail.gmail.com>
Subject: Re: [PATCH v6 04/10] arm64: hyperv: Add memory alloc/free functions
 for Hyper-V size pages
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Marc Zyngier <maz@kernel.org>, gregkh <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        Andy Whitcroft <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>, Jason Wang <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        KY Srinivasan <kys@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:pqRl6Fd4H0X9wVMXwi/c3cfJFZ6jZwBCNBV4LC0LkXVGuGch2Dw
 WaY/bblecKxR5AR9Ibk6xXDhMXsY0Ljj2j+dzkfhHMi9cDLz/U5AykDapmxtQiRJdLbFw/k
 GVOdfz8HRbDdrDTF+4vKvnNDdIEWUdG7ku9veMd38J0CBLOHqDLLWOn5y/TgzVKRcf36afp
 UckGxt6IWO3u8dIkqZBwA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:S6G9fCpXwOs=:8wpKXVScbYPC78iMCpyrOL
 /mby9ephqApkMTMroMDqsto+oI3n/Vij8tZnRN20Csw5MBBzejspORyRW4YCyyaUFdH+29UWO
 YKBi0dUOXJJDwDBUjacXTb1QkkSIC0U631DNNGkKsJdnFFJxdiaX61PcdgT1UCeZ6PzWVwpUD
 v7Wo0KFUKc5g+pdHWMY37jJQbL8k/21PoH7a0YxHlDF5m+sUJtFGaiaPSKBY1bZkgWvQdtSZN
 0l77iTkGK25Pvw2xEUG0qTmWBZX8DomX5UL4K6RoIrFCYyoKr6Pocq2V1DI50bbkqWcjD4VWn
 NcQCV2T9TKzpv1qMHWD7VWb88nWQzL76r3YxXwK99SyxxssHgc1S7japtXJ+eWYCjSnveUBvg
 LZG/p/Bdx5FfwlL8PsG7dGMV6xkLyrMU/mV0xi73bcpNStXZ1sLYN6g10pIkLbiylEMcwugS3
 uJi02POYGjl8CEbdVFG/IiHS0aZ2g0Ey8vAg4l3zpwwZinFWM4qcVMtp23UDc3wZALkiwRqQ1
 KydRYauRerJwGJoaVvyu9UDLeHqLIJlWx2UfYn+FgyaERBwHtFSCjVo5aALHgy/yn17zmkRLz
 GO65aC3utfjNMJ7fcpxrBiSG2hS5Tynq3AndznUvdBQqpqwnphtEMUQ4u88Mu2cYpUmJsr4ro
 9gDU6Giu1X7iqlnTqqDvwht2l2WIwirYJlJKYk4jBfu/GTZQx5NoUF3klIoZOoaaYwBQzP4zO
 kbeeMaf0AFjaMdSAqTXxY4kUG0jYEL/AG4Ws3xpIwQc2L221dcycMekdHBIspByjzVTV/m7ZQ
 a9dmRGH11PCQbMZeYZPScUZ9C+rgAxXxgeNNloFcvp8cZxOrQ0=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 18, 2020 at 1:15 AM Michael Kelley <mikelley@microsoft.com> wrote:
> From: Arnd Bergmann <arnd@arndb.de> Sent: Monday, March 16, 2020 1:33 AM
> >
> > On Mon, Mar 16, 2020 at 9:30 AM Marc Zyngier <maz@kernel.org> wrote:
> > > On 2020-03-16 08:22, Arnd Bergmann wrote:
> > > > On Sat, Mar 14, 2020 at 4:36 PM Michael Kelley <mikelley@microsoft.com>
> > > > wrote:
> > > >>  /*
> > > >> + * Functions for allocating and freeing memory with size and
> > > >> + * alignment HV_HYP_PAGE_SIZE. These functions are needed because
> > > >> + * the guest page size may not be the same as the Hyper-V page
> > > >> + * size. We depend upon kmalloc() aligning power-of-two size
> > > >> + * allocations to the allocation size boundary, so that the
> > > >> + * allocated memory appears to Hyper-V as a page of the size
> > > >> + * it expects.
> > > >> + *
> > > >> + * These functions are used by arm64 specific code as well as
> > > >> + * arch independent Hyper-V drivers.
> > > >> + */
> > > >> +
> > > >> +void *hv_alloc_hyperv_page(void)
> > > >> +{
> > > >> +       BUILD_BUG_ON(PAGE_SIZE <  HV_HYP_PAGE_SIZE);
> > > >> +       return kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
> > > >> +}
> > > >> +EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
> > > >
> > > > I don't think there is any guarantee that kmalloc() returns
> > > > page-aligned
> > > > allocations in general.
> > >
> > > I believe that guarantee came with 59bb47985c1db ("mm, sl[aou]b:
> > > guarantee
> > > natural alignment for kmalloc(power-of-two)").
> > >
> > > > How about using get_free_pages() to implement this?
> > >
> > > This would certainly work, at the expense of a lot of wasted memory when
> > > PAGE_SIZE isn't 4k.
> >
> > I'm sure this is the least of your problems when the guest runs with
> > a large base page size, you've already wasted most of your memory
> > otherwise then.
> >
>
> I think there's value in keeping these functions.  There are 8 uses in
> architecture independent code at the moment, which admittedly saves
> only ~1/2 Mbyte of memory with a 64K page size, but we will have
> additional uses with more memory savings as we get all of the
> Hyper-V synthetic drivers to work with 64K page size.  Furthermore,
> there's coming work that will require additional steps to share a page
> between a guest and the Hyper-V host.  These functions are the right
> place to put the code for the additional sharing steps.  Removing them
> now in favor of a bare kmalloc() and then adding them back doesn't
> seem worthwhile.

My point was to keep the functions but use alloc_pages() internally,
so you can deal with the hypervisor having a larger page size than
the guest, which seems to be a more important scenario if I correctly
understand the differences between the way Windows and Linux
deal with page cache.

As far as I understand, using 64kb pages on Windows is generally
a win as the VFS code already deals with units of that size, while
on Linux the 4kb page size is too deeply entrenched within the
file system code to mess with it: Whatever you gain in terms of
TLB pressure on workloads that cannot use huge pages is all lost
again through extra I/O and wasted physical memory.

        Arnd
