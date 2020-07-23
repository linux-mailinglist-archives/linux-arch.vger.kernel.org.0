Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01CC22B339
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jul 2020 18:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbgGWQM2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 12:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgGWQM2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 12:12:28 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3894AC0619DC;
        Thu, 23 Jul 2020 09:12:28 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a14so3247611pfi.2;
        Thu, 23 Jul 2020 09:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=VfbbwGv4m75EPfOW0baUXWN1YgZZBJIPGp1WqmJP8lg=;
        b=qY7x/OH9vNFSKZgAYfY6d0dn2o0FMZq+yslW+XFUxSS1ssfzwjJfnfDLJJz84VlOz6
         FPD5cVIIybdkZMWJ4OOnUqDLrl4fF4X24m/j769nnmiJsLn6LBjp37/nChKDD9EUZljz
         6dZoJG7phYQEZ8iU2fgjOjmHJHaygLKU4nNZb+JttbZn+9JZeXJy6B0yia9MH0Tp0cV+
         w6t52FrabMZwKTBfKVKaQx3eXb0AiAUV3lb7M+RIqfDaaYjI/UyhqwoowTCW0syaa86J
         Q+OoKNzCb2/DOBgNqaJXQKaNHd3UPmPnXrUgxodi/nq0w+y9beA/xQhR7vfQXQwUomi3
         0Wfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=VfbbwGv4m75EPfOW0baUXWN1YgZZBJIPGp1WqmJP8lg=;
        b=DSPjwtnpObFRySPMvCt9LwOSf9XRBO7HBxQkRBxrAfsKP+V009bYoHJ/GZLXVEuZRI
         TUZoFjaWpN8wcGssngqjTGrQEiBrz5DMLdM5O3bSJXrvP15/QOBytR3z8pug339ld/+q
         uAOGf9u3OXOyE+M+9m+SQyJoKG+vn2ocyM+9P/Rlz3BcRsWJ10nSxKFDLzd49TQVPQX0
         SVdKq7bAWOdRmASJywaOyJk5+F6LO/2dy9MQD5xM8BMhyII1B5HggfrMPX7M0fdBinMk
         o6l9SKczGnNWK282RD9gjKu9FHpLa+X9cMgwZ5itFo34d7H5PZxEGApWfRArfeHv7B+R
         GsOg==
X-Gm-Message-State: AOAM5322toWaaUc6iy3TtCo+E3718nP7o6jP5HpnkAXQhjWEjgC+A6SL
        JnzK8dq9ntXSu6vE9v8U/oI=
X-Google-Smtp-Source: ABdhPJwIS9sYrpZx7WWejQg+HhPLCX9upAMrSJWiKfOQ5V/wrdWIq5BPjwMO92bm7X0aGfua7RM/kg==
X-Received: by 2002:a62:768d:: with SMTP id r135mr5113582pfc.198.1595520747713;
        Thu, 23 Jul 2020 09:12:27 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id np5sm3527975pjb.43.2020.07.23.09.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 09:12:27 -0700 (PDT)
Date:   Fri, 24 Jul 2020 02:12:21 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 0/6] powerpc: queued spinlocks and rwlocks
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Anton Blanchard <anton@ozlabs.org>,
        Boqun Feng <boqun.feng@gmail.com>, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Will Deacon <will@kernel.org>
References: <20200706043540.1563616-1-npiggin@gmail.com>
        <24f75d2c-60cd-2766-4aab-1a3b1c80646e@redhat.com>
        <1594101082.hfq9x5yact.astroid@bobo.none>
        <20200708084106.GE597537@hirez.programming.kicks-ass.net>
        <1595327263.lk78cqolxm.astroid@bobo.none>
        <eaabf501-80fe-dd15-c03c-f75ce4f75877@redhat.com>
        <1595510571.u39qfc8d1o.astroid@bobo.none>
        <af825bce-ecf3-66e4-ad63-a844dbd2e775@redhat.com>
In-Reply-To: <af825bce-ecf3-66e4-ad63-a844dbd2e775@redhat.com>
MIME-Version: 1.0
Message-Id: <1595520724.nzha5zvbid.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Waiman Long's message of July 24, 2020 12:29 am:
> On 7/23/20 9:30 AM, Nicholas Piggin wrote:
>>> I would prefer to extract out the pending bit handling code out into a
>>> separate helper function which can be overridden by the arch code
>>> instead of breaking the slowpath into 2 pieces.
>> You mean have the arch provide a queued_spin_lock_slowpath_pending
>> function that the slow path calls?
>>
>> I would actually prefer the pending handling can be made inline in
>> the queued_spin_lock function, especially with out-of-line locks it
>> makes sense to put it there.
>>
>> We could ifdef out queued_spin_lock_slowpath_queue if it's not used,
>> then __queued_spin_lock_slowpath_queue would be inlined into the
>> caller so there would be no split?
>=20
> The pending code is an optimization for lightly contended locks. That is=20
> why I think it is appropriate to extract it into a helper function and=20
> mark it as such.
>=20
> You can certainly put the code in the arch's spin_lock code, you just=20
> has to override the generic pending code by a null function.

I see what you mean. I guess that would work fine.

Thanks,
Nick
