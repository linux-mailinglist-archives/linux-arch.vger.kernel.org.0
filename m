Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4897695E1D
	for <lists+linux-arch@lfdr.de>; Tue, 14 Feb 2023 10:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjBNJGl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Feb 2023 04:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjBNJGX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Feb 2023 04:06:23 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F802413F
        for <linux-arch@vger.kernel.org>; Tue, 14 Feb 2023 01:05:35 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j23so14906883wra.0
        for <linux-arch@vger.kernel.org>; Tue, 14 Feb 2023 01:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UN96HvyAH3A0F2+hA45TCkXOEUd+s53tiI7+aSVqnGA=;
        b=WP20i8MASM2rCtGp2Z93dGmU3cHmgSrcGF/TuhBxt26HL8dLV8rMBWxB7sa8KBt4Tv
         IL6JfqV+420KDLNpueRS17I87wZnHynwV7GyYH2PGB5tWYRSxhfFEZxTzExAwws6mG6P
         iakcPY+GsXyCb0Vpx7GzOxxLT7GAjj6878tQ978Llodda2xKxo9vKpEvTImdNhhBzQyU
         GBTQXOLeWISX7EYhUsOut4r3WpqCivpUPrmqlCqWIZ3Nn69+5MkbHE7fIJ058QvFHCQX
         3iiN01Fw0+PayGQK0xVI5HNTUycC8oyQptZzWy5M0sPaLFpPfPKlT60lGhE8n0Vhtc/y
         UvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UN96HvyAH3A0F2+hA45TCkXOEUd+s53tiI7+aSVqnGA=;
        b=oleVJMSxBnbBHUvimrCe3MKwQ9VWLakfee/pQSIVXZlatX1MzkEAEZ+npc/0FodVeF
         2vhbs4ZP20d24Ce+/rICDn6Z6SnipDTo3gr6iUtg7Ol+Jmdy24zV0w8KGPY9KLsczODD
         GaolBdAenduUc9PRzbS5grVmlMw2x/fuCpOdVJlfspHap5wkQwAAJGn5NtCaXGpQPESx
         SGZyvpHEKSsRDbUODMoc6qD8edvrfHPInh/jqPvTwyqrp+hOyM6afTQ2fAJCRHdLO1BC
         M+fK5cXLmOyhFO2eFSIlp0NLlNgug8w1GHVjmPauOyT/jQWVWSA7DV32u4u+ljqar6Cc
         0VTQ==
X-Gm-Message-State: AO0yUKV1rISgmy8GmtXUlcRWC+mqW5ykEddHmc6OFXuIQkVwqBXLN/e6
        Sjy1H7st/E84PZ86LQjoOk/FRA==
X-Google-Smtp-Source: AK7set/bnATx/QinUZEv/kaFr37XQ6gSjCAmEMskILGrw/zUjdr7eN5YeojitqRWgY6y+UsZcveJ9A==
X-Received: by 2002:adf:ef91:0:b0:2c3:e0a0:94f with SMTP id d17-20020adfef91000000b002c3e0a0094fmr1673667wro.37.1676365532856;
        Tue, 14 Feb 2023 01:05:32 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id o7-20020a056000010700b002c559def236sm3870899wrx.57.2023.02.14.01.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 01:05:32 -0800 (PST)
Message-ID: <34543e7d-f34f-a3bb-cb64-d47da577589e@linaro.org>
Date:   Tue, 14 Feb 2023 10:05:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v3 24/24] s390: Remove empty <uapi/asm/setup.h>
Content-Language: en-US
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
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
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
References: <20230214074925.228106-1-alexghiti@rivosinc.com>
 <20230214074925.228106-25-alexghiti@rivosinc.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230214074925.228106-25-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 14/2/23 08:49, Alexandre Ghiti wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>   arch/s390/include/asm/setup.h      | 1 -
>   arch/s390/include/uapi/asm/setup.h | 1 -
>   2 files changed, 2 deletions(-)
>   delete mode 100644 arch/s390/include/uapi/asm/setup.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

