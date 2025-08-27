Return-Path: <linux-arch+bounces-13296-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2388B381D5
	for <lists+linux-arch@lfdr.de>; Wed, 27 Aug 2025 13:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42D1206E63
	for <lists+linux-arch@lfdr.de>; Wed, 27 Aug 2025 11:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AF42FF645;
	Wed, 27 Aug 2025 11:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="abt+U3x2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2192FF178
	for <linux-arch@vger.kernel.org>; Wed, 27 Aug 2025 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756295975; cv=none; b=t9s1DbiNgiwx/TY6rOHyrrM5dnIutE4LisEVneMadZrlBHipm3toE7eYuty0Ib41zVfQmoeyX5Ua4hTWdGT0dx1ac1BNyoXEVISsqyJPboC0XfKlcX+vH76od4ivO8JzUiHGG4JnCxgtFd1g2FyjSKSi2Ab5VfoIiinu8/4jQZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756295975; c=relaxed/simple;
	bh=x59G9IzspfxGRKoY9vrF5GARBXG3LFbEsID5KjYkCYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d74oA0JL/y3GPXmxVEgvdO16CMnFlqOSk8jLmPQW3hwqfcutjJvGGqAVU/9wxY4+njw3Eq1cXjKlWVm2dETG2QvbqJ8aGqNDz8QIORBsX5y12vojyaOxKfsoJDcV02bs0Li6S5rDF5adzfCOMdyVrM4AYlDwdtjff6i5G0iIILY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=abt+U3x2; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7ace3baso1198139766b.3
        for <linux-arch@vger.kernel.org>; Wed, 27 Aug 2025 04:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756295971; x=1756900771; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BQaihs8KVNFjFPci/gMTVwx/UBSLhwQ4KKodk3oOIf0=;
        b=abt+U3x2UiakTw23OZTRB/9L7dCIHJGsBBxAhYDkG+/ctfcim19QK0REZD2B/aSZgY
         /8COE5nkRZIKoIxXoOLZxbDd7fW/S5z0ePVmuHXcRh7LJ9Nl3fBG3qakpoo4qRiK6u0S
         Suv3TJmQNTaSspQ+zrz97rJ5jhloJmc0iNxlccmOiSaXNRWnP4deS4NkFs3YKvvBaISf
         mzuov0WbUc+g7ps7mf3t6Gw/1tUOAgC4wT4//XfkTlC/2wOesUKigXSCvpdpeL/EKEOj
         yqoQdoWY3sLlbXH8JQ+Gp3+4UzHIFF3cJqFRkD93kz1RYT12PSALZI2l+qyatEr5GiIH
         48mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756295971; x=1756900771;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQaihs8KVNFjFPci/gMTVwx/UBSLhwQ4KKodk3oOIf0=;
        b=BHbXjni/JuKZrV57umDUnKz+mug4wC/Gc1JQShjtwxC+kfXcYeUixL9OKQHTpDkJMY
         JA99EnKHuBYifdZx27MAIDp+Y9Ew9dUpV0M7+Q9r24VAs8rlskAikzRRgc90GgoSdGU9
         HfyuY6TXZ5+y0p9iyZcChnaRDIqEqKG1rXztQ/ZF5YX15oCGaYBLoz6FHRZvJv9Vg7mf
         P8MxQWipv5RJiHFYjLU+T6RwExv0Jh/a4QRpaRG4CJ0L8OTHmSo4hM3deXz8c8ROmNit
         NFlQpML5m09CTMDv8TUVhh8z2XhrugiQAqdb6aliQPLCCTAu1/cppsXgq3aBcIbIyqJw
         HLkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOTCnokjR9xA8nXoSLsETxWDfHf2bvBrfX6Y4SyajqInAw7SOEPICrzEOQPKs7itR01jDGp6ThtAgk@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+luWISMMyKdQnPjtb5EH8YbLoiE/WVt+x5kZO91qAHv+lPxM/
	gzz6VHslvxD3oR85db2zoDSLOvMpy0Aq0+ZNIuwPx58dp41KzMPfEosGYojvKLOytteqaEZuM1j
	YljRcxas=
X-Gm-Gg: ASbGnctbm5UniJW65xILvK+mr9jg5v46Jah6hYAnc7KNBhA1tiqEGC2jjUFFfEpUBHP
	ga3AQolmLmKaNzS4tn4kthkNQkoKAe50wdYUBf2qN6XttFP1e7F4nq8KF33gsc4zWcBAakPHOSF
	0jWPpomRyRjNlqzQEnMmqBbQRqhTknYSfrASdqkueBBn0QRPVYJvbDZ5+fko0J8nOhSBWPa+QEw
	oEVIlS0t9HxrrBZT1keTdf8KUcSmx0VsI9iFpdgKiYO9/p2eFX7ypafYuB5m7deuXzZMvXTOyml
	owJiTsXJQp6dW/iRXfHs9TScMJoweWm6weNSlDYWukmNIoSI4WOou27KJiLOZe9oaqLBaasvJmR
	LJg9zcAXA8+asA/sz+VnBvguHvAxCS+OO2Nk3v5zS
