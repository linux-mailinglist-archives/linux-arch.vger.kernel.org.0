Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4AA1898F6
	for <lists+linux-arch@lfdr.de>; Wed, 18 Mar 2020 11:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbgCRKK2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Mar 2020 06:10:28 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:57155 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgCRKK1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Mar 2020 06:10:27 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MfYDO-1jlMQi0Qg4-00fxps; Wed, 18 Mar 2020 11:10:24 +0100
Received: by mail-qk1-f173.google.com with SMTP id h14so37696429qke.5;
        Wed, 18 Mar 2020 03:10:23 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3gSZgWkdJWHoe5WeZY5cW3/nvNMwgMzj5hms8APhafXakm590l
        9NJGnWJhwlf82cGKUu9D65XKxdX7Vl3aaBMUyyo=
X-Google-Smtp-Source: ADFU+vvAakuOMd3ErCSUomMX8z0py4x5kF0p1NXkPKJUf0Yfay59WpIhVqcU89UsHhxlAYx4b/h6YAwzOwru6S0xj2Q=
X-Received: by 2002:a37:6455:: with SMTP id y82mr3173930qkb.286.1584526222619;
 Wed, 18 Mar 2020 03:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-2-git-send-email-mikelley@microsoft.com>
 <CAK8P3a1GFDUY4mXzst4Ds+S-4SGXso6-jfpsYyy-eHyceAC1Zg@mail.gmail.com> <MW2PR2101MB10524879CD685710A51AB740D7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB10524879CD685710A51AB740D7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 18 Mar 2020 11:10:06 +0100
X-Gmail-Original-Message-ID: <CAK8P3a02EULGxyuKFq8YnbG8BQ_m-RKciaNEc9ZbdP2yz9dt+Q@mail.gmail.com>
Message-ID: <CAK8P3a02EULGxyuKFq8YnbG8BQ_m-RKciaNEc9ZbdP2yz9dt+Q@mail.gmail.com>
Subject: Re: [PATCH v6 01/10] arm64: hyperv: Add core Hyper-V include files
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        gregkh <gregkh@linuxfoundation.org>,
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
X-Provags-ID: V03:K1:smUb2w4heNdSNB9yZ7n4eJSJIj6+13Vm+vxn/gMm+oubjVt2Lco
 t8yfV/Ua7OQdDkxM7g3doew78zjj7ezzCeYrKRQq/mroH4od0IXyB1IdDIo+PTu94Sn+UOK
 mK3mx6EplklCazvbzSQW6nJwYey6gq+cQ0XWbZxZ5D3OAJmUxiqLaIK4K/WRYbgyH2sn8tq
 TGfToRBZx6AAlkPN5T+Ng==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zssKbvN/uHk=:jBOpXsKPnuklkLOyBfwouw
 0cLBo+4jc+SDTrVRt0sQZkDldoP8lRoj12f9Ov0RJ8v/gU21hdbXpWaGYHRY3yqvMrDAx6VvI
 JKJHdu+gCG/b2SwxARWLawNOqKFpqEKkhEGa+ixW//T5D0hE7L49ciubbucsUNAavij0/+K3N
 RM4PoAXhqlWU3mbwTbPhTtviaVkyg58dEoK8hV4k4UvoTy4512AGrKKPTpf+nFN663V3e7d4B
 Za4fwWotIYQgZsPU25u+YUpOrhuBQmEwURv8JQhnI8EwDuZgP0I2F0qNrh2sjs1DgNT3C7PUc
 RCMAPUPD8h/eUGKl9vM1ULsq+8CO8NNmt6MZTdrTZIbvQw0UBazlXScKq9kMriBkSZZGHK7gA
 TnlyeynkGylrq6SSucAZwszmIsyqCTolyn4ScYCgfMI4C3tUORVM/E+jhte2MG3HOG0D3CZKO
 TAYFLCGpz39POJTAQ9FQGam6gQpysbbN6MA/9r6s4wBxV8g3xZedmUua+w011fOxeBKEAQX3v
 d3gCZs3eBLcVfSVWB9X5BlG5F3x1D5HmYND2iYVSokNs9fveBTVFIoQjR/xD1v7lghJAbNNtb
 CXd7JrcUFIQaDJ8nuTevvoatIrircKhEtk3Wnd4mu6a79DODD9VrntsT9u6bx62EaKCuvJofo
 iiE0vjgUvyrYL+JP4Nkj5AmvIwkJID5at4RP4ZtCBnDkETtUhNrhEQz/d+gbrzzD06OdqJ7Re
 KDdo+OvgT5Hi46VmnA/+aCqr7OvBbhxaB0IiltQyy5ihG/XVib6QEiHRYWTP8FmJAqIXck4FG
 EsIP+Jqfnuw4KCDdli1myGaGs9CtqR/L3j+bbSUwKsp+7VPuv8=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 18, 2020 at 1:12 AM Michael Kelley <mikelley@microsoft.com> wrote:
