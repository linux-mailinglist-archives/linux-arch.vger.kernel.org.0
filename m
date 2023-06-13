Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD9D72EA30
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 19:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjFMRpJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 13:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjFMRpI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 13:45:08 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A65F12C
        for <linux-arch@vger.kernel.org>; Tue, 13 Jun 2023 10:45:07 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f62b512fe2so7541751e87.1
        for <linux-arch@vger.kernel.org>; Tue, 13 Jun 2023 10:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686678305; x=1689270305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcOW2YayMm3xjw1cJ1qlGpr/UGWPmxOrQJ2QJLZKMzE=;
        b=BO7ZUfWA7Mcu3phYwW5mZInQjZHoVgxsQb79z5ZPy5A+s8LJsNUTZ0amyH7D3ic4k2
         e76yc1f9t8ir5cQMmEdhE4SmRSf3sUwzR2RNHGO+z+BNGdFL5/+JrFv9ob8gPSOMmFUg
         PEMKLtmM11yURVs+Im7PLWNTPGon5DtiRZr4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686678305; x=1689270305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcOW2YayMm3xjw1cJ1qlGpr/UGWPmxOrQJ2QJLZKMzE=;
        b=J8J8Oq9zcEyMt0HS5LAXVp/AQ1bEO6YEMXdKHIyUNEP15QWlz3gsfEuQlxIJpM8xYy
         GvNFP8IWHmmde89NDaKA5p7LLuxEgeMjYWuFTbO6p4bKQ/OfG7OOfSmUpttRABwVh1BM
         GEqR91LF4eLJxn58GxkQUU4KHBlEUWujGtHfeBbGi4hysZLUxplvR9zJ8mbjN6oXfEnQ
         KlptX/ZJfU9EdPw0Y+R4QOH+yEpyXNoKlm37R22mEhbpUtqxpCYFn05exGe86NV//YRC
         KAgURvR4pm83ubba6Ui+cl5dUaAUXrFKcxGsUew//iPP0Nhk50FL3Z2+7MZMhzd+T/Cv
         sCuA==
X-Gm-Message-State: AC+VfDz8aS8GIUzb+QSd9gqzQM7YYAIbcAysIMmQncRWRBB4U3/yZVm1
        q5Yj/zLGqbQR0SdTaoTHZnwacqjUK0InKQDEpxgGdu4G
X-Google-Smtp-Source: ACHHUZ6Xij5xgJAQFDcjzqbxPMEuyNepSbfcT7Kfge7MLC9n9XfBrXuTJHIdM1FeN9p/yFEOey2ZKQ==
X-Received: by 2002:a05:6512:478:b0:4f5:bc59:6f21 with SMTP id x24-20020a056512047800b004f5bc596f21mr8010363lfd.12.1686678305449;
        Tue, 13 Jun 2023 10:45:05 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id b14-20020ac247ee000000b004f611dd9935sm1841538lfp.152.2023.06.13.10.45.02
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 10:45:03 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4f658a17aa4so6432660e87.0
        for <linux-arch@vger.kernel.org>; Tue, 13 Jun 2023 10:45:02 -0700 (PDT)
X-Received: by 2002:a05:6512:548:b0:4ef:ec6a:198c with SMTP id
 h8-20020a056512054800b004efec6a198cmr6103911lfl.26.1686678301549; Tue, 13 Jun
 2023 10:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <CAHk-=wh0UNRn96k3XLh2AYOo0iz1k_Qk-rQXv8kYjXkKBzUMWA@mail.gmail.com> <c239d2c4f7e369690866db455813cac359731e1d.camel@intel.com>
In-Reply-To: <c239d2c4f7e369690866db455813cac359731e1d.camel@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Jun 2023 10:44:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjSWhVV+qr_tV0xg8c0WRn_H9wtFZkUVCpv-VzsddAS-Q@mail.gmail.com>
Message-ID: <CAHk-=wjSWhVV+qr_tV0xg8c0WRn_H9wtFZkUVCpv-VzsddAS-Q@mail.gmail.com>
Subject: Re: [PATCH v9 00/42] Shadow stacks for userspace
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 12, 2023 at 8:12=E2=80=AFPM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> Sure. I probably should have included that upfront. Here is a github
> repo:
> https://github.com/rpedgeco/linux/tree/user_shstk_v9
>
> I went ahead and included the tags[0] from last time in case that's
> useful, but unfortunately the github web interface is not very
> conducive to viewing the tag-based segmentation of the series. If
> having it in a korg repo would be useful, please let me know.

Oh, kernel.org vs github doesn't matter. I'm not actually merging this
yet, I'm just doing a fetch to then easily be able to look at it
locally in different formats.

I tend to like seeing small things in my MUA just because then I don't
switch back-and-forth between reading email and some gitk workflow,
and it is easy to just scan through the series and reply all inthe
MUA.

But when it's some bigger piece, just doing a "git fetch" and then
being able to dissect it locally is really convenient.

Having worked with patches for three decades, I can read diffs in my
sleep - but it's still quite useful to say "give me the patches just
for *this* file" to just see how some specific area changed without
having to look at the other parts.

Or for example, that whole pte_mkwrite -> pte_mkwrite_novma patch is
much denser and more legible with color-coding and the --word-diff.

Anyway, I'm scanning through it right now. No comments yet, I only
just got started.

              Linus
