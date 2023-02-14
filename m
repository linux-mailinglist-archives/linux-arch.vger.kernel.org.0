Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72461695F8F
	for <lists+linux-arch@lfdr.de>; Tue, 14 Feb 2023 10:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjBNJp2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Feb 2023 04:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjBNJp1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Feb 2023 04:45:27 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117BA10267;
        Tue, 14 Feb 2023 01:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1676367828; bh=bQoG1+qM5Y71xKKNzZAaZKaP54c9/SNL37IJdDcFtMo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=hihBALAdzJyyuZETKMDTwWBNqyHXT30m1W4+AhNia2aTQ0LGuEudgVjxHBOHc2O/1
         UjuZRvBAir2lTKIaMXuW6l0Jw91yPNhbGpel182Mf/orVb0S6hbISDciYTF54Wy0Zw
         wKM8GKPXEv0aT0K01aIbMc2I219r5PhnIgwwHqOrDmQNcp8nxxBkNf4BBrtdpN/N7Z
         59rGu8CnZqH+X/PEx5ZjDiRwnWNihqf8TyIZs4ozwDLocxhsUitLIrPfomEmdZ19Fu
         jPeCxrDIg0fC138zUyXarDYIQDPoI7A4vyTzEHVqChiz/r0Bk56Uo8AseQSt7S8yL1
         B3Eipy4Ux8oWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.155.167]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mo6qp-1olPAN2FEh-00pbOn; Tue, 14
 Feb 2023 10:43:48 +0100
Message-ID: <dd3f45ec-9578-420b-f1b8-5657fe4d3243@gmx.de>
Date:   Tue, 14 Feb 2023 10:43:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 08/24] parisc: Remove COMMAND_LINE_SIZE from uapi
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
 <20230214074925.228106-9-alexghiti@rivosinc.com>
 <f327ff48-cd50-4caa-1bea-f9906994e998@linaro.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <f327ff48-cd50-4caa-1bea-f9906994e998@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9Li8qIWZi+mvM820GG2clzFMNjBrqaWKtjHwHuJ3DICcz81Fm4U
 2RmO3PI+i3+wTXVGnrbheX/pLAWTgvn/yTBVQw0fLroxnm5K1IoQdsZqRZENGN3ATbehT4q
 LYJbtkfgHvqXKQS4gXQhgNMMzAzKtJiyxwXWla7+a/b/HmF4fSRj8M4VAnavnpLBfZrNVAE
 KFiLIhh+7vq2/cG5n7DgQ==
UI-OutboundReport: notjunk:1;M01:P0:IMRPuKVDPJE=;F//SqmPJNB5y4+cZpiTQkcdojtN
 LJal9PAv1QZdKB5D9CqOG4kDONZWyrNPKkN5b2mOfjhxupMdRrK75ginsDTsmoS6GxkXsawSe
 Ixb8/z/qWuT1XvHLvnObIyu9+CDwBFSLnvfS3oUCwO+McbEoaOIu3JOluz1CKIea/++hZAXXr
 5C/TDqeO2eW5Jj3zZR6/N6R7AbpRepoOcQKEjh1MMZly5ruuMMBXB13XwuZnCOPKbuWQD+P7U
 u5tjrVNOGUNXNhr0d3ai5DZSZ1P8Nv1752gGfUFNLirvADBmHUDdcgrG+Gm61GdfigPYbqqb/
 1PkUPKxRFBpZ1Cx4NSNOEnyeyZwSSXJKUgjkOkH22I1GXJ97YYM62oMo0vh5OYLWx0+hsk/8n
 HQhgMxbA10mk0n61Oj1blXGd+3vMYjFQuoEHgmidB0ldTYGVNyoXaO/SaCdFfxjJsn59BdGTL
 BZkhFpt3GJCd/AnG1wSvWUqOtXgAztE05KU+svPlIGXtnFeCOF2OU2N0ju8TFPdKrWa9brAZn
 sGjDk9UmZcbxwEt172brI7gtjbfvg29z7hHouTLGUEF9EqngZWh7EYp7gkVmQI/hozbgBsgoz
 eeLkzBY9tFrPxWifcvWfEMtpsICAIZXlFRN9dU+6mSkBeP0uz+co3OyUT2lGEettUPgMaBMWt
 hOeJ6wwHJ9pcHumJqm8AgV1qyLG95d6wlp0B94e3M4XQozlyXIMUOfx6LF870WFYysGHABOcC
 oOK9ypcj7sSBG/v7UPkRI/eACrxmZcVd3CnqbnnNKSbQk5qLhC+LBre/2RfSAQNenKWKT/xM6
 x2YRcaR4vPXIiPvzgV67iGQiTV1DY0D+hOgX7A2y/rweS243V0Bg1zHwIp9mRRsPiVM9+jgWo
 5yCcZvbHQGpOV5nnMvCxSj7isEJhJpd8xyktSgL+sUclmpfCvHbx8GkA7VJGN8RClkxcIL70E
 lxVNlTmcU+VpaSQbimIQeIbIpXk=
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
>> As far as I can tell this is not used by userspace and thus should not
>> be part of the user-visible API.
>>
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>> ---
>> =C2=A0 arch/parisc/include/asm/setup.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
7 +++++++
>> =C2=A0 arch/parisc/include/uapi/asm/setup.h | 2 --
>> =C2=A0 2 files changed, 7 insertions(+), 2 deletions(-)
>> =C2=A0 create mode 100644 arch/parisc/include/asm/setup.h
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Acked-by: Helge Deller <deller@gmx.de>



