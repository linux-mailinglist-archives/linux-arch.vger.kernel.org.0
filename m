Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754D063B8B7
	for <lists+linux-arch@lfdr.de>; Tue, 29 Nov 2022 04:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbiK2D0j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Nov 2022 22:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbiK2D0h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Nov 2022 22:26:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3F0490B7;
        Mon, 28 Nov 2022 19:26:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02D5D6155E;
        Tue, 29 Nov 2022 03:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D771C43470;
        Tue, 29 Nov 2022 03:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669692395;
        bh=2wNwy6iThg3PjSBPSHqTNTq6DPiJNZ31+qv039KIXH4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K80F1J8UOo6eYH2e7bpYdMdoLxjnE/Jwv85+yc+I49z385mKbIV4m+uhp94ZaR1+S
         ETLr2/xInY+2CvSKFz3pvq5ablHqtiDZasWVvFFYLNMAhhhgfIpRLkoX8aZz6Dzgve
         h1DCS0Ad/suWRSZMbxS7Zny2yA/X63yleZM1vc0BnnHbxA262uUQ4LI8A9rTALh6iI
         oQyULI2fHwmTfinWq8lyiavyMErMd8Fn1gohCqTvRZ9r5i64twIK1jTJkmtwnmVe/v
         h57RW9mY+r6vEfCcOf6gUZnj1GmtrbMQvUMHGULoLHdzzTIMHDCBA7Ft9n+SDkRVwi
         TaN/6XenKdLuA==
Received: by mail-ed1-f45.google.com with SMTP id m19so16836514edj.8;
        Mon, 28 Nov 2022 19:26:35 -0800 (PST)
X-Gm-Message-State: ANoB5plh6Cf1PEjlwu+/XKXJTi09426WG2GP5j6drFKOlQwwyZ/jcmEg
        sg48fy5myM6h1WADydgFEHujJR/+FCkg7AIlh3Y=
X-Google-Smtp-Source: AA0mqf5i6CvvZTeiTvO8vt+TXfnjgmW3rqRqazHO+w1V3Gb2yVa6G2VdOFt1+sVzGUtAoXGJYrnfcv/T0FURzu78BoQ=
X-Received: by 2002:a05:6402:5003:b0:462:a25f:f0f2 with SMTP id
 p3-20020a056402500300b00462a25ff0f2mr50000667eda.156.1669692393478; Mon, 28
 Nov 2022 19:26:33 -0800 (PST)
MIME-Version: 1.0
References: <20221027125253.3458989-1-chenhuacai@loongson.cn>
 <CAAhV-H4Y5qHSXr2uHvMYpXMgvm5fU7WQmcALB+86OYkgM1XbOg@mail.gmail.com>
 <b9c0711c-6efc-4d84-af4e-62e585ac2fa6@app.fastmail.com> <CAAhV-H7PifGc7jEmVURVYHXLdrKBGdRecjjLwOekeqS_cEXkxw@mail.gmail.com>
 <20221128151005.916e4373cd4e5808111dea0c@linux-foundation.org>
In-Reply-To: <20221128151005.916e4373cd4e5808111dea0c@linux-foundation.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 29 Nov 2022 11:26:21 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4cYHJe15oK=3RypmH+FiEuA+KovftXpOgbHy2Rz6uH9Q@mail.gmail.com>
Message-ID: <CAAhV-H4cYHJe15oK=3RypmH+FiEuA+KovftXpOgbHy2Rz6uH9Q@mail.gmail.com>
Subject: Re: [PATCH V14 0/4] mm/sparse-vmemmap: Generalise helpers and enable
 for LoongArch
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>, loongarch@lists.linux.dev,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, guoren <guoren@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mm@kvack.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Feiyang Chen <chenfeiyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 29, 2022 at 7:10 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Sun, 27 Nov 2022 13:01:19 +0800 Huacai Chen <chenhuacai@kernel.org> wrote:
>
> > Hi, Andrew,
> >
> > On Tue, Nov 15, 2022 at 4:09 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Sat, Nov 12, 2022, at 11:26, Huacai Chen wrote:
> > > > Hi, Arnd,
> > > >
> > > > Just a gentle ping, is this series good enough now? I think the last
> > > > problem (static-key.h inclusion) has also been solved.
> > >
> > > Yes, this looks fine to me. Sorry I didn't have this on my
> > > radar any more.
> > >
> > > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > >
> > > I guess the series should be merged through Andrew's linux-mm
> > > tree. Let me know if for some reason I should pick it up into
> > > the asm-generic tree instead.
> > Another gentle ping, can this series be merged to linux-mm in the 6.2 cycle?
>
> It's a pretty large patchset and I'm a bit concerned about the amount
> of review and test which it has received from the MIPS side?
We have tested on MIPS-based Loongson. :)

>
> Prudence suggest that we merge this in 6.3-rc1.  But I'll queue it up
> for now, get a bit of testing while we consider this.
>
OK, thanks, you are free to decide this.

Huacai
