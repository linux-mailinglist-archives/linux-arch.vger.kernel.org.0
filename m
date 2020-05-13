Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C352E1D1B72
	for <lists+linux-arch@lfdr.de>; Wed, 13 May 2020 18:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732557AbgEMQpg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 May 2020 12:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732437AbgEMQpg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 12:45:36 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475DCC061A0C
        for <linux-arch@vger.kernel.org>; Wed, 13 May 2020 09:45:36 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id i14so16899734qka.10
        for <linux-arch@vger.kernel.org>; Wed, 13 May 2020 09:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oodbg6X4hPZHtBvXjZAsYciMiFkPyRUpeqTjF2PiB2M=;
        b=VKMWihnAb/wGKOJXGQV2TIK1soF3Qg6UEXAcMtlaSZQPjchCIG9iCObFojDKeXhgI1
         E5NmgwMT/zXv5KUCqCHddu7YvL4PzxeRlDwxHwpthBPBbsof1h7W0EJvTtxW80m9qubw
         VFEg3Dzs8Ix3ZFODWbrVb+ex/aAr2x8cABXXvvz4H1BS3j/NfsgD4rFpawQnxjpgoVHV
         uUGO6gCYUIKfJSjkE4NVWbB0u9cECHyPz/pCs85ZlTSk+3DfsJTE55JH9tlPxAtmF7MN
         qxJZT8CTJpKLGIxsvPcGwI5pqKJ21uDU/BAXqm992bVbjC5wtYXsH9SMhBvorNlat/i5
         34zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oodbg6X4hPZHtBvXjZAsYciMiFkPyRUpeqTjF2PiB2M=;
        b=Dp9Xh40sz0VOI2eOMvp5zYzW7bSURbx90g/9GzvknchKTUjIyVIHNUpA4YF6a7h5MW
         SoHI9h6Dk4kPTUBVpuQ3Xbv/NEF9R9C+N3my8MbznzBlxGzS8js4LSZTwbZvhqopc8qO
         hLGig5gr7h1fBD7YNGbSDWlAhdVhmUt7YMZZSK2Tv1CWfWD6gRlfoMwZWRYNHt2W9XUK
         ZzITqBdq1JnqM6mvaGZTwd2smsAMfIHHzLgMlQCNWUNi5Qtugn1W89PYSduvVIP5JpOY
         FSrLQAjdf6iFtNap167nDeBcN2h53Mp5cfh4I+KmyD2OwVj3fPMWGzae8y/pGLqVUrWQ
         FL+g==
X-Gm-Message-State: AOAM531fT2eWFwPqJpOD2e818DS0J/3EJTgtcdyio2je4v8kmKxFfSK0
        uRQAvDrpRWV9JwSSdIetH9i9Hg==
X-Google-Smtp-Source: ABdhPJyllsykuPwPyFp0vCVqR2vDAMZCv41cgMv9iBgJBtzfu2QWJWRgkCMlJNwm7y33iH394jmsyA==
X-Received: by 2002:a05:620a:b19:: with SMTP id t25mr537021qkg.428.1589388334758;
        Wed, 13 May 2020 09:45:34 -0700 (PDT)
Received: from [192.168.0.185] ([191.251.12.44])
        by smtp.gmail.com with ESMTPSA id i59sm108971qtb.58.2020.05.13.09.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 09:45:33 -0700 (PDT)
Subject: Re: [PATCH v3 19/23] arm64: mte: Add PTRACE_{PEEK,POKE}MTETAGS
 support
From:   Luis Machado <luis.machado@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Alan Hayward <Alan.Hayward@arm.com>,
        Omair Javaid <omair.javaid@linaro.org>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
 <20200421142603.3894-20-catalin.marinas@arm.com>
 <a7569985-eb85-497b-e3b2-5dce0acb1332@linaro.org>
 <20200513104849.GC2719@gaia>
 <3d2621ac-9d08-53ea-6c22-c62532911377@linaro.org>
 <20200513141147.GD2719@gaia>
 <eec9ddae-8aa0-6cd1-9a23-16b06bb457c5@linaro.org>
