Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FD66A5EBD
	for <lists+linux-arch@lfdr.de>; Tue, 28 Feb 2023 19:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjB1S1D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Feb 2023 13:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjB1S1B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2023 13:27:01 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D4E3345C;
        Tue, 28 Feb 2023 10:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677608809; i=deller@gmx.de;
        bh=zt+ehWVj1znhB+7eQWSE6l/uRiaIBvZCcGXnGx9yrO4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=DZ123iGitQ3mZ0IK5CoPtzHr5CfVesG/37WdqaMnb398y29M5ymAj8BF/AJ300QQk
         nW6i6nd5xiocqhcE3YR0+yjulv9NfkdmaHEOSgj50el8hvK8guoY9u6B0ULh2Hk9L7
         ZakbNbcBBblqtnUYDYTqFuRcdRNdIh/May4kRRT9XNYxXpVI/gKCMBzwmYk9dbNSdM
         ck8+t/VPDs/wxyEUT1/PIAYyLgVvbodvzU0dQVbiUEgJGatIPSm7MkLs7R5VcX6w4y
         DLpVRVUljKrIZDkDgtZnZDqgs65B0feehVspR0BFaBaTycVGPMgTQqOaXBioKUHMiV
         FchiECrgauKxw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.156.241]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8GMk-1oTCQ50qCu-014CmI; Tue, 28
 Feb 2023 19:26:49 +0100
Message-ID: <e9972a0e-14e6-987c-fcee-005a50d28e46@gmx.de>
Date:   Tue, 28 Feb 2023 19:26:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 08/10] parisc: fix livelock in uaccess
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org
References: <Y9lz6yk113LmC9SI@ZenIV> <Y9l0w4M91DwYLO3N@ZenIV>
 <84b1c2e4-c096-ed19-9701-472b54a4890c@gmx.de> <Y/47PMmpLDX5lPWx@ZenIV>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <Y/47PMmpLDX5lPWx@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hzKtQB+ilx3F7OaNvzae21T8Y/p+VinFjHZnE2cIJxVGK7EZxBW
 rV0qZupqjERQyaJ387BeUeDdzqGbzTqQ51ShuZO2xex/alGJjJcq/nZIHlh2oZDptHYfeWn
 hv7alAHeu2zrj/slBdNCDwi174vZGKyDDW8qgkpD1Qi7y9ZX1ZeaKCsOc1/ipEkvb0aRA70
 0waFLTovxOCELK7dSUOyA==
UI-OutboundReport: notjunk:1;M01:P0:7IBh5g6mBI8=;suggwuriHjnz8dnCfXC3EtQLYF1
 jVEUoFHxY8nTJcWTcYDRlJFSI1Obu01MsZ9oRtVgew3vWLKCiOiVRhG4L6HqnCitY/uGuokbo
 9TVt0W1NhQ0le/r0lyzTFB/cwK14RaMVpDE/CNMRb6nQ2odk4VZ/VsmDMiQ91o6o51i3akFjs
 f2WHVQV5ocWo0sWYRJBunxEv7iBhjrhSr5ZIJf56PP/vJpXWwf25XemiqTRXVQCeQG2ja3hIp
 229jwFFXQoOCQCs6mIugcHqV046u5bIMsAgZyWZVIPjdg7+gM4iBd4qQO+oSfLzblKsLYxyW6
 Py6Zvz4PSKVvzCvD0g8RJZZYZBA00Vgqsd7uQ5yo7xoQGtKLBqti38el0uU6lT1sQdUZZD3tY
 +p/gVYufVvyloI+OcA+wKrFJygcx3K0RDzWq8wxwNAnScyhKOVscdxdG6XbZjEMaePU+em5he
 f20zwH/RvmW9dK7cTY9JIYqca/vUnQM/lMZz/6WO1ImHstZFu0mVoncasxrcoodgP2L3ZnBGZ
 Q4YyN/IMCU4QVbxWuudGaI11lOabiYad8EmjSCGo+22wKPW6aZ2+jy57vqJPMYBQJUY9cEIom
 1Zgn1eihupLbXM6cGuUk/MUeXo7dHnAPzrtWQbfbS1TYKw3ZK0P507bMieMJXv9ryOa/c9leB
 mPN+bPoCaz8JWt+46NNDGS8jWLztwJ8ylqfcONOgcQN/3xLyhe2A2U1uA253u7tTGICi54m49
 qVIAGOcJyVTZj1SuWEiH3a4MjQmSVfIbunxkrlS6H3FKrq8VvGZzPwv9EdwIpCb9IUcwmZYmG
 a6bYfhmioan1OgvDlybePZ/lQxrX61spSi/BwQ0oC7kTCT3gXP8Zv3YqSKh7oUlh+KRE1uPPG
 PmChuQlxVOdNS0EKYeFL7XoyXEKXBiBqX1LkHxBlVa6gBCztcZTyaTu3B3oM8ohSLfglnKiLv
 qfLkeKZAXewX21QHSJrdCC73l9U=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/28/23 18:34, Al Viro wrote:
> On Mon, Feb 06, 2023 at 05:58:02PM +0100, Helge Deller wrote:
>> Hi Al,
>>
>> On 1/31/23 21:06, Al Viro wrote:
>>> parisc equivalent of 26178ec11ef3 "x86: mm: consolidate VM_FAULT_RETRY=
 handling"
>>> If e.g. get_user() triggers a page fault and a fatal signal is caught,=
 we might
>>> end up with handle_mm_fault() returning VM_FAULT_RETRY and not doing a=
nything
>>> to page tables.  In such case we must *not* return to the faulting ins=
n -
>>> that would repeat the entire thing without making any progress; what w=
e need
>>> instead is to treat that as failed (user) memory access.
>>>
>>> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>>> ---
>>>    arch/parisc/mm/fault.c | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
>>> index 869204e97ec9..bb30ff6a3e19 100644
>>> --- a/arch/parisc/mm/fault.c
>>> +++ b/arch/parisc/mm/fault.c
>>> @@ -308,8 +308,11 @@ void do_page_fault(struct pt_regs *regs, unsigned=
 long code,
>>>
>>>    	fault =3D handle_mm_fault(vma, address, flags, regs);
>>>
>>> -	if (fault_signal_pending(fault, regs))
>>> +	if (fault_signal_pending(fault, regs)) {
>>> +		if (!user_mode(regs))
>>> +			goto no_context;
>>>    		return;
>>> +	}
>>
>> The testcase in
>>    https://lore.kernel.org/lkml/20170822102527.GA14671@leverpostej/
>>    https://lore.kernel.org/linux-arch/20210121123140.GD48431@C02TD0UTHF=
1T.local/
>> does hang with and without above patch on parisc.
>> It does not consume CPU in that state and can be killed with ^C.
>>
>> Any idea?
>
> 	Still trying to resurrect the parisc box to test on it...
> FWIW, right now I've locally confirmed that mainline has the bug
> in question and that patch fixes it for alpha, sparc32 and sparc64;
> hexagon, m68k and riscv got acks from other folks; microblaze,
> nios2 and openrisc I can't test at all (no hardware, no qemu setup);
> same for parisc64.  Itanic and parisc32 I might be able to test,
> if I manage to resurrect the hardware.

I can test both parisc32 and parisc64.

> 	Just to confirm: your "can be killed with ^C" had been on the
> mainline parisc kernel (with userfaultfd enable, of course, or it wouldn=
't
> hang up at all), right?

It was a recent mainline kernel with your patch.

> Was it 32bit or 64bit kernel?

I don't remember. I think I tried both.

Helge
