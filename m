Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2DD6AB50A
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 04:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCFDVp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Mar 2023 22:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCFDVo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Mar 2023 22:21:44 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C21A12589;
        Sun,  5 Mar 2023 19:21:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4BEDBCE0E6D;
        Mon,  6 Mar 2023 03:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C92C4339C;
        Mon,  6 Mar 2023 03:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678072898;
        bh=pv8wEDoyBv2b1A68E+Gby64QdTGgcQAxaKKzEZ9lwg0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mmsT6hwIuat+dw5ClAts+TaEBza1mV1u7iOolfUNISctHIuuhoP5wp0B1xIjdalQq
         InkuOp1S607k4AyFSYaLUGCPeySLg9V1MWe79fhZNg9O8Fc+gk05zmKA3KWaOMwPYY
         FXEp/UIoAezznxVNw/qx1kq3lEzU0VGttbseT8mrf/J77bnHb9DLRB8JJ8MextEhL3
         0PMUZzeHX9+9j6HIbph56wQg6DLk7ctoghIO7/GIbwhtCvbNUlHcOXmXkxP/iXRdeQ
         wKNtd/TdU6RlJLYhPsuMDWDIPKEYUowI70JJsMtLMCIO8L28cEIffYXfU/1DgO1xkH
         EHWDv1FcMgVfw==
Received: by mail-ed1-f47.google.com with SMTP id s11so32923329edy.8;
        Sun, 05 Mar 2023 19:21:38 -0800 (PST)
X-Gm-Message-State: AO0yUKWuvrjMvXo4+POBY4BmopLHuhe71EMDggowMbCKUwvbZw6QNUfD
        IlFyl/QuAyXypfq/l+sGD++mNgpW7manT7P/gTw=
X-Google-Smtp-Source: AK7set+v/sQets5ucBK7ug/sAkL2ojd3qvp7Md6yoDGFmcT1Zo+FEUa7QLiDvpZuq0zeLaUe1JpDSKj1ynBL7/TpCCo=
X-Received: by 2002:a17:906:f47:b0:8b0:e909:9136 with SMTP id
 h7-20020a1709060f4700b008b0e9099136mr4488372ejj.1.1678072896840; Sun, 05 Mar
 2023 19:21:36 -0800 (PST)
MIME-Version: 1.0
References: <20230306031258.99230-1-chenhuacai@loongson.cn> <984b486f-0613-6adc-4e87-5fc00560498f@infradead.org>
In-Reply-To: <984b486f-0613-6adc-4e87-5fc00560498f@infradead.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 6 Mar 2023 11:21:26 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4tMTaZQAu7tUoZXbdq0F80+BY+4eesZwavH0V6JO-RBQ@mail.gmail.com>
Message-ID: <CAAhV-H4tMTaZQAu7tUoZXbdq0F80+BY+4eesZwavH0V6JO-RBQ@mail.gmail.com>
Subject: Re: [PATCH V2] LoongArch: Provide kernel fpu functions
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 6, 2023 at 11:15=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Hi,
>
>
> On 3/5/23 19:12, Huacai Chen wrote:
> > +void kernel_fpu_begin(void)
> > +{
> > +     if(this_cpu_read(in_kernel_fpu))
>
>         if (
> > +             return;
> > +
> > +     preempt_disable();
> > +     this_cpu_write(in_kernel_fpu, true);
> > +
> > +     if (!is_fpu_owner())
> > +             enable_fpu();
> > +     else
> > +             _save_fp(&current->thread.fpu);
> > +}
> > +EXPORT_SYMBOL(kernel_fpu_begin);
> > +
> > +void kernel_fpu_end(void)
> > +{
> > +     if(!this_cpu_read(in_kernel_fpu))
>
>         if (
>
> i.e., add a space after "if".
OK, thanks.

Huacai
>
> > +             return;
> > +
> > +     if (!is_fpu_owner())
> > +             disable_fpu();
> > +     else
> > +             _restore_fp(&current->thread.fpu);
> > +
> > +     this_cpu_write(in_kernel_fpu, false);
> > +     preempt_enable();
> > +}
> > +EXPORT_SYMBOL(kernel_fpu_end);
>
> --
> ~Randy
