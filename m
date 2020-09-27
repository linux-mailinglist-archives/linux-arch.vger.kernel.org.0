Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3BC279F63
	for <lists+linux-arch@lfdr.de>; Sun, 27 Sep 2020 09:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbgI0Hu5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 27 Sep 2020 03:50:57 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:13017 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730487AbgI0Hu4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 27 Sep 2020 03:50:56 -0400
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Sep 2020 03:50:54 EDT
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Bzd1C397tz9vCyd;
        Sun, 27 Sep 2020 09:43:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 2rpLFY2yYYd0; Sun, 27 Sep 2020 09:43:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Bzd1C1xLgz9vCyc;
        Sun, 27 Sep 2020 09:43:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9C23F8B771;
        Sun, 27 Sep 2020 09:43:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 8dPWckrkFTns; Sun, 27 Sep 2020 09:43:15 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E510A8B75B;
        Sun, 27 Sep 2020 09:43:13 +0200 (CEST)
Subject: Re: [PATCH v8 2/8] powerpc/vdso: Remove __kernel_datapage_offset and
 simplify __get_datapage()
To:     Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, nathanl@linux.ibm.com,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linuxppc-dev@lists.ozlabs.org
References: <cover.1588079622.git.christophe.leroy@c-s.fr>
 <0d2201efe3c7727f2acc718aefd7c5bb22c66c57.1588079622.git.christophe.leroy@c-s.fr>
 <87wo34tbas.fsf@mpe.ellerman.id.au>
 <2f9b7d02-9e2f-4724-2608-c5573f6507a2@csgroup.eu>
 <6862421a-5a14-2e38-b825-e39e6ad3d51d@csgroup.eu>
 <87imd5h5kb.fsf@mpe.ellerman.id.au>
 <CAJwJo6ZANqYkSHbQ+3b+Fi_VT80MtrzEV5yreQAWx-L8j8x2zA@mail.gmail.com>
 <87a6yf34aj.fsf@mpe.ellerman.id.au> <20200921112638.GC2139@willie-the-truck>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <ad72ffd3-a552-cc98-7545-d30285fd5219@csgroup.eu>
Date:   Sun, 27 Sep 2020 09:43:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200921112638.GC2139@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 21/09/2020 à 13:26, Will Deacon a écrit :
> On Fri, Aug 28, 2020 at 12:14:28PM +1000, Michael Ellerman wrote:
>> Dmitry Safonov <0x7f454c46@gmail.com> writes:
>>> On Wed, 26 Aug 2020 at 15:39, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>>> We added a test for vdso unmap recently because it happened to trigger a
>>>> KAUP failure, and someone actually hit it & reported it.
>>>
>>> You right, CRIU cares much more about moving vDSO.
>>> It's done for each restoree and as on most setups vDSO is premapped and
>>> used by the application - it's actively tested.
>>> Speaking about vDSO unmap - that's concerning only for heterogeneous C/R,
>>> i.e when an application is migrated from a system that uses vDSO to the one
>>> which doesn't - it's much rare scenario.
>>> (for arm it's !CONFIG_VDSO, for x86 it's `vdso=0` boot parameter)
>>
>> Ah OK that explains it.
>>
>> The case we hit of VDSO unmapping was some strange "library OS" thing
>> which had explicitly unmapped the VDSO, so also very rare.
>>
>>> Looking at the code, it seems quite easy to provide/maintain .close() for
>>> vm_special_mapping. A bit harder to add a test from CRIU side
>>> (as glibc won't know on restore that it can't use vdso anymore),
>>> but totally not impossible.
>>>
>>>> Running that test on arm64 segfaults:
>>>>
>>>>    # ./sigreturn_vdso
>>>>    VDSO is at 0xffff8191f000-0xffff8191ffff (4096 bytes)
>>>>    Signal delivered OK with VDSO mapped
>>>>    VDSO moved to 0xffff8191a000-0xffff8191afff (4096 bytes)
>>>>    Signal delivered OK with VDSO moved
>>>>    Unmapped VDSO
>>>>    Remapped the stack executable
>>>>    [   48.556191] potentially unexpected fatal signal 11.
>>>>    [   48.556752] CPU: 0 PID: 140 Comm: sigreturn_vdso Not tainted 5.9.0-rc2-00057-g2ac69819ba9e #190
>>>>    [   48.556990] Hardware name: linux,dummy-virt (DT)
>>>>    [   48.557336] pstate: 60001000 (nZCv daif -PAN -UAO BTYPE=--)
>>>>    [   48.557475] pc : 0000ffff8191a7bc
>>>>    [   48.557603] lr : 0000ffff8191a7bc
>>>>    [   48.557697] sp : 0000ffffc13c9e90
>>>>    [   48.557873] x29: 0000ffffc13cb0e0 x28: 0000000000000000
>>>>    [   48.558201] x27: 0000000000000000 x26: 0000000000000000
>>>>    [   48.558337] x25: 0000000000000000 x24: 0000000000000000
>>>>    [   48.558754] x23: 0000000000000000 x22: 0000000000000000
>>>>    [   48.558893] x21: 00000000004009b0 x20: 0000000000000000
>>>>    [   48.559046] x19: 0000000000400ff0 x18: 0000000000000000
>>>>    [   48.559180] x17: 0000ffff817da300 x16: 0000000000412010
>>>>    [   48.559312] x15: 0000000000000000 x14: 000000000000001c
>>>>    [   48.559443] x13: 656c626174756365 x12: 7865206b63617473
>>>>    [   48.559625] x11: 0000000000000003 x10: 0101010101010101
>>>>    [   48.559828] x9 : 0000ffff818afda8 x8 : 0000000000000081
>>>>    [   48.559973] x7 : 6174732065687420 x6 : 64657070616d6552
>>>>    [   48.560115] x5 : 000000000e0388bd x4 : 000000000040135d
>>>>    [   48.560270] x3 : 0000000000000000 x2 : 0000000000000001
>>>>    [   48.560412] x1 : 0000000000000003 x0 : 00000000004120b8
>>>>    Segmentation fault
>>>>    #
>>>>
>>>> So I think we need to keep the unmap hook. Maybe it should be handled by
>>>> the special_mapping stuff generically.
>>>
>>> I'll cook a patch for vm_special_mapping if you don't mind :-)
>>
>> That would be great, thanks!
> 
> I lost track of this one. Is there a patch kicking around to resolve this,
> or is the segfault expected behaviour?
> 

IIUC dmitry said he will cook a patch. I have not seen any patch yet.

AFAIKS, among the architectures having VDSO sigreturn trampolines, only SH, X86 and POWERPC provide 
alternative trampoline on stack when VDSO is not there.

All other architectures just having a VDSO don't expect VDSO to not be mapped.

As far as nowadays stacks are mapped non-executable, getting a segfaut is expected behaviour. 
However, I think we should really make it cleaner. Today it segfaults because it is still pointing 
to the VDSO trampoline that has been unmapped. But should the user map some other code at the same 
address, we'll run in the weed on signal return instead of segfaulting.

So VDSO unmapping should really be properly managed, the reference should be properly cleared in 
order to segfault in a controllable manner.

Only powerpc has a hook to properly clear the VDSO pointer when VDSO is unmapped.

Christophe
