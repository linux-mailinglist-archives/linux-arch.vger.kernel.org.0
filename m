Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E786AAFE6
	for <lists+linux-arch@lfdr.de>; Sun,  5 Mar 2023 14:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjCEN2w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Mar 2023 08:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjCEN2u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Mar 2023 08:28:50 -0500
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE09E380
        for <linux-arch@vger.kernel.org>; Sun,  5 Mar 2023 05:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1678022925;
        bh=ZaWQHTmSRiNklxlg5kkcCCgVC4tnODce6ijtWwOheZ4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZTPkcc6wRuQsNrXyD46UE4gidUiFbhkCct0fmP79t+FmeKTAoFrkEZjxjj7UU+893
         LXypH6FLUAyVCgcm2e9eJL/4de+F7xlVOuohZLTJE41IaIeau5mIjyQQQP7mUgyvLA
         nrVa8/ya6KWlUK5vS7boTHFY0clhxB6IhPCnMUeg=
Received: from [IPv6:240e:456:1100:450:13f:c7a5:b729:8342] (unknown [IPv6:240e:456:1100:450:13f:c7a5:b729:8342])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 577DF6639E;
        Sun,  5 Mar 2023 08:28:36 -0500 (EST)
Message-ID: <58cc7e6d19628757d6d8dc192d07876288f6077e.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Provide kernel fpu functions
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Date:   Sun, 05 Mar 2023 21:28:27 +0800
In-Reply-To: <CAAhV-H55QUrkYYR1Lbj=zbquiz3frX2dNAH23fAuN6eCOUddNA@mail.gmail.com>
References: <20230305052818.4030447-1-chenhuacai@loongson.cn>
         <48f508aa-ab40-7032-a68d-90d8986afb2f@xen0n.name>
         <CAAhV-H55QUrkYYR1Lbj=zbquiz3frX2dNAH23fAuN6eCOUddNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 2023-03-05 at 20:18 +0800, Huacai Chen wrote:
> > Might be good to provide some explanation in the commit message as to
> > why the pair of helpers should be GPL-only. Do they touch state buried
> > deep enough to make any downstream user a "derivative work"? Or are the
> > annotation inspired by arch/x86?
> Yes, just inspired by arch/x86, and I don't think these symbols should
> be used by non-GPL modules.

Hmm, what if one of your partners wish to provide a proprietary GPU
driver using the FPU like this way?  As a FLOSS developer I'd say "don't
do that, make your driver GPL".  But for Loongson there may be a
commercial issue.
--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
