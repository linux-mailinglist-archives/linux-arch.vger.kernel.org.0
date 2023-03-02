Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973ED6A7C2B
	for <lists+linux-arch@lfdr.de>; Thu,  2 Mar 2023 08:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCBH5Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Mar 2023 02:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjCBH5X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2023 02:57:23 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4FE360A5
        for <linux-arch@vger.kernel.org>; Wed,  1 Mar 2023 23:57:21 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso1100960wmb.0
        for <linux-arch@vger.kernel.org>; Wed, 01 Mar 2023 23:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1677743839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gGlmdrxpk12L0HtiU5R9bJeUayhxQ74GXgfAq6meuw=;
        b=pn+DJn+k9uImMGeBMXuwnMQE1biMNzy71Plo8H7DOI3fKK/ceps9rgGUxc/bmw8s6L
         4TQMSud9TXFc8/r2OEOEiAKv5SApxcJ1Yd/LQHA0imhiw3qi8hrsJYLIdS7LaNAmBH1O
         AbgLlGVWFn2hf8BkmR90At5+g3zqQ61Ankq9cGuBB9WgQfAsyn4JZulcRbW71gf7ZeYz
         oRP4F6/LxUTL9nxCbjnWUdwQSV0fTcnbx/sIcDMk8fB8xQ9dJ6UAQMnDD3HBbCn+Qr4a
         fIykdIwuX5WmEnYpwkBvfu6oXc7MDCcdwlfNYOa5JGNIdVdo8Hubuxh+Kfco99U7Z89i
         QfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677743839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gGlmdrxpk12L0HtiU5R9bJeUayhxQ74GXgfAq6meuw=;
        b=WCchcdnD/AT7OPYvF++FEH77TzmQaMNaKLvkiQfX9DQjg4S1SVj+NJ5hCB7kCXghvO
         +v9QAE0P4KBJv70kjdMJTMa2P0b1RgRdVysvHGT1zF/Fjrq81kT9KFvI4vUybvGgp3oj
         WHmd2Asr24aMtLcVqeJArv9x6gLaNko7M4BG3CSFfDBkZXPq3c35i/UuebqocW9jSZM9
         L3u4YBya7qYvHJ27WJg4jnFEmt3CTAKO30rfXhLLL9nZRIPV+aTInPazIp9QecvpfZEk
         28rIPdfq92m6ZRAuYwRwRU/xN5Bo29guoj7xLmf5gVn0Kyr89t7FSjf7CNWZNyh4uf9j
         KpPg==
X-Gm-Message-State: AO0yUKUJfx9tLq9br+uqcYE5IHOkc/VEhaXaoFVTkKGtnVGEMAzdVLHy
        qHLhu7DlNYguoeLpQKcnr/zyLYhrnKnInrR7rI1Eww==
X-Google-Smtp-Source: AK7set8WtHYe+gEo1Fgs1pSlJqsnM2tCvgsXzdB6/J3n+P8FnRw3jetc5Yrjj9TAlqQSjPmyeFZCYlu44lotg0az/Sk=
X-Received: by 2002:a05:600c:4591:b0:3ea:8ed9:8e4b with SMTP id
 r17-20020a05600c459100b003ea8ed98e4bmr2655128wmo.6.1677743839531; Wed, 01 Mar
 2023 23:57:19 -0800 (PST)
MIME-Version: 1.0
References: <Y+tSBlSsQBQF/Ro2@osiris> <mhng-e8b09772-24e5-4729-a0bf-01a9e4c76636@palmer-ri-x1c9a>
In-Reply-To: <mhng-e8b09772-24e5-4729-a0bf-01a9e4c76636@palmer-ri-x1c9a>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Thu, 2 Mar 2023 08:57:08 +0100
Message-ID: <CAHVXubgdr_NrLPnZ6NhuDt8uZYZD+R_swpCVGoLDxnD+eOJcuA@mail.gmail.com>
Subject: Re: [PATCH v3 00/24] Remove COMMAND_LINE_SIZE from uapi
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     hca@linux.ibm.com, geert@linux-m68k.org, corbet@lwn.net,
        Richard Henderson <richard.henderson@linaro.org>,
        ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org,
        linux@armlinux.org.uk, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, chenhuacai@kernel.org,
        kernel@xen0n.name, monstr@monstr.eu, tsbogend@alpha.franken.de,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        chris@zankel.net, jcmvbkbc@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 2, 2023 at 4:17=E2=80=AFAM Palmer Dabbelt <palmer@dabbelt.com> =
