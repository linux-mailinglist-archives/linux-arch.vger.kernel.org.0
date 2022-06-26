Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D4455B0DF
	for <lists+linux-arch@lfdr.de>; Sun, 26 Jun 2022 11:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiFZJjk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 26 Jun 2022 05:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiFZJjj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Jun 2022 05:39:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084849FD6;
        Sun, 26 Jun 2022 02:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656236372;
        bh=HTV/uvihrFAjWA7e7fPC8tf5ji2lp1NnoBIr/742GVk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=deOIKi6HlsVEkbqwm5BjG1qHsQDkE1Si6S0GWT0XqWL2FFvDd7q8506yVC7ftQl8O
         8w/IDbx6JRSgJr4ka+Zd5GuACmIOKUsPUbbfH+zqjNuXsCLaLkZ6erfnxQ3IgLdw/R
         Dx3SGoJ/xl4bwQp2oHXM+KPRWq8VaQAgKS/1zJsY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.135.166]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFKGP-1nqFOE3LnV-00FiqT; Sun, 26
 Jun 2022 11:39:31 +0200
Message-ID: <2d4476f2-496e-8fea-6be9-9b610302523e@gmx.de>
Date:   Sun, 26 Jun 2022 11:39:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-parisc@vger.kernel.org
References: <20220624155226.2889613-1-arnd@kernel.org>
 <20220624155226.2889613-4-arnd@kernel.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220624155226.2889613-4-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GrHAdzyWf9bARQSXvDwaTAID+3E0L9s52IxQUqx5HxkwyvkcpKo
 wBfCSKIuu45O7PWpz3OMsu1SxW4CH2V0yVepXikx25SI9d1A4F0viWLTOfsacU6LukqLGhd
 KxsRU3NjrNU44DDlu6qPUkQX120LhSqfatXpmeLybBNvRLDDSvTu2+MUfZ2WGjGAjnkHyvy
 0vouMplAX9ef1OS9rkiaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jsnZiX9bMcY=:HrRl/k+Po+w3RmVLu6j8IY
 +uWOnSWt0EkqzLH0cFgwNOljNYcrCx2Xj5QJmLts9WIVurQ7vD1F8Wviu0uIH+vFy6Sc8o2UQ
 v7CfpfeQ+brb68qJyP9RTDuZ2Y3zRue08FEuannL5Db+ANqIyVQG9pUub6Av+8HU9JYDHVC7u
 C2h/TqmfZLczW5o+wnTXhWkKKXlpHush7YxauK4lRSZVQwGCmlzv5PLIqUKwVk9/pgzwAAdcQ
 vq5XcUw7HvYWLDu3FQ05gZ5mBFG2v+v7RK0gq7yt0Iuo2K6AXdbUcRjgGGINVRkVnjSeo+azw
 d4E9UQXJc88Q1wxiBeDeEcN8yJ3AlnUS7s8yxlTmeRh2WEwBBEfF/i3fH/GOBiytrC5wjF2D7
 UupxIp8kHKwWlF+F6t+5pT0QS2m/0UQNEwXgM0uB1aB5fxSMS0aLm8TeZ4xHTYdbH7/mA3uda
 HiinBqFgbGpl3Ze8vyWjpBzp7Q0sPQKZhEGNq9v93j9OFIBpwGnQOWZJW1yqH1VT7yjAZyRvo
 EuOvYHse1kogAlz5ivi11/VJHCQlKSdEx4h0v4UlR0lMjhfPb8kvytAkSgKlgwDC1B+WBT//+
 j6QhNoZ0/zwQnKJJQsf0NAdIbvHqU3rM90cf43eQh4VItTiORKj1uNDCmG4ugdIEWYBO4Zjn9
 thggv+TVMYo9SeuRyzZLH7WKNF5DuGUEsQAoq1YTxWpmp2YDpIQkzeHfqV6P93H1Vmlp9zx2p
 4YtyassdpTtPLCk8h1oV+zAtD9gJ9qFCzJEtAqC6uB4nZHPFzmhiDkFmPqw+s9LNrLXObSl6F
 JZbFQ/IsjqWjPJxCds1mjC5435xIGAyanYkJ0AQY00GUJoybvhH4pz5QciGhe9FVoB4+5pixD
 adcmBah/iuQzbdrtMGOXVHmnfx6/8SHlRFcR79IocR2BzzH8taSkBWpjlxRsfPN3Eg6TgbDMY
 YkjWL0TWjyJJbBuQDg22KEBdqROy5xd3SwbunTky0vOvCSWKWxrcKsjPfJmz2VU3PtZJweKtl
 cCsZ6BEHd7jdDalA3QAX6Sw1HdMskhViNSae7cxsWzeuR17+PuL/vFcAjkkltgF5QvII4a14A
 xQpea0LZGGUQ4ZWfJ9MSUGsi4fUh5nXKXKMI0maSLyu0owfiDEe4YGHCA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/24/22 17:52, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> All architecture-independent users of virt_to_bus() and bus_to_virt()
