Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30D66C38A1
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 18:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjCURvB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 13:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjCURu6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 13:50:58 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED7251FA9
        for <linux-arch@vger.kernel.org>; Tue, 21 Mar 2023 10:50:53 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id cy23so62844121edb.12
        for <linux-arch@vger.kernel.org>; Tue, 21 Mar 2023 10:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679421051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbTuKKPTGahowbJdCxJIAaT7lPuVx9AJJeoBmZ4Lmh4=;
        b=Vweh5rdFSwvlaLqVrE58+BS3C7MgBsraIxL5PiDQxkSwGUwgpM2x+imMlFOEuwDsPT
         Rvlt1JO5EsR7avYj9t3IGMfnMG9v3rzBE4p3jtxKgIzHWRZ96VElYq9CyxQaFCHEdEJD
         3FoxRdUGs9+ZEch/L388ViBE+Cqu2v5DgVBSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679421051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbTuKKPTGahowbJdCxJIAaT7lPuVx9AJJeoBmZ4Lmh4=;
        b=0QDYIuFqq5yrKaayrtrMBfggUVc0YdAxOrkUmCGWinhRTVNyz7BPAQirgj5QTpgmLp
         /sDUsmIC9xzz8PNtdLJo2SU56Qi3+s6RtrhELf/ZpfHmbTGjUqcZKgB8rtbVGWvN9UQh
         TQVG2MuV9zzHgU4SwlcjGF8/jfOIC+xZVSUC0d21EHiulEFFgRGavc3L8Ofi8qA8RrXo
         3MEX4rwhk1/EVHr1j/sBj/ue7wnshGzy3nr6J/uVhe/YTbPq7alOlxCWc+GpQSUYVkng
         mZJGXLnhvAVHmOlDqQlSdEI83qMHB/iB0jesPVRRmtcEqMFh40okl5Vt2iwFqlJTnE16
         0gKQ==
X-Gm-Message-State: AO0yUKX4ZndzARj+g0y9YwuERTLGm4/zrATDqT4HR55L430+lQCcdhFq
        QzG/WLEqTbQsQ5ArDycXdj4GKymnYkcnV33qiOJo1A==
X-Google-Smtp-Source: AK7set9oFUQdIg83XggkRnuFAV3Q4SP97gxIWmpZ/FgnQJSMJ8nlJe5J6Ur7T2QnZx1UckVBKxBDyQ==
X-Received: by 2002:a50:ee0d:0:b0:4fb:2060:4c20 with SMTP id g13-20020a50ee0d000000b004fb20604c20mr3771693eds.31.1679421051744;
        Tue, 21 Mar 2023 10:50:51 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id t21-20020a50d715000000b004af7191fe35sm6595129edi.22.2023.03.21.10.50.50
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 10:50:51 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id b20so30006253edd.1
        for <linux-arch@vger.kernel.org>; Tue, 21 Mar 2023 10:50:50 -0700 (PDT)
X-Received: by 2002:a17:907:9b03:b0:932:da0d:9375 with SMTP id
 kn3-20020a1709079b0300b00932da0d9375mr2314988ejc.4.1679421050440; Tue, 21 Mar
 2023 10:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230321122514.1743889-1-mark.rutland@arm.com> <20230321122514.1743889-4-mark.rutland@arm.com>
In-Reply-To: <20230321122514.1743889-4-mark.rutland@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Mar 2023 10:50:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjCN93bY_iMUF-msP6+2cCQTssQe4kiW2P1ZBDxf4Rt3g@mail.gmail.com>
Message-ID: <CAHk-=wjCN93bY_iMUF-msP6+2cCQTssQe4kiW2P1ZBDxf4Rt3g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] arm64: fix __raw_copy_to_user semantics
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
> For some combinations of sizes and alignments __{arch,raw}_copy_to_user
> will copy some bytes between (to + size - N) and (to + size), but will
> never modify bytes past (to + size).
>
> This violates the documentation in <linux/uaccess.h>, which states:
>
> > If raw_copy_{to,from}_user(to, from, size) returns N, size - N bytes
> > starting at to must become equal to the bytes fetched from the
> > corresponding area starting at from.  All data past to + size - N must
> > be left unmodified.

Hmm.

I'm not 100% sure we couldn't just relax the documentation.

After all, the "exception happens in the middle of a copy" is a
special case, and generally results in -EFAULT rather than any
indication of "this is how much data we filled in for user space".

Now, some operations do *try* to generally give partial results
(notably "read()") even in the presence of page faults in the middle,
but I'm not entirely convinced we need to bend over backwards over
this.

Put another way: we have lots of situations where we fill in partial
user butffers and then return EFAULT, so "copy_to_user()" has at no
point been "atomic" wrt the return value.

So I in no way hate this patch, and I do think it's a good "QoI fix",
but if this ends up being painful for some architecture, I get the
feeling that we could easily just relax the implementation instead.

We have accepted the whole "return value is not byte-exact" thing
forever, simply because we have never required user copies to be done
as byte-at-a-time copies.

Now, it is undoubtedly true that the buffer we fill in with a user copy mus=
t

 (a) be filled AT LEAST as much as we reported it to be filled in (ie
user space can expect that there's no uninitialized data in any range
we claimed to fill)

 (b) obviously never filled past the buffer size that was given

But if we take an exception in the middle, and write a partial aligned
word, and don't report that as written (which is what you are fixing),
I really feel that is a "QoI" thing, not a correctness thing.

I don't think this arm implementation thing has ever hurt anything, in
other words.

That said, at some point that quality-of-implementation thing makes
validation so much easier that maybe it's worth doing just for that
reason, which is why I think "if it's not too painful, go right ahead"
is fine.

           Linus
