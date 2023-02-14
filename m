Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2855C69644B
	for <lists+linux-arch@lfdr.de>; Tue, 14 Feb 2023 14:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjBNNKn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Feb 2023 08:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjBNNKm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Feb 2023 08:10:42 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF67C265AE;
        Tue, 14 Feb 2023 05:10:35 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id e17so8143831plg.12;
        Tue, 14 Feb 2023 05:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/UCnR+z6gmAvcqmKIJeLEMH14WiUbQ57wKTFDt5pcJ8=;
        b=AroULSWko9Zr7eGEPpWTPA6D2mG8vKfAIsqG1/UHiZHP3HX3PbVp0qrMJ+FuAJsbWS
         v05+kTojvExJxZ8W+9yB21D5w8vexFjRyphDjBsOddEZTMVdttkVBNXjxWFQ3Iqwojqw
         +DKSZuOkQRuVKSaqQXL+bh2B50zxlDW7/k12RIgkMnOVm0uYI6LnfzeI25mloiCklp33
         VHHtIf4Dpr/qSsDgSQMEDKRS4lg6TE80G2m56Li8ak7Mi6jrTmPyCPMKDQkClT1hFcFO
         HozC1z+zsQ4VmKCtjiLNbcQm7z7g/V4D6C2WAOwQT8Y+WTTuWkSjrC9wQJ19rS06uj77
         A7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/UCnR+z6gmAvcqmKIJeLEMH14WiUbQ57wKTFDt5pcJ8=;
        b=Yh6r+Cyvc3ch25WkKMIPEi6JcdDwdok7HPEIBQnK6V3sl44mwC+eZ9qNKbOBDbxtWl
         pof2JqyJXjSSkT8CMFExO6s/Qg28xNIzZkC0gf6zD/Fh+L8VnVr0nhv9e95EdfNmzZTR
         mdriLMeZO1jKC0hSUmr7gF4InzhVx6vYPbNQQ8J2yZyraPf7ek6Pouq2xaeU5/n1QvIh
         62bC+IUUpxppa3F30Zet7GzbPx34lKOrKwsgIq/jlYuYB6wCjk/1hDo9foMfVKj6XxAJ
         PfUvAkaQAcovc0GqBavEGkC2KonLbGO9yNI9xAlc31QaGUfLWltVqIdRyWQZZwBNHzML
         5ybw==
X-Gm-Message-State: AO0yUKVlmB4becgaZjpBNj4c5EG+0gsBpVCgNJr8BykApiyxmUb9E0HV
        vCKgG/aiZ7YWKDdAKAHhvWoBkfHaEEujRQyII+g=
X-Google-Smtp-Source: AK7set8wnbcla18BA65mD0tF+YGFQZaLOi1vF6MNFPYgJ+xCNbkwNuOA5gg0rl8sjl7Hw+xmx/asisuFdRpgxW5I32w=
X-Received: by 2002:a17:90a:d486:b0:233:c720:e6d5 with SMTP id
 s6-20020a17090ad48600b00233c720e6d5mr2301551pju.94.1676380235318; Tue, 14 Feb
 2023 05:10:35 -0800 (PST)
MIME-Version: 1.0
References: <20230214074925.228106-1-alexghiti@rivosinc.com> <20230214074925.228106-22-alexghiti@rivosinc.com>
In-Reply-To: <20230214074925.228106-22-alexghiti@rivosinc.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 14 Feb 2023 05:10:24 -0800
Message-ID: <CAMo8BfLCDbYWBWfF7ZJtG_U7E846RmJLF5OFdWpaFOv8ydo0Eg@mail.gmail.com>
Subject: Re: [PATCH v3 21/24] xtensa: Remove empty <uapi/asm/setup.h>
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

On Tue, Feb 14, 2023 at 12:11 AM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  arch/xtensa/include/uapi/asm/setup.h | 15 ---------------
>  1 file changed, 15 deletions(-)
>  delete mode 100644 arch/xtensa/include/uapi/asm/setup.h

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
