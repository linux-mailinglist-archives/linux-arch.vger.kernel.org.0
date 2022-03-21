Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF334E223A
	for <lists+linux-arch@lfdr.de>; Mon, 21 Mar 2022 09:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345281AbiCUIdM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Mar 2022 04:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345282AbiCUIdL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Mar 2022 04:33:11 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7085E158;
        Mon, 21 Mar 2022 01:31:46 -0700 (PDT)
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MBDzc-1nMpmp02H8-00CgfB; Mon, 21 Mar 2022 09:31:45 +0100
Received: by mail-wr1-f53.google.com with SMTP id r13so4543509wrr.9;
        Mon, 21 Mar 2022 01:31:44 -0700 (PDT)
X-Gm-Message-State: AOAM533d2oLOP4ggDTp+ZT1ZGVxKmCEtVetk0b2ewAAwmUOlC3CHiroN
        IQPY+nqrOUDKPzhEzYmEwtvJQ05Y/hu1NeP91s4=
X-Google-Smtp-Source: ABdhPJwNXiwsoigTvelrjNs5EbXksDtDKvgY9x9aJt86WRD44JHHj4qZkGEwvdPjubVD7qa0SC7fOGzOnaEQv83dZHU=
X-Received: by 2002:a5d:6d0f:0:b0:203:9157:1c48 with SMTP id
 e15-20020a5d6d0f000000b0020391571c48mr17100710wrq.192.1647851504650; Mon, 21
 Mar 2022 01:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220319142759.1026237-1-chenhuacai@loongson.cn>
 <20220319143130.1026432-1-chenhuacai@loongson.cn> <20220319143130.1026432-5-chenhuacai@loongson.cn>
In-Reply-To: <20220319143130.1026432-5-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 21 Mar 2022 09:31:28 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3ycOKLvKunyatRETN0n3=D+=Y-EZF3aYH95G5WF8M7bg@mail.gmail.com>
Message-ID: <CAK8P3a3ycOKLvKunyatRETN0n3=D+=Y-EZF3aYH95G5WF8M7bg@mail.gmail.com>
Subject: Re: [PATCH V8 05/22] LoongArch: Add build infrastructure
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ZdHIvV1BtcEI1gX4wU//OX4oJC5NRpmkhfoVFsJOH5Jr1ZJObZw
 ln06/5/rgAjITdJsqK9oZvqddKD+Xw/zMXTQi4oV9lBtV/AZDXmP3sRC/dfvIhVHspMa8BM
 FhUoVeM1yGjwLQhS+le6bwcSGMomY6orS6SwX5QxEjARERUqxisGEnNMowa65ew/ZIZyFED
 rmXyuJB85Ed495+hSf6FQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LJxcEdo9OWc=:/wHgL8BynPJugPKJ9vsSVM
 wYYis3Vtzu9ccMa8CcyupqLNlNG6HtpunpgmyxeVDQtA/AwVCZop58PIQB2r09DnOl0TwxxKo
 t6XrBUWvHMHqd8FbMQ+xyC6Rf7DCnysl42+C1Awkv1nLNWzbn28Gl+sMDsLWzpxS++OoBCZmM
 dMfwr74msMQjS6aoRgVrsRiyWXp19ibT7rbbLq+NpQjJXPE/x5+Msao6azt+3V3igZ2AbSmiY
 EwINTKJyi6odpsYaf7QPI5qxdnm3SB53VsoX+3XNPTUKcFXOS/ossaIBt1F5B/hGt3TpVz12B
 RMDAjgTvZGyTprv37+29HpNZ+IHDY8T75zDmpoKVgk/Lq0ulf+lt6cSNAW5ylkOexnyv2/h5I
 Ml+BnkZQyFF9kZwkuCuXXajOBdQChVmSrjeO6t4xqTnQUWUXEnOn7T1mOXWZisReND+UXt6V7
 M5EW2xEqiIonmX20HYa4T8jsv6Yf0Dqj4oRjQv0AvIuINJU+yD1MOIZBpNOkWq7b8CGAx2Yoz
 coPdy2nCuwT9wJ9G5wOd/PPL3DYOI4md8rIFANFsNwzJW9aMPCZiyabsBH7+dve9UEo7l74O/
 TjcTO7qjoFCWDzR0oikvO/D2Xt5yN9KUwwOpjvkcoNsAEkRNs/NMp07fHen/vwIn3XOzx1N/0
 Wb7Shy83krg45G4A2vJNQxt61O1IcD7wDO+XT9t5F+YkwuI0YAsvybyv9LgxOmHSRbu9z0QkY
 SFsLoq+HxAkStuBNYz3r0NRtKhH0n/WmoYXFiuK+cy4i8x22sTztU8pA0IjCzrXJPeZ/tWSkj
 BmfGblBsFlOWl/ROksCJF/A+3O98gq9h5Z5QwFcccJTM+tE2e8=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Mar 19, 2022 at 3:31 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> This patch adds Kbuild, Makefile, Kconfig and link script for LoongArch
> build infrastructure.

Looks good, but I spotted one detail:

> +       select HAVE_FUTEX_CMPXCHG if FUTEX

HAVE_FUTEX_CMPXCHG no longer exists, everyone supports it now,
so you should drop this line as well.

       ARnd
