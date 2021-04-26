Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F20236B3E7
	for <lists+linux-arch@lfdr.de>; Mon, 26 Apr 2021 15:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhDZNPE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Apr 2021 09:15:04 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:22669 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231862AbhDZNPE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Apr 2021 09:15:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619442862; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=2aasOBDfVeKKukuy1LhKC7ZOGD0SUDLdz1bz/6bTWp8=; b=A7DLCagvQEglF19UICEKrEU0PTtM5p0WrtH5/lvh33Oszp0F5GKAag1qpe7PxNQx512XLdWV
 KFUwo68wuWlDnuVwt1utXXZN4MOmWNq/Gz/mmOTn8BxLPlfKdadO3qRCcrbkFSosX9WEEEP4
 xXeSUFbltt1KoWkGXSbfcFi+Y/M=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5MDNlZiIsICJsaW51eC1hcmNoQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 6086bc8aa817abd39acb10d5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 26 Apr 2021 13:13:46
 GMT
Sender: bcain=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E4283C4338A; Mon, 26 Apr 2021 13:13:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        PDS_BAD_THREAD_QP_64,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from BCAIN (104-54-226-75.lightspeed.austtx.sbcglobal.net [104.54.226.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bcain)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 40E3FC433D3;
        Mon, 26 Apr 2021 13:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 40E3FC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bcain@codeaurora.org
Reply-To: <bcain@codeaurora.org>
From:   "Brian Cain" <bcain@codeaurora.org>
To:     "'Nick Desaulniers'" <ndesaulniers@google.com>
Cc:     "'Arnd Bergmann'" <arnd@kernel.org>,
        "'open list:QUALCOMM HEXAGON...'" <linux-hexagon@vger.kernel.org>,
        "'clang-built-linux'" <clang-built-linux@googlegroups.com>,
        "'linux-arch'" <linux-arch@vger.kernel.org>,
        "'Guenter Roeck'" <linux@roeck-us.net>,
        "'Randy Dunlap'" <rdunlap@infradead.org>,
        "'Miguel Ojeda'" <miguel.ojeda.sandonis@gmail.com>
References: <CAKwvOdngSxXGYAykAbC=GLE_uWGap220=k1zOSxe1ntuC=0wjA@mail.gmail.com> <CAK8P3a2DCCjOq+sB+9sRM7XrtnkromCs_+znv3dehqLiYFDQag@mail.gmail.com> <025b01d7386f$78deed80$6a9cc880$@codeaurora.org> <CAKwvOdnyowwDnHXPyJc8-KZg9vKy8zFn7hErazVT30+sPO8TyA@mail.gmail.com>
In-Reply-To: <CAKwvOdnyowwDnHXPyJc8-KZg9vKy8zFn7hErazVT30+sPO8TyA@mail.gmail.com>
Subject: RE: ARCH=hexagon unsupported?
Date:   Mon, 26 Apr 2021 08:13:43 -0500
Message-ID: <034f01d73a9d$fc4ed420$f4ec7c60$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQHA6GaHPKlqiI34kZpdCyOyqmKBQAItWAQVAr2ClWoDAPOEXKq0DBKw
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> -----Original Message-----
> From: Nick Desaulniers <ndesaulniers@google.com>
> Sent: Friday, April 23, 2021 4:40 PM
> To: Brian Cain <bcain@codeaurora.org>
> Cc: Arnd Bergmann <arnd@kernel.org>; open list:QUALCOMM HEXAGON...
> <linux-hexagon@vger.kernel.org>; clang-built-linux <clang-built-
> linux@googlegroups.com>; linux-arch <linux-arch@vger.kernel.org>; =
Guenter
> Roeck <linux@roeck-us.net>; Randy Dunlap <rdunlap@infradead.org>; =
Miguel
> Ojeda <miguel.ojeda.sandonis@gmail.com>
> Subject: Re: ARCH=3Dhexagon unsupported?
>=20
> On Fri, Apr 23, 2021 at 11:35 AM Brian Cain <bcain@codeaurora.org> =
wrote:
> >
> > > -----Original Message-----
> > > From: Arnd Bergmann <arnd@kernel.org>
> > > Sent: Friday, April 23, 2021 4:37 AM
> > > To: Nick Desaulniers <ndesaulniers@google.com>
> > > Cc: open list:QUALCOMM HEXAGON... <linux-hexagon@vger.kernel.org>;
> > > clang-built-linux <clang-built-linux@googlegroups.com>; Brian Cain
> > > <bcain@codeaurora.org>; linux-arch <linux-arch@vger.kernel.org>;
> > > Guenter Roeck <linux@roeck-us.net>
> > > Subject: Re: ARCH=3Dhexagon unsupported?
> > >
> > > On Fri, Apr 23, 2021 at 12:12 AM 'Nick Desaulniers' via Clang =
Built
> > > Linux <clang-built-linux@googlegroups.com> wrote:
> > > >
> > > > Arnd,
> > > > No one can build ARCH=3Dhexagon and
> > > > https://github.com/ClangBuiltLinux/linux/issues/759 has been =
open
> > > > for
> > > > 2 years.
> > > >
> > > > Trying to build
> > > > $ ARCH=3Dhexagon CROSS_COMPILE=3Dhexagon-linux-gnu make LLVM=3D1
> > > LLVM_IAS=3D1
> > > > -j71
> > > >
> > > > shows numerous issues, the latest of which commit 8320514c91bea
> > > > ("hexagon: switch to ->regset_get()") has a very obvious typo
> > > > which misspells the `struct` keyword and has been in the tree =
for
> > > > almost 1 year.
> > >
> > > Thank you for looking into it.
> > >
> > > > Why is arch/hexagon/ in the tree if no one can build it?
> > >
> > > Removing it sounds reasonable to me, it's been broken for too =
long,
> > > and we did the same thing for unicore32 that was in the same
> > > situation where the gcc port was too old to build the kernel and =
the
> > > clang port never quite work in mainline.
> > >
> > > Guenter also brought up the issue a year ago, and nothing =
happened.
> > > I see Brian still occasionally sends an Ack to a patch that gets
> > > merged through another tree, but he has not send any patches or =
pull
> > > requests himself after taking over maintainership from Richard Kuo
> > > in 2019, and the four hexagon pull requests after 2014 only
> > > contained build fixes from developers that don't have access to =
the
> > > hardware (Randy Dunlap, Viresh Kumar, Mike Frysinger and me).
> >
> > Nick, Arnd,
> >
> > I can appreciate your frustration, I can see that I have let the =
community
> down here.  I would like to keep hexagon in-tree and I am committed to
> making the changes necessary to do so.
>=20
> I'm very happy to hear that.
>=20
> > I have a patch under internal review to address the cited build =
issues and
> libgcc/compiler-rt content.
>=20
> We'd be first in line to help build test such a patch. Please consider =
cc'ing
> myself and clang-built-linux@googlegroups.com when such a patch is
> available externally.  Further, we have the CI ready and waiting to =
add new
> architectures, even if it's just build testing. That would have caught
> regressions like 8320514c91bea; we were down to 1 build failure with
> https://github.com/ClangBuiltLinux/linux/issues/759 last I looked =
which was
> preventing us from adding Hexagon to any CI, but we must now dig =
ourselves
> out of a slightly deeper hole now.
>=20
> Is this patch something you suspect will take quite some time to work =
through
> internal review?

I don't think it should take long, no.  I should have a better idea =
today of about how long it will take.  We will share it ASAP.

> > In addition, my team has been focusing on developing QEMU system =
mode
> support that would mitigate some of the need for having hardware =
access.
> We have landed support for userspace hexagon-linux in upstream QEMU.
>=20
> That's also great to hear. QEMU is a critical part of our CI for boot =
testing; if
> there's more info on timelines or what's involved with booting a =
hexagon
> kernel in QEMU, we'd be very happy to know how or when that's =
available.
>=20
> > My team and I want to make hexagon's open source footprint larger, =
not
> smaller.  I realize that not being a good steward of the hexagon =
kernel has not
> helped, and we will do what we can to fix it.
>=20
> A worthwhile and appreciated sentiment. I believe you.
>=20
> Hexagon could be an interesting case for LLVM support in general for =
the
> Linux kernel; a case where each target or driver need not necessarily =
have a
> GCC backend to be acceptable.  But barring anyone from being able to =
actually
> build it (let alone run it), it's not that; it's less than that. It's =
dead code that bit
> rots further and burdens maintainers who are maintaining something =
that's
> already broken. I'm not sure who derives any benefit.
>=20
> I think it's in everyone's best interest to see Linux support more =
targets than
> fewer, and 2020 has been a hard year, but I'm curious how long =
something
> has to be broken before folks say "enough." Please let's support this =
properly
> or recognize the situation for what it is.

I don't think the special circumstances of 2020 are to blame, it's just =
my failure to give this work the priority it deserves.  Agreed: we will =
support the target properly.

-Brian

