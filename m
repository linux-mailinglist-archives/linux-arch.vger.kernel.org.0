Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F90268BB72
	for <lists+linux-arch@lfdr.de>; Mon,  6 Feb 2023 12:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBFL0V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Feb 2023 06:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBFL0U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 06:26:20 -0500
X-Greylist: delayed 447 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Feb 2023 03:26:19 PST
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8145FD2
        for <linux-arch@vger.kernel.org>; Mon,  6 Feb 2023 03:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1675682332;
        bh=MMQELgfzmTy2xoXiOtkuiLj6chI+faYOtG4k4503QqY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FxqEIztYJEsnztsYoMzZasFmEUzUN8QwwE+GVpct7yREFVRzDZtJQJQr7aBsZTnmx
         Cskc+ZLptA9aIP+LY5WeMczatirrNccPnYmdx+MiYGBOZPHEf3mVDAmVcKgqojYzFc
         5coUMLOyLkYePMjFb+4I/ZAD6610bXAqWQOVLyXs=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 8E48365BFE;
        Mon,  6 Feb 2023 06:18:49 -0500 (EST)
Message-ID: <b1809500e4d55564a1084a3014fb9603ba3d1438.camel@xry111.site>
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
Date:   Mon, 06 Feb 2023 19:18:47 +0800
In-Reply-To: <5303aeda-5c66-ede6-b3ac-7d8ebd73ec70@loongson.cn>
References: <20230202084238.2408516-1-chenhuacai@loongson.cn>
         <5fc85453-1e2c-1f00-7879-1b5fa318c78a@xen0n.name>
         <5303aeda-5c66-ede6-b3ac-7d8ebd73ec70@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2023-02-06 at 18:24 +0800, Jianmin Lv wrote:
> Hi, Xuerui
>=20
> I think the kernels produced with and without -mstrict-align have mainly=
=20
> following differences:
> - Diffirent size. I build two kernls (vmlinux), size of kernel with=20
> -mstrict-align is 26533376 bytes and size of kernel without=20
> -mstrict-align is 26123280 bytes.
> - Diffirent performance. For example, in kernel function jhash(), the=20
> assemble code slices with and without -mstrict-align are following:

But there are still questions remaining:

(1) Is the difference contributed by a bad code generation of GCC?  If
true, it's better to improve GCC before someone starts to build a distro
for LA264 as it would benefit the user space as well.

(2) Is there some "big bad unaligned access loop" on a hot spot in the
kernel code?  If true, it may be better to just refactor the C code
because doing so will benefit all ports, not only LoongArch.  Otherwise,
it may be unworthy to optimize for some cold paths.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
