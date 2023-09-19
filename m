Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB8D7A698F
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 19:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjISRX6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 13:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjISRX5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 13:23:57 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFD9AD;
        Tue, 19 Sep 2023 10:23:51 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59bebd5bdadso61362617b3.0;
        Tue, 19 Sep 2023 10:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695144230; x=1695749030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ke+rhIpc8Yj4RHSOIcCUf04IBals1/6zBz6t3mWbRfs=;
        b=lqDp+sTrbpvsk/gj6cxQsxnsxilv2449oWmf02MP18Xn0eLh9Ct5RDlUus59A/bA+A
         VPdAMIkGw0N9hXn+CgxCvdsxmDAsmaL+TbGJqGbG/0S17YmIjdl1vL5u5MSCcUfwQhXS
         2aV7utyejtOUbS2yOyCrIRuVDgF0lBQaWdya1unG0yOcWF7KP7IqlwSSxvPRAfP7f1XZ
         xwtQgvkjqzOCvXgLjUvxSeJ/BgMf6x1kKBgmJYVsGORk4205Czkr4/sjjtAveTBj6Y7l
         TETp1prWNaoa/Zfkuej9pngYXjS1mPLK7MdNG0EPR/GzMuQYqasp1RZxBsU3cLUFkgin
         nSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695144230; x=1695749030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ke+rhIpc8Yj4RHSOIcCUf04IBals1/6zBz6t3mWbRfs=;
        b=eXNKAyuZXXYTsYKaTQmTQ0BGR1x2e3Qv6p5pYQoESJFnSIxeBCANoHBTM/tMF3e+qK
         aY8QK/3iSmdRS31vtt69X0jLUluSMwxUk2AHsfOsbi4fF4JKTZMOKBA0WTh5zrwlrDrR
         3ocGmWtVa6+WEUQWIQ7Nwwsk0o6dlsFNmNZ4kPDQWL+xc/DJOg2Igzja53AdVvHAP8Fc
         A+/AErOMetq9Mix3rBntsvsXEi0MYoUTCHdQvTRM4tSMOWj8veVPqOvOb4uZHhNkkplY
         b95KR+o9rO2ymAM8dCGAqcTW7pc/flyhpa8h+/4mqLshdy0DnHtapSzMnnUs4OV7eaFZ
         jRaQ==
X-Gm-Message-State: AOJu0Yye14ZDNq0Qc4m3G++8Hf0u3teiDlJGnjBI6ttUMAVpOVMR+Mor
        XsnFSiszHTOcW1NZiu5es+0=
X-Google-Smtp-Source: AGHT+IFYba94/tWKEV5d0wk1Ylg0gSJJMGYXAHDrHy5oPNZruwSqpKZ/9cU/3wLGaHbcTR7JOuKvlQ==
X-Received: by 2002:a81:4810:0:b0:586:9c4e:a9a4 with SMTP id v16-20020a814810000000b005869c4ea9a4mr145786ywa.5.1695144230386;
        Tue, 19 Sep 2023 10:23:50 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.gmail.com with ESMTPSA id u127-20020a0dd285000000b0059bce30a498sm3316842ywd.139.2023.09.19.10.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 10:23:49 -0700 (PDT)
Date:   Tue, 19 Sep 2023 10:23:46 -0700
From:   Vishal Moola <vishal.moola@gmail.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, will@kernel.org,
        aneesh.kumar@linux.ibm.com, npiggin@gmail.com,
        peterz@infradead.org, catalin.marinas@arm.com,
        chenhuacai@kernel.org, tsbogend@alpha.franken.de,
        dave.hansen@linux.intel.com, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, arnd@arndb.de, willy@infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org
Subject: Re: [PATCH] mm: add statistics for PUD level pagetable
Message-ID: <ZQnZIkOfY0btsd8A@unknowna0e70b2ca394.attlocal.net>
References: <876c71c03a7e69c17722a690e3225a4f7b172fb2.1695017383.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <876c71c03a7e69c17722a690e3225a4f7b172fb2.1695017383.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 18, 2023 at 02:31:42PM +0800, Baolin Wang wrote:
> Recently, we found that cross-die access to pagetable pages on ARM64
> machines can cause performance fluctuations in our business. Currently,
> there are no PMU events available to track this situation on our ARM64
> machines, so an accurate pagetable accounting can help to analyze this
> issue, but now the PUD level pagetable accounting is missed.
> 
> So introducing pagetable_pud_ctor/dtor() to help to get an accurate
> PUD pagetable accounting, as well as converting the architectures with
> using generic PUD pagatable allocation to add corresponding PUD pagetable
> accounting. Moreover this patch will also mark the PUD level pagetable
> with PG_table flag, which will help to do sanity validation in unpoison_memory().
> 
> On my testing machine, I can see more pagetables statistics after the patch
> with page-types tool:
> 
> Before patch:
>         flags           page-count      MB  symbolic-flags                     long-symbolic-flags
> 0x0000000004000000           27326      106  __________________________g_________________       pgtable
> After patch:
> 0x0000000004000000           27541      107  __________________________g_________________       pgtable
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Acked-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
