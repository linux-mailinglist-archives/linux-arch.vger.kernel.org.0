Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0B96AC01B
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 14:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjCFNBq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 08:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjCFNBm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 08:01:42 -0500
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE332CC76;
        Mon,  6 Mar 2023 05:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1678107651;
        bh=x4OiSeqm96Mko23JtVo1P9Ks41E5WbC4X2ynF+KSPsc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JmMG3PN74D480ekuBhMeAtF5rAXDWQalW3bCvdzECS3SDRz2NTSnRZ6Cub0e+v6Yv
         TgGRomJTcHlCCSkcs88xEh5NrZR38BE9060R/9pl3976cKnL0C8jyLMKagF4JnHtfR
         TPQLkJ1Zqbj/BNG7FUj/dY2EsoYpBBvecZdWFl9Q=
Received: from [IPv6:240e:456:1020:bd2:48ae:29ab:cdd8:861c] (unknown [IPv6:240e:456:1020:bd2:48ae:29ab:cdd8:861c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 0557A6631C;
        Mon,  6 Mar 2023 08:00:39 -0500 (EST)
Message-ID: <59f11842359f8b3330ea036ca0bf6d5776e4870a.camel@xry111.site>
Subject: Re: [PATCH V3] LoongArch: Provide kernel fpu functions
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@kernel.org>, maobibo <maobibo@loongson.cn>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Date:   Mon, 06 Mar 2023 21:00:33 +0800
In-Reply-To: <CAAhV-H6_-iVAK6-MmfJq12JBzD6nyYNOiObEbzu8yzew3raAvg@mail.gmail.com>
References: <20230306095934.609589-1-chenhuacai@loongson.cn>
         <029a5993-b993-ab73-0a14-0df9b0ddf3da@loongson.cn>
         <CAAhV-H6_-iVAK6-MmfJq12JBzD6nyYNOiObEbzu8yzew3raAvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2023-03-06 at 20:49 +0800, Huacai Chen wrote:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!is_fpu_owner())
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 enable_fpu();
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 else
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 _save_fp(&current->thread.fpu);
> > Do we need initialize fcsr rather than using random fcsr value
> > of other processes? There may be fpu exception enabled by
> > other tasks.
> Emm, I think initialize fcsr to 0 is better here.

I guess it's necessary: if we use a "dirty" FSCR0 with some exceptions
enabled (esp. inaccurate exception which is expected as disabled by most
developers), we may end up oops with a kernel FPE...
--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
