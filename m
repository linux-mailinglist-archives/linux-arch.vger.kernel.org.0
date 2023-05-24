Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB3470F833
	for <lists+linux-arch@lfdr.de>; Wed, 24 May 2023 16:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbjEXOEQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 May 2023 10:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjEXOEO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2023 10:04:14 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE302E7;
        Wed, 24 May 2023 07:04:12 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64d2a613ec4so729793b3a.1;
        Wed, 24 May 2023 07:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684937052; x=1687529052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h3ryO674tidvGL1C9R3/slJDmhuMCbCkck5NhlxC3KY=;
        b=RgZqaiWy3OZvMhNNe3yzbZncIgpHeGmAP60B0EbMXzoTRrkHxdzBX62D+EtuSmYRSb
         nzN1f0JlhG79e9kH9Ombee+VqZhU1WyhNmscn/9TuZ4HXNoprChl0pYJIJh4ZJYvNWY1
         YHQIXyaQDvTCC23a8ECbT5HIZguFJTKPjueRZKfhYTsbBIlyOXOp2zCmrVmCkKxtsw0s
         Pv3eKzcj/44o94PlMW495nM6SEUl8P353kZPVKG2k6eqo9dNme3hdgQD0VQbfbYDnMHM
         Ay0SlZDOSie11UJok8uF5xIc4+cAPKsIlNZUgZ+NMTri0HoEDfQ5neEheSkm7bSc2U9q
         /ZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684937052; x=1687529052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h3ryO674tidvGL1C9R3/slJDmhuMCbCkck5NhlxC3KY=;
        b=lc0xKOtAc7k/fCJC3bFKbddcg2iJrNgdSIDRatm70PfPdE2ZdxonpS/eemJ9W7I9u1
         GTxLX6RCVsJZg/RVVgmTwrhMMOo6Sym36IfXUUtHRqcl7/SjBaRWf+5bqNLobc+hppS1
         OX19W76cuEYxy1gCXO1cTEkvA93Z6uh85qxXAt4h8JnwsjT+RBbFJHaLt6bSshazIDrc
         vliKZi5H6/+JtEi+t4EgDqtFqhBT/PWR4nceAVzkR04bsN25NJh65UJR/I8G1IwHd5Vz
         IzlYS28KVLkm1Dkpl9TnEq+grV/Py1y3thHJEU+5NonArQrijHU2OTxuyFHCRsdG4vju
         jIWw==
X-Gm-Message-State: AC+VfDw0MPtWpHXYL5h331oZy5zdUYuCHGF5LYTwwOv5y2GUOvF/KIvL
        RE7OTS+0+jKxLqFcyeR5mXHqTyAeP1Y=
X-Google-Smtp-Source: ACHHUZ7oPIMU1hwIO/kIU9m19ryJ8QuU5rEftRMFOj9EKTu/ieIgyRqUpzo1f47E0KdfOP9/VnKZCQ==
X-Received: by 2002:a05:6a00:1356:b0:64c:c841:4e8a with SMTP id k22-20020a056a00135600b0064cc8414e8amr3528455pfu.22.1684937051813;
        Wed, 24 May 2023 07:04:11 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id q20-20020a63e954000000b00502ecc282e2sm7939127pgj.5.2023.05.24.07.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 07:04:11 -0700 (PDT)
Message-ID: <96d6930b-78b1-4b4c-63e3-c385a764d6e3@gmail.com>
Date:   Wed, 24 May 2023 23:03:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 24/26] locking/atomic: scripts: generate kerneldoc
 comments
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, corbet@lwn.net, keescook@chromium.org,
        linux-arch@vger.kernel.org, linux@armlinux.org.uk,
        linux-doc@vger.kernel.org, paulmck@kernel.org,
        peterz@infradead.org, sstabellini@kernel.org, will@kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <20230522122429.1915021-1-mark.rutland@arm.com>
 <20230522122429.1915021-25-mark.rutland@arm.com>
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20230522122429.1915021-25-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Mark,

Thank you for the nice documentation improvements!

Please see inline comments for minor nits.

On Mon, 22 May 2023 13:24:27 +0100, Mark Rutland wrote:
> Currently the atomics are documented in Documentation/atomic_t.txt, and
> have no kerneldoc comments. There are a sufficient number of gotchas
> (e.g. semantics, noinstr-safety) that it would be nice to have comments
> to call these out, and it would be nice to have kerneldoc comments such
> that these can be collated.
> 
> While it's possible to derive the semantics from the code, this can be
> painful given the amount of indirection we currently have (e.g. fallback
> paths), and it's easy to be mislead by naming, e.g.
> 
> * The unconditional void-returning ops *only* have relaxed variants
>   without a _relaxed suffix, and can easily be mistaken for being fully
>   ordered.
> 
>   It would be nice to give these a _relaxed() suffix, but this would
>   result in significant churn throughout the kernel.
> 
> * Our naming of conditional and unconditional+test ops is rather
>   inconsistent, and it can be difficult to derive the name of an
>   operation, or to identify where an op is conditional or
>   unconditional+test.
> 
>   Some ops are clearly conditional:
>   - dec_if_positive
>   - add_unless
>   - dec_unless_positive
>   - inc_unless_negative
> 
>   Some ops are clearly unconditional+test:
>   - sub_and_test
>   - dec_and_test
>   - inc_and_test
> 
>   However, what exactly those test is not obvious. A _test_zero suffix
>   might be clearer.
> 
>   Others could be read ambiguously:
>   - inc_not_zero	// conditional
>   - add_negative	// unconditional+test
> 
>   It would probably be worth renaming these, e.g. to inc_unless_zero and
>   add_test_negative.
> 
> As a step towards making this more consistent and easier to understand,
> this patch adds kerneldoc comments for all generated *atomic*_*()
> functions. These are generated from templates, with some common text
> shared, making it easy to extend these in future if necessary.
> 
> I've tried to make these as consistent and clear as possible, and I've
> deliberately ensured:
> 
> * All ops have their ordering explicitly mentioned in the short and long
>   description.
> 
> * All test ops have "test" in their short description.
> 
> * All ops are described as an expression using their usual C operator.
>   For example:
> 
>   andnot: "Atomically updates @v to (@v & ~@i)"

