Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFF518D49D
	for <lists+linux-arch@lfdr.de>; Fri, 20 Mar 2020 17:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgCTQi3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Mar 2020 12:38:29 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:34089 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbgCTQi3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Mar 2020 12:38:29 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MT9v5-1iqloL16QJ-00UZqk; Fri, 20 Mar 2020 17:38:26 +0100
Received: by mail-lf1-f51.google.com with SMTP id v4so1370135lfo.12;
        Fri, 20 Mar 2020 09:38:26 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0jHU9iddxIi5SbUse46sruQf7T5EkCIdEC0e8FM+f/+9xJFMDN
        ALOmf+wtTzo8R9Z2jyg4qj2Yrr75SHvjhsCxjVw=
X-Google-Smtp-Source: ADFU+vtDZNMNKwMI70MLhlIra5oX/KaY/A/S1YKukFTCrCxBIkwCOeyp0t9ZbbgR8Fv4tYMpVwDwO7KgBnd4/HFsTvw=
X-Received: by 2002:a19:6406:: with SMTP id y6mr5994490lfb.125.1584722305592;
 Fri, 20 Mar 2020 09:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-2-git-send-email-mikelley@microsoft.com>
 <CAK8P3a1GFDUY4mXzst4Ds+S-4SGXso6-jfpsYyy-eHyceAC1Zg@mail.gmail.com>
 <MW2PR2101MB10524879CD685710A51AB740D7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <CAK8P3a02EULGxyuKFq8YnbG8BQ_m-RKciaNEc9ZbdP2yz9dt+Q@mail.gmail.com> <MW2PR2101MB1052686237C57955148F173ED7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB1052686237C57955148F173ED7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 20 Mar 2020 17:38:09 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0y==1RsoMOnME9bgP5V_mts4rbaUW08Tt7mS9csXBqDw@mail.gmail.com>
Message-ID: <CAK8P3a0y==1RsoMOnME9bgP5V_mts4rbaUW08Tt7mS9csXBqDw@mail.gmail.com>
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
X-Provags-ID: V03:K1:+Zbwt++57axzA9aupg4DjqJmK2MeBxIpG9CQL7afvRU8sRHbOPB
 39VMPvs1yH7jLxqx8V8ecXmyIhSqswZttoB8td0VF54ccerAalS59jnypIpRpFt1QaSx7Xb
 vRLUQaFM7N7E+PQ9YVDNdNaMN4OxSBHJsc/ZRFzcb4zSnAa8U67f7ML3DLaJAG6ofwuTJFf
 hOFE+n0k6YE48JCKDJGMQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:L1nzbCZCVRw=:+M6+N6UoCkmIO6sNJvSVo1
 6kOoFg1LViy6r7VhEPNtew0IsfmQ6kYCmHp37edJ5vNNClIz/qRLQxepWRMboYytpTm1r+c2g
 M6pljUHSyAOvnX2A5e0b/EViTYg/g6xB5Ax4PrBJrCxWnZj5Hzf/ctigwq3EQcaDLJMADPRaK
 e33JXrOWWxhFlD33R9KYl48cfwQiIkERB0g0RjJxE1AUahdjb4j5AslXJRvP0pSMFMMknXqZy
 97Bm259PxPlwL/zu+XtbsdJYRBylTcmxND4Vba/sY+T+V8RPFgxKlryxKYeElojc8yFnwe5T5
 Z+OiCyksnbFbgeAfQO6+fS/uAPbLwPTjO0BTjCTI2RTOm6QB129b+MurHY+Uih8nBGo0YS9qv
 HMTiXVZuvJ1hEO+e3KSJDNxN0a60MM8fU92a1L9Bg1hZ5bMVJfwfQNQQ7ri/FbAv+Apm4jUIK
 XS6l7exsYenoTt06HMM9UgHYyIuOHDZzvKvKEzXVyqwBORmmHAwPTkds56zwGKAU+aAdP29k7
 Fb3t+lKGWWn8i7muuw2Pp7/dOpgVOgwTA2E/qAHG0FlxwlXfzdWE1InpCXLGSJnSGI1ENPYRX
 n4/UbYAn/xkpsjgmXeWFAO9S64zGKnz9+169o3qODwV5h4AL18yxL2mo6KwJDPu4Fizb5tI6H
 rr03lr3ubzQeJ8RC3Xx57s8Wac36QGl18kvWgEMCT1n64lb4dRxQ7RA8kdEygf9LvnSyC82Cb
 kcd3PPMRQ1HpkmGPjbdGM+fspp/EHmjb8Q7nKivnqKr96uywH9cOoXi7CIBiS2z7bg2zLIfC9
 A/0l7Jao8Mn03EiV58Lbdz8SVMypQVVGDeyRu/wE+S1kr50g8I=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 19, 2020 at 10:31 PM Michael Kelley <mikelley@microsoft.com> wrote:
> From: Arnd Bergmann <arnd@arndb.de> Sent: Wednesday, March 18, 2020 3:10 AM
> > Just drop the __packed annotations then, they just confuse the compiler
> > in this case. In particular, when the compiler thinks that a structure is
> > misaligned, it tries to avoid using load/store instructions on it that are
> > inefficient or trap with misaligned code, so having default alignment
> > produces better object code.
>
> So I'm confused a bit.  Were the original concerns in the above LKML
> discussion bogus?  Is it legal for the compiler to reorder fields or add
> padding, even if the layout of fields in the structure doesn't require it?
> If the compiler *could* do such, then it seems like keeping the __packed
> would be appropriate per the LKML discussion.

The padding is defined in the ELF psABI document for a particular
architecture. In theory an architecture might require padding around
smaller members, but they generally don't when you look at the ones
that Linux runs on. The few odd ones are those that require less
padding, only aligning members to 16 or 32 bit rather than natural
alignment, or padding the size of the structure to 32 bit even if it
only contains 8-bit or 16-bit members. When you have structures
in which every member is naturally aligned and the size it a multiple
of 32 bit, better leave out the __packed.

Aside from generating sub-optimal code, the __packed annotation
can also lead to undefined behavior, if you pass a pointer to
an unaligned member into a function call that takes an aligned
pointer. Newer compilers warn about this.

> > > Unfortunately, changing to a bit mask ripples into
> > > architecture independent code and into the x86
> > > implementation.  I'd prefer not to drag that complexity
> > > into this patch set.
> >
> > How so? If this file is arm64 specific, there should be no need to make
> > x86 do the same change.
>
> This file, hyperv-tlfs.h, is duplicating some definitions on the x86 and
> ARM64 sides that are used by arch independent code, and this is one
> of those definitions.  I had held off on breaking the file into arch
> independent and arch specific portions because the Hyper-V team has
> left some gray areas for functionality that isn't yet used on the ARM64
> side.  So in some cases, it's hard to know what functionality to put
> into the arch independent portion.
>
> But I think I'll go ahead and make the separation with reasonably good
> accuracy, and update the x86 side accordingly.  That will reduce the size
> of this patch set to contain only the things that we know are ARM64
> specific and which are actually used by the ARM64 code.  Things like the
> hv_message_flags will go into the arch independent portion so that
> they can be used by the arch independent code without cluttering up
> the arch specific code.  Making the change will help reduce any
> confusion about what is ARM64-specific. The other core #include file,
> mshyperv.h, has already been done this way.

Ok, sounds good.

     Arnd
