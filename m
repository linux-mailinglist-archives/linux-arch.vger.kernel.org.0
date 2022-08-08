Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEC358C4A6
	for <lists+linux-arch@lfdr.de>; Mon,  8 Aug 2022 10:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242216AbiHHIGs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Aug 2022 04:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242127AbiHHIGh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Aug 2022 04:06:37 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A1513E31;
        Mon,  8 Aug 2022 01:06:32 -0700 (PDT)
Received: from mail-ej1-f44.google.com ([209.85.218.44]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MhDAi-1nhnXw2dfO-00eMfS; Mon, 08 Aug 2022 10:06:30 +0200
Received: by mail-ej1-f44.google.com with SMTP id i14so15135687ejg.6;
        Mon, 08 Aug 2022 01:06:30 -0700 (PDT)
X-Gm-Message-State: ACgBeo3UGsnb/Cf1u8vbQV80/jTX1Ci2F1wdjEwgUbXDxlFpJr2bVtV0
        ZteI2hmDi/5e4u4zePRVGDNxv/iiC//lW++2/Fk=
X-Google-Smtp-Source: AA6agR4GgGd8n+xBtHZRIIZDSb3raNbv0NcwwkrbkWgSf6AjnZq/RmNzizI0Ihs+/xXm5AI+HvVE+1WgmC6BUZ+FEN4=
X-Received: by 2002:a17:906:9b08:b0:730:5d3c:4b1b with SMTP id
 eo8-20020a1709069b0800b007305d3c4b1bmr13057897ejc.606.1659945990183; Mon, 08
 Aug 2022 01:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220807172854.12971-1-rdunlap@infradead.org> <CAK8P3a0FR2ySLXAMGR1ZmaAQMbVwB4MFBPvBw4py_pbgtQSfgA@mail.gmail.com>
 <3a4dad85-1102-1bab-c0af-a2c6827663b1@infradead.org>
In-Reply-To: <3a4dad85-1102-1bab-c0af-a2c6827663b1@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 8 Aug 2022 10:06:14 +0200
X-Gmail-Original-Message-ID: <CAK8P3a140FFhCvrOXbCtYKCW6BR6tEz6uy8Wqd0aG3DdHiZSXg@mail.gmail.com>
Message-ID: <CAK8P3a140FFhCvrOXbCtYKCW6BR6tEz6uy8Wqd0aG3DdHiZSXg@mail.gmail.com>
Subject: Re: [PATCH] asm-generic: unistd.h: make 'compat_sys_fadvise64_64' conditional
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:SGFtsLq8mQqaxrYQ4ycxf177BwA7aQP8CEn1L9f7FQvcOijnEq4
 HfrsKAOzmxmbR5MC9oyM87M7eGM/SAAspq8glgbZiHqUDRk5pm34bFgEuBiMhoE+R8OxDJf
 fS9InY7VFDSTsVMh5jD5FcKAFdLcgfMGrgM8ojlP9Y/yLoH6VVXhMWKvyjA7cA7vhdALiMx
 12qWk7VnVUTUU102ltPJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:REE8JLPm/rU=:waUH4FsaX+ZreVMH/o9cqG
 4xX546mhgANnfQjSTRqaXa5tX4Nu0wRKWDk5KMr7P0XHjJiXFQvrGgX7wtpgpQIpw7aHDkaAN
 QX7HGd50e9P+tJnn4QYrEke6cqMgjpSK1Ei57vXmenSGiwouGh2hojdjU9gxRRVnYktBRekd4
 GM+Q1SPTKpv9iYacH/Ba46Pzi1C82TikSKHHv+dUW2FagYI9Q8eo6HZQlqGVXu1T/e6c5YW5L
 LYEzJzYUKoPaCSOyG0Ev1zIdFHodLdV3kSljrhHMhiASNHp+IVro5RrG7GrU+C+Saf4+vRyTQ
 +552O/BbGtT/s/uHNBld4heQ9WBROMEd3aPvqYSFdTo3GydMzE3ZcCPFsEMljHpQB0Vx6iM7q
 voqOvW5Sge8l2xrFQYzB3CjR65YNnP8jH2xlkzRo9BbuETAihdWxlxGgBINeKMj9O1Px6rDwK
 SknTkzd21wzFaoNJHPGHnBH6dB8y7PaaknQ9/rGKGsOq/XeryczhSeU8PpQcXis5oXCOLGBgC
 BBgvFXAjB0xMnkH7D3O1Dxfm30fc7BXrIpHTeG0L6X7HQ01QIvs96kM4DmXs9XLjpSRtbk4eb
 42PUpc9LxPnEdlYLzqqUYoZJg3aB7yYoJejtexHCmHrTcdG6LomnAnq57n7XQC7hX4M7BXG6j
 k2atACizrau8d8bJw2OaTIAp2pvJRTuN2VLRKLLQ/b5v68YLjBzR8Mhs0hdYOm/UFBMzUjLQM
 ms1TbrZ8DbRI+7el5UWXCwY9uRW7mFumeVUjDTLnUnH2sxqqrR/IlLaqFYMxP07P0/LPfTAfb
 ub+asjAL0ncxz/2ugAtpzkgrMU+4eCLkOXItvGytus3zOMlgcuGtY3H+VwQ8Vc+XVIZ+fS5V0
 fdRGoixc14txamgpLsMg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 8, 2022 at 12:39 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 8/7/22 12:44, Arnd Bergmann wrote:
> > On Sun, Aug 7, 2022 at 7:28 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>
> >
> > This does not work: __ARCH_WANT_COMPAT_FADVISE64_64 is defined in
> > arch/riscv/include/asm/unistd.h, which is not a UAPI header. By making the line
> > conditional on this, user space no longer sees the macro definition.
> >
> > It looks like you also drop the native definition on all architectures other
> > than riscv here. What we probably want is to just make all the
> > declarations in include/linux/compat.h unconditional and not have them
> > depend on architecture specific macros. Some of these may have
> > incompatible prototypes depending on the architecture, but if we run
> > into those, I would suggest we just give them unique names.
>
> Thanks for the comments.
>
> With the other patch to kernel/sys_ni.c, this one is no longer needed,

Ok.

> although I can look into making more entries in <linux/compat.h>
> unconditional.

This would be a nice cleanup, but it does involve making sure that
all prototypes are compatible with the implementation on each
architecture. I think we should definitely do this, it's just not as
simple as removing each #ifdef in linux/compat.h and linux/syscall.h

> That would also mean adding them to kernel/sys_ni.c, right?
> (if not already there)

That part should be completely independent. If the entry in
kernel/sys_ni.c is missing, that causes a link failure, while an
incorrect #ifdef would cause a compile-time error for the missing
prototype.

         Arnd
