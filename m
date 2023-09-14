Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8176E79FD47
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 09:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbjINHdL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 03:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjINHdK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 03:33:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE0C8CF1
        for <linux-arch@vger.kernel.org>; Thu, 14 Sep 2023 00:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694676746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zeXUZmzA2R78d6Tnnb+ykDeaJ41fYcPMQRTIom5IJuI=;
        b=XNDRgndW/I6ws6MgXUN1d23QLtx1zRTy1EFAUJHjfKJSQwgXO7Twd602JSzYL3RP+wXJmJ
        F73SG+gzHKUx8460yaAm4TO9k8iUS9DdjZARvVW+G2GwbZ4DnYYP43qFdgh/IdQ0mW3PSj
        TCDxfHn0tAUMS5ICW3BgE6KNn/HdOLY=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-Ft1RqmUFPQqHDdY8AmZgxQ-1; Thu, 14 Sep 2023 03:32:20 -0400
X-MC-Unique: Ft1RqmUFPQqHDdY8AmZgxQ-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6bdcdde1df9so916576a34.2
        for <linux-arch@vger.kernel.org>; Thu, 14 Sep 2023 00:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694676740; x=1695281540;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zeXUZmzA2R78d6Tnnb+ykDeaJ41fYcPMQRTIom5IJuI=;
        b=ma1A4g6cUinvd2Ss778YbWU1ifyOWwElvHllP6EqJmhdzsyd8PIUP6+GFNJ/+LgEDA
         G0GKgSFE91zd2KsPPVUiFVlHXUy4KllHZo2nUsyzJ8vfVXjS/WuBQVR9YAH5GGW9NJ40
         XaJ/iyQGaWgXbKZovWdXzxbBv001OM99b7/mm4jfM+/FOR1SE9NsCxyZPP+KZYbU9h4D
         aYSrmyQbpmclzWBnerhwVQxe+hOIP7IwPQS+INUvkCHn9wTSQGN/HcpB4Yq1CuWS26/9
         2TlcRe6HTeQy0rx5RUyaTbgTqn2vdE7zkahl2s+I1iGbUtz3WeA6BDFgKs4Nn6raF90I
         WbPA==
X-Gm-Message-State: AOJu0YycYtCNsQyY2pZHuJAo6zFlmHjQPHA8kmNiZz+FsZjFmYmatXCk
        4Z6iWMTzA/qK/DRrtTXW9FPbjFPHEJBO2mxhg0ZfykDsVoj+A7Yu/JVE6k+PqOXbwhfQFWsj4vW
        41hNhiWvymIE5lEM2oz3yAA==
X-Received: by 2002:a9d:7748:0:b0:6b7:6e07:4951 with SMTP id t8-20020a9d7748000000b006b76e074951mr5156987otl.25.1694676740039;
        Thu, 14 Sep 2023 00:32:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr6lIrxX3lHcIWXsLn8H+SAhlSeGClLIiE+FDMDpEhnhKKTf67DlStq8kfOI9KIS1JIF/G5A==
X-Received: by 2002:a9d:7748:0:b0:6b7:6e07:4951 with SMTP id t8-20020a9d7748000000b006b76e074951mr5156960otl.25.1694676739790;
        Thu, 14 Sep 2023 00:32:19 -0700 (PDT)
Received: from redhat.com ([2804:1b3:a803:4ff9:7c29:fe41:6aa7:43df])
        by smtp.gmail.com with ESMTPSA id v25-20020a9d69d9000000b006b83a36c08bsm421777oto.53.2023.09.14.00.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 00:32:19 -0700 (PDT)
Date:   Thu, 14 Sep 2023 04:32:08 -0300
From:   Leonardo Bras <leobras@redhat.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Waiman Long <longman@redhat.com>, paul.walmsley@sifive.com,
        anup@brainfault.org, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, palmer@rivosinc.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V11 07/17] riscv: qspinlock: Introduce qspinlock param
 for command line
Message-ID: <ZQK2-CIL9U_QdMjh@redhat.com>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-8-guoren@kernel.org>
 <5ba0b8f3-f8f5-3a25-e9b7-f29a1abe654a@redhat.com>
 <CAJF2gTT2hRxgnQt+WJ9P0YBWnUaZJ1-9g3ZE9tOz_MiLSsUjwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTT2hRxgnQt+WJ9P0YBWnUaZJ1-9g3ZE9tOz_MiLSsUjwQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 12, 2023 at 09:08:34AM +0800, Guo Ren wrote:
> On Mon, Sep 11, 2023 at 11:34 PM Waiman Long <longman@redhat.com> wrote:
> >
> > On 9/10/23 04:29, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > Allow cmdline to force the kernel to use queued_spinlock when
> > > CONFIG_RISCV_COMBO_SPINLOCKS=y.
> > >
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > ---
> > >   Documentation/admin-guide/kernel-parameters.txt |  2 ++
> > >   arch/riscv/kernel/setup.c                       | 16 +++++++++++++++-
> > >   2 files changed, 17 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index 7dfb540c4f6c..61cacb8dfd0e 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -4693,6 +4693,8 @@
> > >                       [KNL] Number of legacy pty's. Overwrites compiled-in
> > >                       default number.
> > >
> > > +     qspinlock       [RISCV] Force to use qspinlock or auto-detect spinlock.
> > > +
> > >       qspinlock.numa_spinlock_threshold_ns=   [NUMA, PV_OPS]
> > >                       Set the time threshold in nanoseconds for the
> > >                       number of intra-node lock hand-offs before the
> > > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > > index a447cf360a18..0f084f037651 100644
> > > --- a/arch/riscv/kernel/setup.c
> > > +++ b/arch/riscv/kernel/setup.c
> > > @@ -270,6 +270,15 @@ static void __init parse_dtb(void)
> > >   }
> > >
> > >   #ifdef CONFIG_RISCV_COMBO_SPINLOCKS
> > > +bool enable_qspinlock_key = false;
> >
> > You can use __ro_after_init qualifier for enable_qspinlock_key. BTW,
> > this is not a static key, just a simple flag. So what is the point of
> > the _key suffix?
> Okay, I would change it to:
> bool enable_qspinlock_flag __ro_after_init = false;

IIUC, this bool / flag is used in a single file, so it makes sense for it 
to be static. Being static means it does not need to be initialized to 
false, as it's standard to zero-fill this areas.

Also, since it's a bool, it does not need to be called _flag.

I would go with:

static bool enable_qspinlock __ro_after_init;


> 
> >
> > Cheers,
> > Longman
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 

