Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99D161897E2
	for <lists+linux-arch@lfdr.de>; Wed, 18 Mar 2020 10:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgCRJ1M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Mar 2020 05:27:12 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:45273 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbgCRJ1M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Mar 2020 05:27:12 -0400
Received: from mail-qv1-f52.google.com ([209.85.219.52]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MKbc4-1j07t41OrU-00L17b; Wed, 18 Mar 2020 10:27:10 +0100
Received: by mail-qv1-f52.google.com with SMTP id q73so3052817qvq.2;
        Wed, 18 Mar 2020 02:27:09 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3RjbbUDjhwv0qAy37qLDbu4U/HkMOQO3PlT+TfwUO75OjzkFna
        3poEfz8B9wodc2xeFJNrhsdhI07NU+nWGcA8Kv0=
X-Google-Smtp-Source: ADFU+vt7gawMELH51e53V+lfgh4tcfw+GTIfcD3E5r0fL6EUTEgpPXQEXZxqtN5P7/SqAe4TJoaZf/SOj1Csy9P5qbQ=
X-Received: by 2002:a0c:a602:: with SMTP id s2mr3278276qva.222.1584523628935;
 Wed, 18 Mar 2020 02:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-10-git-send-email-mikelley@microsoft.com>
 <CAK8P3a1YUjhaVUmjVC2pCoTTBTU408iN44Q=QZ0RDz8rmzJisQ@mail.gmail.com> <MW2PR2101MB10524254D2FE3EFC72329465D7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB10524254D2FE3EFC72329465D7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 18 Mar 2020 10:26:52 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1YCtc3LJ-_3iT90_Srehb96gLHvTXsbJ0wT6NFYCG=TQ@mail.gmail.com>
Message-ID: <CAK8P3a1YCtc3LJ-_3iT90_Srehb96gLHvTXsbJ0wT6NFYCG=TQ@mail.gmail.com>
Subject: Re: [PATCH v6 09/10] arm64: efi: Export screen_info
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
X-Provags-ID: V03:K1:bY4eEKG4UHYos/scM4jTadQCtBvU2fp8j3wO3vu0V3KQYbxBoFz
 /hhqWVjTyEphKIB7oDVFcWbNO/vulQGgEUjmXc0Pwhdf3L2dz5qhz4EWgu1MMkIp7vr8JVn
 WWov+w9oLuaD5VJW2awkfMzePjDAD049OSZyok51d1/AYw1Q85o++lNXVLd6WB1qlG7wwvJ
 TbMcXwYPzG1wMEQTeGMSw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+uHVysZQnsI=:zO4Ahm4qYxwLZrOHu5D8mu
 foizfJqelS4Exx0HET32VmU1liLAZO0X28PTNbHyN8WUYADoUYPPNw2vDUdvcY3ErC4viNrtD
 sUL9vcAZSJa2mUPXw1t2+2v2iKQLMYqzmS4cpFVOyXBOvAby89dEx4tv96Ziahw5zGyXprOLj
 4nz4MfqfRc7k13q5mdv5SrZPO5bXUKL0QVfBNUVXv3HO1njNJBGBim6jQNW0aXir8ub4LS1HQ
 eAchZPqKrun520NICYr844nZkeMl3OqwA3X6l20uA4nWEapE80cLspmgRI97yzwDILwVWkDjX
 k6kS1N2HcgekiXH3h2W4pmz6pGjM2bJo0B1gL/vBzPjvwCdzsaNxcfQTUj+xQwb5U3djopJwg
 AZ7lCG+g6yoO6tLaGUMXzUtJ2yKmh7WaLiLt1h3EhAdxtb9QkfovOPXQJ+K8gfIKzcqerIKqa
 gwcob0OV2CiLLcWNu2T4Y/9eLsBEX5tpVAt3TCDTHzD1mwliWePr5mxL7P2DxL6lIb6qOBkXm
 jmdQqNcYlB4Yeeu6rbN9ikIJxNna09hewHwoJTlTqzcecwEqu7MaAQWgT/DVajtq4ZQysujrn
 440Q3oZYg5a2Q9S+isCFqJT6SKJd0ZenY50HO4FuobyObzPRjqCGaqFlkZ6iHMk17zNqzKIaE
 /6R3JakpWJezdnQ5XNCRQ9VogZ9A59Bb3xgmMmjh66ao4DrDXGpxF0UiUP4WvpKigvRBIwMTv
 v5gF8Co+6V0Wl7dWh8nDqZNZ6SCZGwa44tNZrch/l6tMIr8yWgSHeQWDFRvv+2DWWxDzPegd4
 Eqv7fcUsQbO9FyOy5Wyhg33ThQSidlO+UFSulM7/BiaX6kUa3Y=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 18, 2020 at 1:18 AM Michael Kelley <mikelley@microsoft.com> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> > On Sat, Mar 14, 2020 at 4:36 PM Michael Kelley <mikelley@microsoft.com> wrote:
> > >
> > > The Hyper-V frame buffer driver may be built as a module, and
> > > it needs access to screen_info. So export screen_info.
> > >
> > > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> >
> > Is there any chance of using a more modern KMS based driver for the screen
> > than the old fbdev subsystem? I had hoped to one day completely remove
> > support for the old CONFIG_VIDEO_FBDEV and screen_info from modern
> > architectures.
> >
>
> The current hyperv_fb.c driver is all we have today for the synthetic Hyper-V
> frame buffer device.  That driver builds and runs on both ARM64 and x86.
>
> I'm not knowledgeable about video/graphics drivers, but when you
> say "a more modern KMS based driver", are you meaning one based on
> DRM & KMS?  Does DRM make sense for a "dumb" frame buffer device?
> Are there any drivers that would be a good pattern to look at?

It used to be a lot harder to write a DRM driver compared to an fbdev
driver, but this has changed to the opposite over the years.

A fairly minimal example would be drivers/gpu/drm/pl111/pl111_drv.c
or anything in drivers/gpu/drm/tiny/, but you may want to look at the
other hypervisor platforms first, i.e drivers/gpu/drm/virtio/virtgpu_drv.c,
drivers/gpu/drm/vmwgfx/vmwgfx_drv.c, drivers/gpu/drm/xen/xen_drm_front.c,
drivers/gpu/drm/qxl/qxl_drv.c, and drivers/gpu/drm/bochs/bochs_drv.c.

       Arnd
