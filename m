Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1C66D864F
	for <lists+linux-arch@lfdr.de>; Wed,  5 Apr 2023 20:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbjDESx7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Apr 2023 14:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjDESx7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Apr 2023 14:53:59 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98523A9E;
        Wed,  5 Apr 2023 11:53:57 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id br40so5571055qkb.9;
        Wed, 05 Apr 2023 11:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680720837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRtXFO8p+VJqvb8EGOqoRE2s3RWE1f66fx+Rp1t5D9o=;
        b=OMlSV93FLik5uu6Z8lBQaDkNCKwnSNM3KQNtekolqO7lEAxeuPLjS7vAMwzAzhfHZ9
         iiFaH/lpB9PdL8VEOyRPJ2pWuyf0eRnq8GXT9u4Qo7TmPlJABcbGiYYymYezYDB9VYTc
         xkNWzfRwbvB7nsbQtDV4/jeva/rzwD/SG5iPLBdW1yU5S04rD1O1LmD0uMbkKZ9cGtiw
         +p904lLQLMu8a2ioQfdd0zG/38JialqxNkswfgAIGzhFtqnihwTUUxXK7+i0iOfKFj0n
         RxGvXaOp6UMT9qYlKaIWuENHXQXsbghZYBb+ZiWjtEDaJJlLAe6PZq1h6UR5rPhPq351
         o8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680720837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRtXFO8p+VJqvb8EGOqoRE2s3RWE1f66fx+Rp1t5D9o=;
        b=4m39JjkQvJ/s7F/lUJ6miKU3QORnr/SjopxFomB/I5pe2RfAmAy2xxnH/KW2vV8ATR
         wdaoBU5NWKHcV8Vu2fFYVqOoqDn5h3Scco95RkUyk9m/toRQ0br3Onh6N4a5JQACvqrE
         EkzZqXTV2tZpVbBUZzS7YOPeuPbgGdX3IrTSw2UPg4CkGkvISkridFDQA0Ti/zOdYyPd
         BCZggEka0Cw2csMmyL6AoBNZ4Buy6bS374qpTuP+eFgR2rEb7Tm2L48KTiTp/inAMf/H
         uqgItKmDsYqF02TGK6klGaRotaqy2RMcPMMt+M1IMoL50eR5PKzbATKKpSj2OF6xrIJs
         6OGA==
X-Gm-Message-State: AAQBX9dfhw1pW865yNuoXSqvVTyx1F0unwFk8BUKvlkHJ8CohZ6/pSLj
        FyNhUDyhlU5e90+3rDW1KaYssgED5ToPT11g7pOd9e5jWJsD03kI
X-Google-Smtp-Source: AKy350aArjUI2H96/efNuT4p4Gns0LFchwaT84DgmUSYAPmyhG0Hxnacumi6y7a0qpoFL35F7ev0gS5BSSlbBVcMbIg=
X-Received: by 2002:a05:620a:280a:b0:745:7249:49ed with SMTP id
 f10-20020a05620a280a00b00745724949edmr1345672qkp.6.1680720836842; Wed, 05 Apr
 2023 11:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230405141710.3551-1-ubizjak@gmail.com> <7360ffd2-a5aa-1373-8309-93e71ff36cbb@intel.com>
In-Reply-To: <7360ffd2-a5aa-1373-8309-93e71ff36cbb@intel.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 5 Apr 2023 20:53:45 +0200
Message-ID: <CAFULd4a6u=LB0ivfHtHt=jRxeJeLWuBot=Pync6pbrvKi=CdjA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] locking: Introduce local{,64}_try_cmpxchg
To:     Dave Hansen <dave.hansen@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jun Yi <yijun@loongson.cn>
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

On Wed, Apr 5, 2023 at 6:37=E2=80=AFPM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> On 4/5/23 07:17, Uros Bizjak wrote:
> > Add generic and target specific support for local{,64}_try_cmpxchg
> > and wire up support for all targets that use local_t infrastructure.
>
> I feel like I'm missing some context.
>
> What are the actual end user visible effects of this series?  Is there a
> measurable decrease in perf overhead?  Why go to all this trouble for
> perf?  Who else will use local_try_cmpxchg()?

This functionality was requested by perf people [1], so perhaps Steven
can give us some concrete examples. In general, apart from the removal
of unneeded compare instruction on x86, usage of try_cmpxchg also
results in slightly better code on non-x86 targets [2], since the code
now correctly identifies fast-path through the cmpxchg loop.

Also important is that try_cmpxchg code reuses the result of cmpxchg
instruction in the loop, so a read from the memory in the loop is
eliminated. When reviewing the cmpxchg usage sites, I found numerous
places where unnecessary read from memory was present in the loop, two
examples can be seen in the last patch of this series.

Also, using try_cmpxchg prevents inconsistencies of the cmpxchg loop,
where the result of the cmpxchg is compared with the wrong "old" value
- one such bug is still lurking in x86 APIC code, please see [3].

Please note that apart from perf subsystem, event subsystem can also
be improved by using local_try_cmpxchg. This is the reason that the
last patch includes a change in events/core.c.

> I'm all for improving things, and perf is an important user.  But, if
> the goal here is improving performance, it would be nice to see at least
> a stab at quantifying the performance delta.

[1] https://lore.kernel.org/lkml/20230301131831.6c8d4ff5@gandalf.local.home=
/
[2] https://lore.kernel.org/lkml/Yo91omfDZtTgXhyn@FVFF77S0Q05N.cambridge.ar=
m.com/
[3] https://lore.kernel.org/lkml/20230227160917.107820-1-ubizjak@gmail.com/

Uros.
