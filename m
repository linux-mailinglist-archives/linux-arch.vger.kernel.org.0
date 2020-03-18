Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 982C918983D
	for <lists+linux-arch@lfdr.de>; Wed, 18 Mar 2020 10:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbgCRJoh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Mar 2020 05:44:37 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:50683 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbgCRJof (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Mar 2020 05:44:35 -0400
Received: from mail-qv1-f47.google.com ([209.85.219.47]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M4384-1jEVFZ3cIa-0001zM; Wed, 18 Mar 2020 10:44:34 +0100
Received: by mail-qv1-f47.google.com with SMTP id c28so12488183qvb.10;
        Wed, 18 Mar 2020 02:44:33 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3GZP4gwGrp0jv80nuEkZsnCwKOUNqkmTyg2h6nDN97CyC/JsMj
        pmtvgEixg+WwyE6PCmX264CD/sKCuKgK3qneKeg=
X-Google-Smtp-Source: ADFU+vtLo+GOWNxMC15V2TiH90BEPvu2JmMbmtc3AvFP8wu5z0vI2xAgHqQbsb7yudqWQcePXGno6172j7v0a1xP4uw=
X-Received: by 2002:a0c:a602:: with SMTP id s2mr3333321qva.222.1584524672422;
 Wed, 18 Mar 2020 02:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-8-git-send-email-mikelley@microsoft.com>
 <CAK8P3a0+uBsurfQ4smjPDGkJQSkMe-TxJ4cWR_EZXgDR4-bAWQ@mail.gmail.com> <MW2PR2101MB1052281E5B197F2AA8E4D622D7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB1052281E5B197F2AA8E4D622D7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 18 Mar 2020 10:44:16 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2fzFdXoMKz_-Bryq0HUar=Tgs7SwJL4JFw2_KjzpOPdg@mail.gmail.com>
Message-ID: <CAK8P3a2fzFdXoMKz_-Bryq0HUar=Tgs7SwJL4JFw2_KjzpOPdg@mail.gmail.com>
Subject: Re: [PATCH v6 07/10] arm64: hyperv: Initialize hypervisor on boot
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
        Boqun Feng <boqun.feng@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Y3E7GFMtxfMb4EWglKwosVf4WGrTPZmdppd+xcndfUIFF7m/2CG
 CP4uWgt+ndLbEEWtP0dqLUntzwuskkrezbWXa0Fe/oTAPnYP2+gfDTr4zjvYdWJvs+9fM30
 pALwNEe4JkxgcRds2+Ct7XHtoQhVyroKYV+eMKgsy55/unt3SmeuyK5BHuqfBMld4BuJW9v
 7Y/gnzAtlTw2pzgEWMpIQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:puLlbryp3kc=:ygU3UUZExT6qMfUKNNbQ/1
 85Lh5A5GfrhtCYzNZbz7OztgiSskM+cAg+CViARiGyEAChaR9i4hoHOC9pNLWB9nf/LaqU5zM
 m/XTBms0xLEjMikmtAzdqYFYmanEmUM7EVpP90IiTiE+dr6n110NeRQ2kbb2CpbC6UTnp9fis
 4QdftzV3l1SrmImh+tYGjK8jqWqUSgWmUiuc7c3o+dHY9F1XFvxEAAsm89iK49VyXnC3XoHGM
 bLQSUn89idCgzqTbiNFFIow0bALmouXm7zrkcHV+cqp0CaicaXtFGKSn1YZcCho36/3iDrP43
 ajpXprl333XxkyGvPa+4plQpnIITxxHYVMuIQBR9o0CxyRs67Fl15VmhRjcgDOfns6DVQiboo
 WZ63S60MZ9VsDCdZOdZi6rtGSxWnWIXG0PcknA1i6pPvlg3EEYpGj1sqTDhDctLrDaapYeeaM
 HBP4ByMaKnkeR/BxZI6afG+S9sFOhzSsr3kbwycOu01qFnbc1vbF7g0ldFMc3tdBObUlWrntO
 WSKvT/4IdMKTJ24PyElsK0+9s+3hkHniApxG8Gn4PnpkBLLXLpnps50UWrmYqCM1mHafkb2wp
 6hEym/m1tNFQbrRuOK3Krr4H7WaL8h/9LpiAeG35cpzc7lon0Z/zvOc8vwqjNj1VDbvjkmhhE
 FE7mcLe5gJDLNtxTgs0C8rCdj0b7Y8SSb0f3HHfg5jmxo2jM1R7PeJDqPj4kms6/GhG8nJCC+
 dKeqMTGFREwQWwJofd/A/bvXlqqxz+4f4EWr+u1YEEQZ3HsLyltuTUMJv+F+GMpGF63UNt3yi
 m91v7PmAaN4D+wrwG4nKNL9jY8+CWKPiGKntIBzoawA/7gAOWE=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 18, 2020 at 1:18 AM Michael Kelley <mikelley@microsoft.com> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de> Sent: Monday, March 16, 2020 1:30 AM
> >
> > As you are effectively adding a new clocksource driver here, please move the
> > code to drivers/clocksource and send the patch to the respective maintainers
> > (added to Cc here), splitting it out from the rest of the patch.
> >
> > You should also describe why your platform doesn't just use the normal
> > architected timer interface.
> >
> > > +TIMER_ACPI_DECLARE(hyperv, ACPI_SIG_GTDT, hyperv_init);
> >
> > This looks like it registers a driver for the same device as the normal
> > arch timer. Won't that clash?
>
> There is a Hyper-V clocksource driver in drivers/clocksource/hyperv_timer.c.
> It is architecture independent and works for both x86 and ARM64.
>
> The requirement here is really for a place to hang the general Hyper-V
> initialization code.   On the x86 side, there's infrastructure already in place
> to do hypervisor initialization, but nothing corresponding on the ARM64 side.
> The TIMER_ACPI_DECLARE hook is admittedly a temporary approach, and I'm
> happy to hear if someone has a better way to handle this.
>
> FWIW, Hyper-V doesn't currently virtualize the ARM arch counter/timer for
> guest VMs.  The Hyper-V synthetic counter/timer in the Hyper-V clocksource
> driver is used on both ARM64 and x86.  But this Hyper-V init code doesn't actually
> touch the GTDT device, so it won't interfere with the ARM arch counter/timer
> when a future Hyper-V version does virtualize it.

I don't have a good idea to solve it, just a few more thoughts:

- if your platform does not actually provide the generic timer, then the
  ACPI tables should not list one either. Instead, create a separate
  description for your custom timer, and have that added to the ACPI
  spec.

- To treat the timer more like a normal driver, better have the
   TIMER_ACPI_DECLARE() function live only in the driver itself,
   and use an early initcall (arch_initcall, subsys_initcall, etc)
   it initialize the rest as late as you can.

- Some of the other code added to arch/arm64/ might be able to
  live in drivers/virt/hyperv in order to be shared between x86 and
  arm64. (No idea how much of it there is).

       Arnd
