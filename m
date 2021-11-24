Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71FC45B831
	for <lists+linux-arch@lfdr.de>; Wed, 24 Nov 2021 11:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240744AbhKXKUl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Nov 2021 05:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240105AbhKXKUk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Nov 2021 05:20:40 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C41C061574;
        Wed, 24 Nov 2021 02:17:31 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r8so3215216wra.7;
        Wed, 24 Nov 2021 02:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=70LFuvA9BwzW8zf1KTQCL6giarK0Nl0WBEKJHk+tQGg=;
        b=lNcgdtvnOSWnBcldpNHr35YPikZfWlGARERZnGXQJam6dJ5VuAYn81zn2TkK5XVcV3
         yqIvxkjQ8EU+s+Hw4acAiBGGsJ/77nrR0Q9SbxrGA+upRT3a7gRWOIF/20QDjVw8QnW2
         /ne0b4ikIg0rXeJWo+VyBmh9PcBn64RGEr5xoiS1OqEoyQFr3F7AJHnC6D30e7r4I1KE
         fJ0oCb7xsyxiFsIUZVz71NEStgnCPdvbP9WA2OIKflWMvB3qHnD9enJrCJz3SNppTx4I
         8o38STuhK0/vLPmlo27lgUx1VPAk7JL4HIMU6xTJfsrCBjni+uW/dC5W9nSDezkCwZam
         m9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=70LFuvA9BwzW8zf1KTQCL6giarK0Nl0WBEKJHk+tQGg=;
        b=DPnFmowZGmDNrgWPQ4SxKMj9Y0Pu8Qv71EKcS0WLVmLgpxQRvbv8muULhs6G3TGu3B
         qCI+XJBlfsBCF0Fnfzykh6rN8lAK9OgDyu2T1ZF9l50JYoUoa/vy/lDdXeY61+dmEC12
         88YRaUbdGAgb5uZrPCsrP1p5hhpQsfC894lzVJQ/ZQGUNtFlD8xnI0Bvw5pU0oNqw6oR
         HQfXvTrFIVBaDp81iw4C8cJ+VvBB6nl3neWqJhOT/liu/HZGronZTuk64Jr+FGRJ36Dn
         k/mwtq8v4LPE8yQSMPwkZ3t8FqAdnIJ0ajOIedbA1vyF2GUAzEvQyRqzKFb94iAkl9QP
         nWig==
X-Gm-Message-State: AOAM5328Z0QWQHHYiiwLPa/koTaBpNq2o5dk2mVlOCQXHqQPgpvcVVlu
        ZbCUXovtuhnytPL22GFoM/k=
X-Google-Smtp-Source: ABdhPJw6qAm068rM9uv6H9YayQc+b8C9roADbIZnGBi3P3kdRFDA9zzgTdiUq3RKZXFYZkChf7L40A==
X-Received: by 2002:a05:6000:15c8:: with SMTP id y8mr17887347wry.101.1637749049690;
        Wed, 24 Nov 2021 02:17:29 -0800 (PST)
Received: from [10.168.10.11] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id n15sm4445528wmq.38.2021.11.24.02.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 02:17:29 -0800 (PST)
Sender: Alejandro Colomar <alx.mailinglists@gmail.com>
Message-ID: <fb57172d-9268-6aaf-1ba1-fa42a2a47c03@gmail.com>
Date:   Wed, 24 Nov 2021 11:17:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] uapi: Make __{u,s}64 match {u,}int64_t in userspace
Content-Language: en-US
To:     Florian Weimer <fweimer@redhat.com>, Cyril Hrubis <chrubis@suse.cz>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>
References: <YZvIlz7J6vOEY+Xu@yuki>
 <CAK8P3a0x5Bw7=0ng-s+KsUywqJYa0tk9cSWmZhx+cZRBOR87ZA@mail.gmail.com>
 <YZyw56flmdQnBIuh@yuki> <87a6hups6w.fsf@oldenburg.str.redhat.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
In-Reply-To: <87a6hups6w.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/23/21 20:50, Florian Weimer via Libc-alpha wrote:
> * Cyril Hrubis:
> 
>> As far as I can tell the userspace bits/types.h does exactly the same
>> check in order to define uint64_t and int64_t, i.e.:
>>
>> #if __WORDSIZE == 64
>> typedef signed long int __int64_t;
>> typedef unsigned long int __uint64_t;
>> #else
>> __extension__ typedef signed long long int __int64_t;
>> __extension__ typedef unsigned long long int __uint64_t;
>> #endif
>>
>> The macro __WORDSIZE is defined per architecture, and it looks like the
>> defintions in glibc sources in bits/wordsize.h match the uapi
>> asm/bitsperlong.h. But I may have missed something, the code in glibc is
>> not exactly easy to read.
> 
> __WORDSIZE isn't exactly a standard libc macro.

The (to-be) standard libc macro would be LONG_WIDTH (although it has a 
slightly different meaning, but it can be used for this, but then the 
code also needs to expose <limits.h>), rigth?

Regards,
Alex

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
