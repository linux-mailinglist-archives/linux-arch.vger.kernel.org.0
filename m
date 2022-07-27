Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D745820A7
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jul 2022 09:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiG0HFV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jul 2022 03:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiG0HFU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Jul 2022 03:05:20 -0400
X-Greylist: delayed 332 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Jul 2022 00:05:19 PDT
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BF6B1D4
        for <linux-arch@vger.kernel.org>; Wed, 27 Jul 2022 00:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1658905183;
        bh=LUb7IaUmkPxUtf7zK+C9AQwLgqePZGGBUxeRPAmvHjE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=O6EdaYemcI9C8hjUGHbHxBdnoVJ13AMudulaz4am2tqsz5lpWUCQyQkVy+h3bmW1y
         maheLpyuQaV+eB5sUU0HryVgfLGLHThPtwuzIVuOF0dvPpJuaN9Y2oEcfUdcOU59Pp
         WALomcJsfBfK1KmGqL6QVK/TRc4FMheoW8d9iNVY=
Received: from [IPv6:240e:358:1119:7700:dc73:854d:832e:3] (unknown [IPv6:240e:358:1119:7700:dc73:854d:832e:3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id AC535667AD;
        Wed, 27 Jul 2022 02:59:37 -0400 (EDT)
Message-ID: <221507a09870312d86193b96f680cdf4fa5742fc.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Disable executable stack by default
From:   Xi Ruoyao <xry111@xry111.site>
To:     WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Wed, 27 Jul 2022 14:59:29 +0800
In-Reply-To: <c873f358-628a-72d9-42e3-5f40354745b1@xen0n.name>
References: <20220726130224.3987623-1-chenhuacai@loongson.cn>
         <c873f358-628a-72d9-42e3-5f40354745b1@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2022-07-26 at 21:10 +0800, WANG Xuerui wrote:
> On 2022/7/26 21:02, Huacai Chen wrote:
> > Disable executable stack for LoongArch by default, as all modern
> > architectures do.
>=20
> I don't know why this slipped in under everyone's eyes... Struggling
> to=20
> recall some of my mental activities during the initial review, I may
> be=20
> not too familiar with the code at that time (maybe still the case
> now),=20
> and didn't check what exactly "read_implies_exec" means in this=20
> particular context. That could be just the reason for my part.
>=20
> But better mention the discussion leading to the discovery of this
> bug:=20
> "The problematic behavior was initially discovered by Andreas Schwab
> in=20
> a binutils discussion [1], fix suggested by WANG Xuerui" or something=20
> along the line.
>=20
> [1]: https://sourceware.org/pipermail/binutils/2022-July/121992.html

I think we already have a "standard" format for this:

"Reported-by: Andreas Schwab <...>"
"Suggested-by: Wang Xuerui <...>"
"Url:=C2=A0https://sourceware.org/pipermail/binutils/2022-July/121992.html"

Tested on my A2101 board and nothing is broken so far.

Tested-by: Xi Ruoyao <xry111@xry111.site>


--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
