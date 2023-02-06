Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFE768BE34
	for <lists+linux-arch@lfdr.de>; Mon,  6 Feb 2023 14:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjBFNbP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Feb 2023 08:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBFNbF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 08:31:05 -0500
X-Greylist: delayed 7930 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Feb 2023 05:31:02 PST
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630E8C17B;
        Mon,  6 Feb 2023 05:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1675690262;
        bh=BcNBytG8LpyrimbJYLehCH+h5QW9ST/22z207Ized/Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=G/Bqfhy1zdS1uco+N2xY1SWkwHT7wFq3xB9lGtwxA0yLnLEipotKPEohs/i69CdTy
         KuqD6gOcfKgwj8agrf2yo84irDWtJkrui48eYypecZWFCDrSW7v4xtLLULFNM6cPhj
         O5RGNADqsH8g++daoimUkIyyWH+gvRw/xIZrGbek=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id E102965EB0;
        Mon,  6 Feb 2023 08:30:58 -0500 (EST)
Message-ID: <74ffc2c05475c6af391b87a06df477ae390cc45c.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Make -mstrict-align be configurable
From:   Xi Ruoyao <xry111@xry111.site>
To:     Jianmin Lv <lvjianmin@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 06 Feb 2023 21:30:55 +0800
In-Reply-To: <3b17d229-bad4-e6a0-9055-c585dd5a62e4@loongson.cn>
References: <20230202084238.2408516-1-chenhuacai@loongson.cn>
         <5fc85453-1e2c-1f00-7879-1b5fa318c78a@xen0n.name>
         <5303aeda-5c66-ede6-b3ac-7d8ebd73ec70@loongson.cn>
         <b1809500e4d55564a1084a3014fb9603ba3d1438.camel@xry111.site>
         <3b17d229-bad4-e6a0-9055-c585dd5a62e4@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2023-02-06 at 21:13 +0800, Jianmin Lv wrote:
> > (1) Is the difference contributed by a bad code generation of GCC?=C2=
=A0 If
> > true, it's better to improve GCC before someone starts to build a distr=
o
> > for LA264 as it would benefit the user space as well.
> >=20
> AFAIK, GCC builds to produce unaligned-access-enabled target binary by
> default (without -mstrict-align) for improving user space performance=20
> (small size and runtime high performance), which is also based the fact=
=20
> that the vast majority of LoongArch CPUs support unaligned-access.

I mean: if someone starts to build a distro for a less-capable LoongArch
processor, (s)he will need an entire user space compiled with -mstrict-
align.  So it would be better to start preparation now.

And it's likely (s)he will either submit a GCC patch to make GCC
enable/disable -mstrict-align based on the -march=3D (--with-arch at
configure time) value, or hack GCC to enable -mstrict-align by default
for the distro.  So I think we'll also need:

> +ifdef CONFIG_ARCH_STRICT_ALIGN may enable strict align by default.
>  # Don't emit unaligned accesses.
>  # Not all LoongArch cores support unaligned access, and as kernel we can=
't
>  # rely on others to provide emulation for these accesses.
>  KBUILD_CFLAGS +=3D $(call cc-option,-mstrict-align)
  +else
  +# Distros designed for running on both kind of processors may disable
  +# strict align by default, but the user may want a no-strict-align=C2=A0
  +# kernel for his/her specific hardware.
   KBUILD_CFLAGS +=3D $(call cc-option,-mno-strict-align)
> +endif

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
