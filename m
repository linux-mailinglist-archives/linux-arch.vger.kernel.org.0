Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54CA217EEF
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jul 2020 07:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgGHFK7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Jul 2020 01:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgGHFK6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jul 2020 01:10:58 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAC0C061755;
        Tue,  7 Jul 2020 22:10:58 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x11so17674845plo.7;
        Tue, 07 Jul 2020 22:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=NBE822KLqldc4RgjTMLNTL7g5oeVKxCy90pB/bhnbqA=;
        b=M8TEn2dPCMOvBZET4JnaMDMy0lYBY2dVPXjJw8C+E1TwnoBBTuk66pgPu2fJqXKVx1
         B5vvUPxm8LxCIC+/4HpDyj9eQK+FH+k8I9aySXAuKaiX/IyWQBl6c9oSucY0pJSrHdhk
         kmKB9L6ekk6XeywFS7Hoy/JAxeOTezXXqTtHJtI9+cpy4/BmerCtU+RNLW1bt+52PMrU
         Pk0YR8Vd5fowCPr/XR1VDl6eRw8K/yg3l2NMayfyGThwcRjmydMPd/jZW4d43k68o1N9
         VVe106DV3DoJXbOl4exlvOx0GiUCrvhWLD74gWkyw6keF+43d7HBt78+En6/6Yio7WIE
         LqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=NBE822KLqldc4RgjTMLNTL7g5oeVKxCy90pB/bhnbqA=;
        b=JhmWHhxHnTLLZqVh6MLdbLZsUoEJqjkKkaYICO3X93xJBE+tRD7Rb3a13X5ey4OrdX
         LiglmSeb6/XlTOfZQNEm26bGG4cNQsdT4+aP8DulXL0SR5ORTqXKPbqZU+oVWsbJ5/FN
         +QzwB+EYF9q2H7aloJxyHn3bk66GdzmbnK48Ii/3VuoCYjruY8/Nr+82tvhwtVYSvzxZ
         VKA01lPrOWuasxEtHVapcjvjWmPq48LxPvfGb8pyONzcsJLZ4J4SIv/8bloAIbqzs5wp
         rDXMFG7ePl2gv91unAPKDS8eQFjLXPxak2PSn53R3eRryR02oaR40cWUt4BAaPDZ+Ut0
         eo7Q==
X-Gm-Message-State: AOAM531jaDN9B+Q7f1Hgn0qGmVgOFAQ1K6907Jrc/UE0qek2wnaGIe5j
        as1grOCoqzduZASsaFgKVcI=
X-Google-Smtp-Source: ABdhPJy7irHmoUu0ynDnJY978dkucESYFNMabuBQ/Z2GkOluE+v9BuscHayaBiw3xLfuRm15lUcw4A==
X-Received: by 2002:a17:902:b114:: with SMTP id q20mr23771251plr.266.1594185058097;
        Tue, 07 Jul 2020 22:10:58 -0700 (PDT)
Received: from localhost (61-68-186-125.tpgi.com.au. [61.68.186.125])
        by smtp.gmail.com with ESMTPSA id m20sm25080630pfk.52.2020.07.07.22.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 22:10:57 -0700 (PDT)
Date:   Wed, 08 Jul 2020 15:10:52 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 0/6] powerpc: queued spinlocks and rwlocks
To:     linuxppc-dev@lists.ozlabs.org, Waiman Long <longman@redhat.com>
Cc:     Anton Blanchard <anton@ozlabs.org>,
        Boqun Feng <boqun.feng@gmail.com>, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        virtualization@lists.linux-foundation.org,
        Will Deacon <will@kernel.org>
References: <20200706043540.1563616-1-npiggin@gmail.com>
        <24f75d2c-60cd-2766-4aab-1a3b1c80646e@redhat.com>
        <1594101082.hfq9x5yact.astroid@bobo.none>
        <de3ead58-7f81-8ebd-754d-244f6be24af4@redhat.com>
In-Reply-To: <de3ead58-7f81-8ebd-754d-244f6be24af4@redhat.com>
MIME-Version: 1.0
Message-Id: <1594184204.ncuq7vstsz.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Waiman Long's message of July 8, 2020 1:33 pm:
> On 7/7/20 1:57 AM, Nicholas Piggin wrote:
>> Yes, powerpc could certainly get more performance out of the slow
>> paths, and then there are a few parameters to tune.
>>
>> We don't have a good alternate patching for function calls yet, but
>> that would be something to do for native vs pv.
>>
>> And then there seem to be one or two tunable parameters we could
>> experiment with.
>>
>> The paravirt locks may need a bit more tuning. Some simple testing
>> under KVM shows we might be a bit slower in some cases. Whether this
>> is fairness or something else I'm not sure. The current simple pv
>> spinlock code can do a directed yield to the lock holder CPU, whereas
>> the pv qspl here just does a general yield. I think we might actually
>> be able to change that to also support directed yield. Though I'm
>> not sure if this is actually the cause of the slowdown yet.
>=20
> Regarding the paravirt lock, I have taken a further look into the=20
> current PPC spinlock code. There is an equivalent of pv_wait() but no=20
> pv_kick(). Maybe PPC doesn't really need that.

So powerpc has two types of wait, either undirected "all processors" or=20
directed to a specific processor which has been preempted by the=20
hypervisor.

The simple spinlock code does a directed wait, because it knows the CPU=20
which is holding the lock. In this case, there is a sequence that is=20
used to ensure we don't wait if the condition has become true, and the
target CPU does not need to kick the waiter it will happen automatically
(see splpar_spin_yield). This is preferable because we only wait as=20
needed and don't require the kick operation.

The pv spinlock code I did uses the undirected wait, because we don't
know the CPU number which we are waiting on. This is undesirable because=20
it's higher overhead and the wait is not so accurate.

I think perhaps we could change things so we wait on the correct CPU=20
when queued, which might be good enough (we could also put the lock
owner CPU in the spinlock word, if we add another format).

> Attached are two=20
> additional qspinlock patches that adds a CONFIG_PARAVIRT_QSPINLOCKS_LITE=20
> option to not require pv_kick(). There is also a fixup patch to be=20
> applied after your patchset.
>=20
> I don't have access to a PPC LPAR with shared processor at the moment,=20
> so I can't test the performance of the paravirt code. Would you mind=20
> adding my patches and do some performance test on your end to see if it=20
> gives better result?

Great, I'll do some tests. Any suggestions for what to try?

Thanks,
Nick