> From: Arnd Bergmann <arnd@arndb.de> Sent: Monday, March 16, 2020 1:48 AM
> > On Sat, Mar 14, 2020 at 4:36 PM Michael Kelley <mikelley@microsoft.com> wrote:
> >
> > > +
> > > +/* Define input and output layout for Get VP Register hypercall */
> > > +struct hv_get_vp_register_input {
> > > +       u64 partitionid;
> > > +       u32 vpindex;
> > > +       u8  inputvtl;
> > > +       u8  padding[3];
> > > +       u32 name0;
> > > +       u32 name1;
> > > +} __packed;
> >
> > Are you sure these need to be made byte-aligned according to the
> > specification? If the structure itself is aligned to 64 bit, better mark only
> > the individual fields that are misaligned as __packed.
> >
> > If the structure is aligned to only 32-bit addresses instead of
> > 64-bit, mark it as "__packed __aligned(4)" to let the compiler
> > generate better code for accessing it.
>
> None of the fields are misaligned and it will always be aligned to 64-bit
> addresses, so there should be no padding needed or added.  There was
> a discussion of __packed and the Hyper-V data structures in general on
> LKML here:  https://lkml.org/lkml/2018/11/30/848.  Adding __packed was
> done as a preventative measure, not because anything was actually
> broken.  Marking as __aligned(8) here would indicate the correct intent,
> though the use of the structure always ensures 64-bit alignment.

Just drop the __packed annotations then, they just confuse the compiler
in this case. In particular, when the compiler thinks that a structure is
misaligned, it tries to avoid using load/store instructions on it that are
inefficient or trap with misaligned code, so having default alignment
produces better object code.

> > Also, in order to write portable code, it would be helpful to mark
> > all the fields as explicitly little-endian, and use __le32_to_cpu()
> > etc for accessing them.
>
> There's an opening comment in this file stating that all data
> structures shared between Hyper-V and a guest VM are little
> endian.  Is there some other marking to consider using?

Yes, device drivers should generally define data structures using
the __le32, __le64 etc types, and use the conversion functions
to access them. Building with 'make C=1' usually tells you when
you have mismatched annotations.

> We have definitely not allowed for the case of Hyper-V running on
> a big endian architecture.  There are a *lot* of messages and data
> structures passed between the guest and Hyper-V, and coding
> to handle either endianness is a big project.  I'm doubtful
> of the value until and unless we actually have a need for it.

In general, the use of big-endian software on Linux is declining, however

- arm64 as an architecture is meant to support both endian types,
  and we still try to ensure it works either way as long as there are
  users that depend on it.

- The remaining users of big-endian software are probably
  more likely to run on virtual machines than on real hardware

- Any device driver should generally be written against portable
  interfaces, even if you think you know how it will be used. As
  driver writers tend to look at existing code for new drivers, it's
  better to have them all be portable. (This is a similar argument
  to the irqchip interface).

Even if you don't convert any of the existing architecture independent
code to run both ways, I see no reason to not do it for new drivers.

> > > +/* Define synthetic interrupt controller message flags. */
> > > +union hv_message_flags {
> > > +       __u8 asu8;
> > > +       struct {
> > > +               __u8 msg_pending:1;
> > > +               __u8 reserved:7;
> > > +       } __packed;
> > > +};
> >
> > For similar reasons, please avoid bit fields and just use a
> > bit mask on the first member of the union.
>
> Unfortunately, changing to a bit mask ripples into
> architecture independent code and into the x86
> implementation.  I'd prefer not to drag that complexity
> into this patch set.

How so? If this file is arm64 specific, there should be no need to make
x86 do the same change.

> > > + * Use the Hyper-V provided stimer0 as the timer that is made
> > > + * available to the architecture independent Hyper-V drivers.
> > > + */
> > > +#define hv_init_timer(timer, tick) \
> > > +               hv_set_vpreg(HV_REGISTER_STIMER0_COUNT + (2*timer), tick)
> > > +#define hv_init_timer_config(timer, val) \
> > > +               hv_set_vpreg(HV_REGISTER_STIMER0_CONFIG + (2*timer), val)
> > > +#define hv_get_current_tick(tick) \
> > > +               (tick = hv_get_vpreg(HV_REGISTER_TIME_REFCOUNT))
> >
> > In general, we prefer inline functions over macros in header files.
>
> I can change the "set" calls to inline functions.  As you can see, the "get"
> functions are coded and used in architecture independent code and on
> the x86 side in a way that won't convert to inline functions.

Ok.

        Arnd
