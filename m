Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1318D21CE0B
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jul 2020 06:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgGMESG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jul 2020 00:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGMESF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2020 00:18:05 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989C5C08C5DB;
        Sun, 12 Jul 2020 21:18:05 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k5so5592312pjg.3;
        Sun, 12 Jul 2020 21:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=7eTyj3gi1aDtq3SZwRhPj7xrS/kHyNTzp5Clbf9/H6g=;
        b=QRDb8cXXiZkV8Jv4Up2PFxkS5KHTOYddBYTIDa6dX9ihMQFwQnfsELMxnUTvgIWnzK
         QXKGV4lOaMTkGovvo3/7/3x6XRSB1bZc4OYdb4vq9kSpp+RUZaXob0xk+9MilQVoa05J
         9tmK2+UqLA08+XbDnwbdkB0htl0lfkZULaSfS2arEL41H5zhm5OMuA2d5fLOUBd2EgdE
         QA/E42tJ/hyqy+TwTZXW7XxlONY+DJ3CKCG2k/lo7lldCv2JIj1irlqjE0eMYkNtoKhi
         SzGwaQpb9+lwjP15fccW4jpb0WcLmLByDLwZ4p9jNmYpweCU89YyEMOAw2jDa15W17wL
         4IMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=7eTyj3gi1aDtq3SZwRhPj7xrS/kHyNTzp5Clbf9/H6g=;
        b=jNrCdmvt2IS9q3Tk+pHU75yqjbr/Kap2j/JIT1KjUhVCAQBQc++QkGjXPxkSxTUKto
         KBQcwqB0EmRTVmOhJiJJwig9NpTyWAyNjRdobttm9GQXsLsv8rWiBVe9txqp0lzkBPm8
         s//5nvVkRx4h5Xtpt4G+Ve1G+M0f8WIFTmxWsIzhDCuzj1ni36E2H70z6XIFcuZ6AVtU
         Yd+X4h4s17E5sjc6zSL4+S0cN083P+2hMXcu3XlCXTIsOfvCUn7biNBBDi1JUqgJyF6m
         OdDJZKwT1S70bWGTUIMLWDUYeBcJMl5STj5RpyafqObqVVqzPDyQ+yXJ0uaLXmZDPJHR
         crrw==
X-Gm-Message-State: AOAM530YOhvDcvbMnEeigVavgy1xJeXys0agfVRDAiY1xB67GmHxbVpA
        b/4a8UoCjxz1gOqfO18KnrBR544L
X-Google-Smtp-Source: ABdhPJx+GAyBv7OofMWetqnuVFBnAzXlniiILxzw/lkl7krvOWYJnZrxjdrz1SdE3tI+aK2C8xKLWg==
X-Received: by 2002:a17:90a:e7cd:: with SMTP id kb13mr17936288pjb.138.1594613885005;
        Sun, 12 Jul 2020 21:18:05 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id my9sm13652282pjb.44.2020.07.12.21.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 21:18:04 -0700 (PDT)
Date:   Mon, 13 Jul 2020 14:17:58 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/2] locking/pvqspinlock: Optionally store lock holder cpu
 into lock
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org
References: <20200711182128.29130-1-longman@redhat.com>
        <20200711182128.29130-3-longman@redhat.com>
        <20200712173452.GB10769@hirez.programming.kicks-ass.net>
        <bed22603-e347-8bff-f586-072a18987946@redhat.com>
In-Reply-To: <bed22603-e347-8bff-f586-072a18987946@redhat.com>
MIME-Version: 1.0
Message-Id: <1594613637.ds7pt1by9l.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Waiman Long's message of July 13, 2020 9:05 am:
> On 7/12/20 1:34 PM, Peter Zijlstra wrote:
>> On Sat, Jul 11, 2020 at 02:21:28PM -0400, Waiman Long wrote:
>>> The previous patch enables native qspinlock to store lock holder cpu
>>> number into the lock word when the lock is acquired via the slowpath.
>>> Since PV qspinlock uses atomic unlock, allowing the fastpath and
>>> slowpath to put different values into the lock word will further slow
>>> down the performance. This is certainly undesirable.
>>>
>>> The only way we can do that without too much performance impact is to
>>> make fastpath and slowpath put in the same value. Still there is a slig=
ht
>>> performance overhead in the additional access to a percpu variable in t=
he
>>> fastpath as well as the less optimized x86-64 PV qspinlock unlock path.
>>>
>>> A new config option QUEUED_SPINLOCKS_CPUINFO is now added to enable
>>> distros to decide if they want to enable lock holder cpu information in
>>> the lock itself for both native and PV qspinlocks across both fastpath
>>> and slowpath. If this option is not configureed, only native qspinlocks
>>> in the slowpath will put the lock holder cpu information in the lock
>>> word.
>> And this kills it,.. if it doesn't make unconditional sense, we're not
>> going to do this. It's just too ugly.
>>
> You mean it has to be unconditional, no option config if we want to do=20
> it. Right?
>=20
> It can certainly be made unconditional after I figure out how to make=20
> the optimized PV unlock code work.

Sorry I've not had a lot of time to get back to this thread and test
things -- don't spend loads of effort or complexity on it until we get
some more numbers. I did see some worse throughput results (with no
attention to fairness) with the PV spin lock, but it was a really quick
limited few tests, I need to get something a bit more substantial.

I do very much appreciate your help with the powerpc patches, and
interest in the PV issues though. I'll try to find more time to help
out.

Thanks,
Nick
