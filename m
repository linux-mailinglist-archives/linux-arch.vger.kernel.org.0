Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7162F508DA6
	for <lists+linux-arch@lfdr.de>; Wed, 20 Apr 2022 18:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380676AbiDTQvq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Apr 2022 12:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239724AbiDTQvp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Apr 2022 12:51:45 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EB64617D
        for <linux-arch@vger.kernel.org>; Wed, 20 Apr 2022 09:48:59 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id bo5so2472315pfb.4
        for <linux-arch@vger.kernel.org>; Wed, 20 Apr 2022 09:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R/fi1SRkDqiUkxZol4SjwZWcZTpEli35mQJt0vyOur0=;
        b=Kk5fPbS0zm4FMP+eBPzfBSMQk7k9oI+B5J3rRBWLm+ph+/RN2Jg+2IIeuaMW4BqINO
         eCCLQAhAk206DsyacsRQH4EyQnpKel4VPaJ45b9x6RaAqhJ4ePGuqfS2st9TkDLH4u0q
         Mjimyb8cA40GoiOx+MA2kM8hTwEIXI0A/8xdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R/fi1SRkDqiUkxZol4SjwZWcZTpEli35mQJt0vyOur0=;
        b=3vVdfxz8hKa031imtftwBxW+NIv5+w7EiIl1FrTQvjSbieBjQUIPEO7d9YcfVLZ270
         3ns3OFU95vgs6kZbam/higfBBGz6uj1He65gcl9zA1nhunNG5g5WFuVfZvm4Ppr0qnDF
         ZHv+MS/zzPtgBOMlXdVxwFYirEwhDPt6m3k3Z5gY21W3iBzmG5wnOqjEd8+SgIwAjgCP
         gTKBuli+nYut32oOqcPzrEHugnYuPqOOKmI7Oj2Nt5UmNwpa6tO6ya9mFy7K5xDxFfKr
         8kOFgJv+MkCXxRTiSxlBac3bXEDaNFlYX0W4M0+Puxn1wD1d8GHOnbaxsx7UB30al6lf
         GHTQ==
X-Gm-Message-State: AOAM531pPrb2TtaJusDyZnDRLjXr3RvsVn6+9CqBfyAy3UynL1vcVmlt
        9GOc7qpnaueojPJ5vbNRkPwqZA==
X-Google-Smtp-Source: ABdhPJwurf26N7fVAiEXm7TpZEdfSHTuxnMwLUBDSeGQvWPvKjDjdGT4MFkI9cmqEOXOsH8y7tgRLQ==
X-Received: by 2002:a65:4108:0:b0:399:1f0e:50da with SMTP id w8-20020a654108000000b003991f0e50damr20583633pgp.2.1650473338612;
        Wed, 20 Apr 2022 09:48:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z16-20020a637e10000000b00382b21c6b0bsm20654702pgc.51.2022.04.20.09.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 09:48:58 -0700 (PDT)
Date:   Wed, 20 Apr 2022 09:48:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     broonie@kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, jeremy.linton@arm.com,
        hjl.tools@gmail.com, libc-alpha@sourceware.org,
        szabolcs.nagy@arm.com, yu-cheng.yu@intel.com,
        ebiederm@xmission.com, linux-arch@vger.kernel.org
Subject: Re: [PATCH v13 0/2] arm64: Enable BTI for the executable as well as
 the interpreter
Message-ID: <202204200948.21173429E@keescook>
References: <20220419105156.347168-1-broonie@kernel.org>
 <165043278356.1481705.13924459838445776007.b4-ty@chromium.org>
 <20220420093612.GB6954@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420093612.GB6954@willie-the-truck>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 20, 2022 at 10:36:13AM +0100, Will Deacon wrote:
> On Tue, Apr 19, 2022 at 10:33:06PM -0700, Kees Cook wrote:
> > On Tue, 19 Apr 2022 11:51:54 +0100, Mark Brown wrote:
> > > Deployments of BTI on arm64 have run into issues interacting with
> > > systemd's MemoryDenyWriteExecute feature.  Currently for dynamically
> > > linked executables the kernel will only handle architecture specific
> > > properties like BTI for the interpreter, the expectation is that the
> > > interpreter will then handle any properties on the main executable.
> > > For BTI this means remapping the executable segments PROT_EXEC |
> > > PROT_BTI.
> > > 
> > > [...]
> > 
> > Applied to for-next/execve, thanks!
> > 
> > [1/2] elf: Allow architectures to parse properties on the main executable
> >       https://git.kernel.org/kees/c/b2f2553c8e89
> > [2/2] arm64: Enable BTI for main executable as well as the interpreter
> >       https://git.kernel.org/kees/c/b65c760600e2
> 
> Kees, please can you drop this series while Catalin's alternative solution
> is under discussion (his Reviewed-by preceded the other patches)?
> 
> https://lore.kernel.org/r/20220413134946.2732468-1-catalin.marinas@arm.com
> 
> Both series expose new behaviours to userspace and we don't need both.

Ah-ha! I wasn't sure if they were solving the same problem or not.

-- 
Kees Cook
