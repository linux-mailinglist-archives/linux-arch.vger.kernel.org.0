Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C36857B954
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jul 2022 17:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241161AbiGTPNF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Jul 2022 11:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241213AbiGTPM5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Jul 2022 11:12:57 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE89F599E3;
        Wed, 20 Jul 2022 08:12:47 -0700 (PDT)
Received: from mail-yw1-f177.google.com ([209.85.128.177]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MMGVE-1nyIv20GjW-00JHgL; Wed, 20 Jul 2022 17:12:46 +0200
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-31d85f82f0bso176937127b3.7;
        Wed, 20 Jul 2022 08:12:45 -0700 (PDT)
X-Gm-Message-State: AJIora8tWs69WeD5ca/MlwEVuRt/GYHEV5qzoqsWng4XLrV9b3qf2cKU
        JyjAzjgpg43ZM9/jMhyYs7t2z7To3XbJp3mYmao=
X-Google-Smtp-Source: AGRyM1tzl4MfM0IyEBCPbwAniHdv8s1Jto4KbP4qg6fnZySPX2LxyYvKTOEczET3MGSeEbAV4lW/gb7Lp1ezV8Pk71I=
X-Received: by 2002:a81:493:0:b0:31e:6ab9:99a5 with SMTP id
 141-20020a810493000000b0031e6ab999a5mr3756881ywe.209.1658329964540; Wed, 20
 Jul 2022 08:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220720131934.373932-1-shorne@gmail.com> <20220720131934.373932-4-shorne@gmail.com>
In-Reply-To: <20220720131934.373932-4-shorne@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Jul 2022 17:12:27 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1DMqdeawhjwCRd1W145J-NSr5c9B_waqsddGw3X_oZ_g@mail.gmail.com>
Message-ID: <CAK8P3a1DMqdeawhjwCRd1W145J-NSr5c9B_waqsddGw3X_oZ_g@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] asm-generic: Add new pci.h and use it
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:mi5LW8spM9wVWLl39mYLbmCADZYnm3wCv8zeYr7KQkeamK5NcZG
 AzRbnFLHF9VQdGzUkJY/eQ5wMG8et45EDaiTVPAYK0HyjAXHbLy3zIGzyRWRcbMZjidFpoV
 7MKs5urm2b7XLrPxWZHXGUnOFv/f/+dlSiyoB8Z83+3XLbkJOSljJTN5az8NmarXFd6HTJg
 p9cvtAUpARIdCyJixTTwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NWvXReUMoHE=:O0dCNUSqCmvENGMgWvAJAJ
 LhcwsCSrlL1s16/KQwDNw/7xgm78D7jE0aNkGBczt+meIOGyIhNRsXpTKbygCVBbmf5wKssft
 nurO6lsehVHBPPOhW9l3neWXf3Uso9QaLkc78WwwL5crCt0cv9bN4tb6BLGNVJ0W/Otip4BZX
 2pkhc6DBpd8ClYzDYhz3/hDiNb5mgemJfmOylSp3ZmM/xKp9r9Tl1u8nufotfufU5PiMfKcQb
 R+m8XqokUfq1Yy8m1HXjTOuisR9ZVJ1PP0UTTl3Vrvl/l2qXcZ/KieDQLLBHnVInJPlXsom9g
 mtnVBIUCPBsL0eFl4NhpdGffBh1b2Vb75EbqLwzzK0pTMweb9RizyKTQttmHROE6eU6thqT+d
 IODacYgGTJlnlCLdJ5X4a91eDABmwPiu/LoWTKCZ0Zan/5eoC1z/yNLGQvZN+hji+4/QrR1jO
 65aG3mSPERIF9t5yRG1GAR7xDxkhx8e/t2g5ocyJTm8THbQgD3XOF5qsF1+Adbrh9Q3sFQHru
 T8uH28qwBvUCYrrVO5OFS8Uxy98fscEz4HU2KIVdBA+a0wl5XXPCnSg8extmdNlfAL74b7FXE
 MNUZbkpmZFLCTO8YtAUbZNNkmsN2cmocY2yBaSFGrfyfDKMU2YSS32OJIYHYT71UOpgQHpsPR
 9TRbzfqwiksvU1cOH3LFI6LJjz1wWS78rgoXtvGJTUWPoF1I5qy/O8Kk5+hdKkIDDLMUzNHnB
 hm+WL10Xv6Cc9XnJeCh6tenmGk2djvJG47bNdRdOBkAcRbnm8TMEsNHhuMyzVJa0FcWAqYIb8
 pjq7WNN6loyu28VpJHfWUl2Ce0gwD0LhD3YKc1Y9PwPwLzZD6iRL6WB1aPov0PxUPfEqEFDxU
 WbZ8BSrZXO4Jo1AtCykQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 20, 2022 at 3:19 PM Stafford Horne <shorne@gmail.com> wrote:
>
> The asm/pci.h used for many newer architectures share similar
> definitions.  Move the common parts to asm-generic/pci.h to allow for
> sharing code.
>
> One thing to note:
>
>  - ARCH_GENERIC_PCI_MMAP_RESOURCE, csky does not define this so we
>    undefine it after including asm-generic/pci.h.  Why doesn't csky
>    define it?

If you want to resolve this, I think the easiest way is to add a patch
that sets this
in csky, I'm quite sure this was just a mistake on their end.

> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/lkml/CAK8P3a0JmPeczfmMBE__vn=Jbvf=nkbpVaZCycyv40pZNCJJXQ@mail.gmail.com/
> Acked-by: Pierre Morel <pmorel@linux.ibm.com>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Either way:

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
