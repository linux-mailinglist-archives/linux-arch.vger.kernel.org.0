Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A8979E2BC
	for <lists+linux-arch@lfdr.de>; Wed, 13 Sep 2023 10:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239140AbjIMI4X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Sep 2023 04:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239177AbjIMI4V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Sep 2023 04:56:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADAE61993
        for <linux-arch@vger.kernel.org>; Wed, 13 Sep 2023 01:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694595328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7IDrq/ZjwAliy/cuqJYdam/hL0PUOvTA7Mi9bsbloig=;
        b=caxjCmskNBOux9IjaT14OV9MMmP2Aflw0stDJpoULQk0VwdtHkIu1U+iTRFEDn/l8O/075
        d0JHoFA+ct41TiVgjXqu7alvBMQSYdVcJaIVCwXtOj3o7k6Q7XIooyEfDEb6VyjkfBCL5m
        AiUZ+ww55m+Qwseb3M43skeX61AjbCs=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-4zGE3OpuPieH8G2R-xmfGw-1; Wed, 13 Sep 2023 04:55:27 -0400
X-MC-Unique: 4zGE3OpuPieH8G2R-xmfGw-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3ab29aedbcbso7717014b6e.1
        for <linux-arch@vger.kernel.org>; Wed, 13 Sep 2023 01:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694595326; x=1695200126;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7IDrq/ZjwAliy/cuqJYdam/hL0PUOvTA7Mi9bsbloig=;
        b=WGGdTrSQ1xZw5aTRwLvsjMHI/40hYGB/+anxEZFoTOomQqplNiyWKyY/SqJS9LEp+4
         mh5Z0Gig63J2ck8fCf9VOJZ23Q5Cuyz5ClqqZLrnupsYwh5UOfMnyADU8Tt/23Jn4wX+
         CYQ3Auy3EN8vihhCsAayjY+o4O3IicTQIYTqmJ2H/dmmYTeiKBGe9Ue9ZwIf+q5/9W20
         VdJaRnZdWsYAzUDBtnxuqM6hoyIWRm/M/b/zE4tDImiZfpW7+M0A5DeyaPBl5psPLG0d
         GJaO3xwrtJjeCbVpu5sH7Xu5mEXWb4rAPBz8BBx4gFmWOxUWZ7MrD71BXfyHm2Erw/H9
         GJLw==
X-Gm-Message-State: AOJu0YxIjaj/b5OSlWHmu0eX76u6CXGP0M1AIiPztM3TeWPDTJHN4DEf
        7qPPgSEKGKVN7OzyjBPHWVgE8ceNKjD1oxmlzIDnaC9eaFcMYSMvW8MbewHblgEgXSKjhX4lQkO
        0LMkgSFYiBNYD/7Pq3KJNEw==
X-Received: by 2002:a05:6808:616:b0:3a8:83df:d5a4 with SMTP id y22-20020a056808061600b003a883dfd5a4mr1851066oih.59.1694595326802;
        Wed, 13 Sep 2023 01:55:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKPVssIlImig5nXmhpkcsDQ7KpqCHiahCisjz+0XwI28OTqJEh/HnL6zXhYAXW7+m311Y1Pw==
X-Received: by 2002:a05:6808:616:b0:3a8:83df:d5a4 with SMTP id y22-20020a056808061600b003a883dfd5a4mr1851051oih.59.1694595326594;
        Wed, 13 Sep 2023 01:55:26 -0700 (PDT)
Received: from redhat.com ([2804:1b3:a803:4ff9:7c29:fe41:6aa7:43df])
        by smtp.gmail.com with ESMTPSA id az19-20020a056830459300b006c21f11dcecsm647356otb.49.2023.09.13.01.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 01:55:26 -0700 (PDT)
Date:   Wed, 13 Sep 2023 05:55:16 -0300
From:   Leonardo Bras <leobras@redhat.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Waiman Long <longman@redhat.com>, paul.walmsley@sifive.com,
        anup@brainfault.org, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, palmer@rivosinc.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V11 04/17] locking/qspinlock: Improve xchg_tail for
 number of cpus >= 16k
