Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE293416CD8
	for <lists+linux-arch@lfdr.de>; Fri, 24 Sep 2021 09:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhIXHdV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Sep 2021 03:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244321AbhIXHdU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Sep 2021 03:33:20 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB360C061574;
        Fri, 24 Sep 2021 00:31:47 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 3so3590123vkg.7;
        Fri, 24 Sep 2021 00:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=abtQCF7RnTPLaUgJ9G/79mIUHU3ytXc+P1P5bvg/g6o=;
        b=M7IvRr8iR3qRUxLjmIMBJ3Blbz5SVBd4hylg0U8R5t0lBEbwJEahQrnrVKd2Q0y11J
         mhfpZEz7Dv0GIU+lNlzIYMk/LpovEB+GgeizI1As0EcTvM8miZa8qmAMg0jztoZ5e9tU
         fmGtjJbPLjFb+dCA4HdKE25qxA/qlYJGtT/AS9gsiWhmzZovrXUnmCEwBlkeUS3tl0Kj
         LqsvSvoMyYq3MFpzxdEpH+o2/zl+t3Uq8fCvvl7gkMPkx1a0DzyS42N648iIgRH+LiM3
         ZnbkPmLgyedPYYGARti9iDwbabReR+6vSVZ3tMYzkRg19vQPlCqVxVz6VUzi6dEnxjIg
         gx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=abtQCF7RnTPLaUgJ9G/79mIUHU3ytXc+P1P5bvg/g6o=;
        b=Ht651JC7H1vdAhL3QzmIsxHLkfgsKiyDZ/g/ryc3qS6rZmucDx6ZqjZbu0gCYx44G4
         GoeyWh9kF/Wxuv8mW5qAtCLVUcQPmfuiAQl+mpBNUV38Rho4q4w6ynARjTeO9c3Pkorb
         v/pCz1Zu+Y9uo9NjOx1gpBOtZX0DPREJSp02xBTvnOU6caMxlZyxb0MiXIoYDKl8zDpd
         bYYWZ2eRCy5AiiOtUVTJw+xAHTx/DxmnncUFOMPHwW/jK4RkmANiyBCLIqfOAUEjGUhI
         9kyQLDJ/cic7sldv7i/Os+VI0mvko3rLQzucPOA3PrShO3xl/9c4B5qawbFCq3neZC/k
         X8YQ==
X-Gm-Message-State: AOAM53020xgSiK4edzRmyU330GBCx0UT7/dzYMivaAQLcog3U4fVZstD
        HQMxE2nhyVjCtU1gUaX0YatZwqpm5Yohpz+yXmRWIyWt
X-Google-Smtp-Source: ABdhPJx9s5FHTO9CRPxBvbxiW6NAEZ3alyDvAcGyV6Fnro1bOAkCisu0Dy7JDP4mcLf2BOBevEp1S2lBZLHmzVYq8Xs=
X-Received: by 2002:a1f:2cd1:: with SMTP id s200mr6730359vks.3.1632468706923;
 Fri, 24 Sep 2021 00:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210917035736.3934017-1-chenhuacai@loongson.cn>
 <20210917035736.3934017-2-chenhuacai@loongson.cn> <20210923205929.GA23210@duo.ucw.cz>
 <CAAhV-H5MPtfsBDH9Vo1e1n0oES_jHUrKJqk6Jgu=KD+WFFrKxA@mail.gmail.com> <20210924065817.GA8576@amd>
In-Reply-To: <20210924065817.GA8576@amd>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 24 Sep 2021 15:31:34 +0800
Message-ID: <CAAhV-H5k72Wb_82Y89n_DziMF428nfk-qLSmPvuszKOMdoEDTA@mail.gmail.com>
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

On Fri, Sep 24, 2021 at 2:58 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > >
> > > > +Relationship of Loongson and LoongArch
> > > > +======================================
> > > > +
> > > > +LoongArch is a RISC ISA which is different from any other existing ones, while
> > > > +Loongson is a family of processors. Loongson includes 3 series: Loongson-1 is
> > > > +32-bit processors, Loongson-2 is low-end 64-bit processors, and Loongson-3 is
> > > > +high-end 64-bit processors. Old Loongson is based on MIPS, and New
> > > > Loongson is
> > >
> > > s/processors/processor/ , I guess.
> > Should be processor series here, thanks.
>
> Makes sense (as do the other fixes), thanks.
>
> > > > +Official web site of Loongson and LoongArch (Loongson Technology Corp. Ltd.):
> > > > +
> > > > +  http://www.loongson.cn/index.html
> > >
> > > It would be better to point to english version of page.
> > The English version doesn't exist at present.
>
> Append (cn) so that people know what to expect?
The English web page is in progress, we can update in later versions.

Huacai
>
> Best regards,
>                                                         Pavel
> --
> http://www.livejournal.com/~pavelmachek
