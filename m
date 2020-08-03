Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBD423ADC9
	for <lists+linux-arch@lfdr.de>; Mon,  3 Aug 2020 21:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgHCTvT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Aug 2020 15:51:19 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:44847 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbgHCTvS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Aug 2020 15:51:18 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N0X4c-1kz4Qi3fU4-00wYvQ; Mon, 03 Aug 2020 21:51:17 +0200
Received: by mail-qk1-f172.google.com with SMTP id d14so36283277qke.13;
        Mon, 03 Aug 2020 12:51:16 -0700 (PDT)
X-Gm-Message-State: AOAM5309Z18JMxzK449IjpocCeEVIlVM2ug0Qr/L7ntvmqgeMr2wE0Or
        +qAmaZxmrI4zyjZTSZC+NR3PR+fKSyRGx5sIWfs=
X-Google-Smtp-Source: ABdhPJzXbakRhT/9DWqVXTuVR8CfkgieaCHqepsu4ZZ/ORIbDhqwN1vHGkMOM70/LNdH8z9+PBsj6hyq23fJ3eMBpfo=
X-Received: by 2002:a37:9004:: with SMTP id s4mr17629472qkd.286.1596484275660;
 Mon, 03 Aug 2020 12:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200803151134.3740544-1-shorne@gmail.com>
In-Reply-To: <20200803151134.3740544-1-shorne@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 3 Aug 2020 21:50:59 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1m=PPg1sDdRsCz7BOu44-zD87b80SvdZbMuvfLTWsc-A@mail.gmail.com>
Message-ID: <CAK8P3a1m=PPg1sDdRsCz7BOu44-zD87b80SvdZbMuvfLTWsc-A@mail.gmail.com>
Subject: Re: [PATCH] asm-generic/io.h: Fix sparse warnings on big-endian architectures
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:UgOW1dNGGTMrAPNwvxp2MHDEgnMOwt5LjVoykbLr6P+1/V3vqj5
 tcg2p26mjtywVVkmjK4qz9KN+/EmcboZiOljkfrHu8ym5VNLWloLSanebDHAr75R8eBVXJh
 VADkvIt5B7gzwmXC60+GK0F24hSul6pEMhSIzKFJySxWqUC2Tc5zy+ZTqTfIc2fUT1GiS+V
 NePZHQo63kQ9cSJ+BQseg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BHXUN0dyYTg=:47gWcfEKDH2jJPDSxNISRr
 vn9yHtuI7YCGOCIs1h+gHNKjcXT4Ul83QA1ds0K8DKtH3DAD1nMZeUe00HUaOoZ8kbM/yA+Ku
 bqf7q135a4VTpAsL5y+IyRyL3P+p13YCpUA/iRQ481epS8qWMDHsA+8rRb3BHb1Wy3G8vmx7Y
 8ePtFb1NkOxS74e6hAd4cKZNYaxjRIV0Pz5pPCxQ5kC1mNINY/YmTVQDnjBOQHm+v/4P8Lwqa
 OK3aW0meRUhK3MmCGqWBhZQ8/7BANgrNdeAUtQ0uu09o68xSXG1last5I2F1tRNtnzV2VtkgM
 QX0lH3WY9DR9hYzlfizGqWE/RMjEr93/Mms0tFt5AYjPkTuCRjFxKqw1Xqecsak/XaYqwYHZD
 Uct0f3pBqs+PBf8vaQuyuCmmCsTeGF+g2lnxWKpIwp4MSpGm4mkvRfASRk8EOZRVXhC+QwC7i
 QbEfnoGrKDvl2BRbWOvhrqWUtsA9NnSgMYytf+aIvGOTJpMRBksYcfYK/6nTT8KKc0+GCbONE
 /XPQWHw9Nq7BZ29DOKA+EI2j02CNDpT/E26kor50wtv8uulAh3H1GZQelN2qukZtTayiybjyR
 movXtSptutsjQEidOGuPRiEtBSYdP5paa37i4Hky2orrlYpCUYFeqwJ8sbSvJBwgN/m6Nrh2B
 xuNb5CtZkCg55ZurfvcvQyzeCnyWP+JfKuazK7PJFfaUR9pyqR4gkNQhZTG5uQ4mfED9qgvJN
 NnF9A3ZBxNNO5e0bI9qojMieN2bKwUUkkiDP1ow65sQyJzv8m8x9NRUTBH+jPunHvfc+iyNty
 xMKvdREEBQf+8/yyS9CKQfzW6ZwPYhXFT5LygbNES7FtKf92r6TRTmE7yovNfVPH3OWh5zK
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 3, 2020 at 5:11 PM Stafford Horne <shorne@gmail.com> wrote:
>
> On big-endian architectures like OpenRISC, sparse outputs below warnings on
> asm-generic/io.h.  This is due to io statements like:
>
>   __raw_writel(cpu_to_le32(value), PCI_IOBASE + addr);
>
> The __raw_writel() function expects native endianness, however
> cpu_to_le32() returns __le32.  On little-endian machines these match up
> and there is no issue.  However, on big-endian we get warnings, for IO
> that is defined as little-endian the mismatch is expected.
>
> The fix I propose is to __force to native endian.
>
> Warnings:
>
> ./include/asm-generic/io.h:166:15: warning: cast to restricted __le16
> ./include/asm-generic/io.h:166:15: warning: cast to restricted __le16
> ./include/asm-generic/io.h:166:15: warning: cast to restricted __le16
> ./include/asm-generic/io.h:166:15: warning: cast to restricted __le16
> ./include/asm-generic/io.h:179:15: warning: cast to restricted __le32
> ./include/asm-generic/io.h:179:15: warning: cast to restricted __le32
> ./include/asm-generic/io.h:179:15: warning: cast to restricted __le32
> ./include/asm-generic/io.h:179:15: warning: cast to restricted __le32
> ./include/asm-generic/io.h:179:15: warning: cast to restricted __le32
> ./include/asm-generic/io.h:179:15: warning: cast to restricted __le32
> ./include/asm-generic/io.h:215:22: warning: incorrect type in argument 1 (different base types)
> ./include/asm-generic/io.h:215:22:    expected unsigned short [usertype] value
> ./include/asm-generic/io.h:215:22:    got restricted __le16 [usertype]
> ./include/asm-generic/io.h:225:22: warning: incorrect type in argument 1 (different base types)
> ./include/asm-generic/io.h:225:22:    expected unsigned int [usertype] value
> ./include/asm-generic/io.h:225:22:    got restricted __le32 [usertype]
>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Looks good to me.

Acked-by: Arnd Bergmann <arnd@arndb.de>

Can you just merge that through your openrisc tree? I don't have
any other asm-generic changes for this merge window.