Message-ID: <ZQF49GIZoFceUGYH@redhat.com>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-5-guoren@kernel.org>
 <f091ead0-99b9-b30a-a295-730ce321ac60@redhat.com>
 <CAJF2gTSbUUdLhN8PFdFzQd0M1T2MVOL1cdZn46WKq1S8MuQYHw@mail.gmail.com>
 <06714da1-d566-766f-7a13-a3c93b5953c4@redhat.com>
 <CAJF2gTQ3Q7f+FGorVTR66c6TGWsSeeKVvLF+LH1_m3kSHrm0yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTQ3Q7f+FGorVTR66c6TGWsSeeKVvLF+LH1_m3kSHrm0yA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 12, 2023 at 09:10:08AM +0800, Guo Ren wrote:
> On Mon, Sep 11, 2023 at 9:03 PM Waiman Long <longman@redhat.com> wrote:
> >
> > On 9/10/23 23:09, Guo Ren wrote:
> > > On Mon, Sep 11, 2023 at 10:35 AM Waiman Long <longman@redhat.com> wrote:
> > >>
> > >> On 9/10/23 04:28, guoren@kernel.org wrote:
> > >>> From: Guo Ren <guoren@linux.alibaba.com>
> > >>>
> > >>> The target of xchg_tail is to write the tail to the lock value, so
> > >>> adding prefetchw could help the next cmpxchg step, which may
> > >>> decrease the cmpxchg retry loops of xchg_tail. Some processors may
> > >>> utilize this feature to give a forward guarantee, e.g., RISC-V
> > >>> XuanTie processors would block the snoop channel & irq for several
> > >>> cycles when prefetch.w instruction (from Zicbop extension) retired,
> > >>> which guarantees the next cmpxchg succeeds.
> > >>>
> > >>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > >>> Signed-off-by: Guo Ren <guoren@kernel.org>
> > >>> ---
> > >>>    kernel/locking/qspinlock.c | 5 ++++-
> > >>>    1 file changed, 4 insertions(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> > >>> index d3f99060b60f..96b54e2ade86 100644
> > >>> --- a/kernel/locking/qspinlock.c
> > >>> +++ b/kernel/locking/qspinlock.c
> > >>> @@ -223,7 +223,10 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
> > >>>     */
> > >>>    static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
> > >>>    {
> > >>> -     u32 old, new, val = atomic_read(&lock->val);
> > >>> +     u32 old, new, val;
> > >>> +
> > >>> +     prefetchw(&lock->val);
> > >>> +     val = atomic_read(&lock->val);
> > >>>
> > >>>        for (;;) {
> > >>>                new = (val & _Q_LOCKED_PENDING_MASK) | tail;
> > >> That looks a bit weird. You pre-fetch and then immediately read it. How
> > >> much performance gain you get by this change alone?
> > >>
> > >> Maybe you can define an arch specific primitive that default back to
> > >> atomic_read() if not defined.
> > > Thx for the reply. This is a generic optimization point I would like
> > > to talk about with you.
> > >
> > > First, prefetchw() makes cacheline an exclusive state and serves for
> > > the next cmpxchg loop semantic, which writes the idx_tail part of
> > > arch_spin_lock. The atomic_read only makes cacheline in the shared
> > > state, which couldn't give any guarantee for the next cmpxchg loop
> > > semantic. Micro-architecture could utilize prefetchw() to provide a
> > > strong forward progress guarantee for the xchg_tail, e.g., the T-HEAD
> > > XuanTie processor would hold the exclusive cacheline state until the
> > > next cmpxchg write success.
> > >
> > > In the end, Let's go back to the principle: the xchg_tail is an atomic
> > > swap operation that contains write eventually, so giving a prefetchw()
> > > at the beginning is acceptable for all architectures..
> > > ••••••••••••
> >
> > I did realize afterward that prefetchw gets the cacheline in exclusive
> > state. I will suggest you mention that in your commit log as well as
> > adding a comment about its purpose in the code.
> Okay, I would do that in v12, thx.

I would suggest adding a snippet from the ISA Extenstion doc:

"A prefetch.w instruction indicates to hardware that the cache block whose 
effective address is the sum of the base address specified in rs1 and the  
sign-extended offset encoded in imm[11:0], where imm[4:0] equals 0b00000, 
is likely to be accessed by a data write (i.e. store) in the near future."

Other than that,
Reviewed-by: Leonardo Bras <leobras@redhat.com>


> 
> >
> > Thanks,
> > Longman
> >
> > >> Cheers,
> > >> Longman
> > >>
> > >
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 

