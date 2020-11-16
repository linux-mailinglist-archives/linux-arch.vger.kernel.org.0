Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA36E2B4309
	for <lists+linux-arch@lfdr.de>; Mon, 16 Nov 2020 12:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgKPLlN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Nov 2020 06:41:13 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34288 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728352AbgKPLlN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Nov 2020 06:41:13 -0500
Received: by mail-wr1-f68.google.com with SMTP id r17so18366562wrw.1;
        Mon, 16 Nov 2020 03:41:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y7kdbqVSDMdCnPNWY4xSbC6hJYp1+DS6xFZoA2u4R2Y=;
        b=bSgikvXuuB4MuvJFEANvghqlliw5C1O0pvDoAt4FicQrg0Tx9pI4kD/YlIuVNGibo8
         hs8x6ONXwzM43BmbFtLO9oQxcjUGrbVFEZ0aklBKpddt1aImNTO92/0Q0Im+BZ6Vfco6
         ZH1XTWTo+AgNexHOzM851nL6ORxdhB31WbFAMJqKdEjdTT7Hiqrdr4QhJlBNdm6ux2zU
         BeVdFWrlny23feFvbE1bk2vXIflw5klGeDG0H3ghVBVZIAsmN/zMeekW+nR+zhdPxj40
         lPrqY6drCE36OhGmVwWLWEheCtlB5ZuuAEgYacdB0gPizgF4+4YeuHuDyeNBET8a9Nbo
         bKwA==
X-Gm-Message-State: AOAM531qvFPkKsskXjblEWcsdSwPx/dAS9NtK4Zo2wWVvlsemmPcGtdq
        oMG+aPNTBrPulZWolwBhFeA=
X-Google-Smtp-Source: ABdhPJyYg/u3vBgXPIJPMNUX/jFnANGn5/BDaJHlRUiRHCzw+3vz4t3mF3pvxwJ5OzdEyUDiFEZEBw==
X-Received: by 2002:adf:f852:: with SMTP id d18mr18070916wrq.232.1605526869393;
        Mon, 16 Nov 2020 03:41:09 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id t11sm16089352wrm.8.2020.11.16.03.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 03:41:08 -0800 (PST)
Date:   Mon, 16 Nov 2020 11:41:07 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2 09/17] x86/hyperv: provide a bunch of helper functions
Message-ID: <20201116114107.bdi2opfjd7gwbpdu@liuwe-devbox-debian-v2>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-10-wei.liu@kernel.org>
 <871rgyy3d1.fsf@vitty.brq.redhat.com>
 <20201113155111.fcruk7dlsp6ohoq5@liuwe-devbox-debian-v2>
 <87zh3lutdz.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zh3lutdz.fsf@vitty.brq.redhat.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 13, 2020 at 05:13:44PM +0100, Vitaly Kuznetsov wrote:
> Wei Liu <wei.liu@kernel.org> writes:
> 
> > On Thu, Nov 12, 2020 at 04:57:46PM +0100, Vitaly Kuznetsov wrote:
> >> Wei Liu <wei.liu@kernel.org> writes:
> > [...]
> >> > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> >> > index 67f5d35a73d3..4e590a167160 100644
> >> > --- a/arch/x86/include/asm/mshyperv.h
> >> > +++ b/arch/x86/include/asm/mshyperv.h
> >> > @@ -80,6 +80,10 @@ extern void  __percpu  **hyperv_pcpu_output_arg;
> >> >  
> >> >  extern u64 hv_current_partition_id;
> >> >  
> >> > +int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
> >> > +int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
> >> > +int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
> >> 
> >> You seem to be only doing EXPORT_SYMBOL_GPL() for
> >> hv_call_deposit_pages() and hv_call_create_vp() but not for
> >> hv_call_add_logical_proc() - is this intended? Also, I don't see
> >> hv_call_create_vp()/hv_call_add_logical_proc() usage outside of
> >> arch/x86/kernel/cpu/mshyperv.c so maybe we don't need to export them at all?
> >> 
> >
> > hv_call_deposit_pages and hv_call_create_vp will be needed by /dev/mshv,
> > which can be built as a module.
> >
> 
> I'd suggest to move EXPORT_SYMBOL_GPL() to the series adding '/dev/mshv'
> then. Dangling exported symbols with no users tend to be removed. No
> strong opinion, just a suggestion.

Sure. This is now done in my v3.

Wei.
