Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE23C772B18
	for <lists+linux-arch@lfdr.de>; Mon,  7 Aug 2023 18:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjHGQg6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 12:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjHGQgz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 12:36:55 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D310510EC;
        Mon,  7 Aug 2023 09:36:37 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so5572559a12.2;
        Mon, 07 Aug 2023 09:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691426196; x=1692030996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZNcpOl8CEiyqW/ZOb/0XcvAH0YrJ+P7c3vLK34uSAU=;
        b=p+tvWBWwjHGrwcist+ERw9YfHaq9zpl05ImB2qAvYkl732NZFX8xD9wURvjqtCVJ1j
         f5qbn/zlJNV6GNzz6n8+mAMJaBmpwk6+UVEKF6KWKUWEFm/F9u8VY8GQrgo2LxfeBZvN
         Q25ySkdvCjrYg1Bcz4X891+wn78TNlj5vCAcuaen/d9ZcFRwWOOdiM/IHn+hB+Sp5QbU
         7KEoIxqB/oC0PKxqJkad8mWMRJdrUlFbGS3ml6DKgWCGfEOr7lCPVn0QEw8jmqV+iO3y
         DCv0CWe6Fi+dWUg+QwUzhxPuhEjT/J6XbuR1v14rXzF9ymm5RSsS8aqzuc3ChKdKQDuo
         ZzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691426196; x=1692030996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZNcpOl8CEiyqW/ZOb/0XcvAH0YrJ+P7c3vLK34uSAU=;
        b=JjAjKbDeZO893tIgkR9/2K2GVtOchnw880mvLGo+xwXPDxxf2LEwiaXpoR9qxuD2Zp
         IfUaW60xxVUyxpQilWu0aGQePqiM2NjBkZu579qZgXzU6PSRf5cR9BNu1X5iwtybmziU
         DQFef0t4pr0UMYju30CLOsW30f06/eOUYjuEJrNy9FEkZdJkW6+sDunfF5R+Af9bYWCn
         duBRUI8h+f03/YL1qWLNOfnx4cUxZ/WD1wJD6Izwh91fWmjAdg3y2PFjuXaj5YAHv9c3
         epncSJ5rs/mRaQj59QDGLvbRHtka8AHVEZi5RbXczEnlFsYlv5kIo6msYhSYf1j9lK92
         e1Yw==
X-Gm-Message-State: AOJu0YxS0W68qAaSvksOxFLngM6Xb8HCC4+c3Bj61IKZnKWu9MFApcMt
        UU2XUW7U1YvOTUcwt48tNZqNCkSekrmZQ4IXKAM=
X-Google-Smtp-Source: AGHT+IG6xEN7hWZW963ar6a6y/IZv7TEMEGaFqOpr/N9QzXhbQky+esm5rTRkDEeHyn3BVgzlYOqaXCi0RXhkI/5nGE=
X-Received: by 2002:aa7:c7d9:0:b0:522:2711:863 with SMTP id
 o25-20020aa7c7d9000000b0052227110863mr9220038eds.1.1691426196109; Mon, 07 Aug
 2023 09:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230731084458.28096-1-ubizjak@gmail.com> <4d4dd1e8-042a-561a-4ffc-529638cb0780@csgroup.eu>
In-Reply-To: <4d4dd1e8-042a-561a-4ffc-529638cb0780@csgroup.eu>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Mon, 7 Aug 2023 18:36:24 +0200
Message-ID: <CAFULd4YByT++kV21nZGE+ME9B2KQtQYNRz6Ar2awoLws-JznUw@mail.gmail.com>
Subject: Re: [PATCH] locking/arch: Rewrite local_add_unless as static inline function
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jun Yi <yijun@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 7, 2023 at 6:13=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 31/07/2023 =C3=A0 10:42, Uros Bizjak a =C3=A9crit :
> > Rewrite local_add_unless as a static inline function with boolean
> > return value, similar to arch_atomic_add_unless arch fallbacks.
> >
> > The function is currently unused.
>
> Is it worth keeping the function if it is not used ?

We already have plenty of these kinds of unused locking functions in
arch/*/include/asm/atomic.h, so I thought we could leave this one as
well.

Uros.
