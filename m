Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1075255348
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 05:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgH1D0g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 23:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgH1D0g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 23:26:36 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0BEC061264;
        Thu, 27 Aug 2020 20:26:36 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u128so5100867pfb.6;
        Thu, 27 Aug 2020 20:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=iBQhZHSuHwT2I3fZ7mC/MttQdOOhPQb2HUpxN0OEuwE=;
        b=Gw03Ya3LWIjg/S6j49TxS1k3q1026Pk4BNLPwKO26SSWjE34vMZizuprKVLBay9uzz
         wwo/8aeJGTNoCjFRBRQ8zRhq03IsFKZ0NyuKmMqXky6p+6pL9yDXOVwtpsnurjtk0rF1
         6pJXsptIhO013w3iLwhmEO/sFrFVliupbYVeEgvwGi4uFb8Va7qC2tl4egXrrGj5rri1
         cvzf9XTosoWpIQsQDJIjFKC8tUGED3nFcKpj+x4VqNXn4vBYg5zZDWkCNdMfewIpjHwq
         exlmDyE+n7zFp00ZNHuaToSJC3u3CDsDQodgGERqq97yvEXsJdUFe0S86QVq9YGjLS9r
         CqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=iBQhZHSuHwT2I3fZ7mC/MttQdOOhPQb2HUpxN0OEuwE=;
        b=B3m/mKs0EQ7zqs/X+z37sHNhzPYFhTF6H9G5NPf1+9MWC3FF32VfkMmIq9DhWpCOMp
         Rlq75tbSo8NCAxZTAxIxRDoDRuJpgJ9d2nnNxrMoiNLcAAQwBXJkr4y8WqG4+iN+qbtR
         osBYTLYUfmyyOE1Aq+mS0BFKt51XgXYmDCNZF4QfeLMBQKQJmEwfoRIzEUwO0e8UiCCB
         gPqVf5zbxa/kn9TyguiqruRMN00Av1nA1Cdr0mf5BUE1PHxs/nRiCnSR11GEVRd41taQ
         PoGNzcxjfau2J1piVyTiYfwZyZXsTBA0zG94ZoSjFE7WDHJ5Gh6DBToHyk160qsO9yth
         LNSg==
X-Gm-Message-State: AOAM530/KC0//qpY4NmYHoEPyZ9QkKy3JB3w5olrODTIxDlVLdTaQCN9
        VNHcOrXkeCCS+h5JMKTToBc=
X-Google-Smtp-Source: ABdhPJyIan9x/B9Rk3wk3F8CelTdZ9oXTLM1WR4tobWEXkcK+Ab2CYk+omSEesgRS98XsZ4j+mL2qA==
X-Received: by 2002:a65:6545:: with SMTP id a5mr17344497pgw.43.1598585195581;
        Thu, 27 Aug 2020 20:26:35 -0700 (PDT)
Received: from localhost (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id b20sm4585699pfp.140.2020.08.27.20.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 20:26:34 -0700 (PDT)
Date:   Fri, 28 Aug 2020 13:26:28 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3] mm: Fix kthread_use_mm() vs TLB invalidate
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        peterz@infradead.org, linux-arch@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, axboe@kernel.dk,
        hch@lst.de, jannh@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@amacapital.net,
        mathieu.desnoyers@efficios.com, torvalds@linux-foundation.org,
        will@kernel.org
References: <20200721154106.GE10769@hirez.programming.kicks-ass.net>
        <87y2m8muag.fsf@linux.ibm.com>
        <20200821130445.GP1362448@hirez.programming.kicks-ass.net>
In-Reply-To: <20200821130445.GP1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1598583976.kyraed50wg.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from peterz@infradead.org's message of August 21, 2020 11:04 pm:
> On Fri, Aug 21, 2020 at 11:09:51AM +0530, Aneesh Kumar K.V wrote:
>> Peter Zijlstra <peterz@infradead.org> writes:
>>=20
>> > For SMP systems using IPI based TLB invalidation, looking at
>> > current->active_mm is entirely reasonable. This then presents the
>> > following race condition:
>> >
>> >
>> >   CPU0			CPU1
>> >
>> >   flush_tlb_mm(mm)	use_mm(mm)
>> >     <send-IPI>
>> > 			  tsk->active_mm =3D mm;
>> > 			  <IPI>
>> > 			    if (tsk->active_mm =3D=3D mm)
>> > 			      // flush TLBs
>> > 			  </IPI>
>> > 			  switch_mm(old_mm,mm,tsk);
>> >
>> >
>> > Where it is possible the IPI flushed the TLBs for @old_mm, not @mm,
>> > because the IPI lands before we actually switched.
>> >
>> > Avoid this by disabling IRQs across changing ->active_mm and
>> > switch_mm().
>> >
>> > [ There are all sorts of reasons this might be harmless for various
>> > architecture specific reasons, but best not leave the door open at
>> > all. ]
>>=20
>>=20
>> Do we have similar race with exec_mmap()? I am looking at exec_mmap()
>> runnning parallel to do_exit_flush_lazy_tlb(). We can get
>>=20
>> 	if (current->active_mm =3D=3D mm) {
>>=20
>> true and if we don't disable irq around updating tsk->mm/active_mm we
>> can end up doing mmdrop on wrong mm?
>=20
> exec_mmap() is called after de_thread(), there should not be any mm
> specific invalidations around I think.
>=20
> Then again, CLONE_VM without CLONE_THREAD might still be possible, so
> yeah, we probably want IRQs disabled there too, just for consistency and
> general paranoia if nothing else.

The problem is probably not this TLB flushing race, but I think there
is a lazy tlb race.

  call_usermodehelper()
    kernel_execve()
      old_mm =3D current->mm;
      active_mm =3D current->active_mm;
      *** preempt *** ---------------------->schedule()
                                               prev->active_mm =3D NULL;
					       mmdrop(prev active mm)
					     ...=20
                      <----------------------schedule()
      current->mm =3D mm;
      current->active_mm =3D mm;
      if (!old_mm)
          mmdrop(active_mm); /* double free! */

There's possibly other problematic interleavings. powerpc also has an
issue with switching away a lazy tlb mm via IPI which is basically the
same problem so I just illustrate the more general issue.

I think we just make it a rule that these always get updated under
local_irq_disable, to be safe.

Trouble is we can't just do it, because some architectures can't do
activate_mm with irqs disabled. ARM and UM, at least. UM can't even
do preempt_disabled. We can probably change them to make them work,
I'm not sure what the best way to go is, my first attempt is to require
activate_mm to do the mm switching and the irq disable as well, but
I'll need some help from the archs

I'll send out rfcs in a minute.

Thanks,
Nick
