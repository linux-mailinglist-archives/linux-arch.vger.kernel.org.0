Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D06E4E4758
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 21:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbiCVUUo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Mar 2022 16:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbiCVUUn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2022 16:20:43 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD2B3A19D
        for <linux-arch@vger.kernel.org>; Tue, 22 Mar 2022 13:19:14 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so4065598wmj.0
        for <linux-arch@vger.kernel.org>; Tue, 22 Mar 2022 13:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod-ie.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9rkIk0IBSzyeRqe3plIoBCEstX3E14ta3gpsDDOz6VQ=;
        b=w0g7/vAzsbVJ77bW2HILV854Pep6hfzLmiCTuW5XJtShxVs/kqM26LN2jde3Ps9PfF
         ylA2xoaZrP3rNmRerFiVrVZuPoh/RVBUo2b9k3uOF/hV3KCLjkUOHj9Xvx/D13iA6p2x
         egbG551k9ZIGhJ6VX3ccsVLlWN8vTOXkEp9FKv408xAYQmuaaecjWTXL0yVF7ghHaRcP
         ANHA7mtVOSOHNOuu/PZj4TBnQ4zeksHibjmvhRbKnbR+0dwkxhMYx1AZmLXXiRHKNCHL
         uPZMqLjMZ2WHp2xspt7JBFvePB2GglHR+JwS0BAiDjdXv/1DvcsWMhbvMKPPztP9Jhd8
         Gi6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9rkIk0IBSzyeRqe3plIoBCEstX3E14ta3gpsDDOz6VQ=;
        b=GTjRkAsMNfkTSxZc3eWIgnC7O5ZgB+0lwgfvk1AHGK8/cki9rWRQXP9hPhiFOxl7K7
         Z10yOKrVh001/PoEzON4FhVkHj3pyWvOZy37QOPs4mYH9bFKdMOLRiBwA6t1PI8ifyYe
         P2J2EronjKTxWoZorEeFcNhr7GiMMHhj1mKKGp4rljuF9F8dB4lswUligVB+NuFzSJei
         OL0wo7lFA+V6VLBi3zX7n7ETD/QaBSEeKvyB/mR8wvc6Pg/ctG5V6uMFc6biv3jv7dC/
         W1buTQ/TXWJFj4tcne2BPoBBxYE0VOSOpARzh0MP6J3ntMBR7SNiV8ycaMFv8Z/P4LsM
         7aqg==
X-Gm-Message-State: AOAM533a1DtlfB5ma7x0S095RpIV9jHxz8NzJETj2H/WB8zzNEmV7Jw6
        UEGrBoc0wuyqhrTfMuKM9bY+Xg==
X-Google-Smtp-Source: ABdhPJwdsNeBRxq7SP9jrWlxnEHi4CbGxrooYjpyKb2EZkVSYaPeJUODsNxxuPr2Es0m2O3k2xSVWQ==
X-Received: by 2002:a05:600c:4e0d:b0:38c:a6da:adec with SMTP id b13-20020a05600c4e0d00b0038ca6daadecmr5600285wmq.145.1647980353450;
        Tue, 22 Mar 2022 13:19:13 -0700 (PDT)
Received: from [192.168.2.116] ([109.76.4.19])
        by smtp.gmail.com with ESMTPSA id k35-20020a05600c1ca300b0038ca38626c0sm2480240wms.16.2022.03.22.13.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 13:19:13 -0700 (PDT)
Message-ID: <7dca0cb8-f0aa-a4cf-7f6f-0e4025527f5d@conchuod.ie>
Date:   Tue, 22 Mar 2022 20:19:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/5] Generic Ticket Spinlocks
Content-Language: en-US
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        mingo@redhat.com, Will Deacon <will@kernel.org>,
        longman@redhat.com, boqun.feng@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        jszhang@kernel.org, wangkefeng.wang@huawei.com,
        openrisc@lists.librecores.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, peterz@infradead.org
References: <mhng-f97b1e7d-1523-4ae5-923b-e73a8db48824@palmer-ri-x1c9>
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <mhng-f97b1e7d-1523-4ae5-923b-e73a8db48824@palmer-ri-x1c9>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 22/03/2022 20:02, Palmer Dabbelt wrote:
> On Tue, 22 Mar 2022 11:18:18 PDT (-0700), mail@conchuod.ie wrote:
>> On 16/03/2022 23:25, Palmer Dabbelt wrote:
>>> Peter sent an RFC out about a year ago
>>> <https://lore.kernel.org/lkml/YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net/>, 
>>>
>>> but after a spirited discussion it looks like we lost track of things.
>>> IIRC there was broad consensus on this being the way to go, but there
>>> was a lot of discussion so I wasn't sure.  Given that it's been a year,
>>> I figured it'd be best to just send this out again formatted a bit more
>>> explicitly as a patch.
>>>
>>> This has had almost no testing (just a build test on RISC-V defconfig),
>>> but I wanted to send it out largely as-is because I didn't have a SOB
>>> from Peter on the code.  I had sent around something sort of similar in
>>> spirit, but this looks completely re-written.  Just to play it safe I
>>> wanted to send out almost exactly as it was posted.  I'd probably rename
>>> this tspinlock and tspinlock_types, as the mis-match kind of makes my
>>> eyes go funny, but I don't really care that much.  I'll also go through
>>> the other ports and see if there's any more candidates, I seem to
>>> remember there having been more than just OpenRISC but it's been a
>>> while.
>>>
>>> I'm in no big rush for this and given the complex HW dependencies I
>>> think it's best to target it for 5.19, that'd give us a full merge
>>> window for folks to test/benchmark it on their systems to make sure it's
>>> OK.
>>
>> Is there a specific way you have been testing/benching things, or is it
>> just a case of test what we ourselves care about?
> 
> I do a bunch of functional testing in QEMU (it's all in my 
> riscv-systems-ci repo, but that's not really fit for human consumption 
> so I don't tell folks to use it).  That's pretty much useless for 
> something like this: sure it'd find something just straight-up broken in 
> the lock implementation, but the stuff I'm really worried about here 
> would be poor interactions with hardware that wasn't designed/tested 
> against this flavor of locks.
> 
> I don't currently do any regular testing on HW, but there's a handful of 
> folks who do.  If you've got HW you care about then the best bet is to 
> give this a shot on it.  There's already been some boot test reports, so 
> it's at least mostly there (on RISC-V, last I saw it was breaking 
> OpenRISC so there's probably some lurking issue somewhere).  I was 
> hoping we'd get enough coverage that way to have confidence in this, but 
> if not then I've got a bunch of RISC-V hardware lying around that I can 
> spin up to fill the gaps.

Aye, I'll at the very least boot it on an Icicle (which should *finally* 
be able to boot a mainline kernel with 5.18), but I don't think that'll 
be a problem.

> As far as what workloads, I really don't know here.  At least on RISC-V, 
> I think any lock microbenchmarks would be essentially meaningless: this 
> is fair, so even if lock/unlock is a bit slower that's probably a win 
> for real workloads.  That said, I'm not sure any of the existing 
> hardware runs any workloads that I'm personally interested in so unless 
> this is some massive hit to just general system responsiveness or 
> make/GCC then I'm probably not going to find anything.

There's a couple benchmarks we've been looking at, although I'm not sure 
that they are "real" workloads. If they encounter any meaningful 
difference I'll let you know I guess.


> Happy to hear if anyone has ideas, though.

Me too!
