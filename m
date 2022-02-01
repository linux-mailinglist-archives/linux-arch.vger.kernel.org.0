Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E799A4A6139
	for <lists+linux-arch@lfdr.de>; Tue,  1 Feb 2022 17:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240995AbiBAQRN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Feb 2022 11:17:13 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60902 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238531AbiBAQRM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Feb 2022 11:17:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEC57B82EDA;
        Tue,  1 Feb 2022 16:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE9EC340FA;
        Tue,  1 Feb 2022 16:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643732229;
        bh=tXC6QnhULfDX3AZU8FS9vMXtAGqHkE62Trq7DiDQG+g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WJwwKHQP2bQp4H+CbO5qOL36XV8TdcUQG/3UyMIqqA9B0Hwm4ETCJEY3lHVClFDXF
         TLDjmG25OjAf2nWbeEIBc7t8N6VE6PYypR1RiqaNALAFRjmNGja8nlfdih+bKRqoXa
         6iwO5cLgem5/buaDb/tp+Lpy7o2qEqI1/UGsUQSKfz+TMPo3z+mSnz3cG8BYoXAAbi
         +TGuHLaymkpv5tyOnUYoe58IArN1k0mbH+FEHC5NNnewgR/sbHx2qa2lZX/kI6lLTq
         KC7FQoHP9N2fB3arkAzwfzPk2f0PAVZIsC9IjuCJdCCr1g3uteH/QlaN158hB2ZU0/
         Ol0fY9iB4pcnw==
Received: by mail-lj1-f176.google.com with SMTP id e9so24888821ljq.1;
        Tue, 01 Feb 2022 08:17:09 -0800 (PST)
X-Gm-Message-State: AOAM531LUfggg7lGTuuWP5QLpOiCFxi3VVslhGV08HcMSa2rScks7I6v
        bwBglKQuqWrAr/mBEaycxyBZtJZ2iY/d/vYXvdk=
X-Google-Smtp-Source: ABdhPJxXcBxe7hc9p5AvEq+x7+VhWiTcTDw0Bpv+4IzlGIScnrvZJUOiEvnRa3Lc9ryY4B1x/+EnE7mJkMbtxGuSWBE=
X-Received: by 2002:a2e:bd82:: with SMTP id o2mr1407770ljq.454.1643732227579;
 Tue, 01 Feb 2022 08:17:07 -0800 (PST)
MIME-Version: 1.0
References: <20220201150545.1512822-1-guoren@kernel.org> <20220201150545.1512822-22-guoren@kernel.org>
 <CAAhSdy27nVvh9F08kPgffJe-Y-gOOc9cnQtCLFAE0GbDhHVbiQ@mail.gmail.com>
 <f8359e15-412a-03d6-1b0c-a9f253816497@redhat.com> <CAAhSdy0U+41OWG_0C=820U+07accLsHxNYENtp=ZZsy6K4mJ0g@mail.gmail.com>
In-Reply-To: <CAAhSdy0U+41OWG_0C=820U+07accLsHxNYENtp=ZZsy6K4mJ0g@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 2 Feb 2022 00:16:55 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQj2vE-1LC5iUa594zSqBt1yMFjiw8pBPTbWVYp7YoitA@mail.gmail.com>
Message-ID: <CAJF2gTQj2vE-1LC5iUa594zSqBt1yMFjiw8pBPTbWVYp7YoitA@mail.gmail.com>
Subject: Re: [PATCH V5 21/21] KVM: compat: riscv: Prevent KVM_COMPAT from
 being selected
To:     Anup Patel <anup@brainfault.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        kvm-riscv@lists.infradead.org, KVM General <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 2, 2022 at 12:11 AM Anup Patel <anup@brainfault.org> wrote:
>
> On Tue, Feb 1, 2022 at 9:31 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > On 2/1/22 16:44, Anup Patel wrote:
> > > +Paolo
> > >
> > > On Tue, Feb 1, 2022 at 8:38 PM <guoren@kernel.org> wrote:
> > >>
> > >> From: Guo Ren <guoren@linux.alibaba.com>
> > >>
> > >> Current riscv doesn't support the 32bit KVM API. Let's make it
> > >> clear by not selecting KVM_COMPAT.
> > >>
> > >> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > >> Signed-off-by: Guo Ren <guoren@kernel.org>
> > >> Cc: Arnd Bergmann <arnd@arndb.de>
> > >> Cc: Anup Patel <anup@brainfault.org>
> > >
> > > This looks good to me.
> > >
> > > Reviewed-by: Anup Patel <anup@brainfault.org>
> >
> > Hi Anup,
> >
> > feel free to send this via a pull request (perhaps together with Mark
> > Rutland's entry/exit rework).
>
> Sure, I will do like you suggested.
Great, thx.

>
> Regards,
> Anup
>
> >
> > Paolo
> >



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
