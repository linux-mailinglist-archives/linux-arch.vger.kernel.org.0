Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D99470117F
	for <lists+linux-arch@lfdr.de>; Fri, 12 May 2023 23:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbjELVsE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 May 2023 17:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239602AbjELVsD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2023 17:48:03 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BAF658E;
        Fri, 12 May 2023 14:48:02 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7577ef2fa31so2084258485a.0;
        Fri, 12 May 2023 14:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683928082; x=1686520082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktA0DPNP5CNQIjFJf+YrLVaDtly7+JfQEYIY1aBuK2A=;
        b=EpptMN9+Uga6hAcxAo2XzkvGGde8U7iZgqSZwup4gFk7ua2rwfBFWm657rBr2tzbl8
         alDpTk4rP4SwxS0++WAmPE4FdQWVm4/enEJ2mQ3J7ahbm+q5NhFo7RUTs7wUOrscZMox
         45eupQg0KhJwmEmfQY80h//uPbuUrGvgy+2S/kMV3ur3MjhthaKdkBj5g/zXWCaAa42F
         nlBJ5ENELKGgHvDXJ6O1MgCI5TkNz2MkLRmOh4ivwQL0KVMfgjcXf0CAUWx2Kaefsg2L
         rPMZHV59fzGHCt/miNVdcAi7XITRfBOYPKnI+nTBEP2ciUF+hg8YN/lZWQD5Nj0f53m5
         YpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683928082; x=1686520082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktA0DPNP5CNQIjFJf+YrLVaDtly7+JfQEYIY1aBuK2A=;
        b=i36IYFiU0ytePZ7pcIjov0x2AkeeuPbz7ORnwIOzT1owKwqt7rCp1nCSkJYqRTktgw
         S8PmdJIdpLOD6jK+FQp9ojTYZoeAuEn6XFqZyV4zS19CqXvPrCr2txjNvHPwaq9DFlQj
         l35lZy43rS7Q6mR46qgznqXKMLu0JZctdIIsQrQJYVCFgnUn+RQf5IBIsbrmzneEgObD
         hubIOgho6mndHB+e0nSCNY4c0gsC8jGFFF3HyQ6jXszlhtM71pZBYZiXoIwnt8Qhwsdx
         Fdq7pCPNFieRf/nj1UYY6aO2T84VW8/40lPlzgmbl/9hAhrhzjGF63ebv9nEm22qRPrN
         pKcA==
X-Gm-Message-State: AC+VfDxTMalHDRjfBc3zmUPIwk3ztahqCC0qpNWpSVdHqsM2xUv2Jdxh
        nuDrxA55bvMJik5eP5FkJpB/K4Xh3ylpg8eZFGk=
X-Google-Smtp-Source: ACHHUZ6Ds4tgg3tY2HwzC7rc3PEkzb8YK+RMc5PzxH8b2x7aIR5D0EBt3CAybWSjFJTCM+nRvm71yFLpXl19En8supA=
X-Received: by 2002:a05:6214:519a:b0:621:65de:f600 with SMTP id
 kl26-20020a056214519a00b0062165def600mr10970695qvb.1.1683928081711; Fri, 12
 May 2023 14:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230510195806.2902878-1-nphamcs@gmail.com> <20230511092843.3896327-1-nphamcs@gmail.com>
 <ZF4YEjiTOeu3jx+5@arm.com> <20230512141510.20075825899e3c869c5358ca@linux-foundation.org>
In-Reply-To: <20230512141510.20075825899e3c869c5358ca@linux-foundation.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Fri, 12 May 2023 14:47:50 -0700
Message-ID: <CAKEwX=P2VW_UfdxgLfYGOq1Bho+AtHt5pci+A7r95qJSSAEFtg@mail.gmail.com>
Subject: Re: [PATCH] arm64: wire up cachestat for arm64
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-api@vger.kernel.org, kernel-team@meta.com,
        linux-arch@vger.kernel.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 12, 2023 at 2:15=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Fri, 12 May 2023 11:42:26 +0100 Catalin Marinas <catalin.marinas@arm.c=
om> wrote:
>
> > On Thu, May 11, 2023 at 02:28:43AM -0700, Nhat Pham wrote:
> > > cachestat is a new syscall that was previously wired in for most
> > > architectures:
> > >
> > > https://lore.kernel.org/lkml/20230503013608.2431726-1-nphamcs@gmail.c=
om/
> > > https://lore.kernel.org/linux-mm/20230510195806.2902878-1-nphamcs@gma=
il.com/
> > >
> > > However, those patches miss arm64, which has its own syscall table in=
 arch/arm64.
> > > This patch wires cachestat in for arm64.
> >
> > You may want to clarify that this is for compat support on arm64,
> > otherwise native support uses the generic syscall numbers already.
>
> Thanks, I updated the changelog thusly.  Note that this patch is
> transitory - it will be squashed into "cachestat: wire up cachestat for
> other architectures".

It's my expectation too - it makes sense to squash it to the other patch.
Thanks, Andrew!
