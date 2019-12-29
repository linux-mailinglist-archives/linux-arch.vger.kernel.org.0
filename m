Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9EF312BFDF
	for <lists+linux-arch@lfdr.de>; Sun, 29 Dec 2019 02:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfL2Bbk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 28 Dec 2019 20:31:40 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:39492 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726187AbfL2Bbk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sat, 28 Dec 2019 20:31:40 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0C43E8EE0DA;
        Sat, 28 Dec 2019 17:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1577583100;
        bh=zbW9WWjeZOxIUrHi9cV0hkGSGh9fn/LBCcZFRjsx/Eo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BPxXS8BVm4iNWQthxVc54Px8MbXMUronXvfS+qIJe9n7MU5v6jgY+bdi41eGNLQ/I
         lOJtGbs5/oXzj3btPfzdfpW7qDQB83/FItyOLigClUosLNTSsfYa6F/fGB8/yvc7Ch
         lBTMYOgbiLGgmuV9ue9DuP36FyixXfYtS7klfO8g=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8mcakcWKeBlo; Sat, 28 Dec 2019 17:31:39 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4249A8EE007;
        Sat, 28 Dec 2019 17:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1577583099;
        bh=zbW9WWjeZOxIUrHi9cV0hkGSGh9fn/LBCcZFRjsx/Eo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=f/jP5S5bhWkg9HidRZ3o4rOA2Ptr0sXFqzGTvye0iM2M0CpR0w1yZ2isI5SAdiQXI
         fErms7c40y+32/icy7WsoWUZfnPpmK42uolC3zC4PBmPFXd30n6QNlHKo5sPxux3hc
         bjvQ6QilqR3HEoc4V1OiR6u2MH5KrbAjJZqoglug=
Message-ID: <1577583097.5661.6.camel@HansenPartnership.com>
Subject: Re: [PATCH] mm/hugetlb: ensure signedness of large numbers
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     isidentical <batuhanosmantaskaya@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 28 Dec 2019 17:31:37 -0800
In-Reply-To: <20191228103357.23904-1-batuhanosmantaskaya@gmail.com>
References: <20191228103357.23904-1-batuhanosmantaskaya@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 2019-12-28 at 13:33 +0300, isidentical wrote:
> This change introduces a sanitity helper for
> numbers that are larger than 2^5.

What's the rationale for this ... i.e. what problem are you trying to
solve?  left to its own devices, gcc will assume int size for all
literals, so 34<<26 doesn't appear to have a problem, except that it
will be sign extended as a negative number into a 64 bit variable. 
However, it's designed use is for an int flags in mmap, so its current
definition seems to be fine.

> Signed-off-by: isidentical <batuhanosmantaskaya@gmail.com>
> ---
>  include/uapi/asm-generic/hugetlb_encode.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/asm-generic/hugetlb_encode.h
> b/include/uapi/asm-generic/hugetlb_encode.h
> index b0f8e87235bd..42c06c62ae17 100644
> --- a/include/uapi/asm-generic/hugetlb_encode.h
> +++ b/include/uapi/asm-generic/hugetlb_encode.h
> @@ -31,6 +31,6 @@
>  #define HUGETLB_FLAG_ENCODE_512MB	(29 <<
> HUGETLB_FLAG_ENCODE_SHIFT)
>  #define HUGETLB_FLAG_ENCODE_1GB		(30 <<
> HUGETLB_FLAG_ENCODE_SHIFT)
>  #define HUGETLB_FLAG_ENCODE_2GB		(31 <<
> HUGETLB_FLAG_ENCODE_SHIFT)
> -#define HUGETLB_FLAG_ENCODE_16GB	(34 <<
> HUGETLB_FLAG_ENCODE_SHIFT)
> +#define HUGETLB_FLAG_ENCODE_16GB	(UINT32_C(34) <<
> HUGETLB_FLAG_ENCODE_SHIFT)

And if there is a literal problem here, it can't be solved like this:
UINT32_C is a Cism which has no analogue in the kernel because we don't
pull in the /usr/include headers where it is defined.  Usually in the
kernel we solve this by making the literal type explicit, like 34U, but
as I said above, I don't see a problem that this would solve.

James

