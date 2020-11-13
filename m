Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52C92B1FD3
	for <lists+linux-arch@lfdr.de>; Fri, 13 Nov 2020 17:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgKMQN7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Nov 2020 11:13:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53108 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726437AbgKMQN7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 13 Nov 2020 11:13:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605284038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lPjThI4CN4zNtchIWv2ayPLPXQ5dzA6VBedvQBJvswQ=;
        b=TMX5o7V4963uU4O5u8BhV/NKqhYDPjG/FC7GYhWMjutXtxdern6KkK3UxPXP+XM0hhUN4R
        gZzUr5PcvOZoEV1Xc9hGaoEP1Tdda1BfN14+GYRtCCCRw2r2zHiPnb1PKdmzK3kmeujRvq
        bnmQ2STGzjXFvbqF40cny31E6ZOIsSA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-Cv9b3fDrOOeXc54ODDfobA-1; Fri, 13 Nov 2020 11:13:56 -0500
X-MC-Unique: Cv9b3fDrOOeXc54ODDfobA-1
Received: by mail-wr1-f70.google.com with SMTP id h8so4096036wrt.9
        for <linux-arch@vger.kernel.org>; Fri, 13 Nov 2020 08:13:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=lPjThI4CN4zNtchIWv2ayPLPXQ5dzA6VBedvQBJvswQ=;
        b=qDwg8a3luKMmYlJMjXDmSx0W124YsbEXwWwXjEraJxCOUY6Ps3Rq50CVfLmPokK6qU
         3IgorySEcnt2CBjmWtCVQQbB4cHE5YqOjb5L/G/LN1SO4+e72D8NSDfBtM7ivuK30fen
         P8UYh+T/3R8uyNm660j0ke8S/T8uMwGJh7zuZUNnZKuL5OowfOq4PcdFc1FGXD+eiQRi
         ElPL/QJ+/5RxP4KHL9Gxwa1DEVwnP4xqf8X5vlRTwtKPwO8sEN8BKnIqwVdyRhYjEisc
         Adj5V2tElh+j53xOkDMwDdp+dIQNFssrFurE+d5Xoeqf4N5PIJgvpRv2+D9fklJpR05u
         kikg==
X-Gm-Message-State: AOAM530/vbsDkoJGC49gHTId5xjMzqTlG94QVD4ZUzSsh9IqJD1OCj/y
        QO7DV0dJdkYWo6DeazfCgHOcMFOQkoSwiwQEIDu7ZFLBkYCpUBPrMSaF9rIkigv7mpT1ilLGygq
        Vu8+UNR2m44Lh3UHufSJu7tScChZ+2VIW5Nu+dX/iz3Z62vbwtnTQI/krxfupx6WlX9f6Y7lA+A
        ==
X-Received: by 2002:a1c:6508:: with SMTP id z8mr3330867wmb.80.1605284031543;
        Fri, 13 Nov 2020 08:13:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwEiuKnDYBv81x66rrPhoiQlzwCLdD8os2zSbokQH7OHbb6WTSUyo1RRJZXPMJ4FUH64NtzPg==
X-Received: by 2002:a1c:6508:: with SMTP id z8mr3330501wmb.80.1605284026289;
        Fri, 13 Nov 2020 08:13:46 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u6sm10587225wmj.40.2020.11.13.08.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:13:45 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>
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
In-Reply-To: <20201113155111.fcruk7dlsp6ohoq5@liuwe-devbox-debian-v2>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-10-wei.liu@kernel.org>
 <871rgyy3d1.fsf@vitty.brq.redhat.com>
 <20201113155111.fcruk7dlsp6ohoq5@liuwe-devbox-debian-v2>
Date:   Fri, 13 Nov 2020 17:13:44 +0100
Message-ID: <87zh3lutdz.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> On Thu, Nov 12, 2020 at 04:57:46PM +0100, Vitaly Kuznetsov wrote:
>> Wei Liu <wei.liu@kernel.org> writes:
> [...]
>> > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
>> > index 67f5d35a73d3..4e590a167160 100644
>> > --- a/arch/x86/include/asm/mshyperv.h
>> > +++ b/arch/x86/include/asm/mshyperv.h
>> > @@ -80,6 +80,10 @@ extern void  __percpu  **hyperv_pcpu_output_arg;
>> >  
>> >  extern u64 hv_current_partition_id;
>> >  
>> > +int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
>> > +int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>> > +int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
>> 
>> You seem to be only doing EXPORT_SYMBOL_GPL() for
>> hv_call_deposit_pages() and hv_call_create_vp() but not for
>> hv_call_add_logical_proc() - is this intended? Also, I don't see
>> hv_call_create_vp()/hv_call_add_logical_proc() usage outside of
>> arch/x86/kernel/cpu/mshyperv.c so maybe we don't need to export them at all?
>> 
>
> hv_call_deposit_pages and hv_call_create_vp will be needed by /dev/mshv,
> which can be built as a module.
>

I'd suggest to move EXPORT_SYMBOL_GPL() to the series adding '/dev/mshv'
then. Dangling exported symbols with no users tend to be removed. No
strong opinion, just a suggestion.

> hv_call_add_logical_proc is only needed by mshyperv.c and not exported
> in the first place.
>
> This code is fine.

Thanks for the confirmation!

-- 
Vitaly

