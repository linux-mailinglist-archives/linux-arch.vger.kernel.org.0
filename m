Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FB5719205
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jun 2023 06:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjFAE7B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Jun 2023 00:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjFAE7A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jun 2023 00:59:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DB2125;
        Wed, 31 May 2023 21:58:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 628FA60A4B;
        Thu,  1 Jun 2023 04:58:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A9BC433A4;
        Thu,  1 Jun 2023 04:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685595538;
        bh=oy+X/QJ3AfHmQ6ri3oCJZOqvE65HhGdDFqeIhvw+j2w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cGspRzDXsJ+v96uxCgHPr/fCogXpgNBasA0a0CnaPzD7cF0M69b/DdT8w205r8vVS
         G9t7oxTm8ZpTJESvfJN62tn8wv8i1WoH7OchVRxL+Ajf3/hyscSOX3vD4ZBsR5VTQd
         Y170qv9lfaLjV09gwZc8HzCYTsiXUI3jVsW2hTRwglOIf2OuXF+WBLT2YH1qmZlJT9
         2VJ/nGfQrY/SkMlNuEeRZDxoaBqiyQM4lMGgT180TrxvB82HGTPdJLQEuBAklxfFpP
         hGnnRDa4Ip4P1QKHyuV6r5yoIIYjBxWzZucX4ZYCrcHVy/NBp95GDDo/peZRBYUD5O
         33wtoTiIlMJWw==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5149b63151aso684509a12.3;
        Wed, 31 May 2023 21:58:58 -0700 (PDT)
X-Gm-Message-State: AC+VfDyEv/nk2Asjmz07P0zf+A3XxaY3BS4X3VG0nzpr4GTtUxwcpSrR
        o7p8ux0hdwSUtrplmy50v2QUyJVWNOk8F8OMgvI=
X-Google-Smtp-Source: ACHHUZ4VH8QZzGD0vgHngiLn8kY9qiolxuEmItJ/iPkVQJfez9e0G79jdsMCAJfKfVfjnw+gwizmiu/fiLhzz3PYeZM=
X-Received: by 2002:aa7:df0e:0:b0:514:9248:d1dd with SMTP id
 c14-20020aa7df0e000000b005149248d1ddmr5631785edy.24.1685595536880; Wed, 31
 May 2023 21:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230511141211.2418-1-jszhang@kernel.org> <20230511141211.2418-4-jszhang@kernel.org>
In-Reply-To: <20230511141211.2418-4-jszhang@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 1 Jun 2023 12:58:45 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSCLLviJ_JzjetU3ajRQtU+L7epeWOOVOeN_pqrfhKLHg@mail.gmail.com>
Message-ID: <CAJF2gTSCLLviJ_JzjetU3ajRQtU+L7epeWOOVOeN_pqrfhKLHg@mail.gmail.com>
Subject: Re: [PATCH 3/4] vmlinux.lds.h: use correct .init.data.* section name
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 11, 2023 at 10:27=E2=80=AFPM Jisheng Zhang <jszhang@kernel.org>=
 wrote:
>
> If building with -fdata-sections on riscv, LD_ORPHAN_WARN will warn
> similar as below:
>
> riscv64-linux-gnu-ld: warning: orphan section `.init.data.efi_loglevel'
> from `./drivers/firmware/efi/libstub/printk.stub.o' being placed in
> section `.init.data.efi_loglevel'
>
> I believe this is caused by a a typo:
> init.data.* should be .init.data.*
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Seems it's a fixup for all architectures, what's the Fix: tag?

> ---
>  include/asm-generic/vmlinux.lds.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmli=
nux.lds.h
> index d1f57e4868ed..371026ca7221 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -688,7 +688,7 @@
>  /* init and exit section handling */
>  #define INIT_DATA                                                      \
>         KEEP(*(SORT(___kentry+*)))                                      \
> -       *(.init.data init.data.*)                                       \
> +       *(.init.data .init.data.*)                                      \
>         MEM_DISCARD(init.data*)                                         \
>         KERNEL_CTORS()                                                  \
>         MCOUNT_REC()                                                    \
> --
> 2.40.1
>


--=20
Best Regards
 Guo Ren
