Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4021E4C7FF6
	for <lists+linux-arch@lfdr.de>; Tue,  1 Mar 2022 02:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiCABEb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 20:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiCABEa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 20:04:30 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99D3237EC
        for <linux-arch@vger.kernel.org>; Mon, 28 Feb 2022 17:03:50 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id u11so19799547lju.4
        for <linux-arch@vger.kernel.org>; Mon, 28 Feb 2022 17:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+UrwimTIhzKiU9pJv3o5X6bf+6FXMWBGxz+Z+GIIGDc=;
        b=avIYh8aQ2dDobwKAVUmxzj/7dS14/rGtEVGY0pMiaJUsHbP3qIU6kno3XMfBz/RlQM
         DBr9tOtZ8iqO/uKNwSujAwo9mle8zBl2HT1HDuvvvRH+Bqr8BYPzCJojUUOk2VYbR5wW
         hMzIeM3di7snjNNfrAaBZvtX47IfluwYB/RPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+UrwimTIhzKiU9pJv3o5X6bf+6FXMWBGxz+Z+GIIGDc=;
        b=bK5Ff3REYWnZFkG7fu73Xzjmk5aMYULZRg+CdeyRknR08HVePkeYHxvs70beUScapU
         J1YohkotQfPM5NU5/4tLnNaDlQFS5QLmj7ZbG8vlNwzbCZNVwirRNSBxHug7wZhoAINK
         Brt8hInh8XiMmvO93c8cZ+V1Rb7Q2U7nugPmHxUes6AXv7J31C3rYU4fgeirV5R4nPEt
         viL0dSfMj6VeORINcGLmgY7/c1eUxaJFLs/zMBR9vQsJZN459CUMBk7QIrRFoYbOFgoa
         IIwZykpFnjdd7u9Yr+CdG8Hn+GkQM5EpvQq0Yl+SmdvLYdKWWYRr0zrlEC9i0Y9q8eIB
         ye6w==
X-Gm-Message-State: AOAM533T8EPphr+ISC0qIQALka/KAOUTVZXVQXKVYHYCxicJD0j7AwOi
        pvCS90sFwAD6sdeRNXwfcVkQ4080rztnwep7i+M=
X-Google-Smtp-Source: ABdhPJw1DQfv6L51dAALzEf8CtgB/J0a+MpGdyMMBpzSmDXcCkQ4xoCuUqVcCBXWWtwe4z713wzjcg==
X-Received: by 2002:a05:651c:1148:b0:244:bb6a:ed9a with SMTP id h8-20020a05651c114800b00244bb6aed9amr15571720ljo.510.1646096628990;
        Mon, 28 Feb 2022 17:03:48 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id v25-20020a056512049900b00443f5c2edb6sm1220969lfq.81.2022.02.28.17.03.48
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 17:03:48 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id i11so24349269lfu.3
        for <linux-arch@vger.kernel.org>; Mon, 28 Feb 2022 17:03:48 -0800 (PST)
X-Received: by 2002:a05:6512:3042:b0:437:96f5:e68a with SMTP id
 b2-20020a056512304200b0043796f5e68amr14803965lfb.449.1646096282839; Mon, 28
 Feb 2022 16:58:02 -0800 (PST)
MIME-Version: 1.0
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-3-jakobkoschel@gmail.com> <2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
 <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
 <CAHk-=wj8fkosQ7=bps5K+DDazBXk=ypfn49A0sEq+7-nZnyfXA@mail.gmail.com>
 <CAHk-=wiTCvLQkHcJ3y0hpqH7FEk9D28LDvZZogC6OVLk7naBww@mail.gmail.com>
 <Yh0tl3Lni4weIMkl@casper.infradead.org> <CAHk-=wgBfJ1-cPA2LTvFyyy8owpfmtCuyiZi4+um8DhFNe+CyA@mail.gmail.com>
 <Yh1aMm3hFe/j9ZbI@casper.infradead.org> <CAHk-=wi0gSUMBr2SVF01Gy1xC1w1iGtJT5ztju9BPWYKjdh+NA@mail.gmail.com>
In-Reply-To: <CAHk-=wi0gSUMBr2SVF01Gy1xC1w1iGtJT5ztju9BPWYKjdh+NA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Feb 2022 16:57:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=whqJmCZ+VHTJPwsHYc1YNNEvWS7=ukqGKfBxcBYAToAkw@mail.gmail.com>
Message-ID: <CAHk-=whqJmCZ+VHTJPwsHYc1YNNEvWS7=ukqGKfBxcBYAToAkw@mail.gmail.com>
Subject: Re: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
To:     Matthew Wilcox <willy@infradead.org>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        alsa-devel@alsa-project.org, linux-aspeed@lists.ozlabs.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-iio@vger.kernel.org, nouveau@lists.freedesktop.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        samba-technical@lists.samba.org,
        linux1394-devel@lists.sourceforge.net, drbd-dev@lists.linbit.com,
        linux-arch <linux-arch@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-staging@lists.linux.dev, "Bos, H.J." <h.j.bos@vu.nl>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        intel-wired-lan@lists.osuosl.org,
        kgdb-bugreport@lists.sourceforge.net,
        bcm-kernel-feedback-list@broadcom.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergman <arnd@arndb.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        v9fs-developer@lists.sourceforge.net,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sgx@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, linux-usb@vger.kernel.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        tipc-discussion@lists.sourceforge.net,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        dma <dmaengine@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mike Rapoport <rppt@kernel.org>
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

On Mon, Feb 28, 2022 at 4:45 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Yeah, except that's ugly beyond belief, plus it's literally not what
> we do in the kernel.

(Of course, I probably shouldn't have used 'min()' as an example,
because that is actually one of the few places where we do exactly
that, using our __UNIQUE_ID() macros. Exactly because people _have_
tried to do -Wshadow when doing W=2).

                 Linus
