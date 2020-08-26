Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E00252854
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 09:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgHZHTS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 03:19:18 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:53245 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgHZHTM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 03:19:12 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N8XLj-1kgAEZ2Vxx-014RA6; Wed, 26 Aug 2020 09:19:10 +0200
Received: by mail-qt1-f178.google.com with SMTP id p36so696958qtd.12;
        Wed, 26 Aug 2020 00:19:10 -0700 (PDT)
X-Gm-Message-State: AOAM533otbBT+1FDrSRwvz7Y7vZ+GY6/CGfE/HFvIQKMGPGWfVft24t1
        MZ2DCoTJw3PV7r9j+G2Y3zqdW6Ihui9/7puns/4=
X-Google-Smtp-Source: ABdhPJy5+Pw3cdGpC8Q6lMpkiPFPkzeHlCi3MRPq3Igp7X2iV4AcClzQkt1xJ/kMgSeokHBcS7+FuRVgiX+xM5QVGLc=
X-Received: by 2002:ac8:4652:: with SMTP id f18mr12561128qto.142.1598426349178;
 Wed, 26 Aug 2020 00:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <1598287583-71762-1-git-send-email-mikelley@microsoft.com>
 <1598287583-71762-8-git-send-email-mikelley@microsoft.com>
 <CAK8P3a1NXVJON+apBZeVDdx_bqQmenab8srqJDWS_VFVpAncRA@mail.gmail.com> <MW2PR2101MB1052AD42CC4F9A71F87EFE95D7570@MW2PR2101MB1052.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB1052AD42CC4F9A71F87EFE95D7570@MW2PR2101MB1052.namprd21.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 26 Aug 2020 09:18:53 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3fzXuyamf=sokW59=Ln-ULBBGaSHxKwUeqxT_4sNrQqw@mail.gmail.com>
Message-ID: <CAK8P3a3fzXuyamf=sokW59=Ln-ULBBGaSHxKwUeqxT_4sNrQqw@mail.gmail.com>
Subject: Re: [PATCH v7 07/10] arm64: hyperv: Initialize hypervisor on boot
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Mark.Rutland@arm.com" <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        gregkh <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:65Evus5OXX7pf1ZayKDZMzlfDj3azEij/JtxW0/w1BmxCL0q69d
 4icpFl1nuXRnjYL2OTsXz7uzqY44dVPZtI5sQUJYc9k5ValxBbw7nxts19K1sokrbaOC02K
 VpISE+98YncBQbbWjaBD5yuK9d2cp6RIybUFfOSV3Hi82GqZe7okaBmzqRcqA6wT8UXGA1j
 fPC8GwM37cYCBIzxQGxzQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nWKx0foQu/g=:cRHTW84q8SmQR80a+VBtT/
 2z0b38SfKjlkje1F/JUIwBZOtPEshpQnl+cs4zTJiXhgYz+kQoYI5cxgMsRGygMePld7UO40y
 VeqZdcmYXrVOXaYtfWci1ZKfxEY0nzmdmHbWGmqF0CfwX/P7j3dg+F27V9yQDJaQu8GlH0Fui
 63PO9vGwn6HSoOYi653wfrTSjqqLmEOKmW731q2GQndpvaJ2LL/RobVxuZrma8MQuGsCaITJp
 nz8sRFrnqGC/JyMNRTohpNmJrIDfG4qiJujya09GceRE4KuT5+wWiwDpOcR7LqePzYfzUhsvW
 Lu02GwBy9sdoDbIYZ1yXnxJMBXMS7vIjs9LB9erL1c+U7cPrvT2cr8KmQ6t8abEmCWQlzP7Os
 qOjUMTL8hLugDbFhvoJz+ismAnpUcfXonLucJ3ybJyb4/un6dUdktjQMfI7xy7d5joHrHZ3O4
 /Fe9t84vCp1cL/YrNsqcCtKnx/MfwATqdtjZyONnqan4IvnsDecuKlhNKC082ROFCKlomiGq3
 jodwVY6ZtFIHfA53gPCK0EjsgAWMtNAjusiJTMn0NW3nilZ4bE+OTbLcOfo6UUpKsvuMUCeLv
 NX6F4V8awdH4qFS55Odp+Awzm3gP2VcnK5FjiarPPlTYUxhj+prxOiZ2k/rygUV3GgRq7wKHL
 QwVmj6b+YXrVL9M7r2NVOc+KPzkQLy0ZobZJFWHf4MNtRUpzZMJ8f0mrm1cR+N6lxV6VHvKAQ
 0ychjMRfxN3lxiCx4DOgKhTD6mn4t4B/aX9nm95wNOLPndI5UYKDxjI1itAmY9oNp2gQMysk4
 1+XA0qKvLGE7EJCIEZ1fTBbWb44Ai1p5YUWQplN4/w+t3pjXa2whWPKWXic0dUbWdluUCwzH5
 w3DEk2VoBUwDWyNu1BYSRQxLTNiZnECn0L0JnzSwXtKIUVy56jKq4lJEf8bHByyLCnSrOTNyP
 AWTjXO2aCPXmaJ6Y2Fsdx9ohQyyK2mP32wUHqdY16TtG4vAoYyLcC
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 25, 2020 at 11:20 PM Michael Kelley <mikelley@microsoft.com> wrote:
> From: Arnd Bergmann <arnd@arndb.de> Sent: Monday, August 24, 2020 11:34 AM
> > On Mon, Aug 24, 2020 at 6:48 PM Michael Kelley <mikelley@microsoft.com> wrote:
> >
> > I think this has come up before, and I still don't consider it an acceptable
> > hack to hook platform initialization code into the timer code.
> >
> > Please split out the timer into a standalone driver in drivers/clocksource
> > that can get reviewed by the clocksource maintainers.
>
> I see two related topics here.

Agreed

>  First, the Hyper-V clocksource driver is
> drivers/clocksource/hyperv_timer.c.  The code is architecture independent
> and is used today on the x86 side and for ARM64 in this patch series.  A few
> architecture specific calls are satisfied by code under arch/x86, and in this
> patch series, under arch/arm64.  Is there some aspect of this driver that
> needs reconsideration?  I just want to make sure to understand what you
> are getting at.

For the clocksource driver, I would like to see the arm64 specific bits
(the code you add in arch/arm64 that are only relevant to this driver)
moved out of arch/arm64 and into drivers/clocksource, in whatever
form the clocksource maintainers prefer. I would suggest having a
separate file that can get linked along with the architecture-independent
part of that driver.

> Second is the question of where/how to do Hyper-V specific initialization.
> I agree that hanging it off the timer initialization isn't a great approach.
> Should I add a Hyper-V specific initialization call at the appropriate point
> in the ARM64 init sequence?  The x86 side has some structure for handling
> multiple hypervisors, and the Hyper-V initialization code naturally plugs into
> that structure.  I'm certainly open to suggestions on the best way to handle
> it for ARM64.

Yes, that is where I was getting at. Maybe the x86 abstraction for handling
multiple hypervisors can be lifted out of arch/x86/ into common code?

       Arnd
