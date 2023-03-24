Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4546C7535
	for <lists+linux-arch@lfdr.de>; Fri, 24 Mar 2023 02:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCXBvl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 21:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCXBvk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 21:51:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74B322103;
        Thu, 23 Mar 2023 18:51:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6115162926;
        Fri, 24 Mar 2023 01:51:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B646AC433D2;
        Fri, 24 Mar 2023 01:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679622698;
        bh=562mzg4DKxEFcXpT10oV3Fv8EOb4PoGIVjP7MJVtugI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hOvjAJSqrY6VAyDbWUNOwN9iOCKw52nN7MQG521xAhJwr1jyZ91oxsA4HicDtp9BR
         oFrSmf6O1xZ6OW1F2M+84NbRl42pwgGwmOsq9XmOuFl+sJk7v9xJKWTs0K/tfdEq/N
         OPagqeNvn1gBOgfPlHWI1DO9K3RV2z8mK87TQd72v5PM3yMp7t5/NhinIOy/RlQXRa
         4OgvWzFIqekVoGpKj8lGfcwnyG2RJOk6It/hX6iK1kr7Nbjp/Bf6UJm+ItP2oX+4L4
         7/4eTFLInyh15fPjT90FKo16AcTH3A6vM9WxlQhcMrfZcYHjHeycN01t9IVXqhAJJe
         HbcpZunC1dBfA==
Received: by mail-ed1-f42.google.com with SMTP id ek18so2269363edb.6;
        Thu, 23 Mar 2023 18:51:38 -0700 (PDT)
X-Gm-Message-State: AAQBX9fpmaJV8v0TDqR/1ItNb2wpQrlXgsW2EmaD4An2P65k6oO882w/
        AQywY88Ds7xG9mk2eCKgDQKK4EreuWRnvYW8o58=
X-Google-Smtp-Source: AKy350a8ZsoaLtzsT+Jmiama3H0sRDs5CyX0uD1V0/Lvmf7UCZqwH3Gl3UzK4SQj1HbLPDciHeCFNeooe7RuIn/BqyY=
X-Received: by 2002:a50:a6d7:0:b0:4fa:71a2:982b with SMTP id
 f23-20020a50a6d7000000b004fa71a2982bmr528130edc.0.1679622697009; Thu, 23 Mar
 2023 18:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230222033021.983168-1-guoren@kernel.org> <20230222033021.983168-2-guoren@kernel.org>
 <87ilesu9mr.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87ilesu9mr.fsf@all.your.base.are.belong.to.us>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 24 Mar 2023 09:51:25 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQHk_RxLuCkO+pxnaGj_iR5WNyxfRJgpDf5r-yNVccA-A@mail.gmail.com>
Message-ID: <CAJF2gTQHk_RxLuCkO+pxnaGj_iR5WNyxfRJgpDf5r-yNVccA-A@mail.gmail.com>
Subject: Re: [PATCH -next V17 1/7] compiler_types.h: Add __noinstr_section()
 for noinstr
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, ben@decadent.org.uk,
        palmer@dabbelt.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 22, 2023 at 10:46=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kerne=
l.org> wrote:
>
> guoren@kernel.org writes:
>
> > From: Lai Jiangshan <laijs@linux.alibaba.com>
> >
> > Using __noinstr_section() doesn't automatically disable all
> > instrumentations on the section. Inhibition for some
> > instrumentations requires extra code. I.E. KPROBES explicitly
> > avoids instrumenting on .noinstr.text.
>
> Guo, the generic entry series doesn't apply cleanly on
> riscv/for-next >6.2-rc1, and this patch is the issue.

It has been merged in palmer/for-next.

Thx for taking care.

54b3948f381c (HEAD -> for-next, palmer/for-next) Merge patch series
"riscv: Add GENERIC_ENTRY support"
45b32b946a97 riscv: entry: Consolidate general regs saving/restoring
ab9164dae273 riscv: entry: Consolidate ret_from_kernel_thread into ret_from=
_fork
0bf298ad2b61 riscv: entry: Remove extra level wrappers of
trace_hardirqs_{on,off}
f0bddf50586d riscv: entry: Convert to generic entry
d0db02c62879 riscv: entry: Add noinstr to prevent instrumentation inserted
8574bf8d0ddd riscv: ptrace: Remove duplicate operation

>
> Could you do a respin (potentially w/o this patch)?
>
>
> Cheers,
> Bj=C3=B6rn



--=20
Best Regards
 Guo Ren
