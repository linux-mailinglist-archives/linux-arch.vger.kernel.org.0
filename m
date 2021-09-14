Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8DD40B05E
	for <lists+linux-arch@lfdr.de>; Tue, 14 Sep 2021 16:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbhINOSj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Sep 2021 10:18:39 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:37485 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbhINOSi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Sep 2021 10:18:38 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M8QJq-1mUZ5k1ox6-004VSc for <linux-arch@vger.kernel.org>; Tue, 14 Sep
 2021 16:17:20 +0200
Received: by mail-wr1-f47.google.com with SMTP id i23so20519540wrb.2
        for <linux-arch@vger.kernel.org>; Tue, 14 Sep 2021 07:17:20 -0700 (PDT)
X-Gm-Message-State: AOAM532YDCfhCk1qDRRtXk9hwn1CoKwwtE1a+DWv1KpOzr4JDOXvyEtB
        ZUcwjtXnYIQHExs0Xy4k3xguinV4Sk4Qn/7C2mE=
X-Google-Smtp-Source: ABdhPJzVpwCq9QmY+CEgyuPxXOnlcA6hdR7rhDntwpTiX+Dg92jrwusUa4D+HhAuJ7H7o1BTV2G1biKrLf5cvWmObRg=
X-Received: by 2002:a5d:4b50:: with SMTP id w16mr19124233wrs.71.1631629040153;
 Tue, 14 Sep 2021 07:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210912212606.11854-1-kilobyte@angband.pl>
In-Reply-To: <20210912212606.11854-1-kilobyte@angband.pl>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 14 Sep 2021 16:17:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0XHaBZXwgZGKhmi1wCO+gb+NgONORm5EcrAfjcu9FiFQ@mail.gmail.com>
Message-ID: <CAK8P3a0XHaBZXwgZGKhmi1wCO+gb+NgONORm5EcrAfjcu9FiFQ@mail.gmail.com>
Subject: Re: [PATCH] asm-generic/io.h: give stub iounmap() on !MMU same
 prototype as elsewhere
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:kFmjrk0YENd+TwQoSANAhOu3/S+LZTiYCuAYJcVTDgAQ+q3rJ/9
 JSVzVr5KuUmdvXEw3FlU0aserFBi893T7DiAv9MBbbdxdm0iVtrj6q7Td6xIcq3qXZTTd40
 UGF2I2n3o+JC6DS9lyBB/JYeVLiEq1EV/2XZfaV6dIMqrwpP5M+Fk6Y7DSyXnYoIbzWoRfJ
 yP9hMnxEmnvlA+/M8MG6w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jpvaU+nMM1Q=:cCBmnjhVJbf53FM8zVvA4g
 C5i48QbkPyCcRJGBnhxbdJWwjeT+hCuLGF32UmNRq6TZKuQu9SWqfAixG3SKbU1ZM/ugOQC1r
 rWHxWFJBvT5uUMWoyrU1YoKpOK7B+hHHMqTo5/5Ae+pRG0Fs52bu71ihvI+LQwtbuxIgLoU3t
 vIyxQk0KF66FFUDbZ9A85oAhfE2NAVJlze9i1WF7oyCs45L0pm02XQ8vD8qzmenLsM6/LpNHC
 fCB2WJbL4LPoFPZgnD2JEvVp+PIbBgi3sVAkQRW/t1XhdhMmxIPMH7gR9Ji1IURE/L000P75M
 pMj8EsGMwbc+sG1IMh0B2QyMvZYqlEau2PUliHSgoBsAgBr3aAh4GEVWGz2o6bgZT3ZzGhkgy
 uj0Iu86dhPGBomI6UV2r/9XU+6hVREArWOqnb/CpQWpcJHEQghUkN47j4gmVRnpo2ilKdrCg6
 5xzNXdVnKX/xjEihD5Rt4zstCz4W+x/vXg8g8oqEFrHOsJfI8moAqvpYn32LwQDi0sZL6VLTF
 sg/cAXoT6NDna7rQQVtkdCZ1pALcbdyu6bmzHJu5YjA75ur7IOBKOsX0a5giuQ1nCSivgvn/O
 QrVrTXMy9nrMwQwXdEee7Cor127hGK6T5x+JpTIiREhcS+jNimcorZnZy4M52ODgzQpVR+vlp
 4wkLoCnY/rlFa8Exko115bxlHw6l8w2GhHgZa2ZPwvJ3Gc/qb4fxXUL3IT5zIH0R5ewKRo+mJ
 huD6tMZHQ4JjRfl8QN2y7zy9lqim1qYOkLMYhtDr5J/BavEzCP+dyD+KCcxgqxDkfHm7WUvzQ
 y3XJdxzzNnwrUVjSEryL1otQu1AYmjQONvzHRT6iGwObxgGIQxE2vkyHbcuhl5YjGFh4AczMA
 a4a567HQMc0j/9/0osMA==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 12, 2021 at 11:26 PM Adam Borowski <kilobyte@angband.pl> wrote:
>
> It made -Werror sad.
>
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>

Applied to the asm-generic-fixes branch, thanks!

      Arnd
