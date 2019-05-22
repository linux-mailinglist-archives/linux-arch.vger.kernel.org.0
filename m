Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFCEC266C5
	for <lists+linux-arch@lfdr.de>; Wed, 22 May 2019 17:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbfEVPTV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 May 2019 11:19:21 -0400
Received: from foss.arm.com ([217.140.101.70]:53530 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729583AbfEVPTV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 May 2019 11:19:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A439380D;
        Wed, 22 May 2019 08:19:20 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B79223F718;
        Wed, 22 May 2019 08:19:19 -0700 (PDT)
Subject: Re: [PATCH] checkpatch: Fix spdxcheck.py
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, jcline@redhat.com
References: <20190522132754.46640-1-vincenzo.frascino@arm.com>
 <CAMuHMdXoUWHk-RvgwbDc0YZ+KnBSaL+1XE2n134oAVR7Y5jazg@mail.gmail.com>
 <c4592dfd-6b56-2837-8c32-495b113e80ee@arm.com>
 <CAMuHMdWaVDe9S1hfhwrZ5D2d74yswvKXeQ9pL7i6Oe7UVJj0MQ@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <3a0524cd-5c83-aad9-bbfc-69b811f63898@arm.com>
Date:   Wed, 22 May 2019 16:19:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWaVDe9S1hfhwrZ5D2d74yswvKXeQ9pL7i6Oe7UVJj0MQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Geert,

On 22/05/2019 16:07, Geert Uytterhoeven wrote:
> Hi Vincenzo,
> 
> On Wed, May 22, 2019 at 4:32 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>> On 22/05/2019 14:48, Geert Uytterhoeven wrote:
>>> On Wed, May 22, 2019 at 3:28 PM Vincenzo Frascino
>>> <vincenzo.frascino@arm.com> wrote:
>>>> The LICENSE directory has recently changed structure and this makes
>>>> spdxcheck fails as per below:
>>>>
>>>> FAIL: "Blob or Tree named 'other' not found"
>>>> Traceback (most recent call last):
>>>>   File "scripts/spdxcheck.py", line 240, in <module>
>>>> spdx = read_spdxdata(repo)
>>>>   File "scripts/spdxcheck.py", line 41, in read_spdxdata
>>>> for el in lictree[d].traverse():
>>>> [...]
>>>> KeyError: "Blob or Tree named 'other' not found"
>>>>
>>>> Fix the script to restore the correctness on checkpatch License
>>>> checking.
>>>>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>> Cc: Jeremy Cline <jcline@redhat.com>
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>>>
>>> Thanks for your patch!
>>>
>>> Looks the issue is already fixed in linux-next:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/scripts/spdxcheck.py
>>>
>>
>> Thank you for pointing this out, I missed it.
>>
>> I had a look at the patch in linux-next and seems that the problem is not
>> completely solved by the patch you are referring to, in fact:
>>  - For how the code it is written, exceptions directory needs to be parsed as
>>    last. The only reason why it seems ok at the moment in linux-next it is
>>    because there is no "dual" license appears in SPDX-Licenses field of any
>>    "exception". A simple test that consists in adding Apache-2.0 to the SPDX-
>>    Licenses of Linux-syscall-note generates still an exception.
>>  - The SPDXException calls in the case of "SPDX-Licenses" and "License-Text" use
>>    undefined parameters.
>>
>> My patch addresses both the issues, if it helps, I can rebase it on linux-next.
>>
>> Please let me know.
> 
> Rebasing against linux-next is the right thing to do.
> Thanks!
> 

Done! I put you in Cc of the v2 of this patch.

Please let me know if I can do anything else.

> Gr{oetje,eeting}s,
> 
>                         Geert
> 

-- 
Regards,
Vincenzo
