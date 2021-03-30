Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEA834DD54
	for <lists+linux-arch@lfdr.de>; Tue, 30 Mar 2021 03:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhC3BKg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Mar 2021 21:10:36 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:58694 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhC3BKV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Mar 2021 21:10:21 -0400
X-Greylist: delayed 1072 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Mar 2021 21:10:20 EDT
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 12U0qO8Z066170
        for <linux-arch@vger.kernel.org>; Tue, 30 Mar 2021 03:52:24 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1617065539; x=1619657539;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4Ytp87wkA+alvM5YO/7dlXgP5/jZJBWXepwASfozGUU=;
        b=CXdKG8AeuRZiwZ+qSuU9itQVeS+S6jzZD+LSRTjBq4uIMwy1EtYl2LFohFQ3P0aL
        1snhQLBfGMnJPLlMUvta1R1ExG60xpMGjvqAzE108mPHfXrfMlKUizgfR2G3CWnj
        dKei0YP7+vI+q9xmsTyWmdWtYdS0hBwgkfMMp+y/DHsFRhQlCWvNoRqg2neDGsDy
        A/MbNsCxbPucEdxZvgGboLEud/obw/iKdEC8cDqcfAJRCeFRpho58PpEswmR8XMQ
        DBZlttMlmL7pkMgUDfZroBTVf9b7EC2+ikG/v595zLMuOGi9LkWZ5Pgiy0gLVEtB
        d2DVMQG/q9QvZWbAMsyDiw==;
X-AuditID: 8b5b014d-a4c337000000209f-f6-60627642ff7a
Received: from enigma.ics.forth.gr (enigma-2.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 86.6D.08351.24672606; Tue, 30 Mar 2021 03:52:18 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 30 Mar 2021 03:52:17 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Rob Herring <robh@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Will Deacon <will@kernel.org>,
        Daniel Walker <danielwa@cisco.com>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>, devicetree@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        microblaze <monstr@monstr.eu>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        nios2 <ley.foon.tan@intel.com>,
        Openrisc <openrisc@lists.librecores.org>,
        linux-hexagon@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        X86 ML <x86@kernel.org>, linux-xtensa@linux-xtensa.org,
        SH-Linux <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>, paul.walmsley@sifive.com
Subject: Re: [PATCH v3 11/17] riscv: Convert to GENERIC_CMDLINE
Organization: FORTH
In-Reply-To: <CAL_JsqK2TT=j1QjiRgTYQvwHqivE-3HgYo2JzxTJSWO2wvK69Q@mail.gmail.com>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
 <46745e07b04139a22b5bd01dc37df97e6981e643.1616765870.git.christophe.leroy@csgroup.eu>
 <87zgyqdn3d.fsf@igel.home> <81a7e63f-57d4-5c81-acc5-35278fe5bb04@csgroup.eu>
 <CAL_JsqK2TT=j1QjiRgTYQvwHqivE-3HgYo2JzxTJSWO2wvK69Q@mail.gmail.com>
Message-ID: <3ae0c2faa08f76efb8a446f262b712df@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsXSHT1dWde5LCnB4AO/xZ1Jz9ktjh7vZbZo
        XriE2WL+kXOsFvd3NzJadOz6ymKx6fE1Vov3LTvYLC7vmsNm0blpK6PFts8tbBZz/kxhtlh5
        di27xe/v/1gtnnw8DVTceZnNom0Wv8X/PTvYLfqXdrBZNJxcwWrRcsfU4seGx6wOYh5Tfm9k
        9fh68xyTx/0Hz1k9Fu95yeSxaVUnm8ehwx2MHi8Obmf22Lyk3mP9hm2MHudnLGT0+Ns1hdnj
        UvN1do/Pm+QCeKO4bFJSczLLUov07RK4MpqW3GYuuMdT8eD2fOYGxrVcXYycHBICJhKb5j1j
        72Lk4hASOM4ocWFHFwtEwlRi9t5ORhCbV0BQ4uTMJ2BxZgELialX9jNC2PISzVtnM4PYLAKq
        Els+QMTZBDQl5l86CFYvIqAo8bttGivIAmaBz+wSj242AhVxcAgL2Essn2UHUsMvICzx6e5F
        VhCbUyBQ4uqL32wQB61hkjh69A8zxBEuEv8+TmeFOE5F4sPvB+wgc0SB7M1zlSYwCs5Ccuos
        JKfOQnLqAkbmVYwCiWXGepnJxXpp+UUlGXrpRZsYwRHN6LuD8fbmt3qHGJk4GA8xSnAwK4nw
        Ch9ITBDiTUmsrEotyo8vKs1JLT7EKM3BoiTOy6s3IV5IID2xJDU7NbUgtQgmy8TBKdXAZDF7
        Ibu7bpJ0S056lY5T1mb7vUI9xyRZInM7SjMP8ahbfi7Uu/0qNq1njospX8DU78dj3x2SfDtV
        xHr+FbGLEcWvzua/LQj7ONkr3DCLIUHfakKWSpDXwry3fhOKIt/ODEo56nXrAdt29SnP+nMU
        /0fe/8z4TdbTnDN88c+XOWxtenuYQhzmfH6zlLlrvXps4O6P71n8I2qa5vKWSe5VsPzLdTHu
        SsfRmr9zrF4xMis2pC6wc3hy+6X3kX3s6p2BTRKZ765un2UqyV7ZejbXdqbCqqDP7v8XdzH4
        y8tEl3xTvfqpobI9Nip3m3ir+7L5W7548iblXFzk8i1x838fU8lVvJ6yk1SXnTbzEFViKc5I
        NNRiLipOBAC7YhWKVwMAAA==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Στις 2021-03-26 17:26, Rob Herring έγραψε:
> On Fri, Mar 26, 2021 at 8:20 AM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
>> 
>> 
>> 
>> Le 26/03/2021 à 15:08, Andreas Schwab a écrit :
>> > On Mär 26 2021, Christophe Leroy wrote:
>> >
>> >> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>> >> index f8f15332caa2..e7c91ee478d1 100644
>> >> --- a/arch/riscv/kernel/setup.c
>> >> +++ b/arch/riscv/kernel/setup.c
>> >> @@ -20,6 +20,7 @@
>> >>   #include <linux/swiotlb.h>
>> >>   #include <linux/smp.h>
>> >>   #include <linux/efi.h>
>> >> +#include <linux/cmdline.h>
>> >>
>> >>   #include <asm/cpu_ops.h>
>> >>   #include <asm/early_ioremap.h>
>> >> @@ -228,10 +229,8 @@ static void __init parse_dtb(void)
>> >>      }
>> >>
>> >>      pr_err("No DTB passed to the kernel\n");
>> >> -#ifdef CONFIG_CMDLINE_FORCE
>> >> -    strlcpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
>> >> +    cmdline_build(boot_command_line, NULL, COMMAND_LINE_SIZE);
>> >>      pr_info("Forcing kernel command line to: %s\n", boot_command_line);
>> >
>> > Shouldn't that message become conditional in some way?
>> >
>> 
>> You are right, I did something similar on ARM but looks like I missed 
>> it on RISCV.
> 
> How is this hunk even useful? Under what conditions can you boot
> without a DTB? Even with a built-in DTB, the DT cmdline handling would
> be called.
> 
> Rob
> 

cced Paul who introduced this:
https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/commit/arch/riscv/kernel/setup.c?id=8fd6e05c7463b635e51ec7df0a1858c1b5a6e350

