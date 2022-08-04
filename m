Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EBE589666
	for <lists+linux-arch@lfdr.de>; Thu,  4 Aug 2022 05:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbiHDDPH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Aug 2022 23:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238654AbiHDDPC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Aug 2022 23:15:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E293557276;
        Wed,  3 Aug 2022 20:15:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2750AB82443;
        Thu,  4 Aug 2022 03:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B8DC433C1;
        Thu,  4 Aug 2022 03:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659582897;
        bh=gZrBQGrhtQKLPBFcVlxf7xhA8jxWtNwNk6Dp4W0Xn9E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U9hE+U5FTa4sp1WdZ7IkErqB2CzF+S9GvujQYewCHKvBNojEJYwwqiyWtnE8TBWal
         Njhbr9+M7YyOCGRVCM2Z71eqhVWSXgIoFXH1IDnOiEeIXSQLIBhWQAww/Zyk7uI+et
         Jij5yObTWnqMl+FwnZRyJHBbRgdqCMyfXMrL3Gx1Fq+NXoLN6AIN2ttU5kQn+VNKLz
         trrb+yxr4o/TAXyYoy0Fq3+p3vXT5HP8np/oMGuPTRqmaUJ/dqCtoMqH5NhhmfuOt4
         1fpqBPBzGtvkjiPqs+U6JLRFprS+sVZiQc33DSVvkCQ/RlhhreFFIGREcmq54jOIOL
         7ZEPtzIRJgZfg==
Received: by mail-ua1-f41.google.com with SMTP id b4so6445699uaw.11;
        Wed, 03 Aug 2022 20:14:57 -0700 (PDT)
X-Gm-Message-State: ACgBeo2p3MmDv6Sxw+pVyXSXgxODCVEbSwLRtqqF71r3ai0nLP6h+iJt
        yORPDqYd716lBe1ISfaztPursRDr8El1ApqnFhE=
X-Google-Smtp-Source: AA6agR6dexsfSg4pR7w05ZnmnDbZFK1BJ3uAqWR9BtNN7H1Q9rSbK36O/IOmUYnbeHBnC3rYR5c+ff2RBxe102Xj6Hc=
X-Received: by 2002:ab0:65d6:0:b0:385:f6e1:83ef with SMTP id
 n22-20020ab065d6000000b00385f6e183efmr11725398uaq.23.1659582896658; Wed, 03
 Aug 2022 20:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220802060948.18807-1-zhangqing@loongson.cn>
In-Reply-To: <20220802060948.18807-1-zhangqing@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 4 Aug 2022 11:14:41 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5HRXwGVs8T3=rvnjhLVdAWEDXgDD_PW2mysmBWmksk2w@mail.gmail.com>
Message-ID: <CAAhV-H5HRXwGVs8T3=rvnjhLVdAWEDXgDD_PW2mysmBWmksk2w@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Requires __force attributes for any casts
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Queued for 5.20, thanks.

On Tue, Aug 2, 2022 at 2:09 PM Qing Zhang <zhangqing@loongson.cn> wrote:
>
> sudo make C=2
> warning:
> arch/loongarch/kernel/ptrace.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/ptrace.h, include/linux/audit.h):
> ./arch/loongarch/include/asm/uaccess.h:232:32: warning: incorrect type in argument 2 (different address spaces)
> ./arch/loongarch/include/asm/uaccess.h:232:32:    expected void const *from
> ./arch/loongarch/include/asm/uaccess.h:232:32:    got void const [noderef] __user *from
>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
>
> diff --git a/arch/loongarch/include/asm/uaccess.h b/arch/loongarch/include/asm/uaccess.h
> index 2b44edc604a2..a8ae2af4025a 100644
> --- a/arch/loongarch/include/asm/uaccess.h
> +++ b/arch/loongarch/include/asm/uaccess.h
> @@ -229,13 +229,13 @@ extern unsigned long __copy_user(void *to, const void *from, __kernel_size_t n);
>  static inline unsigned long __must_check
>  raw_copy_from_user(void *to, const void __user *from, unsigned long n)
>  {
> -       return __copy_user(to, from, n);
> +       return __copy_user(to, (__force const void *)from, n);
>  }
>
>  static inline unsigned long __must_check
>  raw_copy_to_user(void __user *to, const void *from, unsigned long n)
>  {
> -       return __copy_user(to, from, n);
> +       return __copy_user((__force void *)to, from, n);
>  }
>
>  #define INLINE_COPY_FROM_USER
> --
> 2.20.1
>
>
