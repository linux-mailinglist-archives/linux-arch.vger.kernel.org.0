Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32AC229423
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jul 2020 10:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGVI4p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jul 2020 04:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgGVI4p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 04:56:45 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F249CC0619DC;
        Wed, 22 Jul 2020 01:56:44 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k71so833337pje.0;
        Wed, 22 Jul 2020 01:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lJz8m7biG5oe9MPJBUclD03AWiGFPOB3TE3jVUSihK4=;
        b=FWVBt/pEyg3rQFkBIh2Z91kxppaBJi2TnjHsYl4WZThpFb9kSwlgCm4wOY7S0YTQQ1
         Q9hx1We3PHX90zWKFF1670ARvdZ1FttPkjiKQnIADFPtHmNG44TCsxR4hL7cJsSkHJ4a
         hoU3QiG86i2SGq/KyTVZznO0Wy8Q7wphKYfk/Osv69WgnmECueTcJmWrlRbbP66SDXsA
         8ZNQ6yJOx8RtiGx23va/ayFTzXfq6OH9ebivBm32v2BhwpnP+PEFK8u/L3Xn+xyoo1rX
         FKNVKKdtQO29ILwnF6ZINIHQXXBrSO7lGo5MMAC/ct7D3t7NaTasyBe/DFg00w2jmyQo
         NG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lJz8m7biG5oe9MPJBUclD03AWiGFPOB3TE3jVUSihK4=;
        b=OAYvv0zRqPnxNYD2XKnNw+YluTu0XBRh3OTve+vNGgLzQGVbN18fxsuUPTO+2emFi8
         Kk5U4Y5r8zTh3o4uAfvRxXEt7+Qv3t7yOt/wDwfJ7XpbY38Lp+oj3xRF+J+g21jSYcwC
         VGZfzzcXf+BydAHPP+C4JOhAJYXdRukVuZPfCBuTFUacq6yBCL0pXvKauUkN2UXLYk8l
         VUcBGwqhe6KmdobuZdnliW2f1SIb8gmlHuidPT6qM2oKHdOvpJ4zPh2zALX3f9wcBWqm
         s+uAmg5yxF5QC6eYBWODQPJuCAvBsKjm+0f8UaNQ1ycaTj7ARnwY9eFxqaV94uYU6Ony
         2fpA==
X-Gm-Message-State: AOAM532VvufZ5mjWqtAdyesG8THXN8oz5UMcD4KgGmlg3rVs+Pjqli/S
        XoRPnspN0c4s8l7gKpv2De8uy2YN4eAeZC+w0vkQbH5V
X-Google-Smtp-Source: ABdhPJz9EpilhKy972agAbkamJ9cQSzsfFGEJYOYGsykuFoEYrA6+lnteU87/19PwRI832bR9uN//9SVikUsnOkfpVM=
X-Received: by 2002:a17:90b:3748:: with SMTP id ne8mr8255833pjb.7.1595408204594;
 Wed, 22 Jul 2020 01:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200721202425.GA2786714@ZenIV.linux.org.uk> <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
 <20200721202549.4150745-15-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200721202549.4150745-15-viro@ZenIV.linux.org.uk>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 22 Jul 2020 01:56:33 -0700
Message-ID: <CAMo8BfJ7atdFKqkc7nTy5NGXpfAHLGSh95pmVsrZCOGFufw=Kg@mail.gmail.com>
Subject: Re: [PATCH 15/18] xtensa: propagate the calling conventions change
 down into csum_partial_copy_generic()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 21, 2020 at 1:27 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> From: Al Viro <viro@zeniv.linux.org.uk>
>
> turn the exception handlers into returning 0.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  arch/xtensa/include/asm/checksum.h | 20 +++---------
>  arch/xtensa/lib/checksum.S         | 67 +++++++++-----------------------------
>  2 files changed, 19 insertions(+), 68 deletions(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Tested-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
