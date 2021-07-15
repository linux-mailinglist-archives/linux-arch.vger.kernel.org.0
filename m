Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD073C9F11
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jul 2021 15:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhGONGy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Jul 2021 09:06:54 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:37684 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhGONGx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jul 2021 09:06:53 -0400
Received: by mail-wm1-f43.google.com with SMTP id y21-20020a7bc1950000b02902161fccabf1so6017091wmi.2;
        Thu, 15 Jul 2021 06:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bJGICSHpYO0mCBny+k842bEvVqLK1SbOw3MzuL2d1yY=;
        b=BPHpcpQWaWUT4p/Sm9aN6vUD08D6/OrtldnhWXlrO0QEC9KCWB4SM11uwn39fHtyKf
         l4187YmtTnanmBBJtJyZ0tAmTQUAMTo9cpvQtQkmtOmh68MFTDlHlH4tuLArcqyiTyNY
         lfhxt/e2ETfdyv6nWXOJWgkMCjdw+xUb1U5nECUDRTfUA0RibB2YF35n89lY1qF1XW3v
         9ZX7janmaMyAxL8IayfPEbBRTs1yglhTEf9AYHhb8dGe72ERfYDYjv0/brCqTWsgwI5i
         d1UmT15Zn9P2trQz8TZkjeV/sS9cLDrQC91nsBpJ+tBHGG+kY326MjPLGNQyH90o1ui0
         Camw==
X-Gm-Message-State: AOAM531J9PYDP9uvdkdUCkAoUSdRNSN19s1Yyp5vsvJIpsdwlHOzDLAJ
        Y/F+BBT4zRasFmy5K6nhOIU=
X-Google-Smtp-Source: ABdhPJyHb5wyZ5NLzoJUkEJliUgFAMAVKGopBAKAZ2T0I54iyj4rIaOGc0RWAOe5oNF3YZdG1AlzLQ==
X-Received: by 2002:a7b:c846:: with SMTP id c6mr4464137wml.92.1626354238212;
        Thu, 15 Jul 2021 06:03:58 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id b6sm8406146wmj.34.2021.07.15.06.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 06:03:57 -0700 (PDT)
Date:   Thu, 15 Jul 2021 13:03:56 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Additional refactoring of Hyper-V arch specific
 code
Message-ID: <20210715130356.qbmrfnbpqbdaim3j@liuwe-devbox-debian-v2>
References: <1626287687-2045-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626287687-2045-1-git-send-email-mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 14, 2021 at 11:34:44AM -0700, Michael Kelley wrote:
> This patch set moves additional Hyper-V code under arch/x86 into
> arch-neutral hv_common.c where it can be shared by x86 and
> and ARM64 implementations.  The move reduces the overall lines
> of code across both architectures, and removes code under
> arch/ that isn't really architecture-specific.
> 
> The code is moved into hv_common.c because it must be
> built-in to the kernel image, and not be part of a module.
> 
> No functional changes are intended.
> 
> ---
> Changes in v2:
> * Fixed problem when building with CONFIG_HYPERV=n
>   (reported by kernel test robot <lkp@intel.com>)
> 

Thanks for the quick turnaround. I've pushed these three patches to
hyperv-next.

Wei.

> 
> Michael Kelley (3):
>   Drivers: hv: Make portions of Hyper-V init code be arch neutral
>   Drivers: hv: Add arch independent default functions for some Hyper-V
>     handlers
>   Drivers: hv: Move Hyper-V misc functionality to arch-neutral code
> 
>  arch/x86/hyperv/hv_init.c       | 101 +++-----------------
>  arch/x86/include/asm/mshyperv.h |   4 -
>  arch/x86/kernel/cpu/mshyperv.c  |  20 ----
>  drivers/hv/hv_common.c          | 205 ++++++++++++++++++++++++++++++++++++++++
>  include/asm-generic/mshyperv.h  |  10 ++
>  5 files changed, 226 insertions(+), 114 deletions(-)
> 
> -- 
> 1.8.3.1
> 
