Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5063C596157
	for <lists+linux-arch@lfdr.de>; Tue, 16 Aug 2022 19:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbiHPRmQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Aug 2022 13:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbiHPRmP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Aug 2022 13:42:15 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A487F27F;
        Tue, 16 Aug 2022 10:42:14 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id y11so8390963qvn.3;
        Tue, 16 Aug 2022 10:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=mHfKkxNjbITw4skw37Ngnw7bVj0soW59COm/Sw6u77c=;
        b=y3xGmeSUZxDqUkyWTVXFfEDhbbeBuwDOCNUZwWnaenxIsbYHqA/ITWdaEnaaSyazcp
         xn9Ii2y79NbGsYuM6jJHonumMthgbK+MFhWF0SG/gTHdEA8Yb1tWwUbThajEG/+RQKIl
         zGTDbuAQgBGPUn+ig5uIZBIM/y1SaMJJkPgEjlxuRyFOVkJAcmDjWNaZv33U+6bGhexM
         n9GMzP4uoBxYNgdNuN7s7+rJBzDN4A6aanmLBh9wsm3GXSwPAcMxyftABOiUEP1NgqfB
         K8Fq22xcamHwR9l2BBrrEIGAInJWG/QyBZ9dnKzXaAw9SnU/qlcDWeQxMOtC7OAzDSFn
         tWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=mHfKkxNjbITw4skw37Ngnw7bVj0soW59COm/Sw6u77c=;
        b=65Wr/Slxgbzktu79merW2A1OEhswFVPZIswBMWpBm1PnZxChipJRIuALfiacqRD1Uj
         8JjGvgIUwZmxZNs4C1R7xw77yIPwoHZbMFz4cKx6O+ROVLgnBGQmJcWmmmv2k9E4UWGh
         LhvjV/38jB4TtYY5gxpuahBChnse1WIhDNOoOFK6naTAxxYNYgM2UbFDddge/fJ2GI58
         nTogllpWNc9XlfA1vMUg2dS5yh4bkBlKwz0vIjSjpyUbiyFBHyw8EVJu5lNPeMmYWTzm
         U1sT+OVdnMTKFAfVUHUge09JuVMhzDOFyLn3+IYTD4hzV6Pgo80z4DcD+l0K0rEjMo5G
         dcQA==
X-Gm-Message-State: ACgBeo2ZS62+r8WVbzc8+Az5Vuhf2JL0caeWDbyjM3JyXjZUMht6al1p
        HOsB5zsjFI9f89QKGiUhBMEZt9wApaGZ3N35BT4=
X-Google-Smtp-Source: AA6agR7QnNx6w1nlDNLmCWs2O72rXsie4l2PUkDtlHCQtpflTwqqtV9/XXqd/Tl17j5Fq91jcXe9zzIc0+Wwsds2hz4=
X-Received: by 2002:a0c:c684:0:b0:494:d65c:f495 with SMTP id
 d4-20020a0cc684000000b00494d65cf495mr2814466qvj.24.1660671733904; Tue, 16 Aug
 2022 10:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <165791937063.2491387.15277418618265930924.stgit@djiang5-desk3.ch.intel.com>
 <20220718053039.5whjdcxynukildlo@offworld> <4bedc81d-62fa-7091-029e-a2e56b4f8f7a@intel.com>
 <20220803183729.00002183@huawei.com> <9f3705e1-de21-0f3c-12af-fd011b6d613d@intel.com>
 <YvO8pP7NUOdH17MM@FVFF77S0Q05N> <62f40fba338af_3ce6829466@dwillia2-xfh.jf.intel.com.notmuch>
 <20220815160706.tqd42dv24tgb7x7y@offworld> <Yvtc2u1J/qip8za9@worktop.programming.kicks-ass.net>
 <62fbcae511ec1_dfbc129453@dwillia2-xfh.jf.intel.com.notmuch> <20220816165301.4m4w6zsse62z4hxz@offworld>
In-Reply-To: <20220816165301.4m4w6zsse62z4hxz@offworld>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 16 Aug 2022 10:42:03 -0700
Message-ID: <CAA9_cmfBubQe6EGk5+wjotvofZavfjFud-JMPW13Au0gpAcWog@mail.gmail.com>
Subject: Re: [PATCH] arch/cacheflush: Introduce flush_all_caches()
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
        bwidawsk@kernel.org, ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, a.manzanares@samsung.com,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 16, 2022 at 10:30 AM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> On Tue, 16 Aug 2022, Dan Williams wrote:
>
> >Peter Zijlstra wrote:
> >> On Mon, Aug 15, 2022 at 09:07:06AM -0700, Davidlohr Bueso wrote:
> >> > diff --git a/arch/x86/include/asm/cacheflush.h b/arch/x86/include/asm/cacheflush.h
> >> > index b192d917a6d0..ce2ec9556093 100644
> >> > --- a/arch/x86/include/asm/cacheflush.h
> >> > +++ b/arch/x86/include/asm/cacheflush.h
> >> > @@ -10,4 +10,7 @@
> >> >
> >> >  void clflush_cache_range(void *addr, unsigned int size);
> >> >
> >> > +#define flush_all_caches() \
> >> > +  do { wbinvd_on_all_cpus(); } while(0)
> >> > +
> >>
> >> This is horrific... we've done our utmost best to remove all WBINVD
> >> usage and here you're adding it back in the most horrible form possible
> >> ?!?
> >>
> >> Please don't do this, do *NOT* use WBINVD.
> >
> >Unfortunately there are a few good options here, and the changelog did
> >not make clear that this is continuing legacy [1], not adding new wbinvd
> >usage.
>
> While I was hoping that it was obvious from the intel.c changes that this
> was not a new wbinvd, I can certainly improve the changelog with the below.

I also think this cache_flush_region() API wants a prominent comment
clarifying the limited applicability of this API. I.e. that it is not
for general purpose usage, not for VMs, and only for select bare metal
scenarios that instantaneously invalidate wide swaths of memory.
Otherwise, I can now see how this looks like a potentially scary
expansion of the usage of wbinvd.
