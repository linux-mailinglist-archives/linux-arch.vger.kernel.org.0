Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828CC59B78C
	for <lists+linux-arch@lfdr.de>; Mon, 22 Aug 2022 04:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbiHVCTi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 21 Aug 2022 22:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbiHVCTh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 21 Aug 2022 22:19:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D983DDEC9;
        Sun, 21 Aug 2022 19:19:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74C4360F12;
        Mon, 22 Aug 2022 02:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE11DC433B5;
        Mon, 22 Aug 2022 02:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661134775;
        bh=Zpk6Rxu700+dm/MkUInp0fC7Hlw+3o59RXo2zuERj0U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FfVMuzxfJNd6CSHWL3L6vvyrG29BhL3D6t0S/y6HBR97Rb4ybt4WaFhjqcabUYb9k
         7mEeojBh8JIhCkTYbSqMa1nfjg7XK+zfrxtWcz3FtGUipAFc8zIWi3BOd+e/BYi4Ii
         ILc9pybHjCPZvy+jXwdk0Ww0GLM+8CRNrgrhvMa9eV4Fn8ELa7/8HqlClBBB2NDD+L
         hNP/LlGvSo1nV97qwTvdCQDkWs5loZhSxPtJogaP06zZzaZgatb6fABLRqX8KtWKea
         ubAE5pbrW10jIig9wDF9uftLq71Uyy8sB5oKz60WW0whLCUXvbjim5r/v6uvMi2Ho9
         +oyOUKrqbu/6w==
Received: by mail-vk1-f176.google.com with SMTP id 134so1225859vkz.11;
        Sun, 21 Aug 2022 19:19:35 -0700 (PDT)
X-Gm-Message-State: ACgBeo3f4JdZp8QKnDdZBF6ll4qBOGvxeOGkzkqrGZ5RSn9UYXPDbHRB
        968gOYhzkyXytPhJwaoDIMXCrteeXgXMD/aEZVM=
X-Google-Smtp-Source: AA6agR4RYFMtiBixf/mGUUCq8XBHJ3fm93bGawjKI/ZbmnXS+gWhgGjlNeQ3cTucBf/w6/xwzQdtC+IOuaD07o1+1Go=
X-Received: by 2002:a1f:9b90:0:b0:374:f09c:876f with SMTP id
 d138-20020a1f9b90000000b00374f09c876fmr6652088vke.12.1661134774631; Sun, 21
 Aug 2022 19:19:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220815124612.3328670-1-chenhuacai@loongson.cn> <YwIx1xoAmsp8cHMN@infradead.org>
In-Reply-To: <YwIx1xoAmsp8cHMN@infradead.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 22 Aug 2022 10:19:22 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5_bZa2oi6ZSvoMwz8FmJGL8+pg7iYjkT90YT6XTCNb5Q@mail.gmail.com>
Message-ID: <CAAhV-H5_bZa2oi6ZSvoMwz8FmJGL8+pg7iYjkT90YT6XTCNb5Q@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Use TLB for ioremap()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Christoph

On Sun, Aug 21, 2022 at 9:23 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Aug 15, 2022 at 08:46:12PM +0800, Huacai Chen wrote:
> > We can support more cache attributes (CC, SUC and WUC) and page
> > protection when we use TLB for ioremap().
>
> Please build this on top of the series that extents the generic ioremap
> code for these use cases instead of duplicating the generic ioremap
> code.
OK, let me try, thanks.

Huacai
>
