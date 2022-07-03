Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADC6564814
	for <lists+linux-arch@lfdr.de>; Sun,  3 Jul 2022 16:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbiGCO22 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Jul 2022 10:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbiGCO2Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Jul 2022 10:28:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB9F5F97;
        Sun,  3 Jul 2022 07:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656858456;
        bh=KpMsHnx9Tsp7wOc9jjTIPho/g3tytR/7fGCZ5b759AM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ORwSUvdJToU2aXOJAJPZwcMyPo7q0XD+wGtaAB2xnE4kIXQinjKN7cvfKaF6t7fRQ
         lAaLHf77rqiX34NSbv8ZSOu8ADwZeC6AO5motJK3mLiRcqCpaBQyUzyAkzsgFjyIAM
         I3nLRzeuce6TjeLKwhv3UKZ/wE1ldGByknXolypQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.162.245]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9o21-1oDFEA3HC1-005uUC; Sun, 03
 Jul 2022 16:27:35 +0200
Message-ID: <512b4acb-af9c-6582-dcfd-f4f12e2ff2a1@gmx.de>
Date:   Sun, 3 Jul 2022 16:27:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 00/14] arch: make PxD_ORDER generically available
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dinh Nguyen <dinguyen@kernel.org>,
        Guo Ren <guoren@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Matthew Wilcox <willy@infradead.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        WANG Xuerui <kernel@xen0n.name>, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        loongarch@lists.linux.dev
References: <20220703141203.147893-1-rppt@kernel.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220703141203.147893-1-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tZaoKhBevvnK9vyAvxGLbJ1WxgHLdBoWB78yUVKCeDwceL+1g3k
 3nDQgqHWbR+FLBaS1qmHK3M1GE2+In8zWiPkah1rILNvAGv1i2GrDOJaeXlsxtx1+m4AHh5
 lYeODgySsmomjpeoWMwqDyMuKJ38Rmai/3Fg3VrKnoqxsiD99U/v2J4bOlp9twap5xUs8tT
 r9yrX0c9GTgOXDxKNX/Vw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PMjNqHmKIRs=:d6jLLXdRH3KchaTl58weoS
 H6xEIbCVzuUa+TI0Hc50cszEjxo4dXDKhzWfQ3AujWyTqHs37/S3647vAC9ZAP1qZCWjGmNCv
 bpddxu66nAmURkUJHRC1F0/I1h3bcdy0+BTINPbYtniT8FMnegpckOuULEru45hmPsxfWbQzb
 oB0mAp8Klt9DchW5GnnZ9nOs6N7FYz267wJ9lI1iSVXK667IssxDQvnRK1ZeZmFo5aQPNJ1Nl
 IX0XvKY0mBotvVgADa9ncw9LMGWJguukKbE2vphhh+YbxExzY3P8/CLom1zuEBP7qpI3Wx9Uf
 MRk0TzCRRqDkyH0Y3xCE+Ky0kLMD/fY15FKMbT32EtUF8zpIAZvEAOhbMNyhalKv1NHuyU65s
 RDVgUGLkY84GdDauRZjBFIr35dkNZsZ50Fa4O/HNBjVBINSMO9LBop/kxDYDaoGA/etEu4WVz
 KLvaJbE212qlZUkYhlpjmXmPTHxuEOrt49HzVB3VmMh7ZFcse0a0/Qs604X6OyjbKFNUKUotq
 uyAj37BU0wBrIyfxWhOrS0o3DJ1NHlwjaZ1Y6QB0abfeNKs8w6EXf0wNJLRLuRuoggav4RsDH
 njVozRQVlcnv/rKgwPLZA9MlqnLqyXPlgkkkMwrJb2zjimaBgjJLrNRopkBx8i/8NiOZP1bMI
 v798zo2E5WNepp3ejSQjxthY0YSeFmXIVMOGE9nsqd2EKN09dFeouWQ92EDCTxz99iuurDuoH
 ashp6aBOEKgiMkLIiGbFzd6TKeJF4BPbOSheeu1wWQ+gdWcuLgjbFCW/lbAL9n4PaCySEu2MM
 Q1ogqEP5irm9kuGKe13CRsMaYsCyP11DuXhfaCPkhUxMBrrsRg63RNklW1u4hfOiNADHXuzBx
 0ZIHLPzcWQsanSMtlDGiwsA0Gi+sTfrGIYl8S9otwjN8OKVrUbAsi4SwK+MSBxpzh3XbNS8vV
 Dy6AQYB9KMCtNy4gW6lH5we1Sdjh6g3eY96y0YDokwcrYh72pTSEW0rnEzJlW2TpYNyRqQwnm
 nJbF+b9CC7mgfnRHQiCV5wfw9U8f1qobXhknV8I2gShGHg3bN5XDpq7T22iRazIfdy5vCwa+G
 VS0fv/SYXgFaD0nwapGDq/UtmXNOj5JzeXPqAd0IPUxT5UZv8uk5zYgGQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/3/22 16:11, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Hi,
