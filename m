Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B43E5A6BA9
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2019 16:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfICOiH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Sep 2019 10:38:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfICOiH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 3 Sep 2019 10:38:07 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E0D520828;
        Tue,  3 Sep 2019 14:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567521486;
        bh=NYvh1Ty2TcysP6q9uoPqBfVZ4o8Dsna8O9GWcNeTjPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OJb3Kho20mdnwL0J0X12EPvZi+YCveo7/1MvWOJty8arm52+WGvg72faQoeDkDslp
         gcXbCoUgsYIImpD8m9W/cZZXzmw/u/1Ai/IOtMCjmud5lXAkRUAZliTRZJFjfkXUvV
         F/jRoBkgB+zfTcpRpoe3lmbufzbFVwL5ziqsj2V4=
Date:   Tue, 3 Sep 2019 15:38:01 +0100
From:   Will Deacon <will@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org, catalin.marinas@arm.com,
        0x7f454c46@gmail.com, salyzyn@android.com, paul.burton@mips.com,
        luto@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v2 1/8] arm64: compat: vdso: Expose BUILD_VDSO32
Message-ID: <20190903143800.k6r663abs2g2ddpg@willie-the-truck>
References: <20190830135902.20861-1-vincenzo.frascino@arm.com>
 <20190830135902.20861-2-vincenzo.frascino@arm.com>
 <c0b1673d-e37d-a526-0862-ad07f779f5bf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0b1673d-e37d-a526-0862-ad07f779f5bf@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 03, 2019 at 03:36:16PM +0100, Vincenzo Frascino wrote:
> On 8/30/19 2:58 PM, Vincenzo Frascino wrote:
> > clock_gettime32 and clock_getres_time32 should be compiled only with the
> > 32 bit vdso library.
> > 
> > Expose BUILD_VDSO32 when arm64 compat is compiled, to provide an
> > indication to the generic library to include these symbols.
> > 
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> >  arch/arm64/include/asm/vdso/compat_gettimeofday.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
> > index c50ee1b7d5cd..fe7afe0f1a3d 100644
> > --- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
> > +++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
> > @@ -17,6 +17,7 @@
> >  #define VDSO_HAS_CLOCK_GETRES		1
> >  
> >  #define VDSO_HAS_32BIT_FALLBACK		1
> > +#define BUILD_VDSO32			1
> >  
> >  static __always_inline
> >  int gettimeofday_fallback(struct __kernel_old_timeval *_tv,
> > 
> 
> This patch is independent from the rest and touches only arch code. Can it go in
> via the arm64 tree?

Why not take it via -tip along with patch 6? Otherwise we'll get a silly
conflict. I'd assumed this series was going in as one thing.

Will
