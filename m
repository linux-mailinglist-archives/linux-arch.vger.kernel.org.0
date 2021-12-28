Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919D2480770
	for <lists+linux-arch@lfdr.de>; Tue, 28 Dec 2021 09:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbhL1Iev (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Dec 2021 03:34:51 -0500
Received: from mengyan1223.wang ([89.208.246.23]:39554 "EHLO mengyan1223.wang"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231670AbhL1Iev (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Dec 2021 03:34:51 -0500
Received: from [IPv6:240e:358:1148:6f00:dc73:854d:832e:4] (unknown [IPv6:240e:358:1148:6f00:dc73:854d:832e:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@mengyan1223.wang)
        by mengyan1223.wang (Postfix) with ESMTPSA id AB33766215;
        Tue, 28 Dec 2021 03:34:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mengyan1223.wang;
        s=mail; t=1640680490;
        bh=E5j+9tgFVq0+iQWcyDX7IvHFLuER19sgJwHZHiTOdJg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=swfzuJLgiG9rKodcOUC7hK1Q9iGiLZByj83y7Dhnb+0+DfJExwXnD/wj4QfHuhdo7
         ZsRum9/Q2KJQQzu7AJDbOOPIkp8r2gTZxoOAl7f5e8plvK7Cn4JskrjMOdpJtKbnLj
         g5LqzaKlQQSMjbX4xtn8iR8S4Wnmd2wAIEd2HpNxCMa6PQNLYLMIsAapFYZFZ2KHE5
         gixFHUCr+M5UaD/mmiyEj0ySHw7y4OGS2IMMM6SSGyt7quW1fF2EWbvpbw7J9vGSqp
         jzLuY2LN1LS1Rb4Hy4xZV1DBO2yUH6iQ6D0exmU5/Av1G4Cdo5bjaN2TgT1/JVaGqk
         Hf12T/vgAjttg==
Message-ID: <587ab54d77af2fb4cdbe0530cdd5e550c3e968db.camel@mengyan1223.wang>
Subject: Re: [PATCH V5 00/22] arch: Add basic LoongArch support
From:   Xi Ruoyao <xry111@mengyan1223.wang>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Tue, 28 Dec 2021 16:34:33 +0800
In-Reply-To: <CAAhV-H40oWqkD+tQ3=XA8ijQGukkeG5O1M1JL3v5i402dFLK+Q@mail.gmail.com>
References: <20211013063656.3084555-1-chenhuacai@loongson.cn>
         <722477bcc461238f96c3b038b2e3379ee49efdac.camel@mengyan1223.wang>
         <CAAhV-H40oWqkD+tQ3=XA8ijQGukkeG5O1M1JL3v5i402dFLK+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2021-12-21 at 15:53 +0800, Huacai Chen wrote:

> On Mon, Dec 20, 2021 at 5:04 PM Xi Ruoyao <xry111@mengyan1223.wang>
> wrote:
> > 
> > The snapshot panics on my system under high pressure (building and
> > testing GCC).  The panic message is pasted, but it's kind of broken up
> > likely because multiple CPU cores were outputing to the serial console
> > simutaniously.
> > 
> > The config is attached.  I'm not sure the reason of the panic (bug in
> > the patches or bug in mainline kernel?) Do you have some pointers to
> > diagnostic and fix the issue?
> > 
> > [ 5391.004745] CPU 1 Unable to handle kernel paging request at virtual address 000000000040007e, era == 90000000003aa07c, ra == 90000000003aa84c

/* snip */

> We also found that the latest github kernel has some stable issues,
> and we are investigating.

I rebased the patches onto 438645193e59e91761ccb3fa55f6ce70b615ff93 and
the problem *seems* gone.  Not sure if it's something fixed in the
mainline or some more strange thing.
-- 
Xi Ruoyao <xry111@mengyan1223.wang>
School of Aerospace Science and Technology, Xidian University
