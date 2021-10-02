Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4AB41FBB5
	for <lists+linux-arch@lfdr.de>; Sat,  2 Oct 2021 14:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhJBMPt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 2 Oct 2021 08:15:49 -0400
Received: from mengyan1223.wang ([89.208.246.23]:34108 "EHLO mengyan1223.wang"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233110AbhJBMPt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 2 Oct 2021 08:15:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@mengyan1223.wang)
        by mengyan1223.wang (Postfix) with ESMTPSA id 13521661AC;
        Sat,  2 Oct 2021 08:13:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mengyan1223.wang;
        s=mail; t=1633176842;
        bh=f4vXemB4wUsw27uR9flYex9Y9h8f9QEQhMS+IoiPMDU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rfe+Ja5MkE92oMtPhINeBGuA6bsfes9kCHiRQzKUJlt0m3jv5wJWHznoWJ8r9+s/W
         w57L1Ty9pA9+YIcpbXCzWh+EtP5I4ysTqfoWTexTrIR3ebMmMQeTZyBmEYfuHT//62
         jq4e2r4mICCSOlfRYLhqBLdEYWuAYjIYGVO58eiGyJYrdAur8or0UnMRaFzf9JbdKx
         OSkuzgUl9QsjYyN1+jhp3s8nXGqNnudceV+4/1hKe2zzsEA4YgcVdtGjKtiUfBFM91
         JWgV+hwOZX8mo1gQzbqf0w/q2nlurmDSn6tVs8IKPAoEgGnYHjHPIMha5PSAY/F1/3
         gf3UeGml0915w==
Message-ID: <7805af604610508cec679a160d92025e8975132b.camel@mengyan1223.wang>
Subject: Re: [PATCH V4 19/22] LoongArch: Add VDSO and VSYSCALL support
From:   Xi Ruoyao <xry111@mengyan1223.wang>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Sat, 02 Oct 2021 20:13:57 +0800
In-Reply-To: <CAAhV-H6WWPeYfYsAM2UfKH1GYVA=Ww2k1akAy-ve28u3kJL4pA@mail.gmail.com>
References: <20210927064300.624279-1-chenhuacai@loongson.cn>
         <20210927064300.624279-20-chenhuacai@loongson.cn>
         <f6fc1fa8bf4decf97d76900a64fe0bc2bf25576d.camel@mengyan1223.wang>
         <CAAhV-H6WWPeYfYsAM2UfKH1GYVA=Ww2k1akAy-ve28u3kJL4pA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 2021-10-02 at 18:53 +0800, Huacai Chen wrote:
> Hi, Ruoyao,
> 
> On Thu, Sep 30, 2021 at 11:43 PM Xi Ruoyao <xry111@mengyan1223.wang>
> wrote:
> > 
> > On Mon, 2021-09-27 at 14:42 +0800, Huacai Chen wrote:
> > > diff --git a/arch/loongarch/vdso/gen_vdso_offsets.sh
> > > b/arch/loongarch/vdso/gen_vdso_offsets.sh
> > > new file mode 100755
> > > index 000000000000..7da255fea213
> > > --- /dev/null
> > > +++ b/arch/loongarch/vdso/gen_vdso_offsets.sh
> > > @@ -0,0 +1,14 @@
> > > +#!/bin/sh
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +
> > > +#
> > > +# Derived from RISC-V and ARM64:
> > > +# Author: Will Deacon <will.deacon@arm.com>
> > > +#
> > > +# Match symbols in the DSO that look like VDSO_*; produce a
> > > header
> > > file
> > > +# of constant offsets into the shared object.
> > > +#
> > > +
> > > +LC_ALL=C
> > 
> > I'm wondering whether this line is really useful... There is no
> > "export"
> > here so the variable won't be passed to the environment of the sed
> > command below.
> Have you encountered some problems with this? It just works for me,
> and both ARM64 and RISCV are the same.

No problems, and I also seen those in ARM64 & RISCV.  But AFAIK this
line really does nothing and can be removed.

If LC_ALL=C is really necessary for the sed to operate correctly, it
should be "exported" as

LC_ALL=C
export LC_ALL

("export LC_ALL=C" will work under bash, but it's not POSIX.)

Or, explicitly pass LC_ALL to sed with:

LC_ALL=C sed ...
-- 
Xi Ruoyao <xry111@mengyan1223.wang>
School of Aerospace Science and Technology, Xidian University
