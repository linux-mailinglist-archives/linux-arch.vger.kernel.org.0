Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A410F6B3460
	for <lists+linux-arch@lfdr.de>; Fri, 10 Mar 2023 03:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCJCq2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Mar 2023 21:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCJCq1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2023 21:46:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C73DD377;
        Thu,  9 Mar 2023 18:46:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D38060921;
        Fri, 10 Mar 2023 02:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC90C4339B;
        Fri, 10 Mar 2023 02:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678416385;
        bh=tI+aEFnT7+/8bODwsopD97PexndTCnj+r/uQzEYXO3U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EgMfQk0m5WIUpglu2xgTkln1pLOIonelKl3UVfJFXMCVGjyOahjjP6JFIA7diPBrT
         j0tlh6MGGMRfHOxuM1tN9CRIk0axwECB0Ej1SaoE5W5PJ7baVk0wL/+w4xRm8vWjHO
         smxRdAh6qta08PqpVeBjGJ2qhCm7q43iHkx4+0efRgAx2exPtSJ3zsxFI6x8xUqSb/
         KVHzl38JIqNYwVxX+Q3lCjEYZmQGkNN1jqIfZ9GrfApVBWrRPZAm0qvmalbeBHv5cJ
         nH1GiLENps7bIy72xihAuFIg6Qnitm8bog5KNMFG7EpNeMjF9VYjTZ7CGEddcjUjR4
         SgHwpTlM+BTgg==
Received: by mail-ed1-f51.google.com with SMTP id g3so15067312eda.1;
        Thu, 09 Mar 2023 18:46:25 -0800 (PST)
X-Gm-Message-State: AO0yUKXgDNtuU5fWMG3rHVfOMXDZCj3JdeolF72aQt02NwvA90ySYW4e
        7eHNYCf1zSqpm9nw+i3lKdTBNL1WYaj/YPiuAmI=
X-Google-Smtp-Source: AK7set+RD1QtbOMZlvn5OyHmt5ba3zcRlj6C4U+McRvpbPwgqFpd6db/4zp+mwCWLmL/ZXEG05KXDe+Y5x+qVoVuDog=
X-Received: by 2002:a50:d543:0:b0:4af:6e08:30c with SMTP id
 f3-20020a50d543000000b004af6e08030cmr386406edj.4.1678416384101; Thu, 09 Mar
 2023 18:46:24 -0800 (PST)
MIME-Version: 1.0
References: <20230306031258.99230-1-chenhuacai@loongson.cn> <ZAoNPuyHQTqucYxn@infradead.org>
In-Reply-To: <ZAoNPuyHQTqucYxn@infradead.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 10 Mar 2023 10:46:14 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7rms0X=V7fFDRh7KQWamwevvY4fHAEEuzSrQNUgVX0Ug@mail.gmail.com>
Message-ID: <CAAhV-H7rms0X=V7fFDRh7KQWamwevvY4fHAEEuzSrQNUgVX0Ug@mail.gmail.com>
Subject: Re: [PATCH V2] LoongArch: Provide kernel fpu functions
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 10, 2023 at 12:45=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> NAK, this needs to be an EXPORT_SYMBOL_GPL.
OK, let's make it GPL again.

Huacai
>
> Also no way we're going to merge this without an actual user.
