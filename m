Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0493B33EE8A
	for <lists+linux-arch@lfdr.de>; Wed, 17 Mar 2021 11:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhCQKoc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Mar 2021 06:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhCQKoT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Mar 2021 06:44:19 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB91BC06174A;
        Wed, 17 Mar 2021 03:44:18 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v11so1290699wro.7;
        Wed, 17 Mar 2021 03:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bn90u44fy8L7FazXOSgNFKkR48EmU94fLQ8Y07NnDbg=;
        b=RookSN63CvIIb59cAjK0gkYTO2VoPpDwYkO5C4Mf4smeR2XbSEdgmY6GSS7qSum7QG
         bQZ2/C/LB2OAkIMlIt11q5glM6MddtfYSvxiZbQ4ioHduesNUy3EWcdCOpuScZvjQ4IH
         1Jba/B62kF3Byf57FIL/HB//GH6Gntzo3cLY0wbxK1zQkiGcJpyH8w/P3oiQre7oyQD+
         nqvSajOLwrOJka2syyzG6h0nLbTWdvsm9U3+gwdRYi4gejCzn3DdZihhhGUO7xpRkJjM
         OqVRxt+jVXVJ0ojSwRbiyIUTKr4/zrEMSWFrYP+DAdqqmuk1UzONGgyldg22kDEvEUvQ
         x5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Bn90u44fy8L7FazXOSgNFKkR48EmU94fLQ8Y07NnDbg=;
        b=Y+SGaMEt0JRAunhiDSBgDSt+Hh+MaABdWi2ZDaM1Rpryt3A858QK8yY1uzEBWpG+Xr
         DLKnMpg9nMho0aQha3IsKnZadvMtsnLOzKZmAaPPoacBDTgxiVIhRHr97bg/mqzMaKSx
         XPsNI6PWrT6L72K6OwRic6LdfA6fVGVlBHbwMD4BVxi0DX3/cA0OLlN1BFSJilx0ZRaK
         hswoDiUrD6luvtoQW4FGhhO+h7CJkVflQvEZthstfK+mV4YCCDpGpKSLpV9nX6ykA9UP
         xiHHM3ftnO/FFBdWtZijCd2nPg9pVAbBLERjmfps66cGVyZprjRcjxo2Ou0ud1/BA93Y
         KFzA==
X-Gm-Message-State: AOAM53162zy6JJaOxoAtiV+tycTIKRNpHQXy5PKrcm7X4HxW/RKdilo+
        NAkEEDJyUuHAZOlCYSYOicE=
X-Google-Smtp-Source: ABdhPJzMIr4AJ4UN6QhUkf9RjJgTZhqswu3fbGhNtj+qV4sOmO3SCxJg6IEQ/jBzMi23oJWP+3NezQ==
X-Received: by 2002:a05:6000:1acd:: with SMTP id i13mr1921557wry.48.1615977857523;
        Wed, 17 Mar 2021 03:44:17 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id h13sm2026914wmq.29.2021.03.17.03.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 03:44:17 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 17 Mar 2021 11:44:15 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     bp@suse.de, tglx@linutronix.de, luto@kernel.org, x86@kernel.org,
        len.brown@intel.com, dave.hansen@intel.com, hjl.tools@gmail.com,
        Dave.Martin@arm.com, jannh@google.com, mpe@ellerman.id.au,
        carlos@redhat.com, tony.luck@intel.com, ravi.v.shankar@intel.com,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/6] x86: Improve Minimum Alternate Stack Size
Message-ID: <20210317104415.GA692070@gmail.com>
References: <20210316065215.23768-1-chang.seok.bae@intel.com>
 <20210317100640.GC1724119@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317100640.GC1724119@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Chang S. Bae <chang.seok.bae@intel.com> wrote:
> 
> > During signal entry, the kernel pushes data onto the normal userspace
> > stack. On x86, the data pushed onto the user stack includes XSAVE state,
> > which has grown over time as new features and larger registers have been
> > added to the architecture.
> > 
> > MINSIGSTKSZ is a constant provided in the kernel signal.h headers and
> > typically distributed in lib-dev(el) packages, e.g. [1]. Its value is
> > compiled into programs and is part of the user/kernel ABI. The MINSIGSTKSZ
> > constant indicates to userspace how much data the kernel expects to push on
> > the user stack, [2][3].
> > 
> > However, this constant is much too small and does not reflect recent
> > additions to the architecture. For instance, when AVX-512 states are in
> > use, the signal frame size can be 3.5KB while MINSIGSTKSZ remains 2KB.
> > 
> > The bug report [4] explains this as an ABI issue. The small MINSIGSTKSZ can
> > cause user stack overflow when delivering a signal.
> 
> >   uapi: Define the aux vector AT_MINSIGSTKSZ
> >   x86/signal: Introduce helpers to get the maximum signal frame size
> >   x86/elf: Support a new ELF aux vector AT_MINSIGSTKSZ
> >   selftest/sigaltstack: Use the AT_MINSIGSTKSZ aux vector if available
> >   x86/signal: Detect and prevent an alternate signal stack overflow
> >   selftest/x86/signal: Include test cases for validating sigaltstack
> 
> So this looks really complicated, is this justified?
> 
> Why not just internally round up sigaltstack size if it's too small? 
> This would be more robust, as it would fix applications that use 
> MINSIGSTKSZ but don't use the new AT_MINSIGSTKSZ facility.
> 
> I.e. does AT_MINSIGSTKSZ have any other uses than avoiding the 
> segfault if MINSIGSTKSZ is used to create a small signal stack?

I.e. if the kernel sees a too small ->ss_size in sigaltstack() it 
would ignore ->ss_sp and mmap() a new sigaltstack instead and use that 
for the signal handler stack.

This would automatically make MINSIGSTKSZ - and other too small sizes 
work today, and in the future.

But the question is, is there user-space usage of sigaltstacks that 
relies on controlling or reading the contents of the stack?

longjmp using programs perhaps?

Thanks,

	Ingo
