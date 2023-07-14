Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F22754380
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jul 2023 21:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236604AbjGNT4k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Jul 2023 15:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236592AbjGNT4g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Jul 2023 15:56:36 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057753AB8;
        Fri, 14 Jul 2023 12:56:29 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id DEDF05C009D;
        Fri, 14 Jul 2023 15:56:25 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 14 Jul 2023 15:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1689364585; x=1689450985; bh=bIDbQfxsNuvf3d9r/rOpxa+WmMoPtn+8jD3
        nk1eOuRM=; b=SGMembvX6/sAHfuOugqH9axbat/QoJ0k31uIq0vHq0+0ZRq9/bm
        OXE4fsjATB99uYFbcAOqgiYTHo/G6oDsB/CtG/4tOHM+S4lOaCWbNGhHggOsAJTg
        R9x3L8nKHjrq8GlGVIJ3q52beg3LfkH49h4safD8f3/9/UWoGrvEiu/G8GQeWhsj
        QBINygCvMVi3GocH49248OkLx/g7BcAV1u7sIyM14bQ44Jjn/2m2h0UISKDEyaOz
        LiZL8ngaiTLV0m38ocWnY5LlNGr8kj6VSMgo6BbX4AuPvRR9+inBIg2TDeq3EBVa
        XU1pvnDy1aQqp4RoKfvE7UAdu5l/KSmdn0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1689364585; x=1689450985; bh=bIDbQfxsNuvf3d9r/rOpxa+WmMoPtn+8jD3
        nk1eOuRM=; b=OQUfHU85i/3qDShDvTCgfTD7feljdTJdTsnuo5ejQBoyPs0P2uv
        Z8yhnO9uqNgQP4P4ilW2vOODiZuuT114HqvMR+jVhEzUGMPzGFNZb9y/2mM11JH3
        iSO1XktS3kXfIxO1sn/yYGVQonR1mWZCYIIOrqoVRNzaSTphNKiVsgzIBPIScgWb
        Z9v0Zo8pgQ6o2JVPgvhPnhBB/uIl9i84xc840h50R0HRvBf8iSsayfWcg5bT1Eec
        vVXCtmEw6o+6btBP99+xmA290mk9/QTtkdDPF9AJWxPcVzskgP+PvHPr+w/oRip3
        0GmREp6JTbBoHvyZLHHMGxmDM7Lx70sI4ew==
X-ME-Sender: <xms:aKixZINAaHZB2npjlr6kbwwcGSVaR5zGuNyYmH16wvpA4A1Iul-Z-A>
    <xme:aKixZO9FE28zzxsHMXwW1FYewcFTJPhJbLC0HpzLgAg6Gu9oCDArV6KFkUHtSfJNl
    EUoJjSEoSDY6FTMNnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeeigddugeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkeeuleegieeghfduudeltdekfeffjeeuleehleefudettddtgfevueef
    feeigeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:aKixZPTYvU0vcmCP_r2Hf20okR3zUmuZi9AmprKDUWqxyEYbhddrMw>
    <xmx:aKixZAsElIgnNOVEibh3rfmvgRbV4aiLiBiVdTJDz0occUAMdxRP6Q>
    <xmx:aKixZAdfD6MDZtpCirPQ9q2-7iBk7Zcv9Ts7-dfZxNFt69I6d2fbWA>
    <xmx:aaixZHzmJD_NpvGaWn6kqZWRXRbs2qeuuJsh2383wclZmbiiFdiBMw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 66359B60086; Fri, 14 Jul 2023 15:56:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <bf997965-71d1-4949-8cbc-de46ac6a1283@app.fastmail.com>
In-Reply-To: <CAP-5=fWmPQ9vtH1t9pSPCPBiOFxQQe43C7Bk4amLS08ASAnwGg@mail.gmail.com>
References: <1687443219-11946-1-git-send-email-yangtiezhu@loongson.cn>
 <1412dbaf-56f4-418b-85ea-681b1c44cc26@app.fastmail.com>
 <CAP-5=fWmPQ9vtH1t9pSPCPBiOFxQQe43C7Bk4amLS08ASAnwGg@mail.gmail.com>
Date:   Fri, 14 Jul 2023 21:56:04 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Ian Rogers" <irogers@google.com>,
        "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, loongarch@lists.linux.dev,
        Linux-Arch <linux-arch@vger.kernel.org>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v3 0/2] Unify uapi bitsperlong.h
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 14, 2023, at 20:34, Ian Rogers wrote:
> On Thu, Jun 22, 2023 at 8:10=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> =
wrote:
>>
>> On Thu, Jun 22, 2023, at 16:13, Tiezhu Yang wrote:
>> > v3:
>> >   -- Check the definition of __BITS_PER_LONG first at
>> >      the beginning of uapi/asm-generic/bitsperlong.h
>> >
>
> Thanks for doing this cleanup! I just wanted to report an issue I ran
> into with building the Linux perf tool. The header guard in:
> tools/include/asm-generic/bitsperlong.h
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/tools/include/asm-generic/bitsperlong.h
>
> Caused an issue with building:
> tools/perf/util/cs-etm.c
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/tools/perf/util/cs-etm.c
>
> The issue was that cs-etm.c would #include a system header, which
> would transitively include a header with the same header guard. This
> led to the tools/include/asm-generic/bitsperlong.h being ignored and
> the compilation of tools/perf/util/cs-etm.c failing due to a missing
> define. My local workaround is:
>
> ```
> diff --git a/tools/include/asm-generic/bitsperlong.h
> b/tools/include/asm-generic/bitsperlong.h
> index 2093d56ddd11..88508a35cb45 100644
> --- a/tools/include/asm-generic/bitsperlong.h
> +++ b/tools/include/asm-generic/bitsperlong.h
> @@ -1,6 +1,6 @@
> /* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __ASM_GENERIC_BITS_PER_LONG
> -#define __ASM_GENERIC_BITS_PER_LONG
> +#ifndef __LINUX_TOOLS_ASM_GENERIC_BITS_PER_LONG
> +#define __LINUX_TOOLS_ASM_GENERIC_BITS_PER_LONG
> #include <uapi/asm-generic/bitsperlong.h>
> @@ -21,4 +21,4 @@
> #define small_const_nbits(nbits) \
> (__builtin_constant_p(nbits) && (nbits) <=3D BITS_PER_LONG && (nbits) =
> 0)
> -#endif /* __ASM_GENERIC_BITS_PER_LONG */
> +#endif /* __LINUX_TOOLS_ASM_GENERIC_BITS_PER_LONG */
> ```
>
> I'm not sure if a wider fix is necessary for this, but I thought it
> worthwhile to report that there are potential issues. I don't think we
> can use #pragma once, as an alternative to header guards, to avoid
> this kind of name collision.

Thanks for the report! I think the correct fix is to update
the tools/include/ headers to have the same change as the kernel
itself. I don't know why we end up including both, that sounds
like a separate issue but should normally be harmless as long
as the contents are the same.

      Arnd
