Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75E86C50EB
	for <lists+linux-arch@lfdr.de>; Wed, 22 Mar 2023 17:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjCVQkD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Mar 2023 12:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjCVQkC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Mar 2023 12:40:02 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD54018149
        for <linux-arch@vger.kernel.org>; Wed, 22 Mar 2023 09:40:00 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b20so42508304edd.1
        for <linux-arch@vger.kernel.org>; Wed, 22 Mar 2023 09:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679503199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZIyesKHbPqp/V3ehq6MMk3dF6iFvUejqJqEnybp4+Y=;
        b=RNoGDTKOQzh2gLA+UttGwSGhuzrBZqBrSopOh+ABu5jCSaZA6dAFb6zL9nHXejX1ue
         07MQ8X8GPJKtyY+bcYQ7FyCFSyPhyU4y1lKdwOru+CfdbELNUpF8UclG5KTAhCQnQAp6
         SgbjhUDw2hjyWZ1SUMbFR2Eqc0xru73pPso+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679503199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZIyesKHbPqp/V3ehq6MMk3dF6iFvUejqJqEnybp4+Y=;
        b=GtdWA6v9+63Y42aHEwZMe/0jQytQYXvcxEkwak70xOFuJLGhopX8WYh+RLvvBnyeWs
         utMP+MrIy9GFnvzvCdc6apvRzdF9DUJux5bkZdO+5VTlcq9zjMk1EmZ/biuASCu55JVc
         ZfS3svPP7OarNtWU8lSTz0gsma0OIhDJbGaNt8LxioiTbprymWExFIBNNkTFSKJzjhsP
         /IHlZgL6j6iovsKLO2nx33rmG4qMA7vU9gkAM20x8mXgJw2YX8h1efkOgLOXnDk7XW8O
         uWaK7F6V7KfCrRCg39NXTWV+mfhnirEvmbtai3avD5W10JNRdHBISOgboF0wW6nm3C6E
         dr0w==
X-Gm-Message-State: AO0yUKU40n59tLv3RTqtAqZ+RgAmqOL1gY3ynzxsg6y7OdCJstvYJBrR
        kPHdFzBRb7LDFjvEXJkgo/1S3U0oA2ZzkpP+qndZmZMq
X-Google-Smtp-Source: AK7set8TWQMspxMTfA72nfo9t4PXVrif7pYtKEk1FG3wxU0Vlp+EGxqK9wmg7kh0ZaybSO6pm6VAZA==
X-Received: by 2002:a17:906:f0d3:b0:87b:dac0:b23b with SMTP id dk19-20020a170906f0d300b0087bdac0b23bmr7605910ejb.55.1679503198991;
        Wed, 22 Mar 2023 09:39:58 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id qh7-20020a170906eca700b0092bea699124sm7440417ejb.106.2023.03.22.09.39.57
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 09:39:58 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id eg48so75340593edb.13
        for <linux-arch@vger.kernel.org>; Wed, 22 Mar 2023 09:39:57 -0700 (PDT)
X-Received: by 2002:a50:cd0b:0:b0:4f9:f4f7:9e8f with SMTP id
 z11-20020a50cd0b000000b004f9f4f79e8fmr3741539edi.2.1679503197253; Wed, 22 Mar
 2023 09:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230321122514.1743889-1-mark.rutland@arm.com>
 <20230321122514.1743889-4-mark.rutland@arm.com> <ZBsVOu6ygLoGOI5d@arm.com> <ZBsfH6DCVFhrGleS@FVFF77S0Q05N>
In-Reply-To: <ZBsfH6DCVFhrGleS@FVFF77S0Q05N>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Mar 2023 09:39:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiiC=vpcqx4XXzgTqQDFQX9u0+xKZJ+aTLgZy_mVANjdg@mail.gmail.com>
Message-ID: <CAHk-=wiiC=vpcqx4XXzgTqQDFQX9u0+xKZJ+aTLgZy_mVANjdg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] arm64: fix __raw_copy_to_user semantics
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, agordeev@linux.ibm.com,
        aou@eecs.berkeley.edu, bp@alien8.de, dave.hansen@linux.intel.com,
        davem@davemloft.net, gor@linux.ibm.com, hca@linux.ibm.com,
        linux-arch@vger.kernel.org, linux@armlinux.org.uk,
        mingo@redhat.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
        robin.murphy@arm.com, tglx@linutronix.de, viro@zeniv.linux.org.uk,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 22, 2023 at 8:30=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> I also believe that if we have a misaligned store straddling two pages, a=
nd the
> first page is faulting, it the store can do a partial write to the 2nd pa=
ge,
> which I suspected is not what we want (though maybe that's beningn, if we=
're
> going to say that clobbering anywhere within the dst buffer is fine).

So I don't think that clobbering anywhere in the write buffer is fine
in general:, since user space may well depend on the whole "kernel
wrote exactly this range" (ie people who implement things like
circular buffers in user space that are filled by the kernel with a
read() system call).

But that's about partial read() results in general, and things like
interruptible reads (or just partial results from a pipe) in
particular.

At the same time EFAULT really is pretty special. We've *tried* to
make it restartable by user space, but honestly, I'm not entirely sure
that was ever a good idea, and I'm not even sure anybody really
depends on it.

For that case, I don't think we necessarily should care too deeply.

HOWEVER.

There is one very very special case: we may not care about
"restartable system calls" from user space, and say "we might as well
just always return EFAULT for any partial result".

That is, after all, what we already do for many cases (ie structure
copies, "put_user()" and friends). And I suspect it's what a lot of
other systems do.

No, the one special case is for the _kernel_ use of restartable user
copies, and the "__copy_from_user_inatomic()" case in particular.

They aren't hugely common, but they are required for some cases
(notably filesystems that hold locks and cannot take user page faults
due to deadlock scenarios), and *those* need very special care.

They still don't need to be byte-exact, but they do need to be able to
restart and most notably they need to be able to make forward progress
(together with a separate "fault_in_user_readable/writable()").

We've had situations where that didn't happen, and then you get actual
kernel hangs when some filesystem just does an endless loop with page
faults.

And by "make forward progress", it's actually fine to write too much
to user space, and return a short return value, and when restarting,
do some of the writes to user space *again*. It just has to be
restartable with the same data, and it can't keep taking a fault
thanks to some bad interaction with the "fault-in" case.

Of course, that does end up using the exact same user copy code, just
under "pagefault_disable()" (which is often implicitly called through
something like "kmap_atomic()" or similar).

So I don't think we need to be byte-exact, but we do need to keep that
restart case in mind. But again, the restart can re-do parts of the
copy.

                    Linus
