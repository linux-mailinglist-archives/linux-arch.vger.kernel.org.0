Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7775F203D
	for <lists+linux-arch@lfdr.de>; Sun,  2 Oct 2022 00:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiJAWFZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 1 Oct 2022 18:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiJAWFY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 1 Oct 2022 18:05:24 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B187520B9;
        Sat,  1 Oct 2022 15:05:22 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d24so6797482pls.4;
        Sat, 01 Oct 2022 15:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=I7JqWW70Kl7IEMXaO3wvfoltNONqFvJwW8PmLRCKkHM=;
        b=ISESwcDmguedJbf16QBUBnjNWI4g9+oBk4jzQnhzPx9nIeMxhzCwF5v814Mnza1IrV
         rtAJ3iHGMISOkOc58FvzUnt6eKjf2g7TshaaXaZBNikmwcBy04R9WWyVR49A1mpmcm9A
         n0DW0xxrgn7/OQFW61stldmwwMOUg9Ubx/KY2wtpWlfNFVV0RyAi0/j0QyadmM/BbHgR
         0MD/lO0+J+AICf0Di126i492UFl9Gk3tHmmZMaeVVnEX/EHcKY/84QhSit/oxiMfDj6Y
         dpsK7mjr5SG0uvzA5mbRXBMXJMzW0cWxdjC8HZfyi5dQa1VsKeacDz2Sf8Z0alhb6/V4
         AcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=I7JqWW70Kl7IEMXaO3wvfoltNONqFvJwW8PmLRCKkHM=;
        b=uWlbYL3QVIZuQEvJNp4bKTdBduf7OIGJHVGazNUpdK05wXgexKhuzrahk5VPa20Nj/
         a16HGjl3Jlr4LQjNiLQKUiRPXd6iNZEhQnIP9hXuVvFwLxnRhfbWegDTRkt5A/ho3FEr
         qFEEivsLzp5PhpnVAXOmSCiev5aO+ipv6AreDXNH192oUnm+QsOKWXQVo9vEMr1QG/RX
         KVYRoJE7713TBk1OPM/uPmf9+Svvp76O/isXe9DgR8yEkCVPkWdnRBP34pFNKRbqhmtC
         ddN7pra+vU/DrcR9jXeRoAk0DcK9XgK0XEGsDBRk42h6ZsHiLyU5nk1kEzGePyEDiA1w
         wHUQ==
X-Gm-Message-State: ACrzQf16uUk72VVjjh9w6UTVXcLalvx6ksqUutoNkFVt/Z0LnZCZ6fs2
        VRCF0Nz2vNfue86S9rGm7Ts=
X-Google-Smtp-Source: AMsMyM7edeL+zbuxo+AKakfLc2ZG2Nza6yyxoiNhQIWu3lVaW/UCq2b81Ui/vDRrch8MMXPzNiPWkg==
X-Received: by 2002:a17:90b:3ec7:b0:202:b984:8436 with SMTP id rm7-20020a17090b3ec700b00202b9848436mr4957641pjb.4.1664661921681;
        Sat, 01 Oct 2022 15:05:21 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:63e7:415:943b:4707])
        by smtp.gmail.com with ESMTPSA id l12-20020a170903244c00b0016be596c8afsm4378055pls.282.2022.10.01.15.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 15:05:20 -0700 (PDT)
Date:   Sat, 1 Oct 2022 15:05:17 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Input: i8042: Add LoongArch support in
 i8042-acpipnpio.h
Message-ID: <Yzi5nWCeVYV37Htb@google.com>
References: <20220917064020.1639709-1-chenhuacai@loongson.cn>
 <20220917064020.1639709-2-chenhuacai@loongson.cn>
 <87a66rhkri.fsf@baylibre.com>
 <CAAhV-H6YLstS+GqaXv2Y9p_QVAU4x=nrunP_Hd2GeznOWG6q4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H6YLstS+GqaXv2Y9p_QVAU4x=nrunP_Hd2GeznOWG6q4g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 30, 2022 at 10:41:59AM +0800, Huacai Chen wrote:
> Hi, Mattijs,
> 
> On Thu, Sep 22, 2022 at 4:32 PM Mattijs Korpershoek
> <mkorpershoek@baylibre.com> wrote:
> >
> > On Sat, Sep 17, 2022 at 14:40, Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > > LoongArch uses ACPI and nearly the same as X86/IA64 for 8042. So modify
> > > i8042-acpipnpio.h slightly and enable it for LoongArch in i8042.h. Then
> > > i8042 driver can work well under the ACPI firmware with PNP typed key-
> > > board and mouse configured in DSDT.
> > >
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> >
> > I would have split the pr_info() move in its own patch since it seems
> > like a "valid fix" on its own, but i'm probably too pedantic about this.
> >
> > So, please take my:
> >
> > Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> I think the pr_info is needed for all architectures, and the moving is
> very simple so I haven't split it. But anyway, if Dmitry also thinks
> this patch should be split, I will send a new version. :)

The reason for ia64 not emitting this message is because we "trust" ia64
firmware and it is quite normal for it not to have i8042 implementation,
whereas there are a lot of legacy devices on x86 and not having PS/2
keyboard is still not very common.

I moved the pr_info() back into x86/loongarch branch and applied.

Thanks.

-- 
Dmitry
