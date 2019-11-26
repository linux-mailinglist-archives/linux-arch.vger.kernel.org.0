Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFE6109CE9
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2019 12:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfKZLVR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Nov 2019 06:21:17 -0500
Received: from ivanoab7.miniserver.com ([37.128.132.42]:45340 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbfKZLVR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Nov 2019 06:21:17 -0500
X-Greylist: delayed 1875 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Nov 2019 06:21:16 EST
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@kot-begemot.co.uk>)
        id 1iZYPm-0007J0-ON; Tue, 26 Nov 2019 10:49:51 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.92)
        (envelope-from <anton.ivanov@kot-begemot.co.uk>)
        id 1iZYPk-00072p-Fs; Tue, 26 Nov 2019 10:49:50 +0000
Subject: Re: [RFC v2 17/37] lkl tools: host lib: virtio devices
To:     Octavian Purdila <tavi.purdila@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-arch <linux-arch@vger.kernel.org>, cem <cem@freebsd.org>,
        Richard Weinberger <richard@nod.at>,
        linux-um <linux-um@lists.infradead.org>,
        retrage01 <retrage01@gmail.com>, liuyuan <liuyuan@google.com>,
        pscollins <pscollins@google.com>,
        linux-kernel-library <linux-kernel-library@freelists.org>,
        sigmaepsilon92 <sigmaepsilon92@gmail.com>,
        Hajime Tazaki <thehajime@gmail.com>
References: <cover.1573179553.git.thehajime@gmail.com>
 <1531c5f16a00b608635c9a62fa3951807075f950.1573179553.git.thehajime@gmail.com>
 <CAFLxGvzCwCLbLMhcF6ZJ2afeo7PSd8xLQrU9hRH6YVaMakBSyw@mail.gmail.com>
 <de90b04151bafee083727c9769833932788cf428.camel@sipsolutions.net>
 <1662825264.98055.1574758225905.JavaMail.zimbra@nod.at>
 <4ebb14dc67ccb70543617ce1f7066f3f27cd11a8.camel@sipsolutions.net>
 <243342257.98153.1574762974057.JavaMail.zimbra@nod.at>
 <98acf77a7c6f6cba7f76c12a850ac2929b9e5a48.camel@sipsolutions.net>
 <CAMoF9u3LRC_NaVJzmKPc0+XBxhAqdhnr4-ZzY_ypwQEzUz78yQ@mail.gmail.com>
From:   Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <ce1a96d4-3d5e-32be-f493-3522fc56a25b@kot-begemot.co.uk>
Date:   Tue, 26 Nov 2019 10:49:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAMoF9u3LRC_NaVJzmKPc0+XBxhAqdhnr4-ZzY_ypwQEzUz78yQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 26/11/2019 10:42, Octavian Purdila wrote:
> On Tue, Nov 26, 2019 at 12:16 PM Johannes Berg
> <johannes@sipsolutions.net> wrote:
>>
>> On Tue, 2019-11-26 at 11:09 +0100, Richard Weinberger wrote:
>>> ----- Ursprüngliche Mail -----
>>>>> My point is that UML and LKL should try to do use the same concept/code
>>>>> regarding virtio. At the end of day both use virtual devices which use
>>>>> facilities from the host.
>>>>> If this is really not possible it needs a good explanation.
>>>>
>>>> I think it isn't possible, unless you use vhost-user over a unix domain
>>>> socket internally to talk between the kernel (virtio_uml) and hypervisor
>>>> (device) components.
>>>>
>>>> In virtio_uml, the device implementation is assumed to be a separate
>>>> process with a vhost-user connection. Here in LKL, the virtio device is
>>>> part of the "hypervisor", i.e. in the same process.
>>>
>>> Exactly, currently UML and LKL solve same things differently, but do we need to?
>>
>> It's not the same thing though :-)
>>
>> UML right now doesn't have or support virtio devices in the built-in
>> hypervisor, what we wanted to use virtio for was explicitly for the
>> vhost-user devices.
>>
>> LKL clearly wants to have device implementations in the hypervisor,
>> perhaps for networking or console etc.? That _might_ be useful since it
>> makes the device implementation more general, unlike the UML approach
>> where all devices come with a kernel- and user-side and are special
>> drivers in the kernel, vs. general virtio drivers.
>>
> 
> That is correct. Initially we used the same UML model, with dedicated
> drivers for LKL, and later switched to using the built-in virtio
> drivers (so far for network and block devices).
> 
>> Now, arguably, since UML has all these already a combined UML/LKL
>> doesn't actually *need* any virtio devices, since all (or at least most)
>> of the things that could be covered by virtio today are already covered
>> by UML devices (block, net, console, random).
>>
>> I'd probably say then that this can be removed from an initial "minimum
>> viable product" of LKL, since once merged with UML you get the devices
>> from that. Later, we could decide that UML devices actually are better
>> done as virtio, and support something like this.
>>
> 
> I agree, I think it make sense to drop these since the problem of
> dedicated vs generic / virtio drivers are orthogonal with regard to
> UML and LKL unification and can later be worked on.

This brings us back to the interrupt controller as noted by Richard earlier.

UML devices are heavily dependent on the file io as an IRQ trigger 
paradigm and they need an interrupt controller which has an IO event 
feed into it. I did not see that in LKL on first read.

So as a first step we should get it to work with existing UML IRQ 
controller and whatever incremental patches are needed on top of that.

> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/
