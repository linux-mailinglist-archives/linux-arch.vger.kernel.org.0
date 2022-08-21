Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E09859B4AA
	for <lists+linux-arch@lfdr.de>; Sun, 21 Aug 2022 16:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiHUO5G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 21 Aug 2022 10:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiHUO5G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 21 Aug 2022 10:57:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE306222AB;
        Sun, 21 Aug 2022 07:57:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F3E360EEA;
        Sun, 21 Aug 2022 14:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C06FC43141;
        Sun, 21 Aug 2022 14:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661093824;
        bh=r1o2z8hDVx+DkQVhNEo4UP5pCNnqLvLh2RdwYu9Y3FI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=img3vVKpcn75aMsadrwMj0PbEHi9Nj5a3/cS0SSGQNR1z+gxHDU/Tiv1zGgzLH8mj
         93RtoZNZhgrhOeVNxVURRkUYd8AAbWWqtXbuQQcTZh+VDuOVZ5BSpyOu6CyYWb/HBw
         edUt13y6gCKaLWGVG6b/8cgobbISBdQMtLjg++Tc2h9QEZGOog+WV3unC+WwSihijZ
         XQnM6BYeXYHB7SOS/hIm+9DZwNdfAx1MRqoAP0Ml4jdM5hFsyIIHiH8K4RVb6ZPGgp
         s2mvAZyt1PmI21DTpFK86UD+cexf2aR0E3GAstPTHCd6mv1fTCfcUeO+fA1dB92dAD
         rf/06AvbvaM/Q==
Received: by mail-vs1-f51.google.com with SMTP id q67so84220vsa.1;
        Sun, 21 Aug 2022 07:57:04 -0700 (PDT)
X-Gm-Message-State: ACgBeo1tAtC2qwuyHEHUE/AJKBRFKl9ADIZXmVft67F2BnYxk8vlHwgb
        /a02k9YTZGX6j2s9IgmY32q36apxAcgxx4t9Bqs=
X-Google-Smtp-Source: AA6agR6uik2WYsHTIHPI6VOd70EN0gYfjVxQa+9I5vht736nLZJn3U/f+UTmPxQbzVPgvtzIUExkEB6v8pqhltBG3vQ=
X-Received: by 2002:a67:df81:0:b0:390:21a3:823a with SMTP id
 x1-20020a67df81000000b0039021a3823amr3929876vsk.70.1661093823533; Sun, 21 Aug
 2022 07:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <YwF8vibZ2/Xz7a/g@ZenIV> <20220821010239.1554132-1-viro@zeniv.linux.org.uk>
In-Reply-To: <20220821010239.1554132-1-viro@zeniv.linux.org.uk>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 21 Aug 2022 22:56:50 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4AcEOqeZ45Pb+8FN3G9k1wXKYhdgV8Uk=yqXSPAHrQvA@mail.gmail.com>
Message-ID: <CAAhV-H4AcEOqeZ45Pb+8FN3G9k1wXKYhdgV8Uk=yqXSPAHrQvA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] loongarch: remove generic-y += termios.h
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Acked-by: chenhuacai <chenhuacai@kernel.org>

On Sun, Aug 21, 2022 at 9:02 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> not really needed - UAPI mandatory-y += termios.h is sufficient...
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  arch/loongarch/include/asm/Kbuild | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/loongarch/include/asm/Kbuild b/arch/loongarch/include/asm/Kbuild
> index 83bc0681e72b..f2bcfcb4e311 100644
> --- a/arch/loongarch/include/asm/Kbuild
> +++ b/arch/loongarch/include/asm/Kbuild
> @@ -21,7 +21,6 @@ generic-y += shmbuf.h
>  generic-y += statfs.h
>  generic-y += socket.h
>  generic-y += sockios.h
> -generic-y += termios.h
>  generic-y += termbits.h
>  generic-y += poll.h
>  generic-y += param.h
> --
> 2.30.2
>
