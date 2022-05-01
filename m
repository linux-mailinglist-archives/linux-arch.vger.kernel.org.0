Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFFE51653A
	for <lists+linux-arch@lfdr.de>; Sun,  1 May 2022 18:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349073AbiEAQap (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 1 May 2022 12:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238590AbiEAQao (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 1 May 2022 12:30:44 -0400
Received: from mengyan1223.wang (mengyan1223.wang [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36F5B7FD;
        Sun,  1 May 2022 09:27:18 -0700 (PDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@mengyan1223.wang)
        by mengyan1223.wang (Postfix) with ESMTPSA id 4F9BB66572;
        Sun,  1 May 2022 12:27:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mengyan1223.wang;
        s=mail; t=1651422438;
        bh=ALSJSv8A+BX4KvgFoFkSkIrjhFtjXG2yRggtMxZ7sBw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JDW/VZQ4Xej666lypIysa7YDCKe5n59BDSNNZEC4o5y1nFR7nAUJtsf5vPSRD53dq
         vR2K2VJf35Q2xn7OYzROVFze7wohQGSJVegAmqJDd/p7xV6+5An11IIjKwN0Rba23w
         VkAd2ybE14g7ic9klBWX33LgGB5bqzFTMB1I0jtGGzdtKYJqjAx5Kg7qxPC3md/4JQ
         iKxF4pKxY0Ny3YGgkcSe92dwvygVwh3TKVZYjXwbgaK8rw0sK3dmPzEZCLZPTbd4cK
         Zo/LNuHu+wKJLIoKYoslSyFIkiY6QE+7mR1gEcqNvBZwTOuf/34YxOETPQIMOw4IsO
         RVIT4kvdIeMKg==
Message-ID: <4dd26d88b807c967dbbc81a7b2e5f4084d9603d7.camel@mengyan1223.wang>
Subject: Re: [PATCH V9 10/24] LoongArch: Add exception/interrupt handling
From:   Xi Ruoyao <xry111@mengyan1223.wang>
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Mon, 02 May 2022 00:27:12 +0800
In-Reply-To: <20220430090518.3127980-11-chenhuacai@loongson.cn>
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
         <20220430090518.3127980-11-chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 2022-04-30 at 17:05 +0800, Huacai Chen wrote:
> +struct acpi_madt_lio_pic;
> +struct acpi_madt_eio_pic;
> +struct acpi_madt_ht_pic;
> +struct acpi_madt_bio_pic;
> +struct acpi_madt_msi_pic;
> +struct acpi_madt_lpc_pic;

Where are those defined?  I can't find them and the compilation fails with:

arch/loongarch/kernel/irq.c: In function =E2=80=98find_pch_pic=E2=80=99:
arch/loongarch/kernel/irq.c:48:32: error: invalid use of undefined type =E2=
=80=98struct acpi_madt_bio_pic=E2=80=99
   48 |                 start =3D irq_cfg->gsi_base;
      |                                ^~
arch/loongarch/kernel/irq.c:49:32: error: invalid use of undefined type =E2=
=80=98struct acpi_madt_bio_pic=E2=80=99
   49 |                 end   =3D irq_cfg->gsi_base + irq_cfg->size;
      |                                ^~
arch/loongarch/kernel/irq.c:49:52: error: invalid use of undefined type =E2=
=80=98struct acpi_madt_bio_pic=E2=80=99
   49 |                 end   =3D irq_cfg->gsi_base + irq_cfg->size;
      |                                                    ^~

--=20
Xi Ruoyao <xry111@mengyan1223.wang>
School of Aerospace Science and Technology, Xidian University
