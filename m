Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB1F5895D6
	for <lists+linux-arch@lfdr.de>; Thu,  4 Aug 2022 04:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237259AbiHDCKC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Aug 2022 22:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiHDCKB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Aug 2022 22:10:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDCD5F9A8;
        Wed,  3 Aug 2022 19:10:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7ED38B82398;
        Thu,  4 Aug 2022 02:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F19C43143;
        Thu,  4 Aug 2022 02:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659578998;
        bh=fUku56VQ2QJ/iS0vukKD33SzPJmyHQRWdFJILjyWgdA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XbBugSmWJvnJ/F0sEnNDkbqI7NQrMy3jdjQbJ80MHgMUwTr0vRtcP+B1CaiS4WxBu
         Hx7mgaJJGqh0U3+ZPHOu2StmBipPmhV/VjxZuZsTQXMEoqEXUX9N5AsEJ8nqZcugsz
         Jd7wcLFvhxueZzeRljkup0+sWkQ6KQ82weBGGAsJMMRYGCkikTniYAJZyiLbKgrATH
         EZ5k/+29P6nAnXF3PaeT/RnnMsEUldxKAL0Wx6VnduGe54+JdRLTB1xS5xXwx4bANV
         f6rLKoY3O+QCR9sCYeMDxL0RROQi4c+gyGJ1KTT3FrwetDUcitEATybAbh1QbzE+lJ
         qYR28iqSO/ANg==
Received: by mail-oi1-f180.google.com with SMTP id u190so1683322oie.3;
        Wed, 03 Aug 2022 19:09:58 -0700 (PDT)
X-Gm-Message-State: ACgBeo3hRWzCn1MKBZjCNaXku9friZJixcH0cTVhjSoDptxq+peVYgRB
        f6mPmS2aVuqDEg/BnB4lhT+aI6CdPyKBY8SvuZg=
X-Google-Smtp-Source: AA6agR4+z8qNh9gQH5GYsp/nQ60cgGpjBe6+LMaLKEYQwTGENsFDC/lucJe1wCE0kICaI6NGXcudgjmukq14S+LsnGo=
X-Received: by 2002:a05:6808:1a26:b0:33a:76f6:fc19 with SMTP id
 bk38-20020a0568081a2600b0033a76f6fc19mr2862221oib.19.1659578997421; Wed, 03
 Aug 2022 19:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220613013051.1741434-1-guoren@kernel.org> <20220613142947.GA4110@lst.de>
In-Reply-To: <20220613142947.GA4110@lst.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 4 Aug 2022 10:09:44 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQtnMoeb62-63Ou8y4DBrdYM7iztdtfLuXX9U0LTWUHLA@mail.gmail.com>
Message-ID: <CAJF2gTQtnMoeb62-63Ou8y4DBrdYM7iztdtfLuXX9U0LTWUHLA@mail.gmail.com>
Subject: Re: [PATCH] uapi: Fixup strace compile error
To:     Christoph Hellwig <hch@lst.de>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Eugene Syromiatnikov <esyr@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 13, 2022 at 10:29 PM Christoph Hellwig <hch@lst.de> wrote:
>
> The change looks fine, but the commit log could use some work, please
> move the notes from the back to the front and make them a standalone
> commit log and just drop the rest.

Okay.

-- 
Best Regards
 Guo Ren