Message-ID: <e7f995d6-d48b-1ea2-c9e6-d2533e8eadd5@linaro.org>
Date:   Wed, 13 May 2020 13:45:27 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <eec9ddae-8aa0-6cd1-9a23-16b06bb457c5@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/13/20 12:09 PM, Luis Machado wrote:
> On 5/13/20 11:11 AM, Catalin Marinas wrote:
>> On Wed, May 13, 2020 at 09:52:52AM -0300, Luis Machado wrote:
>>> On 5/13/20 7:48 AM, Catalin Marinas wrote:
>>>> On Tue, May 12, 2020 at 04:05:15PM -0300, Luis Machado wrote:
>>>>> On 4/21/20 11:25 AM, Catalin Marinas wrote:
>>>>>> Add support for bulk setting/getting of the MTE tags in a tracee's
>>>>>> address space at 'addr' in the ptrace() syscall prototype. 'data' 
>>>>>> points
>>>>>> to a struct iovec in the tracer's address space with iov_base
>>>>>> representing the address of a tracer's buffer of length iov_len. The
>>>>>> tags to be copied to/from the tracer's buffer are stored as one 
>>>>>> tag per
>>>>>> byte.
>>>>>>
>>>>>> On successfully copying at least one tag, ptrace() returns 0 and 
>>>>>> updates
>>>>>> the tracer's iov_len with the number of tags copied. In case of 
>>>>>> error,
>>>>>> either -EIO or -EFAULT is returned, trying to follow the ptrace() man
>>>>>> page.
>>>>>>
>>>>>> Note that the tag copying functions are not performance critical,
>>>>>> therefore they lack optimisations found in typical memory copy 
>>>>>> routines.
>>>>>>
>>>>>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>>>>>> Cc: Will Deacon <will@kernel.org>
>>>>>> Cc: Alan Hayward <Alan.Hayward@arm.com>
>>>>>> Cc: Luis Machado <luis.machado@linaro.org>
>>>>>> Cc: Omair Javaid <omair.javaid@linaro.org>
>>>>>
>>>>> I started working on MTE support for GDB and I'm wondering if we've 
>>>>> already
>>>>> defined a way to check for runtime MTE support (as opposed to a 
>>>>> HWCAP2-based
>>>>> check) in a traced process.
>>>>>
>>>>> Originally we were going to do it via empty-parameter ptrace calls, 
>>>>> but you
>>>>> had mentioned something about a proc-based method, if I'm not 
>>>>> mistaken.
>>>>
>>>> We could expose more information via proc_pid_arch_status() but that
>>>> would be the tagged address ABI and tag check fault mode and intended
>>>> for human consumption mostly. We don't have any ptrace interface that
>>>> exposes HWCAPs. Since the gdbserver runs on the same machine as the
>>>> debugged process, it can check the HWCAPs itself, they are the same for
>>>> all processes.
>>>
>>> Sorry, I think i haven't made it clear. I already have access to 
>>> HWCAP2 both
>>> from GDB's and gdbserver's side. But HWCAP2 only indicates the 
>>> availability
>>> of a particular feature in a CPU, it doesn't necessarily means the 
>>> traced
>>> process is actively using MTE, right?
>>
>> Right, but "actively" is not well defined either. The only way to tell
>> whether a process is using MTE is to look for any PROT_MTE mappings. You
>> can access these via /proc/<pid>/maps. In theory, one can use MTE
>> without enabling the tagged address ABI or even tag checking (i.e. no
>> prctl() call).
>>
> 
> I see the problem. I was hoping for a more immediate form of runtime 
> check. One debuggers would validate and enable all the tag checks and 
> register access at process attach/startup.
> 
> With that said, checking for PROT_MTE in /proc/<pid>/maps may still be 
> useful, but a process with no immediate PROT_MTE maps doesn't mean such 
> process won't attempt to use PROT_MTE later on. I'll have to factor that 
> in, but I think it'll work.
> 
> I guess HWCAP2_MTE will be useful after all. We can just assume that 
> whenever we have HWCAP2_MTE, we can fetch MTE registers and check for 
> PROT_MTE.
> 
>>> So GDB/gdbserver would need runtime checks to be able to tell if a 
>>> process
>>> is using MTE, in which case the tools will pay attention to tags and
>>> additional MTE-related registers (sctlr and gcr) we plan to make 
>>> available
>>> to userspace.
>>
>> I'm happy to expose GCR_EL1.Excl and the SCTLR_EL1.TCF0 bits via ptrace
>> as a thread state. The tags, however, are a property of the memory range
>> rather than a per-thread state. That's what makes it different from
>> other register-based features like SVE.
> 
> That's my understanding as well. I'm assuming, based on our previous 
> discussion, that we'll have those couple registers under a regset (maybe 
> NT_ARM_MTE).
> 
>>
>>> The original proposal was to have GDB send PTRACE_PEEKMTETAGS with a 
>>> NULL
>>> address and check the result. Then GDB would be able to decide if the
>>> process is using MTE or not.
>>
>> We don't store this information in the kernel as a bool and I don't
>> think it would be useful either. I think gdb, when displaying memory,
>> should attempt to show tags as well if the corresponding range was
>> mapped with PROT_MTE. Just probing whether a thread ever used MTE
>> doesn't help since you need to be more precise on which address supports
>> tags.
> 
> Thanks for making this clear. Checking with ptrace won't work then. It 
> seems like /proc/<pid>/maps is the way to go.
> 
>>
>>>> BTW, in my pre-v4 patches (hopefully I'll post v4 this week), I changed
>>>> the ptrace tag access slightly to return an error (and no tags copied)
>>>> if the page has not been mapped with PROT_MTE. The other option would
>>>> have been read-as-zero/write-ignored as per the hardware behaviour.
>>>> Either option is fine by me but I thought the write-ignored part would
>>>> be more confusing for the debugger. If you have any preference here,
>>>> please let me know.
>>>
>>> I think erroring out is a better alternative, as long as the debugger 
>>> can
>>> tell what the error means, like, for example, "this particular address
>>> doesn't make use of tags".
>>
>> And you could use this for probing whether the range has tags or not.
>> With my current patches it returns -EFAULT but happy to change this to
>> -EOPNOTSUPP or -EINVAL. Note that it only returns an error if no tags
>> copied. If gdb asks for a range of two pages and only the first one has
>> PROT_MTE, it will return 0 and set the number of tags copied equivalent
>> to the first page. A subsequent call would return an error.
>>
>> In my discussion with Dave on the documentation patch, I thought retries
>> wouldn't be needed but in the above case it may be useful to get an
>> error code. That's unless we change the interface to return an error and
>> also update the user iovec structure.
>>
> 
> Let me think about this for a bit. I'm trying to factor in the 
> /proc/<pid>/maps contents. If debuggers know which pages have PROT_MTE 
> set, then we can teach the tools not to PEEK/POKE tags from/to those 
> memory ranges, which simplifies the error handling a bit.

I was checking the output of /proc/<pid>/maps and it doesn't seem to 
contain flags against which i can match PROT_MTE. It seems 
/proc/<pid>/smaps is the one that contains the flags (mt) for MTE. Am i 
missing something?

Is this the only place debuggers can check for PROT_MTE? If so, that's 
unfortunate. /proc/<pid>/smaps doesn't seem to be convenient for parsing.
