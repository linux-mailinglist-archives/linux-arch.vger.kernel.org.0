Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388F1639956
	for <lists+linux-arch@lfdr.de>; Sun, 27 Nov 2022 06:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiK0FBi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 27 Nov 2022 00:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiK0FBh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 27 Nov 2022 00:01:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D694C13F0A;
        Sat, 26 Nov 2022 21:01:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A637B80AE1;
        Sun, 27 Nov 2022 05:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBE6C43147;
        Sun, 27 Nov 2022 05:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669525293;
        bh=BcVxCBSSJcipAEV/aBmW/z7LTxZcFoSl+z5RqrQwQRM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ec57qBrMZ1hUgOhD5s2WrKXz0ZAlqGnDJaNH0v9Ae2hVvRCIPUjAz7OlV0iLlvlRY
         1nWnPDX9kYgB8EyULaHl1OI8KOn/DIXPSGUbzPFbuhUQ9qYa/MwDHJ/QIIqJD0Cx5Y
         L41AwIK8/udrfg9z0xZAOi+1gDg5fEm6HcnT6AuFKMq9P0g22ZjMj2hBXGvGVWOpa9
         NGKdVkYYggIJ3ut1bpEooiT6KnKAlYe9+90APh0UWwt1L1ECVXcYtEuZs1sSoncXP4
         k8s7pDYnr3LYfGuR22Qx8WzZloeJxLbtPP3coKN8kIWnpSSv38bg9NxN0mogNkbtu6
         sXQjmHRwBzJ5w==
Received: by mail-ed1-f51.google.com with SMTP id s12so11354190edd.5;
        Sat, 26 Nov 2022 21:01:32 -0800 (PST)
X-Gm-Message-State: ANoB5pkVSPZBvGkfUZj+ySTJtRjTj46yLb9cPL4nvD7qqrqGcdT7qLJy
        0Zo4ZG6keFSc7JIZ2YDm+cMfXmGSzjxoj39yvlw=
X-Google-Smtp-Source: AA0mqf55bS1nRZOEiJH6TFVxm9l5obYLSN1ugZ6X8p84sbPvVWALTBC8rvOIUbzUo9WSbIoMokrNrJDchK1FZIemwBw=
X-Received: by 2002:a05:6402:5003:b0:462:a25f:f0f2 with SMTP id
 p3-20020a056402500300b00462a25ff0f2mr42425303eda.156.1669525291148; Sat, 26
 Nov 2022 21:01:31 -0800 (PST)
MIME-Version: 1.0
References: <20221027125253.3458989-1-chenhuacai@loongson.cn>
 <CAAhV-H4Y5qHSXr2uHvMYpXMgvm5fU7WQmcALB+86OYkgM1XbOg@mail.gmail.com> <b9c0711c-6efc-4d84-af4e-62e585ac2fa6@app.fastmail.com>
In-Reply-To: <b9c0711c-6efc-4d84-af4e-62e585ac2fa6@app.fastmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 27 Nov 2022 13:01:19 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7PifGc7jEmVURVYHXLdrKBGdRecjjLwOekeqS_cEXkxw@mail.gmail.com>
Message-ID: <CAAhV-H7PifGc7jEmVURVYHXLdrKBGdRecjjLwOekeqS_cEXkxw@mail.gmail.com>
Subject: Re: [PATCH V14 0/4] mm/sparse-vmemmap: Generalise helpers and enable
 for LoongArch
To:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
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

Hi, Andrew,

On Tue, Nov 15, 2022 at 4:09 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Nov 12, 2022, at 11:26, Huacai Chen wrote:
> > Hi, Arnd,
> >
> > Just a gentle ping, is this series good enough now? I think the last
> > problem (static-key.h inclusion) has also been solved.
>
> Yes, this looks fine to me. Sorry I didn't have this on my
> radar any more.
>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>
> I guess the series should be merged through Andrew's linux-mm
> tree. Let me know if for some reason I should pick it up into
> the asm-generic tree instead.
Another gentle ping, can this series be merged to linux-mm in the 6.2 cycle?

Huacai
>
>      Arnd
