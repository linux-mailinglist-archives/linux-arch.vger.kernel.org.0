Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8BA4A6275
	for <lists+linux-arch@lfdr.de>; Tue,  1 Feb 2022 18:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241526AbiBAR3s (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Feb 2022 12:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239884AbiBAR3r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Feb 2022 12:29:47 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2C7C06173B
        for <linux-arch@vger.kernel.org>; Tue,  1 Feb 2022 09:29:46 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso2563488wmj.2
        for <linux-arch@vger.kernel.org>; Tue, 01 Feb 2022 09:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1up9Iuvtlk/iyAkaowMrPN9aJld0zeiBLUkLL04DY6A=;
        b=QWs0wLi0831HmP/LvqHWVwVANAT7rANQll4UtSe0l1qRMJfkYwUAlKC3MvzM9LY59m
         jmirGQcKXR2hKtxGaZX6Az0HBlznNCAt81xhDClcfIpnqSk13VYqNycCy0XzFjBCU8y+
         9+lem5hhoqyNL3tQXojrP7IHE2wBlqnqwYaFh9k63vA91VEWklbrE2Do21974PHp3HPL
         r1uDWYNx165mRiOBob23AYLyRCknUOLHWb/R//K6lz4j+1aU/xNrgpfEx0Qs2nGmuKGl
         yqRWPDr3oPvupXdGUcXBR1+8kd3f2tUAhIzklDg7pSJuKT6T45EHtBwQEq15U83al5Tf
         5pwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1up9Iuvtlk/iyAkaowMrPN9aJld0zeiBLUkLL04DY6A=;
        b=mUGETRQRnOK5xkHGkks2fgCP4C2xC/EWdEY0GWFff+UoB0XIyJv1SZ13tW1M9GCEOf
         GbE4nWDS1TxhznLfj3dV8mzDOyUe1CuYwAZZkuqmCvIJkxzqImRLroYPNMRlPdI1mR2P
         AZ01E4AdCF+Zzzk7grOo7x15/HDyInZN1Pyzfrm9xJBENYKcw9IhIWG58YCxMPdy+eWP
         vI7kG3M9i3K5yarXNun5HL2Fwt/JAaUvIaN0nbuZtsg6gPIWEAW0u5I+KN+DDmH0NOqx
         Q2M2YBKP6BhDjGG3ilGOnZG9ryDX8v84b9a/YCjCTbW920tF1T1rUT3L3l30eS1qE3Fr
         PZAA==
X-Gm-Message-State: AOAM531UsO2Dpq1rZYdNHU8mM1B0y29gbFAtNZ6Mt0rNtpzTy8anZKRo
        mSmKJ050FzVJeMNMY7uBwcMniQ==
X-Google-Smtp-Source: ABdhPJy5hC8TD6/VJePvsLep/Uc4MjPl96ghWdUNl7PHJFXrPu8m3WGr6PFKiyFJDLT/ez1xu4zycQ==
X-Received: by 2002:a05:600c:5c1:: with SMTP id p1mr2710329wmd.31.1643736585242;
        Tue, 01 Feb 2022 09:29:45 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id l29sm3800651wms.1.2022.02.01.09.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 09:29:44 -0800 (PST)
Date:   Tue, 1 Feb 2022 17:29:42 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 08/10] ARM: uaccess: add __{get,put}_kernel_nofault
Message-ID: <20220201172942.nxop6cjr3xfa4237@maple.lan>
References: <20210726141141.2839385-1-arnd@kernel.org>
 <20210726141141.2839385-9-arnd@kernel.org>
 <Yd8P37V/N9EkwmYq@wychelm>
 <Yd8ZEbywqjXkAx9k@shell.armlinux.org.uk>
 <20220113094754.6ei6ssiqbuw7tfj7@maple.lan>
 <CAK8P3a0=OkFcKbL+utDPTPf+RskFNdR8Vt-3BEWkO9g_FqSj5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0=OkFcKbL+utDPTPf+RskFNdR8Vt-3BEWkO9g_FqSj5w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 13, 2022 at 12:14:50PM +0100, Arnd Bergmann wrote:
> On Thu, Jan 13, 2022 at 10:47 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> > On Wed, Jan 12, 2022 at 06:08:17PM +0000, Russell King (Oracle) wrote:
> >
> > > The kernel attempted to access an address that is in the userspace
> > > domain (NULL pointer) and took an exception.
> > >
> > > I suppose we should handle a domain fault more gracefully - what are
> > > the required semantics if the kernel attempts a userspace access
> > > using one of the _nofault() accessors?
> >
> > I think the best answer might well be that, if the arch provides
> > implementations of hooks such as copy_from_kernel_nofault_allowed()
> > then the kernel should never attempt a userspace access using the
> > _nofault() accessors. That means they can do whatever they like!
> >
> > In other words something like the patch below looks like a promising
> > approach.
> 
> Right, it seems this is the same as on x86.

Hmnn...

Looking a bit deeper into copy_from_kernel_nofault() there is an odd
asymmetry between copy_to_kernel_nofault(). Basically there is
copy_from_kernel_nofault_allowed() but no corresponding
copy_to_kernel_nofault_allowed() which means we cannot defend memory
pokes using a helper function.

I checked the behaviour of copy_to_kernel_nofault() on arm, arm64, mips,
powerpc, riscv, x86 kernels (which is pretty much everything where I
know how to fire up qemu). All except arm gracefully handle an
attempt to write to userspace (well, NULL actually) with
copy_to_kernel_nofault() so I think there still a few more changes
to fully fix this.

Looks like we would need a slightly more assertive change, either adding
a copy_to_kernel_nofault_allowed() or modifying the arm dabt handlers to
avoid faults on userspace access.

Any views on which is better?


Daniel.

> 
> > From f66a63b504ff582f261a506c54ceab8c0e77a98c Mon Sep 17 00:00:00 2001
> > From: Daniel Thompson <daniel.thompson@linaro.org>
> > Date: Thu, 13 Jan 2022 09:34:45 +0000
> > Subject: [PATCH] arm: mm: Implement copy_from_kernel_nofault_allowed()
> >
> > Currently copy_from_kernel_nofault() can actually fault (due to software
> > PAN) if we attempt userspace access. In any case, the documented
> > behaviour for this function is to return -ERANGE if we attempt an access
> > outside of kernel space.
> >
> > Implementing copy_from_kernel_nofault_allowed() solves both these
> > problems.
> >
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
