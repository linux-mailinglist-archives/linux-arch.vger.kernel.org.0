Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3EAA25D108
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 07:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgIDF6b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Sep 2020 01:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgIDF6a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Sep 2020 01:58:30 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE36AC061244;
        Thu,  3 Sep 2020 22:58:29 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l17so4894303edq.12;
        Thu, 03 Sep 2020 22:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=86/hDza+7M+cBpbx4SYN2mNKlPBD4Khd4N7abYdp5es=;
        b=INFYiCzmKU5iRQe53yQOFtmJQLAE0oYHTB6GP7SpNat6APmdvxU7CFfVGsOjm0Zto8
         +Y0XjZoAfwtJDOhvF5OsWU5oQQyUQmfpjTt6n+Fqok+l/YzBvTHtkz3WvNmO9f9WZ6Tl
         Vi+vUgPP+WzubQlb3Pf5wQQ/2vK1sk4vD8dWEznnxJx9IkBNSKmQriauqGWDzRLo0gG7
         VI8z/rIRvNRpB6Q/YL8rsM5fb6sHUBf/mf3N0+adBR3VyjGcnVJgZxmKyMSBx6ICd4VF
         S35cHKZhRM5s64mDTpYHaob7cWV4fflraLlbLhMcl51PorbbNws+VWiGnRpQ3VeZCAqn
         NFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=86/hDza+7M+cBpbx4SYN2mNKlPBD4Khd4N7abYdp5es=;
        b=fLuNSmmNZADVY1sNl92nu1EJ4dYiKpiVbAY86gPZ3nw5eYT6UV6Y3FgcJlc1KZ/lD3
         2fIH9YirPDpDvRvGOxNfXw6HoSfBCoCG3YSu3gMRlX/UPOaTKuDKkbAIhb7BhDkxPQq1
         seYe27Q974iG661ulR1j3hu7T+qpM4UKlGQzt1n3xn3DiDNugzKExIyqgMi2E4petdA0
         9HiA97kwuFFIQoLwdWUeTsAcU3bEb9X3c5qQTZJE3pjv/sKSiOP22WLCNpZiIN6E+9SD
         OIVcJaS5ZOGYDp9rCsquxWro384wDgMGR+Pq+2KRE8DCUN4VTyMsTU/av4pvH/PzVYQ1
         wRUA==
X-Gm-Message-State: AOAM532+pH35DUz6M+0zcy5j87NBeI6WqLWpumtB8Gis2fObnpGSHikH
        OVBcYKEneqVZhyyZnzKB0Hw=
X-Google-Smtp-Source: ABdhPJwWt7ZQxHXwfHlIAvDC4aqzZ2345pSsFoI7PTTwHE6eLo8+11eQMMVi7nzT7RaJhdxO9p5+OA==
X-Received: by 2002:a50:fd19:: with SMTP id i25mr6926242eds.142.1599199108527;
        Thu, 03 Sep 2020 22:58:28 -0700 (PDT)
Received: from gmail.com (563BA415.dsl.pool.telekom.hu. [86.59.164.21])
        by smtp.gmail.com with ESMTPSA id c8sm5158129ejp.30.2020.09.03.22.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 22:58:27 -0700 (PDT)
Date:   Fri, 4 Sep 2020 07:58:25 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 0/5] Warn on orphan section placement
Message-ID: <20200904055825.GA2779622@gmail.com>
References: <20200902025347.2504702-1-keescook@chromium.org>
 <CAKwvOd=r8X1UeBRgYMcjUoQX_nbOEbXCQYGX6n7kMnJhGXis=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=r8X1UeBRgYMcjUoQX_nbOEbXCQYGX6n7kMnJhGXis=Q@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Nick Desaulniers <ndesaulniers@google.com> wrote:

> On Tue, Sep 1, 2020 at 7:53 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Hi Ingo,
> >
> > The ever-shortening series. ;) Here is "v7", which is just the remaining
> > Makefile changes to enable orphan section warnings, now updated to
> > include ld-option calls.
> >
> > Thanks for getting this all into -tip!
> 
> For the series,
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> As the recent ppc vdso boogaloo exposed, what about the vdsos?
> * arch/x86/entry/vdso/Makefile
> * arch/arm/vdso/Makefile
> * arch/arm64/kernel/vdso/Makefile
> * arch/arm64/kernel/vdso32/Makefile

Kees, will these patches DTRT for the vDSO builds? I will be unable to test 
these patches on that old system until tomorrow the earliest.

I'm keeping these latest changes in WIP.core/build for now.

Thanks,

	Ingo
