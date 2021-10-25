Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6884743A873
	for <lists+linux-arch@lfdr.de>; Tue, 26 Oct 2021 01:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhJYXsn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Oct 2021 19:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbhJYXsm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Oct 2021 19:48:42 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBE7C061745
        for <linux-arch@vger.kernel.org>; Mon, 25 Oct 2021 16:46:19 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bi35so8447017lfb.9
        for <linux-arch@vger.kernel.org>; Mon, 25 Oct 2021 16:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VPDfwDoASh6gAt3dTueRf0PEqHtCNlU8x3H2SBa8PO4=;
        b=VfI8DkON3Tp1Fy/ofZHy+9jJbXoEWslhCEpoyPUBV0DwrRu9leXOH8yO3qbMa8LdhO
         eiUBtfuN+svqTIJpFzlFvTHE08JfxYnG5ajgah9TKaME07JJqGYzwD5d+WrXn3J/9Qbk
         aJK7XBlwJWrID+d8Uo2ITEIDrOP5ddtY/6OVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VPDfwDoASh6gAt3dTueRf0PEqHtCNlU8x3H2SBa8PO4=;
        b=NJEozdVI39FlC8L5jOsZ8reksP1ihh3izyUVtDg1zVcd25M8zx7e+TT9a9prN5ivDF
         Fu5SMcXb8AfbbJzTHKd9+dKvWL91b5Y7eS6gdJe15JX2g29cfVCNFaMQxLZCFyyuOw/K
         D0GW8DpadbVOdNn67I6Jy41Cffwl4HCfnsjgix44N92hO4cXXcqw65EJHOoG34flpMUJ
         wSRqWaOJA4RsXeCjPp43IMEYiwPic0+/isKYl6kEJ0WWo/Tm+EQVbAMEVGx93FZqUmvV
         6WGrlTeUbfl0rDzoG4SIRozbwWBTlHJZZLbwMizVEhJj2pfXaQE6ztgdGvGvkz/L5sUr
         GuNA==
X-Gm-Message-State: AOAM531YXXOlqrvp64USjqMbNoxr8PlqVfnrPySqt5JWVRPnkZ+RLzkN
        TxA2FoJGX/v5tQTJYheUu0pG4RYqvF0SPw==
X-Google-Smtp-Source: ABdhPJwjvfSxuvJG/0LPJ9aWtfUG005KcXmNgQulRwguU8EbRHEv/vz9OY6/2mwDl8VsNoOyFv62kA==
X-Received: by 2002:a05:6512:36d3:: with SMTP id e19mr19893395lfs.94.1635205577111;
        Mon, 25 Oct 2021 16:46:17 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id o2sm16553lfq.41.2021.10.25.16.46.15
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 16:46:15 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id l13so16805460lfg.6
        for <linux-arch@vger.kernel.org>; Mon, 25 Oct 2021 16:46:15 -0700 (PDT)
X-Received: by 2002:a05:6512:10d0:: with SMTP id k16mr20142390lfg.150.1635205574900;
 Mon, 25 Oct 2021 16:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <87y26nmwkb.fsf@disp2133> <20211020174406.17889-10-ebiederm@xmission.com>
 <875ytkygfj.fsf_-_@disp2133> <4b203254-a333-77b1-0fa9-75c11fabac36@kernel.org>
In-Reply-To: <4b203254-a333-77b1-0fa9-75c11fabac36@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Oct 2021 16:45:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wioHUhqXU3_PR82VbfS8G=+zH+z8igeG-QAuCaWm5Cgqg@mail.gmail.com>
Message-ID: <CAHk-=wioHUhqXU3_PR82VbfS8G=+zH+z8igeG-QAuCaWm5Cgqg@mail.gmail.com>
Subject: Re: [PATCH v2 10/32] signal/vm86_32: Properly send SIGSEGV when the
 vm86 state cannot be saved.
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        H Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 25, 2021 at 3:25 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> I think the result would be nicer if, instead of adding an extra goto,
> you just literally moved all the cleanup under the unsafe_put_user()s
> above them.  Unless I missed something, none of the put_user stuff reads
> any state that is written by the cleanup code.

Sure it does:

        memcpy(&regs->pt, &vm86->regs32, sizeof(struct pt_regs));

is very much part of the cleanup code, and overwrites that regs->pt thing.

Which is exactly what we're writing back to user space in that
unsafe_put_user() thing.

That said, thinking more about this, and looking at it again, I take
back my statement that we could just make it a catchable SIGSEGV
instead.

If we can't write the vm86 state to user space, we will have
fundamentally lost it, and while it's not fatal to the kernel, and
while we've recovered the original 32-bit state, it's not something
that user space can sanely recover from because the register state at
the end of the vm86 work has now been irrecoverably thrown away.

So I think Eric's patch is fine.

Except, as mentioned as part of the other patch, the "force_sigsegv()"
conversion to use "force_fatal_sig()" was broken, because that
function wasn't actually fatal at all.

             Linus
