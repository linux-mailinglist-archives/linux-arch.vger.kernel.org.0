Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB5E251E32
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 19:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgHYRWv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Aug 2020 13:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgHYRWu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Aug 2020 13:22:50 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C44BC061755
        for <linux-arch@vger.kernel.org>; Tue, 25 Aug 2020 10:22:50 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id u46so439492uau.6
        for <linux-arch@vger.kernel.org>; Tue, 25 Aug 2020 10:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZPVupr/Wvq2mhnNe5SUHsqJQ4OJryLMec7QaaJzQxaM=;
        b=BYP9/rdZW/mitTabIHVr6wUdbVQHhGkEVPTrNAuzT7/taPRjL4TXJODa5TQflgTki8
         iLX++f3TUXFz5kB2fDhkZBHIgOMMR0g0l2h20TzrkH5TvrZ3PpCKnmLEvOwzTBVlHJFq
         LEfaPf4UqMDfhSxmEVS8WSZeEPxIiuRegso6QO83LeD/kL+1CSGrnz5nU79pc7Fiv0IA
         hs0QYKGPq72Kni1CwSREQR3R0o/jNeS6wtwMAIzUdyn+qBppNJgAzHLQlR48ImwdRvp0
         Bbm4zXT9LPYrEqlP7vZoT2s7uzfDupindd8hHP0ENFw3pjtuwSn2l/9GbB8jz6xk0I5q
         6igQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZPVupr/Wvq2mhnNe5SUHsqJQ4OJryLMec7QaaJzQxaM=;
        b=jXdWznaP4x681qpZdqdf8wAOKZNdseRJzF080ybdx2fsd4sIcJcdm9m3mQOaqMDmM4
         LBKd9qlnDURaLq2gFXTmt22WsNelglp7WHwc7whdHzqn9XHuC0bJjUv9bBvmyy2Lp4C3
         npswKlPmfN1LpS9XolRNerXa5tVVZRE4pJ8Ln3BrS9WDrnXYiCdkulH0U8X49O1mYGWT
         64a3E750O0lLd6wkKBw4NWYE9ka1HV7IXUFO0P458gGJAVq15F0nr9x/tNJ7e82fgDhZ
         uTr88+A2jWk/xhBnM5PtFtPV69hBuU/wuM530zmF2EghfmZdOSmNZLRD5Y1oHhSI/pdX
         GuJw==
X-Gm-Message-State: AOAM531hft+Ufl/0BNSmCAFp9zqjd0Y1QSNg1pmMoZlIdsekH2ZQtNLb
        z48ffasc9/Z8I7KPwhZ4FMJDt/pY5Pv9AAQ5uiBxuw==
X-Google-Smtp-Source: ABdhPJxtmetWOeGmTO50W1HXfFZgZxeU1NG4D7KI9zjK0xouwyn0+OE+mlUJra7o1QB8bBoHZpYa9ZM6zaA7rIXHF7M=
X-Received: by 2002:ab0:21cf:: with SMTP id u15mr5157043uan.85.1598376169409;
 Tue, 25 Aug 2020 10:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200811000959.2486636-1-posk@google.com> <20200811062733.GP3982@worktop.programming.kicks-ass.net>
 <CAFTs51XK0HLwCCvXCcfE5P7a4ExANPNPw7UvNigwHZ8sZVP+nQ@mail.gmail.com>
 <1003774683.6088.1597257002027.JavaMail.zimbra@efficios.com>
 <CAFTs51XJhKXn7M2U2dZpFRsTrog4juy=UQfbtcdJfOj5TUSbqQ@mail.gmail.com>
 <1477195446.6156.1597261492255.JavaMail.zimbra@efficios.com>
 <CAFTs51Uwf7+Vs+Mbf=LZxoytFA+3WEtRB5zUanatxgk272MP7Q@mail.gmail.com> <1336467655.17779.1598374701401.JavaMail.zimbra@efficios.com>
In-Reply-To: <1336467655.17779.1598374701401.JavaMail.zimbra@efficios.com>
From:   Peter Oskolkov <posk@posk.io>
Date:   Tue, 25 Aug 2020 10:22:38 -0700
Message-ID: <CAFTs51WfWCGPDXy7YVNmfE8zjk98L8+V4erWUTofeYOJBJN-WQ@mail.gmail.com>
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

On Tue, Aug 25, 2020 at 9:58 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
[...]
>
> Concretely speaking, let's just add a new membarrier command for the use-case
> at hand. All other ways of doing things we have discussed are tricky to expose
> in a way that is discoverable by user-space through the QUERY command. (using
> a flag, or OR'ing many commands together)
>
> >
> > 2: should @flags be repurposed for cpu_id, or MEMBARRIER_FLAG_CPU
> >   added with a new syscall parameter.
> > => I'm still not sure a new parameter can be cleanly added, but I can try
> >   it in the next patchset if you prefer it this way.
>
> Yes please, it's easy to implement and we'll quickly see if anyone yells. If
> it turns out to be a bad idea, you can always blame me. ;-)
>
> In summary:
>
> - We add 2 new membarrier commands:
>   - MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ
>   - MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
>
> - We reserve a membarrier flag:
>
> enum membarrier_flag {
>   MEMBARRIER_FLAG_CPU = (1 << 0),
> }
>
> So for CMD_PRIVATE_EXPEDITED_RSEQ, if flags & MEMBARRIER_FLAG_CPU is true,
> then we expect the additional "int cpu" parameter (3rd parameter). Else the cpu
> parameter is unused.
>
> Are you OK with this approach ?

Yes, thanks for looking into this. I'll send a v4 later this week.

Thanks,
Peter

[...]
