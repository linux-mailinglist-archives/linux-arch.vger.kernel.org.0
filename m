Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7886D63CE
	for <lists+linux-arch@lfdr.de>; Tue,  4 Apr 2023 15:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbjDDNtL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Apr 2023 09:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbjDDNtA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Apr 2023 09:49:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6FA468E
        for <linux-arch@vger.kernel.org>; Tue,  4 Apr 2023 06:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680616085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zsTIZUaOt4/p51daq2PZX1n16o1nkazviHKpSzXwqxo=;
        b=biQRgz5lgvsdrwZVxen1gvhHHE3iO9wt2H9rHRCAxK5zNZiXfgzakIwL63QoxWTYAXz8L6
        BQ79HUHwV/EyXLBIl7CkC/nPrrd66N3x4lo9U1a6x6gim/2AdTtSH7AF2A5I9MLsgo8Jv4
        r5DgDl5g1iRR8Ce5MOl2+s35hrbDkg0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-2vmRCARAP8SNwIEQ4YOkMA-1; Tue, 04 Apr 2023 09:48:03 -0400
X-MC-Unique: 2vmRCARAP8SNwIEQ4YOkMA-1
Received: by mail-wr1-f69.google.com with SMTP id b14-20020a05600003ce00b002cfefd8e637so3704028wrg.15
        for <linux-arch@vger.kernel.org>; Tue, 04 Apr 2023 06:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680616079;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zsTIZUaOt4/p51daq2PZX1n16o1nkazviHKpSzXwqxo=;
        b=rVwF2i3xhEmze7B8AfWuYTv48935iAqiom/EFRZw7mA6sgce8hPKxpAOxmIqXaqbka
         J6fxM1j5eRFL5Y3o0/jZo9xsRtB/bdzT9tXo84d9w7QfFtSb75vOf3PG99BPnsv9ER9W
         GZuGcMKddamyvUEqFBk0RDtFyBQ9R2YQICdKIq7l3PwyEpqMse3kzMYGdvEa+EAfbrvZ
         ul2JeKWQrAwntR3OpR6w9Yl1mrZaNeF6Ov51LX1gDuYsp1n3dhTHCgKAedHm6Pm8lJ/K
         NL/SG5YE2V95EpL1ATtAEuzbNBnyJoEzsozqXdIGwC4bBa8hXrhbK3cL0derV0Z0USd0
         Wi1w==
X-Gm-Message-State: AAQBX9cMt0EGuy6e8f1jIKNedvpW8JV9kNS3XcdCCrojqh2She0B+khL
        4kjZGfaK07KpLFaUvPpuAiSdgVKn0kPoy3vVAcXN2w6C/kwe5+M8tsRhssWDl4pQVYAWuPB4Vyp
        VYGVng+81vL4hoblSW0GKiA==
X-Received: by 2002:a5d:4d11:0:b0:2ce:9819:1c1e with SMTP id z17-20020a5d4d11000000b002ce98191c1emr1783376wrt.30.1680616079631;
        Tue, 04 Apr 2023 06:47:59 -0700 (PDT)
X-Google-Smtp-Source: AKy350bmtLhdkOTL49G5hyyIR/dGwEI3AOPEAjf+veEKXRQyea3PV+FawQK0/io3jdVH76JN5ImpWw==
X-Received: by 2002:a5d:4d11:0:b0:2ce:9819:1c1e with SMTP id z17-20020a5d4d11000000b002ce98191c1emr1783320wrt.30.1680616079268;
        Tue, 04 Apr 2023 06:47:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:b600:e63:6c3b:7b5d:f439? (p200300cbc709b6000e636c3b7b5df439.dip0.t-ipconnect.de. [2003:cb:c709:b600:e63:6c3b:7b5d:f439])
        by smtp.gmail.com with ESMTPSA id d7-20020adfe2c7000000b002d419f661d6sm12391832wrj.82.2023.04.04.06.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 06:47:58 -0700 (PDT)
Message-ID: <78a31392-8f9b-9705-918a-24edb650f395@redhat.com>
Date:   Tue, 4 Apr 2023 15:47:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/3] arch: Introduce ARCH_HAS_CPUMASK_BITS
Content-Language: en-US
To:     Yair Podemsky <ypodemsk@redhat.com>, linux@armlinux.org.uk,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, will@kernel.org, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, peterz@infradead.org, arnd@arndb.de,
        keescook@chromium.org, paulmck@kernel.org, jpoimboe@kernel.org,
        samitolvanen@google.com, frederic@kernel.org, ardb@kernel.org,
        juerg.haefliger@canonical.com, rmk+kernel@armlinux.org.uk,
        geert+renesas@glider.be, tony@atomide.com,
        linus.walleij@linaro.org, sebastian.reichel@collabora.com,
        nick.hawkins@hpe.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, mtosatti@redhat.com, vschneid@redhat.com,
        dhildenb@redhat.com
Cc:     alougovs@redhat.com
References: <20230404134224.137038-1-ypodemsk@redhat.com>
 <20230404134224.137038-2-ypodemsk@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230404134224.137038-2-ypodemsk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 04.04.23 15:42, Yair Podemsky wrote:
> Some architectures set and maintain the mm_cpumask bits when loading
> or removing process from cpu.
> This Kconfig will mark those to allow different behavior between
> kernels that maintain the mm_cpumask and those that do not.
> 

I was wondering if we should do something along the lines of:

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 0722859c3647..1f5c15d8e8ed 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -767,11 +767,13 @@ struct mm_struct {
  #endif /* CONFIG_LRU_GEN */
         } __randomize_layout;

+#ifdef CONFIG_MM_CPUMASK
         /*
          * The mm_cpumask needs to be at the end of mm_struct, because it
          * is dynamically sized based on nr_cpu_ids.
          */
         unsigned long cpu_bitmap[];
+#endif
  };

But that would, of course, require additional changes to make it 
compile. What concerns me a bit is that we have in mm/rmap.c a 
mm_cpumask() usage. But it's glued to 
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH ... shaky.

At least if we would properly fence it, there would be no
accidental abuse anymore.


> Signed-off-by: Yair Podemsky <ypodemsk@redhat.com>
> ---
>   arch/Kconfig         | 8 ++++++++
>   arch/arm/Kconfig     | 1 +
>   arch/powerpc/Kconfig | 1 +
>   arch/s390/Kconfig    | 1 +
>   arch/sparc/Kconfig   | 1 +
>   arch/x86/Kconfig     | 1 +

As Valentin says, there are other architectures that do the same.

-- 
Thanks,

David / dhildenb

