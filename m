Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733B353B5C8
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jun 2022 11:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbiFBJNo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jun 2022 05:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiFBJNo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jun 2022 05:13:44 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5237011142;
        Thu,  2 Jun 2022 02:13:43 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 129so4266511pgc.2;
        Thu, 02 Jun 2022 02:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BnJoYZjA/4b43P3Pawo+kmZRrFz/s9PrqOsAvadZtNM=;
        b=YKavzFI7bZlV0cIASU9nzmlObdBqUB8MOir6DIbkiyubVM1gqZg4lEygKki6iUqjk5
         Cev82mKhSNAr1eZP29RaitupnkM1kyp8p8lIOtUr+MvYPn3Zq8BiNQ4I7fhE02pQ4yYE
         1rIyrRp1bfx5WYFcipm8KPfkqzlrlCD8VwE1FGvbVm2yLYPyF0DPVGrOM4qaFQEMOKw4
         69fTu1RZEIv+gC7pvrxro7+tofbPtKngpywa/dkOQqvwQOVVCREAIiLAqIKUhW178zD8
         ZTowoewYRWQlclwXm7vgGB9AE7i5ysj2JhgOUt6fxRxUAwoLr6AIlfjmmrEW7NEca0GP
         AYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BnJoYZjA/4b43P3Pawo+kmZRrFz/s9PrqOsAvadZtNM=;
        b=WNbKSIpmOCr1GlOUdf4u2ixOKXgWsgcy6wxCfcLm9fOdpAtk4ts0XUis3w9ofbohbq
         DodV/6xl9mNYzCpiGz66dRQpONh6YqBx4J69Re0EQp3MH9NGX9Ak2PUn37RIWTfmT1ZO
         mU4fh8vVlqazRvoekkIhCiaM1MZQw/98XhvGT+H0I/Ty71AB2ohHeNYJ2FbMSqX6o8dL
         qO2tADq0HfwQikOeWS9fKMVxT5C3aaDolzY/BSkYw9inLWRfiVlheoIiYdB9/dain5RV
         rQawsg4p457jKFpGr6Aw7hRrASGbKirPYsiwr+7g4y6d5MRawnUQHZC2tAKUfM0Nt/tX
         YTeg==
X-Gm-Message-State: AOAM530WEgCzOt8gr5hpi0gYMwIvpGoLNTGXrTgvloowbfB+pwjaZqee
        CGwywEek7EhnxZ1+s+BcHD4=
X-Google-Smtp-Source: ABdhPJxky6cAMNOEzhcAehlSp4DH4JPBTsmSJrQjyQWPkOf4W7b8tuVS6qW3+f0uHz2DvOIPl3hklA==
X-Received: by 2002:a65:6c07:0:b0:3f2:5efb:6c7 with SMTP id y7-20020a656c07000000b003f25efb06c7mr3458478pgu.496.1654161222925;
        Thu, 02 Jun 2022 02:13:42 -0700 (PDT)
Received: from localhost (subs02-180-214-232-24.three.co.id. [180.214.232.24])
        by smtp.gmail.com with ESMTPSA id z28-20020aa79e5c000000b005184af1d72fsm3019273pfq.15.2022.06.02.02.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 02:13:42 -0700 (PDT)
Date:   Thu, 2 Jun 2022 16:13:39 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        WANG Xuerui <git@xen0n.name>
Subject: Re: [PATCH V12 03/24] Documentation: LoongArch: Add basic
 documentations
Message-ID: <Yph/Q+szVkhDPg4a@debian.me>
References: <20220601100005.2989022-1-chenhuacai@loongson.cn>
 <20220601100005.2989022-4-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220601100005.2989022-4-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 01, 2022 at 05:59:44PM +0800, Huacai Chen wrote:

> +Note: The register ``$r21`` is reserved in the ELF psABI, but used by the Linux
> +kernel for storing the percpu base address. It normally has no ABI name, but is
> +called ``$u0`` in the kernel. You may also see ``$v0`` or ``$v1`` in some old code,
> +they are deprecated aliases of ``$a0`` and ``$a1`` respectively.

A nitpick: instead of just comma (,), also use "however" conjunction, that
is "You may also see ..., however they ... ."

> +
> +Note: You may see ``$fv0`` or ``$fv1`` in some old code, they are deprecated
> +aliases of ``$fa0`` and ``$fa1`` respectively.
> +

The nitpick above also applies here, too.

Otherwise, htmldocs built successfully without any new warnings.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
