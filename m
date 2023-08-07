Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E937771902
	for <lists+linux-arch@lfdr.de>; Mon,  7 Aug 2023 06:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjHGEdA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 00:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjHGEc7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 00:32:59 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A60010F3;
        Sun,  6 Aug 2023 21:32:58 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1b8ad907ba4so25449075ad.0;
        Sun, 06 Aug 2023 21:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691382777; x=1691987577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZP6ot1gxaofWhtOIOHnBKXTDvnoNaKcb4Md9PixkQyc=;
        b=JpE0VwLH5eQnOCH8qhQfivTQXxL2MggpcpVa6M9AuVpmF5wlVhbeX3jm/FXgcRC7us
         Zhd7Rt22Kzunw1OBq3nsPjjHQ8ZS3KqMOIg6OcGkLgxJutgXxXtTFbU7merCku7fvxqn
         /4ygQiw/9NiOpFWg6dkeWym/rLf5/g2LlAfesa8mTkxdZW8DIc/ksl7mY5NkWy0xzxth
         QFdmoEpzFStHi28gFyqEScvcmIdEp3jNMaXmTDN7nb/HWxwcsotPYveMKi8XtaHGVVJ7
         QVMhZxLV7EoUqbbgknY0n2dDM8p2SQ83CnTXIQqOELD76P0EpUd9b/Zh/eDzg3nLco9w
         XgUg==
X-Gm-Message-State: AOJu0YwiCj6m6jAINy978dTo5sq507xCI9Ze7Hp3wjUjRxCTxDT66KIU
        uZhAH5thIbVQnTuSvUHZ78k=
X-Google-Smtp-Source: AGHT+IGeZ8MToiwQzxrc8JHhare2hbAI4DRctOwDwGzQ/zxT59h1r2IMzOcQIe5t1O1ukdPHQsB0Jg==
X-Received: by 2002:a17:902:ba95:b0:1b7:f546:44d7 with SMTP id k21-20020a170902ba9500b001b7f54644d7mr6084713pls.17.1691382777561;
        Sun, 06 Aug 2023 21:32:57 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902cf4600b001bb1f09189bsm5651977plg.221.2023.08.06.21.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 21:32:56 -0700 (PDT)
Date:   Mon, 7 Aug 2023 04:32:47 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com, Tianyu Lan <tiala@microsoft.com>,
        linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com
Subject: Re: [PATCH V4 0/9] x86/hyperv: Add AMD sev-snp enlightened guest
 support on hyperv
Message-ID: <ZNBz72iuI0WquOJf@liuwe-devbox-debian-v2>
References: <20230804152254.686317-1-ltykernel@gmail.com>
 <ZM2LDKrcXvVUVta9@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZM2LDKrcXvVUVta9@liuwe-devbox-debian-v2>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 04, 2023 at 11:34:36PM +0000, Wei Liu wrote:
> On Fri, Aug 04, 2023 at 11:22:44AM -0400, Tianyu Lan wrote:
> > From: Tianyu Lan <tiala@microsoft.com>
> [...]
> > Tianyu Lan (9):
> >   x86/hyperv: Add sev-snp enlightened guest static key
> >   x86/hyperv: Set Virtual Trust Level in VMBus init message
> >   x86/hyperv: Mark Hyper-V vp assist page unencrypted in SEV-SNP
> >     enlightened guest
> >   drivers: hv: Mark percpu hvcall input arg page unencrypted in SEV-SNP
> >     enlightened guest
> >   x86/hyperv: Use vmmcall to implement Hyper-V hypercall in sev-snp
> >     enlightened guest
> >   clocksource: hyper-v: Mark hyperv tsc page unencrypted in sev-snp
> >     enlightened guest
> >   x86/hyperv: Add smp support for SEV-SNP guest
> >   x86/hyperv: Add hyperv-specific handling for VMMCALL under SEV-ES
> 
> I applied all but the last patch to hyperv-next. Thanks.

This is causing build issues in linux-next. I've reverted this series
from hyperv-next.

> 
> >   x86/hyperv: Initialize cpu and memory for SEV-SNP enlightened guest
> 