X-Google-Smtp-Source: AGHT+IEwO9j0QYQ4ePdmBR/viBrOcw84xdsurEVIrUknJvIdTDPUSFSZhPjsQi8BtJA/2U4A7NMt3A==
X-Received: by 2002:a17:906:6a0e:b0:afa:1453:6635 with SMTP id a640c23a62f3a-afe294dce99mr1797221866b.41.1756295970665;
        Wed, 27 Aug 2025 04:59:30 -0700 (PDT)
Received: from [192.168.0.24] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe9c908414sm413654466b.97.2025.08.27.04.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 04:59:30 -0700 (PDT)
Message-ID: <1b52419c-101b-487e-a961-97bd405c5c33@linaro.org>
Date: Wed, 27 Aug 2025 14:59:28 +0300
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v2 22/29] mm/numa: Register information into Kmemdump
To: David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
 andersson@kernel.org, pmladek@suse.com,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 corbet@lwn.net, mojha@qti.qualcomm.com, rostedt@goodmis.org,
 jonechou@google.com, tudor.ambarus@linaro.org,
 Christoph Hellwig <hch@infradead.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
 <20250724135512.518487-23-eugen.hristev@linaro.org>
 <ffc43855-2263-408d-831c-33f518249f96@redhat.com>
 <e66f29c2-9f9f-4b04-b029-23383ed4aed4@linaro.org>
 <751514db-9e03-4cf3-bd3e-124b201bdb94@redhat.com>
 <aJCRgXYIjbJ01RsK@tiehlicka>
 <e2c031e8-43bd-41e5-9074-c8b1f89e04e6@linaro.org>
 <23e7ec80-622e-4d33-a766-312c1213e56b@redhat.com>
 <f43a61b4-d302-4009-96ff-88eea6651e16@linaro.org>
 <77d17dbf-1609-41b1-9244-488d2ce75b33@redhat.com>
 <ecd33fa3-8362-48f0-b3c2-d1a11d8b02e3@linaro.org>
 <9f13df6f-3b76-4d02-aa74-40b913f37a8a@redhat.com>
 <64a93c4a-5619-4208-9e9f-83848206d42b@linaro.org>
 <f1f290fc-b2f0-483b-96d5-5995362e5a8b@redhat.com>
 <01c67173-818c-48cf-8515-060751074c37@linaro.org>
 <aab5e2af-04d6-485f-bf81-557583f2ae4b@redhat.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <aab5e2af-04d6-485f-bf81-557583f2ae4b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/25/25 16:58, David Hildenbrand wrote:
