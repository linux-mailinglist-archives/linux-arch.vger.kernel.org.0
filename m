Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F84924C4BF
	for <lists+linux-arch@lfdr.de>; Thu, 20 Aug 2020 19:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgHTRmb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Aug 2020 13:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgHTRmU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Aug 2020 13:42:20 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5A0C061385
        for <linux-arch@vger.kernel.org>; Thu, 20 Aug 2020 10:42:19 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id e20so825159uav.3
        for <linux-arch@vger.kernel.org>; Thu, 20 Aug 2020 10:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AgLB407bKm54/IrZ6UCuTIQNo2tX1E4LKdmKF7McOxA=;
        b=R84jP9dgvDeMoE2uEu+DF3AzBT5JNaKMCWQ4uCwEUKPxuNmwM7AXtxgRmH9vE+TQeE
         Oah0ew6Va5dDXIcJ0Sjl3icIyEVfYvHNPq8+dsWbA5eS34smi/yPvhdLGCumnolaqKui
         1iy5tM5Uhau+Nia85uAx+l7BXvdZETkn6m3ZEH1nuhX3Tj0SqLsa/xSeSX0gHVdhqOiH
         KRH4n7yk+2B6HP3lvzpEoCHT43c6QW0Diq65ONkUD+NF8moo5oSe4bnh39RVq09Zxt3o
         gie0sMhFlgaUUUx4EWO/KhD2g5nwgrshfLBAmIYzxWT1sn90RWDl4ymlzJ9sUDtv3cT4
         iLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AgLB407bKm54/IrZ6UCuTIQNo2tX1E4LKdmKF7McOxA=;
        b=gnywCisTQqqbby9a4qCZlLWmmJxC0HMqbHtCu8Ca5ykUGNg3JIGFCNF8H1nRHvv2M8
         srqXZYzq0T54q3ArMwjH1WhRuUvi6enNH3uUtlGzpIwjpUcccVAHxizeP8BGZmsmPN08
         KeWLE7JqW4ZTPJ15kMRA8KFd07VFTUQbo3Ix+/HtbLpZ3oyPppVky22Zdiyny1egu/3q
         47E0RglRrne+SF89wcXIIPf9gweuilPP8g9OXU97mEUoG4Z1pIIDJ34uuph8LwgSZITG
         8jpkPycFhp8DPnYwVsRHLWd1CAOX2U0++pz/FXtkcBBuKE4Gr4y0yBhoOI64CO6ZJu8v
         5/6Q==
X-Gm-Message-State: AOAM530mmNrmgIBwsbNlAuRtEG8IcWQKjlPVCQO3CIn9x+i/ELO4o1zh
        vFfO3P9BfOGDIjU5u1yQlRrSioaHkifrrdoDyCXWyg==
X-Google-Smtp-Source: ABdhPJzordxKYzj0nMYhDbICoBQiPfB/Pg2v8UB5v7axF5xFZh2v9ZTA7zbfzsT9wsEFZZcAPTL0/FOaQB/ZTm+f+Bg=
X-Received: by 2002:ab0:7183:: with SMTP id l3mr2519103uao.139.1597945336910;
 Thu, 20 Aug 2020 10:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200811000959.2486636-1-posk@google.com> <20200811062733.GP3982@worktop.programming.kicks-ass.net>
 <CAFTs51XK0HLwCCvXCcfE5P7a4ExANPNPw7UvNigwHZ8sZVP+nQ@mail.gmail.com>
 <1003774683.6088.1597257002027.JavaMail.zimbra@efficios.com>
 <CAFTs51XJhKXn7M2U2dZpFRsTrog4juy=UQfbtcdJfOj5TUSbqQ@mail.gmail.com> <1477195446.6156.1597261492255.JavaMail.zimbra@efficios.com>
In-Reply-To: <1477195446.6156.1597261492255.JavaMail.zimbra@efficios.com>
From:   Peter Oskolkov <posk@posk.io>
Date:   Thu, 20 Aug 2020 10:42:05 -0700
Message-ID: <CAFTs51Uwf7+Vs+Mbf=LZxoytFA+3WEtRB5zUanatxgk272MP7Q@mail.gmail.com>
Subject: Re: [PATCH 1/2 v3] rseq/membarrier: add MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Peter Oskolkov <posk@google.com>, paulmck <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 12, 2020 at 12:44 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
[...]
>
> > One way of doing what you suggest is to allow some commands to be bitwise-ORed.
> >
> > So, for example, the user could call
> >
> > membarrier(CMD_PRIVATE_EXPEDITED_SYNC_CORE | CMD_PRIVATE_EXPEDITED_RSEQ, cpu_id)
> >
> > Is this what you have in mind?
>
> Not really. This would not take care of the fact that we would end up multiplying
> the number of commands as we allow combinations. E.g. if we ever want to have RSEQ
> work in private and global, and in non-expedited and expedited, we end up needing:
>
> - CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ
> - CMD_PRIVATE_EXPEDITED_RSEQ
> - CMD_PRIVATE_RSEQ
> - CMD_REGISTER_GLOBAL_EXPEDITED_RSEQ
> - CMD_GLOBAL_EXPEDITED_RSEQ
> - CMD_GLOBAL_RSEQ
>
> The only thing we would save by OR'ing it with the SYNC_CORE command is the additional
> list:
>
> - CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ_SYNC_CORE
> - CMD_PRIVATE_EXPEDITED_RSEQ_SYNC_CORE
> - CMD_PRIVATE_RSEQ_SYNC_CORE
> - CMD_REGISTER_GLOBAL_EXPEDITED_RSEQ_SYNC_CORE
> - CMD_GLOBAL_EXPEDITED_RSEQ_SYNC_CORE
> - CMD_GLOBAL_RSEQ_SYNC_CORE
>
> But unless we receive feedback that doing a membarrier with RSEQ+sync_core all in
> one go is a significant use-case, I am tempted to leave out that scenario for now.
> If we go for new commands, this means we could add (for private-expedited-rseq):
>
> - MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ,
> - MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ,
>
> I do however have use-cases for using RSEQ across shared memory (between
> processes). Not currently for a rseq-fence, but for rseq acting as per-cpu
> atomic operations. If I ever end up needing rseq-fence across shared memory,
> that would result in the following new commands:
>
> - MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED_RSEQ,
> - MEMBARRIER_CMD_GLOBAL_EXPEDITED_RSEQ,
>
> The remaining open question is whether it would be OK to define a new
> membarrier flag=MEMBARRIER_FLAG_CPU, which would expect an additional
> @cpu parameter.

Hi  Mathieu,

I do not think there is any reason to wait for additional feedback, so I believe
we should finalize the API/ABI.

I see two issues to resolve:
1: how to combine commands:
  - you do not like adding new commands that are combinations of existing ones;
  - you do not like ORing.
=> I'm not sure what other options we have here?

2: should @flags be repurposed for cpu_id, or MEMBARRIER_FLAG_CPU
   added with a new syscall parameter.
=> I'm still not sure a new parameter can be cleanly added, but I can try
   it in the next patchset if you prefer it this way.

Please let me know your thoughts.

Thanks,
Peter
