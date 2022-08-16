Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B72359556C
	for <lists+linux-arch@lfdr.de>; Tue, 16 Aug 2022 10:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbiHPIiS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Aug 2022 04:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbiHPIhw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Aug 2022 04:37:52 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8B5564DA
        for <linux-arch@vger.kernel.org>; Mon, 15 Aug 2022 23:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1660632120;
        bh=mt/X1DAsztX7uiJWfKSzPnLpWY67m/olwMVv+4Fv7oQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Z6XlwZHuuS8QSXiu2we8oL2FEvgn1qfXnZyU6psRNpEpDR0Ro3NAbNtpUmhcmbD2g
         HMLQcHaHpvgH008AFv6yWW1p1yn6NTnAjtrrKTg5ZaxW34x65TbUzhRSIa7LSIgGDt
         5tPCnH41jzNO3aGN0SIEvf9lZFfvB1Ax9GByrw6M=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id A042B669C6;
        Tue, 16 Aug 2022 02:41:57 -0400 (EDT)
Message-ID: <b5d9df4d2f127aea7ac7358e413e09358180bd41.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Add efistub booting support
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Date:   Tue, 16 Aug 2022 14:41:55 +0800
In-Reply-To: <CAAhV-H4Bu0cJ7NAaev56EuvoP5jA-TaSGuAPZ=oG-z4EvXLqFg@mail.gmail.com>
References: <20220617145754.582056-1-chenhuacai@loongson.cn>
         <CAAhV-H7N7-XH79=N5tTtphZ_EHygPSANjHcBTZ37zWSd2sy7AA@mail.gmail.com>
         <CAMj1kXE4DDAEn1GYk7Q8XKdsNOXJ2ah=FJKE1HRjC0J_VFy60A@mail.gmail.com>
         <CAAhV-H4Bu0cJ7NAaev56EuvoP5jA-TaSGuAPZ=oG-z4EvXLqFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.45.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Tested-by: Xi Ruoyao <xry111@xry111.site>

But I'm wandering is it possible to load the kernel onto XKVRANGE
instead of XKPRANGE?

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
