Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF801F38EF
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jun 2020 13:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgFILDj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Jun 2020 07:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgFILDi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2020 07:03:38 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCD6C05BD1E;
        Tue,  9 Jun 2020 04:03:38 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h5so20803854wrc.7;
        Tue, 09 Jun 2020 04:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aJNdMPWPrN93u2hPRulOatep/HuM2hucF4eVhI1US+c=;
        b=ii3Kp2RazJaBkch/duwZbyVhWvA96NeuRemtYCHvICOVqGMZ9fqAL+tv4aY2oloHs9
         UDYcukqmHcoFgL1W35n3tPruj6T2zltrIhmnjVJKYcMzdw3kY4cbMa6748DdrnJPCnUJ
         oSraDkPINlOIYc4UrVHatbWB/WE89OiSccHp4nT5Wjet9duVIlwNst85oyGlpoRrJ+a3
         muWcYaRPuobHejZXDq9R7ANwndujzG0KmaUSe0wFZSrDNgX9eTmjralrY64We/7YDXyy
         L2/o77bqjU49hUmJCIIck8JsCiJuelfBRK8GHBQFVmDUsUTp8mDjKmR/SnqRJjXNnFL4
         ExTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aJNdMPWPrN93u2hPRulOatep/HuM2hucF4eVhI1US+c=;
        b=P91ZeHHVnMOMiBw4MfZkKZBG1xbA/hNGXAPnAKQCGar6NOCpLB1gJ0Gf0rVPIVIpgZ
         vHBGJLv/0ccpXrH7v9lVpZWGThwFQJ6ZCdNbwAhHjSd1nhEQbqnVtC2A4cPD14AKGbid
         OhS60uq247/WP/2ogIZNAsGUPNamxmG1ck4DefxwFF3C+3WcxaiDfrtMo4CKOZROtJIF
         5KCe7fqSPB8YNxnbkrH1zR/21J7SRl0JXN60niUjGUteoJD6lwR/jazlJvlQ3MFKHCuk
         NdiPYT8hAKUQf7CnleyKMLbOy+/odGIpDVVh/Cuki4D5HE47dmz7NKrw2IPMeTDhJBsI
         liXA==
X-Gm-Message-State: AOAM531Carg9+BDSKMHl8OoWDueWqhkpnfYxbOZr+U9qjYKlnaARr4xU
        FtCFff5sRr3rjUNIFKuUpIE=
X-Google-Smtp-Source: ABdhPJwVUqzL+yIQWFnqQp/zOzCZpAquIuPC80KWKaHY3VIwX9zTyBdZ/zHOQLPn14UQtgHcjaViHg==
X-Received: by 2002:a05:6000:100e:: with SMTP id a14mr3732821wrx.349.1591700616981;
        Tue, 09 Jun 2020 04:03:36 -0700 (PDT)
Received: from ?IPv6:2001:a61:253c:8201:b2fb:3ef8:ca:1604? ([2001:a61:253c:8201:b2fb:3ef8:ca:1604])
        by smtp.gmail.com with ESMTPSA id 23sm2503265wmg.10.2020.06.09.04.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 04:03:36 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 5/6] prctl.2: Add PR_PAC_RESET_KEYS (arm64)
To:     Will Deacon <will@kernel.org>, Dave Martin <Dave.Martin@arm.com>
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
 <1590614258-24728-6-git-send-email-Dave.Martin@arm.com>
 <20200609100202.GB25362@willie-the-truck>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <7571ba40-7b4e-ca6d-efb1-691b1c4a6d04@gmail.com>
Date:   Tue, 9 Jun 2020 13:03:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609100202.GB25362@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Will,

Thanks for reviewing.

On 6/9/20 12:02 PM, Will Deacon wrote:
> On Wed, May 27, 2020 at 10:17:37PM +0100, Dave Martin wrote:
>> Add documentation for the PR_PAC_RESET_KEYS ioctl added in Linux
>> 5.0 for arm64.
> 
> [...]
> 
>> +If the arguments are invalid,
>> +and in particular if
>> +.I arg2
>> +contains set bits that are unrecognized
>> +or that correspond to a key not available on this platform,
>> +the call fails with error
>> +.BR EINVAL .
>> +.IP
>> +.B Warning:
>> +Because the compiler or run-time environment
>> +may be using some or all of the keys,
>> +a successful
>> +.IP
>> +For more information, see the kernel source file
>> +.I Documentation/arm64/pointer\-authentication.rst
>> +.\"commit b693d0b372afb39432e1c49ad7b3454855bc6bed
>> +(or
>> +.I Documentation/arm64/pointer\-authentication.txt
>> +before Linux 5.3).
>> +.B PR_PAC_RESET_KEYS
>> +may crash the calling process.
> 
> I might be misreading this, but this looks like the kernel reference appears
> mid-sentence. 

It's hidden as a comment (.\").

> Regardless, I think we should drop the kernel doc reference,
> as I mentioned on the SVE patches.

I actually request that people add these kinds of comments in the source.
It helps me verify details in patches, and is also handy when checking
details in the future.

> With that:
> 
> Acked-by: Will Deacon <will@kernel.org>

Thanks.

Cheers,

Michael



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
