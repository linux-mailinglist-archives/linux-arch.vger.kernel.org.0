Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233506C38E3
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 19:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjCUSFN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 14:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjCUSFL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 14:05:11 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D63038471
        for <linux-arch@vger.kernel.org>; Tue, 21 Mar 2023 11:04:47 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id cy23so63000800edb.12
        for <linux-arch@vger.kernel.org>; Tue, 21 Mar 2023 11:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679421885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7SLq5regHpbyQXTIDtK1SgaDzSaRkQ8eVCIyS1gzK4=;
        b=bWYVHkPrJ3lhl2qvydsocOaNohhdflPAx40ZjmJAkc2ONftBovoeyN6KKIOYZpM74h
         3mzeM/WZjQxgY09Q6myFysAsy47qYHAkO4bHr8grBwOU3B6t6B5Tu5/nyb8GYPzQgaIl
         LEtyibH+8V9c0YyTCK9k+y/A/VQifyeRzodrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679421885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7SLq5regHpbyQXTIDtK1SgaDzSaRkQ8eVCIyS1gzK4=;
        b=8LFcJl+KBciGHKfpOuus29rGQ1ct4onKda1YIBt0MT3r3JvjiNk+zAjdvT4eTpLOXL
         eXBcTFoB8Y2GfRqL2ugccOfPMXgp8ekEjuhSlgwySatcjsHRV2kHCAdwTLe9zlKIMGqf
         u2wL4aKnlg1RMRoJxRerx0sdY00c7Yuqxv0CJwI8Kc7rtyeg82ooloQAR7m61vDslTUw
         jiAhJxGhfKfHPRWo+iAbVdhpJXeXyN/rKD/NMUsfCBk+lYu+hkBakx5App0C7+nXZxca
         Asd5lLJcreQtJAYcnuZ0zo2fURlXp74y1qqtvPrbYOW6I1X+R1aleBlI5gHujQzDOfWO
         G+Hg==
X-Gm-Message-State: AO0yUKXTMlaKJaCtwhOwDKBvxgwpKIOskuz9Z8VJ4krwfcK5V3HsYbwc
        JQjpXOGSENEUckjfFegpBkHqlYq+6WKIjojBfNUPKQ==
X-Google-Smtp-Source: AK7set/TfVF9W3WWFS/DqeTtEpKxy+/JR1LOKvEgFQeVq7EQ30G5MYP55aJ0rSmnIug6ideqwVOhlg==
X-Received: by 2002:aa7:c84a:0:b0:500:2a15:f86b with SMTP id g10-20020aa7c84a000000b005002a15f86bmr3958344edt.42.1679421885180;
        Tue, 21 Mar 2023 11:04:45 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id r12-20020a50c00c000000b00501d2f10d19sm2227312edb.20.2023.03.21.11.04.43
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 11:04:44 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id b20so30162695edd.1
        for <linux-arch@vger.kernel.org>; Tue, 21 Mar 2023 11:04:43 -0700 (PDT)
X-Received: by 2002:a17:906:6d6:b0:933:f6e8:26d9 with SMTP id
 v22-20020a17090606d600b00933f6e826d9mr1718588ejb.15.1679421883223; Tue, 21
 Mar 2023 11:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230321122514.1743889-1-mark.rutland@arm.com> <20230321122514.1743889-2-mark.rutland@arm.com>
In-Reply-To: <20230321122514.1743889-2-mark.rutland@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Mar 2023 11:04:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgknoR11b+mX=AP8TcHP+gsFGdhPk7sJPROaQBBsqdubw@mail.gmail.com>
Message-ID: <CAHk-=wgknoR11b+mX=AP8TcHP+gsFGdhPk7sJPROaQBBsqdubw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] lib: test copy_{to,from}_user()
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, agordeev@linux.ibm.com,
        aou@eecs.berkeley.edu, bp@alien8.de, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, davem@davemloft.net,
        gor@linux.ibm.com, hca@linux.ibm.com, linux-arch@vger.kernel.org,
        linux@armlinux.org.uk, mingo@redhat.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robin.murphy@arm.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 21, 2023 at 5:25=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> * arm64's copy_to_user() under-reports the number of bytes copied in
>   some cases, e.g.

So I think this is the ok case.

> * arm's copy_to_user() under-reports the number of bytes copied in some
>   cases, and both copy_to_user() and copy_from_user() don't guarantee
>   that at least a single byte is copied when a partial copy is possible,

Again, this is ok historically.

> * i386's copy_from_user does not guarantee that at least a single byte
>   is copied when a partial copit is possible, e.g.
>
>   | too few bytes consumed (offset=3D4093, size=3D8, ret=3D8)

And here's the real example of "we've always done this optimization".
The exact details have differed, but the i386 case is the really
really traditional one: it does word-at-a-time copies, and does *not*
try to fall back to byte-wise copies. Never has.

> * riscv's copy_to_user() and copy_from_user() don't guarantee that at
>   least a single byte is copied when a partial copy is possible, e.g.
>
>   | too few bytes consumed (offset=3D4095, size=3D2, ret=3D2)

Yup. This is all the same "we've never forced byte-at-a-time copies"

> * s390 passes all tests
>
> * sparc's copy_from_user() over-reports the number of bbytes copied in
>   some caes, e.g.

So this case I think this is wrong, and an outright bug. That can
cause people to think that uninitialized data is initialized, and leak
sensitive information.

> * x86_64 passes all tests

I suspect your testing is flawed due to being too limited, and x86-64
having multiple different copying routines.

Yes, at some point we made everything be quite careful with
"handle_tail" etc, but we end up still having things that fail early,
and fail hard.

At a minimum, at least unsafe_copy_to_user() will fault and not do the
"fill to the very last byte" case. Of course, that doesn't return a
partial length (it only has a "fail" case), but it's an example of
this whole thing where we haven't really been byte-exact when doing
copies.

So again, I get the feeling that these rules may make sense from a
validation standpoint, but I'm not 100% sure we should generally have
to be this careful.

                 Linus
