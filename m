Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56AF4A6060
	for <lists+linux-arch@lfdr.de>; Tue,  1 Feb 2022 16:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240234AbiBAPpK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Feb 2022 10:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240473AbiBAPpK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Feb 2022 10:45:10 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA7EC061744
        for <linux-arch@vger.kernel.org>; Tue,  1 Feb 2022 07:45:09 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l35-20020a05600c1d2300b0034d477271c1so1911313wms.3
        for <linux-arch@vger.kernel.org>; Tue, 01 Feb 2022 07:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LCcU9g3LWk+Ni1MDTb90PSlSH2Ejv1l38RdD5isGmzA=;
        b=dNCxlG7n/ZWCDBHispxymrFtrSs4c9YqEglHxbiG1ucYsKtBOTQqyfDQwy3eotCMjP
         uLM2L/H5EOfuyuixCibGBeRPuEqC7JcUChO4/5W88/l97mdNAgNvT/xqYmtLFgbKxh5n
         w5nISZOS0HKXiiexKQd+CqHtqM0kejpiHufa6rVenmJHxnYBkcSCvAZ+K0lfDvYe8v8/
         paGmxHQs3RqMpJLOQQe5QQ5vAOhsHvaHBxJGkYOele0OKszptBqf8ga7cK7KXkXhM0iv
         Gsb4gJ97geGtk3lJlPWcjuPmCn1m0Qbge+0Fy+Y8HGop/fCzxMmzbROs7ofYWtG8VEDd
         mjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LCcU9g3LWk+Ni1MDTb90PSlSH2Ejv1l38RdD5isGmzA=;
        b=eE5az1XdVCEvv7pNBXy8nKCH2ggOOoark5ItmGXRVGRFgPAD+IZIbkjvCuXS0+uogi
         jmgDMHVBvVpZ1x9SdklIILLS4UVlr2is65DQtNm5n5IMvK/YoXNpRuZWtsWlkgCZo1e8
         jLXQ8ib9no6p1SjGDF25W0Zdr7II6JsEY9JCHeVlixQEjeRcd4PLeQyFh54996vvvR3G
         rgZIrQfJHjnJFTkIr9sNVW5fKXgV5sO0GIhVRD2uvc/jcRBALwYwOXdlwHxpQ/MzalJ5
         aC4qnWC7YlR0yTuhY18ogKlGF+IYMNfvbjTC2gksdjuur+7ndEycIhUVcr6Rg0Jvwfxe
         lBNg==
X-Gm-Message-State: AOAM531Z687pt3Y2VaH64wbPX7apnRGwAFNGScJc1jxV3FI4qQD92Fz/
        l8n768Q536a2fMgDgesnRCXqw+0WA4TlwiKs4qHxmg==
X-Google-Smtp-Source: ABdhPJzLJXIjzEoU+zr9xqvCLUKq64QKzCzT5/D/E4v9iXKOT2PZW4bgO0vZKGKExLFNyrBqW6Lzx4h6BrcWo4/kvAI=
X-Received: by 2002:a7b:c929:: with SMTP id h9mr2237691wml.176.1643730307764;
 Tue, 01 Feb 2022 07:45:07 -0800 (PST)
MIME-Version: 1.0
References: <20220201150545.1512822-1-guoren@kernel.org> <20220201150545.1512822-22-guoren@kernel.org>
In-Reply-To: <20220201150545.1512822-22-guoren@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 1 Feb 2022 21:14:56 +0530
Message-ID: <CAAhSdy27nVvh9F08kPgffJe-Y-gOOc9cnQtCLFAE0GbDhHVbiQ@mail.gmail.com>
Subject: Re: [PATCH V5 21/21] KVM: compat: riscv: Prevent KVM_COMPAT from
 being selected
To:     Guo Ren <guoren@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        x86@kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        kvm-riscv@lists.infradead.org, KVM General <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

+Paolo

On Tue, Feb 1, 2022 at 8:38 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Current riscv doesn't support the 32bit KVM API. Let's make it
> clear by not selecting KVM_COMPAT.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Anup Patel <anup@brainfault.org>

This looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  virt/kvm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index f4834c20e4a6..a8c5c9f06b3c 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -53,7 +53,7 @@ config KVM_GENERIC_DIRTYLOG_READ_PROTECT
>
>  config KVM_COMPAT
>         def_bool y
> -       depends on KVM && COMPAT && !(S390 || ARM64)
> +       depends on KVM && COMPAT && !(S390 || ARM64 || RISCV)
>
>  config HAVE_KVM_IRQ_BYPASS
>         bool
> --
> 2.25.1
>