> On 25.08.25 15:36, Eugen Hristev wrote:
>>
>>
>> On 8/25/25 16:20, David Hildenbrand wrote:
>>>
>>>>>
>>>>> IIRC, kernel/vmcore_info.c is never built as a module, as it also
>>>>> accesses non-exported symbols.
>>>>
>>>> Hello David,
>>>>
>>>> I am looking again into this, and there are some things which in my
>>>> opinion would be difficult to achieve.
>>>> For example I looked into my patch #11 , which adds the `runqueues` into
>>>> kmemdump.
>>>>
>>>> The runqueues is a variable of `struct rq` which is defined in
>>>> kernel/sched/sched.h , which is not supposed to be included outside of
>>>> sched.
>>>> Now moving all the struct definition outside of sched.h into another
>>>> public header would be rather painful and I don't think it's a really
>>>> good option (The struct would be needed to compute the sizeof inside
>>>> vmcoreinfo). Secondly, it would also imply moving all the nested struct
>>>> definitions outside as well. I doubt this is something that we want for
>>>> the sched subsys. How the subsys is designed, out of my understanding,
>>>> is to keep these internal structs opaque outside of it.
>>>
>>> All the kmemdump module needs is a start and a length, correct? So the
>>> only tricky part is getting the length.
>>
>> I also have in mind the kernel user case. How would a kernel programmer
>> want to add some kernel structs/info/buffers into kmemdump such that the
>> dump would contain their data ? Having "KMEMDUMP_VAR(...)" looks simple
>> enough.
> 
> The other way around, why should anybody have a saying in adding their 
> data to kmemdump? Why do we have that all over the kernel?
> 
> Is your mechanism really so special?
> 
> A single composer should take care of that, and it's really just start + 
> len of physical memory areas.
> 
>> Otherwise maybe the programmer has to write helpers to compute lengths
>> etc, and stitch them into kmemdump core.
>> I am not saying it's impossible, but just tiresome perhaps.
> 
> In your patch set, how many of these instances did you encounter where 
> that was a problem?
> 
>>>
>>> One could just add a const variable that holds this information, or even
>>> better, a simple helper function to calculate that.
>>>
>>> Maybe someone else reading along has a better idea.
>>
>> This could work, but it requires again adding some code into the
>> specific subsystem. E.g. struct_rq_get_size()
>> I am open to ideas , and thank you very much for your thoughts.
>>
>>>
>>> Interestingly, runqueues is a percpu variable, which makes me wonder if
>>> what you had would work as intended (maybe it does, not sure).
>>
>> I would not really need to dump the runqueues. But the crash tool which
>> I am using for testing, requires it. Without the runqueues it will not
>> progress further to load the kernel dump.
>> So I am not really sure what it does with the runqueues, but it works.
>> Perhaps using crash/gdb more, to actually do something with this data,
>> would give more insight about its utility.
>> For me, it is a prerequisite to run crash, and then to be able to
>> extract the log buffer from the dump.
> 
> I have the faint recollection that percpu vars might not be stored in a 
> single contiguous physical memory area, but maybe my memory is just 
> wrong, that's why I was raising it.
> 
>>
>>>
>>>>
>>>>   From my perspective it's much simpler and cleaner to just add the
>>>> kmemdump annotation macro inside the sched/core.c as it's done in my
>>>> patch. This macro translates to a noop if kmemdump is not selected.
>>>
>>> I really don't like how we are spreading kmemdump all over the kernel,
>>> and adding complexity with __section when really, all we need is a place
>>> to obtain a start and a length.
>>>
>>
>> I understand. The section idea was suggested by Thomas. Initially I was
>> skeptic, but I like how it turned out.
> 
> Yeah, I don't like it. Taste differs ;)
> 
> I am in particular unhappy about custom memblock wrappers.
> 
> [...]
> 
>>>>
>>>> To have this working outside of printk, it would be required to walk
>>>> through all the printk structs/allocations and select the required info.
>>>> Is this something that we want to do outside of printk ?
>>>
>>> I don't follow, please elaborate.
>>>
>>> How is e.g., log_buf_len_get() + log_buf_addr_get() not sufficient,
>>> given that you run your initialization after setup_log_buf() ?
>>>
>>>
>>
>> My initial thought was the same. However I got some feedback from Petr
>> Mladek here :
>>
>> https://lore.kernel.org/lkml/aBm5QH2p6p9Wxe_M@localhost.localdomain/
>>
>> Where he explained how to register the structs correctly.
>> It can be that setup_log_buf is called again at a later time perhaps.
>>
> 
> setup_log_buf() is a __init function, so there is only a certain time 
> frame where it can be called.
> 
> In particular, once the buddy is up, memblock allocations are impossible 
> and it would be deeply flawed to call this function again.
> 
> Let's not over-engineer this.
> 
> Peter is on CC, so hopefully he can share his thoughts.
> 

Hello David,

I tested out this snippet (on top of my series, so you can see what I
changed):


diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 18ba6c1e174f..7ac4248a00e5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -67,7 +67,6 @@
 #include <linux/wait_api.h>
 #include <linux/workqueue_api.h>
 #include <linux/livepatch_sched.h>
-#include <linux/kmemdump.h>

 #ifdef CONFIG_PREEMPT_DYNAMIC
 # ifdef CONFIG_GENERIC_IRQ_ENTRY
@@ -120,7 +119,12 @@
EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);

 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
-KMEMDUMP_VAR_CORE(runqueues, sizeof(runqueues));
+
+size_t runqueues_get_size(void);
+size_t runqueues_get_size(void)
+{
+       return sizeof(runqueues);
+}

 #ifdef CONFIG_SCHED_PROXY_EXEC
 DEFINE_STATIC_KEY_TRUE(__sched_proxy_exec);
diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
index d808c5e67f35..c6dd2d6e96dd 100644
--- a/kernel/vmcore_info.c
+++ b/kernel/vmcore_info.c
@@ -24,6 +24,12 @@
 #include "kallsyms_internal.h"
 #include "kexec_internal.h"

+typedef void* kmemdump_opaque_t;
+
+size_t runqueues_get_size(void);
+
+extern kmemdump_opaque_t runqueues;
+
 /* vmcoreinfo stuff */
 unsigned char *vmcoreinfo_data;
 size_t vmcoreinfo_size;
@@ -230,6 +236,9 @@ static int __init crash_save_vmcoreinfo_init(void)

        kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_VMCOREINFO,
                             (void *)vmcoreinfo_data, vmcoreinfo_size);
+       kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_runqueues,
+                            (void *)&runqueues, runqueues_get_size());
+
        return 0;
 }

With this, no more .section, no kmemdump code into sched, however, there
are few things :
First the size function, which is quite dull and doesn't fit into the
sched very much.
Second, having the extern with a different "opaque" type to avoid
exposing the struct rq definition, which is quite hackish.

What do you think ?
My opinion is that it's ugly, but maybe you have some better idea how to
write this nicer ?
( I am also not 100 % sure if I did this the way you wanted).

Thanks for helping out,
Eugen

