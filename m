Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5B2776ECC
	for <lists+linux-arch@lfdr.de>; Thu, 10 Aug 2023 05:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjHJDyl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Aug 2023 23:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjHJDyj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Aug 2023 23:54:39 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49141703;
        Wed,  9 Aug 2023 20:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1691639678;
        bh=BqIWgvq5uC7Yvr8B5ZIRSSaxOGFLY8twcji8cfVK2zY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ESjXVToXL8DWZNYSs5/lY+ubN/opLxzFv5Pr0jaXNdnPDr08CUWXmRXpudspnpG2x
         GeH+tXInv6RpRdDQUS5oqKJl9xTJ/clzG5cZhCF9zV03D04iPAEAtuhZg2x/hKh1bm
         kr2og4MR4sS68IheXv0AUbM1cGIaolBye2jSoSE8=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 87E8A659AD;
        Wed,  9 Aug 2023 23:54:34 -0400 (EDT)
Message-ID: <96a02f30fe68da4551f883599631f15a8978190d.camel@xry111.site>
Subject: Re: [PATCH V2] LoongArch: Fix module relocation error with binutils
 2.41
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        WANG Xuerui <git@xen0n.name>, stable@vger.kernel.org
Date:   Thu, 10 Aug 2023 11:54:31 +0800
In-Reply-To: <CAAhV-H6JTbuK+ypvrUi21KOYcTOWmTKbwxK_D8M5y9XaXfJK4A@mail.gmail.com>
References: <20230710050024.2519893-1-chenhuacai@loongson.cn>
         <ce4cee2d76340d1776560c124c1894080ded13bb.camel@xry111.site>
         <292e6aa6b9399c8dd53562f51237090bcd6d19c5.camel@xry111.site>
         <CAAhV-H6JTbuK+ypvrUi21KOYcTOWmTKbwxK_D8M5y9XaXfJK4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2023-08-10 at 11:34 +0800, Huacai Chen wrote:
> On Thu, Aug 10, 2023 at 11:21=E2=80=AFAM Xi Ruoyao <xry111@xry111.site> w=
rote:
> >=20
> > On Thu, 2023-08-10 at 11:20 +0800, Xi Ruoyao wrote:
> > > Can we backport this patch into stable?=C2=A0 It fixes a build error =
with
> > > binutils >=3D 2.41.
> >=20
> > Correction: not a build error, but all modules won't load if built with
> > binutils >=3D 2.41 without the patch.
> Generally we can backport, but I don't think there are users who use
> the old kernels. :)

The problem is 6.4.x is not "so old": 6.4.9 is actually the latest
kernel release.  6.5.0 is not released yet.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
