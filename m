Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42E734A1A8
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 07:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhCZGTK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Mar 2021 02:19:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:52647 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230080AbhCZGSs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Mar 2021 02:18:48 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F6Bcj15yQz9txtr;
        Fri, 26 Mar 2021 07:18:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id EPzpYio6x8_7; Fri, 26 Mar 2021 07:18:45 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F6Bch6s6pz9txtq;
        Fri, 26 Mar 2021 07:18:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C82E58B864;
        Fri, 26 Mar 2021 07:18:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id pXAsruLCGJL2; Fri, 26 Mar 2021 07:18:45 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2D9C48B834;
        Fri, 26 Mar 2021 07:18:45 +0100 (CET)
Subject: Re: [PATCH v2 6/7] cmdline: Gives architectures opportunity to use
 generically defined boot cmdline manipulation
To:     Will Deacon <will@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, danielwa@cisco.com,
        robh@kernel.org, daniel@gimpelevich.san-francisco.ca.us,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1614705851.git.christophe.leroy@csgroup.eu>
 <2eb6fad3470256fff5c9f33cd876f344abb1628b.1614705851.git.christophe.leroy@csgroup.eu>
 <20210303175747.GD19713@willie-the-truck>
 <8db81511-3f28-4ef1-5e66-188cf7cafad1@csgroup.eu>
 <20210325193216.GC16123@willie-the-truck>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <27de5349-0bc1-74c3-518f-2dcdc1a8cfaf@csgroup.eu>
Date:   Fri, 26 Mar 2021 07:18:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210325193216.GC16123@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 25/03/2021 à 20:32, Will Deacon a écrit :
> On Thu, Mar 25, 2021 at 12:18:38PM +0100, Christophe Leroy wrote:
>>
>> - For ARM it means to append the bootloader arguments to the CONFIG_CMDLINE
>> - For Powerpc it means to append the CONFIG_CMDLINE to the bootloader arguments
>> - For SH  it means to append the CONFIG_CMDLINE to the bootloader arguments
>> - For EFI it means to append the bootloader arguments to the CONFIG_CMDLINE
>> - For OF it means to append the CONFIG_CMDLINE to the bootloader arguments
>>
>> So what happens on ARM for instance when it selects CONFIG_OF for instance ?
> 
> I think ARM gets different behaviour depending on whether it uses ATAGs or
> FDT.

As far as I can see, ARM uses either ATAGs only or both ATAGs and FDT. ATAGs is forced to 'y' when 
USE_OF is set. Do I miss something ?

> 
>> Or should we consider that EXTEND means APPEND or PREPEND, no matter which ?
>> Because EXTEND is for instance used for:
>>
>> 	config INITRAMFS_FORCE
>> 		bool "Ignore the initramfs passed by the bootloader"
>> 		depends on CMDLINE_EXTEND || CMDLINE_FORCE
> 
> Oh man, I didn't spot that one :(
> 
> I think I would make the generic options explicit: either APPEND or PREPEND.
> Then architectures which choose to define CMDLINE_EXTEND in their Kconfigs
> can select the generic option that matches their behaviour.
> 
> INITRAMFS_FORCE sounds like it should depend on APPEND (assuming that means
> CONFIG_CMDLINE is appended to the bootloader arguments).
> 


Christophe
