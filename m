Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E5F5A3495
	for <lists+linux-arch@lfdr.de>; Sat, 27 Aug 2022 06:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbiH0El4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Aug 2022 00:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiH0Elz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Aug 2022 00:41:55 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01722B9410;
        Fri, 26 Aug 2022 21:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1661575310;
        bh=q+IArlEpqH3K0OESnbUSCutT/nF8iPeKxS4hKoZSRns=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=l79NVx+MukLMvGJg7tcyGcezWwlf9tBna2OAmZucrLhO2xX16/BgG1jxsXyPVbJm4
         CJZ/iXP1Oy5Vy6L//Ure38cqukMCtgKzJgtbEtTR7B5pp3Es0HBkSPzu6kKAn+EyDu
         yf9xpZoLvL7HrAsKUZ3lmnmr2MzpngBZOQw9oPMs=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 7285A66A06;
        Sat, 27 Aug 2022 00:41:47 -0400 (EDT)
Message-ID: <9b6f0aeaebbd36882b5b40d655f9ccd20c7be496.camel@xry111.site>
Subject: Re: [PATCH V3] LoongArch: Add efistub booting support
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 27 Aug 2022 12:41:45 +0800
In-Reply-To: <20220819102037.2697798-1-chenhuacai@loongson.cn>
References: <20220819102037.2697798-1-chenhuacai@loongson.cn>
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

Tested V3 with the magic number check manually removed in my GRUB build.
The system boots successfully.  I've not tested Arnd's zBoot patch yet.
--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
