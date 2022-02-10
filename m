Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950034B09D2
	for <lists+linux-arch@lfdr.de>; Thu, 10 Feb 2022 10:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238968AbiBJJqe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 10 Feb 2022 04:46:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238777AbiBJJqd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Feb 2022 04:46:33 -0500
X-Greylist: delayed 309 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 01:46:34 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF511A7
        for <linux-arch@vger.kernel.org>; Thu, 10 Feb 2022 01:46:34 -0800 (PST)
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MA88C-1nTfkU014k-00BYfr; Thu, 10 Feb 2022 10:41:24 +0100
Received: by mail-wr1-f42.google.com with SMTP id k18so8410970wrg.11;
        Thu, 10 Feb 2022 01:41:23 -0800 (PST)
X-Gm-Message-State: AOAM532FlZbzThx9zWPgYSmUFoDGJC+hFyS/v5J9R9p3sn2ApYzDZ5x/
        Sas5baxFJwnIk2DNNyhzU/HFySxP3/sv7fmPsNc=
X-Google-Smtp-Source: ABdhPJwFAXHn/oxpkrKGkjNdQCVhvPPwJqoR18BfcNL1lEqEkdOenRkU6MzFWE9oH1War435497Ub7+zNJE6VpNe5D8=
X-Received: by 2002:adf:e5ce:: with SMTP id a14mr691958wrn.317.1644486083668;
 Thu, 10 Feb 2022 01:41:23 -0800 (PST)
MIME-Version: 1.0
References: <20220210021129.3386083-1-masahiroy@kernel.org> <20220210021129.3386083-6-masahiroy@kernel.org>
In-Reply-To: <20220210021129.3386083-6-masahiroy@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 10 Feb 2022 10:41:07 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3biD8Fmd2GMTkwPtU1ezinvyvbBZqey0cAiJh4_5svKQ@mail.gmail.com>
Message-ID: <CAK8P3a3biD8Fmd2GMTkwPtU1ezinvyvbBZqey0cAiJh4_5svKQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] kexec.h: add linux/kexec.h to UAPI compile-test coverage
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:ehHi4GhNJ7W0pBtKH6PXaACeiIpDdyufnrP9Kn4RSrxY28y506Y
 tv9ROIN7wsDt+fkuc5im9FXCHrt9coUqTp3xS9sWgFw+iTVimamqcQgewNppZi1G3ClkwZW
 xugVn7mWYP6SWeR6MrYmS9BMtbcJnmI5hl1No4L9BGvXOdlfxLE39JGiB3h2vgLq4htBNdU
 +jNNPTtNf61R3gOmmRw+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7ScsKC1nxzo=:222LMN1bT7TviN5PhhGGVX
 ARcddAIuywx6Tif+RiRINGOFpci+iPPcdYzqlfR5J9smBO57UoHLogIAdWnjz9O1yJyoPE5tG
 qoO+f0No7Pk4oQveOxCEYWpnMSlSJIHY11SqJ+adjat2a3VNEAasWaEoBwN9zZhUUp4B3z3QT
 wZ1f7ssZB+ZIAb1Yqedjn1DRd2plA8H/rDE3Vc9ARNukfD0ovNZ4p8pbkk389pWGslDi2ZluN
 c1C6/+gyfzr2UcHTRsWQpptFDvZ1zTxSjW/lD1QRY5JaB5iCJISkiLKBUg3iTpJr+lfNocKuj
 EbcyFSunX8LyIIC8GKbsVFKKqWXI6W0EDBADC3KQfdyJ2WZE5YQT63sHDDb6p1qQDSIZPlp8Z
 CPP7Il135ir2PB4xFILzPD6FO5MCGNeM5Imkc+ldEyq70C7JrjQoDRvwISL9u1b5jiBarkiOP
 Qx5qJhUZjy9Dr17BpHK6upmErjNNEgGJWqusNRDzMyfrI/RJeJnHwOuOFWTUpj+eozvOCEKtg
 PKHtMNZiYgYbrvAXnMQepwdE7Udfq4JaRLfSoW2yHmmxyazcXj44KOX8YarefQpZnCgvBgD78
 7SLL0kwdvJjutlxpNwwhud646+4FfQaluHTxduSQunJ3IdKGAK+Bcv9eRHCu8Tf02npk+TbKo
 QBbxlz6jODi4X7NNaz3LkNI08cuLBpul1baKmKRZRkdoJQEF1ldRRZjrZMyY42GlKbe4S9fuR
 bDedaraqjSYLNL9CPehs9hlbWjCF1nV4P1O1Kq4t5FhLhlWAwVlIie8RYiitFdtaOwj8IrBOJ
 syoca3I5VfAZgh88agai7NI1X5WtaHvHo1UgWm9gmFlsa56vO0=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 10, 2022 at 3:11 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> linux/kexec.h is currently excluded from the UAPI compile-test because
> of the errors like follows:
>
>     HDRTEST usr/include/linux/kexec.h
>   In file included from <command-line>:
>   ./usr/include/linux/kexec.h:56:9: error: unknown type name ‘size_t’
>      56 |         size_t bufsz;
>         |         ^~~~~~
>   ./usr/include/linux/kexec.h:58:9: error: unknown type name ‘size_t’
>      58 |         size_t memsz;
>         |         ^~~~~~
>
> The errors can be fixed by replacing size_t with __kernel_size_t.
>
> Then, remove the no-header-test entry from user/include/Makefile.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
