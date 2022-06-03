Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3EF53C811
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jun 2022 12:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243347AbiFCKC3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jun 2022 06:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242870AbiFCKCZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jun 2022 06:02:25 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1169860E5;
        Fri,  3 Jun 2022 03:02:20 -0700 (PDT)
Received: from mail-yb1-f171.google.com ([209.85.219.171]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MkIEJ-1nU5A3417J-00kczo; Fri, 03 Jun 2022 12:02:19 +0200
Received: by mail-yb1-f171.google.com with SMTP id p13so12887698ybm.1;
        Fri, 03 Jun 2022 03:02:18 -0700 (PDT)
X-Gm-Message-State: AOAM530DNDQQjAlRlN5CRoyQAnG4L8ASTtbh+7o2aMm16A2Sk89/W3OL
        xENGT24wgcOoddKWgWxALYxQCYdLX+Vr58i2ogA=
X-Google-Smtp-Source: ABdhPJwdrQ9PeeqeAjOnu3Suepya4kKybxhJDDsVtaCXf8vl4n8O7u1eitnL1Q1q/6TljwDBvrp/rGj7o3szs4WDOfw=
X-Received: by 2002:a25:bd8b:0:b0:657:8392:55c3 with SMTP id
 f11-20020a25bd8b000000b00657839255c3mr10076933ybh.452.1654250537444; Fri, 03
 Jun 2022 03:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220603072053.35005-1-chenhuacai@loongson.cn>
 <20220603072053.35005-12-chenhuacai@loongson.cn> <4213df91-c762-ae56-f08d-8c925759fa63@xen0n.name>
In-Reply-To: <4213df91-c762-ae56-f08d-8c925759fa63@xen0n.name>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 3 Jun 2022 12:02:00 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2mW7KmgxqWsaf76Q4V++B+0e6bH=tb4w4cA0XkZYuSLA@mail.gmail.com>
Message-ID: <CAK8P3a2mW7KmgxqWsaf76Q4V++B+0e6bH=tb4w4cA0XkZYuSLA@mail.gmail.com>
Subject: Re: [PATCH V15 11/24] LoongArch: Add boot and setup routines
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-efi <linux-efi@vger.kernel.org>,
        WANG Xuerui <git@xen0n.name>, Yun Liu <liuyun@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:s1NvRPCau0Hkty6Nm4xzlAtXdfIepDi+dFoTNUFwt24NqJmwVVU
 7rD3h4+KwztsLVXD98ikXQqWVcU+KjvI76ly+j73c8uAxO8s9soQscJGi+s37zERGXG7JDz
 /f9thbrgD5KSYkTlq4b2OhndTZ2aqNJha2Pot5LNNsnSRl3zsgCoooOECkKtJNHIQgfLMgH
 Ti6PLPVPR0+wZKH8N4y/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gNG8HCuRlfo=:R3uUzthMouM63SxpyLQP/b
 Lq95MJd5iFIGOdKfEXrz8zK+7TbMYxPfMzSuPXWDDHBZatdspdeRVRw/n2pLpDLJNNXXcRQ2l
 87lSAjmTQu1z6sMg6fD4IjZawPKEUDv84bVa0RyBRxnuY1BFkEUR3H+f1Ege0WQKWXDhaObRG
 ehAgQgfcVb2oFArMvYFQ64KmVZTjCX4ODRLP/Qo1e8hg2y3K50Ce3rNVyvJv/U1DnUAuzUVcz
 pnSpuUCholeTRYQd02lFHBjdq/6Vbi7DOP2cl+A3SHjKjrjrztJ7cIQ/W3ANPPcbbG/XX6wwl
 KBPq2Mdp89UrWjxYikAFHAbgbPZeWEOB6cvTaq2Hu2oUV7P8HykMmMt8FmSwYViKxwVHmu4dV
 ODu3z1BE40C2Cznhm+e3yFOXWwRlP0Wcv2R2M3QDkxmYrX911R50qtP0Ngec7tbTlBN6w3V4F
 zEl++w3dbq5M1tJ9B592GRNmiHtAdOAdd80umRUCoBYR/EcmK5i6AVqVV1P2z3miG3/abC8zA
 kXcs71t+zDUMVoEApjjidyu43HDyRKvH3hMHYU3AcQIROWck7MWVO0tdC/U/m5cR72MChwOUS
 af4pYQRPh3/tDaSfHHb9l+pcjTzRunEhqGl+QB3Jgktc3KlwWnU7GfRL1KDQGf6GxsLQPsLfs
 mhwbRoPBYz5Jq3/osOHmfXBn7ODGIBd4hkzbLucRItxPuspEk905i0gXD17HmZQAwgMBb98+M
 BFWiV887wDoofpz5nnL9gc9Llv+KzDEwG5B5I3n6hFdr/MMSPgIcjjZYgqvhIuDkmOHL3C/nS
 V+3dvqAmZr8yEUWwBLNfBWP7YJMgp6fyO3kqkK1xjLTPRbfRysaXnSGE4kCTgrRZaizvzfWuL
 mw6BeymzWYPglXk3SyhO8NGseL+GpY9HsxkIwbxOY=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 3, 2022 at 11:27 AM WANG Xuerui <kernel@xen0n.name> wrote:
> On 6/3/22 15:20, Huacai Chen wrote:
> > Add basic boot, setup and reset routines for LoongArch. Now, LoongArch
> > machines use UEFI-based firmware. The firmware passes configuration
> > information to the kernel via ACPI and DMI/SMBIOS.
> >
> > Currently an existing interface between the kernel and the bootloader
> > is implemented. Kernel gets 2 values from the bootloader, passed in
> > registers a0 and a1; a0 is an "EFI boot flag" distinguishing UEFI and
> > non-UEFI firmware, while a1 is a pointer to an FDT with systable,
> > memmap, cmdline and initrd information.
> >
> > The standard UEFI boot protocol (EFISTUB) will be added later.
> >
> > Cc: linux-efi@vger.kernel.org
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Reviewed-by: WANG Xuerui <git@xen0n.name>
> > Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Co-developed-by: Yun Liu <liuyun@loongson.cn>
> > Signed-off-by: Yun Liu <liuyun@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> Would you please look at this patch, which has all the arch-independent
> changes backed out, and Ack if it is fit for mainlining?
>
> I communicated a little with Huacai about the approach for supporting
> alternative boot protocols down the road, and we agreed to carry the
> respective changes downstream. And if needs truly arise for modifying
> common EFI logic, we can do so in a non-rushed manner later.
>
> For the current status of the code, apparently it just accepts the
> standard efistub-shape FDT pointer from (whatever booting the image),
> and everything onwards are fully using the common code without
> modification as you can see from the diffstat. I rebased my BPI support
> patch on top of this (basically translating Loongson BPI data structures
> into the expected FDT form), and can confirm the boot can progress to
> the same point as before -- indeed the SVAM changes etc. are not
> necessary for a working system, and the code remains working.

I'm a bit lost here: Does this mean the v15 version is back to the old
pre-efistub interface and allows booting with existing firmware, or
is it now left out completely? I still see a kernel_entry() function
in head.S, and I see references to loongson_sysconf, but I don't
see if that is what gets passed in from the bootloader.

I really want to make sure that without the EFI stub, there is no
other way to boot the kernel that would have to get maintained
in the long run.

        Arnd
