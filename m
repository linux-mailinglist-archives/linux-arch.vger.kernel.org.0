Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0F810FEE8
	for <lists+linux-arch@lfdr.de>; Tue,  3 Dec 2019 14:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfLCNgg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Dec 2019 08:36:36 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44405 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfLCNgg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Dec 2019 08:36:36 -0500
Received: by mail-oi1-f194.google.com with SMTP id d62so3216653oia.11
        for <linux-arch@vger.kernel.org>; Tue, 03 Dec 2019 05:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p7E/g0ZgEG0SIrt/LMvG8aw0gP5PcAR7IiJAD9Z/f64=;
        b=Plyt8WUHdt5gIIj47epLgzlVCkXwxZg/8grR6TsFuej57kTL1lVkom+rLGNl0eI+rE
         uMwNRTmM04ypBNYVecsdzKSRW+JBvIyZlN45/+Jj1hAgi+v1V4P9jb5Mr4LrXFEDnPoH
         aoVe1sHws+7TFsm87dIP5/qdO5m5I4WJz+eo7HrZrLRaDVTDME9qvAE++7FlVrdpC4TD
         IPcf2Qoujx/WiwOw0AsewqcT0FK7+GTcWOXGLUvzmBg/HnWSnyjsKWZ2U2sCsOLDsl7W
         x/t9gsimtGz3k6cn+GxYi0JSEZWmPAFk5Gu17zDiUiVZ++haAse58joTfMbPibTxUb4Y
         JZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p7E/g0ZgEG0SIrt/LMvG8aw0gP5PcAR7IiJAD9Z/f64=;
        b=X6vJSetobm0sid08cBSOaYynbLQh/H5ojT/A9h0coZa0QpMTu6D2jPmB0XTOByOz+b
         iCyytmlFpeLkQGDfqZsC7SP4aHc5mRxSpJ3cajiOPzm3fsuXPE3GYrF068prdQU9GHQS
         sADv4B7JvkA8JqvTHiadgrz3YMxKw5duxaOqzWnw+eLCcgiwQ6bvmfsFrxFwZjGN6duT
         +tadksgXtgZgjemLv/VuDg5desfY0jroabdQh3NNURnm8jvotQLvKa9hro5QmuW7Jzib
         vPKoj81aibuwT6lFzEVDOWQMOEcZBTvVtOvCEirCHtansYpatkb04aEpdcNcqyxZEcFe
         70Gw==
X-Gm-Message-State: APjAAAWkr5ZJiw4vChuQoAucyn6fqNaEf9qaWBYexRFFU5SEh5x9sYxu
        PwInKeGfpvuKW4KQcAhzRqF9JLpz9Di1dc+oMmWbPg==
X-Google-Smtp-Source: APXvYqy7sLpjvdiJvY2VTxZDbGv7MYReE6J6G5F5toxOJPKbFHRNKc0F12RJp3/PzAwhZvG5nGdaCTYBn5Fu/t/glM4=
X-Received: by 2002:a05:6808:8d5:: with SMTP id k21mr3650897oij.121.1575380194257;
 Tue, 03 Dec 2019 05:36:34 -0800 (PST)
MIME-Version: 1.0
References: <20190820024941.12640-1-dja@axtens.net> <877e6vutiu.fsf@dja-thinkpad.axtens.net>
 <878sp57z44.fsf@dja-thinkpad.axtens.net> <CANpmjNOCxTxTpbB_LwUQS5jzfQ_2zbZVAc4nKf0FRXmrwO-7sA@mail.gmail.com>
 <87a78xgu8o.fsf@dja-thinkpad.axtens.net> <87y2wbf0xx.fsf@dja-thinkpad.axtens.net>
 <CANpmjNN-=F6GK_jHPUx8OdpboK7nMV=i=sKKfSsKwKEHnMTG0g@mail.gmail.com> <87r21lef1k.fsf@mpe.ellerman.id.au>
In-Reply-To: <87r21lef1k.fsf@mpe.ellerman.id.au>
From:   Marco Elver <elver@google.com>
Date:   Tue, 3 Dec 2019 14:36:23 +0100
Message-ID: <CANpmjNO5MgoBGBxv5iTDCegF-Saxg7dxeiTBqQRKdeUf1F5wXQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kasan: support instrumented bitops combined with
 generic bitops
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Daniel Axtens <dja@axtens.net>, linux-s390@vger.kernel.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 3 Dec 2019 at 14:04, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Marco Elver <elver@google.com> writes:
> > On Wed, 20 Nov 2019 at 08:42, Daniel Axtens <dja@axtens.net> wrote:
> >>
> >> > But the docs do seem to indicate that it's atomic (for whatever that
> >> > means for a single read operation?), so you are right, it should live in
> >> > instrumented-atomic.h.
> >>
> >> Actually, on further inspection, test_bit has lived in
> >> bitops/non-atomic.h since it was added in 4117b02132d1 ("[PATCH] bitops:
> >> generic __{,test_and_}{set,clear,change}_bit() and test_bit()")
> >>
> >> So to match that, the wrapper should live in instrumented-non-atomic.h
> >> too.
> >>
> >> If test_bit should move, that would need to be a different patch. But I
> >> don't really know if it makes too much sense to stress about a read
> >> operation, as opposed to a read/modify/write...
> >
> > That's fair enough. I suppose this can stay where it is because it's
> > not hurting anyone per-se, but the only bad thing about it is that
> > kernel-api documentation will present test_bit() in non-atomic
> > operations.
>
> I only just noticed this thread as I was about to send a pull request
> for these two commits.
>
> I think I agree that test_bit() shouldn't move (yet), but I dislike that
> the documentation ends up being confusing due to this patch.
>
> So I'm inclined to append or squash in the patch below, which removes
> the new headers from the documentation. The end result is the docs look
> more or less the same, just the ordering of some of the functions
> changes. But we don't end up with test_bit() under the "Non-atomic"
> header, and then also documented in Documentation/atomic_bitops.txt.
>
> Thoughts?

For Documentation, this look reasonable to me.

Thanks,
-- Marco

> cheers
>
>
> diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
> index 2caaeb55e8dd..4ac53a1363f6 100644
> --- a/Documentation/core-api/kernel-api.rst
> +++ b/Documentation/core-api/kernel-api.rst
> @@ -57,21 +57,12 @@ The Linux kernel provides more basic utility functions.
>  Bit Operations
>  --------------
>
> -Atomic Operations
> -~~~~~~~~~~~~~~~~~
> -
>  .. kernel-doc:: include/asm-generic/bitops/instrumented-atomic.h
>     :internal:
>
> -Non-atomic Operations
> -~~~~~~~~~~~~~~~~~~~~~
> -
>  .. kernel-doc:: include/asm-generic/bitops/instrumented-non-atomic.h
>     :internal:
>
> -Locking Operations
> -~~~~~~~~~~~~~~~~~~
> -
>  .. kernel-doc:: include/asm-generic/bitops/instrumented-lock.h
>     :internal:
>
