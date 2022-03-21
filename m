Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639314E2291
	for <lists+linux-arch@lfdr.de>; Mon, 21 Mar 2022 09:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343500AbiCUIy4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Mar 2022 04:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240765AbiCUIyz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Mar 2022 04:54:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB3A3CA67;
        Mon, 21 Mar 2022 01:53:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C1F361166;
        Mon, 21 Mar 2022 08:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4192C340F2;
        Mon, 21 Mar 2022 08:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647852809;
        bh=U2Ovm8ntcG6XtGmB1msmTfFNN3ysz5JeGnJ11m8KPWA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t1ZPR+JjQZJDXK527T7aciTdnEJplNDW7uaduQA4+TeNAIjcPTXQ1y2tFjTdHGoAH
         MDp+U1RIWvrktWZlM2hGpSAStqCZNMrKdH391wZ80nVLMrjuQbCbkR5RgnMzN+L+Y5
         VznBqAEnO1aA51civ+Sf6blc33EiDuEQPffKqIooT+kSXXOyekogDTDtjOPn0aClHs
         NF8L4BX2t6JZwq2dr5FMBHcMZjbUa1piR6+5CAYL/Ri2FsNHP/EsIyZZEI5IGcKg94
         EbIm3Y50Xu9eSxKcg6XW6u02MhEIOS+5RIrpTqq37IiRzEAyC2BhixBtYpKVEaQrHu
         jDhoI4o3WYv8g==
Received: by mail-ua1-f51.google.com with SMTP id t40so5179941uad.2;
        Mon, 21 Mar 2022 01:53:29 -0700 (PDT)
X-Gm-Message-State: AOAM533QGJShKMJJEQCbWnc9gMgU7QAwo2Z6Fd77Th9QZe68+687xYEu
        0PJ1b4X5FOozcaZ6jIbXaIhwxhiZ2FlmL8KlH2w=
X-Google-Smtp-Source: ABdhPJwvWzWeFCt9MQpdxmPAWk8GoAGAd6IR8abJAWJLuqH0wSI5SrmxBLkNkoXsJmZZYCaqq9Hcc7WStQXsiKGWNQo=
X-Received: by 2002:ab0:6544:0:b0:352:ec5d:b570 with SMTP id
 x4-20020ab06544000000b00352ec5db570mr6089068uap.96.1647852808843; Mon, 21 Mar
 2022 01:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220319142759.1026237-1-chenhuacai@loongson.cn>
 <20220319143130.1026432-1-chenhuacai@loongson.cn> <20220319143130.1026432-5-chenhuacai@loongson.cn>
 <CAK8P3a3ycOKLvKunyatRETN0n3=D+=Y-EZF3aYH95G5WF8M7bg@mail.gmail.com>
In-Reply-To: <CAK8P3a3ycOKLvKunyatRETN0n3=D+=Y-EZF3aYH95G5WF8M7bg@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 21 Mar 2022 16:53:20 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6jDDFNvaEp6P1abFtf7zcvzT1xXFnp8wYBbn9-i4t59A@mail.gmail.com>
Message-ID: <CAAhV-H6jDDFNvaEp6P1abFtf7zcvzT1xXFnp8wYBbn9-i4t59A@mail.gmail.com>
Subject: Re: [PATCH V8 05/22] LoongArch: Add build infrastructure
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Mon, Mar 21, 2022 at 4:31 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Mar 19, 2022 at 3:31 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> > This patch adds Kbuild, Makefile, Kconfig and link script for LoongArch
> > build infrastructure.
>
> Looks good, but I spotted one detail:
>
> > +       select HAVE_FUTEX_CMPXCHG if FUTEX
>
> HAVE_FUTEX_CMPXCHG no longer exists, everyone supports it now,
> so you should drop this line as well.
Thanks, this will be removed.

Huacai
>
>        ARnd
