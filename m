Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6663AA479
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jun 2021 21:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbhFPTnO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Jun 2021 15:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbhFPTnN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jun 2021 15:43:13 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96131C061574;
        Wed, 16 Jun 2021 12:41:07 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id x19so1658468pln.2;
        Wed, 16 Jun 2021 12:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=qb5d+U0Id8lIqAWfxQheAcWONeEcboJpT5+z508o/Ww=;
        b=HQF8dUO0vj/JLY5AGo7v2s8QQaIzYV63qYOxawNXAC3aRARyE+nU5hzCMBYgwpOUA+
         q8nRzMkhc/tm6xxqwnopRUIz9WhF/HjXQjuanWT1+4mEkJ0UbKeZivFfZx94lhKOnQOP
         Ts7ZOjGA+YuFjIs9CLzBW3fINp+e9Um330Lz/Ig9wIZRxuRqLJJQam+5oQ2mzJV7WY1H
         yGwhgdKL8GJ1aWOeIyR1DNwwTwqNOo7pvB7p1J30SaPr82rNVxB7EhI/vk2o1PYt2hoc
         pp4iCipOjQ4/v83k/wL7M+dB89WD9kEBv4C8g2FUeiatzg/lKnEzH/64bvnzamhh106y
         ef/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qb5d+U0Id8lIqAWfxQheAcWONeEcboJpT5+z508o/Ww=;
        b=iYENDc5yElHPjw4YOGF82Qg2SfN9ravFncjx0gC0p/ww89ZHuTJVcq2Lc51syH/G1o
         rws5ujpPSHK4QLJj4NyCsTd42pdfCJR9zmwvs+f94SSj7TSk21IVqjb6OHV2bOfA8CQr
         YMHyyaBzHfusBYIC630haeUMfkKIReyNCi3SqZxMn3BS/l352VpR7pcj389sna7LOK+c
         wp07OXWOdTsEqeYgQ0r0CRzaVPdzirska+/pCBnvSCmKPo9gV91KEUfJOh2X1vU4n1Y+
         HekSh3bZG8tuLF+4EJvjR4QfH5aMIrIZi4zTBRJFj0fNZlaZ7t4nmK+QYqsQOFqhpBeg
         bpPw==
X-Gm-Message-State: AOAM531djmFcUav1tZQxXOEN4EKJ/ofDpnkdmU3ahvOX9pBRt7Wm+wl6
        LUiub79CTJBjU7K35m75zX7uZRpocHJeTw==
X-Google-Smtp-Source: ABdhPJzC0pt4q7UA0ciR0y49Yot7y5oDh8kUDh16LPHavXhtDkCpQ2gTyxwhSMJ+vZZwvexZYwYg7w==
X-Received: by 2002:a17:90a:9f8f:: with SMTP id o15mr1473325pjp.55.1623872467040;
        Wed, 16 Jun 2021 12:41:07 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:9d12:c2c8:273e:6ffd? ([2001:df0:0:200c:9d12:c2c8:273e:6ffd])
        by smtp.gmail.com with ESMTPSA id c14sm3086391pgv.86.2021.06.16.12.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 12:41:06 -0700 (PDT)
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>
References: <87sg1p30a1.fsf@disp2133>
 <CAHk-=wjiBXCZBxLiCG5hxpd0vMkMjiocenponWygG5SCG6DXNw@mail.gmail.com>
 <87pmwsytb3.fsf@disp2133>
 <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
 <87sg1lwhvm.fsf@disp2133>
 <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
 <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com>
 <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com> <87eed4v2dc.fsf@disp2133>
 <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com> <87fsxjorgs.fsf@disp2133>
 <CAMuHMdUkhbq+tOyrpyd5hKGGcpYduBnbnXKFBwEfCGjw5XGYVA@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <594ca040-3ad3-5cfe-2b9e-8e7804c199b5@gmail.com>
Date:   Thu, 17 Jun 2021 07:40:57 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUkhbq+tOyrpyd5hKGGcpYduBnbnXKFBwEfCGjw5XGYVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Geert,

On 16/06/21 7:38 pm, Geert Uytterhoeven wrote:
> Hi Eric,
>
> On Tue, Jun 15, 2021 at 9:32 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>> Do you happen to know if there is userspace that will run
>> in qemu-system-m68k that can be used for testing?
> There's a link to an image in Laurent's patch series "[PATCH 0/2]
> m68k: Add Virtual M68k Machine"
> https://lore.kernel.org/linux-m68k/20210323221430.3735147-1-laurent@vivier.eu/

Thanks, I'll try that one.

I'll try and implement a few of the solutions Eric came up with for 
alpha, unless someone beats me to it (Andreas?).

Cheers,

     Michael


>
> Gr{oetje,eeting}s,
>
>                          Geert
>
