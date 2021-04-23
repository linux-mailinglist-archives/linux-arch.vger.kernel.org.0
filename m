Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0389B3699D0
	for <lists+linux-arch@lfdr.de>; Fri, 23 Apr 2021 20:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243657AbhDWSgf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Apr 2021 14:36:35 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:43373 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243499AbhDWSge (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Apr 2021 14:36:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619202957; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=RhAT7aH0Aqqk6QCKlg4vyZ7VqDWoW4t/2SQv52LFvD8=; b=ld8wGnZ1s2dF52D0UB1V3BXIWcN911pznFe+pTcpYDcxuzod3ldiYUaCulS8x0Wv2VW3Kqbj
 NRtU40OiZD7GSHIXIsjnqeyWHxgbdldeRIR0CtpHEu2HbqfZydfWvHWiyXur0Krmyw225pn7
 IRnsbkBsftqRG7UWgavpzQyE94Q=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5MDNlZiIsICJsaW51eC1hcmNoQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60831382a817abd39a7ef485 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 23 Apr 2021 18:35:46
 GMT
Sender: bcain=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 54076C4338A; Fri, 23 Apr 2021 18:35:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        PDS_BAD_THREAD_QP_64,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from BCAIN (104-54-226-75.lightspeed.austtx.sbcglobal.net [104.54.226.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bcain)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A09CFC433D3;
        Fri, 23 Apr 2021 18:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A09CFC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bcain@codeaurora.org
Reply-To: <bcain@codeaurora.org>
From:   "Brian Cain" <bcain@codeaurora.org>
To:     "'Arnd Bergmann'" <arnd@kernel.org>,
        "'Nick Desaulniers'" <ndesaulniers@google.com>
Cc:     "'open list:QUALCOMM HEXAGON...'" <linux-hexagon@vger.kernel.org>,
        "'clang-built-linux'" <clang-built-linux@googlegroups.com>,
        "'linux-arch'" <linux-arch@vger.kernel.org>,
        "'Guenter Roeck'" <linux@roeck-us.net>
References: <CAKwvOdngSxXGYAykAbC=GLE_uWGap220=k1zOSxe1ntuC=0wjA@mail.gmail.com> <CAK8P3a2DCCjOq+sB+9sRM7XrtnkromCs_+znv3dehqLiYFDQag@mail.gmail.com>
In-Reply-To: <CAK8P3a2DCCjOq+sB+9sRM7XrtnkromCs_+znv3dehqLiYFDQag@mail.gmail.com>
Subject: RE: ARCH=hexagon unsupported?
Date:   Fri, 23 Apr 2021 13:35:43 -0500
Message-ID: <025b01d7386f$78deed80$6a9cc880$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQHA6GaHPKlqiI34kZpdCyOyqmKBQAItWAQVqt13LMA=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> -----Original Message-----
> From: Arnd Bergmann <arnd@kernel.org>
> Sent: Friday, April 23, 2021 4:37 AM
> To: Nick Desaulniers <ndesaulniers@google.com>
> Cc: open list:QUALCOMM HEXAGON... <linux-hexagon@vger.kernel.org>;
> clang-built-linux <clang-built-linux@googlegroups.com>; Brian Cain
> <bcain@codeaurora.org>; linux-arch <linux-arch@vger.kernel.org>; =
Guenter
> Roeck <linux@roeck-us.net>
> Subject: Re: ARCH=3Dhexagon unsupported?
>=20
> On Fri, Apr 23, 2021 at 12:12 AM 'Nick Desaulniers' via Clang Built =
Linux
> <clang-built-linux@googlegroups.com> wrote:
> >
> > Arnd,
> > No one can build ARCH=3Dhexagon and
> > https://github.com/ClangBuiltLinux/linux/issues/759 has been open =
for
> > 2 years.
> >
> > Trying to build
> > $ ARCH=3Dhexagon CROSS_COMPILE=3Dhexagon-linux-gnu make LLVM=3D1
> LLVM_IAS=3D1
> > -j71
> >
> > shows numerous issues, the latest of which commit 8320514c91bea
> > ("hexagon: switch to ->regset_get()") has a very obvious typo which
> > misspells the `struct` keyword and has been in the tree for almost 1
> > year.
>=20
> Thank you for looking into it.
>=20
> > Why is arch/hexagon/ in the tree if no one can build it?
>=20
> Removing it sounds reasonable to me, it's been broken for too long, =
and we
> did the same thing for unicore32 that was in the same situation where =
the
> gcc port was too old to build the kernel and the clang port never =
quite work
> in mainline.
>=20
> Guenter also brought up the issue a year ago, and nothing happened.
> I see Brian still occasionally sends an Ack to a patch that gets =
merged through
> another tree, but he has not send any patches or pull requests himself =
after
> taking over maintainership from Richard Kuo in 2019, and the four =
hexagon
> pull requests after 2014 only contained build fixes from developers =
that don't
> have access to the hardware (Randy Dunlap, Viresh Kumar, Mike =
Frysinger
> and me).

Nick, Arnd,

I can appreciate your frustration, I can see that I have let the =
community down here.  I would like to keep hexagon in-tree and I am =
committed to making the changes necessary to do so.  I have a patch =
under internal review to address the cited build issues and =
libgcc/compiler-rt content.  In addition, my team has been focusing on =
developing QEMU system mode support that would mitigate some of the need =
for having hardware access.  We have landed support for userspace =
hexagon-linux in upstream QEMU.  My team and I want to make hexagon's =
open source footprint larger, not smaller.  I realize that not being a =
good steward of the hexagon kernel has not helped, and we will do what =
we can to fix it.

-Brian

