Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9BE222D48
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jul 2020 22:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgGPUzP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jul 2020 16:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgGPUzO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 16:55:14 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D53C08C5C0
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2020 13:55:13 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t6so5466149pgq.1
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2020 13:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5MTI6j+IP80rlb/aM1c91JmfYfE5Osj9CRG4Mb8h3u8=;
        b=BUv2M4VRSD2wen45IsSL7yNTJnozpg/gwPGZodjItCPRDJfb7N4bKQjiX7XixbYm8P
         cIsboo5bKpOkxk3XtZVey2uiuX1eRBu5WIt92S/1k6oMZppoMS2xjZ2lYtLeFnGf5F42
         4VmBFpQ2GAs4br3hw2RsfpoSwHxlXKla8vxwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5MTI6j+IP80rlb/aM1c91JmfYfE5Osj9CRG4Mb8h3u8=;
        b=QzJXZj7CjpohqZkUUUjbNBEccODjM9ijsIK22KF2tMtZs/1oab0wPR50mdzQQJ5Bg+
         Vj7WYXrLoK9Cs9Nk6NbPg6r5kAqIGBuhkC2Rd2mjjkB4TNq2p6/fZG3d64cVLFwZtbNv
         wO4jRw3mSEBJ5Kf3ypeL7P+b2WiUHFm6LRQFkty5u6jEacUBoANXj49pflmR1V3Xmrq4
         XizXEndD8berp/cItyGLWQ+1wQkiAkbVSLPRahRYAlfGk1GdHADlpnP77XnNY/KUouuS
         +Vwk1AxDBrOjVmETdp8sy+aYUX7x0hwrOlGNjrWF+QUMwlu5e2eoBbwqzqwSgOSNFRWP
         mwuw==
X-Gm-Message-State: AOAM532zdQJdL1R6/nt8h4uMazNaP4g9EMsxmxIWx/1fMqSgpyUVdpOp
        I21G8LXZTQVhjTI7dPMNrNaEAg==
X-Google-Smtp-Source: ABdhPJwAy3pY3PKmw7KMXldIFkljrR5dKIYZZ376c+NTl4R4CSIRSOXzPuSZuhNstL3QzpzBisSHrA==
X-Received: by 2002:a63:3ec4:: with SMTP id l187mr5653642pga.371.1594932913054;
        Thu, 16 Jul 2020 13:55:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f15sm5823160pgr.36.2020.07.16.13.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 13:55:12 -0700 (PDT)
Date:   Thu, 16 Jul 2020 13:55:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: Re: [patch V3 02/13] entry: Provide generic syscall exit function
Message-ID: <202007161354.62030182F@keescook>
References: <20200716182208.180916541@linutronix.de>
 <20200716185424.116500611@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716185424.116500611@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 16, 2020 at 08:22:10PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Like syscall entry all architectures have similar and pointlessly different
> code to handle pending work before returning from a syscall to user space.
> 
>   1) One-time syscall exit work:
>       - rseq syscall exit
>       - audit
>       - syscall tracing
>       - tracehook (single stepping)
> 
>   2) Preparatory work
>       - Exit to user mode loop (common TIF handling).
>       - Architecture specific one time work arch_exit_to_user_mode_prepare()
>       - Address limit and lockdep checks
>      
>   3) Final transition (lockdep, tracing, context tracking, RCU). Invokes
>      arch_exit_to_user_mode() to handle e.g. speculation mitigations
> 
> Provide a generic version based on the x86 code which has all the RCU and
> instrumentation protections right.
> 
> Provide a variant for interrupt return to user mode as well which shares
> the above #2 and #3 work items.
> 
> After syscall_exit_to_user_mode() and irqentry_exit_to_user_mode() the
> architecture code just has to return to user space. The code after
> returning from these functions must not be instrumented.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

This looks correct to me. Did you happen to run the seccomp selftests
under this series?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
