Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89467437ADD
	for <lists+linux-arch@lfdr.de>; Fri, 22 Oct 2021 18:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhJVQ15 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Oct 2021 12:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbhJVQ15 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Oct 2021 12:27:57 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE22C061764
        for <linux-arch@vger.kernel.org>; Fri, 22 Oct 2021 09:25:39 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id o133so4098973pfg.7
        for <linux-arch@vger.kernel.org>; Fri, 22 Oct 2021 09:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oY8QSYkniGy4foDwgoWYdCetbab1zPbJRB3YWoKstsE=;
        b=MUWNx3ydXkRZ7nB7ArzoWGGeu6JqXj7Ky5ZfIDscQDuCMzNfx+xgFPGBWy+zDWUY47
         3PYKPYxfkr0ddwz1kNVl+ytmt7rTBfCSOspw/QU3EuapopAnO+fibI4sj+///UjF2JdW
         lJnBm1GFhR2UhelUXjKKZzhsgkVqsnJB3pKF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oY8QSYkniGy4foDwgoWYdCetbab1zPbJRB3YWoKstsE=;
        b=QQbI064/70e561qYms5XgUgsNoIzfXO8ctp92AO8n40JExUPmE/te49uYP2SZTyxuP
         djgcWj3z4x4sJPzE7kd992ofO/mgHD1czLL4oPKZmnH0TwXaMLjSuFHsS862F84nHQG2
         ozsAoFB2YrE/H1IcmUyPEIuvtuxP5xf/1ydEAOxwcdanfSAjiXdALJ5cA934pqHhalq2
         ME4nmAOuhazPQO/V0sdzbU9jtCTAO0m5sB1ACpmZ2xfGNQTOJRqXxTMawe9fIZyPvGZS
         NNSgi1xV1VS9kVnd0kj+PPw0HscK/MJ/5AbXE6mCZCK9f4nVnxsC/2wjm53wXzL4z6qd
         DarA==
X-Gm-Message-State: AOAM532ir7ZEuvWD7gZ9BRtiF/EEOjpXbp+T8QEHs3aU55/JChYKiwBO
        h8LyGDdmcDVKcI+TVDA0mfqNBA==
X-Google-Smtp-Source: ABdhPJwuLhj8Lhk+PvZk4Vj66qz3fpKXwmJq6CzRpEAOw69JTAOqJlloI73LhZpzAFtBIsPB633tEg==
X-Received: by 2002:a63:c:: with SMTP id 12mr508399pga.477.1634919939440;
        Fri, 22 Oct 2021 09:25:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mu7sm11214296pjb.12.2021.10.22.09.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 09:25:39 -0700 (PDT)
Date:   Fri, 22 Oct 2021 09:25:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, akpm@linux-foundation.org,
        mark.rutland@arm.com, zhengqi.arch@bytedance.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-arch@vger.kernel.org, ardb@kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/7] x86: Fix __get_wchan() for !STACKTRACE
Message-ID: <202110220925.C2A17F092@keescook>
References: <20211022150933.883959987@infradead.org>
 <20211022152104.137058575@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022152104.137058575@infradead.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 22, 2021 at 05:09:34PM +0200, Peter Zijlstra wrote:
> Use asm/unwind.h to implement wchan, since we cannot always rely on
> STACKTRACE=y.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: bc9bbb81730e ("x86: Fix get_wchan() to support the ORC unwinder")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
