Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08A0D18668C
	for <lists+linux-arch@lfdr.de>; Mon, 16 Mar 2020 09:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbgCPIcy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Mar 2020 04:32:54 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:45621 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729978AbgCPIcy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Mar 2020 04:32:54 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MCsHm-1j4vTQ08rg-008ptg; Mon, 16 Mar 2020 09:32:52 +0100
Received: by mail-qk1-f178.google.com with SMTP id f3so24675110qkh.1;
        Mon, 16 Mar 2020 01:32:51 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1D9RFKOM+mmr0RAgeQ9b61ZPcAE4LE7PPMf2paFHJBMyk9Zv1+
        EeTnh+EWe4suAD+17SdByKLCNWbGC0VpITIvmeA=
X-Google-Smtp-Source: ADFU+vt5kUDFBAPxQ/eoOtbyfq5T4WxUU4coVWhvqGjxWRRI+qcvmiTDhvmnRyeGJebLCVabbOJ5WyjHLakbilschCU=
X-Received: by 2002:a37:6285:: with SMTP id w127mr24726126qkb.138.1584347570587;
 Mon, 16 Mar 2020 01:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-5-git-send-email-mikelley@microsoft.com>
 <CAK8P3a2Hnm74aUMNFHbjMr4HwHGZn1+xa4ERsxAJY6hMzhEOhQ@mail.gmail.com> <632eb459dbe53a9b69df2a4f030a755b@kernel.org>
In-Reply-To: <632eb459dbe53a9b69df2a4f030a755b@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 16 Mar 2020 09:32:34 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3aihZeriUWAhWJMsOtdiY4Lo29syrRbB4Po3v4dsLhvA@mail.gmail.com>
Message-ID: <CAK8P3a3aihZeriUWAhWJMsOtdiY4Lo29syrRbB4Po3v4dsLhvA@mail.gmail.com>
Subject: Re: [PATCH v6 04/10] arm64: hyperv: Add memory alloc/free functions
 for Hyper-V size pages
To:     Marc Zyngier <maz@kernel.org>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        gregkh <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>, olaf@aepfle.de,
        Andy Whitcroft <apw@canonical.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jason Wang <jasowang@redhat.com>, marcelo.cerri@canonical.com,
        "K. Y. Srinivasan" <kys@microsoft.com>, sunilmut@microsoft.com,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:BHpMUhD9WE5ysXlz1KEecLs2Dmfm78AEFkWWqQALB6q+NCVLgJU
 Rb6XRpgprTcor3ig9lc6DhcnvB2Mou+IVdbMu19yOv9agNQIXZRRRIi/HCqU99dpfzQP9QH
 QGFtiPTeguz3S9qHHlWkMqGMCFN+9yVAfsv4J6kTBvHOvbRg5T/nWKok92bMRIpRRYedHhR
 rJyu1C8E8y4KX2mbU2+HA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SsmI/FqHK3w=:6LMYrKew+LxMQI7jNeFoqM
 O9624qbU4K7jnAyUCH7vF5/i92CRlV/yLACBOot8iqHyT3jIlS1vFcACCIC8Ft3rKjsHJSTVd
 2mxy9j8/Vz45B3vp0QQRhPq828WKioQxR+2QeR7t5OG4FPTXORqH6HFxZF0t+ZhF8ldGvDIKI
 dJw6us89CCJe6TIsbpSpTNOmbaQtOvE/iwEmIMOkrfJDPlAafEtfO47L44bFEHKzZmcOTFGEW
 3tpoCbRQj+1Bij61MvITjzA6snQIThaU4kRc1DxU+6h9hF+ZVH7m4c1OzOtBCcpgHFYR818Cz
 0iTYWUJJIjMAFIExv9rdZslCNJNo3DJpcbe+PrUHzHAkIqoo9LL2TZ+l1rqnog+CJ+MkbjSAK
 Fmb8hWd7tGU0SbTyqsQHPXZpDUnp4jzkeb5mEla+VLXRfyhzf1Qiav8VLp3f/Ymyo1gm0JdKz
 h2U99LnWH5eOP8mx4D9QVYJ0pXLdUzJUgN3Tudx7HKdnfRGpyV6NwUk53dlBLHZITqg9ohSAG
 btnwKIE+l9SS7S4rK3VFBRIz0cUbaes8gEWN07AyzzwCXkpbxy9ZrpJAURMPqsWQdG02aUPRI
 GLjMy3CF8NK0weJG71N4bK5aZoIbkN9YxEu5YqptzEzAmsPK8CAVuyvvzFmnU4WE4pAbQBbez
 TfN08eNKXzweWMkKUVffIORAa8asjt8tz3p8nvFtxmrD8sOxSiDoTMkymT+z4Eb+f4DX4ytgU
 N8WLepGoRCYjJ45L65WesCE4+4EJoxP6Xfmq+0CxVh0FeXYsF8Tjrn64J6FxJDQqSAk6maX9g
 VRpxewEvjOqgsd4fsBL0LfGATd26yYR9FODt0EiY0E2IgL0w10=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 16, 2020 at 9:30 AM Marc Zyngier <maz@kernel.org> wrote:
> On 2020-03-16 08:22, Arnd Bergmann wrote:
> > On Sat, Mar 14, 2020 at 4:36 PM Michael Kelley <mikelley@microsoft.com>
> > wrote:
> >>  /*
> >> + * Functions for allocating and freeing memory with size and
> >> + * alignment HV_HYP_PAGE_SIZE. These functions are needed because
> >> + * the guest page size may not be the same as the Hyper-V page
> >> + * size. We depend upon kmalloc() aligning power-of-two size
> >> + * allocations to the allocation size boundary, so that the
> >> + * allocated memory appears to Hyper-V as a page of the size
> >> + * it expects.
> >> + *
> >> + * These functions are used by arm64 specific code as well as
> >> + * arch independent Hyper-V drivers.
> >> + */
> >> +
> >> +void *hv_alloc_hyperv_page(void)
> >> +{
> >> +       BUILD_BUG_ON(PAGE_SIZE <  HV_HYP_PAGE_SIZE);
> >> +       return kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
> >> +}
> >> +EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
> >
> > I don't think there is any guarantee that kmalloc() returns
> > page-aligned
> > allocations in general.
>
> I believe that guarantee came with 59bb47985c1db ("mm, sl[aou]b:
> guarantee
> natural alignment for kmalloc(power-of-two)").
>
> > How about using get_free_pages() to implement this?
>
> This would certainly work, at the expense of a lot of wasted memory when
> PAGE_SIZE isn't 4k.

I'm sure this is the least of your problems when the guest runs with
a large base page size, you've already wasted most of your memory
otherwise then.

    Arnd
