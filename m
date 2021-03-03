Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0C932C868
	for <lists+linux-arch@lfdr.de>; Thu,  4 Mar 2021 02:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240140AbhCDAtS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 19:49:18 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:31744 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237847AbhCCSIl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Mar 2021 13:08:41 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DrMRT2KJHz9twsP;
        Wed,  3 Mar 2021 19:07:49 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Oezy_9lCxP9I; Wed,  3 Mar 2021 19:07:49 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DrMRT1Nrpz9twsB;
        Wed,  3 Mar 2021 19:07:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6D9A88B7E6;
        Wed,  3 Mar 2021 19:07:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id mppgCCIWAOu2; Wed,  3 Mar 2021 19:07:49 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A8E2F8B7DB;
        Wed,  3 Mar 2021 19:07:48 +0100 (CET)
Subject: Re: [PATCH v2 0/7] Improve boot command line handling
To:     Daniel Walker <danielwa@cisco.com>, Rob Herring <robh@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>, devicetree@vger.kernel.org,
        Will Deacon <will@kernel.org>
References: <cover.1614705851.git.christophe.leroy@csgroup.eu>
 <20210302173523.GE109100@zorba>
 <CAL_JsqJ7U8QAbJe3zkZiFPJN4PveHz5TZoPk2S8qQWB6cm5e5Q@mail.gmail.com>
 <20210303173908.GG109100@zorba>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <59b054e8-d85b-fd87-c94d-691af748a2f5@csgroup.eu>
Date:   Wed, 3 Mar 2021 19:07:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210303173908.GG109100@zorba>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 03/03/2021 à 18:39, Daniel Walker a écrit :
> On Tue, Mar 02, 2021 at 08:01:01PM -0600, Rob Herring wrote:
>> +Will D
>>
>> On Tue, Mar 2, 2021 at 11:36 AM Daniel Walker <danielwa@cisco.com> wrote:
>>>
>>> On Tue, Mar 02, 2021 at 05:25:16PM +0000, Christophe Leroy wrote:
>>>> The purpose of this series is to improve and enhance the
>>>> handling of kernel boot arguments.
>>>>
>>>> It is first focussed on powerpc but also extends the capability
>>>> for other arches.
>>>>
>>>> This is based on suggestion from Daniel Walker <danielwa@cisco.com>
>>>>
>>>
>>>
>>> I don't see a point in your changes at this time. My changes are much more
>>> mature, and you changes don't really make improvements.
>>
>> Not really a helpful comment. What we merge here will be from whomever
>> is persistent and timely in their efforts. But please, work together
>> on a common solution.
>>
>> This one meets my requirements of moving the kconfig and code out of
>> the arches, supports prepend/append, and is up to date.
> 
> 
> Maintainers are capable of merging whatever they want to merge. However, I
> wouldn't make hasty choices. The changes I've been submitting have been deployed
> on millions of router instances and are more feature rich.
> 
> I believe I worked with you on this change, or something like it,
> 
> https://lkml.org/lkml/2019/3/19/970
> 
> I don't think Christophe has even addressed this.

I thing I have, see 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/3b4291271ce4af4941a771e5af5cbba3c8fa1b2a.1614705851.git.christophe.leroy@csgroup.eu/

If you see something missing in that patch, can you tell me.

> I've converted many
> architectures, and Cisco uses my changes on at least 4 different
> architecture. With products deployed and tested.

As far as we know, only powerpc was converted in the last series you submitted, see 
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=98106&state=*

> 
> I will resubmit my changes as soon as I can.
> 

Christophe
