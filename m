Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007421C6EAE
	for <lists+linux-arch@lfdr.de>; Wed,  6 May 2020 12:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgEFKrW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 May 2020 06:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726906AbgEFKrW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 May 2020 06:47:22 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE577C061A0F;
        Wed,  6 May 2020 03:47:21 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x25so2059124wmc.0;
        Wed, 06 May 2020 03:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U0c/o/ih8XjkFs39T8/w2Mwm5aWOHE3x26AvSmeqkow=;
        b=ByXxKed4vRtB5iUhx98ERXa2zcUOX8CFtZIoDyqobQQJ4GDJvGgI+4leRrmWAI6hPw
         +WhK+co7vjVRa6K0kU2NANHtsOfvy9EYTKk7sfizvaHp45b3sDQHcZm0mTOr+shYNnIF
         UMDzuDL60DVOdgOC0Ux+2fBwwEN3f0qWeg3Q8bc7bghSXlynWtB4K6cIgbLhv3tky2qJ
         /8aNnjhm/qOwaUg6WVffawlKMXKz5PcZe9HADlw91OkPgWOzUD/Xfw/13GwMn4y2ug/H
         P9RNGPFQAHYdxKgHwo1/GxIt9BB8AQgqPTdtDIYKlgZ30NPyZnNUIpeQzBCriumQoUX3
         bkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U0c/o/ih8XjkFs39T8/w2Mwm5aWOHE3x26AvSmeqkow=;
        b=LZ2DPwMUsfLpRbREDpzfIYo6bqhX/zqJGC2/Vtht5Ekl/lUuB3aybBW/t3rzGEjYV6
         rjT/j7AAKsqEwYwknGYMHMSmAbVu2fs0N6tj8KgC8MzR0d9v2SNu+RRVeCR+EVtd69iY
         suCKrFO5u5agtjGEG2LitMpWGZD9N4K0/oKf345Q8eFhDiOk8MOEe48JMs9zj0tXZe4G
         BFPwYo3THJ+sECnhHqpYIUhP4POG6k3+oHAFpFLLDnntliOvl2zjep4ak5g5eOuIAWTF
         /+eZMIrZqAXgwC7TJrV46LC7reVTT03JbV2oU/pmFR7FzrgGk80pXrfQgRe3BfVrZq+t
         k8wg==
X-Gm-Message-State: AGi0PuYxF+WEaHgjaVwbs4U8Bh27aiMki4UJFJ0YWbQPFAxNdVr8DVac
        u3HkufAdz5MBcYICfkXvSSU=
X-Google-Smtp-Source: APiQypJ8txgcmPuJN8scqmElYyg8NVhJ5SI+oZnH5Ko3rK0TUA6rrxrBxXMiCzbtry3mhMJeZsL4sw==
X-Received: by 2002:a1c:e444:: with SMTP id b65mr3924139wmh.6.1588762040281;
        Wed, 06 May 2020 03:47:20 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id l5sm2325865wmi.22.2020.05.06.03.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 03:47:19 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: RFC: Adding arch-specific user ABI documentation in linux-man
To:     Dave Martin <Dave.Martin@arm.com>
References: <20200504153214.GH30377@arm.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <07855941-d0f7-2ec6-819e-e43a8935e29e@gmail.com>
Date:   Wed, 6 May 2020 12:47:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504153214.GH30377@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello Dave, et al.

On 5/4/20 5:32 PM, Dave Martin wrote:
> Hi all,
> 
> I considering trying to plug some gaps in the arch-specific ABI
> documentation in the linux man-pages, specifically for arm64 (and
> possibly arm, where compat means we have some overlap).

Sounds good to me.

> For arm64, there are now significant new extensions (Pointer
> authentication, SVE, MTE etc.)  Currently there is some user-facing
> documentation mixed in with the kernel-facing documentation in the
> kernel tree, but this situation isn't ideal.
> 
> Do you have an opinion on where in the man-pages documentation should be
> added, and how to structure it?
> 
> 
> Affected areas include:
> 
>  * exec interface

Not sure what the details are here, so I have no opinion yet.
But probably, as additions to execve(2).

>  * aux vector, hwcaps

==> getauxval(3)

>  * arch-specific signals
>  * signal frame

Not sure what the details are here, so I have no opinion yet.

>  * mmap/mprotect extensions

See below.

>  * prctl calls

As additions in prctl(2) would be fine, I think.

>  * ptrace quirks and extensions

See below.

>  * coredump contents

Not sure what the details are here, so I have no opinion yet.
Possibly as additions to core(5).

> Not everything has an obvious home in an existing page, 

Yes.

> and adding
> specifics for every architecture could make some existing manpages very
> unwieldy.

Still, I think it's worth adding details, especially for widely
used architectures.
 
> I think for some arch features, we really need some "overview" pages
> too: just documenting the low-level details is of limited value
> without some guide as to how to use them together.
> 
> 
> Does the following sketch look reasonable?
> 
>  * man7/arm64.7: new page: overview of arm64-specific ABI extensions

I'm a little unclear on what would land in here, but sounds 
reasonable in principle.

>  * man7/sve.7 (or man7/arm64-sve.7 or man7/sve.7arm64): new page:
>    overview of arm64 SVE ABI

Sounds reasonable to me.

>  * man2/arm64-ptrace.2 (or man2/ptrace.2arm64): new page:
>    arm64 ptrace extensions

I think maybe better is: ptrace-arm64.2

I'm agnostic about whether there should be a new page, or whether 
these should be added to ptrace(2). But, we could start with the
idea of a new page.

>  * man2/mmap.2: extend with arm64-specific flags (only two flags, so we
>    add them to the existing man page rather than creating a new one).

Sounds good to me

> etc.
> 
> 
> Ideally, I'd like to adopt a pattern that other arches can follow.

Well, if they do follow. Arch-specific documentation is woefully
thin at the moment. I'm not going to worry too much about the right
pattern (don't let perfect get in the way of good, yadda, yadda),
until I get so much arch-specific documentation that some refactoring
may be required. (I'm not going to hold my breath waiting for that
to happen ;-).)

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
