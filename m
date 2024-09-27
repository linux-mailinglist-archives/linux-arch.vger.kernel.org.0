Return-Path: <linux-arch+bounces-7474-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692219888F8
	for <lists+linux-arch@lfdr.de>; Fri, 27 Sep 2024 18:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A613FB24C0D
	for <lists+linux-arch@lfdr.de>; Fri, 27 Sep 2024 16:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A8D171092;
	Fri, 27 Sep 2024 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="U8brWSp4"
X-Original-To: linux-arch@vger.kernel.org
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [144.217.248.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9F0170854;
	Fri, 27 Sep 2024 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.217.248.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727454105; cv=none; b=GF/1ZeI0rnH/chSSoSuTlccm0Q7nYsLl0SajgsbviugsPDtTWAPXhkA4fPGNesF1ka0vg3k12YUjJRKoAMKSlVX2WyurKBX/PMmYIAR/c1IhH8MZTM/8EO69L9c7F5pWhruUg1egY8nMKXHN8LBdHk60ZkPa4difHKF479Wd4s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727454105; c=relaxed/simple;
	bh=AxPMeG2FdOLZJZ+q46E4+IvQWObSATSIrFU0BmjPRSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tu0PgHSH76SOBOPEMRK4GQcxvCTcJMjCTZRdN69jyND7Jiulp5cys6HSZPgskkmR1YeA2JSPXaLboC/GC2DJKqKhS8dBSuioVGvVd7vnRq3L/hjutZ2T4PNxe5kKfO98lLguH5ohtOOzvGj/thFAsiRU+vLdFjCdkj8FgqGjFrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=U8brWSp4; arc=none smtp.client-ip=144.217.248.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay1.mymailcheap.com (Postfix) with ESMTPS id 447CA3E9E8;
	Fri, 27 Sep 2024 16:21:42 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id 299894075D;
	Fri, 27 Sep 2024 16:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1727454100; bh=AxPMeG2FdOLZJZ+q46E4+IvQWObSATSIrFU0BmjPRSk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U8brWSp4oWZ3+9xwnIoBM/tYm1gyahmvgDH33kHnAc1BOEChhkO9YWsyr2KKiHZOH
	 ZK35u2QHUlfymMT422oV/r4i4Ax9iW1xXsJMZJeCayacZI+A+ibgMwOhLYj5q3C2S5
	 qqul+Zc5A/pZzQR3eCbRFEgQe/MOU4GHSHFks3O8=
Received: from [198.18.0.1] (unknown [58.32.43.121])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id DCB0041431;
	Fri, 27 Sep 2024 16:21:36 +0000 (UTC)
Message-ID: <3ac98e7e-3524-45c4-90e3-ee730a5143ee@aosc.io>
Date: Sat, 28 Sep 2024 00:21:32 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH V2 3/3] SH: cpuinfo: Fix a warning for
 CONFIG_CPUMASK_OFFSTACK
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Huacai Chen <chenhuacai@gmail.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Arnd Bergmann <arnd@arndb.de>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
 Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, stable@vger.kernel.org
References: <20220714084136.570176-1-chenhuacai@loongson.cn>
 <20220714084136.570176-3-chenhuacai@loongson.cn>
 <3a5a4bee5c0739a3b988a328376a6eed3c385fda.camel@physik.fu-berlin.de>
 <CAAhV-H5bw3xcym2-GpyntQEad1h2eB8xDQGwVr_bRRKAOakzoQ@mail.gmail.com>
 <8947f91ba1a10f98723a5982f0fc13ee589d3bf7.camel@physik.fu-berlin.de>
 <a45f1209-ff29-4010-b035-921cb136d58d@aosc.io>
 <fbc1dde6650a3e729fab57decbb5bf4ef14436ce.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Kexy Biscuit <kexybiscuit@aosc.io>
In-Reply-To: <fbc1dde6650a3e729fab57decbb5bf4ef14436ce.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Queue-Id: 299894075D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.09 / 10.00];
	BAYES_HAM(-2.00)[95.08%];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[physik.fu-berlin.de,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]

Hi Adrian

