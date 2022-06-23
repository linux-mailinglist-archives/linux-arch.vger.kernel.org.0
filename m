Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54F95573B5
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jun 2022 09:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiFWHQf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jun 2022 03:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiFWHQe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jun 2022 03:16:34 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0211745AC8
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2022 00:16:33 -0700 (PDT)
Received: from mail-yw1-f172.google.com ([209.85.128.172]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mzhf5-1nijsf0Bhx-00vivW for <linux-arch@vger.kernel.org>; Thu, 23 Jun
 2022 09:16:32 +0200
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-317741c86fdso183541397b3.2
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2022 00:16:31 -0700 (PDT)
X-Gm-Message-State: AJIora++qaoSBjN9YSeUjbgeDQTPBWAB3yFeGZjjYA8oJGRvYa1G1rLe
        M2cUP5gl1mIrtN2uscI0yNCRtcqQGglwb1oywo8=
X-Google-Smtp-Source: AGRyM1v3K64weei10Dq+jkC+TjAoXGUuY8pU5spc3/vrhIwWzmQ9dEdLhsgO1uNzSsDcRPd9iYeWBkq4oZjx7KI3a5E=
X-Received: by 2002:a81:c08:0:b0:317:8131:2b21 with SMTP id
 8-20020a810c08000000b0031781312b21mr9167858ywm.249.1655968590884; Thu, 23 Jun
 2022 00:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220623025200.1824399-1-chenhuacai@loongson.cn>
In-Reply-To: <20220623025200.1824399-1-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 23 Jun 2022 09:16:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0hf8sSXqu14WkYO0yy7hSOn3y6FaE3vqDW7J1JPVcZWA@mail.gmail.com>
Message-ID: <CAK8P3a0hf8sSXqu14WkYO0yy7hSOn3y6FaE3vqDW7J1JPVcZWA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Fix the !THP build
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:YXaINCma2a1jz7teOXWRDmDvsljqRb+YDUA3wqvZWRke9qquxiN
 wjhck8jIKLNCWfn3gIS+k/lsumQ9JdDXUSdr6/rPuToZvWqYuURThEtEdpPw0g0lXWrOKTM
 zv6F2/8MDsOwEWT5Qwiy1dxdPE/L3mL9X7raBW6ahvd1AUXwpPn5EYEbquwvwExX3Synpco
 71Jg5YFWt+Y7WL/ZrCUQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3rWpoQS+vLo=:8sqXCo/RBL6F4NiASbAA9G
 KWrxO8b8InszzwSg5+zAqB+wsus1NKIbu8FCVQbkxxq/DfgUmAYdBcYciJ1rRwzt7kvcNRMvw
 RuYdo36UvTWHpMBGvb4cRoiczGpo2oysuzzeCpz8eNbyCbw4GMo3xrVvd6TS5j6xG2OPn7KaX
 8nmRcgmjD7qd7TcZP1WC4X/YJ78SZHGLr2/vZstE7oX0WfNVUOE3FTovER1t9eq1gN2S1YUY1
 pd0mXXwbrK7pnvR4PcBVJycq9r06Tynm+tiLA6IrebV1eFZosdi9sBNg6wtdmvK/2yjfcX6O6
 mTkDDjM7SbJZPU9yUdA9nP+0zb1qZHIbNn+cx6UEA5qoxwkM1btgaaQWiua0Z/oXlqPE2H7TK
 axYrulvqmiJoZAIbjSJszt0vxGBnlmLKvXYu1USbaLN4wQLv8bHX5EWH1K/0jY6+O7t4px6SO
 bO4rfXAcbL7x5FEVGE0GOGooB/5PFv0veYGdHJGftnBugA65kdmzu4JvOEdnFTx+qRQ+lY5Lg
 d8y/RYbIKt3zBtMKK9spIcd4Qz2KJIIkccIEz1DjLmMyqfukuUuuTAGwa1yTSoEviYzKbqOgT
 y7souu+aqNMkfGmpnhCvbUHQE9WFwmVVaiN5XR74oaWsQdtuToBk6g0wKNdPNZMDDhnB8AHNh
 ou+H3WmCHHbFpBNM63fyhwLzW9Th666OcVsZ5/W+PYEJIegjeLRS4nJog1lZ27joi7wizeWhk
 ZeeXcHmSFqIQetvXnTEy7HYGCZlg+wR4jKUS9w==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 23, 2022 at 4:52 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> Fix the !THP build by making pmd_pfn() available in all configurations.
> Because pmd_pfn() is used in mm/page_vma_mapped.c whether or not THP is
> configured.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Both bugfix patches look good to me. I assume you'll just send a pull request
to Linus from your kernel.org account, rather than going through the asm-generic
tree for follow-up patches. Let me know if you need me to put it into my tree
instead.

         Arnd
