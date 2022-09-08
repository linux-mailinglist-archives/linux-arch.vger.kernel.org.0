Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045915B124B
	for <lists+linux-arch@lfdr.de>; Thu,  8 Sep 2022 04:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiIHCBv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Sep 2022 22:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiIHCBu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Sep 2022 22:01:50 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D147B2BF;
        Wed,  7 Sep 2022 19:01:49 -0700 (PDT)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 28821XjL012230;
        Thu, 8 Sep 2022 11:01:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 28821XjL012230
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662602494;
        bh=6Y1Bya3aPZIeSCr6IhdukpsTZDl2mHIQOZnpZe9hjBU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hC6w73/jbQba9O4cZKC0LRYCxDjbEM7J4YwUZ+TXWkQ6p+n1ytM22WZ+1NNPqOUrq
         ZtDzyIpKPB2UGdcOFYc3TIZ/3OIZCA519hrGV/3vCt/ef+hGI50ch/xJyGYvW5M4mO
         l1g6cqI4BkcKuoWzvynpDu3v9hv1KFHUce5+W/A5ACyvxPdfHuZnnEiHzfG3Y+vasj
         kLski423IKrQiQh0RGx9esWdiyt0axCXTcxFs9G0NGhdkMh2SxmmtLB1UJSsdoeMOi
         XttpO2B3Na0Pm8PuS/F84vEvl3+NKW3SE0NWYBBnYzHeOik6pkGyY2EXmGhwQtxstP
         SGapoNPOx+Q7g==
X-Nifty-SrcIP: [209.85.161.45]
Received: by mail-oo1-f45.google.com with SMTP id c9-20020a4a4f09000000b0044e1294a737so2744625oob.3;
        Wed, 07 Sep 2022 19:01:33 -0700 (PDT)
X-Gm-Message-State: ACgBeo2xwQWhlJyGe8tgJDwOsixTqNKCVQ5ZezKH+7rvTUXM6/ObnRGK
        abimIXtgkrH8LqJ6n/DK1hsSrMtWZEcIYb2ZUDs=
X-Google-Smtp-Source: AA6agR5LEebdg5DlSdHbvjogjPHbIZgd4TjczzfDaGtjQ3D+KX3gf7+iYfPULy+rgzHwPdEJkWdG1FpOt2ozkzowVUw=
X-Received: by 2002:a4a:9789:0:b0:451:437b:cc58 with SMTP id
 w9-20020a4a9789000000b00451437bcc58mr2283450ooi.96.1662602492951; Wed, 07 Sep
 2022 19:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220906061313.1445810-1-masahiroy@kernel.org>
 <Yxj7/WxCcdIuEHG6@bergen.fjasle.eu> <Yxj8lTPByGnahpWq@bergen.fjasle.eu>
In-Reply-To: <Yxj8lTPByGnahpWq@bergen.fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 8 Sep 2022 11:00:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQuJibnWaseXVwc9eLAeQkj6AhyxVk-YHeRgEi7vjNBjg@mail.gmail.com>
Message-ID: <CAK7LNAQuJibnWaseXVwc9eLAeQkj6AhyxVk-YHeRgEi7vjNBjg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] kbuild: various cleanups
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 8, 2022 at 5:18 AM Nicolas Schier <nicolas@fjasle.eu> wrote:
>
> On Wed, 7 Sep 2022 22:15:57 +0200 Nicolas Schier wrote:
> > On Tue,  6 Sep 2022 15:13:05 +0900 Masahiro Yamada wrote:
> > >
> > >  - Refactor single target build to make it work more correctly
> > >  - Link vmlinux and modules in parallel
> > >  - Remove head-y syntax
> > >
> > >
> > > Masahiro Yamada (8):
> > >   kbuild: fix and refactor single target build
> > >   kbuild: rename modules.order in sub-directories to .modules.order
> > >   kbuild: move core-y and drivers-y to ./Kbuild
> > >   kbuild: move .vmlinux.objs rule to Makefile.modpost
> > >   kbuild: move vmlinux.o rule to the top Makefile
> > >   kbuild: unify two modpost invocations
> > >   kbuild: use obj-y instead extra-y for objects placed at the head
> > >   kbuild: remove head-y syntax
> >
> > I'm not able to apply the patchset, neither on your current kbuild
> > branch nor on for-next.  What am I missing here?  Could you give me a
> > hint for a patchset base?
> >
> > Thanks and kind regards,
> > Nicolas
>
>
> ooops.  It _is_ already on kbuild, sorry for the noise.


Yes.
If you are happy to review and/or test the branch,
I will add Reviewed-by/Tested-by when I rebase it.




-- 
Best Regards
Masahiro Yamada
