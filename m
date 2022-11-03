Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D77617465
	for <lists+linux-arch@lfdr.de>; Thu,  3 Nov 2022 03:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiKCCtl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Nov 2022 22:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiKCCtj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Nov 2022 22:49:39 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE596327;
        Wed,  2 Nov 2022 19:49:37 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1667443775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o9XdBdpdcG1/NkMU2aaMoc8QZfSgfsLLPXvYeGPTeUY=;
        b=gd3IyuG/n82G0J624HScRl7Cu7uerzZIPzi0GblFWqs2cgvdf1IRZZrXl28hHno3iKYGkP
        aKzHQUKDA6jjjFMdpUo9UwmVc/NXfUDTzfD24vdzdd4DNAGB8liwZ655wekHdp7A5Zob5i
        qbNEmS2q1/4n2GYtiXg14HQcwxmfQ7U=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.200.110.1.12\))
Subject: Re: [PATCH V14 4/4] LoongArch: Enable
 ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20221027125253.3458989-5-chenhuacai@loongson.cn>
Date:   Thu, 3 Nov 2022 10:49:17 +0800
Cc:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F610957D-A6EE-4211-9E1A-BFB9389856AD@linux.dev>
References: <20221027125253.3458989-1-chenhuacai@loongson.cn>
 <20221027125253.3458989-5-chenhuacai@loongson.cn>
To:     Huacai Chen <chenhuacai@loongson.cn>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Oct 27, 2022, at 20:52, Huacai Chen <chenhuacai@loongson.cn> wrote:
>=20
> From: Feiyang Chen <chenfeiyang@loongson.cn>
>=20
> The feature of minimizing overhead of struct page associated with each
> HugeTLB page is implemented on x86_64. However, the infrastructure of

I'd like to refer to this feature as HVO (more simplified).

> this feature is already there, so just select ARCH_WANT_HUGETLB_PAGE_
> OPTIMIZE_VMEMMAP is enough to enable this feature for LoongArch.
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.=
