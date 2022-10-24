Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5BD609AFD
	for <lists+linux-arch@lfdr.de>; Mon, 24 Oct 2022 09:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiJXHHg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Oct 2022 03:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiJXHHf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Oct 2022 03:07:35 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7044750BA8;
        Mon, 24 Oct 2022 00:07:33 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666595251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V+N9vn0P6R0NJj2sELTzOo4NzUD1BWEF8UWsq1c2RX0=;
        b=bB+7EmY/sKtcvXTR6/6XXh1/s2iANpBqYNhfiTS1pNRQqFxyAueAs8m12STjP6sex/pfUX
        QgwfowBnI/e8a2DlprTQ2Ni8XEDKlJboHodc96d99WOWJKSGCa2/bVk6jK7iq7pcwEIw/j
        otAgqxDfAFypKBqnuVOLZglQ79K2zRs=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 2/2] riscv: Enable ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20221023133205.3493564-3-guoren@kernel.org>
Date:   Mon, 24 Oct 2022 15:07:22 +0800
Cc:     palmer@dabbelt.com, palmer@rivosinc.com, heiko@sntech.de,
        arnd@arndb.de, Muchun Song <songmuchun@bytedance.com>,
        catalin.marinas@arm.com, chenhuacai@loongson.cn,
        Conor.Dooley@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-mm@kvack.org, Guo Ren <guoren@linux.alibaba.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1F5AF29D-708A-483B-A29F-CAEE6F554866@linux.dev>
References: <20221023133205.3493564-1-guoren@kernel.org>
 <20221023133205.3493564-3-guoren@kernel.org>
To:     guoren@kernel.org
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Oct 23, 2022, at 21:32, guoren@kernel.org wrote:
>=20
> From: Guo Ren <guoren@linux.alibaba.com>
>=20
> This patch enable the feature of "free some vmemmap pages of HugeTLB

We have a new name =E2=80=9CHVO" to refer to this feature. So I=E2=80=99d =
like to rewrite
The changelog to something like =E2=80=9CEnable HVO [1] for RISCV=E2=80=9D=
.

> page" [1]. To make it work correct, we also need fixup PG_dcache_clean
> setting for huge page [2].
>=20
> [1] =
https://lore.kernel.org/linux-doc/20210510030027.56044-1-songmuchun@byteda=
nce.com/
> [2] =
https://lore.kernel.org/linux-mm/20220302084624.33340-1-songmuchun@bytedan=
ce.com/
>=20
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: Huacai Chen <chenhuacai@loongson.cn>
> Cc: Arnd Bergmann <arnd@arndb.de>

I=E2=80=99am really glad to see more and more arches for support HVO.

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

