Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EC64E224F
	for <lists+linux-arch@lfdr.de>; Mon, 21 Mar 2022 09:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345323AbiCUIkS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Mar 2022 04:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345232AbiCUIkQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Mar 2022 04:40:16 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F2B21821;
        Mon, 21 Mar 2022 01:38:50 -0700 (PDT)
Received: from mail-wr1-f43.google.com ([209.85.221.43]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MOAJt-1nhXAu00Dp-00OUpg; Mon, 21 Mar 2022 09:38:49 +0100
Received: by mail-wr1-f43.google.com with SMTP id p9so19575698wra.12;
        Mon, 21 Mar 2022 01:38:48 -0700 (PDT)
X-Gm-Message-State: AOAM532zG0r5Z7rmM/TUx5+bv2dR352oQSPnVsHLMof6qJLc5NhDkEFu
        lCYGE7lFqzKMgVHeWdElQNzVt2eqxFAptLDVSY0=
X-Google-Smtp-Source: ABdhPJzC1aPs0mRRzYw94T1L169g4imODEwIVrWcSBzsU4X1Z77CvsT1+Hkq9ngveBo9XP4ELRkzqz2K49xJzH0geF4=
X-Received: by 2002:a5d:66ca:0:b0:203:fb72:a223 with SMTP id
 k10-20020a5d66ca000000b00203fb72a223mr10115814wrw.12.1647851928676; Mon, 21
 Mar 2022 01:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220319142759.1026237-1-chenhuacai@loongson.cn>
 <20220319143817.1026708-1-chenhuacai@loongson.cn> <20220319143817.1026708-3-chenhuacai@loongson.cn>
In-Reply-To: <20220319143817.1026708-3-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 21 Mar 2022 09:38:32 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2gKGuMTLawFSf1hd3LY7rCVUquTPVHMcxBTok6+y-Rag@mail.gmail.com>
Message-ID: <CAK8P3a2gKGuMTLawFSf1hd3LY7rCVUquTPVHMcxBTok6+y-Rag@mail.gmail.com>
Subject: Re: [PATCH V8 10/22] LoongArch: Add exception/interrupt handling
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
X-Provags-ID: V03:K1:hrZpOzbz9UmNY/btGpxVdxrIMhvMeFOM+sdnRcOMkJDPD6kxYJc
 /GWI2Wuawvw6GiZ1GJ7/fhxD6VCq86O+wUK9RqmvazaoHZSdzLl+vMow33tuaJyqnY+ojx5
 ucdD73T34t9SqPtHkNxiVkqG52UUKvDgEUS2PZcTjICGBSSqkh2ho9QeUgS6qOqgGbDeFe0
 L8pyadSbr0/hpkirl1fiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vJ5rL7UIry4=:zhPxe3hGPfuwfe68NqQ39G
 /sg3ea8jlmvaAl/x7P3QkfnPJlSRuuvTCY5CkigfQheRQOaV1qrlxzLUTQZzQxLXztaDxy+Bm
 5z9iC/asCl4Ek5Mjx+2MRRjYYmlcOSEDO+BldRQg1Yh9uEKxA0JuXrDILpW6jpaJ5gjOFbKF8
 CjBubhF9SLbFmOSZvQmzetyA3oXipZGhx7DseuxAv4AYIGzEQI2SLmKtE6S/2Br0hNFz6oRTN
 PqrUCctd0G15oQtXW2L8b5bndNyTnFcfAIP0T1hTtizw3nw2AixWsNes0/XeirbWIyJsfUFMp
 C+RFyZ3g6IZIC5IqwZcYMmA0D17qO6AlLHQ9rTOnXNXfKaYoLIOA2i3qddjw7MVlbw1SGgWgt
 pIWWwbw3kM9Ht8bo2zOWWQKfcveil6POPPRcBqEeRXTXSky22E0zN2veXNvQcO06lpw7v8Ide
 4WfQi8x6kU0ha+B24QNpvC7VEq0NWL+nAY4YGoVPIeiK7+pI3w/wjJSXDqj24kbi/iv1MICFi
 lltIooFhcV42kXNXJeE07ZqptRftLoW8n0XXTTQboYEzLnSIDSYyI2T0fASu8v0JLTxAUkdJb
 j/B/GqQLJlyo2Jqm8avNGt8jC01oiliIZYcnKTahJaCsMYJZ4XiOJphS0DHwVFqoO9cNQf9Bw
 CijxPiFdbsMDGrpAYjPWsaYWOPNQDJVWRyd5+F6xmDwlxnhKF6GxjjPvKuRHL6AxxpKtr9WfH
 P3AnvY3TWO+UH19L+G7vaRzPp4uIeRv1E574+xL3XRxW8M+Eclsao9gdyoWCJtrFkmJs/hlIo
 wcXGmjvZz7yjXU423lsFoSKWbWFqnmrxVlZO5pcQFwumJOSRpo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Mar 19, 2022 at 3:38 PM Huacai Chen <chenhuacai@kernel.org> wrote:

> +unsigned long eentry;
> +EXPORT_SYMBOL_GPL(eentry);
> +unsigned long tlbrentry;
> +EXPORT_SYMBOL_GPL(tlbrentry);

Why are these exported to modules? Maybe add a comment here, or remove
the export if it's not actually needed.

       Arnd
