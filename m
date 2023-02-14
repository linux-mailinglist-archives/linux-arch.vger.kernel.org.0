Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE33B6963FF
	for <lists+linux-arch@lfdr.de>; Tue, 14 Feb 2023 13:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjBNM5J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Feb 2023 07:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjBNM5J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Feb 2023 07:57:09 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3239C1E5F2;
        Tue, 14 Feb 2023 04:57:08 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id f16-20020a17090a9b1000b0023058bbd7b2so15395942pjp.0;
        Tue, 14 Feb 2023 04:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LvbvVZeDxlmyQ+MKMrDf7Zww7VWZ6K77IBbIyuFkUUM=;
        b=WJdnIzCNdsEVhQsGHsWOO7yTWXr+pWI+PtbYUorKW2BchHqmwSwOGYAdoPufsKo0lJ
         bXDPWjxdhH0QnGSePHf16V7IoRXQeuhXlPcWmkxu8rZSjSr3Sh7jD3eqfhHEY8D454AL
         h9BqNX+KCkb4XJj5QiYoEyv/SXP+BeQ/BY4l0AmplspY3uh+sSGXDRYM23x/cN3z17v4
         7mVXCjohMU5LW8N+7VSWMBw+LVgUYmGtE+fRcUV+X7h/ZuXCVclocMVqOgQVU0PU1ZT/
         Iaxkx1YKf72wvTPUawYrrDuiNA9tC+Rro4eK9+FeLt6f2iRUNM5NC3UOCLKbbbVT0kzB
         CWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LvbvVZeDxlmyQ+MKMrDf7Zww7VWZ6K77IBbIyuFkUUM=;
        b=joZ7j/tpT4Wha/UKCwdLWb4k/B862CaaE4FdS+JYcMOEexjFW0ZHkGUERxW63pFDMM
         WPKBNdDjGeC7v6zN763fp2W0N2nGJ7qUmDrrFFQ1dsOJGw9b46OQyzPAnNXz+DCljPk9
         5NohWkTgKgSO49Ln9SSShEja4av6vERPwEQ6LQ3QqUv+fLho4uysL4OQj5crQSaMkMzP
         ZqeLMffMEWrtAKyCKgerOOFb62GqHTbHfsCTKIAP10euu/d1kAr8QP2g2iAeJeAzyFof
         /cMWuHifpASw7txLqKJ8rxp/Rp3sSGdP2xOPugTYGJ9Kl24xifycCCmL3O3/ZWU1pwLM
         IdzA==
X-Gm-Message-State: AO0yUKWRO8NPifYCN7GYzhaVisuCTV8HzhVTJOEa/kez0BeTp1sD8xcZ
        qRwEHSVNWMhogp5HsPdMbsOh9vlJkQM1up7KBkE=
X-Google-Smtp-Source: AK7set8VxH7lwiKYZQHjj1alCNiwWZsomKyHPncWio7rYDiPFQWyD3jSnBu7216hvtJHxDxHzVWwlnilO9YoLshnmQM=
X-Received: by 2002:a17:90a:d486:b0:233:c720:e6d5 with SMTP id
 s6-20020a17090ad48600b00233c720e6d5mr2292500pju.94.1676379427739; Tue, 14 Feb
 2023 04:57:07 -0800 (PST)
MIME-Version: 1.0
References: <20230214074925.228106-1-alexghiti@rivosinc.com> <20230214074925.228106-12-alexghiti@rivosinc.com>
In-Reply-To: <20230214074925.228106-12-alexghiti@rivosinc.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 14 Feb 2023 04:56:56 -0800
Message-ID: <CAMo8BfJ_RF2C7EkZJusFuVPh0-7zpgNaj1pDf079CSKzRBrQjg@mail.gmail.com>
Subject: Re: [PATCH v3 11/24] xtensa: Remove COMMAND_LINE_SIZE from uapi
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 14, 2023 at 12:01 AM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> As far as I can tell this is not used by userspace and thus should not
> be part of the user-visible API.
>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  arch/xtensa/include/asm/setup.h      | 17 +++++++++++++++++
>  arch/xtensa/include/uapi/asm/setup.h |  2 --
>  2 files changed, 17 insertions(+), 2 deletions(-)
>  create mode 100644 arch/xtensa/include/asm/setup.h

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
