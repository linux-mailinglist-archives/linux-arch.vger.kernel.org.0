Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6AA32C86F
	for <lists+linux-arch@lfdr.de>; Thu,  4 Mar 2021 02:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240276AbhCDAtX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 19:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390880AbhCCWSY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Mar 2021 17:18:24 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFA6C061764;
        Wed,  3 Mar 2021 14:17:43 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id n79so14194531qke.3;
        Wed, 03 Mar 2021 14:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F+DfskWs3VLBseDXeXC3pvAy/cUkavN22n3rVw/q6VA=;
        b=VOEsiTE+wYmonPb9dLZ6uXp9SsbWfVePmK1H0UozjpdPD7luFAwgAR3z14UoYr8i2t
         vcl0QJz6HTaSYgIt3e7FgKz7XDxEM43iMSwRP80CM0/ldqhw9XGOV03Wgio2EvwmyJpL
         WDH1gxCmy9M1ZpRXMri6VWQTv1o0npXOpDMuGIJZ5BCE1l+q42RRgtBxI7ClgcD+d+2H
         VNuqFTDlZdPZ68ubDLAOXH2hGzI/RlZ0kKliGdlfUuLMgVqkbQ13c5pt52sIrRdliQQV
         A8ALT92ZrkUrM+5/qvYt6uOW6PEVP0S0tKD5tCYVdpWibi36rKNJ3QJA5K0FHe7vB23o
         ca0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F+DfskWs3VLBseDXeXC3pvAy/cUkavN22n3rVw/q6VA=;
        b=HU0vnzQdI+i+dp1iKwdOHp7AmoHIWgLWmBQYulGMZ57S5/SZ3rWvpr9ULjxg7FaLkN
         fk/0kRBE4rAGew7uNJ7Ug3bwWP8hirhJtfEVu4grXXWxDNJsSCqCIvJVQIV3JuLg7rD4
         wRrClXcebnOdf5zzgJx7f74JS8vn1Er0lNRWFhqUMns04nzGn6jIxsiYOgZ4E9iaivEk
         XOteqzAAy3XDy8EVSXGybKXkWXDPSnfwiB+bhM1G3f+uwdzvrek14/6fTfJwGhqVCcHN
         BwF8i92N0ypLyYYCRcKSXLkbNg8oncjFhXZv71ko8B5YEOz5NnYcudCDmfk+Iio1FKSf
         i8Cg==
X-Gm-Message-State: AOAM533peBQKzS05FzoHtaTK7I+Np/En2+yBHbCZPHj2NLVYl0BkQAY3
        cwpQXowx5Et/mKOAwjV3hhifxkuI0gY=
X-Google-Smtp-Source: ABdhPJwUGaxbBpfrRs/6hYOb4muFNXNpylJrvUpk7d1r1icNmdvfR1Ft/bl/0LxT3qr3mFWRVYG8AQ==
X-Received: by 2002:a37:ef15:: with SMTP id j21mr1219197qkk.385.1614809863097;
        Wed, 03 Mar 2021 14:17:43 -0800 (PST)
Received: from localhost ([76.73.146.210])
        by smtp.gmail.com with ESMTPSA id g186sm17728405qke.0.2021.03.03.14.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 14:17:42 -0800 (PST)
Date:   Wed, 3 Mar 2021 14:17:41 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Alexander Lobakin <alobakin@pm.me>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [RESEND PATCH 1/2] ARM64: enable GENERIC_FIND_FIRST_BIT
Message-ID: <20210303221741.GA2013084@yury-ThinkPad>
References: <20210225135700.1381396-1-yury.norov@gmail.com>
 <20210225135700.1381396-2-yury.norov@gmail.com>
 <20210225140205.GA13297@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225140205.GA13297@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 25, 2021 at 02:02:06PM +0000, Will Deacon wrote:
> On Thu, Feb 25, 2021 at 05:56:59AM -0800, Yury Norov wrote:
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 31bd885b79eb..5596eab04092 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -108,6 +108,7 @@ config ARM64
> >  	select GENERIC_CPU_AUTOPROBE
> >  	select GENERIC_CPU_VULNERABILITIES
> >  	select GENERIC_EARLY_IOREMAP
> > +	select GENERIC_FIND_FIRST_BIT
> >  	select GENERIC_IDLE_POLL_SETUP
> >  	select GENERIC_IRQ_IPI
> >  	select GENERIC_IRQ_MULTI_HANDLER
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> Catalin can pick this up later in the cycle.
> 
> Will

Ping?
