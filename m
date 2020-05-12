Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63D01CFDF5
	for <lists+linux-arch@lfdr.de>; Tue, 12 May 2020 21:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgELTFY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 May 2020 15:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgELTFY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 May 2020 15:05:24 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF171C061A0C
        for <linux-arch@vger.kernel.org>; Tue, 12 May 2020 12:05:22 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id i14so13684164qka.10
        for <linux-arch@vger.kernel.org>; Tue, 12 May 2020 12:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UI6RUzLO2uiSdCmhyivddJoxgBl/MIl48jarD2peWbs=;
        b=BFbHfn98jaGHpu9xzKX+MtSFyYJFBTaHBIt7T3i12X1xzHaO5DG2IOXYytD8A4j/sw
         ZWOt9i4uHd+XqVOA3HUuDyzhDJX9f7OyFa+vVlb1q6Ash9xC5BH7HlmvAknlXIA7lzOy
         OpgAPF1IrwiU/Vi1mMHFLAKYu8i14mADsufWBrahExAGByxA5spM9Pv1JP+avyL7l6rp
         3zm0ZFvv4IpTowGzjbA4uZr0c40u+sI6Al+xrDdK1zOR9rP/S20AraDtbbmyvUxqMGGf
         uZW7bE3JEfI0KzON5dj6KzECbXQNMvGXckvIhxfViSlgPu02tRufwwLmy8advGwvP+E5
         6Tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UI6RUzLO2uiSdCmhyivddJoxgBl/MIl48jarD2peWbs=;
        b=R4xXMZk0KKiwIOeBhB5+qgzi44r4Xy4G8pDE2OZOmXpZTnAmvWfXYjGLE2LTN0yvOj
         1Llayk0D5NjKP9IsAYwb1AMX4AedFVUQdCU/UDn4GoricKp3yRQuwIHp1kOqcUS3Dl9M
         chXqWvlsc7xyTPlZjSzXob3kEV9vBaqbyhaq33yPyvCf4RKajwRReRSCN1tpFqr7nK5H
         QAFrsI+ugxWAK6vEvlrOPITbz0GWlxxs9Oc9JpiHZLFTZYH/bbzL+VlFccnnLXQbPr7c
         ZfjQpWQFPe0rqtgFchvvWoGyvUZMRnuSY0Fk5iwBEPq+wO3u/OS7LGiJG7RyQZil6w/q
         uGGw==
X-Gm-Message-State: AGi0PuaJJDTLvvxXI+uqCk8YpuogR90kXT0KklVyY/6sryxKlTMr+XxX
        KKQEVqZFD9oL0tRBghaqQW6LsA==
X-Google-Smtp-Source: APiQypI4CZtjCar/kgfGa4Bfbol01l3EXMP1gUNn0S19TRhpzZu5I+980B7SFbBcj15iChRZHQHcWg==
X-Received: by 2002:a05:620a:624:: with SMTP id 4mr22287532qkv.86.1589310321938;
        Tue, 12 May 2020 12:05:21 -0700 (PDT)
Received: from [192.168.0.185] ([191.34.158.63])
        by smtp.gmail.com with ESMTPSA id k3sm1025697qkb.112.2020.05.12.12.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 12:05:20 -0700 (PDT)
Subject: Re: [PATCH v3 19/23] arm64: mte: Add PTRACE_{PEEK,POKE}MTETAGS
 support
To:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>,
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
From:   Luis Machado <luis.machado@linaro.org>
Message-ID: <a7569985-eb85-497b-e3b2-5dce0acb1332@linaro.org>
Date:   Tue, 12 May 2020 16:05:15 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421142603.3894-20-catalin.marinas@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Catalin,

On 4/21/20 11:25 AM, Catalin Marinas wrote:
> Add support for bulk setting/getting of the MTE tags in a tracee's
> address space at 'addr' in the ptrace() syscall prototype. 'data' points
> to a struct iovec in the tracer's address space with iov_base
> representing the address of a tracer's buffer of length iov_len. The
> tags to be copied to/from the tracer's buffer are stored as one tag per
> byte.
> 
> On successfully copying at least one tag, ptrace() returns 0 and updates
> the tracer's iov_len with the number of tags copied. In case of error,
> either -EIO or -EFAULT is returned, trying to follow the ptrace() man
> page.
> 
> Note that the tag copying functions are not performance critical,
> therefore they lack optimisations found in typical memory copy routines.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Alan Hayward <Alan.Hayward@arm.com>
> Cc: Luis Machado <luis.machado@linaro.org>
> Cc: Omair Javaid <omair.javaid@linaro.org>
> ---
> 
> Notes:
>      New in v3.
> 
>   arch/arm64/include/asm/mte.h         |  17 ++++
>   arch/arm64/include/uapi/asm/ptrace.h |   3 +
>   arch/arm64/kernel/mte.c              | 127 +++++++++++++++++++++++++++
>   arch/arm64/kernel/ptrace.c           |  15 +++-
>   arch/arm64/lib/mte.S                 |  50 +++++++++++
>   5 files changed, 211 insertions(+), 1 deletion(-)
>
I started working on MTE support for GDB and I'm wondering if we've 
already defined a way to check for runtime MTE support (as opposed to a 
HWCAP2-based check) in a traced process.

Originally we were going to do it via empty-parameter ptrace calls, but 
you had mentioned something about a proc-based method, if I'm not mistaken.

Regards,
Luis
