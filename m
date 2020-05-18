Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78511D78FB
	for <lists+linux-arch@lfdr.de>; Mon, 18 May 2020 14:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgERMvY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 May 2020 08:51:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgERMvY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 May 2020 08:51:24 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19158207D8;
        Mon, 18 May 2020 12:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589806283;
        bh=59VoFxWg86wvMXwZUsJGWlhU4ZYA2YVdpnEWpzS7DZE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TRlQTwf11+v0bpjUNl2t5dPXV5ZIgFjYItuEHgPDLLWI8nX/b3fI1Gf9oXF2MEkY+
         ag3gxxuz76Dqxvfrl2+KlKkbDYuLczLDqjJr4Jr/MylKyy2pqFx2xqJ5fah7iXpxfv
         0CUSaHum5Oyo+Swa4XBHPXOioS47ylD1QP5MYOTg=
Received: by mail-io1-f44.google.com with SMTP id h10so10376232iob.10;
        Mon, 18 May 2020 05:51:23 -0700 (PDT)
X-Gm-Message-State: AOAM533kr8lVGMOlORWinukcrczWUHssUmdNBL5hHoMKBtqyNzGFur/Q
        fdPYRdcAKX0Yo9N4/h56FVXHLNjJgB8owra7InY=
X-Google-Smtp-Source: ABdhPJz9/6CkchQipSV8AM+pHvWaEqOIHqsO5Jiu/QyHeKgC98RsdhCrUuUpwXRVK59Pi3qeDsED7Bv2BcEqy1sJsHA=
X-Received: by 2002:a5e:8705:: with SMTP id y5mr14514218ioj.142.1589806282417;
 Mon, 18 May 2020 05:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-10-git-send-email-mikelley@microsoft.com>
 <CAK8P3a1YUjhaVUmjVC2pCoTTBTU408iN44Q=QZ0RDz8rmzJisQ@mail.gmail.com>
 <MW2PR2101MB10524254D2FE3EFC72329465D7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <CAK8P3a1YCtc3LJ-_3iT90_Srehb96gLHvTXsbJ0wT6NFYCG=TQ@mail.gmail.com>
 <MW2PR2101MB1052E413218D295EF24E5E05D7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <f2b63853-24ae-d6b7-cd43-5792c0d4d31b@nvidia.com> <4202ea20-6e51-31d3-44b1-3861798a8158@nvidia.com>
In-Reply-To: <4202ea20-6e51-31d3-44b1-3861798a8158@nvidia.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 18 May 2020 14:51:11 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEpryfqk5eKxB5NrDcriEBRQKEHnDVZNBMfB4DY=708fw@mail.gmail.com>
Message-ID: <CAMj1kXEpryfqk5eKxB5NrDcriEBRQKEHnDVZNBMfB4DY=708fw@mail.gmail.com>
Subject: Re: [PATCH v6 09/10] arm64: efi: Export screen_info
To:     Nikhil Mahale <nmahale@nvidia.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
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
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 18 May 2020 at 06:25, Nikhil Mahale <nmahale@nvidia.com> wrote:
>
> On 5/13/20 7:56 PM, Nikhil Mahale wrote:
> > On 3/20/20 3:16 AM, Michael Kelley wrote:
> >> From: Arnd Bergmann <arnd@arndb.de> Sent: Wednesday, March 18, 2020 2:27 AM
> >>>
> >>> On Wed, Mar 18, 2020 at 1:18 AM Michael Kelley <mikelley@microsoft.com> wrote:
> >>>> From: Arnd Bergmann <arnd@arndb.de>
> >>>>> On Sat, Mar 14, 2020 at 4:36 PM Michael Kelley <mikelley@microsoft.com> wrote:
> >>>>>>
> >>>>>> The Hyper-V frame buffer driver may be built as a module, and
> >>>>>> it needs access to screen_info. So export screen_info.
> >>>>>>
> >>>>>> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> >>>>>
> >>>>> Is there any chance of using a more modern KMS based driver for the screen
> >>>>> than the old fbdev subsystem? I had hoped to one day completely remove
> >>>>> support for the old CONFIG_VIDEO_FBDEV and screen_info from modern
> >>>>> architectures.
> >>>>>
> >>>>
> >>>> The current hyperv_fb.c driver is all we have today for the synthetic Hyper-V
> >>>> frame buffer device.  That driver builds and runs on both ARM64 and x86.
> >>>>
> >>>> I'm not knowledgeable about video/graphics drivers, but when you
> >>>> say "a more modern KMS based driver", are you meaning one based on
> >>>> DRM & KMS?  Does DRM make sense for a "dumb" frame buffer device?
> >>>> Are there any drivers that would be a good pattern to look at?
> >>>
> >>> It used to be a lot harder to write a DRM driver compared to an fbdev
> >>> driver, but this has changed to the opposite over the years.
> >>>
> >>> A fairly minimal example would be drivers/gpu/drm/pl111/pl111_drv.c
> >>> or anything in drivers/gpu/drm/tiny/, but you may want to look at the
> >>> other hypervisor platforms first, i.e drivers/gpu/drm/virtio/virtgpu_drv.c,
> >>> drivers/gpu/drm/vmwgfx/vmwgfx_drv.c, drivers/gpu/drm/xen/xen_drm_front.c,
> >>> drivers/gpu/drm/qxl/qxl_drv.c, and drivers/gpu/drm/bochs/bochs_drv.c.
> >>>
> >>
> >> Thanks for the pointers, especially for the other hypervisors.
> >>
> > Sorry if anybody in 'to' or 'cc' is receiving this reply multiple times.
> > I had configured by email client incorrectly to reply.
> >
> > screen_info is still useful with a modern KMS-based driver.  It exposes
> > the mode parameters that the GOP driver chose.  This information is
> > needed to implement seamless or glitchless boot, by both ensuring that
> > the scanout parameters don't change and being able to read back the
> > scanout image to populate the initial contents of the new surface.
> >
> > This works today on arches which implement (U)EFI and export
> > screen_info, including x86 and powerpc, but doesn't work on arm or
> > arm64.  As arm64 systems that implement UEFI with real GOP drivers
> > become more prevalent, it would be nice to be have these features there
> > as well.
>
> In addition to this, even if a driver doesn't implement a framebuffer
> console, or if it does but has an option to disable it, the driver still
> needs to know whether the EFI console is using resources on the GPU so
> it can avoid clobbering them. For example screen_info provides information
> like offset and size of EFI console, using this information driver can
> reserve memory used by console and prevent corruption on it.
>
> I think arm64 should export screen_info.
>

If there are reasons why KMS or fbdev drivers may need to access the
information in screen_info, it should be exported. I don't think that
is under debate here.
