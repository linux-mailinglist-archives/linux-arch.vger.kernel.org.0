Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C0E21DAB6
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jul 2020 17:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbgGMPsa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jul 2020 11:48:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729649AbgGMPsa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Jul 2020 11:48:30 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F6882082F
        for <linux-arch@vger.kernel.org>; Mon, 13 Jul 2020 15:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594655309;
        bh=FiLSo9R0STPJ54NQ+j4cquzz90YqRrZ+tVdT8FICfPw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u/HSfMU9F7rxmTiqX4sRr4Pk8VxlDbewsgkjIe6pG2nB4ATgq01e1Xrr0clJ4LJmf
         KF6xr1Xv2GX82a28cw4dDUZuiL8A6ohB3EUIdPA0Gz22eJVXxmjte4lc3XkjzocFbw
         v5Jvv0F2fEGEoQbUjFwMLPV7iO/JAL2dOHC42qck=
Received: by mail-wr1-f47.google.com with SMTP id s10so17020930wrw.12
        for <linux-arch@vger.kernel.org>; Mon, 13 Jul 2020 08:48:29 -0700 (PDT)
X-Gm-Message-State: AOAM531s24R2nUxdXdUZmG5O7iQCiKo78L+VDmYOrEaNWO+XRsM8MjEb
        C+hMLICrUAd8SOKO6D+jSHP8l9xjZh+6/EcqDlmRqA==
X-Google-Smtp-Source: ABdhPJx0toL1Ye0o0H7c4Y3A41BrSlbEq0nHhnxAApxWZf2y0+ABJ/8JMUZOzKNFFHuITvPQPnyOqJdLGjq2hZLzWb4=
X-Received: by 2002:adf:a111:: with SMTP id o17mr79174967wro.257.1594655308027;
 Mon, 13 Jul 2020 08:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200710015646.2020871-1-npiggin@gmail.com> <20200710015646.2020871-5-npiggin@gmail.com>
 <CALCETrVqHDLo09HcaoeOoAVK8w+cNWkSNTLkDDU=evUhaXkyhQ@mail.gmail.com>
 <1594613902.1wzayj0p15.astroid@bobo.none> <1594647408.wmrazhwjzb.astroid@bobo.none>
 <284592761.9860.1594649601492.JavaMail.zimbra@efficios.com>
In-Reply-To: <284592761.9860.1594649601492.JavaMail.zimbra@efficios.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 13 Jul 2020 08:48:16 -0700
X-Gmail-Original-Message-ID: <CALCETrUHsYp0oGAiy3N-yAauPyx2nKqp1AiETgSJWc77GwO-Sg@mail.gmail.com>
Message-ID: <CALCETrUHsYp0oGAiy3N-yAauPyx2nKqp1AiETgSJWc77GwO-Sg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than membarrier_mm_sync_core_before_usermode
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 13, 2020 at 7:13 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Jul 13, 2020, at 9:47 AM, Nicholas Piggin npiggin@gmail.com wrote:
>
> > Excerpts from Nicholas Piggin's message of July 13, 2020 2:45 pm:
> >> Excerpts from Andy Lutomirski's message of July 11, 2020 3:04 am:
> >>> Also, as it stands, I can easily see in_irq() ceasing to promise to
> >>> serialize.  There are older kernels for which it does not promise to
> >>> serialize.  And I have plans to make it stop serializing in the
> >>> nearish future.
> >>
> >> You mean x86's return from interrupt? Sounds fun... you'll konw where to
> >> update the membarrier sync code, at least :)
> >
> > Oh, I should actually say Mathieu recently clarified a return from
> > interrupt doesn't fundamentally need to serialize in order to support
> > membarrier sync core.
>
> Clarification to your statement:
>
> Return from interrupt to kernel code does not need to be context serializing
> as long as kernel serializes before returning to user-space.
>
> However, return from interrupt to user-space needs to be context serializing.
>

Indeed, and I figured this out on the first read through because I'm
quite familiar with the x86 entry code.  But Nick somehow missed this,
and Nick is the one who wrote the patch.

Nick, I think this helps prove my point.  The code you're submitting
may well be correct, but it's unmaintainable.  At the very least, this
needs a comment explaining, from the perspective of x86, *exactly*
what exit_lazy_tlb() is promising, why it's promising it, how it
achieves that promise, and what code cares about it.  Or we could do
something with TIF flags and make this all less magical, although that
will probably end up very slightly slower.

--Andy
