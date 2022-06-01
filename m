Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768D553A986
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jun 2022 17:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237273AbiFAPDB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jun 2022 11:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbiFAPDA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2022 11:03:00 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314702E098;
        Wed,  1 Jun 2022 08:02:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8AEBBCE1C8F;
        Wed,  1 Jun 2022 15:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98636C341C6;
        Wed,  1 Jun 2022 15:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654095775;
        bh=8/8Dqt7lHlQXIOpD2zHMmCEDbzvSyb/HvY35cO28GuM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CshL6cUkrGb9fMbFRbpuSnmZTIGR+zXxn6aKc9T5amldvX1pPV94osIfCVDg65TvP
         3O2KnRssf/53KHAwxb4xaSPxBmwaRlRo1bJuktabgqQW/wmHRcjOFzZ8beqX/z1kPN
         y8JJIgBHrnE7oe1dvyk7/hJzCl2diXjbmmWv/dFSCTWgosxXcrv557R/OL6B33EOvR
         +ZAaLz/UK/w5AliBvYHGPJ343Tz8yWhqKoJBiHpOcrMnSnCMRFDwJHEZ+R+AuqdxUZ
         5I6ZVW3OWpiJX8zG7lT8lT5x69bdTHpftOTuKCWvLf1nkNsc/aalp7QmPUbveyazKk
         dkF46dtGsJ5lQ==
Received: by mail-ua1-f49.google.com with SMTP id p3so651739uam.12;
        Wed, 01 Jun 2022 08:02:55 -0700 (PDT)
X-Gm-Message-State: AOAM533zvyJC9rNiqVfSaCzl3YJ+B4BjPqvgR9z+ocgmbAvG3lzl2yv5
        j6kJpqi2D7YNX8ecLJFr2gsICRNHwta67GqkWg4=
X-Google-Smtp-Source: ABdhPJx7FHmn9+wq7yaCR+nLhzPf5hHqvsbj31ciz15OGyUafxDwxjV7XaQR4x1mjpfI/skNfe4qLRlhLukVn/XgxBU=
X-Received: by 2002:a9f:23c2:0:b0:365:958:e807 with SMTP id
 60-20020a9f23c2000000b003650958e807mr22773846uao.114.1654095774502; Wed, 01
 Jun 2022 08:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220601100005.2989022-1-chenhuacai@loongson.cn> <2c21b163-9eea-4221-b92c-afe471853add@www.fastmail.com>
In-Reply-To: <2c21b163-9eea-4221-b92c-afe471853add@www.fastmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 1 Jun 2022 23:02:43 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRFB023wz0gh7=fhYsDu+BWUWNXgn=14be26-2ppTsc5A@mail.gmail.com>
Message-ID: <CAJF2gTRFB023wz0gh7=fhYsDu+BWUWNXgn=14be26-2ppTsc5A@mail.gmail.com>
Subject: Re: [PATCH V12 00/24] arch: Add basic LoongArch support
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
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
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Xuerui Wang <kernel@xen0n.name>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 1, 2022 at 8:44 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
>
>
> =E5=9C=A82022=E5=B9=B46=E6=9C=881=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8A=E5=
=8D=8810:59=EF=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
> > LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
> > LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
> > version (LA32S) and a 64-bit version (LA64). LoongArch use ACPI as its
> > boot protocol LoongArch-specific interrupt controllers (similar to APIC=
)
> > are already added in the next revision of ACPI Specification (current
> > revision is 6.4).
> >
>
> I=E2=80=99ve been reviewing all LA changes in past week and now I=E2=80=
=99m giving out R-b
> for every patch I had reviewed in detail. (I don=E2=80=99t really now any=
thing about
>  mm and processes so I just leave them).
>
> I also tried to run the kernel on my machine with Huacai=E2=80=99s next t=
ree and
> Xuerui=E2=80=99s BPI patch.
>
> I watched the =E2=80=9CNew World=E2=80=9D of LoongArch grow up from scrat=
ch. And I must
> say it=E2=80=99s a epic work showing the collaboration between community =
and Loongson
> company. Especially Xuerui who invested numerous days and nights without =
any
> return.
>
> Thanks to all people involved.

Great job, best wishes to all of you.

>
> - Jiaxun
>


--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
