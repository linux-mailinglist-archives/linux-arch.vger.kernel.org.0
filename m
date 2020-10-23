Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E58297079
	for <lists+linux-arch@lfdr.de>; Fri, 23 Oct 2020 15:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464804AbgJWN3L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Oct 2020 09:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464803AbgJWN3K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Oct 2020 09:29:10 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B35C0613CE;
        Fri, 23 Oct 2020 06:29:10 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d3so1560091wma.4;
        Fri, 23 Oct 2020 06:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5CyMJDhTomAaoZqFkHeUCCVr9UCp9JN75j1REjgNDKA=;
        b=Ung8MBybCGC3bEJ7PW8O5Dc1F8pLlmdO8mpN8jTjfyuuh+rBkdIryuv1jHVea+dgDN
         1x42JDgL78dfQvYtcPTSvZfAgSYGeiPUqQoHl1LEGHdjW8Ct2FnEVnfcDPC/c8A/V+Lc
         IGwbaFv/7uyuRtdLuBI5eY3c6AXZDhrTKQEDZqjEr7qjIZ0q6XdX86DKNZ5r1u2VB0nh
         JMxWiObEzifGVcax+zElzZTa8vXeJzCancTXThC/AxpK7sIG6Kx8vYOibZv2yWc5uJW4
         fCKZPLVYfzCO2xedIlghPOMExWxvP6iqDIE/zsvjhXyExPTUIXQmdYHndth79VAysIld
         wm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5CyMJDhTomAaoZqFkHeUCCVr9UCp9JN75j1REjgNDKA=;
        b=QxIda9DsD8XgUckM3xuXKF1VTj7dLW2Ju3X/6jvdjk2OGNxPQWasEFN3h+y1pMK4rK
         rJ4yXJB++TR634Qg/KQ9E68aUyM6bIlZ39FBxT/SMLDQ8ZXOTJDy2L763j0Xz3+BJslC
         XgTmnzMQzI1sgsmEVb9UlzW0IKfPag8dTl2wbSsfGdTu4z6m6YZQVx8WdkCOy9ljC41l
         ws1oTcs3HZA7PBLDxgsa8lSf7QgJYlAFjmM54qWtHJ6b0R1Ioq2oOfBFLd3VmSm66tMZ
         Jr7uUg4JaOrRoPPIC8tqJRI9eG5biRSJjT3GtlPzuz+0HlaL4GYBi1MKNjGaWciB2i2j
         K/IA==
X-Gm-Message-State: AOAM530DhZ2UAjC+DuDLKxWkv38lNFEkr2WWIz5e3thUM7UerOQkumi4
        Esb/W0dFCFKJBOjI+M5Ibjc=
X-Google-Smtp-Source: ABdhPJxWcUzCkUZQf5EPci+8xvFYzP6nw9i9+fXq7oUvP/k4VKqigvib5wvMo3C2HDHJVJsGWNQPTQ==
X-Received: by 2002:a1c:152:: with SMTP id 79mr2290463wmb.60.1603459748716;
        Fri, 23 Oct 2020 06:29:08 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id e20sm3128540wme.35.2020.10.23.06.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 06:29:08 -0700 (PDT)
Subject: Re: [PATCH v8 2/8] powerpc/vdso: Remove __kernel_datapage_offset and
 simplify __get_datapage()
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Will Deacon <will@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, nathanl@linux.ibm.com,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linuxppc-dev@lists.ozlabs.org
References: <87wo34tbas.fsf@mpe.ellerman.id.au>
 <2f9b7d02-9e2f-4724-2608-c5573f6507a2@csgroup.eu>
 <6862421a-5a14-2e38-b825-e39e6ad3d51d@csgroup.eu>
 <87imd5h5kb.fsf@mpe.ellerman.id.au>
 <CAJwJo6ZANqYkSHbQ+3b+Fi_VT80MtrzEV5yreQAWx-L8j8x2zA@mail.gmail.com>
 <87a6yf34aj.fsf@mpe.ellerman.id.au> <20200921112638.GC2139@willie-the-truck>
 <ad72ffd3-a552-cc98-7545-d30285fd5219@csgroup.eu>
 <542145eb-7d90-0444-867e-c9cbb6bdd8e3@gmail.com>
 <ba9861da-2f5b-a649-5626-af00af634546@csgroup.eu>
 <20201023112514.GE20933@willie-the-truck>
 <284cacf4-9811-4b67-385c-2783a7cd9b31@csgroup.eu>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <2b25c715-c178-b4f2-04e0-bdbdfacb90b7@gmail.com>
Date:   Fri, 23 Oct 2020 14:29:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <284cacf4-9811-4b67-385c-2783a7cd9b31@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Christophe, Will,

On 10/23/20 12:57 PM, Christophe Leroy wrote:
> 
> 
> Le 23/10/2020 à 13:25, Will Deacon a écrit :
>> On Fri, Oct 23, 2020 at 01:22:04PM +0200, Christophe Leroy wrote:
>>> Hi Dmitry,
[..]
>>> I haven't seen the patches, did you sent them out finally ?

I was working on .close() hook, but while cooking it, I thought it may
be better to make tracking of user landing generic. Note that the vdso
base address is mostly needed by kernel as an address to land in
userspace after processing a signal.

I have some raw patches that add
+#ifdef CONFIG_ARCH_HAS_USER_LANDING
+               struct vm_area_struct *user_landing;
+#endif
inside mm_struct and I plan to finish them after rc1 gets released.

While working on that, I noticed that arm32 and some other architectures
track vdso position in mm.context with the only reason to add
AT_SYSINFO_EHDR in the elf header that's being loaded. That's quite
overkill to have a pointer in mm.context that rather can be a local
variable in elf binfmt loader. Also, I found some issues with mremap
code. The patches series mentioned are at the base of the branch with
generic user landing. I have sent only those patches not the full branch
as I remember there was a policy that during merge window one should
send only fixes, rather than refactoring/new code.

>> I think it's this series:
>>
>> https://lore.kernel.org/r/20201013013416.390574-1-dima@arista.com
>>
>> but they look really invasive to me, so I may cook a small hack for arm64
>> in the meantine / for stable.

I don't mind small hacks, but I'm concerned that the suggested fix which
sets `mm->context.vdso_base = 0` on munmap() may have it's issue: that
won't work if a user for whatever-broken-reason will mremap() vdso on 0
address. As the fix supposes to fix an issue that hasn't fired for
anyone yet, it probably shouldn't introduce another. That's why I've
used vm_area_struct to track vdso position in the patches set.
Probably, temporary, you could use something like:
#define BAD_VDSO_ADDRESS    (-1)UL
Or non-page-aligned address.
But the signal code that checks if it can land on vdso/sigpage should be
also aligned with the new definition.

> Not sure we are talking about the same thing.
> 
> I can't see any new .close function added to vm_special_mapping in order
> to replace arch_unmap() hook.
Thanks,
          Dmitry
