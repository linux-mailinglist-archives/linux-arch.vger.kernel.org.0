Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE2F65158B
	for <lists+linux-arch@lfdr.de>; Mon, 19 Dec 2022 23:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbiLSW1i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Dec 2022 17:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiLSW1h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Dec 2022 17:27:37 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D4D12745
        for <linux-arch@vger.kernel.org>; Mon, 19 Dec 2022 14:27:36 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id c7so9579223qtw.8
        for <linux-arch@vger.kernel.org>; Mon, 19 Dec 2022 14:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrwtJ99mPIdpn902Yl38nd5oEw4ClksCy0+9+58YOqk=;
        b=UxBXVJKdoZanEEmT4XKAQM87Fh/57YuHSQEYg1wo90BnAGQGnB/Ad1wbxqkLVpoHgL
         esx1oQJsxI+i7FnsC7+M248zlv2RvHmMvMQgHmLAMP2bd1xf2qw+HG3ywTkikv8pyk73
         pQGD2dslClLgSdx8JKeggnTAWU+Ne2E3P31Gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZrwtJ99mPIdpn902Yl38nd5oEw4ClksCy0+9+58YOqk=;
        b=zHbSkGhx9MNN7ww5VZR/GEmVxDSCbORG8WAtzUT8yUgXgD6eSs8PL/h+qlzHAVQvXa
         19OMgw2+ktnN2o+3KDe9eO5PRKKIkWR/wJL77f+qlt3CRl/5ok08mNIJj5ml3NdiOS0W
         PrVhoZbGhmV/dszfyrd8sbso0NQVlyTok1IbNWZurUnjL+I4PXyczKFVP/O/2jra1lQk
         G6b6p47rUqTP9fJ5Pz4P91HEIvHwtO3B5b8nv/pi8XDeWy+vcwsPgtZ3UoeJbDJepZ6d
         CoLKtd+wCTqs+t8LheE6z2B2WNBq3sV9yr1Ijuhq/D/lLsQWOu0H+PtUWZ+/zuQvY6nC
         m0VA==
X-Gm-Message-State: AFqh2kpR2c0eSBzmVeAg3Nbk85lDoQdSuPcpAXpmlibhcP9yF4hoIjRP
        QRJT2lTLx+SR8jjIhAgpgdF8CvkgbxruExrS
X-Google-Smtp-Source: AMrXdXvAw2o8h9b889IxwwcyuIqVxzCnecVukiqbrsHbw9r66VD3pwTECMDoA8MDv3q7+4mD1X3YSA==
X-Received: by 2002:ac8:5511:0:b0:3a7:eb78:2833 with SMTP id j17-20020ac85511000000b003a7eb782833mr239024qtq.53.1671488855324;
        Mon, 19 Dec 2022 14:27:35 -0800 (PST)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com. [209.85.219.52])
        by smtp.gmail.com with ESMTPSA id bq17-20020a05622a1c1100b00397e97baa96sm6693529qtb.0.2022.12.19.14.27.34
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 14:27:34 -0800 (PST)
Received: by mail-qv1-f52.google.com with SMTP id i12so7199953qvs.2
        for <linux-arch@vger.kernel.org>; Mon, 19 Dec 2022 14:27:34 -0800 (PST)
X-Received: by 2002:a0c:c690:0:b0:4f0:656b:c275 with SMTP id
 d16-20020a0cc690000000b004f0656bc275mr1406822qvj.129.1671488854458; Mon, 19
 Dec 2022 14:27:34 -0800 (PST)
MIME-Version: 1.0
References: <0b37729c-535f-4864-aa2e-4f6088f8e63e@app.fastmail.com>
In-Reply-To: <0b37729c-535f-4864-aa2e-4f6088f8e63e@app.fastmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 19 Dec 2022 16:27:18 -0600
X-Gmail-Original-Message-ID: <CAHk-=whBeiVWAWUrPj__03MPBpQRF313-Mw05jo08Lxvx2zGcw@mail.gmail.com>
Message-ID: <CAHk-=whBeiVWAWUrPj__03MPBpQRF313-Mw05jo08Lxvx2zGcw@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic bits for 6.2
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
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

On Mon, Dec 19, 2022 at 2:29 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git asm-generic-6.2-1

Nope.

That's not the right repository.

And the right repo doesn't have that tag.

Re-do, please?

         Linus