> have been fixed to use the dma mapping interfaces or have been
> removed now.  This means the definitions on most architectures, and the
> CONFIG_VIRT_TO_BUS symbol are now obsolete and can be removed.
>
> The only exceptions to this are a few network and scsi drivers for m68k
> Amiga and VME machines and ppc32 Macintosh. These drivers work correctly
> with the old interfaces and are probably not worth changing.
>
> On alpha and parisc, virt_to_bus() were still used in asm/floppy.h.
> alpha can use isa_virt_to_bus() like x86 does, and parisc can just
> open-code the virt_to_phys() here, as this is architecture specific
> code.
>
> I tried updating the bus-virt-phys-mapping.rst documentation, which
> started as an email from Linus to explain some details of the Linux-2.0
> driver interfaces. The bits about virt_to_bus() were declared obsolete
> backin 2000, and the rest is not all that relevant any more, so in the
> end I just decided to remove the file completely.
>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for this cleanup!

You may add:
Acked-by: Helge Deller <deller@gmx.de> # parisc

Helge



> ---
>  .../core-api/bus-virt-phys-mapping.rst        | 220 ------------------
>  Documentation/core-api/dma-api-howto.rst      |  14 --
>  Documentation/core-api/index.rst              |   1 -
>  .../translations/zh_CN/core-api/index.rst     |   1 -
>  arch/alpha/Kconfig                            |   1 -
>  arch/alpha/include/asm/floppy.h               |   2 +-
>  arch/alpha/include/asm/io.h                   |   8 +-
>  arch/ia64/Kconfig                             |   1 -
>  arch/ia64/include/asm/io.h                    |   8 -
>  arch/m68k/Kconfig                             |   1 -
>  arch/m68k/include/asm/virtconvert.h           |   4 +-
>  arch/microblaze/Kconfig                       |   1 -
>  arch/microblaze/include/asm/io.h              |   2 -
>  arch/mips/Kconfig                             |   1 -
>  arch/mips/include/asm/io.h                    |   9 -
>  arch/parisc/Kconfig                           |   1 -
>  arch/parisc/include/asm/floppy.h              |   4 +-
>  arch/parisc/include/asm/io.h                  |   2 -
>  arch/powerpc/Kconfig                          |   1 -
>  arch/powerpc/include/asm/io.h                 |   2 -
>  arch/riscv/include/asm/page.h                 |   1 -
>  arch/x86/Kconfig                              |   1 -
>  arch/x86/include/asm/io.h                     |   9 -
>  arch/xtensa/Kconfig                           |   1 -
>  arch/xtensa/include/asm/io.h                  |   3 -
>  include/asm-generic/io.h                      |  14 --
>  mm/Kconfig                                    |   8 -
>  27 files changed, 10 insertions(+), 311 deletions(-)
>  delete mode 100644 Documentation/core-api/bus-virt-phys-mapping.rst
