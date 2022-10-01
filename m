Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697755F203F
	for <lists+linux-arch@lfdr.de>; Sun,  2 Oct 2022 00:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiJAWLe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 1 Oct 2022 18:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJAWLd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 1 Oct 2022 18:11:33 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B9D4E85A;
        Sat,  1 Oct 2022 15:11:32 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d11so6795759pll.8;
        Sat, 01 Oct 2022 15:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=SRtG4ULOwUXYrlLbHbqAnJPCi/RzxeyqQsFq7yJUZCQ=;
        b=d6s6NGvPgWYKNtUDzbG8ra10Za7gavuLMKk7g2peadO4GMYxfOJdfq0McqeSel1QiW
         phbeh6UoLqiGoEwrjhTLy/iFW2yrcWN3oXPiU9fJxbGEljppIg5luWHBt3WvXwNMZNK0
         fSZ7XUq5c/2mee3+ygplZtwXVOBlRRWxL9/dQm8c8X+02vG0aUaLh78ZtmRSGH71hzd7
         hm/mLdFh3V4QOj8KqV38AX2d40XCoRmhm3Dp0O3MDk4B9csaiPDKQuT4AxnuCwW/VvIW
         wUVjGwFTcqWb25G23e16Yim95QikpxgfebfdP6Sh1Yzm+vK+j6D15IPSH2K7e65F6Yy9
         Mtyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=SRtG4ULOwUXYrlLbHbqAnJPCi/RzxeyqQsFq7yJUZCQ=;
        b=tfaEXFeg6tykcDb5nOKMXbPRjAXXXtcQwIAYexY4s7INinxJErp7xaRNv/GWhJ2b7U
         tnw4a5zmPFpK42W7Un0YdFuhjyiQHYD/z3MCRpFva+UbPI8bxA1EDk1vcNNQtxLeEYqp
         If45vFUFrN0L/wcs6U20MqUR3DFzOXej3oB2psRx/P30i+gybJrmsAK1hkXFM4D+UL/c
         /kl4dPZq+zSnJ+AuzD5wTeXbi8A7araGMrMmQdqqvmyIKNL55qksG81yk0sNOKo+tXVM
         3f9tDZ0BX1SAsjHeZIH1IhqKVVxsFulei0tm/XdV7eKpJ9jV+F6jbdc05MrupcFh5lY7
         TecA==
X-Gm-Message-State: ACrzQf1sePNXO+KuV8wGrT4H0UdxdorqcBHTXmrtlI5CTaHL+hWUrU6+
        4fcJKE5w4KT4cjkK2NLEqMsm3KaIDco=
X-Google-Smtp-Source: AMsMyM50kpqeLm3S2yWgpaeK/DsupHNloziLLUitR6V/wRmlQACr21LF1v9ZrphojveaI9hPgPwqeA==
X-Received: by 2002:a17:903:2411:b0:178:5653:ecda with SMTP id e17-20020a170903241100b001785653ecdamr15676190plo.166.1664662291950;
        Sat, 01 Oct 2022 15:11:31 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:63e7:415:943b:4707])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902a38d00b0017d061a6119sm2859135pla.116.2022.10.01.15.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 15:11:31 -0700 (PDT)
Date:   Sat, 1 Oct 2022 15:11:28 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Input: i8042: Rename i8042-x86ia64io.h to
 i8042-acpipnpio.h
Message-ID: <Yzi7EBrSXhfm24zU@google.com>
References: <20220917064020.1639709-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917064020.1639709-1-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 17, 2022 at 02:40:19PM +0800, Huacai Chen wrote:
> Now i8042-x86ia64io.h is shared by X86 and IA64, but it can be shared
> by more platforms (such as LoongArch) with ACPI firmware on which PNP
> typed keyboard and mouse is configured in DSDT. So rename it to i8042-
> acpipnpio.h.
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Applied, thank you.

-- 
Dmitry
