Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AC16C81A6
	for <lists+linux-arch@lfdr.de>; Fri, 24 Mar 2023 16:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjCXPoF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Mar 2023 11:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbjCXPoD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Mar 2023 11:44:03 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924FFF75C;
        Fri, 24 Mar 2023 08:43:46 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-544787916d9so39361457b3.13;
        Fri, 24 Mar 2023 08:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679672623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQ68igRUsnQg6wVXldKGuyS+4F6MYvbK1+eEkynFAsY=;
        b=K53LV2Ko7xTlcNS5SUEdTEPHSAx9VMu3KndgmdfNMx+UIms9g0RyB7VJUhxrU24QnI
         cQDhfbolVWi2kplhpvxOrqu+G2TNMB31B1alqPIag3L9My7jwcxa0nzuK0FzEsAQXANT
         CuoYXCRV7QkE5rCDrHbdvkoGK9/6Nw5J3z4nUFuwANGrXUw5+QGVdzSDcN1kNiJnyBLg
         8ckJxCZjD5I6IeWuw5SlTI4F1OLUxA+83oM9s6+Y14yUpMn+LHgms2YPXRSG3MyExdUC
         3ajx0Xnh/NIFmAoQlAZEFK0nrM7l1qSkTn9vF4HxnS8qyXkaF1PAVl1JfMaMDSwyDAX6
         ZKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679672623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQ68igRUsnQg6wVXldKGuyS+4F6MYvbK1+eEkynFAsY=;
        b=C2GEqOizvbIJiKLmdkiFJH2G0xk+S31R6IKCbU4FotFmdq3dJ+qTFPyodPZkhhVhbG
         Wo3ond4vsIXJ6J/PuhlFIYfDiNXRSBPkycxzq2GCkAWh1YrM1qBwy+VfhyP6riFHlC4+
         TYyBEtVx8vwikjKRGEQMG7OeTKBlPrEow4GKK1bt5tL3JfxR2pDCr3yzgbLi3rsBK0/i
         u/yUdlzgWoxfYBiB7ssnqytq8ZuNMbIfUHoettSLVVrCHVsNOApxPYR/rVZmg+sJukX9
         y18/GLg7A7iU+CklaOkCdVrB43RJtCRJV2xGmt06edWwt2zV2pZ2+h0wb4yieVBOJJZy
         8E2Q==
X-Gm-Message-State: AAQBX9fjJLcCqWd4ibT+GDpY7FY/oqQAH4xJBFhkaIcOJzzNRlhlTx4Y
        XdhmAZmC6hTU2ggfrmygPCLfIZyPj3mhdfrtcfc=
X-Google-Smtp-Source: AKy350bNHA5192Yp0xtsBy+BnFapAy006gmelWsyIvqLWKFQXqJqxH4nWrB7/16FYuoooXDwmaHGuPjIe8uT4/9/A+Q=
X-Received: by 2002:a81:b721:0:b0:545:3f42:2d97 with SMTP id
 v33-20020a81b721000000b005453f422d97mr216474ywh.3.1679672623440; Fri, 24 Mar
 2023 08:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230305205628.27385-1-ubizjak@gmail.com> <20230305205628.27385-2-ubizjak@gmail.com>
 <ZB2v+avNt52ac/+w@FVFF77S0Q05N>
In-Reply-To: <ZB2v+avNt52ac/+w@FVFF77S0Q05N>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Fri, 24 Mar 2023 16:43:32 +0100
Message-ID: <CAFULd4ZCgxDYnyy--qdgKoAo_y7MbNSaQdbdBFefnFuMoM2OYw@mail.gmail.com>
Subject: Re: [PATCH 01/10] locking/atomic: Add missing cast to try_cmpxchg() fallbacks
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 24, 2023 at 3:13=E2=80=AFPM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Sun, Mar 05, 2023 at 09:56:19PM +0100, Uros Bizjak wrote:
> > Cast _oldp to the type of _ptr to avoid incompatible-pointer-types warn=
ing.
>
> Can you give an example of where we are passing an incompatible pointer?

An example is patch 10/10 from the series, which will fail without
this fix when fallback code is used. We have:

-       } while (local_cmpxchg(&rb->head, offset, head) !=3D offset);
+       } while (!local_try_cmpxchg(&rb->head, &offset, head));

where rb->head is defined as:

typedef struct {
   atomic_long_t a;
} local_t;

while offset is defined as 'unsigned long'.

The assignment in existing try_cmpxchg template:

typeof(*(_ptr)) *___op =3D (_oldp)

will trigger an initialization from an incompatible pointer type error.

Please note that x86 avoids this issue by a cast in its
target-dependent definition:

#define __raw_try_cmpxchg(_ptr, _pold, _new, size, lock)                \
({                                                                      \
       bool success;                                                   \
       __typeof__(_ptr) _old =3D (__typeof__(_ptr))(_pold);              \
       __typeof__(*(_ptr)) __old =3D *_old;                              \
       __typeof__(*(_ptr)) __new =3D (_new);                             \

so, the warning/error will trigger only in the fallback code.

> That sounds indicative of a bug in the caller, but maybe I'm missing some
> reason this is necessary due to some indirection.
>
> > Fixes: 29f006fdefe6 ("asm-generic/atomic: Add try_cmpxchg() fallbacks")
>
> I'm not sure that this needs a fixes tag. Does anything go wrong today, o=
r only
> later in this series?

The patch at [1] triggered a build error in posix_acl.c/__get.acl due
to the same problem. The compilation for x86 target was OK, because
x86 defines target-specific arch_try_cmpxchg, but the compilation
broke for targets that revert to generic support. Please note that
this specific problem was recently fixed in a different way [2], but
the issue with the fallback remains.

[1] https://lore.kernel.org/lkml/20220714173819.13312-1-ubizjak@gmail.com/
[2] https://lore.kernel.org/lkml/20221201160103.76012-1-ubizjak@gmail.com/

Uros.
