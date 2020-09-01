Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9336C258A2C
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 10:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgIAIQx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 04:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgIAIQw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 04:16:52 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017F8C061244;
        Tue,  1 Sep 2020 01:16:51 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id c8so574692edv.5;
        Tue, 01 Sep 2020 01:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=swNovB3+fcrt09IBXHVDolTV6/eIXMyoTVYnepRz3fU=;
        b=pABpQ7tZu55e1f7KIWPfqDj7rsSVuHqj7SJd/BNyJtUBlGl3fCXeatZv2VT0Jd7GMy
         CRWI47ko52llmTPN8DSc/qdPwBoeMA0kOw7DyMGgCxAkIFd6Da80nZoAGw17JUz/x6MT
         gEp/23jWYkPvQGV8ouufw/AZF9MYGxg1UBsX0uZImngKkWcDopJtQJ31oT+y2oO6bhsM
         EPbyUx3Go/apQcYolTzEse8P/AnQM2q8YWBROfWcWpGuuRT0kncwn2ORUu1OGGaK4IfZ
         0Ky33sQw/xRKFZjyGNb4ePn/yWz/Digj/WlMevz33aRyx4Q+lqjX4Qx8xt6C+V+qE7Jw
         0azg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=swNovB3+fcrt09IBXHVDolTV6/eIXMyoTVYnepRz3fU=;
        b=EQ96BH/ZVLgRZBmrq7fNXQXDkZ5z75NrzuXy2a3gSuztAPdj7/G+9QXowatIN7jK28
         i6EvRaSr7CLFOfmbnj8Xzck8fV5J4OpkGyWACTsCTwRHrelijOvAdNGxpnKaaFrtreck
         1O/GH2An3CR2vpVstjdNE39ZKobura9V5A9/IbKIyx6JJmd/IXU7ZTSmQ61uW/0HjA+V
         vhalr5sF8BuQoq6APoAiKmYjxdxwyl3jYGDeFG59relYgxfQqKWOVuYXJyfaAkd9OTIY
         A/w6MlIBSb9Qc2Q5KNPXeblipftCPg8jNIwQ7SiINcLRIEoAX63EO6dc+7ESOtGduESA
         mM1A==
X-Gm-Message-State: AOAM530Y2jFYXBkbg5e0XitaxR5oIXGOtDvNggJkm2N3Zw82qDAy7iMI
        h7FptDurSsMzuIn4Rd/Fpvc=
X-Google-Smtp-Source: ABdhPJx2ptuL7kkygWDLtZF4JRxA4A4z1gr2neF5/3bsbYzIVwapfuJUGyH19AxYNzkhui1xtmfaiw==
X-Received: by 2002:a50:d942:: with SMTP id u2mr802309edj.0.1598948210504;
        Tue, 01 Sep 2020 01:16:50 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id k10sm507731ejj.108.2020.09.01.01.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 01:16:49 -0700 (PDT)
Date:   Tue, 1 Sep 2020 10:16:47 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/29] Warn on orphan section placement
Message-ID: <20200901081647.GB3602433@gmail.com>
References: <20200821194310.3089815-1-keescook@chromium.org>
 <202008311240.9F94A39@keescook>
 <20200901071133.GA3577996@gmail.com>
 <20200901075937.GA3602433@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901075937.GA3602433@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
> > 
> > * Kees Cook <keescook@chromium.org> wrote:
> > 
> > > On Fri, Aug 21, 2020 at 12:42:41PM -0700, Kees Cook wrote:
> > > > Hi Ingo,
> > > > 
> > > > Based on my testing, this is ready to go. I've reviewed the feedback on
> > > > v5 and made a few small changes, noted below.
> > > 
> > > If no one objects, I'll pop this into my tree for -next. I'd prefer it
> > > go via -tip though! :)
> > > 
> > > Thanks!
> > 
> > I'll pick it up today, it all looks very good now!
> 
> One thing I found in testing is that it doesn't handler older LD 
> versions well enough:
> 
>   ld: unrecognized option '--orphan-handling=warn'
> 
> Could we just detect the availability of this flag, and emit a warning 
> if it doesn't exist but otherwise not abort the build?
> 
> This is with:
> 
>   GNU ld version 2.25-17.fc23

I've resolved this for now by not applying the 5 patches that add the 
actual orphan section warnings:

  arm64/build: Warn on orphan section placement
  arm/build: Warn on orphan section placement
  arm/boot: Warn on orphan section placement
  x86/build: Warn on orphan section placement
  x86/boot/compressed: Warn on orphan section placement

The new asserts plus the actual fixes/enhancements are enough changes 
to test for now in any case. :-)

Thanks,

	Ingo
