Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016F7247F47
	for <lists+linux-arch@lfdr.de>; Tue, 18 Aug 2020 09:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgHRHWm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Aug 2020 03:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgHRHWk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Aug 2020 03:22:40 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA7AC061389;
        Tue, 18 Aug 2020 00:22:40 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t11so8810246plr.5;
        Tue, 18 Aug 2020 00:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=ngrPbPBRbUsq6w+flBSZQV2nOcmo/y3wzfu+I9RjOwM=;
        b=TSPQYiEu1Z3JAOqWBoqY0hkMurM6qzutlorBVGTCiYHNvCTc6oGO2lvpnf9ygeWYuk
         /hGBax/Aor+9svcSrfngM0CKK3dbpDJc8onXTK9HHtR8G1nWkVBzOz/GzwYyI2Yydf0y
         28NXnmPerG5D0pXpjDvuYp+cFFSYBQujB7GhYS9wU9QhpDn82QALLxrH4lMdBz4XlGEL
         ZyWsXpMC/yMp1GmvYiGoqK5+pBRrbFENkDXjDALUFLx+piH1/xZ2McUr3DB0MXJB/zJR
         Ev8G5+7QjObdSdOFB4uNtu0xANrJPcsSOfvdEN/I3bu5ZF5+xyaxjBcJno801fSmWgRr
         yxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=ngrPbPBRbUsq6w+flBSZQV2nOcmo/y3wzfu+I9RjOwM=;
        b=kH4sSiZkvG3lgpfpA6m6pQZqax9CAYWEC4kXATYHvu2P8PsNCe2P5i1qGTcBvN/gGK
         u9cac4MVGpaMTb+jOpxgOJkYORPXYU3jgGpySiuYwMEGqQ/XuCqn7LObN8WYQmYwXt4D
         G4M23xlSuN/MfrOugPotPHLHFOfgfQ9aOVmf1iaE4Q9EWbJgl3BIE9IXYaPt3akKob8i
         rwyrNRzp0hxoel1UeGeYA8TgSliKngCBEnETO5J8meGWpnIqRNuJ3mE7pD4EcurYxsBZ
         eUvcVVX3XQBRsqFMbPflw6SNHqAHpxd3Y6iBeFoqthCn5r52ZDSqFAtVoHDCqTsxP/PF
         S52w==
X-Gm-Message-State: AOAM532xwEUMjEFrE2mkSTLl6JPsJSJzI5D13ftUWCRTaGfBZX+mzWJo
        nGRX7ugDHnyA4TAV7/NceOE=
X-Google-Smtp-Source: ABdhPJwWicVHjLC3nLnAfAzUswzycukvUhFKVQxdfOgfh/aUNHN6aaAIYbgqXGGLh0wn8G5+FzQeQw==
X-Received: by 2002:a17:90a:e990:: with SMTP id v16mr16323320pjy.194.1597735359589;
        Tue, 18 Aug 2020 00:22:39 -0700 (PDT)
Received: from localhost (193-116-193-175.tpgi.com.au. [193.116.193.175])
        by smtp.gmail.com with ESMTPSA id z26sm21152854pgc.44.2020.08.18.00.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 00:22:39 -0700 (PDT)
Date:   Tue, 18 Aug 2020 17:22:33 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled
 synchronisation with actual irq state
To:     peterz@infradead.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
References: <20200723105615.1268126-1-npiggin@gmail.com>
        <20200807111126.GI2674@hirez.programming.kicks-ass.net>
        <1597220073.mbvcty6ghk.astroid@bobo.none>
        <20200812103530.GL2674@hirez.programming.kicks-ass.net>
In-Reply-To: <20200812103530.GL2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1597735273.s0usqkrlsk.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from peterz@infradead.org's message of August 12, 2020 8:35 pm:
> On Wed, Aug 12, 2020 at 06:18:28PM +1000, Nicholas Piggin wrote:
>> Excerpts from peterz@infradead.org's message of August 7, 2020 9:11 pm:
>> >=20
>> > What's wrong with something like this?
>> >=20
>> > AFAICT there's no reason to actually try and add IRQ tracing here, it'=
s
>> > just a hand full of instructions at the most.
>>=20
>> Because we may want to use that in other places as well, so it would
>> be nice to have tracing.
>>=20
>> Hmm... also, I thought NMI context was free to call local_irq_save/resto=
re
>> anyway so the bug would still be there in those cases?
>=20
> NMI code has in_nmi() true, in which case the IRQ tracing is disabled
> (except for x86 which has CONFIG_TRACE_IRQFLAGS_NMI).
>=20

That doesn't help. It doesn't fix the lockdep irq state going out of
synch with the actual irq state. The code which triggered this with the
special powerpc irq disable has in_nmi() true as well.

Thanks,
Nick
