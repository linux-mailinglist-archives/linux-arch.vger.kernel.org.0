Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E2554E0E2
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jun 2022 14:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiFPMeM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jun 2022 08:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359791AbiFPMeL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jun 2022 08:34:11 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD6751E4C
        for <linux-arch@vger.kernel.org>; Thu, 16 Jun 2022 05:34:10 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y32so1999098lfa.6
        for <linux-arch@vger.kernel.org>; Thu, 16 Jun 2022 05:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TcmjiftvmvstcVVvvRVC96LjLQUb9YXPsyorLZpT7Eo=;
        b=qhLeneM5IfLMq6+4CtNi+ecFfjQWnvkJeicJAimHxgtTT7+vPBKc2RchZH9p+wYdTD
         gMmFHIrevsoJGwvEysG0Bgu/NNM2miz97uOmyCdWH5koYymF8rzEEaIqr4arGIYve0oV
         6zBDSsvtf7R7jOPbN6xQ7yOtEtrajwCbex+Nny24SuYJbwJXPhIY3vts/IHGmE+JCOW1
         3IOwRVmh/zoCs7R7z1WzsLtKqqoZGSenaEjYbI/4cMamYyU9BrKLrTrB6Mv0DXEJxPln
         64Yh3jwH+FgRBBYA6ktvU7u7cjXvqR9zULWt8vsbPNSlXOnjcmVxaINh7LgMq3rq+yCZ
         wxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TcmjiftvmvstcVVvvRVC96LjLQUb9YXPsyorLZpT7Eo=;
        b=V89uUmr8q9OflTC+lusrrV5okUVWFFDIGyxlJRxGnSYj6vOuURTD/i2KHY396zbb6r
         8pwMSO3qAMqYjzwuGb1jJVohsptThUEdeUbYIQZ0eQDyvjTf6tOLbTjYwcHuf2pf6Brs
         2KV9pfjm/SARjvNFJqnZJRSFhBTTg8udd2aPwfu5NOMcvZqNzZG6wSdlwgLu9N2n84uj
         B3HydvqUC6PaMT4bxnNySoPoDsWHXAop3WfAPmbcS/+NG4l0+WtLLq367cOnHx9oa7PQ
         Wonpj7sKrhWNB+S4MTjuSEVoyGTrqEH7O2ZTikoJNXwwj0mS0aXPpVWy9BoqzdT1DzbX
         1lOA==
X-Gm-Message-State: AJIora/jJ5zFe++T3mIbYuaHBcts6f8zQSOP+nQcIIfNttFjWJwo44Aw
        Gbr8bwMHgWL9y+QZx98+1hMcA14sGbEOPoy0Yrk9G/WBUVlkxw==
X-Google-Smtp-Source: AGRyM1tQ8rUEgj2RZPiOje7V1yhvKo6lrBJQedfMEkmkj33ARiAh6lkPBtd6vdK9szIPiA2o2U85nF/g+uupa8H6/dE=
X-Received: by 2002:a05:6512:2398:b0:479:24aa:6454 with SMTP id
 c24-20020a056512239800b0047924aa6454mr2732604lfv.664.1655382849043; Thu, 16
 Jun 2022 05:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220616121456.3613470-1-chenhuacai@loongson.cn> <ab6e2213-0795-68d1-c596-3dae1e174421@xen0n.name>
In-Reply-To: <ab6e2213-0795-68d1-c596-3dae1e174421@xen0n.name>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 16 Jun 2022 20:33:58 +0800
Message-ID: <CAAhV-H7MPgKN1CUCZNDUL00_hyMrhVRxjNOXioZfbjYvS8favg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add maillist information for LoongArch
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        loongarch@lists.linux.dev, linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Xuerui,

On Thu, Jun 16, 2022 at 8:21 PM WANG Xuerui <kernel@xen0n.name> wrote:
>
> On 2022/6/16 20:14, Huacai Chen wrote:
> > Now there is a dedicated maillist (loongarch@lists.linux.dev) for
> > LoongArch, add it for better development.
>
> Obligatory English fixes:
>
>  > Now that there is a dedicated mailing list for LoongArch, add it for
> better collaboration.
>
> Is this version better? We have the list address below so I feel no need
> for duplicating it in the commit message.
Thank you, it is better, but I will keep the list address in the commit message.

Huacai
>
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   MAINTAINERS | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 1fc9ead83d2a..dba5e89527a2 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11590,6 +11590,7 @@ F:    drivers/gpu/drm/bridge/lontium-lt8912b.c
> >   LOONGARCH
> >   M:  Huacai Chen <chenhuacai@kernel.org>
> >   R:  WANG Xuerui <kernel@xen0n.name>
> > +L:   loongarch@lists.linux.dev
> >   S:  Maintained
> >   T:  git git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git
> >   F:  arch/loongarch/
>
> Otherwise LGTM. I should become the 4th subscriber shortly ;-)
>
> Reviewed-by: WANG Xuerui <git@xen0n.name>
>
