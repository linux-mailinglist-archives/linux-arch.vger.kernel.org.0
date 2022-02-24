Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EC34C297D
	for <lists+linux-arch@lfdr.de>; Thu, 24 Feb 2022 11:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbiBXKbQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Feb 2022 05:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbiBXKbM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Feb 2022 05:31:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A553420A3B8;
        Thu, 24 Feb 2022 02:30:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 438F76162C;
        Thu, 24 Feb 2022 10:30:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAB6C340F5;
        Thu, 24 Feb 2022 10:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645698641;
        bh=UVBFu/2kd+72msKvbsEhY06n98IaQ0VgsAo0y3uTQ2c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uKMo67CXZRSwdhBzi8/EEN9oztBr9soHLP8RvL0hIDZzDAQWECQ7f8/Z8eugIY42z
         hdfwcBluy+paiOgWEjWvgQKMnK4adKDRPYUcdzCO1eHFfPr8N0p6F+ynpzpVaLf9iv
         CZRG6rIeJEwNiFrzJtmKDTMeHAoxInP0LBcoot5lwoVNesSWsfBfyAK/NsNtQnkts0
         AMlDmrllC81ZcK3cvVTbMA9khRkXj8pu1dHnRsqHjwpW8ZIpgngP/5/BCpTl75RUUI
         vy/3K30H2fYs4D+RRMADFd4EhSy9aqCosQIJHK8SpqR9iXdhesbYPT0MaBTAKEOI9x
         ItmMoXkR49BCQ==
Received: by mail-vk1-f176.google.com with SMTP id k9so922391vki.4;
        Thu, 24 Feb 2022 02:30:41 -0800 (PST)
X-Gm-Message-State: AOAM53356GDXiNzYC3BdaVZfnWdnLdzuU6RTWh+kwNDoTN7fiPNJdVzG
        q40iGuFT0bflOc33OENuEZJUDBMJ9+7vj4FN45I=
X-Google-Smtp-Source: ABdhPJzrvZFAbp4Whh2uDrOBDpqD226YSRYRm6BxUCxiOKTwC758aaNZI0rGrTfTm/5o1TQu5AW4BErik6sfPZlMfiQ=
X-Received: by 2002:a1f:2355:0:b0:32a:e5bb:29a1 with SMTP id
 j82-20020a1f2355000000b0032ae5bb29a1mr790584vkj.2.1645698640594; Thu, 24 Feb
 2022 02:30:40 -0800 (PST)
MIME-Version: 1.0
References: <20220224085410.399351-1-guoren@kernel.org> <20220224085410.399351-12-guoren@kernel.org>
 <CAK8P3a3wg9S_zPad74FiJzYBn0M9bQyunuKzmH3z_QQrags5ng@mail.gmail.com>
In-Reply-To: <CAK8P3a3wg9S_zPad74FiJzYBn0M9bQyunuKzmH3z_QQrags5ng@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 24 Feb 2022 18:30:29 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQratosmRtoiKx9xTm3-gBSrnEaWgVrYj1U2WZafR1RVg@mail.gmail.com>
Message-ID: <CAJF2gTQratosmRtoiKx9xTm3-gBSrnEaWgVrYj1U2WZafR1RVg@mail.gmail.com>
Subject: Re: [PATCH V6 11/20] riscv: compat: syscall: Add compat_sys_call_table
 implementation
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 24, 2022 at 5:38 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Feb 24, 2022 at 9:54 AM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Implement compat sys_call_table and some system call functions:
> > truncate64, ftruncate64, fallocate, pread64, pwrite64,
> > sync_file_range, readahead, fadvise64_64 which need argument
> > translation.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
>
> Here, I was hoping you'd convert some of the other architectures to use
> the same code, but the changes you did do look correct.
>
> Please at least add the missing bit for big-endian architectures here:
>
> +#if !defined(compat_arg_u64) && !defined(CONFIG_CPU_BIG_ENDIAN)
> +#define compat_arg_u64(name)           u32  name##_lo, u32  name##_hi
> +#define compat_arg_u64_dual(name)      u32, name##_lo, u32, name##_hi
> +#define compat_arg_u64_glue(name)      (((u64)name##_hi << 32) | \
> +                                        ((u64)name##_lo & 0xffffffffUL))
> +#endif
>
> with the lo/hi words swapped. With that change:
Got it, I would change it in next version of patch.

>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
