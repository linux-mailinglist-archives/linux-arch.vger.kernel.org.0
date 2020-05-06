Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324611C6EB5
	for <lists+linux-arch@lfdr.de>; Wed,  6 May 2020 12:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgEFKrg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 May 2020 06:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726906AbgEFKrf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 May 2020 06:47:35 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E516C061A0F;
        Wed,  6 May 2020 03:47:35 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id i15so1187763wrx.10;
        Wed, 06 May 2020 03:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YMCXD5LGztBg7JfOelcWwNhCDu7FuBBcxRsV60XtEAo=;
        b=Y8WXmokd2pErbDdcDf7F3cP6PmYX/GsgXwL3h9RazlUnQtnY7Tlsy4Yjn2lsNJcFp2
         rC4fLZAokmrD9jnz4Vamu/M6qB1P+nX8X+VrDA0cq6+wS8Lzb3EAf8ggXJtEytELHf3y
         r/WdWRUdpK9AddGoj+2jbiQc7IhQ4fJ3oRC1Rtrke5jiboKh6vHfqm/D7zZasfdl+Nz4
         hKZojbQzSZUo74WTECEDGBYET5BIwbRZRUM5T1lqWw34fxQNKTkVK2A9etDbE2azb2kS
         lkn0PZ+QmGUAkiAarzXu2wIdqVPu1a1+BZ0SQolXuQn0f/l7cOfdGVwnyknKXW9K3NEp
         t4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YMCXD5LGztBg7JfOelcWwNhCDu7FuBBcxRsV60XtEAo=;
        b=dCdEE41B/scj5Pd3vGkNV4ni9yhsH/V9Umuj9uRjo32O/NACpKtLf+1XsYM00y11sV
         uHpITgPZTKGHxYlNWZJGlFaLgZfNxwXpLt3pmwfBFs7wZ62rz/YGPF98j6Z+XwgpwRMw
         d5RUqmkPf8czxc4zimJxcbgxiJKmjI7CZ2FRjCZ7Plx1A9pxpMmkyUXPGmY1sz1sySEL
         TobSmDwBpxWZ6mfPpDFxppvcLnpqSTdhcVsDGT1dwsHuPHdI9n8Gc7Bx6Z/6bpCNEhAZ
         K2aS6r4VQg/MGIWqrGuHzhqFmzbumpIhYhLV4WEHLGVEsJfDRQDJneGroqH2QEtNh5v+
         W0Kw==
X-Gm-Message-State: AGi0PuZZN5JfP+3EsT9LorNI/uDRR0sOq8G7F9gkg1tf4SuUwwPJBJb2
        TKSm4B400tkdC29PCxLbpgg=
X-Google-Smtp-Source: APiQypKnrRvA12nCVu7Igad+mH9LiQdBaizE/qeWhqt8uv7hWDVm7SfWfcy1W4zqCKbhI6SrQaSPUQ==
X-Received: by 2002:a5d:6504:: with SMTP id x4mr9778390wru.340.1588762054390;
        Wed, 06 May 2020 03:47:34 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id s24sm2488066wmj.28.2020.05.06.03.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 03:47:33 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Dave Martin <Dave.Martin@arm.com>,
        linux-arch@vger.kernel.org, linux-man@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: RFC: Adding arch-specific user ABI documentation in linux-man
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>
References: <20200504153214.GH30377@arm.com>
 <20200505104454.GC19710@willie-the-truck>
 <20200505124351.GF1551@shell.armlinux.org.uk>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <a86c4f3e-b50e-0541-074f-1bfcb4a93b5d@gmail.com>
Date:   Wed, 6 May 2020 12:47:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505124351.GF1551@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/5/20 2:43 PM, Russell King - ARM Linux admin wrote:
> On Tue, May 05, 2020 at 11:44:55AM +0100, Will Deacon wrote:
>> Michael has been nagging me on and off about that for, what, 10 years now?
>> I would therefore be very much in favour of having our ptrace extensions
>> documented!
>>
>> We could even put this stuff under Documentation/arm64/man/ if it's deemed
>> too CPU-specific for the man-pages project, but my preference would still
>> be for it to be hosted there alongside all the other man pages.
> 
> Stuffing random things into the kernel tree is painful for some people.

Yes, and too often not easily noticeable for user-space programmers.
> 
> For example, if you cross-build your kernel, then the stuff in the
> tools/ subdirectory is totally useless (I think everything except
> perf) because you can't build it.
> 
> Let's stop making the mistake of constantly shoving stuff into the
> kernel source tree.

Agrred.

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
