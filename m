Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673572CFDC9
	for <lists+linux-arch@lfdr.de>; Sat,  5 Dec 2020 19:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgLESoS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Dec 2020 13:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgLEQtq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Dec 2020 11:49:46 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA3BC02B8F9
        for <linux-arch@vger.kernel.org>; Sat,  5 Dec 2020 08:11:57 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id m5so4932605pjv.5
        for <linux-arch@vger.kernel.org>; Sat, 05 Dec 2020 08:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Mz/7Yi61thJ88HE692aK3MZiSQS4EROkVabvy/8vXTw=;
        b=DhL2umoxMynanfmyKr00u4At2reQZYap7bLysS7iO2w5j378kBnpkqTo925b1AMXV9
         GfnmqNtET9W86zssaaOutcBbaatQqvIuT0cFpK/81Z7C+e8JNbfIu0fT5XUcH3GNcfdc
         TB+RF64MfXALrRuW3BwDZoBwlIBtNKpXrKm5Y0/qTBIU331wiDfW9P9m9Ss4s+Q3hmKj
         IbLQSoUJ7xJOh7w9Sws/9AcCKZ+1eQgOt1ThRR6L9HNeFOZO+EVk2vhjr0XajH5/mYrN
         BMTdOzYSYOvXdJvjmZaBKKSwrzDg8IwR22EhWuj7sLHF1rrlBKjTfwBTm4b8Mzs0E+Hn
         xxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Mz/7Yi61thJ88HE692aK3MZiSQS4EROkVabvy/8vXTw=;
        b=ja2fFkZuLNy3oh/QjpOO824vX/eiWrS+3W9bK3Mnau/T4pkD802Bt51VKrZ4Ltbmr2
         j1Et2Wg+Yj1Ssk+BszGzs5zZwUFbjt3O0Wykr7HtQM+JhfJ6T6ZiLebkG4jRUhoCA+56
         D2OYLcRR6yzGq8h4eHp7lou1uZJ25graxKZDddzdyLuTMjMyT0p980ymDM84ovh4+iVw
         OU2rXgTzoMkRnqjQB3miVRT+sN+5UXKkbuOfJnwgiKyUtqp0gH1+PiSstKLiiYhlQhbS
         gXe5j6wHEJajhJEqiQzDb/XmIEaHlLslq6A7Ktx/w4d1lJusDosqv5IJw9yCWCiWOCNS
         mD9g==
X-Gm-Message-State: AOAM533dVcOJY/4ZLFvVLmmdzKJxMU6CRpG1VYHu+Yj0a7igFHpvIrYc
        0gWUT3a7TIiSeHoMu16F+yKTDw==
X-Google-Smtp-Source: ABdhPJwZpG0woeNrtDGe9OhzFE0RR6dieb9MhtJVWcHQn4MXBKdlSYP/d9e6WoDZV96QQKI0PbKqlA==
X-Received: by 2002:a17:902:bd4c:b029:d8:fd6a:6ca2 with SMTP id b12-20020a170902bd4cb02900d8fd6a6ca2mr8830175plx.53.1607184717112;
        Sat, 05 Dec 2020 08:11:57 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:c541:6c6c:97fe:790? ([2601:646:c200:1ef2:c541:6c6c:97fe:790])
        by smtp.gmail.com with ESMTPSA id mr7sm5466394pjb.31.2020.12.05.08.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Dec 2020 08:11:56 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/8] x86: use exit_lazy_tlb rather than membarrier_mm_sync_core_before_usermode
Date:   Sat, 5 Dec 2020 08:11:54 -0800
Message-Id: <116A6B40-C77B-4B6A-897B-18342CD62CEC@amacapital.net>
References: <1607152918.fkgmomgfw9.astroid@bobo.none>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>
In-Reply-To: <1607152918.fkgmomgfw9.astroid@bobo.none>
To:     Nicholas Piggin <npiggin@gmail.com>
X-Mailer: iPhone Mail (18B121)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> On Dec 5, 2020, at 12:00 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
>=20
>=20
> I disagree. Until now nobody following it noticed that the mm gets
> un-lazied in other cases, because that was not too clear from the
> code (only indirectly using non-standard terminology in the arch
> support document).

> In other words, membarrier needs a special sync to deal with the case=20
> when a kthread takes the mm.

I don=E2=80=99t think this is actually true. Somehow the x86 oddities about C=
R3 writes leaked too much into the membarrier core code and comments. (I dou=
bt this is x86 specific.  The actual x86 specific part seems to be that we c=
an return to user mode without syncing the instruction stream.)

As far as I can tell, membarrier doesn=E2=80=99t care at all about laziness.=
 Membarrier cares about rq->curr->mm.  The fact that a cpu can switch its ac=
tual loaded mm without scheduling at all (on x86 at least) is entirely besid=
e the point except insofar as it has an effect on whether a subsequent switc=
h_mm() call serializes.  If we notify membarrier about x86=E2=80=99s asynchr=
onous CR3 writes, then membarrier needs to understand what to do with them, w=
hich results in an unmaintainable mess in membarrier *and* in the x86 code.

I=E2=80=99m currently trying to document how membarrier actually works, and h=
opefully this will result in untangling membarrier from mmdrop() and such.

A silly part of this is that x86 already has a high quality implementation o=
f most of membarrier(): flush_tlb_mm().  If you flush an mm=E2=80=99s TLB, w=
e carefully propagate the flush to all threads, with attention to memory ord=
ering.  We can=E2=80=99t use this directly as an arch-specific implementatio=
n of membarrier because it has the annoying side affect of flushing the TLB a=
nd because upcoming hardware might be able to flush without guaranteeing a c=
ore sync.  (Upcoming means Zen 3, but the Zen 3 implementation is sadly not u=
sable by Linux.)
