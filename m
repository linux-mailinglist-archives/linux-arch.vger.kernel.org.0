Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2F3491029
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jan 2022 19:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238242AbiAQSQo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Jan 2022 13:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiAQSQo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Jan 2022 13:16:44 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EB9C061574
        for <linux-arch@vger.kernel.org>; Mon, 17 Jan 2022 10:16:43 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id g205so24723335oif.5
        for <linux-arch@vger.kernel.org>; Mon, 17 Jan 2022 10:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YbSXZb6U5/gBXtPoXH1tBfKbCD50u97JOowOL8+wMp0=;
        b=g7v8l7VLPOZ7rbh5X9eYoioWExIvOtdSPCty+mbNu/TstD7fO79GhxKxO7WRR2j4ba
         ajYg/M3lcbDeiVy0ex8nrzYt5gXMweZTDEaQe9Nv6h86U8xCPfUQcBOMiZp+hwqYfv1T
         fc1J1QOvSkqO38XB0REmnTHBb2nUVZa9VS4sWIHWrqxRR1xeNYR00sSWB6HPyE3IMEPO
         YTX2B/D1DFYKdUJYl23K6fAqtgjPs2ZmdcPCTRmO7ASr7sUGlzgyJaTiuL6tWndInY6Z
         6gt3XYmJKZp5CqMcBdA1bcw4UekrwemZXjQFMpttxnR/z3fCCHx11UPsnkvOrJOfCnwk
         jnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YbSXZb6U5/gBXtPoXH1tBfKbCD50u97JOowOL8+wMp0=;
        b=19DDJLXGDAxCUtucnsVe5HI80znetc1Y7S1GWSE5+XcQt001iXCVdOVJegWi0crF9Y
         mfWRS2WTEnJpiH1qyvJtkH64wjYGdPVa1c5cwjsunw7zI58SOIiKcsXXd9MggK3wZVGL
         SPs/IcOwZVsSX4dzxKya5Hu/uEbp+NGfL88T222uZJMb9Vd7WJAJDLm0JMLD5M23oKXj
         XMFJwGZR3fs8A6BSorgZHoYk+vyoZlC5/ycWElQ22OsYTma21uqbdb0o//4srqoc4Ya3
         UjBMa+Ldh3+4yVnsCaj5mwx6Zq0+/vdApyJt9hNV/RQM1U5X0/PF8sfljiHzFiQZ6AE/
         3NsA==
X-Gm-Message-State: AOAM531W22BmsXI7gHiGhVXYOOfa+aNCWe39B/u4Tupayvdxzzs3d2uS
        T5O5qj6IrvMkeF8PyL0uHUSDbA==
X-Google-Smtp-Source: ABdhPJx/1pyfb2/mB3ClEs+wAsLxuwIRXyTg2ZnbXc8jRPznydhuHYr65iv181eA7VFjivvgzmjXBQ==
X-Received: by 2002:a05:6808:189b:: with SMTP id bi27mr4283972oib.140.1642443402953;
        Mon, 17 Jan 2022 10:16:42 -0800 (PST)
Received: from ?IPV6:2804:431:c7cb:989a:152:78c4:5eab:b8b5? ([2804:431:c7cb:989a:152:78c4:5eab:b8b5])
        by smtp.gmail.com with ESMTPSA id k24sm5946389otl.31.2022.01.17.10.16.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 10:16:42 -0800 (PST)
Message-ID: <20ae043b-a013-068d-2d83-16e63f5b4989@linaro.org>
Date:   Mon, 17 Jan 2022 15:16:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v7 0/4] arm64: Enable BTI for the executable as well as
 the interpreter
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arch@vger.kernel.org, Yu-cheng Yu <yu-cheng.yu@intel.com>,
        libc-alpha@sourceware.org, Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20211115152714.3205552-1-broonie@kernel.org>
 <YbD4LKiaxG2R0XxN@arm.com> <20211209111048.GM3294453@arm.com>
 <YdSEkt72V1oeVx5E@sirena.org.uk>
 <101d8e84-7429-bbf1-0271-5436eca0eea2@arm.com> <YdbL5kIzi0xqVTVd@arm.com>
 <8550afd2-268d-a25f-88fd-0dd0b184ca23@arm.com> <YdcxUZ06f60UQMKM@arm.com>
 <Ydc+AuagOD9GSooP@sirena.org.uk> <YdgrjWVxRGRtnf5b@arm.com>
 <YeWtRk0H30q38eM8@arm.com>
From:   Adhemerval Zanella <adhemerval.zanella@linaro.org>
In-Reply-To: <YeWtRk0H30q38eM8@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 17/01/2022 14:54, Catalin Marinas via Libc-alpha wrote:
> On Fri, Jan 07, 2022 at 12:01:17PM +0000, Catalin Marinas wrote:
>> I think we can look at this from two angles:
>>
>> 1. Ignoring MDWE, should whoever does the original mmap() also honour
>>    PROT_BTI? We do this for static binaries but, for consistency, should
>>    we extend it to dynamic executable?
>>
>> 2. A 'simple' fix to allow MDWE together with BTI.
> 
> Thinking about it, (1) is not that different from the kernel setting
> PROT_EXEC on the main executable when the dynamic loader could've done
> it as well. There is a case for making this more consistent: whoever
> does the mmap() should use the full attributes.
> 
> Question for the toolchain people: would the compiler ever generate
> relocations in the main executable that the linker needs to resolve via
> an mprotect(READ|WRITE) followed by mprotect(READ|EXEC)? If yes, we'd
> better go for a proper MDWE implementation in the kernel.
> 

Yes, text relocations.  However these are deprecated (some libcs even do
not support it) and have a lot of drawbacks.
