Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD50599996
	for <lists+linux-arch@lfdr.de>; Fri, 19 Aug 2022 12:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347938AbiHSKNV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 06:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347910AbiHSKNU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 06:13:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F16FC78;
        Fri, 19 Aug 2022 03:13:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF5A261668;
        Fri, 19 Aug 2022 10:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E56C433D7;
        Fri, 19 Aug 2022 10:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660903993;
        bh=o0CbF48Em5mz96sWmVzpRgH6GD8V922DFwPtfVZO4mY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Iu4yRLVg0mGRzqy2Gb9BTsjZd+iv43FYdTNqM8QHqWrfcbMOZhzm11YvYV8zO2BJM
         +TAfrh4k8dE/BmaIPKACNCxxjElpysjNEVqKC/FjEfjzs8aJL8yXVCP4W6ilcF98Ys
         9GN7KjAZtCJw0nTGvhZngtpunNQP/4Gs0TwkGNLy/YW8WXxlb1hQM7pAiSqfMVTKrB
         0S5v93PhOd92rs8iCQuShIVqe82NjfQSluLT2Ek5E6fUCeeYu2dGmnVg8Cf0fHeThZ
         jiq1Z4dYZgZDB6v3mD3f5p38lv3VTZs1tPx90+mOKKtZ3kjneDnOn067XmEuAA4nS3
         PAmjUjmosnS3g==
Received: by mail-vk1-f175.google.com with SMTP id i67so2016332vkb.2;
        Fri, 19 Aug 2022 03:13:13 -0700 (PDT)
X-Gm-Message-State: ACgBeo25tu74ZRdg8hLQ7sxKOhicD+T8HAxhPaWgyA/E2kNFKSz4mhuC
        Pli8Px9ZTkMrIQ1N6WZJJ4d2dHvnIMQw6o3WVyM=
X-Google-Smtp-Source: AA6agR7QvqrHDLKBVyC6y3I0WHwCh8PMlGo0hzgqcRFzBayBWFsAos0fr3N2QfGQf/NIxzEoE8IsqK46YT2xHyQPp7A=
X-Received: by 2002:a1f:1d4d:0:b0:382:59cd:596c with SMTP id
 d74-20020a1f1d4d000000b0038259cd596cmr2771878vkd.35.1660903992157; Fri, 19
 Aug 2022 03:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220818042208.2896457-1-chenhuacai@loongson.cn>
 <98d716a4-04de-ff32-1bbc-cac576989a87@loongson.cn> <ce96bcc9bf0aa24d1be5a91d07e6e7515c4d0c33.camel@xry111.site>
 <5d338fcd-d225-6fe1-1b94-0fce94a3fb0f@loongson.cn>
In-Reply-To: <5d338fcd-d225-6fe1-1b94-0fce94a3fb0f@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 19 Aug 2022 18:12:59 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6OaMOnhddiY2WSjiag5sFwAG6gab2m22nZonjnUbCN9w@mail.gmail.com>
Message-ID: <CAAhV-H6OaMOnhddiY2WSjiag5sFwAG6gab2m22nZonjnUbCN9w@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] LoongArch: Add CPU HWMon platform driver
To:     Jianmin Lv <lvjianmin@loongson.cn>
Cc:     Xi Ruoyao <xry111@xry111.site>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, all,

If ACPI TZ is widely configured, this patch can be dropped, but I
found most users don't have ACPI TZ in their machines.

Huacai

On Fri, Aug 19, 2022 at 8:59 AM Jianmin Lv <lvjianmin@loongson.cn> wrote:
>
>
>
> On 2022/8/18 =E4=B8=8B=E5=8D=886:08, Xi Ruoyao wrote:
> > On Thu, 2022-08-18 at 15:08 +0800, Jianmin Lv wrote:
> >> I don't think we need the driver any more, we have thermal zone based
> >> acpi which implemented more functions include the function here.
> >>
> >> And, the driver will conflict with acpi thermal
> >> driver(drivers/acpi/thermal.c), which leads to confusion with users.
> >
> > Hmm... I reverted this in my local tree then the CPU temperature
> > disappeared from /sys/class/hwmon.  I have CONFIG_ACPI_THERMAL=3Dy.  Am=
 I
> > doing something wrong or we need to wait for a firmware update for the
> > ACPI thermal zone device?
> >
>
> Maybe your firmware does not config TZ, you can confirm that by checking
> DSDT as following:
>
> cp /sys/firmware/acpi/tables/DSDT ./
> iasl DSDT
>
> and in produced DSDT.asl, check if TZ is in it.
>
>
> >
>
