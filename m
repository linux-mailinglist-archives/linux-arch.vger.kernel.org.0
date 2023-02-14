Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74BB695F99
	for <lists+linux-arch@lfdr.de>; Tue, 14 Feb 2023 10:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjBNJqG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Feb 2023 04:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjBNJpz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Feb 2023 04:45:55 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443A723328;
        Tue, 14 Feb 2023 01:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1676367870; bh=ERFp+UKx/iNbj6Y6kJUSMmT/xdPleSppwgENqVxf/VM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Za6u4dReX/HTRyphBPafGiLsxCJ+KKmFXzBp1N3wK/BdK0FrKi1Znyq7KSHyqIyd/
         kgfg1K7p6XNdoVzNndtK42V0pk1FbtgyitZSCQWfWujqXuBYwphv2YLUpu/j4syKSL
         9RAZMIGf3dW2anwxyU5UMo1EVcbifIrk3T62A2sIhCPMYdsaAzhIY5t2nwHlg40Zt7
         HtazUlk5mlSfLPOR/KKhdC1Dq5qLUvlQDvzaYGy2cDXLDVpukIxIWr8q4OHqWuB3tT
         6cx52IlEbcB5iPGAwJpjsjaFv5wT4dz6E7YwfLhROeby+gu9v1sPXxrdEBwhQ+jslK
         7mKSZA/LRAQdg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.155.167]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mr9Bu-1ooy3k2CyE-00oHk0; Tue, 14
 Feb 2023 10:44:30 +0100
Message-ID: <32c2584a-8777-26b9-ae29-80df9dfa7833@gmx.de>
Date:   Tue, 14 Feb 2023 10:44:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 19/24] parisc: Remove empty <uapi/asm/setup.h>
Content-Language: en-US
To:     =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
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
 <20230214074925.228106-20-alexghiti@rivosinc.com>
 <6f9c7a6b-4f6b-dead-2d9b-14b405f18397@linaro.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <6f9c7a6b-4f6b-dead-2d9b-14b405f18397@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6i9MLH1uyN4UjvbKa9qFgGzxyogAl9vzFG+CnYpeJmhfg1aCjEo
 fgPVjxDy4iWSOp0fQduaCkCLS49XMnxFV3Cebj1wXgxrmR7Mk+7ALLo+bEOtaCQ7LtdzxdY
 sCyP+X8u7wZGNhDO2HoSYGEmEl3/72yEi0kFbG3gxrNGYWo22p1QITkOnVbWjeRtGq3QAhO
 81HzmD9N+fT9Dd0qQJFHw==
UI-OutboundReport: notjunk:1;M01:P0:/sXWrTs+GHs=;mOBmE8xN1RO7T/4g1DSsoRwJcwg
 9UZR9rEyA6LxshPy2Pz3oePTMgiIj4+AJ5S/kMjQzK+6c4x3H5hr27yLtzKfDT5PmjzMBJ+Of
 3zfIEJQlV54kh1Ta/E2FfIdf+80zKMSI52rgvhwMkMmCjI3cvExJnD5nlbysiqstKtT+wFzv2
 Z260NQ1Y6j9s9OOAoLni9UrAct6Rzpr/LUuWUMgXKKuXfF7kU52/jKJgDV1uBFAO6e5+U9ium
 VU7bbslf79RWKAUFAz+cqTgWfg2fuGDImyE9L+3DmCjQMG4Je3gjyU6QTxHzjARx67lC7Pl/p
 bedRk356yNR+IaCi4+oVkCwy2AY9dZJ/arcneDsIauL5AATahoUIulBRN7BP8SDlfJek6s/Jl
 DdbP1C/VuGwfRMSoxHG8JGSkxMV5vKemlpgKIjZBdDtJFI77SS55OS105zLh5z4ZUEQAw5+iD
 gVWGMHv/5YX1gJCtlIOQqpAHCfa/KUliQGzWaNumDuHSbS1WfcGa+yV5bTGOpiX0VvFOGSRQB
 U8RMxnOZrwFy8bBzFJhabD91opgpUnM1Drax9wp+qCBQVYPpwhhcgl6on9cy9pH9R+aFk3mO1
 nccDm7RKozeMO0SgmShqcIoAo/MMXzhU+k4jUwmlvTNKux7KYJMrIZ3ji9OPa5aewlpMHOTna
 SozD4wCdOT6JL2dhqNqhu36n4+0Z9IWZgWgaFVcSdY0J6JSMrCZl1PwuiDm7p3APkGs2WM/5J
 r7eIJOkBYD6bzCYdI23czK+lvIluKLxeFS4fLTCAb1WjYXxNnV13KwV1j8Yk4Fb+FVUt28ZT4
 0LWoGNHs7csGcm5b93meJrBGDiIruUcZg9DNckv8YppQk7vzTqpr/lTUzz0R/0FKX3/+tbfQa
 Xa6y4Nti/opEugZMRO7Vpm0AV2+BhhBkSR95zi7OPWYYGnYk/coI5tYGHEiard+vIs75wAtJz
 L71IAbhumB1qAsU4XQRHfRtAGXM=
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/14/23 10:08, Philippe Mathieu-Daud=C3=A9 wrote:
> On 14/2/23 08:49, Alexandre Ghiti wrote:
>> From: Palmer Dabbelt <palmer@rivosinc.com>
>>
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>> ---
>> =C2=A0 arch/parisc/include/uapi/asm/setup.h | 5 -----
>> =C2=A0 1 file changed, 5 deletions(-)
>> =C2=A0 delete mode 100644 arch/parisc/include/uapi/asm/setup.h
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Acked-by: Helge Deller <deller@gmx.de>


