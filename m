Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC03159AF5C
	for <lists+linux-arch@lfdr.de>; Sat, 20 Aug 2022 20:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiHTSBt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 20 Aug 2022 14:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiHTSBs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Aug 2022 14:01:48 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599F02AE1C
        for <linux-arch@vger.kernel.org>; Sat, 20 Aug 2022 11:01:45 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id io12so2137449ejc.2
        for <linux-arch@vger.kernel.org>; Sat, 20 Aug 2022 11:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=G+grvKBjCAQ23nLTFvq8USGall6C9xqY2mA86Y/AIhg=;
        b=SYklTh+ZwnMHWr4R06atDe3bNDPz4t2IeKWXhf7HPywfl6qH94d9DSEihQoh0xngE0
         XKWaUMFaQk9rTFuW/5QCgAlRDnxEc2e5l7rgkgu+L9A1qk4JMZv0EYyBB0jYVnvx9jg6
         lKj6YE42n9OLAQdDgjl0d/ayYaY3d/MdB07LY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=G+grvKBjCAQ23nLTFvq8USGall6C9xqY2mA86Y/AIhg=;
        b=bAQB1ZRGNlGBpVEK1mVMwBA/pr7cZqrU4RPJDQiAKjLWxqdMRUnerklxpQpr7UdZAD
         zN7+aI8Q123Y0j2/9Juis7bm+vE75a6UIXyzrcKjNsNQyqZIbbWUSFF/H/KE/79iC+Cg
         8T8HLcS7pXckORCWm+psyTy1HtZBrRz5YYeMPRR/VYHG+11J95DV3T7cnm+gGOCTZClG
         6GTAXLUyvpBBIIpIQOeSQ8xDGcgZIdSxsePonOIFJ0hwRcAGccoPdRUWfd5cjFWFGcqH
         LdfianaFwWt6txZ2uKsByQV5Lv4GYRZXi7Z8PEqE0UW2MM5aRSTGGiBv4VGG1W0LnihO
         V3CQ==
X-Gm-Message-State: ACgBeo1hkAMRaLj3rPaj37eoNdleufyhBvJQPompU+Ezh4iihvEtsZgu
        ygz2GfC8E8GgDpkS7NF9duXQlqVOPL96np5e
X-Google-Smtp-Source: AA6agR4NvkCilzWuRZHaZ7Ji35q1SMVusghbneMPPSKh8DqxzTmxrp1cqjW8l4+mhZA1P1zZhrHN5Q==
X-Received: by 2002:a17:906:8cb0:b0:731:5149:a983 with SMTP id qr48-20020a1709068cb000b007315149a983mr8190141ejc.549.1661018503623;
        Sat, 20 Aug 2022 11:01:43 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id g22-20020aa7c596000000b0043c0fbdcd8esm4981112edq.70.2022.08.20.11.01.42
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Aug 2022 11:01:42 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id v7-20020a1cac07000000b003a6062a4f81so5614054wme.1
        for <linux-arch@vger.kernel.org>; Sat, 20 Aug 2022 11:01:42 -0700 (PDT)
X-Received: by 2002:a05:600c:2195:b0:3a6:b3c:c100 with SMTP id
 e21-20020a05600c219500b003a60b3cc100mr7623351wme.8.1661018502110; Sat, 20 Aug
 2022 11:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <YwBWJYU9BjnGBy2c@ZenIV> <20220820033730.1498392-1-viro@zeniv.linux.org.uk>
 <20220820033730.1498392-4-viro@zeniv.linux.org.uk>
In-Reply-To: <20220820033730.1498392-4-viro@zeniv.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 20 Aug 2022 11:01:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgLzPq42K8w8M6u__p8fu-FbN6VwvhE3Vvu9n_Pb0kwUQ@mail.gmail.com>
Message-ID: <CAHk-=wgLzPq42K8w8M6u__p8fu-FbN6VwvhE3Vvu9n_Pb0kwUQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] termios: consolidate values for VDISCARD in INIT_C_CC
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 19, 2022 at 8:37 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> However, util-linux still resets it to ^O on any architecture,
> ^O is the historical value, kernel ignores it anyway and finally,
> Linus said "Just change everybody to do the same, nobody cares
> about VDISCARD".

Heh. Grepping for DISCARD_CHAR() shows that there literally doesn't
seem to be any user.

I  guess some user space program could care what the initial value is,
but it seems very unlikely.

                Linus
