Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E53416AB2
	for <lists+linux-arch@lfdr.de>; Fri, 24 Sep 2021 06:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhIXEMU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Sep 2021 00:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhIXEMU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Sep 2021 00:12:20 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAE6C061574;
        Thu, 23 Sep 2021 21:10:48 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id k10so8648934vsp.12;
        Thu, 23 Sep 2021 21:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bk15Hm2M8idBVgL17RzOk2yetGgHrtwFP6x5McjK4DA=;
        b=lj+ehfoLt8PH752kmrSF3EVTC8nlA/Ayv88DSqabOxmVGnNIaV0nZVxy/OcKPrkE+G
         GqiH3zCzvzggADBo+GtsyLhASlr5MnXZiPAjgxg4UScuDnontFjuIBF24c7lMR1bFECi
         9mwtPlJOJqx5QlgXsV3oJQD7fiyNi60HL7mliU82r5Hr4+qoZXouquejDPJlm5+V8uGr
         wDrvRgGcYA+ksiMKfsi8Q8MXfCwshPppdH4c4zo03DaPMB6GtTLWHPQcJqeRBKhBQCln
         Q1D4L7dMtzAVDY1/hb9dsF1oeIeTGdd7BbGZR4haVYCJCFYjdfdPeT/ipmyVN135lrsU
         hEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bk15Hm2M8idBVgL17RzOk2yetGgHrtwFP6x5McjK4DA=;
        b=YB5d+OLphiDDWHzppMBcTOZxIKNbSKhZRyjORjV4Tq5C3tC11NjsaAJU7wTtu8nQfd
         RSLgED5K3XRoLyVFsdrirww0cDOatCW+MucpW8D5MdK5ASyvBHXynqt96SM1gvy7pC/e
         O9xdlrS4aZw+iXST2mBeVtmDc9z+RDhT2KWzyO/mt6/SEPfnzCMk1G0hP+FbFl7InE/f
         hutMXspZnJpmw5T21PWr9JGaOTF6zEAwKrXZqtIR6iIdoJroMucLWX8IU4j1UKqweNRq
         pyeDcnfqnjdMjXQ0Jc8/Xnev8YJnf1zewKps4H4q+H9tBdFtPobNgwAX43gsHHJySStc
         nryQ==
X-Gm-Message-State: AOAM53353eGNvp3BgiP/3cJDlouIN55el+hSPDSCOmSB9fz3EKabX/zE
        AX/ViY8SDL+1kjvEI8UlsqeSYFkkgJPbBu+2nKw=
X-Google-Smtp-Source: ABdhPJzLUfouWkKEbNgnmt6Uyf7gpyFM0hgGqGEzrmvrnmP8/pa2XDxulvhZtbJi5dwvUBMg9NmX2k9F0edVcx2hX5g=
X-Received: by 2002:a67:ee12:: with SMTP id f18mr7989448vsp.20.1632456646925;
 Thu, 23 Sep 2021 21:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210917035736.3934017-1-chenhuacai@loongson.cn>
 <20210917035736.3934017-2-chenhuacai@loongson.cn> <20210923205929.GA23210@duo.ucw.cz>
In-Reply-To: <20210923205929.GA23210@duo.ucw.cz>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 24 Sep 2021 12:10:35 +0800
Message-ID: <CAAhV-H5MPtfsBDH9Vo1e1n0oES_jHUrKJqk6Jgu=KD+WFFrKxA@mail.gmail.com>
Subject: Re: [PATCH V3 01/22] Documentation: LoongArch: Add basic documentations
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Pavel,

On Fri, Sep 24, 2021 at 4:59 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > Add some basic documentations for LoongArch. LoongArch is a new RISC
> > ISA, which is a bit like MIPS or RISC-V. LoongArch includes a reduced
> > 32-bit version (LA32R), a standard 32-bit version (LA32S) and a 64-bit
> > version (LA64).
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> > +Relationship of Loongson and LoongArch
> > +======================================
> > +
> > +LoongArch is a RISC ISA which is different from any other existing ones, while
> > +Loongson is a family of processors. Loongson includes 3 series: Loongson-1 is
> > +32-bit processors, Loongson-2 is low-end 64-bit processors, and Loongson-3 is
> > +high-end 64-bit processors. Old Loongson is based on MIPS, and New
> > Loongson is
>
> s/processors/processor/ , I guess.
Should be processor series here, thanks.

>
> > +Official web site of Loongson and LoongArch (Loongson Technology Corp. Ltd.):
> > +
> > +  http://www.loongson.cn/index.html
>
> It would be better to point to english version of page.
The English version doesn't exist at present.

>
> > +Developer web site of Loongson and LoongArch (Software and Documentations):
>
> Documentation.
OK, thanks.

Huacai
>
> BR,                                                             Pavel
> --
> http://www.livejournal.com/~pavelmachek