The kernel-doc script converts "~@i" into reST source of "~**i**",
where the emphasis of i is not recognized by Sphinx.

For the "@" to work as expected, please say "~(@i)" or "~ @i".
My preference is the former.

>   inc:    "Atomically updates @v to (@v + 1)"
> 
>   Which may be clearer to non-naative English speakers, and allows all
                            non-native

>   the operations to be described in the same style.
> 
> * All conditional ops have their condition described as an expression
>   using the usual C operators. For example:
> 
>   add_unless: "If (@v != @u), atomically updates @v to (@v + @i)"
>   cmpxchg:    "If (@v == @old), atomically updates @v to @new"
> 
>   Which may be clearer to non-naative English speakers, and allows all

Ditto.

>   the operations to be described in the same style.
> 
> * All bitwise ops (and,andnot,or,xor) explicitly mention that they are
>   bitwise in their short description, so that they are not mistaken for
>   performing their logical equivalents.
> 
> * The noinstr safety of each op is explicitly described, with a
>   description of whether or not to use the raw_ form of the op.
> 
> There should be no functional change as a result of this patch.
> 
> Reported-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>

FWIW,

Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

        Thanks, Akira

> ---
>  include/linux/atomic/atomic-arch-fallback.h  | 1848 +++++++++++-
>  include/linux/atomic/atomic-instrumented.h   | 2771 +++++++++++++++++-
>  include/linux/atomic/atomic-long.h           |  925 +++++-
>  scripts/atomic/atomic-tbl.sh                 |  112 +-
>  scripts/atomic/gen-atomic-fallback.sh        |    2 +
>  scripts/atomic/gen-atomic-instrumented.sh    |    2 +
>  scripts/atomic/gen-atomic-long.sh            |    2 +
>  scripts/atomic/kerneldoc/add                 |   13 +
>  scripts/atomic/kerneldoc/add_negative        |   13 +
>  scripts/atomic/kerneldoc/add_unless          |   18 +
>  scripts/atomic/kerneldoc/and                 |   13 +
>  scripts/atomic/kerneldoc/andnot              |   13 +
>  scripts/atomic/kerneldoc/cmpxchg             |   14 +
>  scripts/atomic/kerneldoc/dec                 |   12 +
>  scripts/atomic/kerneldoc/dec_and_test        |   12 +
>  scripts/atomic/kerneldoc/dec_if_positive     |   12 +
>  scripts/atomic/kerneldoc/dec_unless_positive |   12 +
>  scripts/atomic/kerneldoc/inc                 |   12 +
>  scripts/atomic/kerneldoc/inc_and_test        |   12 +
>  scripts/atomic/kerneldoc/inc_not_zero        |   12 +
>  scripts/atomic/kerneldoc/inc_unless_negative |   12 +
>  scripts/atomic/kerneldoc/or                  |   13 +
>  scripts/atomic/kerneldoc/read                |   12 +
>  scripts/atomic/kerneldoc/set                 |   13 +
>  scripts/atomic/kerneldoc/sub                 |   13 +
>  scripts/atomic/kerneldoc/sub_and_test        |   13 +
>  scripts/atomic/kerneldoc/try_cmpxchg         |   15 +
>  scripts/atomic/kerneldoc/xchg                |   13 +
>  scripts/atomic/kerneldoc/xor                 |   13 +
>  29 files changed, 5940 insertions(+), 7 deletions(-)
>  create mode 100644 scripts/atomic/kerneldoc/add
>  create mode 100644 scripts/atomic/kerneldoc/add_negative
>  create mode 100644 scripts/atomic/kerneldoc/add_unless
>  create mode 100644 scripts/atomic/kerneldoc/and
>  create mode 100644 scripts/atomic/kerneldoc/andnot
>  create mode 100644 scripts/atomic/kerneldoc/cmpxchg
>  create mode 100644 scripts/atomic/kerneldoc/dec
>  create mode 100644 scripts/atomic/kerneldoc/dec_and_test
>  create mode 100644 scripts/atomic/kerneldoc/dec_if_positive
>  create mode 100644 scripts/atomic/kerneldoc/dec_unless_positive
>  create mode 100644 scripts/atomic/kerneldoc/inc
>  create mode 100644 scripts/atomic/kerneldoc/inc_and_test
>  create mode 100644 scripts/atomic/kerneldoc/inc_not_zero
>  create mode 100644 scripts/atomic/kerneldoc/inc_unless_negative
>  create mode 100644 scripts/atomic/kerneldoc/or
>  create mode 100644 scripts/atomic/kerneldoc/read
>  create mode 100644 scripts/atomic/kerneldoc/set
>  create mode 100644 scripts/atomic/kerneldoc/sub
>  create mode 100644 scripts/atomic/kerneldoc/sub_and_test
>  create mode 100644 scripts/atomic/kerneldoc/try_cmpxchg
>  create mode 100644 scripts/atomic/kerneldoc/xchg
>  create mode 100644 scripts/atomic/kerneldoc/xor
> 
[...]

