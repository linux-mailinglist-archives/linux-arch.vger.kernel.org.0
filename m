Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4432C78CCF2
	for <lists+linux-arch@lfdr.de>; Tue, 29 Aug 2023 21:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjH2TbF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Aug 2023 15:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240364AbjH2Ta7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Aug 2023 15:30:59 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0D9CCA
        for <linux-arch@vger.kernel.org>; Tue, 29 Aug 2023 12:30:44 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50078eba7afso7706112e87.0
        for <linux-arch@vger.kernel.org>; Tue, 29 Aug 2023 12:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693337442; x=1693942242;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FSQ4gNf423WtPLQ+pPFkJbDeU7NfPCf4BEI8oAjZMoY=;
        b=RDbVNrFKy6xcdn22QYHc1pJttUKcJ0FG7vBntA3oKnJSxy+B6taaInoFcj9UBxBuOH
         aQpbG+2FDkte9yPM7ETrXbCzSUU4hZHJ+Qfq1Vtp7KABsr54+oEvsIUcKBh7aARpsqsD
         LxsMkLYtP8F7FZ7dkSWhrNPrngKU8R/nGI8xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693337442; x=1693942242;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FSQ4gNf423WtPLQ+pPFkJbDeU7NfPCf4BEI8oAjZMoY=;
        b=C9i5urAIdezgpcQXPeHna2n2E/Ellca7Fd/SaLXoncY65A0L2rwQ6WEsulp7m7d/8J
         7wn2ZLfWJlglA8sT2ZcwVyV+xHr35UnE8pKjFr1k+3vvkK7Ord6DN7/VnRVB/BqUv70O
         4vj/J+Kp0JHZDEpd9uDDItamiwhic9Ddc11liwm4b7DZDq92heubnm0INzT+hAXDWdJh
         zD2urG9DTUNx034ylnxG/ntk3dt72dw4nPApCJ2FVmRa22S2k/AP7IC+Z+MRx5lfTtq7
         SV1rFwyE9pkGcME8MWpnwBbmJX2JdZ/9yY/VYncUbqEjYz2jri0Kh7PcKIroPVQ9NKi0
         dO+g==
X-Gm-Message-State: AOJu0YxrZfnwPluVGm8WHKBRPTAgf8xTJ6DaLhm9AfcCxmkMvmu26ULU
        F9mBoyQMw8Vrb55q38MqzkTveOmwYlOMBrdAT4irZVM+
X-Google-Smtp-Source: AGHT+IFUfRl1jgtO+96Q5EiaZpnDQLhtSm6Sp2Da43qhpU22C+t7HjAycyGDQzhqSmeWC8Pn7gLa6Q==
X-Received: by 2002:a19:4f56:0:b0:500:c292:e44e with SMTP id a22-20020a194f56000000b00500c292e44emr2032758lfk.54.1693337442417;
        Tue, 29 Aug 2023 12:30:42 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 4-20020ac24844000000b004f85d80ca64sm2069562lfy.221.2023.08.29.12.30.41
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 12:30:41 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-500913779f5so7671837e87.2
        for <linux-arch@vger.kernel.org>; Tue, 29 Aug 2023 12:30:41 -0700 (PDT)
X-Received: by 2002:a19:431c:0:b0:500:7685:83d with SMTP id
 q28-20020a19431c000000b005007685083dmr17941739lfa.48.1693337441334; Tue, 29
 Aug 2023 12:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230828170732.2526618-1-mjguzik@gmail.com>
In-Reply-To: <20230828170732.2526618-1-mjguzik@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Aug 2023 12:30:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=YwAsPUHN7Drem=Gj9xT6vvxgZx77ZecZVxOYYXpC0w@mail.gmail.com>
Message-ID: <CAHk-=wj=YwAsPUHN7Drem=Gj9xT6vvxgZx77ZecZVxOYYXpC0w@mail.gmail.com>
Subject: Re: [PATCH] x86: bring back rep movsq for user access on CPUs without ERMS
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 28 Aug 2023 at 10:07, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> Hand-rolled mov loops executing in this case are quite pessimal compared
> to rep movsq for bigger sizes. While the upper limit depends on uarch,
> everyone is well south of 1KB AFAICS and sizes bigger than that are
> common. The problem can be easily remedied so do it.

Ok, looking at teh actual code now, and your patch is buggy.

> +.Llarge_movsq:
> +       movq %rcx,%r8
> +       movq %rcx,%rax
> +       shrq $3,%rcx
> +       andl $7,%eax
> +6:     rep movsq
> +       movl %eax,%ecx
>         testl %ecx,%ecx
>         jne .Lcopy_user_tail
>         RET

The fixup code is very very broken:

> +/*
> + * Recovery after failed rep movsq
> + */
> +7:     movq %r8,%rcx
> +       jmp .Lcopy_user_tail
> +
> +       _ASM_EXTABLE_UA( 6b, 7b)

That just copies the original value back into %rcx. That's not at all
ok. The "rep movsq" may have succeeded partially, and updated %rcx
(and %rsi/rdi) accordingly. You now will do the "tail" for entirely
too much, and returning the wrong return value.

In fact, if this then races with a mmap() in another thread, the user
copy might end up then succeeding for the part that used to fail, and
in that case it will possibly end up copying much more than asked for
and overrunning the buffers provided.

So all those games with %r8 are entirely bogus. There is no way that
"save the original length" can ever be relevant or correct.

              Linus
