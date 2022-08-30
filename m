Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29A25A5F10
	for <lists+linux-arch@lfdr.de>; Tue, 30 Aug 2022 11:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiH3JRx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Aug 2022 05:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiH3JRw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Aug 2022 05:17:52 -0400
X-Greylist: delayed 2655 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 30 Aug 2022 02:17:49 PDT
Received: from mail.gnudd.com (mail.gnudd.com [93.91.132.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D217CD2E95;
        Tue, 30 Aug 2022 02:17:49 -0700 (PDT)
Received: from rubini by mail.gnudd.com with local (Exim 4.94.2)
        (envelope-from <rubini@arcana.gnudd.com>)
        id 1oSwgE-0003Bx-Nf; Tue, 30 Aug 2022 10:33:06 +0200
Date:   Tue, 30 Aug 2022 10:33:06 +0200
From:   Alessandro Rubini <rubini@gnudd.com>
To:     ciminaghi@gnudd.com
Cc:     arnd@arndb.de, christophe.leroy@csgroup.eu,
        linus.walleij@linaro.org, gnurou@gmail.com, acourbot@nvidia.com,
        brgl@bgdev.pl, corbet@lwn.net, linux@armlinux.org.uk,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH] gpio: Allow user to customise maximum number of GPIOs
Message-ID: <Yw3LQjhZWmZaU2N1@arcana.i.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: GnuDD, Device Drivers, Embedded Systems, Courses
Sender: rubini@gnudd.com
In-Reply-To: <Yw3DKCuDoPkCaqxE@arcana.i.gnudd.com>
References: <Yw3DKCuDoPkCaqxE@arcana.i.gnudd.com>
  <CAK8P3a0j-54_OkXC7x3NSNaHhwJ+9umNgbpsrPxUB4dwewK63A@mail.gmail.com>
  <CACRpkda0+iy8H0YmyowSDn8RbYgnVbC1k+o5F67inXg4Qb934Q@mail.gmail.com>
  <CAK8P3a0uuJ_z8wmNmQTW_qPNqzz7XoxZdHgqbzmK+ydtjraeHg@mail.gmail.com>
  <CACRpkdb5ow4hD3td6agCuKWvuxptm5AV4rsCrcxNStNdXnBzrA@mail.gmail.com>
  <87f2ff4c-3426-201c-df86-2d06d3587a20@csgroup.eu>
  <CACRpkdYizQhiJXzXNHg7TXUVHzhkwXHFN5+e58kH4udGm1ziEA@mail.gmail.com>
  <f76dbc49-526f-6dc7-2ef1-558baea5848b@csgroup.eu>
  <CACRpkdZpwdP+1VitohznqRfhFGcLT2f+sQnmsRWwMBB3bobwAw@mail.gmail.com>
  <515364a9-33a1-fafa-fdce-dc7dbd5bb7fb@csgroup.eu>
  <CAK8P3a36qbRW8hd+1Uhi88kh+-KTjDMT-Zr8Jq9h_G3zQLfzgw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thanks davide for the good explanation
(and the link the the old email I forgot about)

> tl;dr: sta2x11 support can be removed.

Confirmed.

The point here is that we talked with the vendor. They are still using
the device (with some extra internal patches), but new development at
kernel level is stopped.

Since the device is not currently available to the general public,
it's ok to save the maintaining efforts.

I can submit patch[es] next week or ack removal if somebody submits
them earlier.

thanks
/alessandro
