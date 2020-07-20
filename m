Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728DC226CC3
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jul 2020 19:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732733AbgGTRCX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jul 2020 13:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730579AbgGTRCW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jul 2020 13:02:22 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003B4C061794
        for <linux-arch@vger.kernel.org>; Mon, 20 Jul 2020 10:02:21 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q3so13913541ilt.8
        for <linux-arch@vger.kernel.org>; Mon, 20 Jul 2020 10:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lLa51XHV19pSn8dCau2GuTKu0LZrcXv1DrhKxMQG6SQ=;
        b=VcHZcngkwm/n7gdBFYMeUsSdh5uZvMVcDjIBV3ECeQR8GAZCLzW/ix7cDJDD4mkw8j
         XvXBGxCga3mtMWCHZyakDM16MKnA20qLojDjxmaMOM2hAQFo3xkfcuygPVr3do95FJzw
         /iXRZJCdZkPfSkB027sq0tDcY4+Y38vvKTW4YXISYUWJRLtYsTQuEP1+Oc87ev80laL2
         G+ZPldX2GCPKQ3LR3oUw2d1qiycFNcp19R40LW3VYX2NPOi3FQI7ZWFNsRui/BDnepP8
         mnc7/F2Cq94AzCvhFEBa3icJeg/Eox3xAjWyP1BRBrgbuMzqTYQIPa05G9ZF9RHUN9aI
         BGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lLa51XHV19pSn8dCau2GuTKu0LZrcXv1DrhKxMQG6SQ=;
        b=S7eU6IWTLZHXEVe3/jRzgolWuG9bL5X0kQskjtW3kMyFuuAlA5h3+3QZGQMDuNgsqi
         0UmD+9n4OU53dc9IblouKWZ7N7V62fpkoa+8nMgfScDNZMYBt7zgTEsFERkSdxb+1JI1
         rX7PBEyX/yGb/TcrwouvXALLxsxTk3E0EUOz+RqvS7piJ/FccYn9aOXxNyGdboo1ORja
         jfJAuID6gvqiGIIX58Iq54AEr4ZSpmo1Wg4iRGBFQOH4tM6CQzLH4kSAaCCYwl2DAaec
         q4Ck3LBbyv/Js1o43uo/LEdaBNucZak3a5txeKtTe57q7hg24PHD0w+ar92d4QfxlWT/
         5jnw==
X-Gm-Message-State: AOAM5307xooi831TBhdQTpbQcp7HG0hJCiaspGqYlLNRjF1CxR9vAcp5
        DWx7/O0xDRdi4eX4lxHY81gL0A==
X-Google-Smtp-Source: ABdhPJz5zLxNXcsTdxphGCNjFI0YjQ5J7FtVKPPcrF4sltl8mBBoIBkKciDhL+q4GYsjdYBiefx/jQ==
X-Received: by 2002:a92:c689:: with SMTP id o9mr24384488ilg.302.1595264541233;
        Mon, 20 Jul 2020 10:02:21 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m2sm9126349iln.1.2020.07.20.10.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 10:02:20 -0700 (PDT)
Subject: Re: io_uring vs in_compat_syscall()
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        io-uring@vger.kernel.org
References: <ceb21006-26d0-b216-84a9-5da0b89b5fbf@kernel.dk>
 <BACE670C-6A65-4D86-BC5F-A7EA267C3140@amacapital.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b754dad5-ee85-8a2f-f41a-8bdc56de42e8@kernel.dk>
Date:   Mon, 20 Jul 2020 11:02:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BACE670C-6A65-4D86-BC5F-A7EA267C3140@amacapital.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/20/20 10:58 AM, Andy Lutomirski wrote:
> 
>> On Jul 20, 2020, at 9:37 AM, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> ﻿On 7/20/20 12:10 AM, Christoph Hellwig wrote:
>>> Hi Jens,
>>>
>>> I just found a (so far theoretical) issue with the io_uring submission
>>> offloading to workqueues or threads.  We have lots of places using
>>> in_compat_syscall() to check if a syscall needs compat treatmenet.
>>> While the biggest users is iocttl(), we also have a fair amount of
>>> places using in_compat_task() in read and write methods, and these
>>> will not do the wrong thing when used with io_uring under certain
>>> conditions.  I'm not sure how to best fix this, except for making sure
>>> in_compat_syscall() returns true one way or another for these cases.
>>
>> We can probably propagate this information in the io_kiocb via a flag,
>> and have the io-wq worker set TS_COMPAT if that's the case.
>>
> 
> Is TS_COMPAT actually a cross-arch concept for which this is safe?
> Having a real arch helper for “set the current syscall arch for the
> current kernel thread” seems more sensible to me. 

Sure, I'd consider that implementation detail for the actual patch(es)
for this issue.

-- 
Jens Axboe

