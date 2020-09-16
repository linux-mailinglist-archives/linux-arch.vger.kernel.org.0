Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B618726C78B
	for <lists+linux-arch@lfdr.de>; Wed, 16 Sep 2020 20:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgIPS3z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Sep 2020 14:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbgIPS3k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Sep 2020 14:29:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3812C0698E2
        for <linux-arch@vger.kernel.org>; Wed, 16 Sep 2020 04:54:07 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a9so2707072wmm.2
        for <linux-arch@vger.kernel.org>; Wed, 16 Sep 2020 04:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yh0igFnXFGH3K7pZzQhRNs7ViU5/hMjpnGkORzHpipk=;
        b=JyQsV3C/yV+HMhjcrBeo4b6vbtbXN/7M7NJbIgBea1ZCl6bB/Wv56zT6tM39MhZYIz
         1ePZsPTW5M75mT5wRpRoNtZy/x1FJ8O69Jo5IFaxDlzHdWeRiNrB4GKbyft7T7Rf3m7c
         aWwz5PsssRQJClQFnacWnvlS5MQg4yUM9L2jw8VuALu4NTPRUxNv67kIW5FUWGPCDVP9
         yMm7HzrgXsD04qEeBHOQTjc1spMBk+h1ObSRut8UsG0poo7gRH4ptNx9EujbEMj5Cb7U
         w4FXV2249ahLD5jNOQ2ov9+67BvirUZC0p0CE4a+dXdPSDP2nJyRXQPZXP6lPs90vfLk
         zTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yh0igFnXFGH3K7pZzQhRNs7ViU5/hMjpnGkORzHpipk=;
        b=rW18dtKAogbnQQhfULQA17dKUJ1W7ZXKxlxGPlas9CSSa5MvpUmn2VtFgxYhpkrQ0z
         YvrPxtDSeeHk8VQpmOdqcUf9+RTkx0lWEu92TQXGkbgJAS+m1cC7a8FTAY5Bx3dtwTDk
         qtX8DPUXcl2gsM29+bOSRl7LnfYtedtcJAGgy2gjnPCMIX4VnMbo43UQwnP8FTNax7Ve
         /AVlkuFoJGmXflavzQAPt00sGt4aU5xk3ZUKwXMtssUZdLxruLMZPPBHyOWpkZSQxShv
         xcXtr/bLAopzBazWGpc/0yGVfdAUBvQNqdpl8fDjTLpKhKpfG8o8lkJK1aS0KD8pV2jd
         Agug==
X-Gm-Message-State: AOAM533DCSW268z/TaJWng1umooEXQN5aIghR9qNAntYdAMHOT+ShVF6
        XL9Fan9vVhIUH0IMSotUVAUJMw==
X-Google-Smtp-Source: ABdhPJwEUCld1s87TOjbwzmcs50r5qVIn7ePIrzWPUYEsAFENq0CtkJ+OctMHBN++deLK1KNg4U8hw==
X-Received: by 2002:a05:600c:2118:: with SMTP id u24mr4258846wml.59.1600257246355;
        Wed, 16 Sep 2020 04:54:06 -0700 (PDT)
Received: from google.com ([2a01:4b00:8523:2d03:e49d:f6be:d31b:ad3c])
        by smtp.gmail.com with ESMTPSA id u66sm5088416wmg.44.2020.09.16.04.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 04:54:05 -0700 (PDT)
Date:   Wed, 16 Sep 2020 12:54:04 +0100
From:   David Brazdil <dbrazdil@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 00/10] Independent per-CPU data section for nVHE
Message-ID: <20200916115404.rhv4dkyjz35e4x25@google.com>
References: <20200903091712.46456-1-dbrazdil@google.com>
 <20200914174008.GA25238@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914174008.GA25238@willie-the-truck>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Will,

On Mon, Sep 14, 2020 at 06:40:09PM +0100, Will Deacon wrote:
> Hi David,
> 
> On Thu, Sep 03, 2020 at 11:17:02AM +0200, David Brazdil wrote:
> > Introduce '.hyp.data..percpu' as part of ongoing effort to make nVHE
> > hyp code self-contained and independent of the rest of the kernel.
> > 
> > The series builds on top of the "Split off nVHE hyp code" series which
> > used objcopy to rename '.text' to '.hyp.text' and prefix all ELF
> > symbols with '__kvm_nvhe' for all object files under kvm/hyp/nvhe.
> 
> I've been playing around with this series this afternoon, trying to see
> if we can reduce the coupling between the nVHE code and the core code. I've
> ended up with the diff below on top of your series, but I think it actually
> removes the need to change the core code at all. The idea is to collapse
> the percpu sections during prelink, and then we can just deal with the
> resulting data section a bit like we do for .hyp.text already.
> 
> Have I missed something critical?

I was wondering whether this approach would be sufficient as well because of
the simplicity. We'd just need to be careful about correctly preserving the
semantics of the different .data..percpu..* sections.

For instance, I've noticed you make .hyp..data..percpu page-aligned rather than
cacheline-aligned. We need that for stage-2 unmapping but it also happens to
correctly align DEFINE_PER_CPU_PAGE_ALIGNED variables when collapsed into the
single hyp section. The reason why I ended up reusing the global macro was to
avoid introducing subtleties like that into the arm64 linker script. Do you
think it's a worthwhile trade off?

One place where this approach doesn't work is DEFINE_PER_CPU_FIRST. But I'm
guessing that's something we can live without.

I was also wondering about another approach - using the PERCPU_SECTION macro
unchanged in the hyp linker script. It would lay out a single .data..percpu and
we would then prefix it with .hyp and the symbols with __kvm_nvhe_ as with
everything else. WDYT? Haven't tried that yet, could be a naive idea. 

Thanks for reviewing,
David
