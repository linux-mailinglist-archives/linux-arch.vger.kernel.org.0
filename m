Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA0C6ABF26
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 13:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjCFMJ3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 07:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCFMJ2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 07:09:28 -0500
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3581E9E0;
        Mon,  6 Mar 2023 04:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1678104567;
        bh=Sjwa9ifIBvxLH+dQt5f1i4tLOr8oSfIbilkx/Lz3tZU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JgvhxuBXzmO/JFFrY6NaobpfeAEx2fKF6uTzyu7RhIz94OhM8uNx8f7WhjhkJJDn6
         egE2ld5rSmB9X0As4d48F3zNMYh6BjJC4biQoVVYZ6aBYjWTqPa3TpzWPM0Jf29Kgr
         YAuAN5NqVPNJF0hqywWdbqHOopwTxbF+wIyR66xA=
Received: from [IPv6:240e:456:1020:bd2:48ae:29ab:cdd8:861c] (unknown [IPv6:240e:456:1020:bd2:48ae:29ab:cdd8:861c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 1DB7366304;
        Mon,  6 Mar 2023 07:09:18 -0500 (EST)
Message-ID: <95273478173af301f3b63b9be2559213e4f29fb8.camel@xry111.site>
Subject: Re: [PATCH V3] LoongArch: Provide kernel fpu functions
From:   Xi Ruoyao <xry111@xry111.site>
To:     maobibo <maobibo@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Date:   Mon, 06 Mar 2023 20:09:07 +0800
In-Reply-To: <029a5993-b993-ab73-0a14-0df9b0ddf3da@loongson.cn>
References: <20230306095934.609589-1-chenhuacai@loongson.cn>
         <029a5993-b993-ab73-0a14-0df9b0ddf3da@loongson.cn>
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

On Mon, 2023-03-06 at 20:03 +0800, maobibo wrote:
> =E5=9C=A8 2023/3/6 17:59, Huacai Chen =E5=86=99=E9=81=93:
> > Provide kernel_fpu_begin()/kernel_fpu_end() to allow the kernel itself
> > to use fpu. They can be used by some other kernel components, e.g., the
> > AMDGPU graphic driver for DCN.
> Since kernel is compiled with -msoft-float, I guess hw fpu will not be
> used in kernel by present:). However it is deserved to try.

See the draft AMD DCN support patch:
https://github.com/loongson/linux/commit/0ee299095c963938a7626c3121a8feef32=
251301

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
