Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9CD2D0219
	for <lists+linux-arch@lfdr.de>; Sun,  6 Dec 2020 10:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbgLFJCd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Dec 2020 04:02:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:51694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgLFJCc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Dec 2020 04:02:32 -0500
Date:   Sun, 6 Dec 2020 10:01:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607245312;
        bh=fcaGZ5LUkxrPA+V30rlNwNOCcQI1azfZbmbtwpENhP8=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=o/0NfLcdW4ao8C/sPiiX7YsHOMWQQO2Qf5NjJIp7NsfXv4gKCwqpxmnVbUOwc5QUS
         WocRjdSgpU/cgslSgghLA1oaLK0M3sHcd5gNech3/1E8v3X3aGx1U6TDQn70PrJoei
         BoI4eOgejIwcwH8Amp2YU1bQX53yPluxsglWQJks=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yun Levi <ppbuk5246@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        richard.weiyang@linux.alibaba.com, christian.brauner@ubuntu.com,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, rdunlap@infradead.org,
        masahiroy@kernel.org, peterz@infradead.org,
        peter.enderborg@sony.com, krzk@kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Kees Cook <keescook@chromium.org>, broonie@kernel.org,
        matti.vaittinen@fi.rohmeurope.com, mhiramat@kernel.org,
        jpa@git.mail.kapsi.fi, nivedita@alum.mit.edu,
        Alexander Potapenko <glider@google.com>, orson.zhai@unisoc.com,
        Takahiro Akashi <takahiro.akashi@linaro.org>, clm@fb.com,
        Josef Bacik <josef@toxicpanda.com>, dsterba@suse.com,
        dushistov@mail.ru,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/8] lib/find_bit.c: Add find_last_zero_bit
Message-ID: <X8yd/Em7ZQv7I32a@kroah.com>
References: <20201206064624.GA5871@ubuntu>
 <X8yWxe/9gzosFOam@kroah.com>
 <CAM7-yPSpqCUEJqJW+hzz9ccJbU5OnOZj1Vpyi8d5LG5=QbCTjA@mail.gmail.com>
 <CAM7-yPQgkh=JnW_mtX9fXRin87sHQjh+58aY3asgBvHK+g3V_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM7-yPQgkh=JnW_mtX9fXRin87sHQjh+58aY3asgBvHK+g3V_A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Dec 06, 2020 at 05:56:30PM +0900, Yun Levi wrote:
> > This, and the change above this, are not related to this patch so you
> > might not want to include them.
> 
> > Also, why is this patch series even needed?  I don't see a justification
> > for it anywhere, only "what" this patch is, not "why".
> 
> I think the find_last_zero_bit will help to improve in
> 7th patch's change and It can be used in the future.
> But if my thinking is bad.. Please let me know..

You need to explain that in a 0/8 patch.  But note that this seems like
a lot of work just for one tiny user, what is the real benifit here?

thanks,

greg k-h
