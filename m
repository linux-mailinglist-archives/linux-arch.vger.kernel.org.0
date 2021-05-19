Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA483887DA
	for <lists+linux-arch@lfdr.de>; Wed, 19 May 2021 08:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhESG4G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 May 2021 02:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbhESG4G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 May 2021 02:56:06 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D1CC061760
        for <linux-arch@vger.kernel.org>; Tue, 18 May 2021 23:54:34 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id t21so6480918plo.2
        for <linux-arch@vger.kernel.org>; Tue, 18 May 2021 23:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2ScD741o+QURZZPw733RWWmwYXPFhfmlwQ+Cj/Nypb0=;
        b=cX7NlRVxOwOKhhSA4/69Ayqnip1ZqdQVgVcbl0bX/edQVkh3QLIKaii0yMSLrECxj+
         Dbvotak+LCZxfuQOc3f08xucZP8jQokPJjyMHYeBXHENqK/U3qXyjtgWmJHXc7f91PK6
         KTMoO0H4H0HWHbBk/0OR2tXgoAB93ZoPznOd/ACvhTFzSUwvaWppBpmZVbDyVNhneDmk
         KZVYGuEQOSKMWnh0kaRc34BqlJZoGw4bfVbgsHdbSK1UviGHP3zRK1BgqUC1A9dVSviH
         /KOgvBznGPu7GY8wGtR9tBiTF2fmLca+yccav0EOn60Oy/SUssiHLMUDAiJ4PBEenpbV
         4lXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2ScD741o+QURZZPw733RWWmwYXPFhfmlwQ+Cj/Nypb0=;
        b=Ba5jtW0bkrh/1VyYOrg4H9kCv12Yn0Bv7vFopbq2U47TVLGHHTNBbcls8QJa2A+hpU
         4ISKG6q4OIZXvDxAt5heKA7rNsNhQNavqQuQo0p+0FHR1uFOsY4hrWOJP817IbMv1RCq
         Da3FF4wu8BYBk3iagkA/60uLEkSDwcGJuRE6arPnJZYOVo1A5bgWL4kOxMOtclrokTyr
         pLXuOEMgkqf90jnQ6mbsqAj/Zpp7rkJxHBbmGGLKZEd8GHEaVzyp8PW08EQDpbR3Vq90
         3VlNZQcK5JcP2dk205XVmKK/6RTh0cy2aMl683JIq/wBb9thr7OC2uC4X5sIn0WCGgZF
         DlZw==
X-Gm-Message-State: AOAM5319cX9kMDBFumnqQgeZ+0qBF9YTAP2q1sjIDfJaxQcVIHjIodk7
        Kp2uZD++M1D33W5oPcDsYOrWMw==
X-Google-Smtp-Source: ABdhPJx+meH2AZClfHyVtpeacNdTvFk5+2vdyzAovgo9a7hj5AkNu+XhOzxniHuRliV60D2l7mpiQA==
X-Received: by 2002:a17:90a:560b:: with SMTP id r11mr10039603pjf.224.1621407273992;
        Tue, 18 May 2021 23:54:33 -0700 (PDT)
Received: from x1 ([2601:1c0:4701:ae70:9384:8c4b:dc2b:c4d0])
        by smtp.gmail.com with ESMTPSA id k14sm5063003pfu.80.2021.05.18.23.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 23:54:33 -0700 (PDT)
Date:   Tue, 18 May 2021 23:54:31 -0700
From:   Drew Fustini <drew@beagleboard.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Guo Ren <guoren@kernel.org>, Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>, wefu@redhat.com,
        lazyparser@gmail.com,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>,
        paul.walmsley@sifive.com
Subject: Re: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
Message-ID: <20210519065431.GB3076809@x1>
References: <1621400656-25678-1-git-send-email-guoren@kernel.org>
 <20210519052048.GA24853@lst.de>
 <CAJF2gTR5838=Uwc5P6Xs=G7vk80k0yqWcSsNe0OFcwc9sDBBHg@mail.gmail.com>
 <20210519060617.GA28397@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519060617.GA28397@lst.de>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 19, 2021 at 08:06:17AM +0200, Christoph Hellwig wrote:
> On Wed, May 19, 2021 at 02:05:00PM +0800, Guo Ren wrote:
> > Since the existing RISC-V ISA cannot solve this problem, it is better
> > to provide some configuration for the SOC vendor to customize.
> 
> We've been talking about this problem for close to five years.  So no,
> if you don't manage to get the feature into the ISA it can't be
> supported.

Isn't it a good goal for Linux to support the capabilities present in
the SoC that a currently being fab'd?

I believe the CMO group only started last year [1] so the RV64GC SoCs
that are going into mass production this year would not have had the
opporuntiy of utilizing any RISC-V ISA extension for handling cache
management.

Thanks,
Drew

[1] https://github.com/riscv/riscv-CMOs
