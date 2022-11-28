Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00E563B5AA
	for <lists+linux-arch@lfdr.de>; Tue, 29 Nov 2022 00:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbiK1XKL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Nov 2022 18:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbiK1XKK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Nov 2022 18:10:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BA32E9D6;
        Mon, 28 Nov 2022 15:10:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26616B8102B;
        Mon, 28 Nov 2022 23:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEA6C433D6;
        Mon, 28 Nov 2022 23:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669677006;
        bh=Z/itbdefigEkmW9ubXmwx/IWcP+dYHfAaiqq0syhieQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zoujZvTTGZ/7PzKtBN3jnsRdwHk6AGdfYydfuv0cnu8pxGG4Z5OsihxFXGZO+7uwU
         XXRT0z9WWgHbdxdSvSXeg2l7EcYoNalJSgNCRhgKmWmheim0iIuhoxLWu6S/w8xw/X
         ZkEIsPzG00T/4bEyTIjImIKg7FFj1F77JrfrNXJ4=
Date:   Mon, 28 Nov 2022 15:10:05 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Huacai Chen <chenhuacai@kernel.org>
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
Subject: Re: [PATCH V14 0/4] mm/sparse-vmemmap: Generalise helpers and
 enable for LoongArch
Message-Id: <20221128151005.916e4373cd4e5808111dea0c@linux-foundation.org>
In-Reply-To: <CAAhV-H7PifGc7jEmVURVYHXLdrKBGdRecjjLwOekeqS_cEXkxw@mail.gmail.com>
References: <20221027125253.3458989-1-chenhuacai@loongson.cn>
        <CAAhV-H4Y5qHSXr2uHvMYpXMgvm5fU7WQmcALB+86OYkgM1XbOg@mail.gmail.com>
        <b9c0711c-6efc-4d84-af4e-62e585ac2fa6@app.fastmail.com>
        <CAAhV-H7PifGc7jEmVURVYHXLdrKBGdRecjjLwOekeqS_cEXkxw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 27 Nov 2022 13:01:19 +0800 Huacai Chen <chenhuacai@kernel.org> wrote:

> Hi, Andrew,
> 
> On Tue, Nov 15, 2022 at 4:09 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Sat, Nov 12, 2022, at 11:26, Huacai Chen wrote:
> > > Hi, Arnd,
> > >
> > > Just a gentle ping, is this series good enough now? I think the last
> > > problem (static-key.h inclusion) has also been solved.
> >
> > Yes, this looks fine to me. Sorry I didn't have this on my
> > radar any more.
> >
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> >
> > I guess the series should be merged through Andrew's linux-mm
> > tree. Let me know if for some reason I should pick it up into
> > the asm-generic tree instead.
> Another gentle ping, can this series be merged to linux-mm in the 6.2 cycle?

It's a pretty large patchset and I'm a bit concerned about the amount
of review and test which it has received from the MIPS side?

Prudence suggest that we merge this in 6.3-rc1.  But I'll queue it up
for now, get a bit of testing while we consider this.

