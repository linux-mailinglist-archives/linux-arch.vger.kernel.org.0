Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891CA3DE0B5
	for <lists+linux-arch@lfdr.de>; Mon,  2 Aug 2021 22:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhHBUcR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Aug 2021 16:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhHBUcR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Aug 2021 16:32:17 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3D0C061760;
        Mon,  2 Aug 2021 13:32:05 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id a192-20020a1c7fc90000b0290253b32e8796so652607wmd.0;
        Mon, 02 Aug 2021 13:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M1nBUo4KZ7/feK13SK1ltjciiCFL6QbXAmkAclXDcwk=;
        b=jE2IKMDJCKiu0+a2EeiLzhAmvFml5I8A0zkmXmFK3ZyQXlSQ97rdMAB7ZaYdAHijd3
         Vzvu8Mp17UBwHT2nih+IFxaiZFGHuFM1DriOKm7vudR+6k3VGnEc5NVUlSRHYAIwzROs
         HQNhFf5hHNFHMDSPC7V4AsPHQbXgylyxoPpNT1YcXaAwPgrdoOKA3YI0LzQHUfSP8Ig/
         qpmzQExuMPpumfAMIxc8zZJI5/iEsZbjA8LuYqBgsqbIk0wrQrvauJ7hZmi0i2uCsSBH
         /DiDgqCOPCPXVja/fb5w2KS/D/Zygf/ZGuSXkWaSIUqdhen2wuB+i0gVMdFb5fLFdvh6
         XR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M1nBUo4KZ7/feK13SK1ltjciiCFL6QbXAmkAclXDcwk=;
        b=mq/d35kY22nNuKSaE42kw7cJ56ozirXbbo/tUkZOGhd0Gt+H8Z6QAkgqneUG1yzG62
         5jUm3zPPScXH1erlHp5nvF8ra0ZrTi123XSk7Pdnu0pPPKYdJ4UwVcGN3VwCNO3CoEkC
         PAQvwxmrTWqSKimTDSmpo8+FhamgRlIKolvRKJYQZPqgeor3wT93a6KS9K6T4T4RmElu
         80vQNoI6Xa8hsWyMZzgANwD7rBcmgKAY+joyAyky+3YzXJUAW+y/jJU7zPrJwSUrr7R1
         9t6cE7GUDaKkYthkz84xm6dFEvEdZyRKTmS3g61IPJmBl0mEosCoEx8If2aZqVImedHg
         QIug==
X-Gm-Message-State: AOAM530xc0yfgxAyI+fIgALo6aBpfcMlDhGksLkgS2I9kQK52qKFj6Dv
        AAXXNBnUwkQoOzGrI37edw==
X-Google-Smtp-Source: ABdhPJywcnySifupCI+7bkrOwR1Br6hJZav/murBPhZkaBphO5C0vq9XjyYzQ+BUWPpZaGgnsr67YQ==
X-Received: by 2002:a05:600c:2909:: with SMTP id i9mr689355wmd.74.1627936324376;
        Mon, 02 Aug 2021 13:32:04 -0700 (PDT)
Received: from localhost.localdomain ([46.53.249.181])
        by smtp.gmail.com with ESMTPSA id s9sm12474226wra.80.2021.08.02.13.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 13:32:04 -0700 (PDT)
Date:   Mon, 2 Aug 2021 23:32:02 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, masahiroy@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/3] isystem: delete global -isystem compile option
Message-ID: <YQhWQkbN+pe354RW@localhost.localdomain>
References: <20210801201336.2224111-1-adobriyan@gmail.com>
 <20210801201336.2224111-3-adobriyan@gmail.com>
 <YQg2+C4Z98BMFucg@archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YQg2+C4Z98BMFucg@archlinux-ax161>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 02, 2021 at 11:18:32AM -0700, Nathan Chancellor wrote:
> On Sun, Aug 01, 2021 at 11:13:36PM +0300, Alexey Dobriyan wrote:
> > In theory, it enables "leakage" of userspace headers into kernel which
> > may present licensing problem.
> > 
> > In practice, only stdarg.h was used, stdbool.h is trivial and SIMD
> > intrinsics are contained to a few architectures and aren't global
> > problem.
> > 
> > In general, kernel is very self contained code and -isystem removal
> > will further isolate it from Ring Threeland influence.
> > 
> > nds32 keeps -isystem globally due to intrisics used in entrenched header.
> > 
> > -isystem is selectively reenabled for some files.
> > 
> > Not compile tested on hexagon.
> 
> With this series on top of v5.14-rc4 and a tangential patch to fix
> another issue, ARCH=hexagon defconfig and allmodconfig show no issues.
> 
> Tested-by: Nathan Chancellor <nathan@kernel> # build (hexagon)

Oh wow, small miracle. Thank you!

Where can I find a cross-compiler? This link doesn't seem to have one
https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/11.1.0/
