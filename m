Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E29222EF6
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jul 2020 01:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgGPX1E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jul 2020 19:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgGPX1E (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 19:27:04 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2F6C061755;
        Thu, 16 Jul 2020 16:27:04 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l63so5690732pge.12;
        Thu, 16 Jul 2020 16:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=emv834qbGgi893dX/IaKrVeomPzEVS0ZG+EyN4ke6Jw=;
        b=BxY54KCj4kiARNkK+N4vp/W9OTuudktsuJd+WODxPAeDB4oFxO4DQsQB4GI6IM8Gas
         UJN/mRtbMfMb7XYESBrFdSYxHm0/dz5lI2i/IvV6zif0bXiZCQ+gabEvMQ/IDQfQisVf
         qes+jiODle+UMzXIbB4xMZ9XK1erPvZaombyKjkf2dPCBjxm1hRdpabhchByUJPhDzib
         1F8S+2UX/dzkcedaYb5el1Xm3NMrNgCIzlZ/QU0AfZ6HYI73UBsnFviQsYS1R4bLJyiY
         ZznnhHQxDV5gPYJtSWQnGIgTy8kG8Ine/794rLiZ9vTmkP2RhhiHUWsR4lNJs0KKqWp4
         Ibpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=emv834qbGgi893dX/IaKrVeomPzEVS0ZG+EyN4ke6Jw=;
        b=sSfhWaxXF+xNariXnzkSVtRhaQQnJasKUaF+qLb0QwhMwF3opD6kRSQ005h4Xd7W9A
         IGFbyNICM1iHoXKyWtRFgelqL+T/ea46Vj9kbsS0VLcxGxCyKJL5h/ezhr+S3b4E9l+V
         Xk1QFvsqU6GwwSy0UDeMvvOOKHp69uRYItizBimx/rFtnh2m12qwYn8JtVW0qt8TcGTo
         vajA2c0PtgosYqDTKxtYLbcKIiWVxaUMGpdCpOCTdrUTblRvRvUDVV3Q6BRQ1LlU/hTl
         JV7N250s12iL999HRzh9pxRTiz8GsujXoqiml2ZafO4HprrC5yywetGOGd+4LLipSs7g
         s27g==
X-Gm-Message-State: AOAM530cNtnP6jXIzqVq4nrOA48LlyKq2ayU7emTsdNMUc8irOSallk0
        8CBbAg901HJ5vF3UA4rKGWw=
X-Google-Smtp-Source: ABdhPJzsas/W/l7YZ8rsW53AbEGEaqr8R3Pt+kUjAsFkMcalVEs2KKHzvH8Zn5PQ137qjCJoqRQ5XQ==
X-Received: by 2002:a63:fc52:: with SMTP id r18mr6477752pgk.334.1594942023742;
        Thu, 16 Jul 2020 16:27:03 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id 4sm5684665pgk.68.2020.07.16.16.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 16:27:03 -0700 (PDT)
Date:   Fri, 17 Jul 2020 09:26:57 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
To:     peterz@infradead.org
Cc:     Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        x86 <x86@kernel.org>
References: <1594868476.6k5kvx8684.astroid@bobo.none>
        <EFAD6E2F-EC08-4EB3-9ECC-2A963C023FC5@amacapital.net>
        <20200716085032.GO10769@hirez.programming.kicks-ass.net>
        <1594892300.mxnq3b9a77.astroid@bobo.none>
        <20200716110038.GA119549@hirez.programming.kicks-ass.net>
In-Reply-To: <20200716110038.GA119549@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1594906688.ikv6r4gznx.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from peterz@infradead.org's message of July 16, 2020 9:00 pm:
> On Thu, Jul 16, 2020 at 08:03:36PM +1000, Nicholas Piggin wrote:
>> Excerpts from Peter Zijlstra's message of July 16, 2020 6:50 pm:
>> > On Wed, Jul 15, 2020 at 10:18:20PM -0700, Andy Lutomirski wrote:
>> >> > On Jul 15, 2020, at 9:15 PM, Nicholas Piggin <npiggin@gmail.com> wr=
ote:
>=20
>> >> But I=E2=80=99m wondering if all this deferred sync stuff is wrong. I=
n the
>> >> brave new world of io_uring and such, perhaps kernel access matter
>> >> too.  Heck, even:
>> >=20
>> > IIRC the membarrier SYNC_CORE use-case is about user-space
>> > self-modifying code.
>> >=20
>> > Userspace re-uses a text address and needs to SYNC_CORE before it can =
be
>> > sure the old text is forgotten. Nothing the kernel does matters there.
>> >=20
>> > I suppose the manpage could be more clear there.
>>=20
>> True, but memory ordering of kernel stores from kernel threads for
>> regular mem barrier is the concern here.
>>=20
>> Does io_uring update completion queue from kernel thread or interrupt,
>> for example? If it does, then membarrier will not order such stores
>> with user memory accesses.
>=20
> So we're talking about regular membarrier() then? Not the SYNC_CORE
> variant per-se.

Well, both but Andy in this case was wondering about kernel writes
vs user.

>=20
> Even there, I'll argue we don't care, but perhaps Mathieu has a
> different opinion. All we care about is that all other threads (or CPUs
> for GLOBAL) observe an smp_mb() before it returns.
>=20
> Any serialization against whatever those other threads/CPUs are running
> at the instant of the syscall is external to the syscall, we make no
> gauarantees about that. That is, we can fundamentally not say what
> another CPU is executing concurrently. Nor should we want to.
>=20
> So if you feel that your membarrier() ought to serialize against remote
> execution, you need to arrange a quiecent state on the remote side
> yourself.
>=20
> Now, normally membarrier() is used to implement userspace RCU like
> things, and there all that matters is that the remote CPUs observe the
> beginngin of the new grace-period, ie counter flip, and we observe their
> read-side critical sections, or smething like that, it's been a while
> since I looked at all that.
>=20
> It's always been the case that concurrent syscalls could change user
> memory, io_uring doesn't change that, it just makes it even less well
> defined when that would happen. If you want to serialize against that,
> you need to arrange that externally.

membarrier does replace barrier instructions on remote CPUs, which do
order accesses performed by the kernel on the user address space. So
membarrier should too I guess.

Normal process context accesses like read(2) will do so because they
don't get filtered out from IPIs, but kernel threads using the mm may
not.

Thanks,
Nick