wrote:
>
> On Tue, 14 Feb 2023 01:19:02 PST (-0800), hca@linux.ibm.com wrote:
> > On Tue, Feb 14, 2023 at 09:58:17AM +0100, Geert Uytterhoeven wrote:
> >> Hi Heiko,
> >>
> >> On Tue, Feb 14, 2023 at 9:39 AM Heiko Carstens <hca@linux.ibm.com> wro=
te:
> >> > On Tue, Feb 14, 2023 at 08:49:01AM +0100, Alexandre Ghiti wrote:
> >> > > This all came up in the context of increasing COMMAND_LINE_SIZE in=
 the
> >> > > RISC-V port.  In theory that's a UABI break, as COMMAND_LINE_SIZE =
is the
> >> > > maximum length of /proc/cmdline and userspace could staticly rely =
on
> >> > > that to be correct.
> >> > >
> >> > > Usually I wouldn't mess around with changing this sort of thing, b=
ut
> >> > > PowerPC increased it with a5980d064fe2 ("powerpc: Bump COMMAND_LIN=
E_SIZE
> >> > > to 2048").  There are also a handful of examples of COMMAND_LINE_S=
IZE
> >> > > increasing, but they're from before the UAPI split so I'm not quit=
e sure
> >> > > what that means: e5a6a1c90948 ("powerpc: derive COMMAND_LINE_SIZE =
from
> >> > > asm-generic"), 684d2fd48e71 ("[S390] kernel: Append scpdata to ker=
nel
> >> > > boot command line"), 22242681cff5 ("MIPS: Extend COMMAND_LINE_SIZE=
"),
> >> > > and 2b74b85693c7 ("sh: Derive COMMAND_LINE_SIZE from
> >> > > asm-generic/setup.h.").
> >> > >
> >> > > It seems to me like COMMAND_LINE_SIZE really just shouldn't have b=
een
> >> > > part of the uapi to begin with, and userspace should be able to ha=
ndle
> >> > > /proc/cmdline of whatever length it turns out to be.  I don't see =
any
> >> > > references to COMMAND_LINE_SIZE anywhere but Linux via a quick Goo=
gle
> >> > > search, but that's not really enough to consider it unused on my e=
nd.
> >> > >
> >> > > The feedback on the v1 seemed to indicate that COMMAND_LINE_SIZE r=
eally
> >> > > shouldn't be part of uapi, so this now touches all the ports.  I'v=
e
> >> > > tried to split this all out and leave it bisectable, but I haven't
> >> > > tested it all that aggressively.
> >> >
> >> > Just to confirm this assumption a bit more: that's actually the same
> >> > conclusion that we ended up with when commit 3da0243f906a ("s390: ma=
ke
> >> > command line configurable") went upstream.
>
> Thanks, I guess I'd missed that one.  At some point I think there was
> some discussion of making this a Kconfig for everyone, which seems
> reasonable to me -- our use case for this being extended is syzkaller,
> but we're sort of just picking a value that's big enough for now and
> running with it.
>
> Probably best to get it out of uapi first, though, as that way at least
> it's clear that it's not uABI.
>
> >> Commit 622021cd6c560ce7 ("s390: make command line configurable"),
> >> I assume?
> >
> > Yes, sorry for that. I got distracted while writing and used the wrong
> > branch to look this up.
>
> Alex: Probably worth adding that to the list in the cover letter as it
> looks like you were planning on a v4 anyway (which I guess you now have
> to do, given that I just added the issue to RISC-V).

Yep, I will :)

Thanks,

Alex
