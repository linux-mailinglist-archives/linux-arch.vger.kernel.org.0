Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071D57A1BE8
	for <lists+linux-arch@lfdr.de>; Fri, 15 Sep 2023 12:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbjIOKVZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Fri, 15 Sep 2023 06:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjIOKVZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Sep 2023 06:21:25 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866051AD;
        Fri, 15 Sep 2023 03:21:20 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3ab8e324725so381257b6e.0;
        Fri, 15 Sep 2023 03:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694773280; x=1695378080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T2EQISS+TI6FymgehjVGYiebl+s7fB1qqSBohFwF18Y=;
        b=AAlgGTqfBYfcjl5eD5VIO+Au9x0rHdCLLUO3mDkwc8yiCu9KbflRmoz4rlZHveb3dK
         XZJWjq7/smr5YT79YuxyyPxRZzcqt3HU3iqtzugPHia7KfYKG4JZJx6MPS/wcqHvICoa
         o56L8IN99wdBhpGum3a3hhyiRiAYK7eYuPNfrVzPzq1gur72zn8NPXQ8n5RMc8EfdFsW
         a1zD2it1VqrL6vulZ1GlUBicYK1Fcbx4oTt4sPG7qrJp6eOK/OVufkXZ+d9P6KeCejyO
         wnIXSNPKYvxteEFC3mcG5MBszppWw/2C1FzUvq9Bd0elmdxdMpJ6HDPHidfLnmIuRVjL
         ElhA==
X-Gm-Message-State: AOJu0Yx7D66xbMpTSKcGMTOAsKlBDD26WuQcufnoXf9yd7pPjuKYXnif
        qhDfRci6tZ/2CZ5bAynETYQOxwfDdDIPcVJjZ+g=
X-Google-Smtp-Source: AGHT+IE91hPOK8y/kVeJFKJe8XyQhu0n/Q+0x2/bog6c455z4TN1+FSBkfJT1sJVgSvtor6J5rMGJgfx0mnsyytHqT0=
X-Received: by 2002:a4a:de83:0:b0:56e:94ed:c098 with SMTP id
 v3-20020a4ade83000000b0056e94edc098mr1206706oou.0.1694773279760; Fri, 15 Sep
 2023 03:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230913163823.7880-1-james.morse@arm.com> <20230913163823.7880-28-james.morse@arm.com>
 <CAMj1kXHRAt7ecB9p_dm3MjDL5wZkAsVh30hMY2SV_XUe=bm6Vg@mail.gmail.com>
 <20230914155459.00002dba@Huawei.com> <CAMj1kXFquiLGCMow3iujHUU4GBZx2t9KfKy1R9iqjBFjY+acaA@mail.gmail.com>
 <f5d9beea95e149ab89364dcdb0f8bf69@huawei.com> <ZQQDJT6MOaIOPmq5@shell.armlinux.org.uk>
 <CAJZ5v0jUQ+4G5ArYAtu1gvYF4356CK_QVTO4oWn0ukwdOiZaHA@mail.gmail.com> <80e36ff513504a0382a1cbce83e42295@huawei.com>
In-Reply-To: <80e36ff513504a0382a1cbce83e42295@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Sep 2023 12:21:08 +0200
Message-ID: <CAJZ5v0gou9Pdj_CPC=vLJ-6S-hz+0VY+GMgXcRJk=6t9mL1ykw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 27/35] ACPICA: Add new MADT GICC flags fields [code first?]
To:     Salil Mehta <salil.mehta@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        James Morse <james.morse@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "x86@kernel.org" <x86@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "jianyong.wu@arm.com" <jianyong.wu@arm.com>,
        "justin.he@arm.com" <justin.he@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 15, 2023 at 11:34 AM Salil Mehta <salil.mehta@huawei.com> wrote:
>
>
> > From: Rafael J. Wysocki <rafael@kernel.org>
> > Sent: Friday, September 15, 2023 9:45 AM
> > To: Russell King (Oracle) <linux@armlinux.org.uk>
> > Cc: Salil Mehta <salil.mehta@huawei.com>; Ard Biesheuvel <ardb@kernel.org>;
> > Jonathan Cameron <jonathan.cameron@huawei.com>; James Morse
> > <james.morse@arm.com>; linux-pm@vger.kernel.org; loongarch@lists.linux.dev;
> > linux-acpi@vger.kernel.org; linux-arch@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > riscv@lists.infradead.org; kvmarm@lists.linux.dev; x86@kernel.org; Jean-
> > Philippe Brucker <jean-philippe@linaro.org>; jianyong.wu@arm.com;
> > justin.he@arm.com
> > Subject: Re: [RFC PATCH v2 27/35] ACPICA: Add new MADT GICC flags fields
> > [code first?]
> >
> > On Fri, Sep 15, 2023 at 9:09 AM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Fri, Sep 15, 2023 at 02:29:13AM +0000, Salil Mehta wrote:
> > > > On x86, during init, if the MADT entry for LAPIC is found to be
> > > > online-capable and is enabled as well then possible and present
> > >
> > > Note that the ACPI spec says enabled + online-capable isn't defined.
> > >
> > > "The information conveyed by this bit depends on the value of the
> > > Enabled bit. If the Enabled bit is set, this bit is reserved and
> > > must be zero."
> > >
> > > So, if x86 is doing something with the enabled && online-capable
> > > state (other than ignoring the online-capable) then technically it
> > > is doing something that the spec doesn't define
> >
> > And so it is wrong.
>
>
> Or maybe, specification has not been updated yet. code-first?

Well, if you are aware of any change requests related to this and
posted as code-first, please let me know.
