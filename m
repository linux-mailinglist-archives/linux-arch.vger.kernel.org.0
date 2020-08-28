Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739D02554B3
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 08:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgH1Gz2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 02:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgH1Gz1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2020 02:55:27 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAEAC061264;
        Thu, 27 Aug 2020 23:55:27 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mt12so94850pjb.4;
        Thu, 27 Aug 2020 23:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=+JUN11wzB4//nQqIzalGuMruUm78CprFXuE4iMliK+A=;
        b=QHEhcA+L2xDZeLWaOimRKxMvcWKUV7APQj13AGQse1tQz3oysNoNSOkHG+jpm5RNx4
         vyTGU8HxgauBixzldRhKqsl5qWqOGKgC0R1gwOlnpwyfzOyEfFP9SturS3sMgSHA//Uo
         eCHXavTvDGOEEVPGzGvzbPbFD/VZ2h7ZWfLB9vKwS9G+DPJnwV7TWhrxEfTp886e3cEW
         TjzveX8PL40tHXSj4eH12gqa33hWfhdy1pQjWzFwJBDXUZBgP60ahgKxXx47e4bhK5rs
         x51wCeaCAT3xZAD9TIGpmQ6F4YY2QGbnonTNSzbwSjVsDsn/TgUC0U2fNoGnuyrAIE61
         2uGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=+JUN11wzB4//nQqIzalGuMruUm78CprFXuE4iMliK+A=;
        b=c1DVz4qbpU0NT4pVodzMRdWaDOJIABoOxyNQjNhD3iz2eq+AQ4u6dkifgdmhimVCyP
         PztwE5F6Rtvn4H6ZCw7Ic5+DoC37iFEoaXMm6lv27djcyykBW61/hYCjc+e296/MjukA
         7VIpTnVgXubfcRtPW6/wROQYPH9sKhBfUfPUVLLEE8mZ6uCmEqMGpIY4AipXZiClgapF
         TEorZLyHzeDEHCF6NUSUYY2WfH6mfId15avNEW/bqaadqRFFJ7obHhaJ7x83PACq+6S1
         luoQTNX52C3Xw4poRyb7WWx/91t4STZPKIFDeXsdrSnNEaDK1pRZge9YHI+0atZyEmrf
         uimw==
X-Gm-Message-State: AOAM531v4PU5mivw/cVEc4mXPn9i84fV81NPxBvQjhunnXH4+++/o7mJ
        tmKpd5Ni5VitZGbobFTL6PnRGkIdXjM=
X-Google-Smtp-Source: ABdhPJzY1y30hYoc7MXm9GmsWDJ0rbKwyOd+c7kG3lLflh5q+WfA5awxRQg1RVn9pL5erj3EeWb06A==
X-Received: by 2002:a17:902:b497:: with SMTP id y23mr191262plr.251.1598597727069;
        Thu, 27 Aug 2020 23:55:27 -0700 (PDT)
Received: from localhost (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id j10sm306996pff.171.2020.08.27.23.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 23:55:26 -0700 (PDT)
Date:   Fri, 28 Aug 2020 16:55:21 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3] mm: Fix kthread_use_mm() vs TLB invalidate
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-arch@vger.kernel.org, peterz@infradead.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, axboe@kernel.dk,
        hch@lst.de, jannh@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@amacapital.net,
        mathieu.desnoyers@efficios.com, torvalds@linux-foundation.org,
        will@kernel.org
References: <20200721154106.GE10769@hirez.programming.kicks-ass.net>
        <87y2m8muag.fsf@linux.ibm.com>
        <20200821130445.GP1362448@hirez.programming.kicks-ass.net>
        <1598583976.kyraed50wg.astroid@bobo.none>
In-Reply-To: <1598583976.kyraed50wg.astroid@bobo.none>
MIME-Version: 1.0
Message-Id: <1598597607.h04xhbtpuo.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Nicholas Piggin's message of August 28, 2020 1:26 pm:
> Excerpts from peterz@infradead.org's message of August 21, 2020 11:04 pm:
>> On Fri, Aug 21, 2020 at 11:09:51AM +0530, Aneesh Kumar K.V wrote:
>>> Peter Zijlstra <peterz@infradead.org> writes:
>>>=20
>>> > For SMP systems using IPI based TLB invalidation, looking at
>>> > current->active_mm is entirely reasonable. This then presents the
>>> > following race condition:
>>> >
>>> >
>>> >   CPU0			CPU1
>>> >
>>> >   flush_tlb_mm(mm)	use_mm(mm)
>>> >     <send-IPI>
>>> > 			  tsk->active_mm =3D mm;
>>> > 			  <IPI>
>>> > 			    if (tsk->active_mm =3D=3D mm)
>>> > 			      // flush TLBs
>>> > 			  </IPI>
>>> > 			  switch_mm(old_mm,mm,tsk);
>>> >
>>> >
>>> > Where it is possible the IPI flushed the TLBs for @old_mm, not @mm,
>>> > because the IPI lands before we actually switched.
>>> >
>>> > Avoid this by disabling IRQs across changing ->active_mm and
>>> > switch_mm().
>>> >
>>> > [ There are all sorts of reasons this might be harmless for various
>>> > architecture specific reasons, but best not leave the door open at
>>> > all. ]
>>>=20
>>>=20
>>> Do we have similar race with exec_mmap()? I am looking at exec_mmap()
>>> runnning parallel to do_exit_flush_lazy_tlb(). We can get
>>>=20
>>> 	if (current->active_mm =3D=3D mm) {
>>>=20
>>> true and if we don't disable irq around updating tsk->mm/active_mm we
>>> can end up doing mmdrop on wrong mm?
>>=20
>> exec_mmap() is called after de_thread(), there should not be any mm
>> specific invalidations around I think.
>>=20
>> Then again, CLONE_VM without CLONE_THREAD might still be possible, so
>> yeah, we probably want IRQs disabled there too, just for consistency and
>> general paranoia if nothing else.
>=20
> The problem is probably not this TLB flushing race, but I think there
> is a lazy tlb race.

Hmm, is it possible for something to be holding the mm_users when we
exec? That could actually make it a problem for TLB flushing too.

Thanks,
Nick
