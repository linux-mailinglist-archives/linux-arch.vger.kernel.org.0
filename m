Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A113D3A57
	for <lists+linux-arch@lfdr.de>; Fri, 23 Jul 2021 14:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbhGWLz7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Jul 2021 07:55:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234774AbhGWLz7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Jul 2021 07:55:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 001EC60E8C
        for <linux-arch@vger.kernel.org>; Fri, 23 Jul 2021 12:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627043793;
        bh=kbqkjgZx0i2FNjnLd6NpL865j7k342XTF3ZhEzzvM1I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mJDf1QIhCz+3Yc8Tph2qv8iddezTqScB88SEMBzWOzcyIJMCp+D9MSfOYK/RmF0ID
         7yXAaTzjIX4C11GoM3IffCnuxjvj1C3M7clCDlZEsP2M7ZSmVOM3qNsxdQs9vJlO6R
         uANaDgTGpktsbZ5OYX/gAqiZkjoDAneSRuqjvmv0XR2uRgJr+plmCR2NkbsHl7GwCF
         6YywCVE8My3gbj9YKPwrpDJ916iQGCetj5M3/+uBFLCKnq0UDrt6DSXhLFexbczDBJ
         RPt4p+7LbWMMKilq5sCvzVmKNGzA2IK7JhSBJmWrDFuA1aTUk9rdOzM9FeDBFMTuMi
         rBaG15DItO9JQ==
Received: by mail-wr1-f52.google.com with SMTP id t17so2238296wrq.2
        for <linux-arch@vger.kernel.org>; Fri, 23 Jul 2021 05:36:32 -0700 (PDT)
X-Gm-Message-State: AOAM532li0AjI31iPFHG/V/AeSdJS8D644VSmN/CIZYGAFosyRSmJA0t
        K49mT9AAsBkWGxbWnAROW+iIsRG4wARFAVGfH/Y=
X-Google-Smtp-Source: ABdhPJyS3rDvYit1p6RxOd1UAJoAFsisDeTbOIdhA8V643oGeu3wjE5idj91qtvL4RXUfv+/CdiF0RPvL3k+vf5Op1Y=
X-Received: by 2002:a5d:65cb:: with SMTP id e11mr5304315wrw.105.1627043791659;
 Fri, 23 Jul 2021 05:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210722124814.778059-7-arnd@kernel.org> <202107230453.Cz16fInO-lkp@intel.com>
In-Reply-To: <202107230453.Cz16fInO-lkp@intel.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 23 Jul 2021 14:36:15 +0200
X-Gmail-Original-Message-ID: <CAK8P3a22AEb+Sn6ZXPnMt4WykwjizNv3O6fXOtMjD4egA257VA@mail.gmail.com>
Message-ID: <CAK8P3a22AEb+Sn6ZXPnMt4WykwjizNv3O6fXOtMjD4egA257VA@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] microblaze: use generic strncpy/strnlen from_user
To:     kernel test robot <lkp@intel.com>, Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>
Cc:     kbuild-all@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 22, 2021 at 10:48 PM kernel test robot <lkp@intel.com> wrote:
>
> All errors (new ones prefixed by >>):
>
>    lib/strncpy_from_user.c: In function 'strncpy_from_user':
> >> lib/strncpy_from_user.c:123:13: error: implicit declaration of function 'user_addr_max' [-Werror=implicit-function-declaration]
>      123 |  max_addr = user_addr_max();
>          |             ^~~~~~~~~~~~~
>    cc1: some warnings being treated as errors

> --
> >> lib/strnlen_user.c:92:6: error: conflicting types for 'strnlen_user'
>       92 | long strnlen_user(const char __user *str, long count)
>          |      ^~~~~~~~~~~~
>    In file included from include/linux/uaccess.h:11,
>                     from lib/strnlen_user.c:4:
>    arch/microblaze/include/asm/uaccess.h:306:13: note: previous declaration of 'strnlen_user' was here
>      306 | extern long strnlen_user(const char __user *sstr, int len);

Fixed both now, thanks for the report.

I had to add a user_addr_max() definition here, which unfortunately
will also conflict
with the get_fs() removal if Christoph plans to have that merged
through the microblaze
tree.

If this becomes a problem, I could merge both series through the
asm-generic tree.

     Arnd
