Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93B653D632
	for <lists+linux-arch@lfdr.de>; Sat,  4 Jun 2022 11:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbiFDJG4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 4 Jun 2022 05:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbiFDJFJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 4 Jun 2022 05:05:09 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA092CCB9
        for <linux-arch@vger.kernel.org>; Sat,  4 Jun 2022 02:05:07 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id s23so7772896iog.13
        for <linux-arch@vger.kernel.org>; Sat, 04 Jun 2022 02:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jYaLFEWOclihFzS4U6IplAacKFcgmJCfQWRbC9TywlA=;
        b=DFbzDDxzzgjke7pdno7CWB4tuZpk+kXbMoki0TZvjjHhBTWaV3zAGYNmLLb7vFloEE
         O+aGUyFZ/+StgH327dmNb93EzZECVzDM/iVpZb/JtbgrsbUmhvyUQpkVmswciBGyXVcH
         x1amxkts5wSnsJNlAN/lMrjAVfLTRNnTJ6aobE3eGIVswmcKsTW0mYXmmiyX7ENTp7aT
         ua0LypeaCyhP+IFQ34GtXSpqQBQOAey+Tek1CPruwQWSLB5ieICAGRrF98c9Vq62C83J
         p+YWNGn5pYDMnt/E5EXOW3WEbwGqrpAvWMF8hmhSHeWQqqLEEswcLHA1/wUu6hzSdzm7
         xIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jYaLFEWOclihFzS4U6IplAacKFcgmJCfQWRbC9TywlA=;
        b=sxPUmkLFL2atzUGySaqSPBkfcq8lAAbalsyPPQp6P8dS6ES7sCAaqEhg5bT7kJ3N7k
         N4YPlyRuhE25C+3ImU1WdIxvaPcVQ+hsrb768FtgtTTeCH+7GNjgF+hopAvVUNd1PbSF
         Hz7sFVHvoNfglqPxNpGvLFnA11oCl/3RQsKKSBWR3vtraISA0qaBl0W/84irkO2IDBp+
         NbI2yQP7FHN36JA7j/5WvXSYmfZftRGP/1s1xtKBf1TtTXbTdrDNIS9wW8z+ztayHGsr
         ijsclZA2jc9bimsQEo2U6PUQs3mtlbBXLDSc3xO9Aq9oOY8OkYQkT444c68umajyP5f9
         0hAQ==
X-Gm-Message-State: AOAM5316GHL8piWrM1V1kcqrsQiNOs2u+IHDjlf0swnpF1L5lwseA49a
        nUmQKoGgqINwf0BMNqEIMNRmyGpi0o1wk6POokoMefq7KV82Yg==
X-Google-Smtp-Source: ABdhPJyjKi15HbGLMlhq7JQ6Y/8NMlIOgXotxyeIUuKyYf3hF7LZyHrZ286RyhiuDHPZ7D83gaWhkTbWHiZU9ZNQhcU=
X-Received: by 2002:a02:860d:0:b0:32b:2210:95c with SMTP id
 e13-20020a02860d000000b0032b2210095cmr7707895jai.175.1654333507329; Sat, 04
 Jun 2022 02:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220604080614.268078-1-chenhuacai@loongson.cn> <fefe35c1-4bcc-b8e8-6f3f-8d71209a2c13@xen0n.name>
In-Reply-To: <fefe35c1-4bcc-b8e8-6f3f-8d71209a2c13@xen0n.name>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 4 Jun 2022 17:04:57 +0800
Message-ID: <CAAhV-H4Dr2xJBiQr6tjkpSj+uDEJbKMCXPG0DPZrxAcVYE6G_A@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Fix copy_thread() build error
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Xuerui,

On Sat, Jun 4, 2022 at 4:39 PM WANG Xuerui <kernel@xen0n.name> wrote:
>
> On 6/4/22 16:06, Huacai Chen wrote:
> > Commit c5febea0956fd387 ("fork: Pass struct kernel_clone_args into
> > copy_thread") change the prototype of copy_thread() and cause build
> > error, fix it.
> >
> > Fixes: c5febea0956fd387 ("fork: Pass struct kernel_clone_args into copy_thread")
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   arch/loongarch/kernel/process.c | 7 +++++--
> >   include/linux/efi.h             | 1 +
> >   include/linux/pe.h              | 2 ++
> >   3 files changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
> > index 6d944d65f600..5e090ffd16b9 100644
> > --- a/arch/loongarch/kernel/process.c
> > +++ b/arch/loongarch/kernel/process.c
> > @@ -120,10 +120,13 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
> >   /*
> >    * Copy architecture-specific thread state
> >    */
> > -int copy_thread(unsigned long clone_flags, unsigned long usp,
> > -     unsigned long kthread_arg, struct task_struct *p, unsigned long tls)
> > +int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
> >   {
> >       unsigned long childksp;
> > +     unsigned long tls = args->tls;
> > +     unsigned long usp = args->stack;
> > +     unsigned long clone_flags = args->flags;
> > +     unsigned long kthread_arg = args->stack_size;
> >       struct pt_regs *childregs, *regs = current_pt_regs();
> >
> >       childksp = (unsigned long)task_stack_page(p) + THREAD_SIZE - 32;
> Please confirm if the patch is inadvertently truncated? I see there are
> 3 files in the diffstat, yet only one hunk below.
I'm sorry, this is my fault.

Huacai