On 9/27/2024 5:06 PM, John Paul Adrian Glaubitz wrote:
> Hi,
> 
> On Fri, 2024-09-27 at 13:31 +0800, Kexy Biscuit wrote:
>> On 3/19/2024 1:12 AM, John Paul Adrian Glaubitz wrote:
>>> Hi Hucai,
>>>
>>> On Mon, 2024-03-18 at 22:21 +0800, Huacai Chen wrote:
>>>> Hi, SuperH maintainers,
>>>>
>>>> On Wed, Feb 8, 2023 at 8:59 PM John Paul Adrian Glaubitz
>>>> <glaubitz@physik.fu-berlin.de> wrote:
>>>>>
>>>>> On Thu, 2022-07-14 at 16:41 +0800, Huacai Chen wrote:
>>>>>> When CONFIG_CPUMASK_OFFSTACK and CONFIG_DEBUG_PER_CPU_MAPS is selected,
>>>>>> cpu_max_bits_warn() generates a runtime warning similar as below while
>>>>>> we show /proc/cpuinfo. Fix this by using nr_cpu_ids (the runtime limit)
>>>>>> instead of NR_CPUS to iterate CPUs.
>>>>>>
>>>>>> [    3.052463] ------------[ cut here ]------------
>>>>>> [    3.059679] WARNING: CPU: 3 PID: 1 at include/linux/cpumask.h:108 show_cpuinfo+0x5e8/0x5f0
>>>>>> [    3.070072] Modules linked in: efivarfs autofs4
>>>>>> [    3.076257] CPU: 0 PID: 1 Comm: systemd Not tainted 5.19-rc5+ #1052
>>>>>> [    3.099465] Stack : 9000000100157b08 9000000000f18530 9000000000cf846c 9000000100154000
>>>>>> [    3.109127]         9000000100157a50 0000000000000000 9000000100157a58 9000000000ef7430
>>>>>> [    3.118774]         90000001001578e8 0000000000000040 0000000000000020 ffffffffffffffff
>>>>>> [    3.128412]         0000000000aaaaaa 1ab25f00eec96a37 900000010021de80 900000000101c890
>>>>>> [    3.138056]         0000000000000000 0000000000000000 0000000000000000 0000000000aaaaaa
>>>>>> [    3.147711]         ffff8000339dc220 0000000000000001 0000000006ab4000 0000000000000000
>>>>>> [    3.157364]         900000000101c998 0000000000000004 9000000000ef7430 0000000000000000
>>>>>> [    3.167012]         0000000000000009 000000000000006c 0000000000000000 0000000000000000
>>>>>> [    3.176641]         9000000000d3de08 9000000001639390 90000000002086d8 00007ffff0080286
>>>>>> [    3.186260]         00000000000000b0 0000000000000004 0000000000000000 0000000000071c1c
>>>>>> [    3.195868]         ...
>>>>>> [    3.199917] Call Trace:
>>>>>> [    3.203941] [<90000000002086d8>] show_stack+0x38/0x14c
>>>>>> [    3.210666] [<9000000000cf846c>] dump_stack_lvl+0x60/0x88
>>>>>> [    3.217625] [<900000000023d268>] __warn+0xd0/0x100
>>>>>> [    3.223958] [<9000000000cf3c90>] warn_slowpath_fmt+0x7c/0xcc
>>>>>> [    3.231150] [<9000000000210220>] show_cpuinfo+0x5e8/0x5f0
>>>>>> [    3.238080] [<90000000004f578c>] seq_read_iter+0x354/0x4b4
>>>>>> [    3.245098] [<90000000004c2e90>] new_sync_read+0x17c/0x1c4
>>>>>> [    3.252114] [<90000000004c5174>] vfs_read+0x138/0x1d0
>>>>>> [    3.258694] [<90000000004c55f8>] ksys_read+0x70/0x100
>>>>>> [    3.265265] [<9000000000cfde9c>] do_syscall+0x7c/0x94
>>>>>> [    3.271820] [<9000000000202fe4>] handle_syscall+0xc4/0x160
>>>>>> [    3.281824] ---[ end trace 8b484262b4b8c24c ]---
>>>>>>
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>>>>>> ---
>>>>>>    arch/sh/kernel/cpu/proc.c | 2 +-
>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/arch/sh/kernel/cpu/proc.c b/arch/sh/kernel/cpu/proc.c
>>>>>> index a306bcd6b341..5f6d0e827bae 100644
>>>>>> --- a/arch/sh/kernel/cpu/proc.c
>>>>>> +++ b/arch/sh/kernel/cpu/proc.c
>>>>>> @@ -132,7 +132,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>>>>>>
>>>>>>    static void *c_start(struct seq_file *m, loff_t *pos)
>>>>>>    {
>>>>>> -     return *pos < NR_CPUS ? cpu_data + *pos : NULL;
>>>>>> +     return *pos < nr_cpu_ids ? cpu_data + *pos : NULL;
>>>>>>    }
>>>>>>    static void *c_next(struct seq_file *m, void *v, loff_t *pos)
>>>>>>    {
>>>>>
>>>>> I build-tested the patch and also booted the patched kernel successfully
>>>>> on my SH-7785LCR board.
>>>>>
>>>>> Showing the contents of /proc/cpuinfo works fine, too:
>>>>>
>>>>> root@tirpitz:~> cat /proc/cpuinfo
>>>>> machine         : SH7785LCR
>>>>> processor       : 0
>>>>> cpu family      : sh4a
>>>>> cpu type        : SH7785
>>>>> cut             : 7.x
>>>>> cpu flags       : fpu perfctr llsc
>>>>> cache type      : split (harvard)
>>>>> icache size     : 32KiB (4-way)
>>>>> dcache size     : 32KiB (4-way)
>>>>> address sizes   : 32 bits physical
>>>>> bogomips        : 599.99
>>>>> root@tirpitz:~>
>>>>>
>>>>> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>>>>>
>>>>> I am not sure yet whether the change is also correct as I don't know whether
>>>>> it's possible to change the number of CPUs at runtime on SuperH.
>>>> Can this patch be merged? This is the only one still unmerged in the
>>>> whole series.
>>>
>>> Thanks for the reminder. I will pick it up for 6.10.
>>>
>>> Got sick this week, so I can't pick up anymore patches for 6.9 and will just
>>> send Linus a PR later this week.
>>>
>>> Adrian
>>>
>>
>> Gentle ping on this, can we get this patch merged into 6.12?
> 
> Thanks a lot for the reminder. Since the merge window is about to close, I'll
> pick this up for 6.13 as it hasn't been reviewed yet from what I can see.
> 
> I will definitely pick it up for 6.13 and I'm sorry for the very long delay.
> 
> However, when this patch got posted back then, I wasn't a kernel maintainer yet.
> 
> Adrian
> 

Thank you so much for taking care of this patch, congrats on your new role!

-- 
Best Regards,
Kexy Biscuit

