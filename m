Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BC5695E53
	for <lists+linux-arch@lfdr.de>; Tue, 14 Feb 2023 10:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjBNJJi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Feb 2023 04:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjBNJJV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Feb 2023 04:09:21 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4193324C9A
        for <linux-arch@vger.kernel.org>; Tue, 14 Feb 2023 01:08:21 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id y1so14887360wru.2
        for <linux-arch@vger.kernel.org>; Tue, 14 Feb 2023 01:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dJq3RRMzf3lbuS5bgQVc8NQ+nEsYjE4jNGYbXmQQw78=;
        b=Wsp4Zlb8V2Jx4m9+tXkDNgf5Lxau03xHaG+6WGxc+G8HrcJltAE2Px1QSC5XUlVOpz
         2Ng4jqNhjAJ4QJFwe7IYqEDhVP83rKHt0zthGOU/F+j+7d3lCfNC+HaTRTHh98F2fr7Y
         I1aHMaHeLfbmf2lAE+TKEJNN/s8peiJT6bIUpf+6MkHhRn0aKlK4U+gulZSfiKfbW+Eu
         wBNce34+0fI2Gh7tFdgEA0vsetKVHpBVYQ4d3RHWTRqruuVixLinnhKVyILNuRuoZPxH
         SlDA849VfSADVOOeo3f3/Yud1fZ/0yd8ncI6fO9i/ywnDuaYO8zFs36ALYL690/jjvZv
         Clag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJq3RRMzf3lbuS5bgQVc8NQ+nEsYjE4jNGYbXmQQw78=;
        b=JEvGz0UR0lAiIwCL6CVrbyS5E93vk15KjGDOBW+zEsbyKePeqGharZvCPXA5unXeWq
         xHEPQ9n5fS4f0cvPebIopMRPZWOdje4VwAbUG3xN228l+mripjabWYB6mMjLwY05DnUS
         cj6qvWFigzSIRIFd8aeg1aufTw6kBbLSO2w22oLgb9QUvb4FaEgYBlHRdRXf+nUi+azK
         4CdwRPFKk+jj0T8DFV8ETQRSSsaKwRpKoxO8PqIsN7p8OABFnvALOWeGkE1wroaPmjWR
         2w36dXcFe9ir8xHl127QXK5KM2uC2hQh9rTRDDt7FfXeZV5CRcu+HmkL/ZHCWyIZ4UAo
         EPFw==
X-Gm-Message-State: AO0yUKVtu7cFyuxQYFVrxRxuh7NMGqsyUWyfI4+8JGwKUe0n8r5/RagZ
        C/EcG6p274cUYoFNGhbB97cY8w==
X-Google-Smtp-Source: AK7set9xlomseTD4h4a83sLRQq4DtapmagaqXlgE7UNo4UXcLklpQodFpnducrj9Vfa/kRz/NDHZaQ==
X-Received: by 2002:a5d:4e01:0:b0:2c5:5a68:958 with SMTP id p1-20020a5d4e01000000b002c55a680958mr1356559wrt.33.1676365699836;
        Tue, 14 Feb 2023 01:08:19 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c3b8d00b003dc434900e1sm17810977wms.34.2023.02.14.01.08.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 01:08:19 -0800 (PST)
Message-ID: <f327ff48-cd50-4caa-1bea-f9906994e998@linaro.org>
Date:   Tue, 14 Feb 2023 10:08:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v3 08/24] parisc: Remove COMMAND_LINE_SIZE from uapi
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
 <20230214074925.228106-9-alexghiti@rivosinc.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230214074925.228106-9-alexghiti@rivosinc.com>
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
> As far as I can tell this is not used by userspace and thus should not
> be part of the user-visible API.
> 
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>   arch/parisc/include/asm/setup.h      | 7 +++++++
>   arch/parisc/include/uapi/asm/setup.h | 2 --
>   2 files changed, 7 insertions(+), 2 deletions(-)
>   create mode 100644 arch/parisc/include/asm/setup.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

