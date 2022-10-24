Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240AE609C01
	for <lists+linux-arch@lfdr.de>; Mon, 24 Oct 2022 10:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJXIDH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Oct 2022 04:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJXIDG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Oct 2022 04:03:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464AA5805C;
        Mon, 24 Oct 2022 01:03:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE33A61073;
        Mon, 24 Oct 2022 08:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A585C43145;
        Mon, 24 Oct 2022 08:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666598584;
        bh=CXws4eLr0gl3odZwqTEuuhZZp1WDhaclsxdDRXlhMQQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YIj6ATKSLfUvngOWKyQpxY0uDpchrCF9EfJF3NhblMSs0sZd1UQFhe3JsKjQx1JOg
         aEuKTT4mup0cKdPRcGDGVUjf4cpVK14Lz5PXYVL4gAgSMXAxOYefSV7nfIfeCmZPEA
         0iyRrEbnZ/av/766ux6DZTpYX0aF1r+Iuspd/stry1Stle/WBLw9aZB14gbjaZIPyI
         8UY4zsjz/drcQgifIw/F/8YYbEjLdNkTJr/0aBcEidr81pJ0zfrWC9rgwjxglsKFaL
         SrVRRRAExIAkiHYqi11Kf66WHK9dnD/ONhh12JEfcVcH5BmSd/q4I0+s34qKwMgc3W
         7dtdnWAcYBNqw==
Received: by mail-oi1-f176.google.com with SMTP id r204so7294519oie.5;
        Mon, 24 Oct 2022 01:03:04 -0700 (PDT)
X-Gm-Message-State: ACrzQf2uWM4k5sT0QRntcbeO5iaiVl+m9id4o50LGwqVz8l4M6672iUN
        zW8ZnIAadhjTxDYWioLpVRwGq9KExkvyD4FVUKI=
X-Google-Smtp-Source: AMsMyM4opuf9ZlLlQKT18CpSvfe9XotBrtNnzZrG6O6GBcHpNVvd4QnPrdeLYevOyANG4WDlsZD5B1GA8zDQRLU5blc=
X-Received: by 2002:a05:6808:14cf:b0:355:5204:dd81 with SMTP id
 f15-20020a05680814cf00b003555204dd81mr15684588oiw.112.1666598583325; Mon, 24
 Oct 2022 01:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221023133205.3493564-1-guoren@kernel.org> <20221023133205.3493564-3-guoren@kernel.org>
 <1F5AF29D-708A-483B-A29F-CAEE6F554866@linux.dev>
In-Reply-To: <1F5AF29D-708A-483B-A29F-CAEE6F554866@linux.dev>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 24 Oct 2022 16:02:51 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSmSR7uKrCGZ24+NSa31FAecOBpUh8G0SMAEV-5oFGJyQ@mail.gmail.com>
Message-ID: <CAJF2gTSmSR7uKrCGZ24+NSa31FAecOBpUh8G0SMAEV-5oFGJyQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: Enable ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
To:     Muchun Song <muchun.song@linux.dev>
Cc:     palmer@dabbelt.com, palmer@rivosinc.com, heiko@sntech.de,
        arnd@arndb.de, Muchun Song <songmuchun@bytedance.com>,
        catalin.marinas@arm.com, chenhuacai@loongson.cn,
        Conor.Dooley@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-mm@kvack.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 24, 2022 at 3:07 PM Muchun Song <muchun.song@linux.dev> wrote:
>
>
>
> > On Oct 23, 2022, at 21:32, guoren@kernel.org wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > This patch enable the feature of "free some vmemmap pages of HugeTLB
>
> We have a new name =E2=80=9CHVO" to refer to this feature. So I=E2=80=99d=
 like to rewrite
> The changelog to something like =E2=80=9CEnable HVO [1] for RISCV=E2=80=
=9D.
Okay.

>
> > page" [1]. To make it work correct, we also need fixup PG_dcache_clean
> > setting for huge page [2].
> >
> > [1] https://lore.kernel.org/linux-doc/20210510030027.56044-1-songmuchun=
@bytedance.com/
> > [2] https://lore.kernel.org/linux-mm/20220302084624.33340-1-songmuchun@=
bytedance.com/
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: Muchun Song <songmuchun@bytedance.com>
> > Cc: Huacai Chen <chenhuacai@loongson.cn>
> > Cc: Arnd Bergmann <arnd@arndb.de>
>
> I=E2=80=99am really glad to see more and more arches for support HVO.
>
> Acked-by: Muchun Song <songmuchun@bytedance.com>
Thx

>
> Thanks.
>


--=20
Best Regards
 Guo Ren
