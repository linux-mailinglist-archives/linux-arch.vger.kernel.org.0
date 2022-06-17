Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2AF54FA9F
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jun 2022 17:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbiFQPmS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jun 2022 11:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383133AbiFQPmR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jun 2022 11:42:17 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8944F9E8
        for <linux-arch@vger.kernel.org>; Fri, 17 Jun 2022 08:42:16 -0700 (PDT)
Received: from mail-yw1-f177.google.com ([209.85.128.177]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MOzjW-1oL1Xm1zMS-00PJAl for <linux-arch@vger.kernel.org>; Fri, 17 Jun
 2022 17:42:14 +0200
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-3177e60d980so24526267b3.12
        for <linux-arch@vger.kernel.org>; Fri, 17 Jun 2022 08:42:14 -0700 (PDT)
X-Gm-Message-State: AJIora+wiIuYhuVN6XcOszD1s3yauvU6G0KNmN+/gT8yO5HSkucZcfY2
        POqTBGiOnk+t1mtgIQsAe3oTOhCbm2s69WEAIco=
X-Google-Smtp-Source: AGRyM1ukWmthpfkPr4/2y5gBl+lfiymkoEAMJBnSKg9FV3PSl6oCNkzW4sCz4lGmqPQB/NHxQLxcBDB8WkwxgVsVieQ=
X-Received: by 2002:a0d:d84d:0:b0:314:2bfd:ddf3 with SMTP id
 a74-20020a0dd84d000000b003142bfdddf3mr12471471ywe.347.1655480533296; Fri, 17
 Jun 2022 08:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220617145859.582176-1-chenhuacai@loongson.cn>
In-Reply-To: <20220617145859.582176-1-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Jun 2022 17:41:56 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1L40=P8GnuyK--K7URyrdAb4XcPJ-+HxwY4_+siA25oQ@mail.gmail.com>
Message-ID: <CAK8P3a1L40=P8GnuyK--K7URyrdAb4XcPJ-+HxwY4_+siA25oQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add sparse memory vmemmap support
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Min Zhou <zhoumin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:EyyJ7u71NqEiDdk8OQW0yO/MPYg4Hql6mRDsKuvfLyVZBw7xRx7
 YMFW4vgq8LywSE8lx6WJMIpzaJy7AsK4iDlzSUgfxX5QkUh6PwR2v+baBVYCP9MhgO+FcjC
 9eLW4rWCPl6L6AsyvPpRN4FVjITQzubcdWfJfINqfvURB3ZWJbW0IO7aUjAeNEYnaHyUabN
 G0wu3FZOmicxuh9TtkWVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NRpPfAGWOUM=:ZwgMgwQPldnvK+lRW0RfyP
 5GeYjObT/HTrKFXcPmro7JEz7dKvSBXs/hxh/I9jGJsXTHjlh66AqTE/RMBMImKH9YeMFAzQy
 E9oc2LgcAgX/FRvNY8TlLTzRFaN4YETztBrS6A/bCjYisDT+ar9BS8G9V4k853N1c1ckr9JRX
 2o0I4q6lCSdWjqPX/M1/3yjUc5R/sHOloMFEbfd+jlaAMCUrligOjw+C1D+F2d4B07XVnqkjp
 EiuOJtUA+QPV6bxkKY8QF0SDBXBwM7oRU0rCp+LqZEGIHrvp5hpcHuqCXeVaXL7Dn5UkefeM7
 Efbe/LYTlfop1CGxu3QB6N3aCMI5+08ilJgTCwbHEa+2zwjzPcB3YvrNx0e8vrTdvJV4qOqCh
 cm7UjtfnvRtwcAZc3Kds8bfg5dUJTqh9EPUKeGgwO515tHT5QksxsQmvE1Rew3/RaHVoq3xSL
 on+fQBWGornGpDE/zVc9gU1taFpMRACi8nXxNTmtTmbfWHj52P6ZMBmvLlB6PeGmJPg3ImA8b
 /TZHBWzQF2GD6+Yf8X4aKPvaHKxBg4QJK3ATalYgCcMZrB1qAUFb3uL+LEmXL7tUkwpfhNttN
 lUJUD7lhzSXgLpCZS80TQ8v6M/vy3X0I5i1/j57HUQe6TChm0YZEfLaqdXqgWw6jQ/GAbR+aI
 VXCSP6PQTX/xsL8RHqkVpoKGrZs2JFktMP6ELcm4Y4qHcJjit1nr6xw0T99sUFWbuQZOXQELa
 4a6iW+S3l2YpM2J2+1nI6Sxi/IeSXXiO016RJDOxcf9MXCp7D6iZ20l+i5bNyvcEO4/0xoyuA
 KdmpmymDPwhjQOAaNV1Ty1mvltG1qdByyr4Wo/N6+XA2IKWELo0P7OAV8HOg0Vwz5QfGjSH5L
 72H2FKHnH0Bu77qXv5RQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 17, 2022 at 4:58 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> Add sparse memory vmemmap support for LoongArch. SPARSEMEM_VMEMMAP
> uses a virtually mapped memmap to optimise pfn_to_page and page_to_pfn
> operations. This is the most efficient option when sufficient kernel
> resources are available.

I have not looked at this in detail, but from a high-level perspective, it
seems very similar to the corresponding code in arch/arm64 and arch/x86.

Can you try to merge the three copies into a generic helper and add that
to mm/sparse-vmemmap.c? If this does not work, can you describe in the
changelog text why these have to be architecture specific?

       Arnd
