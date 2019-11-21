Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6A2410543B
	for <lists+linux-arch@lfdr.de>; Thu, 21 Nov 2019 15:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfKUOR4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Nov 2019 09:17:56 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:49977 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfKUORz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Nov 2019 09:17:55 -0500
Received: from mail-qv1-f53.google.com ([209.85.219.53]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MHG0U-1icD8E1LOK-00DIps; Thu, 21 Nov 2019 15:17:54 +0100
Received: by mail-qv1-f53.google.com with SMTP id q19so1458059qvs.5;
        Thu, 21 Nov 2019 06:17:53 -0800 (PST)
X-Gm-Message-State: APjAAAVpqA5krgnnod1UxadtsU6tC1uPhisER2PpVRuED5J7c07/200z
        HH6Ak6ywBu9nBl4QIQIOXAD7gRAUKjdV7n/D+ew=
X-Google-Smtp-Source: APXvYqxLKbuQ9O3FhXwBvflrp+50FRlW8iONE6qzTZEhfSBODhQm2eIXHq1gD3J2WzsjeJ9sWHPrfZS6LlKeAqhLZMY=
X-Received: by 2002:a0c:a9cc:: with SMTP id c12mr1679849qvb.222.1574345873081;
 Thu, 21 Nov 2019 06:17:53 -0800 (PST)
MIME-Version: 1.0
References: <20191108210236.1296047-1-arnd@arndb.de> <20191108210824.1534248-2-arnd@arndb.de>
 <a5f530323b66cd8c0055c5e642ef4eb035c53808.camel@codethink.co.uk>
In-Reply-To: <a5f530323b66cd8c0055c5e642ef4eb035c53808.camel@codethink.co.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Nov 2019 15:17:36 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1GSncyq6dX482ZY8TmJxT8gazFZpnJs-Jzomq6keWjHg@mail.gmail.com>
Message-ID: <CAK8P3a1GSncyq6dX482ZY8TmJxT8gazFZpnJs-Jzomq6keWjHg@mail.gmail.com>
Subject: Re: [Y2038] [PATCH 02/23] y2038: add __kernel_old_timespec and __kernel_old_time_t
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:B3GuU6WhlLaghY0A8lZ5hWCXgyDmfx6RZqU5h2D3zYmMZ0R/4zs
 fjxCL+797aqsaPmBxbOztp7yNcO/1yXdaORW4JZaSn3n3W33Nm+Db+l12tAqJUXunCWU23Z
 wRYdCVkEv9FFwpX6pS8B+GLVhKYFAqtbN4XpcL316oWLPQVeOdNYKM6lxU6UiFVyOJf2m4U
 WZbNMtzgKHdH7YZDNdiug==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:N5FS4rkFg2M=:XDTHmuFeQ21cgiOnd7mbPo
 oAvGHYQhrRFNA+6RYrC/+zbYT9lJyh0Cy2Q8/a4Gopo5U9KX5THNz/Lov8XOVCxToaqOfqHCh
 GVhd43PsNi5MnKMwBJkS2SQIsd7n9AlBa5Y29pUk0zZWxpUSFjW5EOAnmfCTyYuiLM2L1m4vx
 FxYlxJtkv2ASIOxcgmlVgFNRN7rOZFJQHIXdIGRZ2ivsZwSdSm5ieuohCQEIClnLSffd5Zrxo
 IsGQsnaNlgrXN2AJowx+d21XKK6/cWwpuTwgyTwd96OIxgQ/zc2ZeHgTTgV2gjouTaZxStJGA
 u3v/WsSCh5vGba+5Xq2NVbLy40nlz2dkcOepaTj3GusYTXrcBczPsJfKu1HX/CmLmyR/K6D9G
 30V/q6j537irhkcklg0llAX0thp4QlBA/Ykau6yTvp0XwZOFxHWMMQorkQpGrlNUVavUxUNcE
 y16tVvDMtLYgGMHAxlVmre+oBA8Z6nm8d5hcB+gqmRZEG7Jillum/YUFrqYVc1YT5ueUmBF1F
 rdifi3Dx0OPXM6h4v3us//K9P0wd0k93RyunE/3SgMSleeBDn4PfSipt9+ABGldj4fi4ptC7K
 DrfT2HqdjvCo4MVYzpebtK1AZswuQHyJTNqDwHr2kX+6oKEY1T6+IcnZo9uA6h+e3Y4pj0q+C
 UhjEGu8i8W/4an10ewCT8PeW9h7mZ8nLC0QT8+WkoOAxGVq5OZpdduIqj2SlfPD7rk1yht35/
 lFOSozF1a5fjjekH3+nVBC7cLoGDsq4Ex59q9BMx+CFECQp7E6BN7AIUdLo9ZuFoBA0zQO2X0
 lOY7pA9KmrLWjLS94WXrTHs5ejOUHeZJ6TQZGCnaqYNsECGazhwdOQLh8lk9VGoShXfRjiySd
 jhGZfwdjOMMc9M9blRKA==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 20, 2019 at 11:30 PM Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
>
> On Fri, 2019-11-08 at 22:07 +0100, Arnd Bergmann wrote:
> > The 'struct timespec' definition can no longer be part of the uapi headers
> > because it conflicts with a a now incompatible libc definition. Also,
> > we really want to remove it in order to prevent new uses from creeping in.
> >
> > The same namespace conflict exists with time_t, which should also be
> > removed. __kernel_time_t could be used safely, but adding 'old' in the
> > name makes it clearer that this should not be used for new interfaces.
> >
> > Add a replacement __kernel_old_timespec structure and __kernel_old_time_t
> > along the lines of __kernel_old_timeval.
> [...]
> > --- a/include/uapi/linux/time_types.h
> > +++ b/include/uapi/linux/time_types.h
> > @@ -28,6 +28,11 @@ struct __kernel_old_timeval {
> >  };
> >  #endif
> >
> > +struct __kernel_old_timespec {
> > +     __kernel_time_t tv_sec;                 /* seconds */
>
> Should this be __kernel_old_time_t for consistency?

Yes. I had already noticed this and changed it in the current version
of "y2038: uapi: change __kernel_time_t to __kernel_old_time_t".

      Arnd
