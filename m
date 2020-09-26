Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8EB279C0C
	for <lists+linux-arch@lfdr.de>; Sat, 26 Sep 2020 21:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgIZTOB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Sep 2020 15:14:01 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:38719 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgIZTOA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Sep 2020 15:14:00 -0400
Received: from mail-qv1-f50.google.com ([209.85.219.50]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N1xdf-1kSYBC1Dqb-012Cya; Sat, 26 Sep 2020 21:13:59 +0200
Received: by mail-qv1-f50.google.com with SMTP id h1so3284205qvo.9;
        Sat, 26 Sep 2020 12:13:59 -0700 (PDT)
X-Gm-Message-State: AOAM530X/lzfhlYVcWnmHyzRydXSdu9ITssq83uUy4GcMxz3aGPdAtSB
        bmnp6rP5K+s/d2a5A0qP64/zL95uNlYmdPsE7YM=
X-Google-Smtp-Source: ABdhPJw/iwukTKg1GclSKE6lTSTpb5ucr5JoCxFL+sd07zV4NOrukIDXbARQdfOrxI+K+AB97dYshpN6f6+rdDPzfHs=
X-Received: by 2002:a05:6214:1873:: with SMTP id eh19mr4898917qvb.16.1601147638094;
 Sat, 26 Sep 2020 12:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200922043752.GA29151@lst.de> <mhng-9b0b114e-a104-40b7-b4f5-ad64dbbbd5bd@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-9b0b114e-a104-40b7-b4f5-ad64dbbbd5bd@palmerdabbelt-glaptop1>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 26 Sep 2020 21:13:41 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3ONxXm_MWKn9BSswtLH3etVwOUh52NYoXpj032=WP0gw@mail.gmail.com>
Message-ID: <CAK8P3a3ONxXm_MWKn9BSswtLH3etVwOUh52NYoXpj032=WP0gw@mail.gmail.com>
Subject: Re: remove set_fs for riscv v2
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:7T/lcr5em1kZ8igH32FcKnwNwzeBB/ovgz7Ywqz/KeBUqtRMkwU
 XkQtgCAqFTwN0V7Xtta5u+YJsih8TGD9QmE0A4uzu6rxSCOv35PgT/TRp+syTLEF59lICr8
 491wdRXvS2zcd9RhuQA58aQiGAdQs2bZwe7FpFTnQONanS8svvo/QJXIwkQuSoF58akot2E
 p2nezZXyGkQcFtZ8VGzmA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:amXl3hVfAds=:1uGQyARomwmRq5d4XA0F78
 nZSRETyJh014qZvfI+3+z0TtEtnbCUoP2ZGHSBR11k8qsBInDnDwJvSn2Ud/ZbU7H1dyzUMMb
 +ppXcFuUNuGkSc1Zf5fZ9uMNLu/ET84Fau4XZNudUvyPAAnnTjCACkTuYYP27PsCQM6vDjMZA
 81xbcPo98G5bGx+r5i3knJxHM/6veiNuMNSM7/d+uEJVq87Lb7GGHNUdqkjya52cHOqhSFsuQ
 lv92kVsqdt4KG463XaCXWRI+3HJiHC0MtxFzcDeTXIGs1nLPRIfoWPZvLEKCQMJtauMM73hBM
 p1TYNwfOc/osLlPCCWLo5ouoVoKhZH5J9lbU+KtM4w8i5SAmIKDWWvvjL5OzWndX5+0LxRRMT
 IENo0WnvJGZvir2BTGPVqnshiSLyF3k/0IUBBlQvBEoKQ1sa07Zr33V6mB+3d9K+KDqVDbkSS
 CVoEMdmChSpfmEV9CEjxW2RafG2vcc8+Jhm8q3HtwxzKxlFsUwwahaXwlv2IvQJUQIq/HpJ94
 FmcO5I9sfoIg97Eof4x6iXncS1Lrnj9s2ux9y92V6E1zeaKwkIft/d46c3HfIlqME1Kp4cETf
 2b2vuyY33ZeZQcbD+edjwk2gKOD+QnOmkxstp7O9Rtr+XRArFtjhMB6AUvVhlGD4ktZ6i+f1m
 UUwdLtMzJql7N4kHEaB3tUcb09ulmYObou9LN69ZTPxbTVunzMy4wVjHfqtuJ8nFhaizQ2wuf
 5Xh+QMNBjZLIav55vd0PWwZTzUh41Po9zWcNXospLW9+qaEmnEB3A8zlJanIBxJleZHnQpZ/i
 241Qg+z8nsjVb6DZJxC4GZxCh55cvAAjsZSq6dAWi4d3AkoHtQJloCWa+X/xu1PxUy+PdOhpF
 Ot3oPlIeDNezNxi8UGT0FURqUt9G8TqIqvYDhGjItw2yLZsBz6NH7hiyxo3GSY1WBTOZ+fHDB
 UUiXCicpo11GxYoWLNw/qelJ0QiZxkSKke7HXpCF/vNFutR4cW36c
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 26, 2020 at 7:50 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> I'm OK taking it, but there's a few things I'd like to sort out.  IIRC I put it
> on a temporary branch over here
>
>     https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/log/?h=riscv-remove_set_fs
>
> under the assumption it might get lost otherwise, but let me know if that's not
> what you were looking for.
>
> Arnd: Are you OK with the asm-generic stuff?  I couldn't find anything in my
> mail history, so sorry if I just missed it.

For some reason I had missed that __copy_from_user() change earlier,
but I had a closer look now and this is all very good, feel free to
add an

Acked-by: Arnd Bergmann <arnd@arndb.de>

       Arnd
