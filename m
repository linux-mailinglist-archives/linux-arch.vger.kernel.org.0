Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC8960C0FD
	for <lists+linux-arch@lfdr.de>; Tue, 25 Oct 2022 03:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiJYB1V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Oct 2022 21:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiJYB1C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Oct 2022 21:27:02 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A94B7C317
        for <linux-arch@vger.kernel.org>; Mon, 24 Oct 2022 18:02:52 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id w10so1367895qvr.3
        for <linux-arch@vger.kernel.org>; Mon, 24 Oct 2022 18:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6x4NyeHIOb8xnnvnRIlkAggzAkRP4Y6+NCcjWrSgBrw=;
        b=IQ2h5W/VdXcKcCHqZdhxMIgDZ36eLpFiMnCu+wiKIn/Tp7DodYCzwFOutjpjlySJZR
         vpE2tn82bO7UEbAXqNq6PQPZyK500l+Je3siM1BUgKglFvjBTx/thHbAYntOfut4L/lf
         HmkKJ00EAIxPj9lNiSx5HYNgBpcftcBuKvnjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6x4NyeHIOb8xnnvnRIlkAggzAkRP4Y6+NCcjWrSgBrw=;
        b=1Ht+YHGuW9tlDa6jgkYwjxUfkZ9nxXJuekZx2w9wXvCrb7AWFGYmIii2SBfEotcG8G
         i2kdAojjzngNlPUSy2H8nsZrSU8j2zRQwaBsaR4f0TB2/NhOn/93S06r5k3wnPITQphO
         ZnSDdSb3ND2ovhci6umE7C3UPk26P5tIz/l0fx9MA6rq6z2eK93YFmKRlVNawWCmy9Y8
         pHAr4MYtkiFH0krxdsDKFHKf+iwrevSynNZMJHa0dJG/mT467Y2imfK+JkVEUdKfX9Q3
         LCuLsUXpUOWA1aAXMj0mlUmmccwCLBSYlRwYbNSDuocjZDnfC7IrYmPpKaY+dHnyvGiF
         Pf3g==
X-Gm-Message-State: ACrzQf2iZvzn1QJAJuNxft7DozBBycdHs2cSo2ntdS0dN73pjQ8S4EXD
        hYxac2GCvAL0R5+XsUTKNppPQNu0SQps9Q==
X-Google-Smtp-Source: AMsMyM6WpJ5BdoVpcLVcDSuAztmxOnByHTiHZ9r+R7IIYITonI6f8xAD9eFCe0mNVYKj6ytMwvcvig==
X-Received: by 2002:a05:6214:2346:b0:496:ae16:f602 with SMTP id hu6-20020a056214234600b00496ae16f602mr29788023qvb.37.1666659770407;
        Mon, 24 Oct 2022 18:02:50 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id f18-20020a05620a409200b006ce515196a7sm1087472qko.8.2022.10.24.18.02.48
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 18:02:48 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id j130so12868956ybj.9
        for <linux-arch@vger.kernel.org>; Mon, 24 Oct 2022 18:02:48 -0700 (PDT)
X-Received: by 2002:a05:6902:124f:b0:66e:e3da:487e with SMTP id
 t15-20020a056902124f00b0066ee3da487emr33367907ybu.310.1666659768246; Mon, 24
 Oct 2022 18:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20221024190311.65b89ecb@gandalf.local.home> <CAHk-=wji4q7rGUWDLonnEnxq0ykNCcYGpMrNnZg89rAwOgyRKg@mail.gmail.com>
 <20221024202133.38e0913e@gandalf.local.home>
In-Reply-To: <20221024202133.38e0913e@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Oct 2022 18:02:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_jxetFqMB8VWcJdtOt+CU0r_isyGV4AhEYFxA7YsU7Q@mail.gmail.com>
Message-ID: <CAHk-=wj_jxetFqMB8VWcJdtOt+CU0r_isyGV4AhEYFxA7YsU7Q@mail.gmail.com>
Subject: Re: [RFC PATCH] text_poke/ftrace/x86: Allow text_poke() to be called
 in early boot
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 24, 2022 at 5:21 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> It's all about updating read only pages that are executable with a shadow mm.

Right. And it doesn't actually need the mm at all, all it wants is the
kernel page tables. Which is why all the "dup_mmap()" stuff seems so
wrong.

I suspect mm_alloc() does everything that VM actually needs.

IOW, it shouldn't have used the fork() helper, it should have used the
execve() helper that actually starts out from a clean slate. Because a
clean slate is exactly what that code wants.

No?

           Linus
