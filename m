Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38EB14FEBB
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jun 2019 03:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfFXBwp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 23 Jun 2019 21:52:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbfFXBw0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 23 Jun 2019 21:52:26 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7A7422CE9
        for <linux-arch@vger.kernel.org>; Mon, 24 Jun 2019 01:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561338947;
        bh=oPpq+YScZrWevywmu9N3ag0Ky3wXqEPlzcFQAwc4wac=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZObr9Sve1fr7WfDRdAZ7O7pKw2lzSEd1p3K7pVFn8jwfqek+njnBSfU1sbxow578F
         F3L2CcAeHPt3k4hmVjYWNM5uRXjlXxrtSgeEisWCC9Uq4HZjuqASVM4UZsrVcxDLnl
         t5ja0wCLA+XZotal4ksNMp9wwleOlxtVrJ5K1QKc=
Received: by mail-wm1-f41.google.com with SMTP id a15so11119335wmj.5
        for <linux-arch@vger.kernel.org>; Sun, 23 Jun 2019 18:15:46 -0700 (PDT)
X-Gm-Message-State: APjAAAVHDcXeAFD7l4lXEEGYgD/6YIcnnvzvknpk3KzrYgB11YhzDXzC
        9+Q9NF3juLFtVUvo0g8Kcm+ACYd6rZQrAId00pv9ZQ==
X-Google-Smtp-Source: APXvYqxXfZO9JbIsNZmRpKd7ahekmHh/DeHYGI38xrq+mQInt0q9I7titye+BRFoBLBaUaVpBy9Q+nBinA9a1jW5Vj4=
X-Received: by 2002:a7b:c450:: with SMTP id l16mr13710054wmi.0.1561338945460;
 Sun, 23 Jun 2019 18:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190621095252.32307-1-vincenzo.frascino@arm.com> <alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 23 Jun 2019 18:15:32 -0700
X-Gmail-Original-Message-ID: <CALCETrV-suRS5=JqDjbouXciN_OPsguERjux7fQVFOKGmdrspA@mail.gmail.com>
Message-ID: <CALCETrV-suRS5=JqDjbouXciN_OPsguERjux7fQVFOKGmdrspA@mail.gmail.com>
Subject: Re: [PATCH v7 00/25] Unify vDSOs across more architectures
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrei Vagin <avagin@openvz.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 23, 2019 at 5:34 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> +GENERIC VDSO LIBRARY:
> +M:     Andy Lutomirksy <luto@kernel.org>

Lutomirski, perhaps?  Although I do appreciate the opportunity to say
"not me!" :)
