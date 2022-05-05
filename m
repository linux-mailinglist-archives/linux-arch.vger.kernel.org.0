Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F3251B683
	for <lists+linux-arch@lfdr.de>; Thu,  5 May 2022 05:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241309AbiEEDYs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 May 2022 23:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241323AbiEEDYk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 23:24:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22E246142;
        Wed,  4 May 2022 20:20:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B61F6195E;
        Thu,  5 May 2022 03:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA8DC385BA;
        Thu,  5 May 2022 03:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651720857;
        bh=8W4kBn4cvHk6r3+lwf/6ButOTrWe/kiGQICQ5Hzrtlw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ULiDy+TNuXJo6HQ4a4XM1jHiaWkDRP5O+X8fId3NvLdKPBzT0svQn/OTP9SK+6huD
         5Garqm1aRrc92H33s0ghHBKvEt/mrrGT0KJOmAlZtUOeyrvGkuP8DDUFHMh0cmzdsP
         zaQMmdQmhZn0ivopaD05gh26RZspyaqNIGsbjV4F+LYn856W2yQHDl0C/D4KxcYbtZ
         f/9G1my/QNQ1n99xy6RdAZn507oz6/cU2wqOjcENbnJhK2brcnXcDFfTrteXI1JuCd
         tRJlgFhYbyMjx37jsZQb1Qn8XUbIpswzMnE3SaBz+vVw3eAoa/WXX7tuuF/pCQTpRd
         1yMP7pi7WgKng==
Received: by mail-vk1-f169.google.com with SMTP id b81so1527022vkf.1;
        Wed, 04 May 2022 20:20:56 -0700 (PDT)
X-Gm-Message-State: AOAM5338ex4wDkezIiQcqybT0cGVqNiFrdet4RYdyuBBPKyEqtFMmBXs
        ZXP4xJYqL9QKq40Qtl1/JBTsVIBsB0GlHbuStWs=
X-Google-Smtp-Source: ABdhPJyJZejNzSZk8O7z5JR3mWL5/1Sv673cZFpbPSQ+7GqKCT9F24kk4CFIyITIIwUZE190BgkA/I9p6RX4tzvx38w=
X-Received: by 2002:a1f:1856:0:b0:34e:be86:97b4 with SMTP id
 83-20020a1f1856000000b0034ebe8697b4mr5873966vky.8.1651720855656; Wed, 04 May
 2022 20:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220430153626.30660-1-palmer@rivosinc.com> <20220430153626.30660-7-palmer@rivosinc.com>
 <3100713.5fSG56mABF@diego>
In-Reply-To: <3100713.5fSG56mABF@diego>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 5 May 2022 11:20:44 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRspLiaSExBMOXODTokhBofUXrF7sKAT8wp-XnKf3VJ=g@mail.gmail.com>
Message-ID: <CAJF2gTRspLiaSExBMOXODTokhBofUXrF7sKAT8wp-XnKf3VJ=g@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] RISC-V: Move to queued RW locks
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        sudipm.mukherjee@gmail.com, macro@orcam.me.uk, jszhang@kernel.org,
        linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Wed, May 4, 2022 at 8:03 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Samstag, 30. April 2022, 17:36:25 CEST schrieb Palmer Dabbelt:
> > From: Palmer Dabbelt <palmer@rivosinc.com>
> >
> > Now that we have fair spinlocks we can use the generic queued rwlocks,
> > so we might as well do so.
> >
> > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>
> on riscv64+riscv32 qemu, beaglev and d1-nezha
>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
>
>


--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