>
> The question what does PxD_ORDER define raises from time to time and
> there is still a conflict between MIPS and DAX definitions.
>
> Some time ago Matthew Wilcox suggested to use PMD_TABLE_ORDER to define
> the order of page table allocation:
>
> [1] https://lore.kernel.org/linux-arch/YPCJftSTUBEnq2lI@casper.infradead=
.org/
>
> The parisc patch made it in, but mips didn't.
> Now mips defines from asm/include/pgtable.h were copied to loongarch whi=
ch
> made it worse.
>
> Let's deal with it once and for all and rename PxD_ORDER defines to
> PxD_TABLE_ORDER or just drop them when the only possible order of page
> table is 0.
>
> I think the best way to merge this via mm tree with acks from arch
> maintainers.

That's fine for me.

Acked-by: Helge Deller <deller@gmx.de> # parisc

Thanks!
Helge



> Matthew Wilcox (Oracle) (1):
>   mips: Rename PMD_ORDER to PMD_TABLE_ORDER
>
> Mike Rapoport (13):
>   csky: drop definition of PTE_ORDER
>   csky: drop definition of PGD_ORDER
>   mips: Rename PUD_ORDER to PUD_TABLE_ORDER
>   mips: drop definitions of PTE_ORDER
>   mips: Rename PGD_ORDER to PGD_TABLE_ORDER
>   nios2: drop definition of PTE_ORDER
>   nios2: drop definition of PGD_ORDER
>   loongarch: drop definition of PTE_ORDER
>   loongarch: drop definition of PMD_ORDER
>   loongarch: drop definition of PUD_ORDER
>   loongarch: drop definition of PGD_ORDER
>   parisc: Rename PGD_ORDER to PGD_TABLE_ORDER
>   xtensa: drop definition of PGD_ORDER
>
>  arch/csky/include/asm/pgalloc.h      |  2 +-
>  arch/csky/include/asm/pgtable.h      |  6 +--
>  arch/loongarch/include/asm/pgalloc.h |  6 +--
>  arch/loongarch/include/asm/pgtable.h | 27 +++++-------
>  arch/loongarch/kernel/asm-offsets.c  |  5 ---
>  arch/loongarch/mm/pgtable.c          |  2 +-
>  arch/loongarch/mm/tlbex.S            |  6 +--
>  arch/mips/include/asm/pgalloc.h      |  8 ++--
>  arch/mips/include/asm/pgtable-32.h   | 19 ++++-----
>  arch/mips/include/asm/pgtable-64.h   | 61 +++++++++++++---------------
>  arch/mips/kernel/asm-offsets.c       |  5 ---
>  arch/mips/kvm/mmu.c                  |  2 +-
>  arch/mips/mm/pgtable.c               |  2 +-
>  arch/mips/mm/tlbex.c                 | 14 +++----
>  arch/nios2/include/asm/pgtable.h     |  7 +---
>  arch/nios2/mm/init.c                 |  5 +--
>  arch/nios2/mm/pgtable.c              |  2 +-
>  arch/parisc/include/asm/pgalloc.h    |  6 +--
>  arch/parisc/include/asm/pgtable.h    |  8 ++--
>  arch/xtensa/include/asm/pgalloc.h    |  2 +-
>  arch/xtensa/include/asm/pgtable.h    |  1 -
>  21 files changed, 84 insertions(+), 112 deletions(-)
>
>
> base-commit: 03c765b0e3b4cb5063276b086c76f7a612856a9a

