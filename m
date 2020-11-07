Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4F32AA1E7
	for <lists+linux-arch@lfdr.de>; Sat,  7 Nov 2020 01:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgKGAxu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Nov 2020 19:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbgKGAxs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Nov 2020 19:53:48 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDFCC0613CF
        for <linux-arch@vger.kernel.org>; Fri,  6 Nov 2020 16:53:46 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id j12so3356502iow.0
        for <linux-arch@vger.kernel.org>; Fri, 06 Nov 2020 16:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=htvs7lR/1BI8D0Mzc+TXEsKixscjGZpRTsGr1YNtxI4=;
        b=Gm+gGA0zABCYmnzgAZbqB8LmrvQ24MZCZCeuofocA24Z9DinusB4T1r6s3QuIsHnq/
         BDgTerVHPvQuevB4yFhOhYW29XoCPLIvMjMF66TkV6n1x1WAtyJgsMXb/N5zpnI9faJa
         FIOqUay2ys7nfNVAmyM7TMxQWX7Rcmmu7ZLY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=htvs7lR/1BI8D0Mzc+TXEsKixscjGZpRTsGr1YNtxI4=;
        b=mOT9I50QP8W1ve9HQVQAMXHJc2nIcYGuWuEJEA7MRP0UjmZjYoZf7u0EHtzsT67Coo
         mxI2iQFKS4vo9OkxC9jUpwQ32Q3ONzBxrPk1FD7CWCBzOWbKXfE2Kuf/Fi/wndeFxmS4
         i77M/Sxf0+JUBS14vmZYbsNR1Ll/EnDzuNxqCSAoQx29QvdIFyRcVGDEkJqUhBbI03WK
         UWhC70FzhsQFp/BcYs0ZeXlFPTtOZa4P11mtLVlVbR+/PA31fvlPrix7GMtJPdqgDEo+
         NCPOlKFC3IY4Liltde36PW9MrmM0seZsGC0NHVcGgPZ6+htqET3hNX19PiMTK0KNXv/U
         mRZA==
X-Gm-Message-State: AOAM5300YmCrlnW0tySur4XOcvHfnrZtTLwR43GrqONOCb6NJZCRIISI
        ie9YI7kNtHd4+1TDf3o4ttQsbUpMmrPGh4r6dcQH8keKlNWX
X-Google-Smtp-Source: ABdhPJyTo+S+mQWAmRQ8EDSKdeh04ebDM4c/nGCflyQ+HMbV7hMgiFw6U1U5Deqk5cCMRheBFpX7520CFYInwaVMtLw=
X-Received: by 2002:a5d:9842:: with SMTP id p2mr3570190ios.113.1604710425638;
 Fri, 06 Nov 2020 16:53:45 -0800 (PST)
MIME-Version: 1.0
References: <20201006001752.248564-1-atish.patra@wdc.com> <20201006001752.248564-3-atish.patra@wdc.com>
 <20201106171403.GK29329@gaia> <CAOnJCUJo795yX_7am0hdB_JFio3_ZBRHioHNcydhqEouCUynUg@mail.gmail.com>
 <20201106190847.GA23792@gaia>
In-Reply-To: <20201106190847.GA23792@gaia>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 6 Nov 2020 16:53:33 -0800
Message-ID: <CAOnJCUJ-vi=1w8HzsPP-adcV58jZC4NM-mvHD09QVkd9iJrwOA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] arm64, numa: Change the numa init functions name
 to be generic
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Zong Li <zong.li@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Jia He <justin.he@arm.com>, Anup Patel <anup@brainfault.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 6, 2020 at 11:08 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Fri, Nov 06, 2020 at 09:33:14AM -0800, Atish Patra wrote:
> > On Fri, Nov 6, 2020 at 9:14 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > On Mon, Oct 05, 2020 at 05:17:49PM -0700, Atish Patra wrote:
> > > > diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
> > > > index 7ff800045434..96502ff92af5 100644
> > > > --- a/arch/arm64/kernel/acpi_numa.c
> > > > +++ b/arch/arm64/kernel/acpi_numa.c
> > > > @@ -117,16 +117,3 @@ void __init acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa)
> > > >
> > > >       node_set(node, numa_nodes_parsed);
> > > >  }
> > > > -
> > > > -int __init arm64_acpi_numa_init(void)
> > > > -{
> > > > -     int ret;
> > > > -
> > > > -     ret = acpi_numa_init();
> > > > -     if (ret) {
> > > > -             pr_info("Failed to initialise from firmware\n");
> > > > -             return ret;
> > > > -     }
> > > > -
> > > > -     return srat_disabled() ? -EINVAL : 0;
> > > > -}
> > >
> > > I think it's better if arm64_acpi_numa_init() and arm64_numa_init()
> > > remained in the arm64 code. It's not really much code to be shared.
> >
> > RISC-V will probably support ACPI one day. The idea is to not to do
> > exercise again in future.
> > Moreover, there will be arch_numa_init which will be used by RISC-V
> > and there will be arm64_numa_init
> > used by arm64. However, if you feel strongly about it, I am happy to
> > move back those two functions to arm64.
>
> I don't have a strong view on this, only if there's a risk at some point
> of the implementations diverging (e.g. quirks). We can revisit it if
> that happens.
>

Sure. I seriously hope we don't have to deal with arch specific quirks
in future.

> It may be worth swapping patches 1 and 2 so that you don't have an
> arm64_* function in the core code after the first patch (more of a
> nitpick). Either way, feel free to add my ack on both patches:
>

Sure. I will swap 1 & 2 and resend the series.

> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks.

-- 
Regards,
Atish
