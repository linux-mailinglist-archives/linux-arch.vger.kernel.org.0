Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A8E1FFCF1
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jun 2020 22:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgFRUv7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Jun 2020 16:51:59 -0400
Received: from mout.gmx.net ([212.227.15.15]:42295 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727092AbgFRUv5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Jun 2020 16:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592513502;
        bh=dAh/4XFnuCUZkG3McHXtZt1y3vLAuRwTuz7aNgGjgDk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ca2O/NfSaWRL7gU05aaFJwXPHSqQ1k5miQ8OYz1FMq+owQEMvZDm8ixOogA40db7z
         qt/b8np34UeOPHe9Ak22mKA2Tkraoe4De4AK0s088PJ7I1tgrRXevxBa66DRf+c+kq
         jr05KpcS2q/fnDC5OJJ10j/DNSSdehtVyT6abKww=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.168.63]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiaY9-1jHLWD0dSp-00fgx2; Thu, 18
 Jun 2020 22:51:42 +0200
Subject: Re: rename probe_kernel_* and probe_user_*
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        the arch/x86 maintainers <x86@kernel.org>
References: <20200617073755.8068-1-hch@lst.de>
 <CAHk-=wjpnu=882iD9ck9Ywt6R1LYX_Hv-oS7dBMsWZwDRGZ5jA@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <7b3da127-6101-045e-9a8a-4d46198c1190@gmx.de>
Date:   Thu, 18 Jun 2020 22:51:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjpnu=882iD9ck9Ywt6R1LYX_Hv-oS7dBMsWZwDRGZ5jA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kiUDgX8PfCD306rR7Gaqh2uWshvEfL76iLet0Tg6znsoXqYfMqk
 LaKEc4PF/5JXUQGcHKSIlNrQTzmGO75SBwDLrwu8GlfUiMoBk9sHzbLNxT8Tv32EfCizcu3
 gwvB2aUSBTJW0hjGLXrS78XRQ4LkVtKViqRm950xpw1D0wcCRYmYL7k0/sdRJZvPtMYvt2v
 jB3Km407Oxinsh4DCJ5bA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6n+cOUXpzPI=:m/AZK6KLhJ7uQy0czU5UkZ
 0xDxL0Uf9VUuAm+l69Dp6E3V4E0rlYWre9EV2HZadIskwpndyznnQoe5UrMgC5tQVf1/FqaO1
 wJXuQ6Zyyjyv/6s8CsxGYnh7ucFJBwvCaEapX0ASLEUvXfq6K18Y4v33njC28/mzeqQgEPxTw
 7QXFIFy3QRi+HfGzrD9LjYAJZSR0A3WR+4eZmjMbl+NTcyOGQ6mzI/h0A+iokm2fk+sTxy1on
 5JgeyTEVpBeU4BgArfkDTDJQQvs+PrhlxYq2sxZ9+WzblSY6EH+xgzNhz3eXS+97Cxe7p2QSt
 0m4ig4HYihKibHEtZ8iHD83FFIUL9uISlT3wwIDw99Kpt2lbUs0j4JOBXjmjXyzavjs5e83Vl
 jHkEhXoK9dHiK+TOuKA2oBPFoKb9VsG930/x1Pbs0L1dkgtiqQ11su6l2EgTUic2RIRPOJxJJ
 4U6PXmqfSUJJr69lYZQs4gxB6rDlb128ptg/gAAEFEFG7tStOvMkaxxDM/RuCeeoHdgRtRhuU
 AQG3xn0ywVj2C5lKOD2kNeOVUG9no397RWj7pT/st9taXoy8bxRyOPf48PuPycCwxQcjhGZaQ
 rC6Uf1GSLkxw6dB0kC18X3dM3BTrN6+AHjgybmHNFOCxgHaSzM27RsnLd1xPgyyr8DvUjohtt
 iNI6daSKCUV31hzRKAdNtUSsqJDmsWa+EI6t9wPYavmkyrh079whGeGiksprLVJmCGzPZGpiQ
 xyGuxTHIzj76SMwibDyqX8X/RUyucEjCIWjAp/Q0d7G/f2Io7ee5+RVvcBjxVLV8S5Oc7Fshw
 3etbYet7x6LKExWQz0qDM2ZFYXaHuZyiP/OztO4UBhsZAEdBupMVMspRPQ0+cUrY2kVsEt52l
 X9GlkV9auOtb1FctFMg2g+roK2y4muR4glhqcaCZg3ZBSoRrQgh8K0NNQIRBRLmxDkNzP69Fj
 aXmRndU/7F+byAQY17h8ib76QGSxyL3HXFCoKL1KA6fVpEUUFNIknWjO0gscdh8ISAYByhh+b
 QE/ekzixgSP6f0HqzkIjTyQQGeV/Lul1DSLW8LbZWLCalzwK+C6IB4WDmW5JRQth1fh0qImel
 cNK3ewvG7f4ElYKXXTWT/9yWEKXxUHAlB9enjK/RHcEacV7vl0ELZRKTlpsslZnIXUuGc1PWO
 1vqULklzTHKIUL6CRCQxpfexA/TwBI3zP01zD6xbwZu7Okfesv1yWG/yqpOOmu9Y8gBqw=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 18.06.20 21:48, Linus Torvalds wrote:
> [ Explicitly added architecture lists and developers to the cc to make
> this more visible ]
>
> On Wed, Jun 17, 2020 at 12:38 AM Christoph Hellwig <hch@lst.de> wrote:
>>
>> Andrew and I decided to drop the patches implementing your suggested
>> rename of the probe_kernel_* and probe_user_* helpers from -mm as there
>> were way to many conflicts.  After -rc1 might be a good time for this a=
s
>> all the conflicts are resolved now.
>
> So I've merged this renaming now, together with my changes to make
> 'get_kernel_nofault()' look and act a lot more like 'get_user()'.
>
> It just felt wrong (and potentially dangerous) to me to have a
> 'get_kernel_nofault()' naming that implied semantics that we're all
> familiar with from 'get_user()', but acting very differently.
>
> But part of the fixups I made for the type checking are for
> architectures where I didn't even compile-test the end result. I
> looked at every case individually, and the patch looks sane, but I
> could have screwed something up.
>
> Basically, 'get_kernel_nofault()' doesn't do the same automagic type
> munging from the pointer to the target that 'get_user()' does, but at
> least now it checks that the types are superficially compatible.
> There should be build failures if they aren't, but I hopefully fixed
> everything up properly for all architectures.
>
> This email is partly to ask people to double-check, but partly just as
> a heads-up so that _if_ I screwed something up, you'll have the
> background and it won't take you by surprise.

Linus. thanks for the heads-up!
With your change it compiles cleanly on 32- and 64-bit parisc.

Helge
