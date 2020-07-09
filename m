Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D55219DA9
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jul 2020 12:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgGIKZN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 06:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgGIKZF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 06:25:05 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA38EC061A0B
        for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2020 03:25:04 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b92so910411pjc.4
        for <linux-arch@vger.kernel.org>; Thu, 09 Jul 2020 03:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=b2NeK05XWB0xDJ7gbj6dxeZbhLfM0JEMlPnaA+COod8=;
        b=h3icAK0fJlduSxaVJZTAsAbBOXWSxN4IoYHK8mdc1bCh1bsLxSIRHiIVfUBzc1NIk4
         aoS/LYGHK2VtD9IJjgkcsYAiHBNDI5I/E9YfhQN+zvgbc0Sf+ycTqzneR/HN2BDzvLwH
         Q2NkaNM+WU969yGnPwKGrc5gVFFKNhZLEDB8Wrk5PdIFMYw+IjQ9SG4k3hotPwn1fe1/
         PkDr0zWaYC0j89w8FyTmwpQTbCevkciW+WhITHnKtX+zqcrDC1lMP6LttxQPbpM+yVht
         D5GQ4RzZJEfyRBjOJVXeLp/yD/BbL/R+GWtYKEZJdg+8aZ50SP5aWC/FwiNOqOn19AgU
         VCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=b2NeK05XWB0xDJ7gbj6dxeZbhLfM0JEMlPnaA+COod8=;
        b=SXVNl0VWRPBWFNYofbdqZqW9pdov2oSMaRDWmxSmNpV+4sGjbzLenFpM2S3GKFSBLi
         tk4eFVN8+eWAWgIUe5SO0iAygVqLspHUnzQI0OxmkSdXpUTNW+bsIndyHt8oczXpvaO9
         XOILsR2w542pODEGb/pzJ+eHgmFo9aayROS4wKwJw7+QMvPw+dKDF2mSX7KQd0ITnScM
         JcVtmrH7eDv4gG7/3p2GrDqDs+nJ0Q00lJMBtndQCTS/NoX3pEsr8S4AutYGOFszfKGe
         idtofWKB5BwHIDrhU/apOCDoS21AZRbcZQxhbUYHAHXsWCZDd66OvKgCn0ZGhDNtOKgN
         UKwA==
X-Gm-Message-State: AOAM531wTw/GWWlW5648ZXDX7mGqOnI6ziIAg+myXUhaVXzCXLk5Cs05
        N0a1JFq5Mz368F3EjFL28LR/52FbqL4lag==
X-Google-Smtp-Source: ABdhPJyW7NYnbURxdwM8YP4WKOabd+AK4ezMjz49kVRoyMbLLTmNSYA/GBxbPfH1AietJHL0utbNeQ==
X-Received: by 2002:a17:90a:7185:: with SMTP id i5mr15201660pjk.170.1594290304419;
        Thu, 09 Jul 2020 03:25:04 -0700 (PDT)
Received: from localhost (27-33-0-186.tpgi.com.au. [27.33.0.186])
        by smtp.gmail.com with ESMTPSA id l15sm2101883pjq.1.2020.07.09.03.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 03:25:03 -0700 (PDT)
Date:   Thu, 09 Jul 2020 20:24:56 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc: select ARCH_HAS_MEMBARRIER_SYNC_CORE
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20200706021822.1515189-1-npiggin@gmail.com>
        <cf10b0bc-de79-1b2b-8355-fc7bbeec47c3@csgroup.eu>
        <1594098302.nadnq2txti.astroid@bobo.none>
        <638683144.970.1594121101349.JavaMail.zimbra@efficios.com>
        <1594185107.e130s0d92x.astroid@bobo.none>
        <407005394.1910.1594217551840.JavaMail.zimbra@efficios.com>
In-Reply-To: <407005394.1910.1594217551840.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Message-Id: <1594290193.f21t9y66td.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Mathieu Desnoyers's message of July 9, 2020 12:12 am:
> ----- On Jul 8, 2020, at 1:17 AM, Nicholas Piggin npiggin@gmail.com wrote=
:
>=20
>> Excerpts from Mathieu Desnoyers's message of July 7, 2020 9:25 pm:
>>> ----- On Jul 7, 2020, at 1:50 AM, Nicholas Piggin npiggin@gmail.com wro=
te:
>>>=20
> [...]
>>>> I should actually change the comment for 64-bit because soft masked
>>>> interrupt replay is an interesting case. I thought it was okay (becaus=
e
>>>> the IPI would cause a hard interrupt which does do the rfi) but that
>>>> should at least be written.
>>>=20
>>> Yes.
>>>=20
>>>> The context synchronisation happens before
>>>> the Linux IPI function is called, but for the purpose of membarrier I
>>>> think that is okay (the membarrier just needs to have caused a memory
>>>> barrier + context synchronistaion by the time it has done).
>>>=20
>>> Can you point me to the code implementing this logic ?
>>=20
>> It's mostly in arch/powerpc/kernel/exception-64s.S and
>> powerpc/kernel/irq.c, but a lot of asm so easier to explain.
>>=20
>> When any Linux code does local_irq_disable(), we set interrupts as
>> software-masked in a per-cpu flag. When interrupts (including IPIs) come
>> in, the first thing we do is check that flag and if we are masked, then
>> record that the interrupt needs to be "replayed" in another per-cpu
>> flag. The interrupt handler then exits back using RFI (which is context
>> synchronising the CPU). Later, when the kernel code does
>> local_irq_enable(), it checks the replay flag to see if anything needs
>> to be done. At that point we basically just call the interrupt handler
>> code like a normal function, and when that returns there is no context
>> synchronising instruction.
>=20
> AFAIU this can only happen for interrupts nesting over irqoff sections,
> therefore over kernel code, never userspace, right ?

Right.

>> So membarrier IPI will always cause target CPUs to perform a context
>> synchronising instruction, but sometimes it happens before the IPI
>> handler function runs.
>=20
> If my understanding is correct, the replayed interrupt handler logic
> only nests over kernel code, which will eventually need to issue a
> context synchronizing instruction before returning to user-space.

Yes.

> All we care about is that starting from the membarrier, each core
> either:
>=20
> - interrupt user-space to issue the context synchronizing instruction if
>   they were running userspace, or
> - _eventually_ issue a context synchronizing instruction before returning
>   to user-space if they were running kernel code.
>=20
> So your earlier statement "the membarrier just needs to have caused a mem=
ory
> barrier + context synchronistaion by the time it has done" is not strictl=
y
> correct: the context synchronizing instruction does not strictly need to
> happen on each core before membarrier returns. A similar line of thoughts
> can be followed for memory barriers.

Ah okay that makes it simpler, then no such speical comment is required=20
for the powerpc specific interrupt handling.

Thanks,
Nick
