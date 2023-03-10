Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8186B38C7
	for <lists+linux-arch@lfdr.de>; Fri, 10 Mar 2023 09:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjCJIdv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Mar 2023 03:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjCJIds (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Mar 2023 03:33:48 -0500
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3611CBF2;
        Fri, 10 Mar 2023 00:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1678437201;
        bh=H1uDGv8j82PG/omXA8I5l9seIgQwaVUrcBDhFnOLxWU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=R2lMO64b77mU3PTHDWfsWlz2g0/ciPQqjizfI8Oq2Nr5qlnw/AQpbzxAjxdYOuq17
         Ahjz4a7h4Z78AH4dR6uVZaCE3LGpVOkey6OzX0/Qm9CW/KGQ7Su/Fi8BkkfivuNC17
         RFfWU8lrfpK6tC77jLZBAbcjG+uuS2js2/te99rM=
Received: from [192.168.124.9] (unknown [113.140.11.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 1806165A8F;
        Fri, 10 Mar 2023 03:33:18 -0500 (EST)
Message-ID: <037d7f13866e03dd2cc0dd4307479fa9a7498b19.camel@xry111.site>
Subject: Re: [PATCH V4] LoongArch: Provide kernel fpu functions
From:   Xi Ruoyao <xry111@xry111.site>
To:     WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Date:   Fri, 10 Mar 2023 16:33:13 +0800
In-Reply-To: <7e743095-3dbc-3f28-a347-d2a1659e650d@xen0n.name>
References: <20230310025136.964745-1-chenhuacai@loongson.cn>
         <7e743095-3dbc-3f28-a347-d2a1659e650d@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2023-03-10 at 14:33 +0800, WANG Xuerui wrote:
> We should probably provide more archaeology or legal evidence as to why=
=20
> the in-kernel FPU ops must be GPL-only. After all the status quo is that=
=20
> among all arches that provide such ops, only the x86 ones are exported
> GPL, so if loongarch should go GPL for this interface then probably=20
> everyone else should too. It's not only affecting loongarch IMO.

If it's forced by GPL we should change the other arch's similar function
to EXPORT_GPL immediately.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
