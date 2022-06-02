Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A13D53B60A
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jun 2022 11:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbiFBJ1H (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jun 2022 05:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbiFBJ1E (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jun 2022 05:27:04 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69042A46CD;
        Thu,  2 Jun 2022 02:27:01 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id q203so4280967iod.0;
        Thu, 02 Jun 2022 02:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C+EMAmeFZRp3TpuWkCRyv9pKB/CTk056YS87itpmWkg=;
        b=D+SU6LNlQnSn/HNiKiYSBUr4ljM0Q/WxPuIdSALbrS/aSUy5MFA0RQcdgV/76jyqW5
         CkMAQFqL2Ib2gRHa3G6yfytEFENO+cAnH1ucAtIRyBGKg8/WOOtmBAsZJJfGXBOoT6WR
         oQPAYCqYm5UEDFMRTKPRr1+E0UTzWpp0MZcLZPMWNaQ0J35dgJgXeO7OK7gA9gP2G2E8
         EJGvb0cJQAygIMGW8+0WTw7PHNiJdFQHyHMkebCT6OLpNTwkP3FxQHquGChIB9A0XoEC
         HLIxPiOxBczJj15khy+QfouuTbFrIPZivLu3OPqNgKd3Ns8hgk7HL8O0XjdV2TPON2m2
         Htaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C+EMAmeFZRp3TpuWkCRyv9pKB/CTk056YS87itpmWkg=;
        b=iGsmzZvD50F5N36PVkLC3Npq0TUANQ2XOyL3uKIRPbHw9+Q7CmTlN/HYQE9A0ypQkk
         nPW1VEMqjGkUu8rErWWdZUikqwwEJWLQbr/WesVgAEsZFl6Y8v8k9zddRxmb5vnl6edk
         VrEZAMSYwhdQ1yrhn2HfY2wMF3xCVVI1DJx26eJF5WstpL9V7ivEzZqr1mN2WMdFhZct
         wYsKqvYm9XqNtLIKLKDhMzIY5pXP5qBF1/HdKzcDYi14PkX9p/sUsIrlGgMl+Ls+/8kH
         BZsmmyOmW6VZBu2q7A7OU5RTFCojtrJh+z/8aTiTKI9Su0lCydkKSOslZc6dcCaj0iLS
         EzDw==
X-Gm-Message-State: AOAM532z8ecVX5fUyJWozB0ZWKXKHdjG4me3Cf7rf9DZvkN4czsQP+H1
        U0YzdnjyOrc4HkAiMmBCmI28PTOU91SS9ysGPt0=
X-Google-Smtp-Source: ABdhPJwlpWpdB/ytI31JwutxbVKBoDGmOXA6+bkbvuq/cwiSYf170f4WOIXhJkFkQDVZTPOv1JFevXIUlVGkIuhangg=
X-Received: by 2002:a5d:9d8c:0:b0:664:afc8:64df with SMTP id
 ay12-20020a5d9d8c000000b00664afc864dfmr2090581iob.42.1654162021097; Thu, 02
 Jun 2022 02:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220601100005.2989022-1-chenhuacai@loongson.cn>
 <20220601100005.2989022-4-chenhuacai@loongson.cn> <Yph/Q+szVkhDPg4a@debian.me>
In-Reply-To: <Yph/Q+szVkhDPg4a@debian.me>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 2 Jun 2022 17:26:51 +0800
Message-ID: <CAAhV-H4MeVyT1TVx6gfaYaPU3oNSLUyr4iJpt0-FRCNzPf=jfw@mail.gmail.com>
Subject: Re: [PATCH V12 03/24] Documentation: LoongArch: Add basic documentations
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        WANG Xuerui <git@xen0n.name>
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

Hi, Bagas,

On Thu, Jun 2, 2022 at 5:13 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On Wed, Jun 01, 2022 at 05:59:44PM +0800, Huacai Chen wrote:
>
> > +Note: The register ``$r21`` is reserved in the ELF psABI, but used by the Linux
> > +kernel for storing the percpu base address. It normally has no ABI name, but is
> > +called ``$u0`` in the kernel. You may also see ``$v0`` or ``$v1`` in some old code,
> > +they are deprecated aliases of ``$a0`` and ``$a1`` respectively.
>
> A nitpick: instead of just comma (,), also use "however" conjunction, that
> is "You may also see ..., however they ... ."
OK, thanks.

Huacai
>
> > +
> > +Note: You may see ``$fv0`` or ``$fv1`` in some old code, they are deprecated
> > +aliases of ``$fa0`` and ``$fa1`` respectively.
> > +
>
> The nitpick above also applies here, too.
>
> Otherwise, htmldocs built successfully without any new warnings.
>
> Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
>
> --
> An old man doll... just what I always wanted! - Clara
