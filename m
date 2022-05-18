Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56D152C143
	for <lists+linux-arch@lfdr.de>; Wed, 18 May 2022 19:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240819AbiERRTI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 May 2022 13:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240806AbiERRTH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 May 2022 13:19:07 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C5820E089;
        Wed, 18 May 2022 10:19:06 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id q136so1489054vke.10;
        Wed, 18 May 2022 10:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/f4APx/MmD2R61Oq/wBqbBZa049BgS6jzCZYyWux6uw=;
        b=CRqJwsiNKT4sZEtqe3T41FiSRcnJ1GsrN97IRQZ6MZkmYh8ZdRyxXmtb/J94D0H61o
         UXlXak6BwEHPqc2i+M+cNvc+wf3aNRyAOIpBmDN/fIjJEV8pftJl6kSgPYBN3pEbXwLm
         bHZfYOVXsV1IfzwhXAWwHXg3ukhgzhZIRxWz8win7ObqSWummoAxcmSlondFXp08DZJ4
         36/jI0h+mLOLIm+PhHabN6wQrZiXMkSwrSOeuYDSMkhROPYdHF0MW6UVpWeuZPpCZvlr
         IbfiGH1c3JqN/a2fSTNLxa4MWt7gRYQIbq3e/pyR3zd/D8QZT2xw/TM/14tLWOaQ765P
         KwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/f4APx/MmD2R61Oq/wBqbBZa049BgS6jzCZYyWux6uw=;
        b=O1aPuB+yzs2SpMcIC6TnpWK1K3aSz2LvmHJyOSJWG5tqUp4fHRnbytELoelCawhPQF
         Y3DohQucUtiSZahGa4OTZ3zWfh0ar74EAKsuuwMUSr83TER2Ge65BnFIIHbBmQcpB2y9
         R26j7tHY5NdZuFdCGmmU+aFyHeGOfIb3hC7HoMiYuJj7T0QSGOy9f4EaMWM83PpZGZ5T
         R7T6fchovkBBh1i92x5Qqle2hJ9zZqwDJ18glJAwV+MRt2AUi9qB+xPDwkFIZ4o2gdCr
         glTqblW0NE510bXkJVm6sd9ANsh+KmoDYKFBPffpy9J0oOJY/sNFXJ243ATgcsToPVzB
         uU9g==
X-Gm-Message-State: AOAM5332MF2ifTMHYhBnaX5EiukODiFi0qtqmbHDU8iTPXQSBz1idSo5
        EsN8ahHjE2WGg79ziOq+LtmBcMlRQ64r2pNqvJ8czkNMIak=
X-Google-Smtp-Source: ABdhPJzf4sXua4bct76Oyku4J/3wXX8VMl6ys/ENNwkiwS8pSsja0y2cQ4G4/bZEmsVFbs/m4R20xIdtzkR0sQhil10=
X-Received: by 2002:a05:6122:818:b0:357:26f8:5e73 with SMTP id
 24-20020a056122081800b0035726f85e73mr243934vkj.5.1652894345690; Wed, 18 May
 2022 10:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220518092619.1269111-1-chenhuacai@loongson.cn> <CAK8P3a15oQNZvST56v0AvtC1oZP4iDHy-QMLwZuDAg30gq-+4A@mail.gmail.com>
In-Reply-To: <CAK8P3a15oQNZvST56v0AvtC1oZP4iDHy-QMLwZuDAg30gq-+4A@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 19 May 2022 01:18:53 +0800
Message-ID: <CAAhV-H73Ymi6HVoEoYx6UbfZFeS+VtxUwTVvNzhiyycjVocYOQ@mail.gmail.com>
Subject: Re: [PATCH V11 00/22] arch: Add basic LoongArch support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Wed, May 18, 2022 at 9:42 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, May 18, 2022 at 10:25 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
> > LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
> > version (LA32S) and a 64-bit version (LA64). LoongArch use ACPI as its
> > boot protocol LoongArch-specific interrupt controllers (similar to APIC)
> > are already added in the next revision of ACPI Specification (current
> > revision is 6.4).
> >
> > This patchset is adding basic LoongArch support in mainline kernel, we
> > can see a complete snapshot here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/log/?h=loongarch-next
>
> Stephen, can you add this branch to the linux-next tree?
>
> I see there are still comments coming in, but at some point this has
> to just be considered good enough that any further changes can be addressed
> with patches on top rather than rebasing.
>
> > V10 -> V11:
> > 1, Rebased on asm-generic tree;
>
> I was expecting that you'd base this on just the spinlock changes from Palmer's
> tree that are part of the asm-generic tree rather than all of what I have.
>
> Can you rebase it once more? If there are conflicts against the h8300 removal
> series that is also in asm-generic, leaving it on top of that may be
> easier though.
Thank you very much, I have rebased the below tree on asm-generic
tree's spinlock commit 9282d0996936c5fbf877c0d096a3feb45 again, and
fixed some small problems from Eric and WANG Xuerui's comments in V11.
https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/log/?h=loongarch-next

Huacai
>
>         Arnd
