Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39771C5F94
	for <lists+linux-arch@lfdr.de>; Tue,  5 May 2020 20:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbgEESDh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 May 2020 14:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730093AbgEESDh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 May 2020 14:03:37 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81670C061A0F
        for <linux-arch@vger.kernel.org>; Tue,  5 May 2020 11:03:37 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id fb4so1473149qvb.7
        for <linux-arch@vger.kernel.org>; Tue, 05 May 2020 11:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cle1DWcPgPwaZVS6K0GMi0byjOYCQs6ur6FJmvddoLs=;
        b=J1uhBg+3MkuM1j9tvj0WGa7CGjzz9eGSspQTqVRSKqIdeC3wyzadBR3U7aKzH5oULK
         1NBjfx6a+kMXoR0J517DVHPn0CVf6YL9au+1tCE8PnDcWU90F52qXsF3oy6DnBiG/fm4
         dMGFzOJORy0Gxy5s+E3q2lJ01+5YkrzdLkpM6mgb058B182LFtrBfwEJoJZZaCLaXOf6
         ZV6IWTrmh7mUs0GBUEpPi+H/OVLR8nI5+T8OWbGeCrvk1S3TCuFPycFL2XDyiZXO8act
         npVP+w7T+3cyPoxbYqwTrIn+nJsCzBsEpe5mjtm5s3MW73yagI+0b9NjLgfUbh4YmcaO
         gVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cle1DWcPgPwaZVS6K0GMi0byjOYCQs6ur6FJmvddoLs=;
        b=CoP84w/9kUhyN40OrC9qbkagzwn310l0kFzO3lfRfqxyPSGGwCIeZxZJzrsCbHFR8m
         bgET5w1xmx0KQOTngETWA4BPdD9pT0SEZQlmO8ApPQfQ1HD+HpFIbw1yVg9qqPgIxSzf
         qi0rvzpjzibGj9JAIlpa+M832f2MZJwsF4UXJzPNRDGw309FoPuKbXp/Bw6492SXk0/+
         d+BJ0lPWmNF6PYqWgOJMpkEmxZiA22IspK4izzyeOWcnnrxshxFGhQuBuRv6Z0RHxO3I
         co5iIFmEjH4VMI7JSfCmBI5tcAaNkLuN83Aec+CHRcmvuLVLTOoxbuI/nBHO24dBX1Dc
         CGew==
X-Gm-Message-State: AGi0PuZb2sew83cwhR/lW4HbFcQDhm7QRKBSRBqVKdfWsM946cx5pIep
        CU9Y02KIK2WyvJ0HPW6xlY8fZA==
X-Google-Smtp-Source: APiQypJa6N5F6cPRll3YQL8uaSBvMyiPNIl4PgWRh95sWBVd9KkFeg2UCfAEuV2oheS/qEcgVKCSDw==
X-Received: by 2002:a0c:8262:: with SMTP id h89mr3848628qva.173.1588701816621;
        Tue, 05 May 2020 11:03:36 -0700 (PDT)
Received: from [192.168.0.185] ([191.249.236.107])
        by smtp.gmail.com with ESMTPSA id c26sm2326833qkm.98.2020.05.05.11.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 11:03:35 -0700 (PDT)
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
Message-ID: <b78fe0c4-f89e-9347-7d7d-a68085f70b1d@linaro.org>
Date:   Tue, 5 May 2020 15:03:29 -0300
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

I'll try to exercise the new ptrace requests with QEMU and GDB.
