Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C14A668ACB
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jan 2023 05:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbjAMEVQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Jan 2023 23:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbjAMEU2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Jan 2023 23:20:28 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D3D66990
        for <linux-arch@vger.kernel.org>; Thu, 12 Jan 2023 20:15:41 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id e22so5765761qts.1
        for <linux-arch@vger.kernel.org>; Thu, 12 Jan 2023 20:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wt3jnzhUF3EcxhYr3T4hnm8uRCL7X//ykE1nGacQiX8=;
        b=QW41cnynBWFCcbN2np1bR6tedxbtO3eX5SbrPn1/lU9d4aaXmlahkT2WbS3tM/if0A
         VzpLPqX9WvAnwx7NbuqRmOaO9xqYz/nx1EGX61d8Bj2VG4zI+F4YccXnLtgT3U3a9uMK
         ML5XR8tAKhK45vk0ghApza55rwDgnktIGJWc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wt3jnzhUF3EcxhYr3T4hnm8uRCL7X//ykE1nGacQiX8=;
        b=CTnSDhmA2/wHMGkgc2rIn9+2zc1KObNbySW8dOUAJH2l449VMbFyzJKkP6QPZytSKl
         CIfBy6Qf5/nO6WH0Iz/GXd4EUSEZ+TrpQGMZCISMq6H4o/eBygs/YcFpjJjQedBeZDyt
         vXcYi2pLVkM/JcZis7QtymD7/wcgxVcB3hMnCZwipB2cyY5ManmvDeFJr1O8WZQnePqy
         LCBOO3ETcPMSo6Z9YSVXfMBzbsEqI3BSA+MX4WD1iY/Z5ne+Nj8KWExFCAKP81SOtjud
         k4RzuPStlu4jfF+NVWORD70wBy9vy5VytbUam/SE0oOtfIEi8ZvTS4B1pPwsnGPKJBan
         AYjA==
X-Gm-Message-State: AFqh2kqSq6rY4KcA9Huwu9H5GGRthO9i166fPiu5LsjOR25blbcJd7RT
        CM2kMsHDuR80O8Lxj7rM2VPgiOz1WBWZ1VIPQ+8=
X-Google-Smtp-Source: AMrXdXsVtRs3LEtncv2CZEWu417pvjB1l2mv5aO2PenVv1rjJ/U/MXrV4S8eqThwdreQb3er4d724A==
X-Received: by 2002:ac8:4519:0:b0:3a9:763b:4a6d with SMTP id q25-20020ac84519000000b003a9763b4a6dmr112473151qtn.10.1673583340809;
        Thu, 12 Jan 2023 20:15:40 -0800 (PST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com. [209.85.222.179])
        by smtp.gmail.com with ESMTPSA id bq35-20020a05620a46a300b00704c9015e68sm12097434qkb.116.2023.01.12.20.15.38
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 20:15:39 -0800 (PST)
Received: by mail-qk1-f179.google.com with SMTP id s8so7002565qkj.6
        for <linux-arch@vger.kernel.org>; Thu, 12 Jan 2023 20:15:38 -0800 (PST)
X-Received: by 2002:a05:620a:674:b0:6ff:a7de:ce22 with SMTP id
 a20-20020a05620a067400b006ffa7dece22mr4281758qkh.72.1673583338361; Thu, 12
 Jan 2023 20:15:38 -0800 (PST)
MIME-Version: 1.0
References: <CAGudoHHx0Nqg6DE70zAVA75eV-HXfWyhVMWZ-aSeOofkA_=WdA@mail.gmail.com>
 <CAHk-=wjthxgrLEvgZBUwd35e_mk=dCWKMUEURC6YsX5nWom8kQ@mail.gmail.com> <CPQQLU1ISBIJ.2SHU1BOMNO7TY@bobo>
In-Reply-To: <CPQQLU1ISBIJ.2SHU1BOMNO7TY@bobo>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Jan 2023 22:15:22 -0600
X-Gmail-Original-Message-ID: <CAHk-=wiRm+Z613bHt2d=N1yWJAiDiQVXkh0dN8z02yA_JS-rew@mail.gmail.com>
Message-ID: <CAHk-=wiRm+Z613bHt2d=N1yWJAiDiQVXkh0dN8z02yA_JS-rew@mail.gmail.com>
Subject: Re: lockref scalability on x86-64 vs cpu_relax
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, tony.luck@intel.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        Jan Glauber <jan.glauber@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 12, 2023 at 9:20 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Actually what we'd really want is an arch specific implementation of
> lockref.

The problem is mainly that then you need to generate the asm versions
of all those different CMPXCHG_LOOP()  variants.

They are all fairly simple, though, and it woudln't be hard to make
the current lib/lockref.c just be the generic fallback if you don't
have an arch-specific one.

And even if you do have the arch-specific LL/SC version, you'd still
want the generic fallback for the case where a spinlock isn't a single
word any more (which happens when the spinlock debugging options are
on).

            Linus
